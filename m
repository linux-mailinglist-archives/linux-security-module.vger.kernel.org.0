Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A315684A2
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Jul 2022 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGFKGR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 6 Jul 2022 06:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiGFKGQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:16 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B583725281
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 03:06:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso5862242pgc.23
        for <linux-security-module@vger.kernel.org>; Wed, 06 Jul 2022 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ps635/kpA1eo1e2a/d/LkjenrD3s0FFYKtlQH5og2M0=;
        b=NnynWWsFfTO+dssm6EIyPhjE+6ApmP6rlGBgJIa4hjcU/iJJY5BwKVCYSsog4WiWVX
         VDsaEFZrRp+XsyKcCEmw4KZWipHQRyDu/cD9ip08AN20WScWrdo+817dBdzSnXfpxgCg
         VTEuIjEiJBrB9mFSCrZWEG19FX6yzHPv6lhcjBomqEFUcUy/Oy9nmcqAwT4xnbIDTHVk
         b6zqi0B1PK3O/xgcbr3fO7C7Wmj+l9j5BHZx7Hu2NhioXvuc3dlbOVw8fotQHF2X6w0z
         2P/Jy5KOYU7EZjo97NVQnQ3mZEH10ekINoXovU53Su/npgQOQyJVdGhQIlbipJbPHJli
         qz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ps635/kpA1eo1e2a/d/LkjenrD3s0FFYKtlQH5og2M0=;
        b=QCF20mX8sI5mqEWOUeNlgup7TrVtJMAV43FygwLBG/TSZYyMrSyKqeLGY6nEQ1VQlW
         NKCo30hcWff5wOSa16TN2Xtm/yVszddH218ROFSK1MBf3n+198QifALr07ZRs5yx7E/U
         aYukL3UpeHB72j8mLZyezplA5f970t72OBVSJh09K+Mx/935Pc45lTm64pMjW5b3CH4B
         6elaQu3DOZAtWghLhu0eQ7wF7wOu+Wak5KKLy04MaIYdRFpLTy5nbvman7u8fjfV2XSk
         dAmq+jyNYrWPozjXbBO5BcRG94YMWRwq0a3CSII3q745iGqn7B9FgoVTopFikzSx69ta
         6xfA==
X-Gm-Message-State: AJIora+vCFSDX9Znzzcu0un/cfLVkzGXrJ9wwUklPjnD0BUhIXonDoRQ
        EzXW9dgV/k5+VxnFG/W6wIV6W2M4kmNb0A==
X-Google-Smtp-Source: AGRyM1uOxF/MrPzQp6BtGripzjqJC6JwABG5OHiDEZ1tbj3+JeUCDkBfbNlhP7R6C3rOrgYGj62qT2p8TRZx3A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:d243:b0:1ef:9e70:3d4e with SMTP
 id o3-20020a17090ad24300b001ef9e703d4emr9065309pjw.232.1657101975263; Wed, 06
 Jul 2022 03:06:15 -0700 (PDT)
Date:   Wed,  6 Jul 2022 18:06:07 +0800
Message-Id: <20220706100607.75761-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3] apparmor: test: Remove some casts which are no-longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With some of the stricter type checking in KUnit's EXPECT macros
removed, several casts in policy_unpack_test are no longer required.

Remove the unnecessary casts, making the conditions clearer.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: David Gow <davidgow@google.com>
---

This is a rebase and resend of [1], which had been accepted into the
AppArmor tree, but eventually conflicted with [2]. Let's push it via the
KUnit tree to avoid any further conflicts, as discussed in [3].

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/20210513193204.816681-9-davidgow@google.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f91bd9f1e7ad5a2025a2f95a2bc002cb7c9e0f9
[3]: https://lore.kernel.org/all/20220405125540.2135d81d@canb.auug.org.au/
---
 security/apparmor/policy_unpack_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 5c18d2f19862..7954cb23d5f2 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -177,7 +177,7 @@ static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
 
 	array_size = unpack_array(puf->e, name);
 
-	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
+	KUNIT_EXPECT_EQ(test, array_size, 0);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
 		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
 }
@@ -391,10 +391,10 @@ static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
+	KUNIT_EXPECT_PTR_EQ(test, chunk,
 			    puf->e->start + TEST_U16_OFFSET + 2);
-	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
-	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
+	KUNIT_EXPECT_EQ(test, size, TEST_U16_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (chunk + TEST_U16_DATA));
 }
 
 static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
@@ -408,7 +408,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
 }
@@ -430,7 +430,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

