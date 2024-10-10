Return-Path: <linux-security-module+bounces-6035-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B7998937
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6376E1C24B9C
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946431E8821;
	Thu, 10 Oct 2024 14:12:22 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D71E7C21;
	Thu, 10 Oct 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569542; cv=none; b=RVnGeU0BaxojRjuvmkiV/un8SWgAMpr03T1aBjgFsi9XsATXCTvxDBHucKhqpXWy/Nk9eDuaLfi/6bNsgI8AE3qvYuAbeclHkAE4Bqq6fiGOOCaeXNxfkIN0bIbyIGom/PHexPCx4PmJyORez61nvHdDORf9w+kuXiBJRO5trUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569542; c=relaxed/simple;
	bh=3Bjfe7NAtCXidb5TFTCiuIh/dnHj0G/gKNNhaIgHxTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0Mo0gu6kmEC2G+kPmnWPcXnDmTwem8BZp8M2lh4Hfxw5I6DUlg2+yB7o5aZPgbd7DPS+hQjbpEUy9by+P+dklEVE2ABPz9mmHVPO9ubdHpcUl3VBNXdJ/+WriQ8DvMsGaqjL+kzW+34YTZ32ajcAtSKt+PJqskSISQennokphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPWq6495SzfdDh;
	Thu, 10 Oct 2024 22:09:54 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3A218007C;
	Thu, 10 Oct 2024 22:12:18 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 22:12:15 +0800
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
Subject: [PATCH v3 -next 15/15] sysctl: remove unneeded include
Date: Thu, 10 Oct 2024 23:22:15 +0800
Message-ID: <20241010152215.3025842-16-yukaixiong@huawei.com>
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

Removing unneeded mm includes in kernel/sysctl.c.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 kernel/sysctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f04da9f3abc6..6e3e0ce4da79 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -20,8 +20,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
 #include <linux/signal.h>
@@ -30,7 +28,6 @@
 #include <linux/proc_fs.h>
 #include <linux/security.h>
 #include <linux/ctype.h>
-#include <linux/kmemleak.h>
 #include <linux/filter.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -41,7 +38,6 @@
 #include <linux/highuid.h>
 #include <linux/writeback.h>
 #include <linux/ratelimit.h>
-#include <linux/hugetlb.h>
 #include <linux/initrd.h>
 #include <linux/key.h>
 #include <linux/times.h>
@@ -52,13 +48,11 @@
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
-#include <linux/oom.h>
 #include <linux/kmod.h>
 #include <linux/capability.h>
 #include <linux/binfmts.h>
 #include <linux/sched/sysctl.h>
 #include <linux/mount.h>
-#include <linux/userfaultfd_k.h>
 #include <linux/pid.h>
 
 #include "../lib/kstrtox.h"
-- 
2.34.1


