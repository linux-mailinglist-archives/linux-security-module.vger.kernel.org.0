Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2D51DCCE
	for <lists+linux-security-module@lfdr.de>; Fri,  6 May 2022 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443367AbiEFQHq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 May 2022 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443355AbiEFQHh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 12:07:37 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC86D95D
        for <linux-security-module@vger.kernel.org>; Fri,  6 May 2022 09:03:52 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNR2F81zMqp8c;
        Fri,  6 May 2022 18:03:51 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNR0Jb8zlhSMn;
        Fri,  6 May 2022 18:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853031;
        bh=qmbAdnwQXamArdpYJ+V1gi+xQsRRzFsMGFvCbzzlvmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dacd7aeZVu+UKVilEKi3flml47lRTmpfgzosk7iOFpRLW993B0Vt4BT560eA5t9Qt
         i176gXDTZd0+5RmXEOnUSSvxuEpdu1PfJpk3Z8TfAa5Mwb0bVYKJfA99Ub+KE1Y0Dx
         sCGhTynbztmLUxi3fGEZzWN04IX0EvStbX5NfQ9g=
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
Subject: [PATCH v1 4/7] selftests/landlock: Normalize array assignment
Date:   Fri,  6 May 2022 18:05:10 +0200
Message-Id: <20220506160513.523257-5-mic@digikod.net>
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

Add a comma after each array value to make clang-format keep the
current array formatting.  See the following commit.

Automatically modified with:
sed -i 's/\t\({}\|NULL\)$/\0,/' tools/testing/selftests/landlock/fs_test.c

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-5-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 112 ++++++++++-----------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index aef2eb3d07cd..198184ca0396 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -514,7 +514,7 @@ TEST_F_FORK(layout1, proc_nsfs)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	struct landlock_path_beneath_attr path_beneath;
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access |
@@ -560,7 +560,7 @@ TEST_F_FORK(layout1, unpriv) {
 			.path = dir_s1d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd;
 
@@ -588,7 +588,7 @@ TEST_F_FORK(layout1, effective_access)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 	char buf;
@@ -635,7 +635,7 @@ TEST_F_FORK(layout1, unhandled_access)
 			.path = dir_s1d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	/* Here, we only handle read accesses, not write accesses. */
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
@@ -669,7 +669,7 @@ TEST_F_FORK(layout1, ruleset_overlap)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_READ_DIR,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -703,14 +703,14 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
 		},
-		{}
+		{},
 	};
 	const struct rule layer2[] = {
 		{
 			.path = dir_s1d3,
 			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd;
 
@@ -767,7 +767,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = file1_s1d3,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	/* First rule with write restrictions. */
 	const struct rule layer2_read_write[] = {
@@ -782,7 +782,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	const struct rule layer3_read[] = {
 		/* Allows read access via its great-grandparent directory. */
@@ -790,7 +790,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = dir_s1d1,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	const struct rule layer4_read_write[] = {
 		/*
@@ -801,7 +801,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	const struct rule layer5_read[] = {
 		/*
@@ -812,7 +812,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	const struct rule layer6_execute[] = {
 		/*
@@ -823,7 +823,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = dir_s2d1,
 			.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		},
-		{}
+		{},
 	};
 	const struct rule layer7_read_write[] = {
 		/*
@@ -834,7 +834,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd;
 
@@ -932,7 +932,7 @@ TEST_F_FORK(layout1, inherit_subset)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_READ_DIR,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1048,7 +1048,7 @@ TEST_F_FORK(layout1, inherit_superset)
 			.path = dir_s1d3,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1084,7 +1084,7 @@ TEST_F_FORK(layout1, max_layers)
 			.path = dir_s1d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1146,7 +1146,7 @@ TEST_F_FORK(layout1, rule_on_mountpoint)
 			.path = dir_s3d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1175,7 +1175,7 @@ TEST_F_FORK(layout1, rule_over_mountpoint)
 			.path = dir_s3d1,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1203,7 +1203,7 @@ TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
 			.path = "/",
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1233,7 +1233,7 @@ TEST_F_FORK(layout1, rule_over_root_deny)
 			.path = "/",
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1253,7 +1253,7 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 			.path = "s3d3",
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd;
 
@@ -1280,7 +1280,7 @@ TEST_F_FORK(layout1, mount_and_pivot)
 			.path = dir_s3d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1303,7 +1303,7 @@ TEST_F_FORK(layout1, move_mount)
 			.path = dir_s3d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1344,7 +1344,7 @@ TEST_F_FORK(layout1, release_inodes)
 			.path = dir_s3d3,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
@@ -1382,7 +1382,7 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 			.path = TMP_DIR,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	const struct rule layer2_subs[] = {
 		{
@@ -1393,7 +1393,7 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 			.path = dir_s2d2,
 			.access = ACCESS_RO,
 		},
-		{}
+		{},
 	};
 	int dirfd, ruleset_fd;
 
@@ -1558,7 +1558,7 @@ TEST_F_FORK(layout1, execute)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_EXECUTE,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1591,7 +1591,7 @@ TEST_F_FORK(layout1, link)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1628,7 +1628,7 @@ TEST_F_FORK(layout1, rename_file)
 			.path = dir_s2d2,
 			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1705,7 +1705,7 @@ TEST_F_FORK(layout1, rename_dir)
 			.path = dir_s2d1,
 			.access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1759,7 +1759,7 @@ TEST_F_FORK(layout1, remove_dir)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1796,7 +1796,7 @@ TEST_F_FORK(layout1, remove_file)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1821,7 +1821,7 @@ static void test_make_file(struct __test_metadata *const _metadata,
 			.path = dir_s1d2,
 			.access = access,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, access, rules);
 
@@ -1907,7 +1907,7 @@ TEST_F_FORK(layout1, make_sym)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_MAKE_SYM,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1952,7 +1952,7 @@ TEST_F_FORK(layout1, make_dir)
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_MAKE_DIR,
 		},
-		{}
+		{},
 	};
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
 			rules);
@@ -1992,7 +1992,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 			.path = file1_s1d2,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	int reg_fd, proc_fd;
 	const int ruleset_fd = create_ruleset(_metadata,
@@ -2034,7 +2034,7 @@ TEST_F_FORK(layout1, proc_pipe)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	/* Limits read and write access to files tied to the filesystem. */
 	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
@@ -2171,7 +2171,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 			.path = dir_s2d1,
 			.access = ACCESS_RW,
 		},
-		{}
+		{},
 	};
 	/*
 	 * Sets access rights on the same bind-mounted directories.  The result
@@ -2187,7 +2187,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 			.path = dir_s2d2,
 			.access = ACCESS_RW,
 		},
-		{}
+		{},
 	};
 	/* Only allow read-access to the s1d3 hierarchies. */
 	const struct rule layer3_source[] = {
@@ -2195,7 +2195,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 			.path = dir_s1d3,
 			.access = LANDLOCK_ACCESS_FS_READ_FILE,
 		},
-		{}
+		{},
 	};
 	/* Removes all access rights. */
 	const struct rule layer4_destination[] = {
@@ -2203,7 +2203,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 			.path = bind_file1_s1d3,
 			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd;
 
@@ -2305,18 +2305,18 @@ static const char lower_do1_fl3[] = LOWER_DATA "/do1/fl3";
 static const char (*lower_base_files[])[] = {
 	&lower_fl1,
 	&lower_fo1,
-	NULL
+	NULL,
 };
 static const char (*lower_base_directories[])[] = {
 	&lower_dl1,
 	&lower_do1,
-	NULL
+	NULL,
 };
 static const char (*lower_sub_files[])[] = {
 	&lower_dl1_fl2,
 	&lower_do1_fo2,
 	&lower_do1_fl3,
-	NULL
+	NULL,
 };
 
 #define UPPER_BASE	TMP_DIR "/upper"
@@ -2333,18 +2333,18 @@ static const char upper_do1_fu3[] = UPPER_DATA "/do1/fu3";
 static const char (*upper_base_files[])[] = {
 	&upper_fu1,
 	&upper_fo1,
-	NULL
+	NULL,
 };
 static const char (*upper_base_directories[])[] = {
 	&upper_du1,
 	&upper_do1,
-	NULL
+	NULL,
 };
 static const char (*upper_sub_files[])[] = {
 	&upper_du1_fu2,
 	&upper_do1_fo2,
 	&upper_do1_fu3,
-	NULL
+	NULL,
 };
 
 #define MERGE_BASE	TMP_DIR "/merge"
@@ -2365,13 +2365,13 @@ static const char (*merge_base_files[])[] = {
 	&merge_fl1,
 	&merge_fu1,
 	&merge_fo1,
-	NULL
+	NULL,
 };
 static const char (*merge_base_directories[])[] = {
 	&merge_dl1,
 	&merge_du1,
 	&merge_do1,
-	NULL
+	NULL,
 };
 static const char (*merge_sub_files[])[] = {
 	&merge_dl1_fl2,
@@ -2379,7 +2379,7 @@ static const char (*merge_sub_files[])[] = {
 	&merge_do1_fo2,
 	&merge_do1_fl3,
 	&merge_do1_fu3,
-	NULL
+	NULL,
 };
 
 /*
@@ -2544,7 +2544,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 			.path = MERGE_BASE,
 			.access = ACCESS_RW,
 		},
-		{}
+		{},
 	};
 	const struct rule layer2_data[] = {
 		{
@@ -2559,7 +2559,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 			.path = MERGE_DATA,
 			.access = ACCESS_RW,
 		},
-		{}
+		{},
 	};
 	/* Sets access right on directories inside both layers. */
 	const struct rule layer3_subdirs[] = {
@@ -2591,7 +2591,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 			.path = merge_do1,
 			.access = ACCESS_RW,
 		},
-		{}
+		{},
 	};
 	/* Tighten access rights to the files. */
 	const struct rule layer4_files[] = {
@@ -2644,7 +2644,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	const struct rule layer5_merge_only[] = {
 		{
@@ -2652,7 +2652,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 			.access = LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
-		{}
+		{},
 	};
 	int ruleset_fd;
 	size_t i;
-- 
2.35.1

