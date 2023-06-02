Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95218720521
	for <lists+linux-security-module@lfdr.de>; Fri,  2 Jun 2023 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjFBPB0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 2 Jun 2023 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjFBPA4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 11:00:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B010CC
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 08:00:51 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3527V6d7028577
        for <linux-security-module@vger.kernel.org>; Fri, 2 Jun 2023 08:00:50 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qyc3papha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 08:00:50 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F145E31E04AFF; Fri,  2 Jun 2023 08:00:45 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 16/18] bpf: consistenly use BPF token throughout BPF verifier logic
Date:   Fri, 2 Jun 2023 08:00:09 -0700
Message-ID: <20230602150011.1657856-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 77K8l4aX5MErzfuQaxDmzSaGbUBdgx7l
X-Proofpoint-ORIG-GUID: 77K8l4aX5MErzfuQaxDmzSaGbUBdgx7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 9467d093e88e..bd0b448e1a22 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2054,24 +2054,26 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 
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
index bbce89937fde..60c0420143b3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1110,7 +1110,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
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
index 086b2a14905b..9a0a93fa2c15 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19219,7 +19219,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
 
@@ -19251,12 +19256,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
index 10d655c140c9..1b4b2ae1cedc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8434,7 +8434,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!bpf_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 			return false;
 		break;
 	}
@@ -8446,7 +8446,7 @@ static bool cg_skb_is_valid_access(int off, int size,
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

