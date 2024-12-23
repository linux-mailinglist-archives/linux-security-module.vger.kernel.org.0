Return-Path: <linux-security-module+bounces-7314-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BE9FAF8F
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Dec 2024 15:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CE81884047
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Dec 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9B1C878A;
	Mon, 23 Dec 2024 14:20:01 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FB1C5F1F;
	Mon, 23 Dec 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963601; cv=none; b=YnZXcfWkXNGQKqLgiqCFTwbBSJN5YE1eC4uGcXpOA2lsOKH/gjaYB+RqCn0dVvXY1HW+JY3nCRAYCqsUybHu1Bb4UUl5wstrb1TpexVGIazYOLn2xGTmGAhkl7jaoUdhs8eTWHCiLgZs8FnpVP1SJ1MwsHKmojp5xN+P7NY70Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963601; c=relaxed/simple;
	bh=M3xZTu6EzZyd6n2YrYUR5sdHROdsWcbu6nDRtPtIFM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m80mU/FBSWxn+M6W9zummN0KKyePHmo4X3IzrMWga3beR23FqEXjlroXL06b5RIV0s7fgBXKUweKisEBjEXvLvNjw9Wpp5kNveecg73QAsKaZStBhKAq9A/n3So94lSK0DuNo7dXeOUIxywr86ttfsbBpqq/c7TvZYxFPuABSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YH0TW251zzhZZ9;
	Mon, 23 Dec 2024 22:17:19 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 01A5C1800D1;
	Mon, 23 Dec 2024 22:19:57 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:19:53 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v4 -next 07/15] security: min_addr: move sysctl to security/min_addr.c
Date: Mon, 23 Dec 2024 22:15:26 +0800
Message-ID: <20241223141550.638616-8-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223141550.638616-1-yukaixiong@huawei.com>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100016.china.huawei.com (7.202.181.102)

The dac_mmap_min_addr belongs to min_addr.c, move it to
min_addr.c from /kernel/sysctl.c. In the previous Linux kernel
boot process, sysctl_init_bases needs to be executed before
init_mmap_min_addr, So, register_sysctl_init should be executed
before update_mmap_min_addr in init_mmap_min_addr. And according
to the compilation condition in security/Makefile:

      obj-$(CONFIG_MMU)            += min_addr.o

if CONFIG_MMU is not defined, min_addr.c would not be included in the
compilation process. So, drop the CONFIG_MMU check.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
---
v4:
 - const qualify struct ctl_table min_addr_sysctl_table
v3:
 - change the title
v2:
 - update the changelog to explain why drop CONFIG_MMU check.
---
---
 kernel/sysctl.c     |  9 ---------
 security/min_addr.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9c245898f535..62a58e417c40 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2049,15 +2049,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
-#ifdef CONFIG_MMU
-	{
-		.procname	= "mmap_min_addr",
-		.data		= &dac_mmap_min_addr,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= mmap_min_addr_handler,
-	},
-#endif
 #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
    (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
 	{
diff --git a/security/min_addr.c b/security/min_addr.c
index 0ce267c041ab..df1bc643d886 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -44,8 +44,19 @@ int mmap_min_addr_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static const struct ctl_table min_addr_sysctl_table[] = {
+	{
+		.procname	= "mmap_min_addr",
+		.data		= &dac_mmap_min_addr,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= mmap_min_addr_handler,
+	},
+};
+
 static int __init init_mmap_min_addr(void)
 {
+	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
-- 
2.34.1


