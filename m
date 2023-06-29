Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F882741FB9
	for <lists+linux-security-module@lfdr.de>; Thu, 29 Jun 2023 07:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjF2FTQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 29 Jun 2023 01:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjF2FTK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 01:19:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B792724
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:51 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35T17W08006277
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:50 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3rgygy9ptt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:50 -0700
Received: from twshared16556.03.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B1FA733AFB4E6; Wed, 28 Jun 2023 22:18:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 05/14] libbpf: add BPF token support to bpf_map_create() API
Date:   Wed, 28 Jun 2023 22:18:23 -0700
Message-ID: <20230629051832.897119-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yjPh8yUa88TSl9yU6_cEoEvQ1d0JisYp
X-Proofpoint-ORIG-GUID: yjPh8yUa88TSl9yU6_cEoEvQ1d0JisYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add ability to provide token_fd for BPF_MAP_CREATE command through
bpf_map_create() API.

Also wire through token_create.allowed_map_types param for
BPF_TOKEN_CREATE command.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 5 ++++-
 tools/lib/bpf/bpf.h | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a247a1612f29..882297b1e136 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -198,6 +198,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.numa_node = OPTS_GET(opts, numa_node, 0);
 	attr.map_ifindex = OPTS_GET(opts, map_ifindex, 0);
 
+	attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
+
 	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
@@ -1218,6 +1220,7 @@ int bpf_token_create(int pin_path_fd, const char *pin_pathname, struct bpf_token
 	attr.token_create.token_flags = OPTS_GET(opts, token_flags, 0);
 	attr.token_create.pin_flags = OPTS_GET(opts, pin_flags, 0);
 	attr.token_create.allowed_cmds = OPTS_GET(opts, allowed_cmds, 0);
+	attr.token_create.allowed_map_types = OPTS_GET(opts, allowed_map_types, 0);
 
 	ret = sys_bpf(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(ret);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ab0355d90a2c..cd3fb5ce6fe2 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,10 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 token_fd;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field token_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
@@ -557,9 +559,10 @@ struct bpf_token_create_opts {
 	__u32 token_flags;
 	__u32 pin_flags;
 	__u64 allowed_cmds;
+	__u64 allowed_map_types;
 	size_t :0;
 };
-#define bpf_token_create_opts__last_field allowed_cmds
+#define bpf_token_create_opts__last_field allowed_map_types
 
 /**
  * @brief **bpf_token_create()** creates a new instance of BPF token, pinning
-- 
2.34.1

