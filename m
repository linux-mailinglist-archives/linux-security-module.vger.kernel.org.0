Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53773CD53
	for <lists+linux-security-module@lfdr.de>; Tue, 11 Jun 2019 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbfFKNsj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 11 Jun 2019 09:48:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18549 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387866AbfFKNsi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Jun 2019 09:48:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF7B39DEFC9E36BF9118;
        Tue, 11 Jun 2019 21:48:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 21:48:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <serge@hallyn.com>, <jmorris@namei.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] security: Make capability_hooks static
Date:   Tue, 11 Jun 2019 21:48:15 +0800
Message-ID: <20190611134815.16612-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix sparse warning:

security/commoncap.c:1347:27: warning:
 symbol 'capability_hooks' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/commoncap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index c0b9664..3150bed 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
-- 
2.7.4


