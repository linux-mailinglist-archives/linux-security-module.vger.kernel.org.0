Return-Path: <linux-security-module+bounces-6025-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFA9988F8
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37A528A464
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D11CCEE2;
	Thu, 10 Oct 2024 14:11:52 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770C1CCECB;
	Thu, 10 Oct 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569512; cv=none; b=KcwPaI5FeIeKK1Fo+j/oyNxMBy4tY/2q4kQ4Ix3nChWMIx5SQmn2t+39/mchff91DV7fcAwQlJaAL/VsbpAVb3jLJ2ZQiLCpVlR6Ta2meOrZ8xKacpntfO48QJhJHpky5iY4NXdbxlElz18F9sQveiyyTLvNGbv358KYd0X+b7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569512; c=relaxed/simple;
	bh=qjQUM9Pu/xL1uv+5ViWjTEXFrOxn79eIJadQW9kS6+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLa2DaTfBN6noUylcDLlZmFkOdjIZ+MkBojN/49wudXQR0LkpLZBlvfki7nmg7RkFGkadiHir3pb3W39/DqBOwrlZW3pUorEC3ol5PujpiqHXtqPXjPLddJqexVJXiB5OYw1NBVfevmPtcYejo3qjfa35Fn/CB08GUfq2Mf9n40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPWpV3pGKzfdB3;
	Thu, 10 Oct 2024 22:09:22 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id C5727180105;
	Thu, 10 Oct 2024 22:11:46 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 22:11:43 +0800
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
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH v3 -next 05/15] mm: util: move sysctls to mm/util.c
Date: Thu, 10 Oct 2024 23:22:05 +0800
Message-ID: <20241010152215.3025842-6-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010152215.3025842-1-yukaixiong@huawei.com>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100016.china.huawei.com (7.202.181.102)

This moves all util related sysctls to mm/util.c, as part of the
kernel/sysctl.c cleaning, also removes redundant external
variable declarations and function declarations.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v3:
 - change the title
---
 include/linux/mm.h   | 11 --------
 include/linux/mman.h |  2 --
 kernel/sysctl.c      | 37 ------------------------
 mm/util.c            | 67 ++++++++++++++++++++++++++++++++++++++------
 4 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c46de4290da..50f0069280f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -204,17 +204,6 @@ extern int sysctl_max_map_count;
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
-extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
-extern unsigned long sysctl_overcommit_kbytes;
-
-int overcommit_ratio_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int overcommit_kbytes_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int overcommit_policy_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..e62ef272d140 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -58,8 +58,6 @@
 		| MAP_HUGE_1GB)
 
 extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
-extern unsigned long sysctl_overcommit_kbytes;
 extern struct percpu_counter vm_committed_as;
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 184d39944e16..ad3ac6f6c808 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2030,29 +2030,6 @@ static struct ctl_table kern_table[] = {
 };
 
 static struct ctl_table vm_table[] = {
-	{
-		.procname	= "overcommit_memory",
-		.data		= &sysctl_overcommit_memory,
-		.maxlen		= sizeof(sysctl_overcommit_memory),
-		.mode		= 0644,
-		.proc_handler	= overcommit_policy_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "overcommit_ratio",
-		.data		= &sysctl_overcommit_ratio,
-		.maxlen		= sizeof(sysctl_overcommit_ratio),
-		.mode		= 0644,
-		.proc_handler	= overcommit_ratio_handler,
-	},
-	{
-		.procname	= "overcommit_kbytes",
-		.data		= &sysctl_overcommit_kbytes,
-		.maxlen		= sizeof(sysctl_overcommit_kbytes),
-		.mode		= 0644,
-		.proc_handler	= overcommit_kbytes_handler,
-	},
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
@@ -2133,20 +2110,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-	{
-		.procname	= "user_reserve_kbytes",
-		.data		= &sysctl_user_reserve_kbytes,
-		.maxlen		= sizeof(sysctl_user_reserve_kbytes),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "admin_reserve_kbytes",
-		.data		= &sysctl_admin_reserve_kbytes,
-		.maxlen		= sizeof(sysctl_admin_reserve_kbytes),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 	{
 		.procname	= "mmap_rnd_bits",
diff --git a/mm/util.c b/mm/util.c
index c1c3b06ab4f9..d0c5f5110aa1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/sysctl.h>
 #include <linux/mman.h>
 #include <linux/hugetlb.h>
 #include <linux/vmalloc.h>
@@ -894,14 +895,16 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 EXPORT_SYMBOL(folio_mc_copy);
 
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
-int sysctl_overcommit_ratio __read_mostly = 50;
-unsigned long sysctl_overcommit_kbytes __read_mostly;
+static int sysctl_overcommit_ratio __read_mostly = 50;
+static unsigned long sysctl_overcommit_kbytes __read_mostly;
 int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
-int overcommit_ratio_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+#ifdef CONFIG_SYSCTL
+
+static int overcommit_ratio_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -916,8 +919,8 @@ static void sync_overcommit_as(struct work_struct *dummy)
 	percpu_counter_sync(&vm_committed_as);
 }
 
-int overcommit_policy_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int overcommit_policy_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int new_policy = -1;
@@ -952,8 +955,8 @@ int overcommit_policy_handler(const struct ctl_table *table, int write, void *bu
 	return ret;
 }
 
-int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int overcommit_kbytes_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -963,6 +966,54 @@ int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *bu
 	return ret;
 }
 
+static struct ctl_table util_sysctl_table[] = {
+	{
+		.procname	= "overcommit_memory",
+		.data		= &sysctl_overcommit_memory,
+		.maxlen		= sizeof(sysctl_overcommit_memory),
+		.mode		= 0644,
+		.proc_handler	= overcommit_policy_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{
+		.procname	= "overcommit_ratio",
+		.data		= &sysctl_overcommit_ratio,
+		.maxlen		= sizeof(sysctl_overcommit_ratio),
+		.mode		= 0644,
+		.proc_handler	= overcommit_ratio_handler,
+	},
+	{
+		.procname	= "overcommit_kbytes",
+		.data		= &sysctl_overcommit_kbytes,
+		.maxlen		= sizeof(sysctl_overcommit_kbytes),
+		.mode		= 0644,
+		.proc_handler	= overcommit_kbytes_handler,
+	},
+	{
+		.procname	= "user_reserve_kbytes",
+		.data		= &sysctl_user_reserve_kbytes,
+		.maxlen		= sizeof(sysctl_user_reserve_kbytes),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "admin_reserve_kbytes",
+		.data		= &sysctl_admin_reserve_kbytes,
+		.maxlen		= sizeof(sysctl_admin_reserve_kbytes),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+};
+
+static int __init init_vm_util_sysctls(void)
+{
+	register_sysctl_init("vm", util_sysctl_table);
+	return 0;
+}
+subsys_initcall(init_vm_util_sysctls);
+#endif /* CONFIG_SYSCTL */
+
 /*
  * Committed memory limit enforced when OVERCOMMIT_NEVER policy is used
  */
-- 
2.34.1


