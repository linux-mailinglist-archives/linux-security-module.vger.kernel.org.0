Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD422F26C
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Jul 2020 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgG0OJU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Jul 2020 10:09:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53206 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgG0OJU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:20 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6C9F20B4909;
        Mon, 27 Jul 2020 07:09:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6C9F20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595858958;
        bh=gQfNPjbMtiLw79tGj9bRmOj5FZFZE/TY/VjUKPcR7xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvtvY1fxBnHUPZsItNgIsxWH0mzf/2BASXXWLWY5jNXE1tX77MlmoEaiNS8Jg9dFt
         VkARKG+GVvUElRV9k2+fbxy2q3wLw8GTd8YALP4IqaHqSydRktTqNvCojcjGQ+Bz/4
         WcrlzumesAnv2wfirwvr2wXf5L6EyhsiZgTlduPU=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] ima: Pre-parse the list of keyrings in a KEY_CHECK rule
Date:   Mon, 27 Jul 2020 09:08:30 -0500
Message-Id: <20200727140831.64251-2-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
References: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The ima_keyrings buffer was used as a work buffer for strsep()-based
parsing of the "keyrings=" option of an IMA policy rule. This parsing
was re-performed each time an asymmetric key was added to a kernel
keyring for each loaded policy rule that contained a "keyrings=" option.

An example rule specifying this option is:

 measure func=KEY_CHECK keyrings=a|b|c

The rule says to measure asymmetric keys added to any of the kernel
keyrings named "a", "b", or "c". The size of the buffer size was
equal to the size of the largest "keyrings=" value seen in a previously
loaded rule (5 + 1 for the NUL-terminator in the previous example) and
the buffer was pre-allocated at the time of policy load.

The pre-allocated buffer approach suffered from a couple bugs:

1) There was no locking around the use of the buffer so concurrent key
   add operations, to two different keyrings, would result in the
   strsep() loop of ima_match_keyring() to modify the buffer at the same
   time. This resulted in unexpected results from ima_match_keyring()
   and, therefore, could cause unintended keys to be measured or keys to
   not be measured when IMA policy intended for them to be measured.

2) If the kstrdup() that initialized entry->keyrings in ima_parse_rule()
   failed, the ima_keyrings buffer was freed and set to NULL even when a
   valid KEY_CHECK rule was previously loaded. The next KEY_CHECK event
   would trigger a call to strcpy() with a NULL destination pointer and
   crash the kernel.

Remove the need for a pre-allocated global buffer by parsing the list of
keyrings in a KEY_CHECK rule at the time of policy load. The
ima_rule_entry will contain an array of string pointers which point to
the name of each keyring specified in the rule. No string processing
needs to happen at the time of asymmetric key add so iterating through
the list and doing a string comparison is all that's required at the
time of policy check.

In the process of changing how the "keyrings=" policy option is handled,
a couple additional bugs were fixed:

1) The rule parser accepted rules containing invalid "keyrings=" values
   such as "a|b||c", "a|b|", or simply "|".

2) The /sys/kernel/security/ima/policy file did not display the entire
   "keyrings=" value if the list of keyrings was longer than what could
   fit in the fixed size tbuf buffer in ima_policy_show().

Fixes: 5c7bac9fb2c5 ("IMA: pre-allocate buffer to hold keyrings string")
Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 138 +++++++++++++++++++---------
 1 file changed, 93 insertions(+), 45 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 07f033634b27..c328cfa0fc49 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -59,6 +59,11 @@ enum policy_types { ORIGINAL_TCB = 1, DEFAULT_TCB };
 
 enum policy_rule_list { IMA_DEFAULT_POLICY = 1, IMA_CUSTOM_POLICY };
 
+struct ima_rule_opt_list {
+	size_t count;
+	char *items[];
+};
+
 struct ima_rule_entry {
 	struct list_head list;
 	int action;
@@ -78,7 +83,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
-	char *keyrings; /* Measure keys added to these keyrings */
+	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_template_desc *template;
 };
 
@@ -206,10 +211,6 @@ static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
 static struct list_head *ima_rules = &ima_default_rules;
 
-/* Pre-allocated buffer used for matching keyrings. */
-static char *ima_keyrings;
-static size_t ima_keyrings_len;
-
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -253,6 +254,72 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
+{
+	struct ima_rule_opt_list *opt_list;
+	size_t count = 0;
+	char *src_copy;
+	char *cur, *next;
+	size_t i;
+
+	src_copy = match_strdup(src);
+	if (!src_copy)
+		return NULL;
+
+	next = src_copy;
+	while ((cur = strsep(&next, "|"))) {
+		/* Don't accept an empty list item */
+		if (!(*cur)) {
+			kfree(src_copy);
+			return ERR_PTR(-EINVAL);
+		}
+		count++;
+	}
+
+	/* Don't accept an empty list */
+	if (!count) {
+		kfree(src_copy);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opt_list = kzalloc(struct_size(opt_list, items, count), GFP_KERNEL);
+	if (!opt_list) {
+		kfree(src_copy);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * strsep() has already replaced all instances of '|' with '\0',
+	 * leaving a byte sequence of NUL-terminated strings. Reference each
+	 * string with the array of items.
+	 *
+	 * IMPORTANT: Ownership of the allocated buffer is transferred from
+	 * src_copy to the first element in the items array. To free the
+	 * buffer, kfree() must only be called on the first element of the
+	 * array.
+	 */
+	for (i = 0, cur = src_copy; i < count; i++) {
+		opt_list->items[i] = cur;
+		cur = strchr(cur, '\0') + 1;
+	}
+	opt_list->count = count;
+
+	return opt_list;
+}
+
+static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
+{
+	if (!opt_list)
+		return;
+
+	if (opt_list->count) {
+		kfree(opt_list->items[0]);
+		opt_list->count = 0;
+	}
+
+	kfree(opt_list);
+}
+
 static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 {
 	int i;
@@ -274,7 +341,7 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	 * the defined_templates list and cannot be freed here
 	 */
 	kfree(entry->fsname);
-	kfree(entry->keyrings);
+	ima_free_rule_opt_list(entry->keyrings);
 	ima_lsm_free_rule(entry);
 	kfree(entry);
 }
@@ -394,8 +461,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 static bool ima_match_keyring(struct ima_rule_entry *rule,
 			      const char *keyring, const struct cred *cred)
 {
-	char *next_keyring, *keyrings_ptr;
 	bool matched = false;
+	size_t i;
 
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
 		return false;
@@ -406,15 +473,8 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
 	if (!keyring)
 		return false;
 
-	strcpy(ima_keyrings, rule->keyrings);
-
-	/*
-	 * "keyrings=" is specified in the policy in the format below:
-	 * keyrings=.builtin_trusted_keys|.ima|.evm
-	 */
-	keyrings_ptr = ima_keyrings;
-	while ((next_keyring = strsep(&keyrings_ptr, "|")) != NULL) {
-		if (!strcmp(next_keyring, keyring)) {
+	for (i = 0; i < rule->keyrings->count; i++) {
+		if (!strcmp(rule->keyrings->items[i], keyring)) {
 			matched = true;
 			break;
 		}
@@ -1065,7 +1125,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	struct ima_template_desc *template_desc;
 	int result = 0;
-	size_t keyrings_len;
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
 				       AUDIT_INTEGRITY_POLICY_RULE);
@@ -1231,37 +1290,18 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);
 
-			keyrings_len = strlen(args[0].from) + 1;
-
-			if ((entry->keyrings) ||
-			    (keyrings_len < 2)) {
+			if (entry->keyrings) {
 				result = -EINVAL;
 				break;
 			}
 
-			if (keyrings_len > ima_keyrings_len) {
-				char *tmpbuf;
-
-				tmpbuf = krealloc(ima_keyrings, keyrings_len,
-						  GFP_KERNEL);
-				if (!tmpbuf) {
-					result = -ENOMEM;
-					break;
-				}
-
-				ima_keyrings = tmpbuf;
-				ima_keyrings_len = keyrings_len;
-			}
-
-			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
-			if (!entry->keyrings) {
-				kfree(ima_keyrings);
-				ima_keyrings = NULL;
-				ima_keyrings_len = 0;
-				result = -ENOMEM;
+			entry->keyrings = ima_alloc_rule_opt_list(args);
+			if (IS_ERR(entry->keyrings)) {
+				result = PTR_ERR(entry->keyrings);
+				entry->keyrings = NULL;
 				break;
 			}
-			result = 0;
+
 			entry->flags |= IMA_KEYRINGS;
 			break;
 		case Opt_fsuuid:
@@ -1574,6 +1614,15 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 		seq_printf(m, "func=%d ", func);
 }
 
+static void ima_show_rule_opt_list(struct seq_file *m,
+				   const struct ima_rule_opt_list *opt_list)
+{
+	size_t i;
+
+	for (i = 0; i < opt_list->count; i++)
+		seq_printf(m, "%s%s", i ? "|" : "", opt_list->items[i]);
+}
+
 int ima_policy_show(struct seq_file *m, void *v)
 {
 	struct ima_rule_entry *entry = v;
@@ -1630,9 +1679,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_KEYRINGS) {
-		if (entry->keyrings != NULL)
-			snprintf(tbuf, sizeof(tbuf), "%s", entry->keyrings);
-		seq_printf(m, pt(Opt_keyrings), tbuf);
+		seq_puts(m, "keyrings=");
+		ima_show_rule_opt_list(m, entry->keyrings);
 		seq_puts(m, " ");
 	}
 
-- 
2.25.1

