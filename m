Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE39F4CBCC4
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Mar 2022 12:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiCCLfm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Mar 2022 06:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiCCLez (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Mar 2022 06:34:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A2649906;
        Thu,  3 Mar 2022 03:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=r0bVFbVhsj5LL+wNbkofSLQx6AtPcOg+2fbKjtm7YHo=; b=wQnvgl37SlMhIzoigH4gGfMGzT
        Mu5xImU4hYUW1yupIm+BaAu1iSBPcQUNyhJXYLL2ErJXJl+U+TxTGj7ZDj4KDEVIIWpV1ZZRXVgnc
        G4g7HLRNyD+NGGA0Clzz6ti6/SZUPTf4gsk6/khlwLvql2uSkoYdPB50mFMp9bXhSMi7lQiARRv8e
        GX4xBs0G9tH0i18rVK6H5yksKYk6QJWzDhVmtVMm1ratPHkkFGE+VvK1UMDldbSMpK6hGg07dwYPH
        +H/rA/wRIycn8oMt9eZRNGgY9rBCBxttqr85THJIJFJakJvHaYsoARACJyM4X/vc4SFMdFR8J2BRc
        TKjjyV/Q==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjhE-006Dds-3l; Thu, 03 Mar 2022 11:32:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-security-module@vger.kernel.org
Subject: [PATCH 2/5] block: stop using bdevname in __blkdev_issue_discard
Date:   Thu,  3 Mar 2022 14:32:20 +0300
Message-Id: <20220303113223.326220-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303113223.326220-1-hch@lst.de>
References: <20220303113223.326220-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index fc6ea52e74824..a745fc389a7c5 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -34,10 +34,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	/* In case the discard granularity isn't set by buggy device driver */
 	if (WARN_ON_ONCE(!q->limits.discard_granularity)) {
-		char dev_name[BDEVNAME_SIZE];
-
-		bdevname(bdev, dev_name);
-		pr_err_ratelimited("%s: Error: discard_granularity is 0.\n", dev_name);
+		pr_err_ratelimited("%pg: Error: discard_granularity is 0.\n",
+				   bdev);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.30.2

