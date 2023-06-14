Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2D727376
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Jun 2023 01:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjFGXzT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Jun 2023 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjFGXzJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:55:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7002697
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:55:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 357HCNAB003468
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:55:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3r2a82txgb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:55:03 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AC22B32857E75; Wed,  7 Jun 2023 16:54:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 16/18] bpf: consistenly use BPF token throughout BPF verifier logic
Date:   Wed, 7 Jun 2023 16:53:50 -0700
Message-ID: <20230607235352.1723243-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -Y7FseShiB_W5ZdX97_p7Cr6IIKaOPs4
X-Proofpoint-ORIG-GUID: -Y7FseShiB_W5ZdX97_p7Cr6IIKaOPs4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Remove remaining direct queries to perfmon_capable() and bpf_capable()
in BPF verifier logic and instead use BPF token (if available) to make
decisions about privileges.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h    | 18 ++++++++++--------
 include/linux/filter.h |  2 +-
 kernel/bpf/arraymap.c  |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  | 13 ++++++-------
 net/core/filter.c      |  4 ++--
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9a9212c5e3ff..452b935d21ed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2059,24 +2059,26 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 
 extern int sysctl_unprivileged_bpf_disabled;
 
-static inline bool bpf_allow_ptr_leaks(void)
+bool bpf_token_capable(const struct bpf_token *token, int cap);
+
+static inline bool bpf_allow_ptr_leaks(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
 
-static inline bool bpf_allow_uninit_stack(void)
+static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
 
-static inline bool bpf_bypass_spec_v1(void)
+static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
 
-static inline bool bpf_bypass_spec_v4(void)
+static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f69114083ec7..2391a9025ffd 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1109,7 +1109,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && bpf_capable())
+	if (bpf_jit_harden == 1 && bpf_token_capable(prog->aux->token, CAP_BPF))
 		return false;
 
 	return true;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..f0c64df6b6ff 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -82,7 +82,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
-	bool bypass_spec_v1 = bpf_bypass_spec_v1();
+	bool bypass_spec_v1 = bpf_bypass_spec_v1(NULL);
 	u64 array_size, mask64;
 	struct bpf_array *array;
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cd0a93968009..c48303e097ec 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -661,7 +661,7 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !bpf_capable())
+	    !bpf_token_capable(fp->aux->token, CAP_BPF))
 		return;
 
 	bpf_prog_ksym_set_addr(fp);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e38584d497c..20fdc1255a0b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19237,7 +19237,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
-	is_priv = bpf_capable();
+
+	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
+	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
+	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
+	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
+	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
 
 	bpf_get_btf_vmlinux();
 
@@ -19269,12 +19274,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment = false;
 
-	env->allow_ptr_leaks = bpf_allow_ptr_leaks();
-	env->allow_uninit_stack = bpf_allow_uninit_stack();
-	env->bypass_spec_v1 = bpf_bypass_spec_v1();
-	env->bypass_spec_v4 = bpf_bypass_spec_v4();
-	env->bpf_capable = bpf_capable();
-
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 59e5f41f2d5b..0f2e5a15f1fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8447,7 +8447,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!bpf_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 			return false;
 		break;
 	}
@@ -8459,7 +8459,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 			break;
 		case bpf_ctx_range(struct __sk_buff, tstamp):
-			if (!bpf_capable())
+			if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 				return false;
 			break;
 		default:
-- 
2.34.1

