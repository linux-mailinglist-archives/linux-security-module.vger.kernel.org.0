Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF84E947B
	for <lists+linux-security-module@lfdr.de>; Mon, 28 Mar 2022 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiC1LaX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 28 Mar 2022 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiC1L3I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Mar 2022 07:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B5E090;
        Mon, 28 Mar 2022 04:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB4A61195;
        Mon, 28 Mar 2022 11:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD55C340EC;
        Mon, 28 Mar 2022 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466638;
        bh=4O0N2N8QRgt9YtZz4EGkGqK582Qf7irZX4OwaBX3SkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeprNjIsTSNizEWS09B3LfgDquwBAh0BuaGozzqiYvFmxMcEommPBO4jiytRWUbMB
         lV9BQ2lgJ2o0XuKHHGAB4kqZH57eO66CJDyK7a67Yb0FARYEHfG1IznZjHn0P3WaYn
         sr83yqdtYBToI7JNC1n5SGwGtDWxZLgEuf5B8pWKqAolfqjo3Nx/7wlFuSeGX8dsBZ
         27LMhT7pmgx9ZnSdpWGcCoJaavaWVIlpvnjuFKHVO3DGzmXJTn7wi83UNyAmlZUwFe
         Q/S4upfNI86tFd199MXL0ix9u3wQ1DowpSsM/DMmZGS75FsyhRWJpZy81FJwVEMhJ0
         Mj2IbyKReQb4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/16] Fix incorrect type in assignment of ipv6 port for audit
Date:   Mon, 28 Mar 2022 07:23:36 -0400
Message-Id: <20220328112345.1556601-7-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328112345.1556601-1-sashal@kernel.org>
References: <20220328112345.1556601-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit a5cd1ab7ab679d252a6d2f483eee7d45ebf2040c ]

Remove inappropriate use of ntohs() and assign the
port value directly.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 12c0fa85d9f8..0253cd2e2358 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2501,7 +2501,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 	ad.a.u.net->family = PF_INET6;
-	ad.a.u.net->dport = ntohs(address->sin6_port);
+	ad.a.u.net->dport = address->sin6_port;
 	if (act == SMK_RECEIVING)
 		ad.a.u.net->v6info.saddr = address->sin6_addr;
 	else
-- 
2.34.1

