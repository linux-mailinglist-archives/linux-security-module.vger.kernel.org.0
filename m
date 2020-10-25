Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD52982E3
	for <lists+linux-security-module@lfdr.de>; Sun, 25 Oct 2020 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417812AbgJYRrU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 25 Oct 2020 13:47:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:51073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1417807AbgJYRrS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Oct 2020 13:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603648010;
        bh=46tXLmeDZxoZnd9ahI0FOEafCPrksfhcOGGheXfG4Fw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c+Zd4Om1zzKBFjABTliqLmRqPj3WdxTb3CFuN7H9d0IbjW35o0JRcVlhOdbLs0ah9
         YwmS8vN2zEfdsqoW+/BtBN7SPMRB+N3z6sZKpF7ZbVSpIKTgvWhQ8v67hFiGJBg1Ia
         MsOzUsfXMZTM5VHL04oV7RZLQrqNb90mb7ktKkgs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.231.59]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MZkpb-1krwAH1Mfv-00Wjuw; Sun, 25 Oct 2020 18:46:50 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 6/8] security/brute: Add prctls to enable/disable the fork attack detection
Date:   Sun, 25 Oct 2020 14:45:38 +0100
Message-Id: <20201025134540.3770-7-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025134540.3770-1-john.wood@gmx.com>
References: <20201025134540.3770-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y8g9unw+ZDo8pqpejS21tJx/xOIOj5BtZUmKSvK51UzvxtkRlyz
 M51rNcVIJMjG5KMuMCQ/GlRzamPn6rXzGJXIb0TfgDRGOw/1a8bKGkmO6vU/qTtmu6orNyi
 vDzRVK+t2A5xqsBKAtAn1HBgGrU0uEBTJYMSzlWrQeySLPr+PqexeXwWZ718Kaz7j+9mlMH
 EUUVbNJPWp5PIeeFu1eQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y3MmYaVH5K8=:2AqjJSdIUPwhC76kMXt0Kl
 oREs/VdbnYEA5cEbe2g+9SagWZF0hlFZXmAfdBX3kUiwYgKLbkJ766hP/50LJzZjxwGIGVlll
 1jTzYfURwRcTqGfxIR4hJG4iGdPwdV4Oym1loHEEf3NisqcV/YablzEoRy+7/1d2egl4W0GLl
 fY2YGcM/RfoBvC0xCWI4AUpeJAXvFvfUBYXDSXgb8ivyCBS35JG8t455hvlrqcjWh7QwHl09/
 X2QloSo7la2SxX/eZIR4CMvmQkBulZGoBN6aFNYP6sRJ59czVuaUknx/9y+F4JWUcNjSyzxuP
 YypthcKsyVCtcTI9P2IoqjpSf2b1RSKJuqgYblB+C04Mz5fMN20tgrWPxJGH3PPhgz5DoZAfc
 bZ2A6fYxNNua6PyaJCkFHTLU5WTIEA7GlTFouV5tHYs0wGiQ0ZstUTzjxVMSMqtsoRqb0moxY
 OphjVmtcx2HzedEoSJ/CsOXZksiwHdK0PwdJfioVrMcAN4XxDYhNBgr0LvIOiJc2PGBNltV49
 4w8chzkKFHwi9uqlW4UydP22gtdxkLhKsm/msKdW3870U2JkOgZ/YfCE8OjS9CAfMX0udC39K
 IrqkAHPcVPu2L38Leq3IIZBIzvOvYFP5sBsuLThZjaQgAdmQRbjDN8N9qeKgeQyJeOroAnXYN
 uQQphWlBnMC7KywJEzLSMY7od5N8mKp7VM8WwPSu0tgMQtBHO/tgYwAcLadLxk+O6InP3LYC6
 ZDuP+TXHu4RvgS9790U3l7B4cxjAM49P/8PRiaOQdj4YaOJ2F6P/n/IUFVJCQQ+ovf4OArJtt
 KK4JmtdUev4PKNngrT6JaZVCT+DoGQYEn0712PZNRgbSk+Yy4BpM8+smIfr4L5okkQO5bYGdL
 Hb8iCgOU2eFFMZm+2QAg==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

To allow that a process can turn off or turn on the detection and
mitigation of a fork brute force attack when required, add two new
defines to the prctl interface.

All the arguments passed to the prctl system call are ignored for the
two new cases.

To enable the attack detection make the last crashes timestamps list not
empty. To disable the detection use the already created brute_disable()
function.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 include/brute/brute.h      | 16 +++++++++
 include/uapi/linux/prctl.h |  4 +++
 kernel/sys.c               |  8 +++++
 security/brute/brute.c     | 71 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 include/brute/brute.h

diff --git a/include/brute/brute.h b/include/brute/brute.h
new file mode 100644
index 000000000000..da6fca04f16b
=2D-- /dev/null
+++ b/include/brute/brute.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BRUTE_H_
+#define _BRUTE_H_
+
+#include <linux/errno.h>
+
+#ifdef CONFIG_SECURITY_FORK_BRUTE
+int brute_prctl_enable(void);
+int brute_prctl_disable(void);
+#else
+static inline int brute_prctl_enable(void) { return -EINVAL; }
+static inline int brute_prctl_disable(void) { return -EINVAL; }
+#endif
+
+#endif /* _BRUTE_H_ */
+
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..01f5033210d0 100644
=2D-- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,8 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58

+/* Enable/disable the detection and mitigation of a fork brute force atta=
ck */
+#define PR_SECURITY_FORK_BRUTE_ENABLE	59
+#define PR_SECURITY_FORK_BRUTE_DISABLE	60
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index ab6c409b1159..35dae4e2f59a 100644
=2D-- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -72,6 +72,8 @@
 #include <asm/io.h>
 #include <asm/unistd.h>

+#include <brute/brute.h>
+
 #include "uid16.h"

 #ifndef SET_UNALIGN_CTL
@@ -2530,6 +2532,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, =
arg2, unsigned long, arg3,

 		error =3D (current->flags & PR_IO_FLUSHER) =3D=3D PR_IO_FLUSHER;
 		break;
+	case PR_SECURITY_FORK_BRUTE_ENABLE:
+		error =3D brute_prctl_enable();
+		break;
+	case PR_SECURITY_FORK_BRUTE_DISABLE:
+		error =3D brute_prctl_disable();
+		break;
 	default:
 		error =3D -EINVAL;
 		break;
diff --git a/security/brute/brute.c b/security/brute/brute.c
index a1bdf25ffcf9..6f85e137553c 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -676,3 +676,74 @@ DEFINE_LSM(brute) =3D {
 	.blobs =3D &brute_blob_sizes,
 };

+/**
+ * brute_prctl_enable() - Enable the fork brute force attack detection.
+ *
+ * To enable the fork brute force attack detection the last crashes times=
tamps
+ * list must not be empty. So, if this list already contains entries noth=
ing
+ * needs to be done. Otherwise, initialize the last crashes timestamps li=
st with
+ * one entry set to now. This way, the application crash period can be co=
mputed
+ * at the next fault.
+ *
+ * It's mandatory to disable interrupts before acquiring the lock since t=
he
+ * task_free hook can be called from an IRQ context during the execution =
of the
+ * prctl syscall.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. -EN=
OMEM if
+ *         the allocation of the new timestamp structure fails. Zero othe=
rwise.
+ */
+int brute_prctl_enable(void)
+{
+	struct brute_stats **stats;
+	struct brute_timestamp *timestamp;
+	unsigned long flags;
+
+	stats =3D brute_stats_ptr(current);
+	if (!*stats)
+		return -EFAULT;
+
+	timestamp =3D brute_new_timestamp();
+	if (!timestamp)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&(*stats)->lock, flags);
+
+	if (!list_empty(&(*stats)->timestamps)) {
+		kfree(timestamp);
+		goto unlock;
+	}
+
+	list_add_tail(&timestamp->node, &(*stats)->timestamps);
+	(*stats)->timestamps_size =3D 1;
+
+unlock:
+	spin_unlock_irqrestore(&(*stats)->lock, flags);
+	return 0;
+}
+
+/**
+ * brute_prctl_disable() - Disable the fork brute force attack detection.
+ *
+ * It's mandatory to disable interrupts before acquiring the lock since t=
he
+ * task_free hook can be called from an IRQ context during the execution =
of the
+ * prctl syscall.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zer=
o
+ *         otherwise.
+ */
+int brute_prctl_disable(void)
+{
+	struct brute_stats **stats;
+	unsigned long flags;
+
+	stats =3D brute_stats_ptr(current);
+	if (!*stats)
+		return -EFAULT;
+
+	spin_lock_irqsave(&(*stats)->lock, flags);
+	brute_disable(*stats);
+	spin_unlock_irqrestore(&(*stats)->lock, flags);
+
+	return 0;
+}
+
=2D-
2.25.1

