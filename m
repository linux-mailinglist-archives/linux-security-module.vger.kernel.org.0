Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349C2298263
	for <lists+linux-security-module@lfdr.de>; Sun, 25 Oct 2020 16:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417055AbgJYPrC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 25 Oct 2020 11:47:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:57375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1417049AbgJYPrB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Oct 2020 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603640800;
        bh=FL6P9PlcVXad6H4MtVd1cnzcCv3Sr7IXdhqycJIBKF0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cA3lU6XdbcZa8MvTNKxLW5CQS/ifFwerYN+SHSpe0GFT4CbiyspGTFYNW9oP3vZ8P
         pTvgn5dYxj3a5LmyQdMdnM1FIOwSxxRlu2+tMv9AVoLLbRPGSw4GMg0kO67aj5jer/
         jqUxkhrCHM3GJtRcN6CYePCAk+PMjz5/TVf8+3JM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.231.59]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M9FnZ-1kRT1k3r1T-006PTS; Sun, 25 Oct 2020 16:46:40 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 3/8] security/brute: Add sysctl attributes to allow detection fine tuning
Date:   Sun, 25 Oct 2020 14:45:35 +0100
Message-Id: <20201025134540.3770-4-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025134540.3770-1-john.wood@gmx.com>
References: <20201025134540.3770-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pofVpQawf3cGIOvUmDx1sWEL7cIqeQhbsAoJcoXuQe4Kmy96jmh
 QQgyBhhHJ1dcWAV19f31YFCvjT+ZDiMTFk6KC/FyoDKTKb1TVpbe9YmYKf+vuWiRjw2EJKz
 Lt+2qG/0k3LKn/qYawV5ON0lt3kbPTrzXSxp8NZOGnjerTVfFeCoJ0xx0cPQR0dBRQPwARp
 2EyO1lU2t2fow+l2KKxWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fD2ezhdR8F4=:pnRSOwo+YDnupRmdVquV14
 FI/Seu4PTrzkrG9v8P14awXBqqhv2GPSKRRNaUZpnKsqzCXqqZ40BDRYTsv4/CLZI1vAL81YC
 hTGvnbxYxL8JIfMjZJMkRzHlWP6Y2eTR4/uddYXePSglt2bwaoQcyh5S4rL8djtonosmD9iMU
 lLO3MvFWqOgAq9en5TjR+1oBaU3cAW0FU4rYGydB0QONwm93vE6Kz/2vn3BoAfqi1iIuHygmA
 muzA50Hxu3N1OOkQZtdwB423BwGaFJxdeOetjT4kBOLj9+I/5AmqB05Dte/uuA7EYkv3k46oz
 H6KhVBFRjAevye6SjlVXmggbvSzFqDMh2NpD/IXe+Ciw+lhq8zrHTYWqEA27cxVmm+sKdz9SF
 BMhh36UCDi2vndTYDAuEa/ANLeDKoS2J++5AZPELSpO3mFJHy1oHU93y/eU/SdstUkaVFzRbA
 h6UG+WGYWYNHWuxZqAo8j1ASnKgLdjOR3KQmVho6Rr0bDpbs7G3U4Xa9saFNJ5+me09gmSnu8
 JS07TYteXtJtsWTjaV2DmOOS5CWjSsDN/PLwNoU2mAPmNcvA7XUC3tBaxEh/1+c0wUSje/t2I
 1dV33FSSVyit/21xCbGi4xdBV/93Z6dZi80kgU5Shc2zAAhKmbIcOF0yGZw4Q6EaPLdNmPlAH
 JobMvvbp8Tnx2HAFxrE3rPQP+hqMBK/vG1VDMlIk3FOhblDYFy5tzSwYZ9cLXSQFm5KMznbUo
 SGzjjEtkFqEMPW/J7tQXXMrBVsVdk+hsZheFrSfARqt5As8ggyLER6jnO7mJoW8umSTz5m+ly
 BFST+YJSAykDMGpN2Z2kURl2d+fIKX0jz1z7j1aJSzWwfiMkKIQDLE92h/+mTUvWYKbgS7kHC
 R97vGMdtKJzy55FV+7sQ==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a previous step to add the detection feature.

A fork brute force attack will be detected when an application crashes
quickly. Since, the application crash period is the time between the
execve system call and the first fault or the time between two
consecutives faults add a new sysctl attribute to control the crash
period threshold.

But a detection method based only on this computation has a drawback. If
an application crashes once quickly from the execve system call or
crashes twice in a short period of time for some reason, a false
positive attack will be triggered. To avoid this scenario use a list of
the i last crashes timestamps and compute the application crash period
as follows:

crash_period =3D (n_last_timestamp - n_minus_i_timestamp) / i;

So, also add a new sysctl attribute to control the size of this list.

This way, each system can tune the detection's sensibility adjusting the
application crash period threshold and the size of the last crashes
timestamps list.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/brute/brute.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/security/brute/brute.c b/security/brute/brute.c
index 307d07bf9d98..29835fe2f141 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -4,12 +4,14 @@

 #include <asm/current.h>
 #include <linux/bug.h>
+#include <linux/cache.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lsm_hooks.h>
 #include <linux/printk.h>
@@ -17,6 +19,34 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sysctl.h>
+
+/**
+ * brute_timestamps_list_size - Last crashes timestamps list size.
+ *
+ * The application crash period is the time between the execve system cal=
l and
+ * the first fault or the time between two consecutives faults, but this =
has a
+ * drawback. If an application crashes once quickly from the execve syste=
m call
+ * or crashes twice in a short period of time for some reason, a false po=
sitive
+ * attack will be triggered. To avoid this scenario use a list of the i l=
ast
+ * crashes timestamps and compute the application crash period as follows=
:
+ *
+ * crash_period =3D (n_last_timestamp - n_minus_i_timestamp) / i;
+ *
+ * The brute_timestamps_list_size variable sets the size of this list.
+ */
+static unsigned int brute_timestamps_list_size __read_mostly =3D 5;
+
+/**
+ * brute_crash_period_threshold - Application crash period threshold.
+ *
+ * The units are expressed in milliseconds.
+ *
+ * A fork brute force attack will be detected if the application crash pe=
riod
+ * falls under this threshold. So, the higher this value, the more sensit=
ive the
+ * detection will be.
+ */
+static unsigned int brute_crash_period_threshold __read_mostly =3D 30000;

 /**
  * struct brute_stats - Fork brute force attack statistics.
@@ -318,6 +348,58 @@ static struct security_hook_list brute_hooks[] __lsm_=
ro_after_init =3D {
 	LSM_HOOK_INIT(task_free, brute_task_free),
 };

+#ifdef CONFIG_SYSCTL
+static unsigned int uint_one =3D 1;
+static unsigned int uint_max =3D UINT_MAX;
+static unsigned int max_brute_timestamps_list_size =3D 10;
+
+/**
+ * brute_sysctl_path - Sysctl attributes path.
+ */
+static struct ctl_path brute_sysctl_path[] =3D {
+	{ .procname =3D "kernel", },
+	{ .procname =3D "brute", },
+	{ }
+};
+
+/**
+ * brute_sysctl_table - Sysctl attributes.
+ */
+static struct ctl_table brute_sysctl_table[] =3D {
+	{
+		.procname	=3D "timestamps_list_size",
+		.data		=3D &brute_timestamps_list_size,
+		.maxlen		=3D sizeof(brute_timestamps_list_size),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D &uint_one,
+		.extra2		=3D &max_brute_timestamps_list_size,
+	},
+	{
+		.procname	=3D "crash_period_threshold",
+		.data		=3D &brute_crash_period_threshold,
+		.maxlen		=3D sizeof(brute_crash_period_threshold),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D &uint_one,
+		.extra2		=3D &uint_max,
+	},
+	{ }
+};
+
+/**
+ * brute_init_sysctl() - Initialize the sysctl interface.
+ */
+static void __init brute_init_sysctl(void)
+{
+	if (!register_sysctl_paths(brute_sysctl_path, brute_sysctl_table))
+		panic("Cannot register the sysctl interface\n");
+}
+
+#else
+static inline void brute_init_sysctl(void) { }
+#endif /* CONFIG_SYSCTL */
+
 /**
  * brute_init() - Initialize the brute LSM.
  *
@@ -328,6 +410,7 @@ static int __init brute_init(void)
 	pr_info("Brute initialized\n");
 	security_add_hooks(brute_hooks, ARRAY_SIZE(brute_hooks),
 			   KBUILD_MODNAME);
+	brute_init_sysctl();
 	return 0;
 }

=2D-
2.25.1

