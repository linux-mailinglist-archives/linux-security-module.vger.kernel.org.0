Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1196189EE4
	for <lists+linux-security-module@lfdr.de>; Wed, 18 Mar 2020 16:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCRPF0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 18 Mar 2020 11:05:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59039 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727339AbgCRPF0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Mar 2020 11:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzNG4GfNqflKrUpl1xSrMXqumlU4F+cA0mDF/K9bFVI=;
        b=DeyXSM+8ElF+c7nfOOiLU2JyBGon19ppA0QxdRRxFw7tw9dfblgY2Wjv7Ixzd7ub/FMcRV
        /1HvpXt+HwV/eRA1KAcTdLfZD0teahOJtzs6kGyUELGiBxEt6GrSmkY3vGK++9EGSsn2sz
        ZNaYOw0ldz1ybqqopMD/R+AXVL8pWCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-8kQcuRLoPuiIibqJ5UJAEg-1; Wed, 18 Mar 2020 11:05:19 -0400
X-MC-Unique: 8kQcuRLoPuiIibqJ5UJAEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29CC91084424;
        Wed, 18 Mar 2020 15:05:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB8081001B07;
        Wed, 18 Mar 2020 15:05:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:05:13 +0000
Message-ID: <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a mount notification facility whereby notifications about changes in
mount topology and configuration can be received.  Note that this only
covers vfsmount topology changes and not superblock events.  A separate
facility will be added for that.

Every mount is given a change counter than counts the number of topological
rearrangements in which it is involved and the number of attribute changes
it undergoes.  This allows notification loss to be dealt with.  Later
patches will provide a way to quickly retrieve this value, along with
information about topology and parameters for the superblock.

Firstly, a watch queue needs to be created:

	pipe2(fds, O_NOTIFICATION_PIPE);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_MOUNT_NOTIFY,
				.subtype_filter[0] = UINT_MAX,
			},
		},
	};
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
	watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);

In this case, it would let me monitor the mount topology subtree rooted at
"/" for events.  Mount notifications propagate up the tree towards the
root, so a watch will catch all of the events happening in the subtree
rooted at the watch.

After setting the watch, records will be placed into the queue when, for
example, as superblock switches between read-write and read-only.  Records
are of the following format:

	struct mount_notification {
		struct watch_notification watch;
		__u32	triggered_on;
		__u32	auxiliary_mount;
		__u32	topology_changes;
		__u32	attr_changes;
		__u32	aux_topology_changes;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.

	n->watch.subtype will indicate the type of event, such as
	NOTIFY_MOUNT_NEW_MOUNT.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the fifth argument to
	watch_mount(), shifted.

	n->watch.info & NOTIFY_MOUNT_IN_SUBTREE if true indicates that the
	notifcation was generated in the mount subtree rooted at the watch,
	and not actually in the watch itself.

	n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates that
	the notifcation was generated by an event (eg. SETATTR) that was
	applied recursively.  The notification is only generated for the
	object that initially triggered it.

	n->watch.info & NOTIFY_MOUNT_IS_NOW_RO will be used for
	NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O, and
	being cleared otherwise, and for NOTIFY_MOUNT_NEW_MOUNT, being set
	if the new mount is a submount (e.g. an automount).

	n->watch.info & NOTIFY_MOUNT_IS_SUBMOUNT if true indicates that the
	NOTIFY_MOUNT_NEW_MOUNT notification is in response to a mount
	performed by the kernel (e.g. an automount).

	n->triggered_on indicates the ID of the mount to which the change
	was accounted (e.g. the new parent of a new mount).

	n->axiliary_mount indicates the ID of an additional mount that was
	affected (e.g. a new mount itself) or 0.

	n->topology_changes provides the value of the topology change
	counter of the triggered-on mount at the conclusion of the
	operarion.

	n->attr_changes provides the value of the attribute change counter
	of the triggered-on mount at the conclusion of the operarion.

	n->aux_topology_changes provides the value of the topology change
	counter of the auxiliary mount at the conclusion of the operation.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst               |   12 +
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/arm64/include/asm/unistd32.h           |    2 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 fs/Kconfig                                  |    9 +
 fs/Makefile                                 |    1 
 fs/mount.h                                  |   21 ++
 fs/mount_notify.c                           |  228 +++++++++++++++++++++++++++
 fs/namespace.c                              |   22 +++
 include/linux/dcache.h                      |    1 
 include/linux/syscalls.h                    |    2 
 include/uapi/asm-generic/unistd.h           |    4 
 include/uapi/linux/watch_queue.h            |   36 ++++
 kernel/sys_ni.c                             |    3 
 29 files changed, 355 insertions(+), 4 deletions(-)
 create mode 100644 fs/mount_notify.c

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 849fad6893ef..3e647992be31 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -8,6 +8,7 @@ opened by userspace.  This can be used in conjunction with::
 
   * Key/keyring notifications
 
+  * Mount notifications.
 
 The notifications buffers can be enabled by:
 
@@ -233,6 +234,11 @@ Any particular buffer can be fed from multiple sources.  Sources include:
 
     See Documentation/security/keys/core.rst for more information.
 
+  * WATCH_TYPE_MOUNT_NOTIFY
+
+    Notifications of this type indicate changes to mount attributes and the
+    mount topology within the subtree at the indicated point.
+
 
 Event Filtering
 ===============
@@ -292,9 +298,10 @@ A buffer is created with something like the following::
 	pipe2(fds, O_TMPFILE);
 	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
 
-It can then be set to receive keyring change notifications::
+It can then be set to receive notifications::
 
 	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
+	watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
 
 The notifications can then be consumed by something like the following::
 
@@ -331,6 +338,9 @@ The notifications can then be consumed by something like the following::
 				case WATCH_TYPE_KEY_NOTIFY:
 					saw_key_change(&n.n);
 					break;
+				case WATCH_TYPE_MOUNT_NOTIFY:
+					saw_mount_change(&n.n);
+					break;
 				}
 
 				p += len;
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 36d42da7466a..b869428033ef 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -477,3 +477,4 @@
 # 545 reserved for clone3
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
+549	common	watch_mount			sys_watch_mount
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 4d1cf74a2caa..9c389da9efcc 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -451,3 +451,4 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 1dd22da1c3a9..75f04a1023be 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		439
+#define __NR_compat_syscalls		440
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c1c61635f89c..774f0339763f 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -883,6 +883,8 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_watch_mount 439
+__SYSCALL(__NR_watch_mount, sys_watch_mount)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 042911e670b8..6817f865cc71 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -358,3 +358,4 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f4f49fcb76d0..fbf85da75ecb 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 435	common	clone3				__sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 4c67b11f9c9e..b05b192da1e2 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 1f9e8ad636cc..0f85d2a033f9 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -376,3 +376,4 @@
 435	n32	clone3				__sys_clone3
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
+439	n32	watch_mount			sys_watch_mount
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c0b9d802dbf6..905cf9ac0792 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -352,3 +352,4 @@
 435	n64	clone3				__sys_clone3
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
+439	n64	watch_mount			sys_watch_mount
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ac586774c980..834b26b08d74 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -425,3 +425,4 @@
 435	o32	clone3				__sys_clone3
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
+439	o32	watch_mount			sys_watch_mount
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 52a15f5cd130..badd3449db43 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -435,3 +435,4 @@
 435	common	clone3				sys_clone3_wrapper
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 35b61bfc1b1a..b404361bc929 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -519,3 +519,4 @@
 435	nospu	clone3				ppc_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bd7bd3581a0f..33071de24511 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 435  common	clone3			sys_clone3			sys_clone3
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount		sys_watch_mount			sys_watch_mount
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c7a30fcd135f..682c125122f4 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index f13615ecdecc..febf3cd675e3 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -483,3 +483,4 @@
 # 435 reserved for clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77eb150..085bcc5afdf1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,4 @@
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+439	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..9cfb6b2eb319 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			__x64_sys_clone3/ptregs
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+439	common	watch_mount		__x64_sys_watch_mount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 85a9ab1bc04d..1a066a43a58b 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -408,3 +408,4 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	watch_mount			sys_watch_mount
diff --git a/fs/Kconfig b/fs/Kconfig
index 708ba336e689..d7039137d538 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -117,6 +117,15 @@ source "fs/verity/Kconfig"
 
 source "fs/notify/Kconfig"
 
+config MOUNT_NOTIFICATIONS
+	bool "Mount topology change notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting change notifications on the
+	  mount tree topology.  This makes use of the /dev/watch_queue misc
+	  device to handle the notification buffer and provides the
+	  mount_notify() system call to enable/disable watchpoints.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 505e51166973..4477757780d0 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -22,6 +22,7 @@ obj-y +=	no-block.o
 endif
 
 obj-$(CONFIG_PROC_FS) += proc_namespace.o
+obj-$(CONFIG_MOUNT_NOTIFICATIONS) += mount_notify.o
 
 obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..9a49ea1e7365 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/watch_queue.h>
 
 struct mnt_namespace {
 	atomic_t		count;
@@ -72,6 +73,12 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	atomic_t mnt_topology_changes;	/* Number of topology changes applied */
+	atomic_t mnt_attr_changes;	/* Number of attribute changes applied */
+	atomic_t mnt_subtree_notifications;	/* Number of notifications in subtree */
+	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
+#endif
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
@@ -153,3 +160,17 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
 	return ns->seq == 0;
 }
+
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+extern void notify_mount(struct mount *triggered,
+			 struct mount *aux,
+			 enum mount_notification_subtype subtype,
+			 u32 info_flags);
+#else
+static inline void notify_mount(struct mount *triggered,
+				struct mount *aux,
+				enum mount_notification_subtype subtype,
+				u32 info_flags)
+{
+}
+#endif
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
new file mode 100644
index 000000000000..403d79785807
--- /dev/null
+++ b/fs/mount_notify.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Provide mount topology/attribute change notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/syscalls.h>
+#include <linux/slab.h>
+#include <linux/security.h>
+#include "mount.h"
+
+/*
+ * Post mount notifications to all watches going rootwards along the tree.
+ *
+ * Must be called with the mount_lock held.
+ */
+static void post_mount_notification(struct mount *changed,
+				    struct mount_notification *notify)
+{
+	const struct cred *cred = current_cred();
+	struct path cursor;
+	struct mount *mnt;
+	unsigned seq;
+
+	seq = 0;
+	rcu_read_lock();
+restart:
+	cursor.mnt = &changed->mnt;
+	cursor.dentry = changed->mnt.mnt_root;
+	mnt = real_mount(cursor.mnt);
+	notify->watch.info &= ~NOTIFY_MOUNT_IN_SUBTREE;
+
+	read_seqbegin_or_lock(&rename_lock, &seq);
+	for (;;) {
+		if (mnt->mnt_watchers &&
+		    !hlist_empty(&mnt->mnt_watchers->watchers)) {
+			if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
+				post_watch_notification(mnt->mnt_watchers,
+							&notify->watch, cred,
+							(unsigned long)cursor.dentry);
+		} else {
+			cursor.dentry = mnt->mnt.mnt_root;
+		}
+		notify->watch.info |= NOTIFY_MOUNT_IN_SUBTREE;
+
+		if (cursor.dentry == cursor.mnt->mnt_root ||
+		    IS_ROOT(cursor.dentry)) {
+			struct mount *parent = READ_ONCE(mnt->mnt_parent);
+
+			/* Escaped? */
+			if (cursor.dentry != cursor.mnt->mnt_root)
+				break;
+
+			/* Global root? */
+			if (mnt == parent)
+				break;
+
+			cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
+			mnt = parent;
+			cursor.mnt = &mnt->mnt;
+			atomic_inc(&mnt->mnt_subtree_notifications);
+		} else {
+			cursor.dentry = cursor.dentry->d_parent;
+		}
+	}
+
+	if (need_seqretry(&rename_lock, seq)) {
+		seq = 1;
+		goto restart;
+	}
+
+	done_seqretry(&rename_lock, seq);
+	rcu_read_unlock();
+}
+
+/*
+ * Generate a mount notification.
+ */
+void notify_mount(struct mount *trigger,
+		  struct mount *aux,
+		  enum mount_notification_subtype subtype,
+		  u32 info_flags)
+{
+
+	struct mount_notification n;
+
+	memset(&n, 0, sizeof(n));
+	n.watch.type	= WATCH_TYPE_MOUNT_NOTIFY;
+	n.watch.subtype	= subtype;
+	n.watch.info	= info_flags | watch_sizeof(n);
+	n.triggered_on	= trigger->mnt_id;
+
+	switch (subtype) {
+	case NOTIFY_MOUNT_EXPIRY:
+	case NOTIFY_MOUNT_READONLY:
+	case NOTIFY_MOUNT_SETATTR:
+		n.topology_changes	= atomic_read(&trigger->mnt_topology_changes);
+		n.attr_changes		= atomic_inc_return(&trigger->mnt_attr_changes);
+		break;
+
+	case NOTIFY_MOUNT_NEW_MOUNT:
+	case NOTIFY_MOUNT_UNMOUNT:
+	case NOTIFY_MOUNT_MOVE_FROM:
+	case NOTIFY_MOUNT_MOVE_TO:
+		n.auxiliary_mount	= aux->mnt_id,
+		n.attr_changes		= atomic_read(&trigger->mnt_attr_changes);
+		n.topology_changes	= atomic_inc_return(&trigger->mnt_topology_changes);
+		n.aux_topology_changes	= atomic_inc_return(&aux->mnt_topology_changes);
+		break;
+
+	default:
+		BUG();
+	}
+
+	post_mount_notification(trigger, &n);
+}
+
+static void release_mount_watch(struct watch *watch)
+{
+	struct dentry *dentry = (struct dentry *)(unsigned long)watch->id;
+
+	dput(dentry);
+}
+
+/**
+ * sys_watch_mount - Watch for mount topology/attribute changes
+ * @dfd: Base directory to pathwalk from or fd referring to mount.
+ * @filename: Path to mount to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(watch_mount,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = NULL;
+	struct watch *watch = NULL;
+	struct mount *m;
+	struct path path;
+	unsigned int lookup_flags =
+		LOOKUP_DIRECTORY | LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	int ret;
+
+	if (watch_id < -1 || watch_id > 0xff)
+		return -EINVAL;
+	if ((at_flags & ~(AT_NO_AUTOMOUNT | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+	if (at_flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	ret = user_path_at(dfd, filename, lookup_flags, &path);
+	if (ret)
+		return ret;
+
+	ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
+	if (ret)
+		goto err_path;
+
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue))
+		goto err_path;
+
+	m = real_mount(path.mnt);
+
+	if (watch_id >= 0) {
+		ret = -ENOMEM;
+		if (!READ_ONCE(m->mnt_watchers)) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			init_watch_list(wlist, release_mount_watch);
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch, wqueue);
+		watch->id		= (unsigned long)path.dentry;
+		watch->info_id		= (u32)watch_id << 24;
+
+		ret = security_watch_mount(watch, &path);
+		if (ret < 0)
+			goto err_watch;
+
+		down_write(&m->mnt.mnt_sb->s_umount);
+		if (!m->mnt_watchers) {
+			m->mnt_watchers = wlist;
+			wlist = NULL;
+		}
+
+		ret = add_watch_to_object(watch, m->mnt_watchers);
+		if (ret == 0) {
+			spin_lock(&path.dentry->d_lock);
+			path.dentry->d_flags |= DCACHE_MOUNT_WATCH;
+			spin_unlock(&path.dentry->d_lock);
+			dget(path.dentry);
+			watch = NULL;
+		}
+		up_write(&m->mnt.mnt_sb->s_umount);
+	} else {
+		down_write(&m->mnt.mnt_sb->s_umount);
+		ret = remove_watch_from_object(m->mnt_watchers, wqueue,
+					       (unsigned long)path.dentry,
+					       false);
+		up_write(&m->mnt.mnt_sb->s_umount);
+	}
+
+err_watch:
+	kfree(watch);
+err_wlist:
+	kfree(wlist);
+err_wqueue:
+	put_watch_queue(wqueue);
+err_path:
+	path_put(&path);
+	return ret;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..54d237251941 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -498,6 +498,9 @@ static int mnt_make_readonly(struct mount *mnt)
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	unlock_mount_hash();
+	if (ret == 0)
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY,
+			     NOTIFY_MOUNT_IS_NOW_RO);
 	return ret;
 }
 
@@ -506,6 +509,7 @@ static int __mnt_unmake_readonly(struct mount *mnt)
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0);
 	return 0;
 }
 
@@ -819,6 +823,7 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
  */
 static void umount_mnt(struct mount *mnt)
 {
+	notify_mount(mnt->mnt_parent, mnt, NOTIFY_MOUNT_UNMOUNT, 0);
 	put_mountpoint(unhash_mnt(mnt));
 }
 
@@ -1159,6 +1164,11 @@ static void mntput_no_expire(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	if (mnt->mnt_watchers)
+		remove_watch_list(mnt->mnt_watchers, mnt->mnt_id);
+#endif
+
 	list_del(&mnt->mnt_instance);
 
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
@@ -1453,6 +1463,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		p = list_first_entry(&tmp_list, struct mount, mnt_list);
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
+
 		ns = p->mnt_ns;
 		if (ns) {
 			ns->mounts--;
@@ -2079,7 +2090,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 	if (moving) {
 		unhash_mnt(source_mnt);
+		notify_mount(source_mnt->mnt_parent, source_mnt,
+			     NOTIFY_MOUNT_MOVE_FROM, 0);
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_MOVE_TO, 0);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -2088,6 +2102,11 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		}
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		commit_tree(source_mnt);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT,
+			     (source_mnt->mnt.mnt_sb->s_flags & SB_RDONLY ?
+			      NOTIFY_MOUNT_IS_NOW_RO : 0) |
+			     (source_mnt->mnt.mnt_sb->s_flags & SB_SUBMOUNT ?
+			      NOTIFY_MOUNT_IS_SUBMOUNT : 0));
 	}
 
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
@@ -2464,6 +2483,8 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR,
+		     (mnt_flags & SB_RDONLY ? NOTIFY_MOUNT_IS_NOW_RO : 0));
 }
 
 static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
@@ -2899,6 +2920,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 			propagate_mount_busy(mnt, 1))
 			continue;
 		list_move(&mnt->mnt_expire, &graveyard);
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_EXPIRY, 0);
 	}
 	while (!list_empty(&graveyard)) {
 		mnt = list_first_entry(&graveyard, struct mount, mnt_expire);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..7b194d778155 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,6 +217,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_MOUNT_WATCH		0x80000000 /* There's a mount watch here */
 
 extern seqlock_t rename_lock;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..1fd43af3b22d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,8 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_watch_mount(int dfd, const char __user *path,
+				unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..6b5748287883 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_watch_mount 439
+__SYSCALL(__NR_watch_mount, sys_watch_mount)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 440
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index c3d8320b5d3a..6b6cd2afc590 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
-	WATCH_TYPE__NR		= 2
+	WATCH_TYPE_MOUNT_NOTIFY	= 2,	/* Mount topology change notification */
+	WATCH_TYPE___NR		= 3
 };
 
 enum watch_meta_notification_subtype {
@@ -101,4 +102,37 @@ struct key_notification {
 	__u32	aux;		/* Per-type auxiliary data */
 };
 
+/*
+ * Type of mount topology change notification.
+ */
+enum mount_notification_subtype {
+	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
+	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
+	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
+	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
+	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
+	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
+	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
+};
+
+#define NOTIFY_MOUNT_IN_SUBTREE		WATCH_INFO_FLAG_0 /* Event not actually at watched dentry */
+#define NOTIFY_MOUNT_IS_RECURSIVE	WATCH_INFO_FLAG_1 /* Change applied recursively */
+#define NOTIFY_MOUNT_IS_NOW_RO		WATCH_INFO_FLAG_2 /* Mount changed to R/O */
+#define NOTIFY_MOUNT_IS_SUBMOUNT	WATCH_INFO_FLAG_3 /* New mount is submount */
+
+/*
+ * Mount topology/configuration change notification record.
+ * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
+ * - watch.subtype = enum mount_notification_subtype
+ */
+struct mount_notification {
+	struct watch_notification watch; /* WATCH_TYPE_MOUNT_NOTIFY */
+	__u32	triggered_on;		/* The mount that triggered the notification */
+	__u32	auxiliary_mount;	/* Added/moved/removed mount or 0 */
+	__u32	topology_changes;	/* trigger: Number of topology changes applied */
+	__u32	attr_changes;		/* trigger: Number of attribute changes applied */
+	__u32	aux_topology_changes;	/* aux: Number of topology changes applied */
+	__u32	__padding;
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..3e1c5c9d2efe 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -85,6 +85,9 @@ COND_SYSCALL(ioprio_get);
 /* fs/locks.c */
 COND_SYSCALL(flock);
 
+/* fs/mount_notify.c */
+COND_SYSCALL(watch_mount);
+
 /* fs/namei.c */
 
 /* fs/namespace.c */


