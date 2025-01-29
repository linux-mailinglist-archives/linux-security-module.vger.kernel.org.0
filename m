Return-Path: <linux-security-module+bounces-8004-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C3A22551
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jan 2025 22:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE541648CC
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jan 2025 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FF1E3DD3;
	Wed, 29 Jan 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSrV9KrH"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D27081B;
	Wed, 29 Jan 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184421; cv=none; b=LYcWubxP8wMDi9E3eOx2E/adyg3MCgTgI7MYNlkNukuCVdVS/W9WdSIs10/gz1+lBrbLWfU2bOfpQTUgkYmLgg/mPGns4vW0q8Tg0rXfQ9+F/jGZxZ9ajphjyFCPjIpwyp3iGNsuBxh3XKknWTDEnPl/CA7N+SmScAvN+HP5xGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184421; c=relaxed/simple;
	bh=TPkgZIxI5mjdipacolcuCkx+yEJCZweLTQb3sPFeay4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fywg/tLFXuV0rdjYXbhve/LJxG7sLYZYY6fkptmhyKC5pdxJlw74owteCnUlwOvi+3cDdFImddGpynfsQAulYftq8NBpD9QesqzaWfdgJlCU9h5hvdswQd8XiJC99lR4rnrIqjCAtypABM+tO3kbgEr2JRbBa7BUPW+fUzB8SGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSrV9KrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24388C4CED3;
	Wed, 29 Jan 2025 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184420;
	bh=TPkgZIxI5mjdipacolcuCkx+yEJCZweLTQb3sPFeay4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSrV9KrHGidnH/Z5V48rZ2USVE5o4Kh3X9yRS26NsP/2SS+MHzWAcDvnmp/FFjBK3
	 mZji1hb1wu0WZql7sC8YSKJofhX6JQrgWHMUCix6tadNav0eFGEnpbLIfneIbxGJhN
	 EzqPX028O0VALUnoyrja7aFJY8THO1W8DlJRhzTlgavGBXCXm/H80adEHWFoqYIkJS
	 1SFKJUJZiWWZh/N3mgfiMzU+9lwgZ8V2R41UFl4Lzr8lpZQQI7x31hc3/QbTxK6QYW
	 pDz9XIlUPFLJXA5ei8UlnJqqekfLg39zylOm0Cgx9g4s4F3c6sbwaRT2u2HpAyDcgO
	 0xMRSjN9RZqQQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v11 bpf-next 2/7] selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr names
Date: Wed, 29 Jan 2025 12:59:52 -0800
Message-ID: <20250129205957.2457655-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250129205957.2457655-1-song@kernel.org>
References: <20250129205957.2457655-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend test_progs fs_kfuncs to cover different xattr names. Specifically:
xattr name "user.kfuncs" and "security.bpf.xxx" can be read from BPF
program with kfuncs bpf_get_[file|dentry]_xattr(); while "security.bpf"
and "security.selinux" cannot be read.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 37 ++++++++++++++-----
 .../selftests/bpf/progs/test_get_xattr.c      | 28 ++++++++++++--
 2 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 5a0b51157451..419f45b56472 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -12,7 +12,7 @@
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
-static void test_xattr(void)
+static void test_get_xattr(const char *name, const char *value, bool allow_access)
 {
 	struct test_get_xattr *skel = NULL;
 	int fd = -1, err;
@@ -25,7 +25,7 @@ static void test_xattr(void)
 	close(fd);
 	fd = -1;
 
-	err = setxattr(testfile, "user.kfuncs", "hello", sizeof("hello"), 0);
+	err = setxattr(testfile, name, value, strlen(value) + 1, 0);
 	if (err && errno == EOPNOTSUPP) {
 		printf("%s:SKIP:local fs doesn't support xattr (%d)\n"
 		       "To run this test, make sure /tmp filesystem supports xattr.\n",
@@ -48,16 +48,23 @@ static void test_xattr(void)
 		goto out;
 
 	fd = open(testfile, O_RDONLY, 0644);
+
 	if (!ASSERT_GE(fd, 0, "open_file"))
 		goto out;
 
-	ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
-
 	/* Trigger security_inode_getxattr */
-	err = getxattr(testfile, "user.kfuncs", v, sizeof(v));
-	ASSERT_EQ(err, -1, "getxattr_return");
-	ASSERT_EQ(errno, EINVAL, "getxattr_errno");
-	ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
+	err = getxattr(testfile, name, v, sizeof(v));
+
+	if (allow_access) {
+		ASSERT_EQ(err, -1, "getxattr_return");
+		ASSERT_EQ(errno, EINVAL, "getxattr_errno");
+		ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
+		ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
+	} else {
+		ASSERT_EQ(err, strlen(value) + 1, "getxattr_return");
+		ASSERT_EQ(skel->bss->found_xattr_from_file, 0, "found_xattr_from_file");
+		ASSERT_EQ(skel->bss->found_xattr_from_dentry, 0, "found_xattr_from_dentry");
+	}
 
 out:
 	close(fd);
@@ -141,8 +148,18 @@ static void test_fsverity(void)
 
 void test_fs_kfuncs(void)
 {
-	if (test__start_subtest("xattr"))
-		test_xattr();
+	/* Matches xattr_names in progs/test_get_xattr.c */
+	if (test__start_subtest("user_xattr"))
+		test_get_xattr("user.kfuncs", "hello", true);
+
+	if (test__start_subtest("security_bpf_xattr"))
+		test_get_xattr("security.bpf.xxx", "hello", true);
+
+	if (test__start_subtest("security_bpf_xattr_error"))
+		test_get_xattr("security.bpf", "hello", false);
+
+	if (test__start_subtest("security_selinux_xattr_error"))
+		test_get_xattr("security.selinux", "hello", false);
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
index 66e737720f7c..54305f4c9f2d 100644
--- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_kfuncs.h"
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -17,12 +18,23 @@ static const char expected_value[] = "hello";
 char value1[32];
 char value2[32];
 
+/* Matches caller of test_get_xattr() in prog_tests/fs_kfuncs.c */
+static const char xattr_names[][64] = {
+	/* The following work. */
+	"user.kfuncs",
+	"security.bpf.xxx",
+
+	/* The following do not work. */
+	"security.bpf",
+	"security.selinux"
+};
+
 SEC("lsm.s/file_open")
 int BPF_PROG(test_file_open, struct file *f)
 {
 	struct bpf_dynptr value_ptr;
 	__u32 pid;
-	int ret;
+	int ret, i;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
 	if (pid != monitored_pid)
@@ -30,7 +42,11 @@ int BPF_PROG(test_file_open, struct file *f)
 
 	bpf_dynptr_from_mem(value1, sizeof(value1), 0, &value_ptr);
 
-	ret = bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
+	for (i = 0; i < ARRAY_SIZE(xattr_names); i++) {
+		ret = bpf_get_file_xattr(f, xattr_names[i], &value_ptr);
+		if (ret == sizeof(expected_value))
+			break;
+	}
 	if (ret != sizeof(expected_value))
 		return 0;
 	if (bpf_strncmp(value1, ret, expected_value))
@@ -44,7 +60,7 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
 {
 	struct bpf_dynptr value_ptr;
 	__u32 pid;
-	int ret;
+	int ret, i;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
 	if (pid != monitored_pid)
@@ -52,7 +68,11 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
 
 	bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
 
-	ret = bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);
+	for (i = 0; i < ARRAY_SIZE(xattr_names); i++) {
+		ret = bpf_get_dentry_xattr(dentry, xattr_names[i], &value_ptr);
+		if (ret == sizeof(expected_value))
+			break;
+	}
 	if (ret != sizeof(expected_value))
 		return 0;
 	if (bpf_strncmp(value2, ret, expected_value))
-- 
2.43.5


