Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4039EB46
	for <lists+linux-security-module@lfdr.de>; Tue,  8 Jun 2021 03:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFHBVm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Jun 2021 21:21:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3457 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFHBVl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 21:21:41 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzXQ444dfz6wqB;
        Tue,  8 Jun 2021 09:16:44 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:19:47 +0800
Received: from huawei.com (10.175.113.32) by dggpemm000001.china.huawei.com
 (7.185.36.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 09:19:46 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul@paul-moore.com>, <davem@davemloft.net>,
        <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>
Subject: [PATCH] net: ipv4: fix memory leak in netlbl_cipsov4_add_std
Date:   Tue, 8 Jun 2021 09:51:58 +0800
Message-ID: <20210608015158.3848878-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reported by syzkaller:
BUG: memory leak
unreferenced object 0xffff888105df7000 (size 64):
comm "syz-executor842", pid 360, jiffies 4294824824 (age 22.546s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
backtrace:
[<00000000e67ed558>] kmalloc include/linux/slab.h:590 [inline]
[<00000000e67ed558>] kzalloc include/linux/slab.h:720 [inline]
[<00000000e67ed558>] netlbl_cipsov4_add_std net/netlabel/netlabel_cipso_v4.c:145 [inline]
[<00000000e67ed558>] netlbl_cipsov4_add+0x390/0x2340 net/netlabel/netlabel_cipso_v4.c:416
[<0000000006040154>] genl_family_rcv_msg_doit.isra.0+0x20e/0x320 net/netlink/genetlink.c:739
[<00000000204d7a1c>] genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
[<00000000204d7a1c>] genl_rcv_msg+0x2bf/0x4f0 net/netlink/genetlink.c:800
[<00000000c0d6a995>] netlink_rcv_skb+0x134/0x3d0 net/netlink/af_netlink.c:2504
[<00000000d78b9d2c>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
[<000000009733081b>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
[<000000009733081b>] netlink_unicast+0x4a0/0x6a0 net/netlink/af_netlink.c:1340
[<00000000d5fd43b8>] netlink_sendmsg+0x789/0xc70 net/netlink/af_netlink.c:1929
[<000000000a2d1e40>] sock_sendmsg_nosec net/socket.c:654 [inline]
[<000000000a2d1e40>] sock_sendmsg+0x139/0x170 net/socket.c:674
[<00000000321d1969>] ____sys_sendmsg+0x658/0x7d0 net/socket.c:2350
[<00000000964e16bc>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2404
[<000000001615e288>] __sys_sendmsg+0xd3/0x190 net/socket.c:2433
[<000000004ee8b6a5>] do_syscall_64+0x37/0x90 arch/x86/entry/common.c:47
[<00000000171c7cee>] entry_SYSCALL_64_after_hwframe+0x44/0xae

The memory of doi_def->map.std pointing is allocated in
netlbl_cipsov4_add_std, but no place has freed it. It should be
freed in cipso_v4_doi_free which frees the cipso DOI resource.

Fixes: 96cb8e3313c7a ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 net/ipv4/cipso_ipv4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index d6e3a92841e3..099259fc826a 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -471,6 +471,7 @@ void cipso_v4_doi_free(struct cipso_v4_doi *doi_def)
 		kfree(doi_def->map.std->lvl.local);
 		kfree(doi_def->map.std->cat.cipso);
 		kfree(doi_def->map.std->cat.local);
+		kfree(doi_def->map.std);
 		break;
 	}
 	kfree(doi_def);
-- 
2.18.0.huawei.25

