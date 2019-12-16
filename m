Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC28F121E12
	for <lists+linux-security-module@lfdr.de>; Mon, 16 Dec 2019 23:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLPWd4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 16 Dec 2019 17:33:56 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:42761
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfLPWd4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Dec 2019 17:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535633; bh=1geWvs7GfSFx9csTS2THo8vohI1Xi608jxOz2eEL/1Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=R1LWH5tvglhJLUGArwNjQr4inkmovRkGxnFkqc/jcu7gIVEE9hUs8HVlgNtH1cPOSGfyUmOLnlk8R2HKpWQWTJV5AHtbxui/k40h93hkyEpZCl9Bzs1+ynMRZWS0KVZqOLw3OHmNnV8YxjgVvaJHGN0WdB8btIr4yzSlaM2UAikL4aT1jRPSjbdIGz7nJIklCtTPxNEWV2b/BiNI617mDCG5H1aZIQr7ElqUzrjZtKsN5oc+oXodNMuh2PJf0Oi5eACHMqU+JVPp4dFVLEV1Q1JlQxZxTD42WyhehWLl1U4+tts1hoAupKVMlo5kgEQFTY9D0T7CG8LS03BDBc4KFQ==
X-YMail-OSG: 8XwkDCUVM1nNgNgHgdJDLpufT5cA4VSZqQ4KjRdXVchJ9ktrLpjmXgC83apAZD5
 uySAUrjhdZ7yWJECVosjl7aUuQRiCPLoq5jNqIleFn.KUedzwERjgiK3ZwrgIh5XM3FK1iM_OkSO
 cH0IIfKPihIUHTj58LcbqgxpOm7ZzGMGa9w6hsSwy4I22irrfSuEA05MI9TxQ6PSCcvRWZDUfcym
 HJD0FE9AOvHNxdZ9ycBw2dL_dluosnaZKQ4A85VzVNBxqjES3QFzalyfkiH1BxiAmXWvZyGiWW08
 wv.rzmJVJMAXBlrEFEA7YW6YagN2w32C0VKspafkfU5tah_RF1kalz_sd5oYAqYsK50OckGiSssM
 nv_Qur1izmJcijolzTbEc4kCgZT40X.oMpc_3kZSrhw83uUmH6ifK2OZlrnNCwwOprqmN9IPSU1f
 IQyboAZe9hILQ0nGLGP3hcNeKx6nAd2tYbRFJhVod1oTZt6N7Z6sb74uAOsju8ytmdxoDw9po_u4
 xgEbyTsd1loZ1Yl8LLEineVaLmhDqdvIzdz6LDz07Mx3tx6flDLcX4rcf3FYGwrYwoq5qrBuOQ56
 GX6v8aBp4Lno.4WzCgbhIUtXUNUeeJ0j.o1Tmxm7jEdx.lNWb1.4MMDobLeeI6RFb2j1zgppp8Im
 ezAoQ4MnhUPeZ4ooFQdSN5fxwicyCe9fbpaK2KT2zkOI6r94bCT0iiWi4wj0xvz_6rBRTa3SpqpS
 GsvWgNb.Yisb5gkuqRjewY97t7DhtGpII0CilZCPF4P7QbP1Vk_CtzUl3__vLKNOmUux297i3ONk
 s.7ZFNF6zn_I94SEo1vhIw.NUamK6etJBJPwW1Twzk2nPn9w8BVdBN9FvWFfUzBWnICoBGpyHBhj
 .YemkQLkPhtDBU5StZJut6l4LC8YPAELXCP67CYl9TxbUeKoFRlBfVVN8rN_gUpUuZ7cqalP8e.d
 byXZ7Ahxf84kxIHA8nOQ6ioDs98CntLwI9apw1IkIm8md.wxuGTTM_.ZnXDAgzVhc1ZPW02WNYCT
 Crr.tWDiL7C6QjQlkcUrEOj9AjJMJA.cLXBOrxnU0eF.a2CZJTdhVUxl.L4YmEqmIPiiTSa3vZ8T
 6WswUx5L6qJWtx5Euqi_ARfBY.Pjn9r62niSoR_JyUR8hgS8J5wZJ73ihNQJZaX6LwCfYdpI1Zx5
 XUgknX_VrL17CsDtYXaL8aas480vuaO3zpXE6gz8p9SI5Vbult9_hkLfpfznKqIwULB0wC14S6Ed
 K1bTF2zI6KCx.l5GpFfjXjnHofMg_vYePcWsefWU58UwsYPYdnaa6p5HzBG0VU9JEWvoHWDOuF2l
 GxFBpbV3YtbUF.njvbmLrmRUbJKWTRNmAVyMrSk10AHaq9dVrcINw6KVGtEfnNv9iSg3ncc9KDdv
 gCuq7zhOZADo3thaq24hF7RNTcpaevHfoAWiy9PZnmFYgojXJspwmwyU8Tle87A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:33:53 +0000
Received: by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID df0d9b9ca902229e8a3f24aecb3674a2;
          Mon, 16 Dec 2019 22:33:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon, 16 Dec 2019 14:33:23 -0800
Message-Id: <20191216223345.5066-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223345.5066-1-casey@schaufler-ca.com>
References: <20191216223345.5066-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. In some cases this requires a
temporary conversion using lsmblob_init() that will go
away when other interfaces get converted.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  7 +++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 18 +++++++++++++++---
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b74dc70088ca..9c6dbe248eaf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1837,7 +1837,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1853,8 +1854,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index b0126e9c0743..356db1dd276c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+							&blob, f->type,
+							f->op, f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..7566e5b1c419 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df4ca482fb53..d95b0ece7434 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -381,8 +381,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f19a895ad7cd..193ddd55420b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
 			continue;
@@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&blob, secid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index a89634af639a..bfea9739c084 100644
--- a/security/security.c
+++ b/security/security.c
@@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op, lsmrule);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.20.1

