Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15D65843A6
	for <lists+linux-security-module@lfdr.de>; Thu, 28 Jul 2022 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiG1PzE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 28 Jul 2022 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiG1Pyr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jul 2022 11:54:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54B6C117
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 08:54:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 6so1834883pgb.13
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU+1umJQF2o/NXaZ6DOn2fpiiayOd6S6bPdTx2dKd/k=;
        b=dcP32hnVDAltE5oC+wFB7l+/9L6Z/Bg5HW+o9yRipBBv5uJDAQXieFFGffT0dNJZ7l
         zEqG4XhEhIB0FrK93YOLQ4BJORQ8hjBdq2MOry8P8m+EZz0Cz2Rj7fHJJ1k3L22PNqoW
         9YBcW2a6vn5f+takyY6WspSt+E5TvXmdfcbNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU+1umJQF2o/NXaZ6DOn2fpiiayOd6S6bPdTx2dKd/k=;
        b=vd9g1gZojRTULIROfRf7+RwnJB2zXLE3kbS18tUC7ILggMQGpHswSmEdkbjXMnp6qX
         JTBfqTW+ZJX2xK4xD2urYPonBaXfP7MdQopHoYcQoOHbu6CDgvDFO+6aJDjEWYEL8x6N
         roApWlOV/a/Ydxxci24Es2n8fadaM91ZV8T4rJ06eqZJ9em9C0b+1DfN6phkXmre0zs+
         8FDTitc9S1jWmXnjt4swm62R1uDALTzwtiX2MePOLpmAmqvJBISz3hKntMKZtaPxHlEw
         8uIfjaKTQpmbNDiISjkweh75unoZix7KxECBCH5bSsNNavlpmLmwpq1KrYBZW2fidSNh
         HOGw==
X-Gm-Message-State: AJIora9BiHa9fSz+lRT9UBFzEJ8dPZg+4giO3Bc65zOgct6FfaGfuFED
        9xd5tzmT9Qrsfuwj9uxow5mqIQ==
X-Google-Smtp-Source: AGRyM1uEQZQL0BQQkR3RNvEAFIjhq7+7MXq8qU7ybWJ2B13O/5RNLqRZS5pTd/rmE0sG+MnN8+l1Xg==
X-Received: by 2002:a05:6a00:234c:b0:52b:7cb:ed9d with SMTP id j12-20020a056a00234c00b0052b07cbed9dmr27527599pfj.32.1659023686099;
        Thu, 28 Jul 2022 08:54:46 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bb10:e729:7f59:7cbc])
        by smtp.gmail.com with UTF8SMTPSA id i6-20020a626d06000000b0052c70770b24sm974115pfc.40.2022.07.28.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 08:54:45 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>, linux-raid@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
Date:   Thu, 28 Jul 2022 08:54:41 -0700
Message-Id: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 2aec377a2925 ("dm table: remove dm_table_get_num_targets()
wrapper") in linux-dm/for-next removed the function
dm_table_get_num_targets() which is used by verity-loadpin. Access
table->num_targets directly instead of using the defunct wrapper.

Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/md/dm-verity-loadpin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 10c18bc1652c..387ec43aef72 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -5,6 +5,7 @@
 #include <linux/dm-verity-loadpin.h>
 
 #include "dm.h"
+#include "dm-core.h"
 #include "dm-verity.h"
 
 #define DM_MSG_PREFIX	"verity-loadpin"
@@ -58,7 +59,7 @@ bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
 
 	table = dm_get_live_table(md, &srcu_idx);
 
-	if (dm_table_get_num_targets(table) != 1)
+	if (table->num_targets != 1)
 		goto out;
 
 	ti = dm_table_get_target(table, 0);
-- 
2.37.1.455.g008518b4e5-goog

