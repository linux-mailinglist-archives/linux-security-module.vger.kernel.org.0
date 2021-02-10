Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4231606C
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Feb 2021 08:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhBJHyK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Feb 2021 02:54:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12506 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhBJHxr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Feb 2021 02:53:47 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DbBmF55xJzjGtw;
        Wed, 10 Feb 2021 15:51:41 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 15:52:58 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] integrity: Make function integrity_add_key() static
Date:   Wed, 10 Feb 2021 08:01:31 +0000
Message-ID: <20210210080131.1209889-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The sparse tool complains as follows:

security/integrity/digsig.c:146:12: warning:
 symbol 'integrity_add_key' was not declared. Should it be static?

This function is not used outside of digsig.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 security/integrity/digsig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 0f518dcfde05..250fb0836156 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -143,8 +143,8 @@ int __init integrity_init_keyring(const unsigned int id)
 	return __integrity_init_keyring(id, perm, restriction);
 }
 
-int __init integrity_add_key(const unsigned int id, const void *data,
-			     off_t size, key_perm_t perm)
+static int __init integrity_add_key(const unsigned int id, const void *data,
+				    off_t size, key_perm_t perm)
 {
 	key_ref_t key;
 	int rc = 0;

