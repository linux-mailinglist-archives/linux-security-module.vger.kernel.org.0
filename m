Return-Path: <linux-security-module+bounces-7882-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10434A1BD7F
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Jan 2025 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A5D1888F9C
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Jan 2025 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B341DA60D;
	Fri, 24 Jan 2025 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyneSq5r"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938ED1DB36B;
	Fri, 24 Jan 2025 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750603; cv=none; b=oEB4zoFGmeHDzh5fdKxD2JBMb371jEZXnPPhSVZwMrhojfMQGDwUF4zSfIQn4njn8/K4OVwF8LaKOeVVJjlTxzGylkoic0zGP26megOEuchlI9YhT9WwaqgHSro6zBn1nhohrMIXzXRqt35mKAMJywCoQX+FZR3HLPNPAIoB8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750603; c=relaxed/simple;
	bh=bnZrm3/Hb1nIJZ7r0LF83ktCbGI3OtlCz4w9SdkVqrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj1ZvFjA83nfYFlqf6ma6a/7KU4qvA5Dga1qgSxeNSeADQQ3g3f/F6p1AP9pS9fzKtyiLi10Xmr83KqQ4QJyZhBLfqxla5c7z6nndp9iyckujqY5gh2pcaWSE6cNTgSPHLbyxb/4TCIVW4GJZ1phIzSEC32MxrzU09/wtdZQiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyneSq5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379D0C4CEDF;
	Fri, 24 Jan 2025 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737750603;
	bh=bnZrm3/Hb1nIJZ7r0LF83ktCbGI3OtlCz4w9SdkVqrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyneSq5rxTKDXlsaOc/L7Vzu1IdZEJN9H751Yde8vSJ3idmPnQW0WINvJI8QeX6d/
	 Y5RZDUjOiU6fuAwsZL93Ew9hDyXvb91DcA7QMAGOjFJ0H5b+5jSSgGwWUTwxmpVkbQ
	 L4PDJJBh8SwzQlnmDUe9dHLp7X4sTrBdbOEtDlRzyPv/M7uZJcnoPNX8blzyMmHsce
	 mHLEYRpzWNWn0Cun8E4rwomrI113ydS6FcOAblBHJZvydubVf+c+KsjA+pJR+7PU9s
	 Hc09EPoxx79zvPOSWzlTUzbe2/nGtJjefjwobXl5r2KkVrO1D/ka765KdXStsyFsg9
	 cGvEi5I0S1RrQ==
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
Subject: [PATCH v10 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
Date: Fri, 24 Jan 2025 12:29:09 -0800
Message-ID: <20250124202911.3264715-6-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124202911.3264715-1-song@kernel.org>
References: <20250124202911.3264715-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_kfunc_id_set.remap can pick proper version of a kfunc for the calling
context. Use this logic to select bpf_dynptr_from_skb or
bpf_dynptr_from_skb_rdonly. This will make the verifier simpler.

Unfortunately, btf_kfunc_id_set.remap cannot cover the DYNPTR_TYPE_SKB
logic in check_kfunc_args(). This can be addressed later.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 25 ++++++----------------
 net/core/filter.c     | 49 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2188b6674266..55e710e318e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11750,6 +11750,7 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
 	KF_bpf_dynptr_from_skb,
+	KF_bpf_dynptr_from_skb_rdonly,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
@@ -11785,6 +11786,7 @@ BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 BTF_ID(func, bpf_dynptr_from_xdp)
 #endif
 BTF_ID(func, bpf_dynptr_slice)
@@ -11816,10 +11818,12 @@ BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 BTF_ID(func, bpf_dynptr_from_xdp)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12741,7 +12745,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_rdonly]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
@@ -20898,9 +20903,7 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr)
 {
 	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
 	void *xdp_kfunc;
-	bool is_rdonly;
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
@@ -20910,22 +20913,6 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 		}
 		/* fallback to default kfunc when not supported by netdev */
 	}
-
-	if (offset)
-		return;
-
-	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		seen_direct_write = env->seen_direct_write;
-		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
-
-		if (is_rdonly)
-			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
-	}
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..6416689e3976 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12062,10 +12062,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
-__bpf_kfunc_end_defs();
-
-int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
-			       struct bpf_dynptr *ptr__uninit)
+__bpf_kfunc int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
+					   struct bpf_dynptr *ptr__uninit)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	int err;
@@ -12079,10 +12077,16 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 	return 0;
 }
 
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
+BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_rdonly, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_hidden_set_skb)
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
@@ -12095,9 +12099,46 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_ID_LIST(bpf_dynptr_from_skb_list)
+BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
+
+static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (kfunc_id != bpf_dynptr_from_skb_list[0])
+		return 0;
+
+	switch (resolve_prog_type(prog)) {
+	/* Program types only with direct read access go here! */
+	case BPF_PROG_TYPE_LWT_IN:
+	case BPF_PROG_TYPE_LWT_OUT:
+	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
+	case BPF_PROG_TYPE_SK_REUSEPORT:
+	case BPF_PROG_TYPE_FLOW_DISSECTOR:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		return bpf_dynptr_from_skb_list[1];
+
+	/* Program types with direct read + write access go here! */
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_XDP:
+	case BPF_PROG_TYPE_LWT_XMIT:
+	case BPF_PROG_TYPE_SK_SKB:
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		return kfunc_id;
+
+	default:
+		break;
+	}
+	return bpf_dynptr_from_skb_list[1];
+}
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
+	.hidden_set = &bpf_kfunc_check_hidden_set_skb,
+	.remap = &bpf_kfunc_set_skb_remap,
 };
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
-- 
2.43.5


