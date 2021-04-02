Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B537352885
	for <lists+linux-security-module@lfdr.de>; Fri,  2 Apr 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBJUp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 2 Apr 2021 05:20:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15903 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBJUo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Apr 2021 05:20:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FBZHQ1bqLzkgpp;
        Fri,  2 Apr 2021 17:18:58 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:20:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     <jejb@linux.ibm.com>, <jarkko@kernel.org>
Subject: [PATCH -next] KEYS: trusted: Switch to kmemdup_nul()
Date:   Fri, 2 Apr 2021 17:23:46 +0800
Message-ID: <20210402092346.2444932-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 493eb91ed017..90ded4757e79 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -978,11 +978,9 @@ static int trusted_instantiate(struct key *key,
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	datablob = kmemdup_nul(prep->data, datalen, GFP_KERNEL);
 	if (!datablob)
 		return -ENOMEM;
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] = '\0';
 
 	options = trusted_options_alloc();
 	if (!options) {
-- 
2.25.1

