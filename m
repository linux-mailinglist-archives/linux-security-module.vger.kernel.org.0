Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D124F7E7838
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Nov 2023 04:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbjKJDst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 Nov 2023 22:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjKJDst (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Nov 2023 22:48:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B34689
        for <linux-security-module@vger.kernel.org>; Thu,  9 Nov 2023 19:48:46 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYZMh029088
        for <linux-security-module@vger.kernel.org>; Thu, 9 Nov 2023 19:48:46 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3u97ht2337-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 09 Nov 2023 19:48:46 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:48:42 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4DE613B41DBBA; Thu,  9 Nov 2023 19:48:40 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 01/17] bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
Date:   Thu, 9 Nov 2023 19:48:22 -0800
Message-ID: <20231110034838.1295764-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110034838.1295764-1-andrii@kernel.org>
References: <20231110034838.1295764-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kZPc7ZULNC6yRvLXi1JNXLBwILAswM1X
X-Proofpoint-GUID: kZPc7ZULNC6yRvLXi1JNXLBwILAswM1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Within BPF syscall handling code CAP_NET_ADMIN checks stand out a bit
compared to CAP_BPF and CAP_PERFMON checks. For the latter, CAP_BPF or
CAP_PERFMON are checked first, but if they are not set, CAP_SYS_ADMIN
takes over and grants whatever part of BPF syscall is required.

Similar kind of checks that involve CAP_NET_ADMIN are not so consistent.
One out of four uses does follow CAP_BPF/CAP_PERFMON model: during
BPF_PROG_LOAD, if the type of BPF program is "network-related" either
CAP_NET_ADMIN or CAP_SYS_ADMIN is required to proceed.

But in three other cases CAP_NET_ADMIN is required even if CAP_SYS_ADMIN
is set:
  - when creating DEVMAP/XDKMAP/CPU_MAP maps;
  - when attaching CGROUP_SKB programs;
  - when handling BPF_PROG_QUERY command.

This patch is changing the latter three cases to follow BPF_PROG_LOAD
model, that is allowing to proceed under either CAP_NET_ADMIN or
CAP_SYS_ADMIN.

This also makes it cleaner in subsequent BPF token patches to switch
wholesomely to a generic bpf_token_capable(int cap) check, that always
falls back to CAP_SYS_ADMIN if requested capability is missing.

Cc: Jakub Kicinski <kuba@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..ad4d8e433ccc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1096,6 +1096,11 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
+static bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1199,7 +1204,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			return -EPERM;
 		break;
 	default:
@@ -2599,7 +2604,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
+	if (is_net_admin_prog_type(type) && !bpf_net_capable())
 		return -EPERM;
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
@@ -3751,7 +3756,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -3954,7 +3959,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
 {
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_net_capable())
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_QUERY))
 		return -EINVAL;
-- 
2.34.1

