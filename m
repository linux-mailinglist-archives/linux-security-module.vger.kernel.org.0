Return-Path: <linux-security-module+bounces-8893-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F90A6AE64
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Mar 2025 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F79A9A0E82
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Mar 2025 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25F229B2C;
	Thu, 20 Mar 2025 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JXG+A4DP"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C222F176
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497684; cv=none; b=pKsw9NBKXiADHbwlYwhLoT/48bA2ZIguYKcIP0FtrvlPDTWU6mbjbIgbFHSKf+kD7nh+grmfpAL8v2KmbRhm8zxL7/J7R7t053h/GnXxZ+upMp/vpJvcJLnBnAJLlzWn2WdwRS8DTfjqBmriwe7cCb09Dp67+pqnN4RNb/sI7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497684; c=relaxed/simple;
	bh=o32z6dIuawc+cy907aPku4fhUOEpTl5pGyJZOx4r3u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYahtEtkyBaJPobtEp8PwRHpkJRe1v7xmZNAaVVye9uELvUMWfbMsXrsKdPL8uqm9vgwq2BhnzJ1QKL1ikff7QavtJICDUf1+DeZFg9fdg3BZyjZMdnuxe1LznSpAqSXqQrpK1c4EN/9Zch/Kpd+yEd6j9xsDqvnqQtm4ZL30aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JXG+A4DP; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpm6kPSzvmR;
	Thu, 20 Mar 2025 20:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497680;
	bh=ykmvepjRGXuTbOiW14n8Z+TDB99kFTkRkeI512o0QkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXG+A4DPyRNaCwxeenevxVEYtgyeJEl9LksM8TwBg3RFedf95orrJf3lmh77/vh6R
	 cGdDMCf64R9rNlQXkav8zRA173/bn9yt9tF6bwpgF3TdZgj/RXEK2KvfSNhepi8fJR
	 kJVtaW0sJhz4Ei9n7ZC3t4X+8U+I7idht/Kg3Qeo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpm0W1bzBxH;
	Thu, 20 Mar 2025 20:08:00 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 23/28] selftests/landlock: Test audit with restrict flags
Date: Thu, 20 Mar 2025 20:07:12 +0100
Message-ID: <20250320190717.2287696-24-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit_exec tests to filter Landlock denials according to
cross-execution or muted subdomains.

Add a wait-pipe-sandbox.c test program to sandbox itself and send a
(denied) signals to its parent.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Check audit_count_records() calls for audit errors.
- Simplify matches_log_fs_read_root().
- Update .gitignore

Changes since v5:
- Rename audit_exec.flags to audit_exec.signal_and_open .

Changes since v4:
- Revamp to test the Landlock syscall flags instead of the audit rules.
- Copy wait-pipe.c to wait-pipe-sandbox.c and extend it.
- Fix regex.

Changes since v3:
- New patch.
---
 tools/testing/selftests/landlock/.gitignore   |   1 +
 tools/testing/selftests/landlock/Makefile     |   6 +-
 tools/testing/selftests/landlock/audit_test.c | 219 ++++++++++++++++++
 tools/testing/selftests/landlock/common.h     |   1 +
 .../selftests/landlock/wait-pipe-sandbox.c    | 131 +++++++++++
 5 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/landlock/wait-pipe-sandbox.c

diff --git a/tools/testing/selftests/landlock/.gitignore b/tools/testing/selftests/landlock/.gitignore
index 335b2b1a3463..a820329cae0d 100644
--- a/tools/testing/selftests/landlock/.gitignore
+++ b/tools/testing/selftests/landlock/.gitignore
@@ -2,3 +2,4 @@
 /sandbox-and-launch
 /true
 /wait-pipe
+/wait-pipe-sandbox
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 5cb0828f0514..a3f449914bf9 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -10,7 +10,11 @@ src_test := $(wildcard *_test.c)
 
 TEST_GEN_PROGS := $(src_test:.c=)
 
-TEST_GEN_PROGS_EXTENDED := true sandbox-and-launch wait-pipe
+TEST_GEN_PROGS_EXTENDED := \
+	true \
+	sandbox-and-launch \
+	wait-pipe \
+	wait-pipe-sandbox
 
 # Short targets:
 $(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 59764dc18ecb..a0643070c403 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -7,7 +7,9 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
+#include <limits.h>
 #include <linux/landlock.h>
+#include <stdlib.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
@@ -329,4 +331,221 @@ TEST_F(audit_flags, signal)
 	}
 }
 
+static int matches_log_fs_read_root(int audit_fd)
+{
+	return audit_match_record(
+		audit_fd, AUDIT_LANDLOCK_ACCESS,
+		REGEX_LANDLOCK_PREFIX
+		" blockers=fs\\.read_dir path=\"/\" dev=\"[^\"]\\+\" ino=[0-9]\\+$",
+		NULL);
+}
+
+FIXTURE(audit_exec)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_VARIANT(audit_exec)
+{
+	const int restrict_flags;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_exec, default) {
+	/* clang-format on */
+	.restrict_flags = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_exec, same_exec_off) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_exec, subdomains_off) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_exec, cross_exec_on) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_exec, subdomains_off_and_cross_exec_on) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+			  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
+};
+
+FIXTURE_SETUP(audit_exec)
+{
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	self->audit_fd = audit_init();
+	EXPECT_LE(0, self->audit_fd)
+	{
+		const char *error_msg;
+
+		/* kill "$(auditctl -s | sed -ne 's/^pid \([0-9]\+\)$/\1/p')" */
+		if (self->audit_fd == -EEXIST)
+			error_msg = "socket already in use (e.g. auditd)";
+		else
+			error_msg = strerror(-self->audit_fd);
+		TH_LOG("Failed to initialize audit: %s", error_msg);
+	}
+
+	/* Applies test filter for the bin_wait_pipe_sandbox program. */
+	EXPECT_EQ(0, audit_init_filter_exe(&self->audit_filter,
+					   bin_wait_pipe_sandbox));
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter,
+				      AUDIT_ADD_RULE));
+
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN(audit_exec)
+{
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter,
+				      AUDIT_DEL_RULE));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, close(self->audit_fd));
+}
+
+TEST_F(audit_exec, signal_and_open)
+{
+	struct audit_records records;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+	pid_t child;
+	int status;
+
+	ASSERT_EQ(0, pipe2(pipe_child, 0));
+	ASSERT_EQ(0, pipe2(pipe_parent, 0));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		const struct landlock_ruleset_attr layer1 = {
+			.scoped = LANDLOCK_SCOPE_SIGNAL,
+		};
+		char pipe_child_str[12], pipe_parent_str[12];
+		char *const argv[] = { (char *)bin_wait_pipe_sandbox,
+				       pipe_child_str, pipe_parent_str, NULL };
+		int ruleset_fd;
+
+		/* Passes the pipe FDs to the executed binary. */
+		EXPECT_EQ(0, close(pipe_child[0]));
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		snprintf(pipe_child_str, sizeof(pipe_child_str), "%d",
+			 pipe_child[1]);
+		snprintf(pipe_parent_str, sizeof(pipe_parent_str), "%d",
+			 pipe_parent[0]);
+
+		ruleset_fd =
+			landlock_create_ruleset(&layer1, sizeof(layer1), 0);
+		if (ruleset_fd < 0) {
+			perror("Failed to create a ruleset");
+			_exit(1);
+		}
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd,
+					   variant->restrict_flags)) {
+			perror("Failed to restrict self");
+			_exit(1);
+		}
+		close(ruleset_fd);
+
+		ASSERT_EQ(0, execve(argv[0], argv, NULL))
+		{
+			TH_LOG("Failed to execute \"%s\": %s", argv[0],
+			       strerror(errno));
+		};
+		_exit(1);
+		return;
+	}
+
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
+
+	/* Waits for the child. */
+	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+	/* Tests that there was no denial until now. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	/*
+	 * Wait for the child to do a first denied action by layer1 and
+	 * sandbox itself with layer2.
+	 */
+	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+	/* Tests that the audit record only matches the child. */
+	if (variant->restrict_flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON) {
+		/* Matches the current domain. */
+		EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+						getpid(), NULL));
+	}
+
+	/* Checks that we didn't miss anything. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	/*
+	 * Wait for the child to do a second denied action by layer1 and
+	 * layer2, and sandbox itself with layer3.
+	 */
+	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+	/* Tests that the audit record only matches the child. */
+	if (variant->restrict_flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON) {
+		/* Matches the current domain. */
+		EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+						getpid(), NULL));
+	}
+
+	if (!(variant->restrict_flags &
+	      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+		/* Matches the child domain. */
+		EXPECT_EQ(0, matches_log_fs_read_root(self->audit_fd));
+	}
+
+	/* Checks that we didn't miss anything. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	/* Waits for the child to terminate. */
+	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+
+	/* Tests that the audit record only matches the child. */
+	if (!(variant->restrict_flags &
+	      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+		/*
+		 * Matches the child domains, which tests that the
+		 * llcred->domain_exec bitmask is correctly updated with a new
+		 * domain.
+		 */
+		EXPECT_EQ(0, matches_log_fs_read_root(self->audit_fd));
+		EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+						getpid(), NULL));
+	}
+
+	/* Checks that we didn't miss anything. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 54b6f80fc697..6e1d143ddfa7 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -31,6 +31,7 @@
 
 static const char bin_sandbox_and_launch[] = "./sandbox-and-launch";
 static const char bin_wait_pipe[] = "./wait-pipe";
+static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
 
 static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 {
diff --git a/tools/testing/selftests/landlock/wait-pipe-sandbox.c b/tools/testing/selftests/landlock/wait-pipe-sandbox.c
new file mode 100644
index 000000000000..87dbc9164430
--- /dev/null
+++ b/tools/testing/selftests/landlock/wait-pipe-sandbox.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Write in a pipe, wait, sandbox itself, test sandboxing, and wait again.
+ *
+ * Used by audit_exec.flags from audit_test.c
+ *
+ * Copyright © 2024-2025 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <linux/prctl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+
+#include "wrappers.h"
+
+static int sync_with(int pipe_child, int pipe_parent)
+{
+	char buf;
+
+	/* Signals that we are waiting. */
+	if (write(pipe_child, ".", 1) != 1) {
+		perror("Failed to write to first argument");
+		return 1;
+	}
+
+	/* Waits for the parent do its test. */
+	if (read(pipe_parent, &buf, 1) != 1) {
+		perror("Failed to write to the second argument");
+		return 1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	const struct landlock_ruleset_attr layer2 = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	const struct landlock_ruleset_attr layer3 = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+	int err, pipe_child, pipe_parent, ruleset_fd;
+
+	/* The first argument must be the file descriptor number of a pipe. */
+	if (argc != 3) {
+		fprintf(stderr, "Wrong number of arguments (not two)\n");
+		return 1;
+	}
+
+	pipe_child = atoi(argv[1]);
+	pipe_parent = atoi(argv[2]);
+	/* PR_SET_NO_NEW_PRIVS already set by parent. */
+
+	/* First step to test parent's layer1. */
+	err = sync_with(pipe_child, pipe_parent);
+	if (err)
+		return err;
+
+	/* Tries to send a signal, denied by layer1. */
+	if (!kill(getppid(), 0)) {
+		fprintf(stderr, "Successfully sent a signal to the parent");
+		return 1;
+	}
+
+	/* Second step to test parent's layer1 and our layer2. */
+	err = sync_with(pipe_child, pipe_parent);
+	if (err)
+		return err;
+
+	ruleset_fd = landlock_create_ruleset(&layer2, sizeof(layer2), 0);
+	if (ruleset_fd < 0) {
+		perror("Failed to create the layer2 ruleset");
+		return 1;
+	}
+
+	if (landlock_restrict_self(ruleset_fd, 0)) {
+		perror("Failed to restrict self");
+		return 1;
+	}
+	close(ruleset_fd);
+
+	/* Tries to send a signal, denied by layer1. */
+	if (!kill(getppid(), 0)) {
+		fprintf(stderr, "Successfully sent a signal to the parent");
+		return 1;
+	}
+
+	/* Tries to open ., denied by layer2. */
+	if (open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC) >= 0) {
+		fprintf(stderr, "Successfully opened /");
+		return 1;
+	}
+
+	/* Third step to test our layer2 and layer3. */
+	err = sync_with(pipe_child, pipe_parent);
+	if (err)
+		return err;
+
+	ruleset_fd = landlock_create_ruleset(&layer3, sizeof(layer3), 0);
+	if (ruleset_fd < 0) {
+		perror("Failed to create the layer3 ruleset");
+		return 1;
+	}
+
+	if (landlock_restrict_self(ruleset_fd, 0)) {
+		perror("Failed to restrict self");
+		return 1;
+	}
+	close(ruleset_fd);
+
+	/* Tries to open ., denied by layer2. */
+	if (open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC) >= 0) {
+		fprintf(stderr, "Successfully opened /");
+		return 1;
+	}
+
+	/* Tries to send a signal, denied by layer3. */
+	if (!kill(getppid(), 0)) {
+		fprintf(stderr, "Successfully sent a signal to the parent");
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.49.0


