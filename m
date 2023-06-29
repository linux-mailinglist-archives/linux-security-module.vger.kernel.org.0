Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6A741FB7
	for <lists+linux-security-module@lfdr.de>; Thu, 29 Jun 2023 07:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjF2FTO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 29 Jun 2023 01:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjF2FTK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 01:19:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5B272A
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:54 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0gV1G031347
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:54 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgynb1p5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:53 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BE55633AFB531; Wed, 28 Jun 2023 22:18:44 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 06/14] selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
Date:   Wed, 28 Jun 2023 22:18:24 -0700
Message-ID: <20230629051832.897119-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: d9nEr2b4dOCHSvjrkEcMAFnsIxVrRxal
X-Proofpoint-GUID: d9nEr2b4dOCHSvjrkEcMAFnsIxVrRxal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add test for creating BPF token with support for BPF_MAP_CREATE
delegation. And validate that its allowed_map_types filter works as
expected and allows to create privileged BPF maps through delegated
token, as long as they are allowed by privileged creator of a token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 153c4e26ef6b..0f832f9178a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -89,8 +89,63 @@ static void subtest_token_create(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
 
+static void subtest_map_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int token_fd = 0, map_fd = 0, err;
+	__u64 old_caps = 0;
+
+	/* check that it's ok to allow any map type */
+	token_opts.allowed_map_types = ~0ULL; /* any current and future map types is allowed */
+	err = bpf_token_create(-EBADF, TOKEN_PATH, &token_opts);
+	if (!ASSERT_OK(err, "token_create_future_proof"))
+		return;
+	unlink(TOKEN_PATH);
+
+	/* create BPF token allowing STACK, but not QUEUE map */
+	token_opts.allowed_cmds = 1ULL << BPF_MAP_CREATE;
+	token_opts.allowed_map_types = 1ULL << BPF_MAP_TYPE_STACK; /* but not QUEUE */
+	err = bpf_token_create(-EBADF, TOKEN_PATH, &token_opts);
+	if (!ASSERT_OK(err, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	token_fd = bpf_obj_get(TOKEN_PATH);
+	if (!ASSERT_GT(token_fd, 0, "token_get"))
+		goto cleanup;
+
+	/* BPF_MAP_TYPE_STACK is privileged, but with given token_fd should succeed */
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "token_stack", 0, 8, 1, &map_opts);
+	if (!ASSERT_GT(map_fd, 0, "stack_map_fd"))
+		goto cleanup;
+	close(map_fd);
+	map_fd = 0;
+
+	/* BPF_MAP_TYPE_QUEUE is privileged, and token doesn't allow it, so should fail */
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, "token_queue", 0, 8, 1, &map_opts);
+	if (!ASSERT_EQ(map_fd, -EPERM, "queue_map_fd"))
+		goto cleanup;
+
+cleanup:
+	if (map_fd > 0)
+		close(map_fd);
+	if (token_fd)
+		close(token_fd);
+	unlink(TOKEN_PATH);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("token_create"))
 		subtest_token_create();
+	if (test__start_subtest("map_token"))
+		subtest_map_token();
 }
-- 
2.34.1

