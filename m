Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6302A167845
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Feb 2020 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgBUHsi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Feb 2020 02:48:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729093AbgBUHsh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 02:48:37 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15BF75A4DAF002EA0A8B;
        Fri, 21 Feb 2020 15:48:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 15:48:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>, <jmorris@namei.org>
CC:     <casey@schaufler-ca.com>, <sds@tycho.nsa.gov>,
        <zohar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] security: remove duplicated include from security.h
Date:   Fri, 21 Feb 2020 15:43:42 +0800
Message-ID: <20200221074342.16788-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/security.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 910a1ef..fe2c566 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -30,7 +30,6 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/fs.h>
 
 struct linux_binprm;
 struct cred;
-- 
2.7.4


