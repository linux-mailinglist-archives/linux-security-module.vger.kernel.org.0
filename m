Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C477CCA4
	for <lists+linux-security-module@lfdr.de>; Wed, 31 Jul 2019 21:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfGaTTY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 15:19:24 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.218]:14242 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730029AbfGaTTY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 15:19:24 -0400
X-Greylist: delayed 1463 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 15:19:23 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 15F345AD9
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 13:55:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id stkahJoEC4FKpstkahTGkh; Wed, 31 Jul 2019 13:55:00 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KIJv1aOM1ysMzR07N3FqA1hGoliaxCsgaIx5trxif/g=; b=akhndPKOuVlMO4SCbZd6JPHzEY
        0WMX7pBKsNJEwCHoZ1mjnjO422FmDfNANLZT7NXHmhFt/fTdPpP7Qppqqlahn5yPCGb7dKp3/r6Hq
        M4KEUSr0BLrBHAfGB67bqI2pGJNZya+BTuty+ycZaOxN02KT69Pzqh5f4iDY5GrYZtOgF0Lv2w5G0
        ORyp7lcPiFSSMThZZf/D+E2b/WYp8BSVLuMt8tzasDgRL9JiTZVosBnfNGU6Iz/XmXc8Lb/3C5o72
        1uKtAWtB17diOLZfcOzhNszcNg6Tzch0Kj/9byNyFy4umMa7GNlzXvDPUuxBOOr5VqcmjY72KfyFD
        bbcDzwEw==;
Received: from [187.192.11.120] (port=38908 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hstkY-003ws3-UA; Wed, 31 Jul 2019 13:54:59 -0500
Date:   Wed, 31 Jul 2019 13:54:57 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tomoyo: common: Fix potential Spectre v1 vulnerability
Message-ID: <20190731185457.GA21407@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hstkY-003ws3-UA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:38908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

profile is controlled by user-space via /sys/kernel/security/tomoyo/profile,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

This issue was detected with the help of Smatch:

security/tomoyo/common.c:498 tomoyo_assign_profile() warn: potential spectre issue 'ns->profile_ptr' [r] (local cap)
security/tomoyo/common.c:499 tomoyo_assign_profile() warn: possible spectre second half.  'ptr'
security/tomoyo/common.c:505 tomoyo_assign_profile() warn: possible spectre second half.  'ptr'
security/tomoyo/common.c:523 tomoyo_assign_profile() warn: possible spectre second half.  'ptr'

Fix this by sanitizing profile before using it to index ns->profile_ptr

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/tomoyo/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index dd3d5942e669..45858dbcfdb9 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/security.h>
+#include <linux/nospec.h>
 #include "common.h"
 
 /* String table for operation mode. */
@@ -488,13 +489,15 @@ static void tomoyo_print_number_union(struct tomoyo_io_buffer *head,
  * Returns pointer to "struct tomoyo_profile" on success, NULL otherwise.
  */
 static struct tomoyo_profile *tomoyo_assign_profile
-(struct tomoyo_policy_namespace *ns, const unsigned int profile)
+(struct tomoyo_policy_namespace *ns, unsigned int profile)
 {
 	struct tomoyo_profile *ptr;
 	struct tomoyo_profile *entry;
 
 	if (profile >= TOMOYO_MAX_PROFILES)
 		return NULL;
+	profile = array_index_nospec(profile, TOMOYO_MAX_PROFILES);
+
 	ptr = ns->profile_ptr[profile];
 	if (ptr)
 		return ptr;
-- 
2.22.0

