Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495CB53B458
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Jun 2022 09:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiFBHbQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Jun 2022 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiFBHbP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jun 2022 03:31:15 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41DDF2A90C4
        for <linux-security-module@vger.kernel.org>; Thu,  2 Jun 2022 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=gaEyDHO1LpI7BPrJT3
        Ah6HERITFafn14fFE2XuY+C3w=; b=RtUtyDNHQcDLIbAVRWbhpNGMKgoXrLdoJ9
        PKD8GfQxRIwqAla4CzdAxAlW7gjgnF3jDQ8lKIytt2B7XCGpt8kI7Q80Srz+IKJr
        zMO8kz74oloA6uOcatjRB+kl292xX9Fhqm/Z4cUqs9/iqEh89DzWYKaOliYF9Pmc
        YQXYCCOV0=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp12 (Coremail) with SMTP id EMCowACX1jHuZphiC_kjAA--.3208S4;
        Thu, 02 Jun 2022 15:30:13 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] security: avoid a leak in securityfs_remove()
Date:   Thu,  2 Jun 2022 15:29:43 +0800
Message-Id: <20220602072943.8095-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowACX1jHuZphiC_kjAA--.3208S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrGw1xWF15ZF1ftryxKF1UAwb_yoWxGwb_CF
        y5Ar4kG3yDu3WrJrsxAF4FvFZI9r95Gry8Ca4fJ3ZFy345Ar45XFy7JryxXryUGr4UWr90
        kFsxGFyIk3W7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_-tx3UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbB0AUU5WEsqyef-QAAsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Delete the dentry in securityfs_remove() to make sure the
dentry is not used by another thread and live longer than
the call of securityfs_remove().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 security/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..606f390d21d2 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.17.1

