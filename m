Return-Path: <linux-security-module+bounces-2339-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289DB88E680
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 15:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD522C4120
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710C15699D;
	Wed, 27 Mar 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcKkpfqx"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027A156C4D
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545054; cv=none; b=KfYxhGduoFs1Jq0QKGdfftv9dsfbI3kc8gpu0wKWX2hojj/DlfYQtlfAIVv4q9nYD0xZPqMkPgUq60tR0YFPdw3o8O+ExUtaz9VuqxyIkpqCcUTx3R20BfQ/o5a8sSE36uBRt+I5CpoMT05MR8ZjXgDmu9aGDv8KNm/2J6IuozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545054; c=relaxed/simple;
	bh=69+sBAT5DFQPj/FsWeM9JXAWrYVQRS6u6SuX1nKaQzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AaRyIXEzRju/uSaY7yYOLPB/ZuolZbvY4ztH7HpTd7MQNo3sJh/4prynIrD9os0tqxi0BykiqogpnmxlhfQdeaUTkhopmo3tHL9Ksmui94z7QntruwParKpJmB9VsgQ4TvP0ij9/Ir4gCVjmPwTgk8UZi/AVJb4nqX8kxLg4diI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcKkpfqx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so11965197276.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545049; x=1712149849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XgsbOK+COBH2/F6qwPzuov0zyvzGSIEZS2/NwxKHec=;
        b=IcKkpfqxH/SVJmm7C7+wqwqJ34ByzDtT2CfsakdsGYrXseOIARooDfrpH2Tw0oRVx4
         qe8EjqSfuOHw/O4FuatE+dVYyImX7kJuBkBdyyEblOmvxfSOAFsBk/nwrULIFDyVJVfD
         K/NzTVnOo1pQq5OVCJkYdUWm2S/aTPnMpgsfr5sn5Sg8Ry6tyZuQPOEbtlXUj2RNvKht
         K6zss8DdLAUtSbaq7dOlnw2sq4BWbA7lCMCtAUXQNYI3dyvyC7erbl4LOzU0hpyTlYvV
         q12CuliDdjtNdSNZaiWPaxN945XWg7NwvbG9zTIrfv0o/ESF9Jxj1P0GkWo3LLMg+/EN
         wE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545049; x=1712149849;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0XgsbOK+COBH2/F6qwPzuov0zyvzGSIEZS2/NwxKHec=;
        b=FP2NLpit1rXCzjVKXE/WttKg3053XLQs9mm0z2p6jP8GJ8gU0Lgw7dwrB+nBOCQPZu
         XB8vFuDE6lMrMXyXNdO6hZ73nYXYcbGLTiP4v7X8OX4xlkAV4y/MB7Y+vM/CgLjXED/q
         vJiOFSMSW2oK7i+dJJq09SjnKNuNMOlaHCs26m4m3MR5I3XjoFJMqsILILo8PZIIhpa2
         QYIEfc4/WxyCArUB4G3V9GCqpgye9aQtgVA4I7PZwZbth3qdq+fncBBGBhm4VcsmH4mQ
         pswHMigNXiyF/7zR/JurTd9g3jkmjHD/o9trMfJ4NBgK7R+37r7SqKZyVTHkMUBu6QVh
         OWLQ==
X-Gm-Message-State: AOJu0Yw9V6m+7X2nQgNS3He6Owm6qeXdVuZu3WXOab5+x6RqDQGOGMpi
	5FIQhOgsNmJDp0U9RpA9RFCLkFFtvW1sbtHMSuPxVIfywW13o9/mMhzTU5+l5PuRZ6ztDLPETAW
	9gC0XMwI+OS/2P1sf0hB62A4I6mBRR/rf1R7ngK3fPrpdi0+OQJ8Rhp13gY4bGipMSUme6yGu9H
	79UNbmDLVPK+AdSFjjGppgmPs993QE22aeqV/FicMm6NhBujVr6mcm
X-Google-Smtp-Source: AGHT+IGE3Bu7JafeRuLXGnsYHtnrsil/NXBaMuLFq0Sp5uMgD5dAvIhIw01ZLRbiLMshQtN8kgtcxxyhwKo=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:90e:b0:dc7:7ce9:fb4d with SMTP id
 bu14-20020a056902090e00b00dc77ce9fb4dmr3949639ybb.12.1711545049578; Wed, 27
 Mar 2024 06:10:49 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:32 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-3-gnoack@google.com>
Subject: [PATCH v13 02/10] selftests/landlock: Test IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Exercises Landlock's IOCTL feature in different combinations of
handling and permitting the LANDLOCK_ACCESS_FS_IOCTL_DEV right, and in
different combinations of using files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 227 ++++++++++++++++++++-
 1 file changed, 224 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 418ad745a5dd..8a72e26d4977 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -8,6 +8,7 @@
  */
=20
 #define _GNU_SOURCE
+#include <asm/termbits.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
@@ -15,6 +16,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/capability.h>
+#include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/sendfile.h>
@@ -23,6 +25,12 @@
 #include <sys/vfs.h>
 #include <unistd.h>
=20
+/*
+ * Intentionally included last to work around header conflict.
+ * See https://sourceware.org/glibc/wiki/Synchronizing_Headers.
+ */
+#include <linux/fs.h>
+
 #include "common.h"
=20
 #ifndef renameat2
@@ -737,6 +745,9 @@ static int create_ruleset(struct __test_metadata *const=
 _metadata,
 	}
=20
 	for (i =3D 0; rules[i].path; i++) {
+		if (!rules[i].access)
+			continue;
+
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
 				 rules[i].path);
 	}
@@ -3445,7 +3456,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3528,7 +3539,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3754,7 +3765,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3831,6 +3842,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
+/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
+static int test_fs_ioc_getflags_ioctl(int fd)
+{
+	uint32_t flags;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
+		return errno;
+	return 0;
+}
+
 TEST(memfd_ftruncate)
 {
 	int fd;
@@ -3847,6 +3868,206 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+/* clang-format off */
+FIXTURE(ioctl) {};
+
+FIXTURE_SETUP(ioctl) {};
+
+FIXTURE_TEARDOWN(ioctl) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(ioctl)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const mode_t open_mode;
+	/*
+	 * TCGETS is used as a characteristic device-specific IOCTL command.
+	 * The logic is the same for other IOCTL commands as well.
+	 */
+	const int expected_tcgets_result; /* terminal device IOCTL */
+	/*
+	 * FIONREAD is implemented in fs/ioctl.c for regular files,
+	 * but we do not blanket-permit it for devices.
+	 */
+	const int expected_fionread_result;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D 0,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+static int test_tcgets_ioctl(int fd)
+{
+	struct termios info;
+
+	if (ioctl(fd, TCGETS, &info) < 0)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev",
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open("/dev/tty", variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/* Checks that IOCTL commands return the expected errors. */
+	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev",
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int dir_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Ignore variant->open_mode for this test, as we intend to open a
+	 * directory.  If the directory can not be opened, the variant is
+	 * infeasible to test with an opened directory.
+	 */
+	dir_fd =3D open("/dev", O_RDONLY);
+	if (dir_fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands return the expected errors.
+	 * We do not use the expected values from the fixture here.
+	 *
+	 * When using IOCTL on a directory, no Landlock restrictions apply.
+	 * TCGETS will fail anyway because it is not invoked on a TTY device.
+	 */
+	EXPECT_EQ(ENOTTY, test_tcgets_ioctl(dir_fd));
+	EXPECT_EQ(0, test_fionread_ioctl(dir_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIGETBSZ, &flag));
+
+	ASSERT_EQ(0, close(dir_fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev/tty0",
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
+		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
+			     "can not be granted on files");
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open("/dev/tty0", variant->open_mode);
+	ASSERT_LE(0, file_fd)
+	{
+		TH_LOG("Failed to open /dev/tty0: %s", strerror(errno));
+	}
+
+	/* Checks that IOCTL commands return the expected errors. */
+	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.44.0.396.g6e790dbe36-goog


