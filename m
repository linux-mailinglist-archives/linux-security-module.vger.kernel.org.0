Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2BFDE92
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Nov 2019 14:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKONI5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 15 Nov 2019 08:08:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfKONI5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Nov 2019 08:08:57 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34D7B2A6BA2C4B011194;
        Fri, 15 Nov 2019 21:08:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 21:08:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jmorris@namei.org>, <serge@hallyn.com>, <nayna@linux.ibm.com>,
        <zohar@linux.ibm.com>, <dhowells@redhat.com>,
        <jwboyer@fedoraproject.org>, <yuehaibing@huawei.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/efi: remove unused variables
Date:   Fri, 15 Nov 2019 21:08:30 +0800
Message-ID: <20191115130830.13320-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit ad723674d675 ("x86/efi: move common keyring
handler functions to new file") leave this unused.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/integrity/platform_certs/load_uefi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 4369204..111898a 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -11,11 +11,6 @@
 #include "../integrity.h"
 #include "keyring_handler.h"
 
-static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
-static efi_guid_t efi_cert_x509_sha256_guid __initdata =
-	EFI_CERT_X509_SHA256_GUID;
-static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
-
 /*
  * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
  * it does.
-- 
2.7.4


