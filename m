Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BC21F3B25
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Jun 2020 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgFIMxv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 9 Jun 2020 08:53:51 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50044 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgFIMxu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Jun 2020 08:53:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U.4edQW_1591707214;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U.4edQW_1591707214)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Jun 2020 20:53:35 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH] integrity: Remove redundant variable assignments
Date:   Tue,  9 Jun 2020 20:53:34 +0800
Message-Id: <20200609125334.15764-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The local variable `ret` will be assigned when it is used
for the first time, and assignment is not necessary when
the variable is declared.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/digsig_asymmetric.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 4e0d6778277e..cfa4127d0518 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -79,7 +79,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
 	struct key *key;
-	int ret = -ENOMEM;
+	int ret;
 
 	if (siglen <= sizeof(*hdr))
 		return -EBADMSG;
-- 
2.17.1

