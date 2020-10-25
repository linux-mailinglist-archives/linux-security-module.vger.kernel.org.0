Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA9298214
	for <lists+linux-security-module@lfdr.de>; Sun, 25 Oct 2020 15:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416622AbgJYO1D (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 25 Oct 2020 10:27:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:57621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416619AbgJYO1B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Oct 2020 10:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603635995;
        bh=dC1GAYDBvewqH+15RkWtGKNy0TPLCQGsQjJzFQDQAnw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dyEwEY+vBxu55T65yXEq7Ce8bmYNMvoz5AMtdy2OtJ9UG1KeHIQuvKPhiOogXje+F
         I6UwzEWWwf4+k+E7uOmOdTtkg6FQsA3szGKBaOuvtuVfYqocprDRsI9xW01z5PH52M
         wv0V/kAR8Oh5AJtVe+QK4Gj01oqmrvli2sQn5sLs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.231.59]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Ma24y-1kriRS3bKW-00Vuve; Sun, 25 Oct 2020 15:26:35 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 1/8] security: Add LSM hook at the point where a task gets a fatal signal
Date:   Sun, 25 Oct 2020 14:45:33 +0100
Message-Id: <20201025134540.3770-2-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025134540.3770-1-john.wood@gmx.com>
References: <20201025134540.3770-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkupQ1akacLnRJqP1KdBhhAbud+zuJqEkwRwuwT3qFhfPIzQho8
 LJgT+hubrBqL9itzdwXipymtIx1zhmqM88Ik/XTX/YgeHMgPLgZ1Ppss7Vmx3E0i8ymxPXR
 zU62AwkMKBMLVoYz8w9Zm0Ev+k/K4S3a4CnuuPFdCuNCipgeS6KUwvKegJGfuoPwAOhuCNY
 Mr6p26zrS6KljN0UxitBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bjOM493H6M=:o4xZVjH+p0ZO7TJHbqj/N1
 jTDqJbR7M/l4QXpt9Y4b7IpYlwAv9QwPDLnePDKBkXdGLyDIFLyJl6mvPv36EMWiwi8jEfOp8
 vzZ/wGJ4gaxeoZiFNFuq6UH5ex6+wTatp5HF7N6TJ8+Ji13nYBO0lj4rTpOyFeS3uDtRYULDl
 dVi+kDo2VlUTajWYn3ok6MToz7/qcC5cjSwSerYZP1e9R/eMm7NiuEt0K55YtgpP5gfB/C6Pk
 e1u7Qvt0FFykuKlkL4k883ehav6T7TLQ39d4nU6xBi7JY2jfjSq4Xixy8e82d5hDGP+XiOuNP
 mntGQgEtCItOsU/PFpcBOiFWcoFSGY8E5hMr8rDXPTIkMLN0B/jN8xrLp1rjCsYzWKtTZ8ehE
 fz/oZX1sW5J4RYLIbRzOFCL8XXfqUHSR1mP/k/BN88g/PBUEm/Rg9Axq17EePwOwBx95kVtHR
 QryxYAdv6q71gu8Ad3pD6+fTbt2fTkWAJF11EPuU43vbxXdKvM13LmYkpmB+DrASMIw6XQbpS
 H3h/967FdPMCtjgfE+PUij73O6VEfZN4lHu17BxNgV1L065Q8+PbchiJ/P7ccsv25GEJtqu/E
 0bwKfz/IoitNb3p/Lr3y055y4ydsKPFvvc9io2NMNRrCZUY70NxWyzSJAy6c2B5neS3kgqHI8
 gQn+LpQ2XyYrWfZcv+Xg8SDkBVhsvq3uh0u8m3oSBY/tOzZcpy1FFzhsz6CLYn53eSdSZpnvv
 ct4UgextoikBaHPETK7KE0U//2PL5mBxkKCZgwfMxilC7bstf8E926/wGzl5Pvd2B7Vw6KlBK
 lX/PsEiPgmH1eFNyYKCwjWVfFjJWp3J2ZwLehRGS6ewz49c2ICyjPPkJ7xmKi8DD5RbYnOrTI
 gYndmheGlz9Fz6ZGQhww==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a security hook that allows a LSM to be notified when a task gets a
fatal signal. This patch is a previous step on the way to compute the
task crash period by the "brute" LSM (linux security module to detect
and mitigate fork brute force attack against vulnerable userspace
processes).

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 4 ++++
 kernel/signal.c               | 1 +
 security/security.c           | 5 +++++
 5 files changed, 15 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2a8c74d99015..8ecbb6849555 100644
=2D-- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -213,6 +213,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigne=
d long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, task_fatal_signal, const kernel_siginfo_t *s=
iginfo)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
 	 u32 *secid)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9e2e3e63719d..0a8b0fab0212 100644
=2D-- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -761,6 +761,10 @@
  *	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @task_fatal_signal:
+ *	This hook allows security modules to be notified when a task gets a
+ *	fatal signal.
+ *	@siginfo contains the signal information.
  *
  * Security hooks for Netlink messaging.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index 0a0a03b36a3b..4bc000bb8685 100644
=2D-- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -413,6 +413,7 @@ int security_task_kill(struct task_struct *p, struct k=
ernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg=
3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+void security_task_fatal_signal(const kernel_siginfo_t *siginfo);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1127,6 +1128,9 @@ static inline int security_task_prctl(int option, un=
signed long arg2,
 static inline void security_task_to_inode(struct task_struct *p, struct i=
node *inode)
 { }

+static inline void security_task_fatal_signal(const kernel_siginfo_t *sig=
info)
+{ }
+
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 					  short flag)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index a38b3edc6851..a0866d6b2c06 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2734,6 +2734,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Anything else is fatal, maybe with a core dump.
 		 */
+		security_task_fatal_signal(&ksig->info);
 		current->flags |=3D PF_SIGNALED;

 		if (sig_kernel_coredump(signr)) {
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..e8c7978b515c 100644
=2D-- a/security/security.c
+++ b/security/security.c
@@ -1810,6 +1810,11 @@ void security_task_to_inode(struct task_struct *p, =
struct inode *inode)
 	call_void_hook(task_to_inode, p, inode);
 }

+void security_task_fatal_signal(const kernel_siginfo_t *siginfo)
+{
+	call_void_hook(task_fatal_signal, siginfo);
+}
+
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
=2D-
2.25.1

