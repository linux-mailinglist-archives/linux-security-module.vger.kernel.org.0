Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21573931F
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jun 2023 01:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFUXjT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Jun 2023 19:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjFUXjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jun 2023 19:39:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758811733
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 16:39:12 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHcvsg006275
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 16:39:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbnr9hmwq-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 16:39:11 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:45 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C8375333E8937; Wed, 21 Jun 2023 16:38:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH v3 bpf-next 14/14] selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
Date:   Wed, 21 Jun 2023 16:38:09 -0700
Message-ID: <20230621233809.1941811-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621233809.1941811-1-andrii@kernel.org>
References: <20230621233809.1941811-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _d4prvxSoLRONUhRxA2Fo7OcNi_5mIFM
X-Proofpoint-ORIG-GUID: _d4prvxSoLRONUhRxA2Fo7OcNi_5mIFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_13,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a test validating that BPF token can be used to load privileged BPF
program using privileged BPF helpers through delegated BPF token created
by privileged process.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 113cd4786a70..415d49eacd4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <bpf/btf.h>
 #include "cap_helpers.h"
+#include <linux/filter.h>
 
 static int drop_priv_caps(__u64 *old_caps)
 {
@@ -200,6 +201,69 @@ static void subtest_btf_token(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
 
+static void subtest_prog_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	int token_fd = 0, prog_fd = 0, err;
+	__u64 old_caps = 0;
+	struct bpf_insn insns[] = {
+		/* bpf_jiffies64() requires CAP_BPF */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		/* bpf_get_current_task() requires CAP_PERFMON */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_current_task),
+		/* r0 = 0; exit; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	size_t insn_cnt = ARRAY_SIZE(insns);
+
+	/* create BPF token allowing BPF_PROG_LOAD command */
+	token_opts.allowed_cmds = 1ULL << BPF_PROG_LOAD;
+	token_opts.allowed_prog_types = 1ULL << BPF_PROG_TYPE_XDP;
+	token_opts.allowed_attach_types = 1ULL << BPF_XDP;
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
+	/* validate we can successfully load BPF program with token; this
+	 * being XDP program (CAP_NET_ADMIN) using bpf_jiffies64() (CAP_BPF)
+	 * and bpf_get_current_task() (CAP_PERFMON) helpers validates we have
+	 * BPF token wired properly in a bunch of places in the kernel
+	 */
+	prog_opts.token_fd = token_fd;
+	prog_opts.expected_attach_type = BPF_XDP;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd"))
+		goto cleanup;
+	close(prog_fd);
+
+	/* now validate that we *cannot* load BPF program without token */
+	prog_opts.token_fd = 0;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm"))
+		goto cleanup;
+
+cleanup:
+	if (prog_fd > 0)
+		close(prog_fd);
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
@@ -208,4 +272,6 @@ void test_token(void)
 		subtest_map_token();
 	if (test__start_subtest("btf_token"))
 		subtest_btf_token();
+	if (test__start_subtest("prog_token"))
+		subtest_prog_token();
 }
-- 
2.34.1

