Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4C473931E
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jun 2023 01:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjFUXjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Jun 2023 19:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFUXjL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jun 2023 19:39:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8021721
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 16:39:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHcvsb006275
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 16:39:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbnr9hmwq-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 16:39:09 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:44 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8E9EB333E88E4; Wed, 21 Jun 2023 16:38:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH v3 bpf-next 10/14] bpf: add BPF token support to BPF_PROG_LOAD command
Date:   Wed, 21 Jun 2023 16:38:05 -0700
Message-ID: <20230621233809.1941811-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621233809.1941811-1-andrii@kernel.org>
References: <20230621233809.1941811-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2VG5hnmDf02WlC2iXmOggIJRJMlHcnRM
X-Proofpoint-ORIG-GUID: 2VG5hnmDf02WlC2iXmOggIJRJMlHcnRM
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

Add basic support of BPF token to BPF_PROG_LOAD. Extend BPF token to
allow specifying BPF_PROG_LOAD as an allowed command, and also allow to
specify bit sets of program type and attach type combination that would
be allowed to be loaded by requested BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  6 ++
 include/uapi/linux/bpf.h                      |  8 ++
 kernel/bpf/core.c                             |  1 +
 kernel/bpf/syscall.c                          | 89 +++++++++++++------
 kernel/bpf/token.c                            | 21 +++++
 tools/include/uapi/linux/bpf.h                |  8 ++
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 8 files changed, 113 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 856a147c8ce8..64dcdc18f09a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1411,6 +1411,7 @@ struct bpf_prog_aux {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+	struct bpf_token *token;
 	struct bpf_prog_offload *offload;
 	struct btf *btf;
 	struct bpf_func_info *func_info;
@@ -1540,6 +1541,8 @@ struct bpf_token {
 	atomic64_t refcnt;
 	u64 allowed_cmds;
 	u64 allowed_map_types;
+	u64 allowed_prog_types;
+	u64 allowed_attach_types;
 };
 
 struct bpf_struct_ops_value;
@@ -2099,6 +2102,9 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type);
 
 enum bpf_type {
 	BPF_TYPE_UNSPEC	= 0,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f926f553e6eb..091484cf2efc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1007,6 +1007,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1438,6 +1439,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1664,6 +1666,12 @@ union bpf_attr {
 		 * are allowed to be created by requested BPF token;
 		 */
 		__u64		allowed_map_types;
+		/* similarly to allowed_map_types, bit sets of BPF program
+		 * types and BPF program attach types that are allowed to be
+		 * loaded by requested BPF token
+		 */
+		__u64		allowed_prog_types;
+		__u64		allowed_attach_types;
 	} token_create;
 
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..2ed54d1ed32a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2599,6 +2599,7 @@ void bpf_prog_free(struct bpf_prog *fp)
 
 	if (aux->dst_prog)
 		bpf_prog_put(aux->dst_prog);
+	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
 	schedule_work(&aux->work);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 36be42159c2c..364b1efca301 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2573,13 +2573,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
+#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
+	struct bpf_token *token = NULL;
+	bool bpf_cap;
 	int err;
 	char license[128];
 
@@ -2595,10 +2597,31 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
+	bpf_prog_load_fixup_attach_type(attr);
+
+	if (attr->prog_token_fd) {
+		token = bpf_token_get_from_fd(attr->prog_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		/* if current token doesn't grant prog loading permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
+		    !bpf_token_allow_prog_type(token, attr->prog_type,
+					       attr->expected_attach_type)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	bpf_cap = bpf_token_capable(token, CAP_BPF);
+	err = -EPERM;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
 
 	/* Intent here is for unprivileged_bpf_disabled to block BPF program
 	 * creation for unprivileged users; other actions depend
@@ -2607,21 +2630,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 * capability checks are still carried out for these
 	 * and other operations.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
+		goto put_token;
 
 	if (attr->insn_cnt == 0 ||
-	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
-		return -E2BIG;
+	    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS)) {
+		err = -E2BIG;
+		goto put_token;
+	}
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	if (is_perfmon_prog_type(type) && !perfmon_capable())
-		return -EPERM;
+	if (is_net_admin_prog_type(type) && !bpf_token_capable(token, CAP_NET_ADMIN))
+		goto put_token;
+	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
+		goto put_token;
 
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
@@ -2631,27 +2656,33 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		if (IS_ERR(dst_prog)) {
 			dst_prog = NULL;
 			attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
-			if (IS_ERR(attach_btf))
-				return -EINVAL;
+			if (IS_ERR(attach_btf)) {
+				err = -EINVAL;
+				goto put_token;
+			}
 			if (!btf_is_kernel(attach_btf)) {
 				/* attaching through specifying bpf_prog's BTF
 				 * objects directly might be supported eventually
 				 */
 				btf_put(attach_btf);
-				return -ENOTSUPP;
+				err = -ENOTSUPP;
+				goto put_token;
 			}
 		}
 	} else if (attr->attach_btf_id) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
-		if (IS_ERR(attach_btf))
-			return PTR_ERR(attach_btf);
-		if (!attach_btf)
-			return -EINVAL;
+		if (IS_ERR(attach_btf)) {
+			err = PTR_ERR(attach_btf);
+			goto put_token;
+		}
+		if (!attach_btf) {
+			err = -EINVAL;
+			goto put_token;
+		}
 		btf_get(attach_btf);
 	}
 
-	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
 				       dst_prog)) {
@@ -2659,7 +2690,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -EINVAL;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	/* plain bpf_prog allocation */
@@ -2669,7 +2701,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -ENOMEM;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	prog->expected_attach_type = attr->expected_attach_type;
@@ -2680,6 +2713,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
+	/* move token into prog->aux, reuse taken refcnt */
+	prog->aux->token = token;
+	token = NULL;
+
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
 		goto free_prog;
@@ -2781,6 +2818,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
@@ -3540,7 +3579,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -5129,7 +5168,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
 
-#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_map_types
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_attach_types
 
 static int token_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 91d8d987faea..22449a509048 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -114,6 +114,14 @@ int bpf_token_create(union bpf_attr *attr)
 	if (token && !is_bit_subset_of(attr->token_create.allowed_map_types,
 				       token->allowed_map_types))
 		goto out;
+	/* requested prog types should be a subset of associated token's set */
+	if (token && !is_bit_subset_of(attr->token_create.allowed_prog_types,
+				       token->allowed_prog_types))
+		goto out;
+	/* requested attach types should be a subset of associated token's set */
+	if (token && !is_bit_subset_of(attr->token_create.allowed_attach_types,
+				       token->allowed_attach_types))
+		goto out;
 
 	new_token = bpf_token_alloc();
 	if (!new_token) {
@@ -123,6 +131,8 @@ int bpf_token_create(union bpf_attr *attr)
 
 	new_token->allowed_cmds = attr->token_create.allowed_cmds;
 	new_token->allowed_map_types = attr->token_create.allowed_map_types;
+	new_token->allowed_prog_types = attr->token_create.allowed_prog_types;
+	new_token->allowed_attach_types = attr->token_create.allowed_attach_types;
 
 	ret = bpf_obj_pin_any(attr->token_create.pin_path_fd,
 			      u64_to_user_ptr(attr->token_create.pin_pathname),
@@ -178,3 +188,14 @@ bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type t
 
 	return token->allowed_map_types & (1ULL << type);
 }
+
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type)
+{
+	if (!token || prog_type >= __MAX_BPF_PROG_TYPE || attach_type >= __MAX_BPF_ATTACH_TYPE)
+		return false;
+
+	return (token->allowed_prog_types & (1ULL << prog_type)) &&
+	       (token->allowed_attach_types & (1ULL << attach_type));
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f926f553e6eb..091484cf2efc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1007,6 +1007,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1438,6 +1439,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1664,6 +1666,12 @@ union bpf_attr {
 		 * are allowed to be created by requested BPF token;
 		 */
 		__u64		allowed_map_types;
+		/* similarly to allowed_map_types, bit sets of BPF program
+		 * types and BPF program attach types that are allowed to be
+		 * loaded by requested BPF token
+		 */
+		__u64		allowed_prog_types;
+		__u64		allowed_attach_types;
 	} token_create;
 
 } __attribute__((aligned(8)));
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 573249a2814d..4ed46ed58a7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -30,6 +30,8 @@ void test_libbpf_probe_prog_types(void)
 
 		if (prog_type == BPF_PROG_TYPE_UNSPEC)
 			continue;
+		if (strcmp(prog_type_name, "__MAX_BPF_PROG_TYPE") == 0)
+			continue;
 
 		if (!test__start_subtest(prog_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index e677c0435cec..ea2a8c4063a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -185,6 +185,9 @@ static void test_libbpf_bpf_prog_type_str(void)
 		const char *prog_type_str;
 		char buf[256];
 
+		if (prog_type == __MAX_BPF_PROG_TYPE)
+			continue;
+
 		prog_type_name = btf__str_by_offset(btf, e->name_off);
 		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
 		ASSERT_OK_PTR(prog_type_str, prog_type_name);
-- 
2.34.1

