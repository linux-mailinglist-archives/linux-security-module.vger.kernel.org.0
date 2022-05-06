Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638E351DCD5
	for <lists+linux-security-module@lfdr.de>; Fri,  6 May 2022 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443381AbiEFQHs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 May 2022 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443372AbiEFQHp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 12:07:45 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E06D951
        for <linux-security-module@vger.kernel.org>; Fri,  6 May 2022 09:03:53 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNS0WYJzMqHqK;
        Fri,  6 May 2022 18:03:52 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNR4xNYzljsTZ;
        Fri,  6 May 2022 18:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853032;
        bh=fPn/ypiifbsOvoNiZVIp7cpEr1n7nRA+kXLb91MpBbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/noaBgjC5OkhmMeyUJr9jsmFW+d25p2/0axvufZFddwBx+XiD6jOwSlAhsBrUA1i
         9cGDwboo/5Q60pQAG/xrR8EUL6fJfe/faB9mQI/EdzKT1JZvQrTqlMz9MrqKBhN/U6
         BKQCu3dpNFFUwGtns1QNMNhCe8tLSiFOx+Puo4RQ=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 5/7] selftests/landlock: Format with clang-format
Date:   Fri,  6 May 2022 18:05:11 +0200
Message-Id: <20220506160513.523257-6-mic@digikod.net>
In-Reply-To: <20220506160513.523257-1-mic@digikod.net>
References: <20220506160513.523257-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Let's follow a consistent and documented coding style.  Everything may
not be to our liking but it is better than tacit knowledge.  Moreover,
this will help maintain style consistency between different developers.

This contains only whitespace changes.

Automatically formatted with:
clang-format-14 -i tools/testing/selftests/landlock/*.[ch]

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-6-mic@digikod.net
---
 tools/testing/selftests/landlock/base_test.c  |  80 ++--
 tools/testing/selftests/landlock/common.h     |  64 +--
 tools/testing/selftests/landlock/fs_test.c    | 399 ++++++++++--------
 .../testing/selftests/landlock/ptrace_test.c  |  18 +-
 4 files changed, 310 insertions(+), 251 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index ca40abe9daa8..3faeae4233a4 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -18,10 +18,11 @@
 #include "common.h"
 
 #ifndef O_PATH
-#define O_PATH		010000000
+#define O_PATH 010000000
 #endif
 
-TEST(inconsistent_attr) {
+TEST(inconsistent_attr)
+{
 	const long page_size = sysconf(_SC_PAGESIZE);
 	char *const buf = malloc(page_size + 1);
 	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
@@ -39,15 +40,16 @@ TEST(inconsistent_attr) {
 	/* The size if less than sizeof(struct landlock_attr_enforce). */
 	ASSERT_EQ(EFAULT, errno);
 
-	ASSERT_EQ(-1, landlock_create_ruleset(NULL,
-				sizeof(struct landlock_ruleset_attr), 0));
+	ASSERT_EQ(-1, landlock_create_ruleset(
+			      NULL, sizeof(struct landlock_ruleset_attr), 0));
 	ASSERT_EQ(EFAULT, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
 	ASSERT_EQ(E2BIG, errno);
 
-	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr,
-				sizeof(struct landlock_ruleset_attr), 0));
+	ASSERT_EQ(-1, landlock_create_ruleset(
+			      ruleset_attr,
+			      sizeof(struct landlock_ruleset_attr), 0));
 	ASSERT_EQ(ENOMSG, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
 	ASSERT_EQ(ENOMSG, errno);
@@ -63,32 +65,35 @@ TEST(inconsistent_attr) {
 	free(buf);
 }
 
-TEST(abi_version) {
+TEST(abi_version)
+{
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
 	ASSERT_EQ(1, landlock_create_ruleset(NULL, 0,
-				LANDLOCK_CREATE_RULESET_VERSION));
+					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-				LANDLOCK_CREATE_RULESET_VERSION));
+					      LANDLOCK_CREATE_RULESET_VERSION));
 	ASSERT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
-				LANDLOCK_CREATE_RULESET_VERSION));
+					      LANDLOCK_CREATE_RULESET_VERSION));
 	ASSERT_EQ(EINVAL, errno);
 
-	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
-				sizeof(ruleset_attr),
-				LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(-1,
+		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
+					  LANDLOCK_CREATE_RULESET_VERSION));
 	ASSERT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
-				LANDLOCK_CREATE_RULESET_VERSION | 1 << 31));
+					      LANDLOCK_CREATE_RULESET_VERSION |
+						      1 << 31));
 	ASSERT_EQ(EINVAL, errno);
 }
 
-TEST(inval_create_ruleset_flags) {
+TEST(inval_create_ruleset_flags)
+{
 	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
 	const int invalid_flag = last_flag << 1;
 	const struct landlock_ruleset_attr ruleset_attr = {
@@ -102,38 +107,42 @@ TEST(inval_create_ruleset_flags) {
 	ASSERT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
-				invalid_flag));
+					      invalid_flag));
 	ASSERT_EQ(EINVAL, errno);
 
-	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
-				sizeof(ruleset_attr), invalid_flag));
+	ASSERT_EQ(-1,
+		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
+					  invalid_flag));
 	ASSERT_EQ(EINVAL, errno);
 }
 
-TEST(empty_path_beneath_attr) {
+TEST(empty_path_beneath_attr)
+{
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Similar to struct landlock_path_beneath_attr.parent_fd = 0 */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				NULL, 0));
+					NULL, 0));
 	ASSERT_EQ(EFAULT, errno);
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
-TEST(inval_fd_enforce) {
+TEST(inval_fd_enforce)
+{
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	ASSERT_EQ(EBADF, errno);
 }
 
-TEST(unpriv_enforce_without_no_new_privs) {
+TEST(unpriv_enforce_without_no_new_privs)
+{
 	int err;
 
 	drop_caps(_metadata);
@@ -151,8 +160,8 @@ TEST(ruleset_fd_io)
 	char buf;
 
 	drop_caps(_metadata);
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(-1, write(ruleset_fd, ".", 1));
@@ -197,14 +206,15 @@ TEST(ruleset_fd_transfer)
 	drop_caps(_metadata);
 
 	/* Creates a test ruleset with a simple rule. */
-	ruleset_fd_tx = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	ruleset_fd_tx =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd_tx);
-	path_beneath_attr.parent_fd = open("/tmp", O_PATH | O_NOFOLLOW |
-			O_DIRECTORY | O_CLOEXEC);
+	path_beneath_attr.parent_fd =
+		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
-	ASSERT_EQ(0, landlock_add_rule(ruleset_fd_tx, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath_attr, 0));
+	ASSERT_EQ(0,
+		  landlock_add_rule(ruleset_fd_tx, LANDLOCK_RULE_PATH_BENEATH,
+				    &path_beneath_attr, 0));
 	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
 
 	cmsg = CMSG_FIRSTHDR(&msg);
@@ -215,7 +225,8 @@ TEST(ruleset_fd_transfer)
 	memcpy(CMSG_DATA(cmsg), &ruleset_fd_tx, sizeof(ruleset_fd_tx));
 
 	/* Sends the ruleset FD over a socketpair and then close it. */
-	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, socket_fds));
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
+				socket_fds));
 	ASSERT_EQ(sizeof(data_tx), sendmsg(socket_fds[0], &msg, 0));
 	ASSERT_EQ(0, close(socket_fds[0]));
 	ASSERT_EQ(0, close(ruleset_fd_tx));
@@ -226,7 +237,8 @@ TEST(ruleset_fd_transfer)
 		int ruleset_fd_rx;
 
 		*(char *)msg.msg_iov->iov_base = '\0';
-		ASSERT_EQ(sizeof(data_tx), recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
+		ASSERT_EQ(sizeof(data_tx),
+			  recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
 		ASSERT_EQ('.', *(char *)msg.msg_iov->iov_base);
 		ASSERT_EQ(0, close(socket_fds[1]));
 		cmsg = CMSG_FIRSTHDR(&msg);
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 435ba6963756..7ba18eb23783 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -75,9 +75,9 @@
 /* clang-format on */
 
 #ifndef landlock_create_ruleset
-static inline int landlock_create_ruleset(
-		const struct landlock_ruleset_attr *const attr,
-		const size_t size, const __u32 flags)
+static inline int
+landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
+			const size_t size, const __u32 flags)
 {
 	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
 }
@@ -85,17 +85,18 @@ static inline int landlock_create_ruleset(
 
 #ifndef landlock_add_rule
 static inline int landlock_add_rule(const int ruleset_fd,
-		const enum landlock_rule_type rule_type,
-		const void *const rule_attr, const __u32 flags)
+				    const enum landlock_rule_type rule_type,
+				    const void *const rule_attr,
+				    const __u32 flags)
 {
-	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type,
-			rule_attr, flags);
+	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_attr,
+		       flags);
 }
 #endif
 
 #ifndef landlock_restrict_self
 static inline int landlock_restrict_self(const int ruleset_fd,
-		const __u32 flags)
+					 const __u32 flags)
 {
 	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
 }
@@ -113,69 +114,76 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 	};
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p) {
+	EXPECT_NE(NULL, cap_p)
+	{
 		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
 	}
-	EXPECT_NE(-1, cap_clear(cap_p)) {
+	EXPECT_NE(-1, cap_clear(cap_p))
+	{
 		TH_LOG("Failed to cap_clear: %s", strerror(errno));
 	}
 	if (!drop_all) {
 		EXPECT_NE(-1, cap_set_flag(cap_p, CAP_PERMITTED,
-					ARRAY_SIZE(caps), caps, CAP_SET)) {
+					   ARRAY_SIZE(caps), caps, CAP_SET))
+		{
 			TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
 		}
 	}
-	EXPECT_NE(-1, cap_set_proc(cap_p)) {
+	EXPECT_NE(-1, cap_set_proc(cap_p))
+	{
 		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
 	}
-	EXPECT_NE(-1, cap_free(cap_p)) {
+	EXPECT_NE(-1, cap_free(cap_p))
+	{
 		TH_LOG("Failed to cap_free: %s", strerror(errno));
 	}
 }
 
 /* We cannot put such helpers in a library because of kselftest_harness.h . */
-__attribute__((__unused__))
-static void disable_caps(struct __test_metadata *const _metadata)
+__attribute__((__unused__)) static void
+disable_caps(struct __test_metadata *const _metadata)
 {
 	_init_caps(_metadata, false);
 }
 
-__attribute__((__unused__))
-static void drop_caps(struct __test_metadata *const _metadata)
+__attribute__((__unused__)) static void
+drop_caps(struct __test_metadata *const _metadata)
 {
 	_init_caps(_metadata, true);
 }
 
 static void _effective_cap(struct __test_metadata *const _metadata,
-		const cap_value_t caps, const cap_flag_value_t value)
+			   const cap_value_t caps, const cap_flag_value_t value)
 {
 	cap_t cap_p;
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p) {
+	EXPECT_NE(NULL, cap_p)
+	{
 		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
 	}
-	EXPECT_NE(-1, cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &caps, value)) {
+	EXPECT_NE(-1, cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &caps, value))
+	{
 		TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
 	}
-	EXPECT_NE(-1, cap_set_proc(cap_p)) {
+	EXPECT_NE(-1, cap_set_proc(cap_p))
+	{
 		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
 	}
-	EXPECT_NE(-1, cap_free(cap_p)) {
+	EXPECT_NE(-1, cap_free(cap_p))
+	{
 		TH_LOG("Failed to cap_free: %s", strerror(errno));
 	}
 }
 
-__attribute__((__unused__))
-static void set_cap(struct __test_metadata *const _metadata,
-		const cap_value_t caps)
+__attribute__((__unused__)) static void
+set_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
 {
 	_effective_cap(_metadata, caps, CAP_SET);
 }
 
-__attribute__((__unused__))
-static void clear_cap(struct __test_metadata *const _metadata,
-		const cap_value_t caps)
+__attribute__((__unused__)) static void
+clear_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
 {
 	_effective_cap(_metadata, caps, CAP_CLEAR);
 }
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 198184ca0396..28b01cb30c78 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -22,8 +22,8 @@
 
 #include "common.h"
 
-#define TMP_DIR		"tmp"
-#define BINARY_PATH	"./true"
+#define TMP_DIR "tmp"
+#define BINARY_PATH "./true"
 
 /* Paths (sibling number and depth) */
 static const char dir_s1d1[] = TMP_DIR "/s1d1";
@@ -75,7 +75,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
  */
 
 static void mkdir_parents(struct __test_metadata *const _metadata,
-		const char *const path)
+			  const char *const path)
 {
 	char *walker;
 	const char *parent;
@@ -90,9 +90,10 @@ static void mkdir_parents(struct __test_metadata *const _metadata,
 			continue;
 		walker[i] = '\0';
 		err = mkdir(parent, 0700);
-		ASSERT_FALSE(err && errno != EEXIST) {
-			TH_LOG("Failed to create directory \"%s\": %s",
-					parent, strerror(errno));
+		ASSERT_FALSE(err && errno != EEXIST)
+		{
+			TH_LOG("Failed to create directory \"%s\": %s", parent,
+			       strerror(errno));
 		}
 		walker[i] = '/';
 	}
@@ -100,22 +101,24 @@ static void mkdir_parents(struct __test_metadata *const _metadata,
 }
 
 static void create_directory(struct __test_metadata *const _metadata,
-		const char *const path)
+			     const char *const path)
 {
 	mkdir_parents(_metadata, path);
-	ASSERT_EQ(0, mkdir(path, 0700)) {
+	ASSERT_EQ(0, mkdir(path, 0700))
+	{
 		TH_LOG("Failed to create directory \"%s\": %s", path,
-				strerror(errno));
+		       strerror(errno));
 	}
 }
 
 static void create_file(struct __test_metadata *const _metadata,
-		const char *const path)
+			const char *const path)
 {
 	mkdir_parents(_metadata, path);
-	ASSERT_EQ(0, mknod(path, S_IFREG | 0700, 0)) {
+	ASSERT_EQ(0, mknod(path, S_IFREG | 0700, 0))
+	{
 		TH_LOG("Failed to create file \"%s\": %s", path,
-				strerror(errno));
+		       strerror(errno));
 	}
 }
 
@@ -243,7 +246,8 @@ FIXTURE_TEARDOWN(layout1)
  * This helper enables to use the ASSERT_* macros and print the line number
  * pointing to the test caller.
  */
-static int test_open_rel(const int dirfd, const char *const path, const int flags)
+static int test_open_rel(const int dirfd, const char *const path,
+			 const int flags)
 {
 	int fd;
 
@@ -292,23 +296,23 @@ TEST_F_FORK(layout1, inval)
 {
 	struct landlock_path_beneath_attr path_beneath = {
 		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		.parent_fd = -1,
 	};
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_WRITE_FILE,
+				     LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 	int ruleset_fd;
 
-	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
-			O_CLOEXEC);
+	path_beneath.parent_fd =
+		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd);
 
 	ruleset_fd = open(dir_s1d1, O_PATH | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	/* Returns EBADF because ruleset_fd is not a landlock-ruleset FD. */
 	ASSERT_EQ(EBADF, errno);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -316,55 +320,55 @@ TEST_F_FORK(layout1, inval)
 	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
 	ASSERT_EQ(EBADFD, errno);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	/* Gets a real ruleset. */
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+				       &path_beneath, 0));
 	ASSERT_EQ(0, close(path_beneath.parent_fd));
 
 	/* Tests without O_PATH. */
 	path_beneath.parent_fd = open(dir_s1d2, O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+				       &path_beneath, 0));
 	ASSERT_EQ(0, close(path_beneath.parent_fd));
 
 	/* Tests with a ruleset FD. */
 	path_beneath.parent_fd = ruleset_fd;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	ASSERT_EQ(EBADFD, errno);
 
 	/* Checks unhandled allowed_access. */
-	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
-			O_CLOEXEC);
+	path_beneath.parent_fd =
+		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd);
 
 	/* Test with legitimate values. */
 	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	ASSERT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
 
 	/* Test with unknown (64-bits) value. */
 	path_beneath.allowed_access |= (1ULL << 60);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	ASSERT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
 	/* Test with no access. */
 	path_beneath.allowed_access = 0;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	ASSERT_EQ(ENOMSG, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
@@ -409,8 +413,8 @@ TEST_F_FORK(layout1, file_access_rights)
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = ACCESS_ALL,
 	};
-	const int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -420,7 +424,7 @@ TEST_F_FORK(layout1, file_access_rights)
 	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
 		path_beneath.allowed_access = access;
 		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0);
+					&path_beneath, 0);
 		if ((access | ACCESS_FILE) == ACCESS_FILE) {
 			ASSERT_EQ(0, err);
 		} else {
@@ -432,22 +436,24 @@ TEST_F_FORK(layout1, file_access_rights)
 }
 
 static void add_path_beneath(struct __test_metadata *const _metadata,
-		const int ruleset_fd, const __u64 allowed_access,
-		const char *const path)
+			     const int ruleset_fd, const __u64 allowed_access,
+			     const char *const path)
 {
 	struct landlock_path_beneath_attr path_beneath = {
 		.allowed_access = allowed_access,
 	};
 
 	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
-	ASSERT_LE(0, path_beneath.parent_fd) {
+	ASSERT_LE(0, path_beneath.parent_fd)
+	{
 		TH_LOG("Failed to open directory \"%s\": %s", path,
-				strerror(errno));
+		       strerror(errno));
 	}
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0)) {
+				       &path_beneath, 0))
+	{
 		TH_LOG("Failed to update the ruleset with \"%s\": %s", path,
-				strerror(errno));
+		       strerror(errno));
 	}
 	ASSERT_EQ(0, close(path_beneath.parent_fd));
 }
@@ -470,38 +476,43 @@ struct rule {
 /* clang-format on */
 
 static int create_ruleset(struct __test_metadata *const _metadata,
-		const __u64 handled_access_fs, const struct rule rules[])
+			  const __u64 handled_access_fs,
+			  const struct rule rules[])
 {
 	int ruleset_fd, i;
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = handled_access_fs,
 	};
 
-	ASSERT_NE(NULL, rules) {
+	ASSERT_NE(NULL, rules)
+	{
 		TH_LOG("No rule list");
 	}
-	ASSERT_NE(NULL, rules[0].path) {
+	ASSERT_NE(NULL, rules[0].path)
+	{
 		TH_LOG("Empty rule list");
 	}
 
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
-	ASSERT_LE(0, ruleset_fd) {
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd)
+	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
 
 	for (i = 0; rules[i].path; i++) {
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
-				rules[i].path);
+				 rules[i].path);
 	}
 	return ruleset_fd;
 }
 
 static void enforce_ruleset(struct __test_metadata *const _metadata,
-		const int ruleset_fd)
+			    const int ruleset_fd)
 {
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0)) {
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
+	{
 		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
 	}
 }
@@ -512,13 +523,14 @@ TEST_F_FORK(layout1, proc_nsfs)
 		{
 			.path = "/dev/null",
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{},
 	};
 	struct landlock_path_beneath_attr path_beneath;
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access |
-			LANDLOCK_ACCESS_FS_READ_DIR, rules);
+	const int ruleset_fd = create_ruleset(
+		_metadata, rules[0].access | LANDLOCK_ACCESS_FS_READ_DIR,
+		rules);
 
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
@@ -545,16 +557,17 @@ TEST_F_FORK(layout1, proc_nsfs)
 	 * references to a ruleset.
 	 */
 	path_beneath.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
-		LANDLOCK_ACCESS_FS_WRITE_FILE,
+				      LANDLOCK_ACCESS_FS_WRITE_FILE,
 	path_beneath.parent_fd = open("/proc/self/ns/mnt", O_PATH | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				&path_beneath, 0));
+					&path_beneath, 0));
 	ASSERT_EQ(EBADFD, errno);
 	ASSERT_EQ(0, close(path_beneath.parent_fd));
 }
 
-TEST_F_FORK(layout1, unpriv) {
+TEST_F_FORK(layout1, unpriv)
+{
 	const struct rule rules[] = {
 		{
 			.path = dir_s1d2,
@@ -586,7 +599,7 @@ TEST_F_FORK(layout1, effective_access)
 		{
 			.path = file1_s2d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{},
 	};
@@ -662,12 +675,12 @@ TEST_F_FORK(layout1, ruleset_overlap)
 		{
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_READ_DIR,
+				  LANDLOCK_ACCESS_FS_READ_DIR,
 		},
 		{},
 	};
@@ -717,8 +730,8 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG,
-			layer1);
+	ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, layer1);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -729,7 +742,7 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
 	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REMOVE_FILE,
-			layer2);
+				    layer2);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -775,7 +788,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 		{
 			.path = dir_s1d3,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		/* ...but also denies read access via its grandparent directory. */
 		{
@@ -839,7 +852,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	int ruleset_fd;
 
 	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-			layer1_read);
+				    layer1_read);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -849,8 +862,10 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_WRITE_FILE, layer2_read_write);
+	ruleset_fd = create_ruleset(_metadata,
+				    LANDLOCK_ACCESS_FS_READ_FILE |
+					    LANDLOCK_ACCESS_FS_WRITE_FILE,
+				    layer2_read_write);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -861,7 +876,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-			layer3_read);
+				    layer3_read);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -872,8 +887,10 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	/* This time, denies write access for the file hierarchy. */
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_WRITE_FILE, layer4_read_write);
+	ruleset_fd = create_ruleset(_metadata,
+				    LANDLOCK_ACCESS_FS_READ_FILE |
+					    LANDLOCK_ACCESS_FS_WRITE_FILE,
+				    layer4_read_write);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -888,7 +905,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 
 	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-			layer5_read);
+				    layer5_read);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -900,7 +917,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
 	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_EXECUTE,
-			layer6_execute);
+				    layer6_execute);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -911,8 +928,10 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_WRITE_FILE, layer7_read_write);
+	ruleset_fd = create_ruleset(_metadata,
+				    LANDLOCK_ACCESS_FS_READ_FILE |
+					    LANDLOCK_ACCESS_FS_WRITE_FILE,
+				    layer7_read_write);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
@@ -930,7 +949,7 @@ TEST_F_FORK(layout1, inherit_subset)
 		{
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_READ_DIR,
+				  LANDLOCK_ACCESS_FS_READ_DIR,
 		},
 		{},
 	};
@@ -958,7 +977,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * ANDed with the previous ones.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			dir_s1d2);
+			 dir_s1d2);
 	/*
 	 * According to ruleset_fd, dir_s1d2 should now have the
 	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
@@ -1013,7 +1032,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * that there was no rule tied to it before.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			dir_s1d3);
+			 dir_s1d3);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -1063,8 +1082,10 @@ TEST_F_FORK(layout1, inherit_superset)
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
 	/* Now dir_s1d2, parent of dir_s1d3, gets a new rule tied to it. */
-	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_READ_DIR, dir_s1d2);
+	add_path_beneath(_metadata, ruleset_fd,
+			 LANDLOCK_ACCESS_FS_READ_FILE |
+				 LANDLOCK_ACCESS_FS_READ_DIR,
+			 dir_s1d2);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -1106,15 +1127,15 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	int ruleset_fd;
 
 	/* Tests empty handled_access_fs. */
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(-1, ruleset_fd);
 	ASSERT_EQ(ENOMSG, errno);
 
 	/* Enforces policy which deny read access to all files. */
 	ruleset_attr.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE;
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -1122,8 +1143,8 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 
 	/* Nests a policy which deny read access to all directories. */
 	ruleset_attr.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR;
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -1258,7 +1279,8 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 	int ruleset_fd;
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3)) {
+	ASSERT_EQ(0, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3))
+	{
 		TH_LOG("Failed to pivot root: %s", strerror(errno));
 	};
 	ASSERT_EQ(0, chdir("/"));
@@ -1311,12 +1333,13 @@ TEST_F_FORK(layout1, move_mount)
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
-				dir_s1d2, 0)) {
+			     dir_s1d2, 0))
+	{
 		TH_LOG("Failed to move mount: %s", strerror(errno));
 	}
 
 	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
-				dir_s3d2, 0));
+			     dir_s3d2, 0));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -1324,7 +1347,7 @@ TEST_F_FORK(layout1, move_mount)
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
-				dir_s1d2, 0));
+			      dir_s1d2, 0));
 	ASSERT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -1371,7 +1394,7 @@ enum relative_access {
 };
 
 static void test_relative_path(struct __test_metadata *const _metadata,
-		const enum relative_access rel)
+			       const enum relative_access rel)
 {
 	/*
 	 * Common layer to check that chroot doesn't ignore it (i.e. a chroot
@@ -1434,14 +1457,16 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 		break;
 	case REL_CHROOT_ONLY:
 		/* Do chroot into dir_s1d2 (relative to dir_s2d2). */
-		ASSERT_EQ(0, chroot("../../s1d1/s1d2")) {
+		ASSERT_EQ(0, chroot("../../s1d1/s1d2"))
+		{
 			TH_LOG("Failed to chroot: %s", strerror(errno));
 		}
 		dirfd = AT_FDCWD;
 		break;
 	case REL_CHROOT_CHDIR:
 		/* Do chroot into dir_s1d2. */
-		ASSERT_EQ(0, chroot(".")) {
+		ASSERT_EQ(0, chroot("."))
+		{
 			TH_LOG("Failed to chroot: %s", strerror(errno));
 		}
 		dirfd = AT_FDCWD;
@@ -1449,7 +1474,7 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	}
 
 	ASSERT_EQ((rel == REL_CHROOT_CHDIR) ? 0 : EACCES,
-			test_open_rel(dirfd, "..", O_RDONLY));
+		  test_open_rel(dirfd, "..", O_RDONLY));
 	ASSERT_EQ(0, test_open_rel(dirfd, ".", O_RDONLY));
 
 	if (rel == REL_CHROOT_ONLY) {
@@ -1471,11 +1496,13 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	if (rel != REL_CHROOT_CHDIR) {
 		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s1d1", O_RDONLY));
 		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3",
+					   O_RDONLY));
 
 		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s2d1", O_RDONLY));
 		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3",
+					   O_RDONLY));
 	}
 
 	if (rel == REL_OPEN)
@@ -1504,40 +1531,42 @@ TEST_F_FORK(layout1, relative_chroot_chdir)
 }
 
 static void copy_binary(struct __test_metadata *const _metadata,
-		const char *const dst_path)
+			const char *const dst_path)
 {
 	int dst_fd, src_fd;
 	struct stat statbuf;
 
 	dst_fd = open(dst_path, O_WRONLY | O_TRUNC | O_CLOEXEC);
-	ASSERT_LE(0, dst_fd) {
-		TH_LOG("Failed to open \"%s\": %s", dst_path,
-				strerror(errno));
+	ASSERT_LE(0, dst_fd)
+	{
+		TH_LOG("Failed to open \"%s\": %s", dst_path, strerror(errno));
 	}
 	src_fd = open(BINARY_PATH, O_RDONLY | O_CLOEXEC);
-	ASSERT_LE(0, src_fd) {
+	ASSERT_LE(0, src_fd)
+	{
 		TH_LOG("Failed to open \"" BINARY_PATH "\": %s",
-				strerror(errno));
+		       strerror(errno));
 	}
 	ASSERT_EQ(0, fstat(src_fd, &statbuf));
-	ASSERT_EQ(statbuf.st_size, sendfile(dst_fd, src_fd, 0,
-				statbuf.st_size));
+	ASSERT_EQ(statbuf.st_size,
+		  sendfile(dst_fd, src_fd, 0, statbuf.st_size));
 	ASSERT_EQ(0, close(src_fd));
 	ASSERT_EQ(0, close(dst_fd));
 }
 
-static void test_execute(struct __test_metadata *const _metadata,
-		const int err, const char *const path)
+static void test_execute(struct __test_metadata *const _metadata, const int err,
+			 const char *const path)
 {
 	int status;
-	char *const argv[] = {(char *)path, NULL};
+	char *const argv[] = { (char *)path, NULL };
 	const pid_t child = fork();
 
 	ASSERT_LE(0, child);
 	if (child == 0) {
-		ASSERT_EQ(err ? -1 : 0, execve(path, argv, NULL)) {
+		ASSERT_EQ(err ? -1 : 0, execve(path, argv, NULL))
+		{
 			TH_LOG("Failed to execute \"%s\": %s", path,
-					strerror(errno));
+			       strerror(errno));
 		};
 		ASSERT_EQ(err, errno);
 		_exit(_metadata->passed ? 2 : 1);
@@ -1545,9 +1574,10 @@ static void test_execute(struct __test_metadata *const _metadata,
 	}
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status)) {
+	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
+	{
 		TH_LOG("Unexpected return code for \"%s\": %s", path,
-				strerror(errno));
+		       strerror(errno));
 	};
 }
 
@@ -1560,8 +1590,8 @@ TEST_F_FORK(layout1, execute)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 	copy_binary(_metadata, file1_s1d1);
@@ -1593,8 +1623,8 @@ TEST_F_FORK(layout1, link)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1630,8 +1660,8 @@ TEST_F_FORK(layout1, rename_file)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1684,14 +1714,14 @@ TEST_F_FORK(layout1, rename_file)
 
 	/* Exchanges and renames files with same parent. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
-				RENAME_EXCHANGE));
+			       RENAME_EXCHANGE));
 	ASSERT_EQ(0, rename(file2_s2d3, file1_s2d3));
 
 	/* Exchanges files and directories with same parent, twice. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s2d3,
-				RENAME_EXCHANGE));
+			       RENAME_EXCHANGE));
 	ASSERT_EQ(0, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s2d3,
-				RENAME_EXCHANGE));
+			       RENAME_EXCHANGE));
 }
 
 TEST_F_FORK(layout1, rename_dir)
@@ -1707,8 +1737,8 @@ TEST_F_FORK(layout1, rename_dir)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1745,7 +1775,7 @@ TEST_F_FORK(layout1, rename_dir)
 	 * directory removal.
 	 */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, file1_s1d2,
-				RENAME_EXCHANGE));
+			       RENAME_EXCHANGE));
 	ASSERT_EQ(0, unlink(dir_s1d3));
 	ASSERT_EQ(0, mkdir(dir_s1d3, 0700));
 	ASSERT_EQ(0, rename(file1_s1d2, dir_s1d3));
@@ -1761,8 +1791,8 @@ TEST_F_FORK(layout1, remove_dir)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1798,8 +1828,8 @@ TEST_F_FORK(layout1, remove_file)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -1814,7 +1844,8 @@ TEST_F_FORK(layout1, remove_file)
 }
 
 static void test_make_file(struct __test_metadata *const _metadata,
-		const __u64 access, const mode_t mode, const dev_t dev)
+			   const __u64 access, const mode_t mode,
+			   const dev_t dev)
 {
 	const struct rule rules[] = {
 		{
@@ -1829,9 +1860,10 @@ static void test_make_file(struct __test_metadata *const _metadata,
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file2_s1d1));
-	ASSERT_EQ(0, mknod(file2_s1d1, mode | 0400, dev)) {
-		TH_LOG("Failed to make file \"%s\": %s",
-				file2_s1d1, strerror(errno));
+	ASSERT_EQ(0, mknod(file2_s1d1, mode | 0400, dev))
+	{
+		TH_LOG("Failed to make file \"%s\": %s", file2_s1d1,
+		       strerror(errno));
 	};
 
 	ASSERT_EQ(0, unlink(file1_s1d2));
@@ -1850,9 +1882,10 @@ static void test_make_file(struct __test_metadata *const _metadata,
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
 	ASSERT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, mknod(file1_s1d2, mode | 0400, dev)) {
-		TH_LOG("Failed to make file \"%s\": %s",
-				file1_s1d2, strerror(errno));
+	ASSERT_EQ(0, mknod(file1_s1d2, mode | 0400, dev))
+	{
+		TH_LOG("Failed to make file \"%s\": %s", file1_s1d2,
+		       strerror(errno));
 	};
 	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
 	ASSERT_EQ(0, unlink(file2_s1d2));
@@ -1869,7 +1902,7 @@ TEST_F_FORK(layout1, make_char)
 	/* Creates a /dev/null device. */
 	set_cap(_metadata, CAP_MKNOD);
 	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_CHAR, S_IFCHR,
-			makedev(1, 3));
+		       makedev(1, 3));
 }
 
 TEST_F_FORK(layout1, make_block)
@@ -1877,7 +1910,7 @@ TEST_F_FORK(layout1, make_block)
 	/* Creates a /dev/loop0 device. */
 	set_cap(_metadata, CAP_MKNOD);
 	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_BLOCK, S_IFBLK,
-			makedev(7, 0));
+		       makedev(7, 0));
 }
 
 TEST_F_FORK(layout1, make_reg_1)
@@ -1909,8 +1942,8 @@ TEST_F_FORK(layout1, make_sym)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1954,8 +1987,8 @@ TEST_F_FORK(layout1, make_dir)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1974,12 +2007,12 @@ TEST_F_FORK(layout1, make_dir)
 }
 
 static int open_proc_fd(struct __test_metadata *const _metadata, const int fd,
-		const int open_flags)
+			const int open_flags)
 {
 	static const char path_template[] = "/proc/self/fd/%d";
 	char procfd_path[sizeof(path_template) + 10];
-	const int procfd_path_size = snprintf(procfd_path, sizeof(procfd_path),
-			path_template, fd);
+	const int procfd_path_size =
+		snprintf(procfd_path, sizeof(procfd_path), path_template, fd);
 
 	ASSERT_LT(procfd_path_size, sizeof(procfd_path));
 	return open(procfd_path, open_flags);
@@ -1995,9 +2028,10 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 		{},
 	};
 	int reg_fd, proc_fd;
-	const int ruleset_fd = create_ruleset(_metadata,
-			LANDLOCK_ACCESS_FS_READ_FILE |
-			LANDLOCK_ACCESS_FS_WRITE_FILE, rules);
+	const int ruleset_fd = create_ruleset(
+		_metadata,
+		LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
+		rules);
 
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -2014,9 +2048,10 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 	ASSERT_EQ(0, close(proc_fd));
 
 	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDWR | O_CLOEXEC);
-	ASSERT_EQ(-1, proc_fd) {
-		TH_LOG("Successfully opened /proc/self/fd/%d: %s",
-				reg_fd, strerror(errno));
+	ASSERT_EQ(-1, proc_fd)
+	{
+		TH_LOG("Successfully opened /proc/self/fd/%d: %s", reg_fd,
+		       strerror(errno));
 	}
 	ASSERT_EQ(EACCES, errno);
 
@@ -2032,13 +2067,13 @@ TEST_F_FORK(layout1, proc_pipe)
 		{
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{},
 	};
 	/* Limits read and write access to files tied to the filesystem. */
-	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
-			rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata, rules[0].access, rules);
 
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -2050,7 +2085,8 @@ TEST_F_FORK(layout1, proc_pipe)
 
 	/* Checks access to pipes through FD. */
 	ASSERT_EQ(0, pipe2(pipe_fds, O_CLOEXEC));
-	ASSERT_EQ(1, write(pipe_fds[1], ".", 1)) {
+	ASSERT_EQ(1, write(pipe_fds[1], ".", 1))
+	{
 		TH_LOG("Failed to write in pipe: %s", strerror(errno));
 	}
 	ASSERT_EQ(1, read(pipe_fds[0], &buf, 1));
@@ -2059,9 +2095,10 @@ TEST_F_FORK(layout1, proc_pipe)
 	/* Checks write access to pipe through /proc/self/fd . */
 	proc_fd = open_proc_fd(_metadata, pipe_fds[1], O_WRONLY | O_CLOEXEC);
 	ASSERT_LE(0, proc_fd);
-	ASSERT_EQ(1, write(proc_fd, ".", 1)) {
+	ASSERT_EQ(1, write(proc_fd, ".", 1))
+	{
 		TH_LOG("Failed to write through /proc/self/fd/%d: %s",
-				pipe_fds[1], strerror(errno));
+		       pipe_fds[1], strerror(errno));
 	}
 	ASSERT_EQ(0, close(proc_fd));
 
@@ -2069,9 +2106,10 @@ TEST_F_FORK(layout1, proc_pipe)
 	proc_fd = open_proc_fd(_metadata, pipe_fds[0], O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, proc_fd);
 	buf = '\0';
-	ASSERT_EQ(1, read(proc_fd, &buf, 1)) {
+	ASSERT_EQ(1, read(proc_fd, &buf, 1))
+	{
 		TH_LOG("Failed to read through /proc/self/fd/%d: %s",
-				pipe_fds[1], strerror(errno));
+		       pipe_fds[1], strerror(errno));
 	}
 	ASSERT_EQ(0, close(proc_fd));
 
@@ -2292,8 +2330,8 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
 }
 
-#define LOWER_BASE	TMP_DIR "/lower"
-#define LOWER_DATA	LOWER_BASE "/data"
+#define LOWER_BASE TMP_DIR "/lower"
+#define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
 static const char lower_dl1[] = LOWER_DATA "/dl1";
 static const char lower_dl1_fl2[] = LOWER_DATA "/dl1/fl2";
@@ -2319,9 +2357,9 @@ static const char (*lower_sub_files[])[] = {
 	NULL,
 };
 
-#define UPPER_BASE	TMP_DIR "/upper"
-#define UPPER_DATA	UPPER_BASE "/data"
-#define UPPER_WORK	UPPER_BASE "/work"
+#define UPPER_BASE TMP_DIR "/upper"
+#define UPPER_DATA UPPER_BASE "/data"
+#define UPPER_WORK UPPER_BASE "/work"
 static const char upper_fu1[] = UPPER_DATA "/fu1";
 static const char upper_du1[] = UPPER_DATA "/du1";
 static const char upper_du1_fu2[] = UPPER_DATA "/du1/fu2";
@@ -2347,8 +2385,8 @@ static const char (*upper_sub_files[])[] = {
 	NULL,
 };
 
-#define MERGE_BASE	TMP_DIR "/merge"
-#define MERGE_DATA	MERGE_BASE "/data"
+#define MERGE_BASE TMP_DIR "/merge"
+#define MERGE_DATA MERGE_BASE "/data"
 static const char merge_fl1[] = MERGE_DATA "/fl1";
 static const char merge_dl1[] = MERGE_DATA "/dl1";
 static const char merge_dl1_fl2[] = MERGE_DATA "/dl1/fl2";
@@ -2374,12 +2412,8 @@ static const char (*merge_base_directories[])[] = {
 	NULL,
 };
 static const char (*merge_sub_files[])[] = {
-	&merge_dl1_fl2,
-	&merge_du1_fu2,
-	&merge_do1_fo2,
-	&merge_do1_fl3,
-	&merge_do1_fu3,
-	NULL,
+	&merge_dl1_fl2, &merge_du1_fu2, &merge_do1_fo2,
+	&merge_do1_fl3, &merge_do1_fu3, NULL,
 };
 
 /*
@@ -2455,9 +2489,8 @@ FIXTURE_SETUP(layout2_overlay)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_cap(_metadata, CAP_DAC_OVERRIDE);
 	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
-				"lowerdir=" LOWER_DATA
-				",upperdir=" UPPER_DATA
-				",workdir=" UPPER_WORK));
+			   "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
+			   ",workdir=" UPPER_WORK));
 	clear_cap(_metadata, CAP_DAC_OVERRIDE);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -2524,9 +2557,9 @@ TEST_F_FORK(layout2_overlay, no_restriction)
 	ASSERT_EQ(0, test_open(merge_do1_fu3, O_RDONLY));
 }
 
-#define for_each_path(path_list, path_entry, i)			\
-	for (i = 0, path_entry = *path_list[i]; path_list[i];	\
-			path_entry = *path_list[++i])
+#define for_each_path(path_list, path_entry, i)               \
+	for (i = 0, path_entry = *path_list[i]; path_list[i]; \
+	     path_entry = *path_list[++i])
 
 TEST_F_FORK(layout2_overlay, same_content_different_file)
 {
@@ -2622,27 +2655,27 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		{
 			.path = merge_dl1_fl2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{
 			.path = merge_du1_fu2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{
 			.path = merge_do1_fo2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{
 			.path = merge_do1_fl3,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{
 			.path = merge_do1_fu3,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{},
 	};
@@ -2650,7 +2683,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		{
 			.path = MERGE_DATA,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_WRITE_FILE,
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{},
 	};
@@ -2670,7 +2703,8 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	for_each_path(lower_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		ASSERT_EQ(EACCES,
+			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(lower_sub_files, path_entry, i) {
 		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
@@ -2682,7 +2716,8 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	for_each_path(upper_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		ASSERT_EQ(EACCES,
+			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(upper_sub_files, path_entry, i) {
 		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
@@ -2767,7 +2802,8 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		ASSERT_EQ(EACCES,
+			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
 		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
@@ -2792,7 +2828,8 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		ASSERT_EQ(EACCES,
+			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
 		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 090adadfe2dc..61db8b84e1f7 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -26,9 +26,10 @@ static void create_domain(struct __test_metadata *const _metadata)
 		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_BLOCK,
 	};
 
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-			sizeof(ruleset_attr), 0);
-	EXPECT_LE(0, ruleset_fd) {
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	EXPECT_LE(0, ruleset_fd)
+	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
 	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
@@ -43,7 +44,7 @@ static int test_ptrace_read(const pid_t pid)
 	int procenv_path_size, fd;
 
 	procenv_path_size = snprintf(procenv_path, sizeof(procenv_path),
-			path_template, pid);
+				     path_template, pid);
 	if (procenv_path_size >= sizeof(procenv_path))
 		return E2BIG;
 
@@ -63,7 +64,8 @@ static int test_ptrace_read(const pid_t pid)
 FIXTURE(hierarchy) {};
 /* clang-format on */
 
-FIXTURE_VARIANT(hierarchy) {
+FIXTURE_VARIANT(hierarchy)
+{
 	const bool domain_both;
 	const bool domain_parent;
 	const bool domain_child;
@@ -217,10 +219,10 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
 };
 
 FIXTURE_SETUP(hierarchy)
-{ }
+{}
 
 FIXTURE_TEARDOWN(hierarchy)
-{ }
+{}
 
 /* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
 TEST_F(hierarchy, trace)
@@ -348,7 +350,7 @@ TEST_F(hierarchy, trace)
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
-			WEXITSTATUS(status) != EXIT_SUCCESS)
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->passed = 0;
 }
 
-- 
2.35.1

