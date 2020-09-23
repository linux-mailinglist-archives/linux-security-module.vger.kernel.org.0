Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C12760EC
	for <lists+linux-security-module@lfdr.de>; Wed, 23 Sep 2020 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIWTU2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 23 Sep 2020 15:20:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47356 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgIWTUW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Sep 2020 15:20:22 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4447C2089E54;
        Wed, 23 Sep 2020 12:20:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4447C2089E54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600888819;
        bh=SOTaZce6/RdN7od+EbMFXj1LgFxOXmnEyQ3AaS1qrxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfBgp9640BotbUFbtAcr2pea/uKjcZ5sSvft2z+zVclFD7THE82dXzLTQT/uS7knV
         kU4peJ4JktGLrDNKYL1DYcvsTzhj9fQ2NfykT6tOWtDhFiN0DL7gF59qC51ZQIXBYK
         QA/c+wgcDlv28dTp02FpRb6UZA6Yogj0ungUonAE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v4 1/6] IMA: generalize keyring specific measurement constructs
Date:   Wed, 23 Sep 2020 12:20:06 -0700
Message-Id: <20200923192011.5293-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

IMA functions such as ima_match_keyring(), process_buffer_measurement(),
ima_match_policy() etc. handle data specific to keyrings. Currently,
these constructs are not generic to handle any func specific data.
This makes it harder to extend without code duplication.

Refactor the keyring specific measurement constructs to be generic and
reusable in other measurement scenarios.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h        |  6 ++---
 security/integrity/ima/ima_api.c    |  6 ++---
 security/integrity/ima/ima_main.c   |  6 ++---
 security/integrity/ima/ima_policy.c | 38 ++++++++++++++++-------------
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 38043074ce5e..8875085db689 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -255,7 +255,7 @@ static inline void ima_process_queued_keys(void) {}
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *keyring);
+		   const char *func_data);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -267,7 +267,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring);
+				int pcr, const char *func_data);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
@@ -283,7 +283,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *keyring);
+		     const char *func_data);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..af218babd198 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -170,7 +170,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
- * @keyring: keyring name used to determine the action
+ * @func_data: private data specific to @func, can be NULL.
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -186,14 +186,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *keyring)
+		   const char *func_data)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc, keyring);
+				template_desc, func_data);
 }
 
 /*
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..c870fd6d2f83 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -732,13 +732,13 @@ int ima_load_data(enum kernel_load_data_id id)
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
- * @keyring: keyring name to determine the action to be performed
+ * @func_data: private data specific to @func, can be NULL.
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring)
+				int pcr, const char *func_data)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -770,7 +770,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, keyring);
+					&pcr, &template, func_data);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fe1df373c113..31a772d8a86b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -451,15 +451,19 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 }
 
 /**
- * ima_match_keyring - determine whether the keyring matches the measure rule
- * @rule: a pointer to a rule
- * @keyring: name of the keyring to match against the measure rule
+ * ima_match_rule_data - determine whether the given func_data matches
+ *			 the measure rule data
+ * @rule: IMA policy rule
+ * @opt_list: rule data to match func_data against
+ * @func_data: data to match against the measure rule data
  * @cred: a pointer to a credentials structure for user validation
  *
- * Returns true if keyring matches one in the rule, false otherwise.
+ * Returns true if func_data matches one in the rule, false otherwise.
  */
-static bool ima_match_keyring(struct ima_rule_entry *rule,
-			      const char *keyring, const struct cred *cred)
+static bool ima_match_rule_data(struct ima_rule_entry *rule,
+				const struct ima_rule_opt_list *opt_list,
+				const char *func_data,
+				const struct cred *cred)
 {
 	bool matched = false;
 	size_t i;
@@ -467,14 +471,14 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
 		return false;
 
-	if (!rule->keyrings)
+	if (!opt_list)
 		return true;
 
-	if (!keyring)
+	if (!func_data)
 		return false;
 
-	for (i = 0; i < rule->keyrings->count; i++) {
-		if (!strcmp(rule->keyrings->items[i], keyring)) {
+	for (i = 0; i < opt_list->count; i++) {
+		if (!strcmp(opt_list->items[i], func_data)) {
 			matched = true;
 			break;
 		}
@@ -491,20 +495,21 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @secid: the secid of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
- * @keyring: keyring name to check in policy for KEY_CHECK func
+ * @func_data: private data specific to @func, can be NULL.
  *
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const struct cred *cred, u32 secid,
 			    enum ima_hooks func, int mask,
-			    const char *keyring)
+			    const char *func_data)
 {
 	int i;
 
 	if (func == KEY_CHECK) {
 		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-		       ima_match_keyring(rule, keyring, cred);
+		       ima_match_rule_data(rule, rule->keyrings, func_data,
+					   cred);
 	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -608,8 +613,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
- * @keyring: the keyring name, if given, to be used to check in the policy.
- *           keyring can be NULL if func is anything other than KEY_CHECK.
+ * @func_data: private data specific to @func, can be NULL.
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -621,7 +625,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *keyring)
+		     const char *func_data)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -636,7 +640,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 			continue;
 
 		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
-				     keyring))
+				     func_data))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.17.1

