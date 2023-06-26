Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275D273EDAE
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jun 2023 23:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFZVza (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Jun 2023 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjFZVyP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Jun 2023 17:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09282964;
        Mon, 26 Jun 2023 14:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11CE60F64;
        Mon, 26 Jun 2023 21:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06A2C433C9;
        Mon, 26 Jun 2023 21:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816292;
        bh=XzLyUG9IOF2FmNlCE9hkjcb5E8FRkyeQNTklQWGEU1M=;
        h=From:To:Cc:Subject:Date:From;
        b=egIUODX7uD4ep4uGrUhZDWFLXhZNWu54R9SAPk7CnViFWjWef5GjmGQL5ovaRLfza
         WN8OGAvf09o4LxxqNfyJHa49JD5WvuAOSkOGBYvEmsMjN0Xvw/QThiXE6UcnB5tpbu
         k9qYqqcOiA6elJfVts6/vge+X+Z1N8IFbzFZ5ipBWXhfpF2WyLXVQ0KjMTBPqlSfOo
         zVthcyQUa3ZykoxFQYS1RH/Z0oH29kEDuvlZ4VJRpH7kJ36k8rA5Wlg4tI++eXsIxP
         aGV3gcb0k3RwOmj4EKoGqjqgs9mEcN0HfBEgLfOLCvZIx3JxP/UamNKFvGpyX2Wx3/
         OoHuJsroLEOFw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 1/5] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date:   Mon, 26 Jun 2023 17:51:26 -0400
Message-Id: <20230626215130.179740-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.319
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Dmitry Mastykin <dmastykin@astralinux.ru>

[ Upstream commit b403643d154d15176b060b82f7fc605210033edd ]

There is a shift wrapping bug in this code on 32-bit architectures.
NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
Every second 32-bit word of catmap becomes corrupted.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_kapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 15fe2120b3109..14c3d640f94b9 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -871,7 +871,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
-- 
2.39.2

