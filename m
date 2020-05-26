Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3725D1A7558
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Apr 2020 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406944AbgDNID6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Apr 2020 04:03:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2049 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729491AbgDNIDw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Apr 2020 04:03:52 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 98A43B13CF284C87779C;
        Tue, 14 Apr 2020 09:03:49 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.45) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 14 Apr 2020 09:03:40 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] evm: Fix possible memory leak in evm_calc_hmac_or_hash()
Date:   Tue, 14 Apr 2020 10:01:31 +0200
Message-ID: <20200414080131.29411-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Don't immediately return if the signature is portable and security.ima is
not present. Just set error so that memory allocated is freed before
returning from evm_calc_hmac_or_hash().

Cc: stable@vger.kernel.org
Fixes: 50b977481fce9 ("EVM: Add support for portable signature format")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 35682852ddea..499ea01b2edc 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -241,7 +241,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
-		return -EPERM;
+		error = -EPERM;
 out:
 	kfree(xattr_value);
 	kfree(desc);
-- 
2.17.1

