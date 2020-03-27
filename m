Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A1195CD0
	for <lists+linux-security-module@lfdr.de>; Fri, 27 Mar 2020 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgC0Rbx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 27 Mar 2020 13:31:53 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:38852 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgC0Rbt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Mar 2020 13:31:49 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id E38B920AB2;
        Fri, 27 Mar 2020 17:23:59 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v10 6/9] docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior
Date:   Fri, 27 Mar 2020 18:23:28 +0100
Message-Id: <20200327172331.418878-7-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200327172331.418878-1-gladkov.alexey@gmail.com>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Fri, 27 Mar 2020 17:24:00 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Documentation/filesystems/proc.txt | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 99ca040e3f90..bd0e0ab85048 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -50,6 +50,8 @@ Table of Contents
   4	Configuring procfs
   4.1	Mount options
 
+  5	Filesystem behavior
+
 ------------------------------------------------------------------------------
 Preface
 ------------------------------------------------------------------------------
@@ -2021,6 +2023,7 @@ The following mount options are supported:
 
 	hidepid=	Set /proc/<pid>/ access mode.
 	gid=		Set the group authorized to learn processes information.
+	subset=		Show only the specified subset of procfs.
 
 hidepid=0 means classic mode - everybody may access all /proc/<pid>/ directories
 (default).
@@ -2042,6 +2045,56 @@ information about running processes, whether some daemon runs with elevated
 privileges, whether other user runs some sensitive program, whether other users
 run any program at all, etc.
 
+hidepid=4 means that procfs should only contain /proc/<pid>/ directories
+that the caller can ptrace.
+
 gid= defines a group authorized to learn processes information otherwise
 prohibited by hidepid=.  If you use some daemon like identd which needs to learn
 information about processes information, just add identd to this group.
+
+subset=pid hides all top level files and directories in the procfs that
+are not related to tasks.
+
+------------------------------------------------------------------------------
+5 Filesystem behavior
+------------------------------------------------------------------------------
+
+Originally, before the advent of pid namepsace, procfs was a global file
+system. It means that there was only one procfs instance in the system.
+
+When pid namespace was added, a separate procfs instance was mounted in
+each pid namespace. So, procfs mount options are global among all
+mountpoints within the same namespace.
+
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=2 0 0
+
+# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
+mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
++++ exited with 0 +++
+
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=2 0 0
+proc /tmp/proc proc rw,relatime,hidepid=2 0 0
+
+and only after remounting procfs mount options will change at all
+mountpoints.
+
+# mount -o remount,hidepid=1 -t proc proc /tmp/proc
+
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=1 0 0
+proc /tmp/proc proc rw,relatime,hidepid=1 0 0
+
+This behavior is different from the behavior of other filesystems.
+
+The new procfs behavior is more like other filesystems. Each procfs mount
+creates a new procfs instance. Mount options affect own procfs instance.
+It means that it became possible to have several procfs instances
+displaying tasks with different filtering options in one pid namespace.
+
+# mount -o hidepid=2 -t proc proc /proc
+# mount -o hidepid=1 -t proc proc /tmp/proc
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=2 0 0
+proc /tmp/proc proc rw,relatime,hidepid=1 0 0
-- 
2.25.2

