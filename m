Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940EF7A6D30
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Sep 2023 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjISVss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 19 Sep 2023 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjISVsq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Sep 2023 17:48:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F11D7
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 14:48:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JL5GHW021184
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 14:48:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t76krcyc7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 14:48:38 -0700
Received: from twshared15338.14.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 78603385A5F1D; Tue, 19 Sep 2023 14:48:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 04/13] bpf: add BPF token support to BPF_MAP_CREATE command
Date:   Tue, 19 Sep 2023 14:47:51 -0700
Message-ID: <20230919214800.3803828-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919214800.3803828-1-andrii@kernel.org>
References: <20230919214800.3803828-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sT4HN04vIKobOTdOjpPknFYS_s5mS1O3
X-Proofpoint-GUID: sT4HN04vIKobOTdOjpPknFYS_s5mS1O3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Allow providing token_fd for BPF_MAP_CREATE command to allow controlled
BPF map creation from unprivileged process through delegated BPF token.

Wire through a set of allowed BPF map types to BPF token, derived from
BPF FS at BPF token creation time. This, in combination with allowed_cmds
allows to create a narrowly-focused BPF token (controlled by privileged
agent) with a restrictive set of BPF maps that application can attempt
to create.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  3 ++
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/inode.c                            |  3 +-
 kernel/bpf/syscall.c                          | 54 +++++++++++++++----
 kernel/bpf/token.c                            | 15 ++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 ++
 8 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae13538f5465..a4aea5b34290 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -265,6 +265,7 @@ struct bpf_map {
 	u32 btf_value_type_id;
 	u32 btf_vmlinux_value_type_id;
 	struct btf *btf;
+	struct bpf_token *token;
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
 #endif
@@ -1579,6 +1580,7 @@ struct bpf_token {
 	atomic64_t refcnt;
 	struct user_namespace *userns;
 	u64 allowed_cmds;
+	u64 allowed_maps;
 };
 
 struct bpf_struct_ops_value;
@@ -2214,6 +2216,7 @@ int bpf_token_new_fd(struct bpf_token *token);
 struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
 
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 36e98c6f8944..9c399454712e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -984,6 +984,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
 
 /* Note that tracing related programs such as
@@ -1423,6 +1424,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 82f11fbffd3e..6e8b4e2bda97 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -614,7 +614,8 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
 
-	if (opts->delegate_maps == ~0ULL)
+	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((opts->delegate_maps & mask) == mask)
 		seq_printf(m, ",delegate_maps=any");
 	else if (opts->delegate_maps)
 		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 93338faa43d5..72fe3b9fa2e4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 	struct btf_record *rec = map->record;
+	struct bpf_token *token = map->token;
 
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
@@ -710,6 +711,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	 * template bpf_map struct used during verification.
 	 */
 	btf_record_free(rec);
+	bpf_token_put(token);
 }
 
 static void bpf_map_put_uref(struct bpf_map *map)
@@ -1014,7 +1016,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
-		if (!bpf_capable()) {
+		if (!bpf_token_capable(map->token, CAP_BPF)) {
 			ret = -EPERM;
 			goto free_map_tab;
 		}
@@ -1102,11 +1104,12 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
@@ -1157,14 +1160,32 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
 
+	if (attr->map_token_fd) {
+		token = bpf_token_get_from_fd(attr->map_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+
+		/* if current token doesn't grant map creation permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
+		    !bpf_token_allow_map_type(token, attr->map_type)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	err = -EPERM;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
 	 * object creation success. Even with unprivileged BPF disabled,
 	 * capability checks are still carried out.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token, CAP_BPF))
+		goto put_token;
 
 	/* check privileged map type permissions */
 	switch (map_type) {
@@ -1197,28 +1218,36 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
-		if (!bpf_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_BPF))
+			goto put_token;
 		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!bpf_net_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_NET_ADMIN))
+			goto put_token;
 		break;
 	default:
 		WARN(1, "unsupported map type %d", map_type);
-		return -EPERM;
+		goto put_token;
 	}
 
 	map = ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	if (IS_ERR(map)) {
+		err = PTR_ERR(map);
+		goto put_token;
+	}
 	map->ops = ops;
 	map->map_type = map_type;
 
+	if (token) {
+		/* move token reference into map->token, reuse our refcnt */
+		map->token = token;
+		token = NULL;
+	}
+
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
 	if (err < 0)
@@ -1291,8 +1320,11 @@ static int map_create(union bpf_attr *attr)
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
+	bpf_token_put(map->token);
 	btf_put(map->btf);
 	map->ops->map_free(map);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index f6ea3eddbee6..bcc170fcf341 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -88,6 +88,12 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 		seq_printf(m, "allowed_cmds:\tany\n");
 	else
 		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+
+	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((token->allowed_maps & mask) == mask)
+		seq_printf(m, "allowed_maps:\tany\n");
+	else
+		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
 }
 
 static const struct file_operations bpf_token_fops = {
@@ -142,6 +148,7 @@ int bpf_token_create(union bpf_attr *attr)
 
 	mnt_opts = path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
+	token->allowed_maps = mnt_opts->delegate_maps;
 
 	ret = bpf_token_new_fd(token);
 	if (ret < 0)
@@ -187,3 +194,11 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
 
 	return token->allowed_cmds & (1ULL << cmd);
 }
+
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type)
+{
+	if (!token || type >= __MAX_BPF_MAP_TYPE)
+		return false;
+
+	return token->allowed_maps & (1ULL << type);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 36e98c6f8944..9c399454712e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -984,6 +984,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
 
 /* Note that tracing related programs such as
@@ -1423,6 +1424,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 9f766ddd946a..573249a2814d 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -68,6 +68,8 @@ void test_libbpf_probe_map_types(void)
 
 		if (map_type == BPF_MAP_TYPE_UNSPEC)
 			continue;
+		if (strcmp(map_type_name, "__MAX_BPF_MAP_TYPE") == 0)
+			continue;
 
 		if (!test__start_subtest(map_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index c440ea3311ed..2a0633f43c73 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -132,6 +132,9 @@ static void test_libbpf_bpf_map_type_str(void)
 		const char *map_type_str;
 		char buf[256];
 
+		if (map_type == __MAX_BPF_MAP_TYPE)
+			continue;
+
 		map_type_name = btf__str_by_offset(btf, e->name_off);
 		map_type_str = libbpf_bpf_map_type_str(map_type);
 		ASSERT_OK_PTR(map_type_str, map_type_name);
-- 
2.34.1

