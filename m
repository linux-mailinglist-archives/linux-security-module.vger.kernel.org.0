Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241DD4EADB0
	for <lists+linux-security-module@lfdr.de>; Tue, 29 Mar 2022 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiC2MxN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 29 Mar 2022 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiC2MxA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Mar 2022 08:53:00 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBE611C1A;
        Tue, 29 Mar 2022 05:51:02 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KSTvS74JSzMq11v;
        Tue, 29 Mar 2022 14:51:00 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KSTvS4wrjzlhMCG;
        Tue, 29 Mar 2022 14:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648558260;
        bh=oOLJDQB5hwbJfFE+GVd5hlaYVgtsaPndzmaHv28AxNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM8iX1FSvvlrnUg1j7ZvgC3CYBD+A07wP5+e1dW+mZXNGV5KNZKYLMmRdlfglVdZs
         1gFySiEWjNCTsK4KwrAYy8/KN7Ro7ungv0dOGnRT+P6evfsOkm4tswPbgCk09G3BCq
         ZfIEdhgZRGqWR2bOTMWMp5A/hi8qQyb3asjqhpdg=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 04/12] landlock: Fix same-layer rule unions
Date:   Tue, 29 Mar 2022 14:51:09 +0200
Message-Id: <20220329125117.1393824-5-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-1-mic@digikod.net>
References: <20220329125117.1393824-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

The original behavior was to check if the full set of requested accesses
was allowed by at least a rule of every relevant layer.  This didn't
take into account requests for multiple accesses and same-layer rules
allowing the union of these accesses in a complementary way.  As a
result, multiple accesses requested on a file hierarchy matching rules
that, together, allowed these accesses, but without a unique rule
allowing all of them, was illegitimately denied.  This case should be
rare in practice and it can only be triggered by the path_rename or
file_open hook implementations.

For instance, if, for the same layer, a rule allows execution
beneath /a/b and another rule allows read beneath /a, requesting access
to read and execute at the same time for /a/b should be allowed for this
layer.

This was an inconsistency because the union of same-layer rule accesses
was already allowed if requested once at a time anyway.

This fix changes the way allowed accesses are gathered over a path walk.
To take into account all these rule accesses, we store in a matrix all
layer granting the set of requested accesses, according to the handled
accesses.  To avoid heap allocation, we use an array on the stack which
is 2*13 bytes.  A following commit bringing the LANDLOCK_ACCESS_FS_REFER
access right will increase this size to reach 84 bytes (2*14*3) in case
of link or rename actions.

Add a new layout1.layer_rule_unions test to check that accesses from
different rules pertaining to the same layer are ORed in a file
hierarchy.  Also test that it is not the case for rules from different
layers.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220329125117.1393824-5-mic@digikod.net
---

Changes since v1:
* Add Reviewed-by: Paul Moore.
* Small cosmetic comment cleanup.
---
 security/landlock/fs.c                     |  77 ++++++++++-----
 security/landlock/ruleset.h                |   2 +
 tools/testing/selftests/landlock/fs_test.c | 107 +++++++++++++++++++++
 3 files changed, 160 insertions(+), 26 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0bcb27f2360a..461751c01726 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -204,45 +204,66 @@ static inline const struct landlock_rule *find_rule(
 	return rule;
 }
 
-static inline layer_mask_t unmask_layers(
-		const struct landlock_rule *const rule,
-		const access_mask_t access_request, layer_mask_t layer_mask)
+/*
+ * @layer_masks is read and may be updated according to the access request and
+ * the matching rule.
+ *
+ * Returns true if the request is allowed (i.e. relevant layer masks for the
+ * request are empty).
+ */
+static inline bool unmask_layers(const struct landlock_rule *const rule,
+		const access_mask_t access_request,
+		layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
 {
 	size_t layer_level;
 
+	if (!access_request || !layer_masks)
+		return true;
 	if (!rule)
-		return layer_mask;
+		return false;
 
 	/*
 	 * An access is granted if, for each policy layer, at least one rule
-	 * encountered on the pathwalk grants the requested accesses,
-	 * regardless of their position in the layer stack.  We must then check
+	 * encountered on the pathwalk grants the requested access,
+	 * regardless of its position in the layer stack.  We must then check
 	 * the remaining layers for each inode, from the first added layer to
-	 * the last one.
+	 * the last one.  When there is multiple requested accesses, for each
+	 * policy layer, the full set of requested accesses may not be granted
+	 * by only one rule, but by the union (binary OR) of multiple rules.
+	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
 	 */
 	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
 		const struct landlock_layer *const layer =
 			&rule->layers[layer_level];
 		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
+		const unsigned long access_req = access_request;
+		unsigned long access_bit;
+		bool is_empty;
 
-		/* Checks that the layer grants access to the full request. */
-		if ((layer->access & access_request) == access_request) {
-			layer_mask &= ~layer_bit;
-
-			if (layer_mask == 0)
-				return layer_mask;
+		/*
+		 * Records in @layer_masks which layer grants access to each
+		 * requested access.
+		 */
+		is_empty = true;
+		for_each_set_bit(access_bit, &access_req,
+				ARRAY_SIZE(*layer_masks)) {
+			if (layer->access & BIT_ULL(access_bit))
+				(*layer_masks)[access_bit] &= ~layer_bit;
+			is_empty = is_empty && !(*layer_masks)[access_bit];
 		}
+		if (is_empty)
+			return true;
 	}
-	return layer_mask;
+	return false;
 }
 
 static int check_access_path(const struct landlock_ruleset *const domain,
 		const struct path *const path,
 		const access_mask_t access_request)
 {
-	bool allowed = false;
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	bool allowed = false, has_access = false;
 	struct path walker_path;
-	layer_mask_t layer_mask;
 	size_t i;
 
 	if (!access_request)
@@ -262,13 +283,20 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 		return -EACCES;
 
 	/* Saves all layers handling a subset of requested accesses. */
-	layer_mask = 0;
 	for (i = 0; i < domain->num_layers; i++) {
-		if (domain->fs_access_masks[i] & access_request)
-			layer_mask |= BIT_ULL(i);
+		const unsigned long access_req = access_request;
+		unsigned long access_bit;
+
+		for_each_set_bit(access_bit, &access_req,
+				ARRAY_SIZE(layer_masks)) {
+			if (domain->fs_access_masks[i] & BIT_ULL(access_bit)) {
+				layer_masks[access_bit] |= BIT_ULL(i);
+				has_access = true;
+			}
+		}
 	}
 	/* An access request not handled by the domain is allowed. */
-	if (layer_mask == 0)
+	if (!has_access)
 		return 0;
 
 	walker_path = *path;
@@ -280,14 +308,11 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	while (true) {
 		struct dentry *parent_dentry;
 
-		layer_mask = unmask_layers(find_rule(domain,
-					walker_path.dentry), access_request,
-				layer_mask);
-		if (layer_mask == 0) {
+		allowed = unmask_layers(find_rule(domain, walker_path.dentry),
+				access_request, &layer_masks);
+		if (allowed)
 			/* Stops when a rule from each layer grants access. */
-			allowed = true;
 			break;
-		}
 
 jump_up:
 		if (walker_path.dentry == walker_path.mnt->mnt_root) {
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0128c56ee7ff..fa17cc1f82db 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -22,6 +22,8 @@
 typedef u16 access_mask_t;
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
+/* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
+static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 99838cac970b..1ac41bfa7382 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -687,6 +687,113 @@ TEST_F_FORK(layout1, ruleset_overlap)
 	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 }
 
+TEST_F_FORK(layout1, layer_rule_unions)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	const struct rule layer2[] = {
+		/* Doesn't change anything from layer1. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	const struct rule layer3[] = {
+		/* Only allows write (but not read) to dir_s1d3. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks s1d1 hierarchy with layer1. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d2 hierarchy with layer1. */
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d3 hierarchy with layer1. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Doesn't change anything from layer1. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks s1d1 hierarchy with layer2. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d2 hierarchy with layer2. */
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d3 hierarchy with layer2. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Only allows write (but not read) to dir_s1d3. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer3);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks s1d1 hierarchy with layer3. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d2 hierarchy with layer3. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d3 hierarchy with layer3. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	/* dir_s1d3 should now deny READ_FILE and WRITE_FILE (O_RDWR). */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+}
+
 TEST_F_FORK(layout1, non_overlapping_accesses)
 {
 	const struct rule layer1[] = {
-- 
2.35.1

