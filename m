Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3175D64D474
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Dec 2022 01:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLOAOq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 14 Dec 2022 19:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLOANp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60122532F4
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:17 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so1004026pjr.3
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVyjOhi/pzntg5cu80LrTtyRL8XcAFXbux7p+GJEQIo=;
        b=jxcNFgeVj0Fxc7Zx42KHLwUQnKFsiu9IWedp4b+G2OMNf7qLsJU/1Q6BFjav07vpp+
         CRDJLhClYOM5aVDmzdmThMzLzT7vBZ+NfoKEWjuzi5XaHPReEG8TLdqj75y76ovECaw0
         J8B1MYFOInCEb2NTKyBph8idcyYY5LFmUD9CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVyjOhi/pzntg5cu80LrTtyRL8XcAFXbux7p+GJEQIo=;
        b=aMuWQOnjOMaL0Eu+Xo/E1wa6dgVxwgWTn22VbZnNojH0m0d9ARQFg7vNYaj9MWbxcB
         X3ZFWeISA7bdOhL8dq9SDRkouSXPu/NrMcKcoppPHrwT8QAMcG7XJbiabyXAf/1Ma47Y
         YTvcvrZeRBLajPPHZs0kMH7//FYu0BMvAqv0VFOi7jx782TirXq8OadXf2ePxa0eWYkP
         U0FE3NitBEeTTeOA6sx+VsNkn9pZGsup/aEXXtG2S80E9xLDZEz0e9SN4Bj1cb0wF4ov
         uW5E7Zs/UXch2cmhu6s4Eob7sVsASD25VpayVF7QlCNVr9OLKk8k8uxdeF/w7pa4npsS
         M1lA==
X-Gm-Message-State: ANoB5pm0K0rGFToX5110CtyyKrzloE5MHNwmeHkXL7A23b5OkXSxzV7G
        iwRJrsHiGSYZFep308Kw5UvTIA==
X-Google-Smtp-Source: AA0mqf6N67OOGMq1W724yjn6V46JwAAPQJebK22wsb76tFC/URwFsfBxyXHyi5y7bzgI/wAqnQ4C5w==
X-Received: by 2002:a17:90a:c38e:b0:219:6c57:c3ea with SMTP id h14-20020a17090ac38e00b002196c57c3eamr27602261pjt.12.1671063136848;
        Wed, 14 Dec 2022 16:12:16 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:16 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Thu, 15 Dec 2022 00:12:03 +0000
Message-Id: <20221215001205.51969-4-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
set executable bit at creation time (memfd_create).

When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
be executable (mode: 0777) after creation.

when MFD_EXEC flag is set, memfd is created with executable bit
(mode:0777), this is the same as the old behavior of memfd_create.

The new pid namespaced sysctl vm.memfd_noexec has 3 values:
0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
        MFD_EXEC was set.
1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
        MFD_NOEXEC_SEAL was set.
2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.

The sysctl allows finer control of memfd_create for old-software
that doesn't set the executable bit, for example, a container with
vm.memfd_noexec=1 means the old-software will create non-executable
memfd by default. Also, the value of memfd_noexec is passed to child
namespace at creation time. For example, if the init namespace has
vm.memfd_noexec=2, all its children namespaces will be created with 2.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pid_namespace.h | 19 +++++++++++
 include/uapi/linux/memfd.h    |  4 +++
 kernel/pid_namespace.c        |  5 +++
 kernel/pid_sysctl.h           | 59 +++++++++++++++++++++++++++++++++++
 mm/memfd.c                    | 48 ++++++++++++++++++++++++++--
 5 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 kernel/pid_sysctl.h

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87d4e..c758809d5bcf 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -16,6 +16,21 @@
 
 struct fs_pin;
 
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+/*
+ * sysctl for vm.memfd_noexec
+ * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
+ *	acts like MFD_EXEC was set.
+ * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
+ *	acts like MFD_NOEXEC_SEAL was set.
+ * 2: memfd_create() without MFD_NOEXEC_SEAL will be
+ *	rejected.
+ */
+#define MEMFD_NOEXEC_SCOPE_EXEC			0
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2
+#endif
+
 struct pid_namespace {
 	struct idr idr;
 	struct rcu_head rcu;
@@ -31,6 +46,10 @@ struct pid_namespace {
 	struct ucounts *ucounts;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	/* sysctl for vm.memfd_noexec */
+	int memfd_noexec_scope;
+#endif
 } __randomize_layout;
 
 extern struct pid_namespace init_pid_ns;
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..273a4e15dfcf 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,10 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+/* not executable and sealed to prevent changing to executable. */
+#define MFD_NOEXEC_SEAL		0x0008U
+/* executable */
+#define MFD_EXEC		0x0010U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..8a98b1af9376 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -23,6 +23,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
 #include <linux/idr.h>
+#include "pid_sysctl.h"
 
 static DEFINE_MUTEX(pid_caches_mutex);
 static struct kmem_cache *pid_ns_cachep;
@@ -110,6 +111,8 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
 
+	initialize_memfd_noexec_scope(ns);
+
 	return ns;
 
 out_free_idr:
@@ -455,6 +458,8 @@ static __init int pid_namespaces_init(void)
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	register_sysctl_paths(kern_path, pid_ns_ctl_table);
 #endif
+
+	register_pid_ns_sysctl_table_vm();
 	return 0;
 }
 
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
new file mode 100644
index 000000000000..90a93161a122
--- /dev/null
+++ b/kernel/pid_sysctl.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_PID_SYSCTL_H
+#define LINUX_PID_SYSCTL_H
+
+#include <linux/pid_namespace.h>
+
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns)
+{
+	ns->memfd_noexec_scope =
+		task_active_pid_ns(current)->memfd_noexec_scope;
+}
+
+static int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table,
+	int write, void *buf, size_t *lenp, loff_t *ppos)
+{
+	struct pid_namespace *ns = task_active_pid_ns(current);
+	struct ctl_table table_copy;
+
+	if (write && !ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	table_copy = *table;
+	if (ns != &init_pid_ns)
+		table_copy.data = &ns->memfd_noexec_scope;
+
+	/*
+	 * set minimum to current value, the effect is only bigger
+	 * value is accepted.
+	 */
+	if (*(int *)table_copy.data > *(int *)table_copy.extra1)
+		table_copy.extra1 = table_copy.data;
+
+	return proc_dointvec_minmax(&table_copy, write, buf, lenp, ppos);
+}
+
+static struct ctl_table pid_ns_ctl_table_vm[] = {
+	{
+		.procname	= "memfd_noexec",
+		.data		= &init_pid_ns.memfd_noexec_scope,
+		.maxlen		= sizeof(init_pid_ns.memfd_noexec_scope),
+		.mode		= 0644,
+		.proc_handler	= pid_mfd_noexec_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{ }
+};
+static struct ctl_path vm_path[] = { { .procname = "vm", }, { } };
+static inline void register_pid_ns_sysctl_table_vm(void)
+{
+	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
+}
+#else
+static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
+static inline void register_pid_ns_ctl_table_vm(void) {}
+#endif
+
+#endif /* LINUX_PID_SYSCTL_H */
diff --git a/mm/memfd.c b/mm/memfd.c
index 4ebeab94aa74..ec70675a7069 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -18,6 +18,7 @@
 #include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
 #include <linux/memfd.h>
+#include <linux/pid_namespace.h>
 #include <uapi/linux/memfd.h>
 
 /*
@@ -263,12 +264,14 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
+	char comm[TASK_COMM_LEN];
+	struct pid_namespace *ns;
 	unsigned int *file_seals;
 	struct file *file;
 	int fd, error;
@@ -285,6 +288,39 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
+	/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
+	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
+		return -EINVAL;
+
+	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
+#ifdef CONFIG_SYSCTL
+		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
+
+		ns = task_active_pid_ns(current);
+		if (ns)
+			sysctl = ns->memfd_noexec_scope;
+
+		switch (sysctl) {
+		case MEMFD_NOEXEC_SCOPE_EXEC:
+			flags |= MFD_EXEC;
+			break;
+		case MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL:
+			flags |= MFD_NOEXEC_SEAL;
+			break;
+		default:
+			pr_warn_ratelimited(
+				"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
+				task_pid_nr(current), get_task_comm(comm, current));
+			return -EINVAL;
+		}
+#else
+		flags |= MFD_EXEC;
+#endif
+		pr_warn_ratelimited(
+			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+	}
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
@@ -328,7 +364,15 @@ SYSCALL_DEFINE2(memfd_create,
 	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |= O_LARGEFILE;
 
-	if (flags & MFD_ALLOW_SEALING) {
+	if (flags & MFD_NOEXEC_SEAL) {
+		struct inode *inode = file_inode(file);
+
+		inode->i_mode &= ~0111;
+		file_seals = memfd_file_seals_ptr(file);
+		*file_seals &= ~F_SEAL_SEAL;
+		*file_seals |= F_SEAL_EXEC;
+	} else if (flags & MFD_ALLOW_SEALING) {
+		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
 		file_seals = memfd_file_seals_ptr(file);
 		*file_seals &= ~F_SEAL_SEAL;
 	}
-- 
2.39.0.rc1.256.g54fd8350bd-goog

