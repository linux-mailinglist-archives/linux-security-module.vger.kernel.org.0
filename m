Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9968A85A
	for <lists+linux-security-module@lfdr.de>; Sat,  4 Feb 2023 06:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBDFck (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 4 Feb 2023 00:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjBDFcj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:32:39 -0500
X-Greylist: delayed 1349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 21:32:38 PST
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E0A992EED
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:32:38 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 31459vdj011622;
        Fri, 3 Feb 2023 23:09:57 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 31459vrE011620;
        Fri, 3 Feb 2023 23:09:57 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 03/14] Add magic number for tsemfs.
Date:   Fri,  3 Feb 2023 23:09:43 -0600
Message-Id: <20230204050954.11583-4-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204050954.11583-1-greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 include/uapi/linux/magic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..6a6a2b70c529 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -95,6 +95,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #define AAFS_MAGIC		0x5a3c69f0
 #define ZONEFS_MAGIC		0x5a4f4653
+#define TSEMFS_MAGIC		0x11242022
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
-- 
2.39.1

