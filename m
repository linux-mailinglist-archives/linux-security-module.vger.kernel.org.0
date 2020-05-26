Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF05D1B72F6
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Apr 2020 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDXLVp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 Apr 2020 07:21:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLVp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Apr 2020 07:21:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jRwOs-0005mF-TW; Fri, 24 Apr 2020 11:21:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: remove redundant assignment to variable ret
Date:   Fri, 24 Apr 2020 12:21:42 +0100
Message-Id: <20200424112142.12261-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is
never read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.25.1

