Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC324E4C0
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Aug 2020 05:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHVDFr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Aug 2020 23:05:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbgHVDFr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Aug 2020 23:05:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A9F3D65E5144998DEE4F;
        Sat, 22 Aug 2020 11:05:44 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 22 Aug 2020 11:05:36 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <serge@hallyn.com>, <jmorris@namei.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <casey@schaufler-ca.com>,
        <takedakn@nttdata.co.jp>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
CC:     <wangle6@huawei.com>, <nixiaoming@huawei.com>
Subject: [PATCH] security: fix some spelling mistakes in the comments by codespell
Date:   Sat, 22 Aug 2020 11:05:34 +0800
Message-ID: <20200822030534.2577-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ecurity/commoncap.c: capabilties ==> capabilities
security/lsm_audit.c: programers ==> programmers
security/tomoyo/audit.c: stuct ==> struct
security/tomoyo/common.c: Poiter ==> Pointer
security/smack/smack_lsm.c: overriden ==> overridden overridden
security/smack/smackfs.c: overriden ==> overridden
security/integrity/ima/ima_template_lib.c: algoritm ==> algorithm

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 security/commoncap.c                      | 2 +-
 security/integrity/ima/ima_template_lib.c | 2 +-
 security/lsm_audit.c                      | 2 +-
 security/smack/smack_lsm.c                | 2 +-
 security/smack/smackfs.c                  | 2 +-
 security/tomoyo/audit.c                   | 2 +-
 security/tomoyo/common.c                  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 59bf3c1674c8..2c3a0f1b6876 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1046,7 +1046,7 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 		break;
 
 	case LSM_SETID_FS:
-		/* juggle the capabilties to follow FSUID changes, unless
+		/* juggle the capabilities to follow FSUID changes, unless
 		 * otherwise suppressed
 		 *
 		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c022ee9e2a4e..9513564ee0b2 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -231,7 +231,7 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 	 * digest formats:
 	 *  - DATA_FMT_DIGEST: digest
 	 *  - DATA_FMT_DIGEST_WITH_ALGO: [<hash algo>] + ':' + '\0' + digest,
-	 *    where <hash algo> is provided if the hash algoritm is not
+	 *    where <hash algo> is provided if the hash algorithm is not
 	 *    SHA1 or MD5
 	 */
 	u8 buffer[CRYPTO_MAX_ALG_NAME + 2 + IMA_MAX_DIGEST_SIZE] = { 0 };
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 53d0d183db8f..a0ff2e441069 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -212,7 +212,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	char comm[sizeof(current->comm)];
 
 	/*
-	 * To keep stack sizes in check force programers to notice if they
+	 * To keep stack sizes in check force programmers to notice if they
 	 * start making this union too large!  See struct lsm_network_audit
 	 * as an example of how to deal with large data.
 	 */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c0893eb5aa8..960d4641239c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1784,7 +1784,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	 */
 	file = container_of(fown, struct file, f_owner);
 
-	/* we don't log here as rc can be overriden */
+	/* we don't log here as rc can be overridden */
 	blob = smack_file(file);
 	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 9c4308077574..5c581ec814ac 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -111,7 +111,7 @@ struct smack_known *smack_syslog_label;
 /*
  * Ptrace current rule
  * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
- * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
+ * SMACK_PTRACE_EXACT      labels must match, but can be overridden with
  *			   CAP_SYS_PTRACE
  * SMACK_PTRACE_DRACONIAN  lables must match, CAP_SYS_PTRACE has no effect
  */
diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index 3c96e8402e94..b51bad121c11 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -311,7 +311,7 @@ static LIST_HEAD(tomoyo_log);
 /* Lock for "struct list_head tomoyo_log". */
 static DEFINE_SPINLOCK(tomoyo_log_lock);
 
-/* Length of "stuct list_head tomoyo_log". */
+/* Length of "struct list_head tomoyo_log". */
 static unsigned int tomoyo_log_count;
 
 /**
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 4bee32bfe16d..38bdc0ffc312 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2608,7 +2608,7 @@ ssize_t tomoyo_read_control(struct tomoyo_io_buffer *head, char __user *buffer,
 /**
  * tomoyo_parse_policy - Parse a policy line.
  *
- * @head: Poiter to "struct tomoyo_io_buffer".
+ * @head: Pointer to "struct tomoyo_io_buffer".
  * @line: Line to parse.
  *
  * Returns 0 on success, negative value otherwise.
-- 
2.27.0

