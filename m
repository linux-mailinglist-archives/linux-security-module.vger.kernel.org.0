Return-Path: <linux-security-module+bounces-8771-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB026A62450
	for <lists+linux-security-module@lfdr.de>; Sat, 15 Mar 2025 02:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DC3421A43
	for <lists+linux-security-module@lfdr.de>; Sat, 15 Mar 2025 01:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C6EC0;
	Sat, 15 Mar 2025 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="EY0xiIxP"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016A1804A
	for <linux-security-module@vger.kernel.org>; Sat, 15 Mar 2025 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742003874; cv=none; b=A1ZHPdpbgueMHe15Mz4X2D+5NL3z2m17K24dOh4TixjJumFndE9VweqRGKJMM3yrlgI5DzzMGO8C/NPvVgiv3xQSdlP21nnTDXlqL74AwA2RVpIMSsDyDnL1wHVZvcPpnBCmhVhOcug2cT9FdxNKxUMGmqHndWS7QEqXUvTGGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742003874; c=relaxed/simple;
	bh=aUNYi/QuiD5LLD9S4RF0r8lZambvn+NVKYLjhEppixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGawuiqPdv0eLDlt2M8UtWdW+Ae6kJ3b521Pu+1Lezx5bpu1tTvzlQQSF33IET46mULCE82xk+cQks1ooX3JvVQxGDcq7qT29xt5FziHhs3a+X2qk07JzQgW9t80dIf9sM5enFt8H6fJEB38bcBgEkdVx81XsDVviy0YAHQOqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=EY0xiIxP; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742003859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXFRYq9isvUoqQYteol/ELohkuRSXfMMY7Ew53LpBlQ=;
	b=EY0xiIxPght/ai4xjfK2qP5txOSFiH48FW5xgwFg0RB90S1jFPAYxWILBCUAFrOOWnRfGS
	3R0seUS9J/5Xi6RBrJNxHV2DwEXjnXRnqkgYZ7viiAPFASOxL/yX0KVoLmR3x/BVkHuas9
	CtRa0S2YfYVgAe361qX98bviBG7R9IQ=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] smack: fix bug: setting task label silently ignores input garbage
Date: Sat, 15 Mar 2025 04:57:14 +0300
Message-ID: <20250315015723.1357541-3-andreev@swemel.ru>
In-Reply-To: <20250315015723.1357541-1-andreev@swemel.ru>
References: <20250315015723.1357541-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This command:
    # echo foo/bar >/proc/$$/attr/smack/current

gives the task a label 'foo' w/o indication
that label does not match input.
Setting the label with lsm_set_self_attr() syscall
behaves identically.

This occures because:

1) smk_parse_smack() is used to convert input to a label
2) smk_parse_smack() takes only that part from the
   beginning of the input that looks like a label.
3) `/' is prohibited in labels, so only "foo" is taken.

(2) is by design, because smk_parse_smack() is used
for parsing strings which are more than just a label.

Silent failure is not a good thing, and there are two
indicators that this was not done intentionally:

    (size >= SMK_LONGLABEL) ~> invalid

clause at the beginning of the do_setattr() and the
"Returns the length of the smack label" claim
in the do_setattr() description.

So I fixed this by adding one tiny check:
the taken label length == input length.

Since input length is now strictly controlled,
I changed the two ways of setting label

   smack_setselfattr(): lsm_set_self_attr() syscall
   smack_setprocattr(): > /proc/.../current

to accommodate the divergence in
what they understand by "input length":

  smack_setselfattr counts mandatory \0 into input length,
  smack_setprocattr does not.

  smack_setprocattr allows various trailers after label

Related changes:

* fixed description for smk_parse_smack

* allow unprivileged tasks validate label syntax.

* extract smk_parse_label_len() from smk_parse_smack()
  so parsing may be done w/o string allocation.

* extract smk_import_valid_label() from smk_import_entry()
  to avoid repeated parsing.

* smk_parse_smack(): scan null-terminated strings
  for no more than SMK_LONGLABEL(256) characters

* smack_setselfattr(): require struct lsm_ctx . flags == 0
  to reserve them for future.

Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
v2: 1) accept two more trailers after label
       in /proc/PID/attr/smack/current input: \0 and \n\0
    2) added documentation

 Documentation/admin-guide/LSM/Smack.rst |  11 ++-
 security/smack/smack.h                  |   3 +
 security/smack/smack_access.c           |  93 ++++++++++++++-----
 security/smack/smack_lsm.c              | 117 +++++++++++++++---------
 4 files changed, 157 insertions(+), 67 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Smack.rst b/Documentation/admin-guide/LSM/Smack.rst
index 6d44f4fdbf59..2b89b5dfddea 100644
--- a/Documentation/admin-guide/LSM/Smack.rst
+++ b/Documentation/admin-guide/LSM/Smack.rst
@@ -601,10 +601,15 @@ specification.
 Task Attribute
 ~~~~~~~~~~~~~~
 
-The Smack label of a process can be read from /proc/<pid>/attr/current. A
-process can read its own Smack label from /proc/self/attr/current. A
+The Smack label of a process can be read from ``/proc/<pid>/attr/current``. A
+process can read its own Smack label from ``/proc/self/attr/current``. A
 privileged process can change its own Smack label by writing to
-/proc/self/attr/current but not the label of another process.
+``/proc/self/attr/current`` but not the label of another process.
+
+Format of writing is : only the label or the label followed by one of the
+3 trailers: ``\n`` (by common agreement for ``/proc/...`` interfaces),
+``\0`` (because some applications incorrectly include it),
+``\n\0`` (because we think some applications may incorrectly include it).
 
 File Attribute
 ~~~~~~~~~~~~~~
diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..759343a6bbae 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -286,9 +286,12 @@ int smk_tskacc(struct task_smack *, struct smack_known *,
 int smk_curacc(struct smack_known *, u32, struct smk_audit_info *);
 int smack_str_from_perm(char *string, int access);
 struct smack_known *smack_from_secid(const u32);
+int smk_parse_label_len(const char *string, int len);
 char *smk_parse_smack(const char *string, int len);
 int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
 struct smack_known *smk_import_entry(const char *, int);
+struct smack_known *smk_import_valid_label(const char *label, int label_len,
+					   gfp_t gfp);
 void smk_insert_entry(struct smack_known *skp);
 struct smack_known *smk_find_entry(const char *);
 bool smack_privileged(int cap);
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 2e4a0cb22782..a289cb6672bd 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -443,19 +443,19 @@ struct smack_known *smk_find_entry(const char *string)
 }
 
 /**
- * smk_parse_smack - parse smack label from a text string
- * @string: a text string that might contain a Smack label
- * @len: the maximum size, or zero if it is NULL terminated.
+ * smk_parse_label_len - calculate the length of the starting segment
+ *                       in the string that constitutes a valid smack label
+ * @string: a text string that might contain a Smack label at the beginning
+ * @len: the maximum size to look into, may be zero if string is null-terminated
  *
- * Returns a pointer to the clean label or an error code.
+ * Returns the length of the segment (0 < L < SMK_LONGLABEL) or an error code.
  */
-char *smk_parse_smack(const char *string, int len)
+int smk_parse_label_len(const char *string, int len)
 {
-	char *smack;
 	int i;
 
-	if (len <= 0)
-		len = strlen(string) + 1;
+	if (len <= 0 || len > SMK_LONGLABEL)
+		len = SMK_LONGLABEL;
 
 	/*
 	 * Reserve a leading '-' as an indicator that
@@ -463,7 +463,7 @@ char *smk_parse_smack(const char *string, int len)
 	 * including /smack/cipso and /smack/cipso2
 	 */
 	if (string[0] == '-')
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	for (i = 0; i < len; i++)
 		if (string[i] > '~' || string[i] <= ' ' || string[i] == '/' ||
@@ -471,6 +471,25 @@ char *smk_parse_smack(const char *string, int len)
 			break;
 
 	if (i == 0 || i >= SMK_LONGLABEL)
+		return -EINVAL;
+
+	return i;
+}
+
+/**
+ * smk_parse_smack - copy the starting segment in the string
+ *                   that constitutes a valid smack label
+ * @string: a text string that might contain a Smack label at the beginning
+ * @len: the maximum size to look into, may be zero if string is null-terminated
+ *
+ * Returns a pointer to the copy of the label or an error code.
+ */
+char *smk_parse_smack(const char *string, int len)
+{
+	char *smack;
+	int i = smk_parse_label_len(string, len);
+
+	if (i < 0)
 		return ERR_PTR(-EINVAL);
 
 	smack = kstrndup(string, i, GFP_NOFS);
@@ -554,31 +573,25 @@ int smack_populate_secattr(struct smack_known *skp)
 }
 
 /**
- * smk_import_entry - import a label, return the list entry
- * @string: a text string that might be a Smack label
- * @len: the maximum size, or zero if it is NULL terminated.
+ * smk_import_valid_allocated_label - import a label, return the list entry
+ * @smack: a text string that is a valid Smack label and may be kfree()ed.
+ *         It is consumed: either becomes a part of the entry or kfree'ed.
  *
- * Returns a pointer to the entry in the label list that
- * matches the passed string, adding it if necessary,
- * or an error code.
+ * Returns: see description of smk_import_entry()
  */
-struct smack_known *smk_import_entry(const char *string, int len)
+static struct smack_known *
+smk_import_allocated_label(char *smack, gfp_t gfp)
 {
 	struct smack_known *skp;
-	char *smack;
 	int rc;
 
-	smack = smk_parse_smack(string, len);
-	if (IS_ERR(smack))
-		return ERR_CAST(smack);
-
 	mutex_lock(&smack_known_lock);
 
 	skp = smk_find_entry(smack);
 	if (skp != NULL)
 		goto freeout;
 
-	skp = kzalloc(sizeof(*skp), GFP_NOFS);
+	skp = kzalloc(sizeof(*skp), gfp);
 	if (skp == NULL) {
 		skp = ERR_PTR(-ENOMEM);
 		goto freeout;
@@ -608,6 +621,42 @@ struct smack_known *smk_import_entry(const char *string, int len)
 	return skp;
 }
 
+/**
+ * smk_import_entry - import a label, return the list entry
+ * @string: a text string that might contain a Smack label at the beginning
+ * @len: the maximum size to look into, may be zero if string is null-terminated
+ *
+ * Returns a pointer to the entry in the label list that
+ * matches the passed string, adding it if necessary,
+ * or an error code.
+ */
+struct smack_known *smk_import_entry(const char *string, int len)
+{
+	char *smack = smk_parse_smack(string, len);
+
+	if (IS_ERR(smack))
+		return ERR_CAST(smack);
+
+	return smk_import_allocated_label(smack, GFP_NOFS);
+}
+
+/**
+ * smk_import_valid_label - import a label, return the list entry
+ * @label a text string that is a valid Smack label, not null-terminated
+ *
+ * Returns: see description of smk_import_entry()
+ */
+struct smack_known *
+smk_import_valid_label(const char *label, int label_len, gfp_t gfp)
+{
+	char *smack = kstrndup(label, label_len, gfp);
+
+	if  (!smack)
+		return ERR_PTR(-ENOMEM);
+
+	return smk_import_allocated_label(smack, gfp);
+}
+
 /**
  * smack_from_secid - find the Smack label associated with a secid
  * @secid: an integer that might be associated with a Smack label
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 80d68d2c228c..4a463da8f37e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3664,7 +3664,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  * @attr: which attribute to fetch
  * @ctx: buffer to receive the result
  * @size: available size in, actual size out
- * @flags: unused
+ * @flags: reserved, currently zero
  *
  * Fill the passed user space @ctx with the details of the requested
  * attribute.
@@ -3725,57 +3725,52 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  * Sets the Smack value of the task. Only setting self
  * is permitted and only with privilege
  *
- * Returns the length of the smack label or an error code
+ * Returns zero on success or an error code
  */
-static int do_setattr(u64 attr, void *value, size_t size)
+static int do_setattr(unsigned int attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
-	char *labelstr;
-	int rc = 0;
-
-	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
-		return -EPERM;
+	int label_len;
 
+	/*
+	 * let unprivileged user validate input, check permissions later
+	 */
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (attr != LSM_ATTR_CURRENT)
-		return -EOPNOTSUPP;
-
-	labelstr = smk_parse_smack(value, size);
-	if (IS_ERR(labelstr))
-		return PTR_ERR(labelstr);
+	label_len = smk_parse_label_len(value, size);
+	if (label_len < 0 || label_len != size)
+		return -EINVAL;
 
 	/*
 	 * No process is ever allowed the web ("@") label
 	 * and the star ("*") label.
 	 */
-	if (labelstr[1] == '\0' /* '@', '*' */) {
-		const char c = labelstr[0];
+	if (label_len == 1 /* '@', '*' */) {
+		const char c = *(const char *)value;
 
 		if (c == *smack_known_web.smk_known ||
-		    c == *smack_known_star.smk_known) {
-			rc = -EPERM;
-			goto free_labelstr;
-		}
+		    c == *smack_known_star.smk_known)
+			return -EPERM;
 	}
 
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
 		const struct smack_known_list_elem *sklep;
-		list_for_each_entry(sklep, &tsp->smk_relabel, list)
-			if (strcmp(sklep->smk_label->smk_known, labelstr) == 0)
-				goto free_labelstr;
-		rc = -EPERM;
+		list_for_each_entry(sklep, &tsp->smk_relabel, list) {
+			const char *cp = sklep->smk_label->smk_known;
+
+			if (strlen(cp) == label_len &&
+			    strncmp(cp, value, label_len) == 0)
+				goto in_relabel;
+		}
+		return -EPERM;
+in_relabel:
+		;
 	}
 
-free_labelstr:
-	kfree(labelstr);
-	if (rc)
-		return -EPERM;
-
-	skp = smk_import_entry(value, size);
+	skp = smk_import_valid_label(value, label_len, GFP_KERNEL);
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
 
@@ -3791,7 +3786,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
 	smk_destroy_label_list(&tsp->smk_relabel);
 
 	commit_creds(new);
-	return size;
+	return 0;
 }
 
 /**
@@ -3799,7 +3794,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
  * @attr: which attribute to set
  * @ctx: buffer containing the data
  * @size: size of @ctx
- * @flags: unused
+ * @flags: reserved, must be zero
  *
  * Fill the passed user space @ctx with the details of the requested
  * attribute.
@@ -3809,12 +3804,26 @@ static int do_setattr(u64 attr, void *value, size_t size)
 static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
 			     u32 size, u32 flags)
 {
-	int rc;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
-	rc = do_setattr(attr, ctx->ctx, ctx->ctx_len);
-	if (rc > 0)
-		return 0;
-	return rc;
+	if (ctx->flags)
+		return -EINVAL;
+	/*
+	 * string must have \0 terminator, included in ctx->ctx
+	 * (see description of struct lsm_ctx)
+	 */
+	if (ctx->ctx_len == 0)
+		return -EINVAL;
+
+	if (ctx->ctx[ctx->ctx_len - 1] != '\0')
+		return -EINVAL;
+	/*
+	 * other do_setattr() caller, smack_setprocattr(),
+	 * does not count \0 into size, so
+	 * decreasing length by 1 to accommodate the divergence.
+	 */
+	return do_setattr(attr, ctx->ctx, ctx->ctx_len - 1);
 }
 
 /**
@@ -3826,15 +3835,39 @@ static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
  * Sets the Smack value of the task. Only setting self
  * is permitted and only with privilege
  *
- * Returns the length of the smack label or an error code
+ * Returns the size of the input value or an error code
  */
 static int smack_setprocattr(const char *name, void *value, size_t size)
 {
-	int attr = lsm_name_to_attr(name);
+	size_t realsize = size;
+	unsigned int attr = lsm_name_to_attr(name);
 
-	if (attr != LSM_ATTR_UNDEF)
-		return do_setattr(attr, value, size);
-	return -EINVAL;
+	switch (attr) {
+	case LSM_ATTR_UNDEF:   return -EINVAL;
+	default:               return -EOPNOTSUPP;
+	case LSM_ATTR_CURRENT:
+		;
+	}
+
+	/*
+	 * The value for the "current" attribute is the label
+	 * followed by one of the 4 trailers: none, \0, \n, \n\0
+	 *
+	 * I.e. following inputs are accepted as 3-characters long label "foo":
+	 *
+	 *   "foo"     (3 characters)
+	 *   "foo\0"   (4 characters)
+	 *   "foo\n"   (4 characters)
+	 *   "foo\n\0" (5 characters)
+	 */
+
+	if (realsize && (((const char *)value)[realsize - 1] == '\0'))
+		--realsize;
+
+	if (realsize && (((const char *)value)[realsize - 1] == '\n'))
+		--realsize;
+
+	return do_setattr(attr, value, realsize) ? : size;
 }
 
 /**
-- 
2.43.0


