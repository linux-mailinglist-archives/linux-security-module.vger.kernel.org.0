Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D530239CAB
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Aug 2020 00:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHBWAs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 2 Aug 2020 18:00:48 -0400
Received: from smtp-8fa8.mail.infomaniak.ch ([83.166.143.168]:53073 "EHLO
        smtp-8fa8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbgHBV7b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 2 Aug 2020 17:59:31 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BKZg43r36zlhZZH;
        Sun,  2 Aug 2020 23:59:28 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BKZg40ZXBzlh8T3;
        Sun,  2 Aug 2020 23:59:28 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v20 04/12] landlock: Add ptrace restrictions
Date:   Sun,  2 Aug 2020 23:58:55 +0200
Message-Id: <20200802215903.91936-5-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc2
In-Reply-To: <20200802215903.91936-1-mic@digikod.net>
References: <20200802215903.91936-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Using ptrace(2) and related debug features on a target process can lead
to a privilege escalation.  Indeed, ptrace(2) can be used by an attacker
to impersonate another task and to remain undetected while performing
malicious activities.  Thanks to  ptrace_may_access(), various part of
the kernel can check if a tracer is more privileged than a tracee.

A landlocked process has fewer privileges than a non-landlocked process
and must then be subject to additional restrictions when manipulating
processes. To be allowed to use ptrace(2) and related syscalls on a
target process, a landlocked process must have a subset of the target
process' rules (i.e. the tracee must be in a sub-domain of the tracer).

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v14:
* Constify variables.

Changes since v13:
* Make the ptrace restriction mandatory, like in the v10.
* Remove the eBPF dependency.

Previous changes:
https://lore.kernel.org/lkml/20191104172146.30797-5-mic@digikod.net/
---
 security/landlock/Makefile |   2 +-
 security/landlock/ptrace.c | 120 +++++++++++++++++++++++++++++++++++++
 security/landlock/ptrace.h |  14 +++++
 security/landlock/setup.c  |   2 +
 4 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 041ea242e627..f1d1eb72fa76 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o object.o ruleset.o \
-	cred.o
+	cred.o ptrace.o
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
new file mode 100644
index 000000000000..61df38b13f5c
--- /dev/null
+++ b/security/landlock/ptrace.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ptrace hooks
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2020 ANSSI
+ */
+
+#include <asm/current.h>
+#include <linux/cred.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/lsm_hooks.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+
+#include "common.h"
+#include "cred.h"
+#include "ptrace.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/**
+ * domain_scope_le - Checks domain ordering for scoped ptrace
+ *
+ * @parent: Parent domain.
+ * @child: Potential child of @parent.
+ *
+ * Checks if the @parent domain is less or equal to (i.e. an ancestor, which
+ * means a subset of) the @child domain.
+ */
+static bool domain_scope_le(const struct landlock_ruleset *const parent,
+		const struct landlock_ruleset *const child)
+{
+	const struct landlock_hierarchy *walker;
+
+	if (!parent)
+		return true;
+	if (!child)
+		return false;
+	for (walker = child->hierarchy; walker; walker = walker->parent) {
+		if (walker == parent->hierarchy)
+			/* @parent is in the scoped hierarchy of @child. */
+			return true;
+	}
+	/* There is no relationship between @parent and @child. */
+	return false;
+}
+
+static bool task_is_scoped(const struct task_struct *const parent,
+		const struct task_struct *const child)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *dom_parent, *dom_child;
+
+	rcu_read_lock();
+	dom_parent = landlock_get_task_domain(parent);
+	dom_child = landlock_get_task_domain(child);
+	is_scoped = domain_scope_le(dom_parent, dom_child);
+	rcu_read_unlock();
+	return is_scoped;
+}
+
+static int task_ptrace(const struct task_struct *const parent,
+		const struct task_struct *const child)
+{
+	/* Quick return for non-landlocked tasks. */
+	if (!landlocked(parent))
+		return 0;
+	if (task_is_scoped(parent, child))
+		return 0;
+	return -EPERM;
+}
+
+/**
+ * hook_ptrace_access_check - Determines whether the current process may access
+ *			      another
+ *
+ * @child: Process to be accessed.
+ * @mode: Mode of attachment.
+ *
+ * If the current task has Landlock rules, then the child must have at least
+ * the same rules.  Else denied.
+ *
+ * Determines whether a process may access another, returning 0 if permission
+ * granted, -errno if denied.
+ */
+static int hook_ptrace_access_check(struct task_struct *const child,
+		const unsigned int mode)
+{
+	return task_ptrace(current, child);
+}
+
+/**
+ * hook_ptrace_traceme - Determines whether another process may trace the
+ *			 current one
+ *
+ * @parent: Task proposed to be the tracer.
+ *
+ * If the parent has Landlock rules, then the current task must have the same
+ * or more rules.  Else denied.
+ *
+ * Determines whether the nominated task is permitted to trace the current
+ * process, returning 0 if permission is granted, -errno if denied.
+ */
+static int hook_ptrace_traceme(struct task_struct *const parent)
+{
+	return task_ptrace(parent, current);
+}
+
+static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
+	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
+};
+
+__init void landlock_add_hooks_ptrace(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			LANDLOCK_NAME);
+}
diff --git a/security/landlock/ptrace.h b/security/landlock/ptrace.h
new file mode 100644
index 000000000000..6740c6a723de
--- /dev/null
+++ b/security/landlock/ptrace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Ptrace hooks
+ *
+ * Copyright © 2017-2019 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_PTRACE_H
+#define _SECURITY_LANDLOCK_PTRACE_H
+
+__init void landlock_add_hooks_ptrace(void);
+
+#endif /* _SECURITY_LANDLOCK_PTRACE_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 39ee1766f175..5e7540fdeefa 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,6 +11,7 @@
 
 #include "common.h"
 #include "cred.h"
+#include "ptrace.h"
 #include "setup.h"
 
 struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
@@ -20,6 +21,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 static int __init landlock_init(void)
 {
 	landlock_add_hooks_cred();
+	landlock_add_hooks_ptrace();
 	pr_info("Up and running.\n");
 	return 0;
 }
-- 
2.28.0.rc2

