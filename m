Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8275E8AE
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Jul 2023 03:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjGXBoP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 23 Jul 2023 21:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGXBmh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Jul 2023 21:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF631BD3;
        Sun, 23 Jul 2023 18:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAB2460FFF;
        Mon, 24 Jul 2023 01:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5146AC433C8;
        Mon, 24 Jul 2023 01:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162403;
        bh=nGSDXvVX4lelz1Sbv2iNOqwTq9fHFua6ngurqZWqlFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbeGeoRIFuad4yIDVE0rwv9xVCM2nmEAVVRZziWyOo4yy7NPFD/vPnbV29Abga4hv
         AtT0Gfq2iXO9Fgadhpi4Di5tCaqV9TlcbeAk6PtzgAoH+48cMdbVBArte0vNECoD0K
         m3WyI7xeIeBk/Sg4RAiYqrAnl3K/iE1wH6d36ZatInAtgd8k+s/cP5A4aqLV2I4BBO
         hj3IgT24dpCizNtjK3mifgxfbc40rHPnQ6bNWyBYQp/L9lEo/+hOcWgGqKlS75mSWu
         PTG7mkyZOII5cAuJnYGzvU4KAqYUHX3C617ancq6Bj444Zgo46ljKxEfagyiOEXAk7
         LqbYUhiSw3DTw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>, james.l.morris@oracle.com,
        serge@hallyn.com, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 33/34] apparmor: fix use of strcpy in policy_unpack_test
Date:   Sun, 23 Jul 2023 21:32:36 -0400
Message-Id: <20230724013238.2329166-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Rae Moar <rmoar@google.com>

[ Upstream commit b54aebd4411134b525a82d663a26b2f135ecb7e8 ]

Replace the use of strcpy() in build_aa_ext_struct() in
policy_unpack_test.c with strscpy().

strscpy() is the safer method to use to ensure the buffer does not
overflow. This was found by kernel test robot:
https://lore.kernel.org/all/202301040348.NbfVsXO0-lkp@intel.com/.

Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Rae Moar <rmoar@google.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy_unpack_test.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 0a969b2e03dba..64ddea559f9ac 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -66,31 +66,30 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_STRING_NAME) + 1;
-	strcpy(buf + 3, TEST_STRING_NAME);
+	strscpy(buf + 3, TEST_STRING_NAME, e->end - (void *)(buf + 3));
 
 	buf = e->start + TEST_STRING_BUF_OFFSET;
 	*buf = AA_STRING;
 	*(buf + 1) = strlen(TEST_STRING_DATA) + 1;
-	strcpy(buf + 3, TEST_STRING_DATA);
-
+	strscpy(buf + 3, TEST_STRING_DATA, e->end - (void *)(buf + 3));
 	buf = e->start + TEST_NAMED_U32_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
-	strcpy(buf + 3, TEST_U32_NAME);
+	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
 	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
-	strcpy(buf + 3, TEST_U64_NAME);
+	strscpy(buf + 3, TEST_U64_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
 	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
 
 	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_BLOB_NAME) + 1;
-	strcpy(buf + 3, TEST_BLOB_NAME);
+	strscpy(buf + 3, TEST_BLOB_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_BLOB_NAME) + 1) = AA_BLOB;
 	*(buf + 3 + strlen(TEST_BLOB_NAME) + 2) = TEST_BLOB_DATA_SIZE;
 	memcpy(buf + 3 + strlen(TEST_BLOB_NAME) + 6,
@@ -99,7 +98,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	buf = e->start + TEST_NAMED_ARRAY_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
-	strcpy(buf + 3, TEST_ARRAY_NAME);
+	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
 	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
 
-- 
2.39.2

