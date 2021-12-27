Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFE44803BD
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Dec 2021 20:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhL0TFD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Dec 2021 14:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhL0TEQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Dec 2021 14:04:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D40C061763;
        Mon, 27 Dec 2021 11:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08FFA6116E;
        Mon, 27 Dec 2021 19:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D73C36AED;
        Mon, 27 Dec 2021 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640631855;
        bh=e6+pXrEBPpHq42k1fiqzkjtZ/G+OfbbfNM0/EKa6+YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceE8JVF6fytNeXImAFzYZD78OVSxXcAnL+2sArt9UjO4wQ8tzqYwOMFbw6HP3ug08
         8niuq5a2UyjQqhILegbn5NOLk+PmZ94f8qOfxRhYOBdBWwfMhjTA+wAkk5k+3SzQL/
         rqnktDYsA++m/NtuN5I9p5JNEzxpeBoyN9PUwQ6LPaCJsrRzl4/W001rc98MnUQMkF
         mvN3kNl2y/itIf6RI81SRy9b6rFN13ptJPr1/HW+rwX7CYEs9WSgsOQLFEZSE+c+sk
         vYPIRr8c1KPz60aJpPjitTvfUKWLyOFRUNRKeJsjFKuOzWL+obHAlRxPOfmRu8AD3U
         csb4yJCNh+5Bg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sasha Levin <sashal@kernel.org>, takedakn@nttdata.co.jp,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/26] tomoyo: use hwight16() in tomoyo_domain_quota_is_ok()
Date:   Mon, 27 Dec 2021 14:03:14 -0500
Message-Id: <20211227190327.1042326-13-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227190327.1042326-1-sashal@kernel.org>
References: <20211227190327.1042326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit f702e1107601230eec707739038a89018ea3468d ]

hwight16() is much faster. While we are at it, no need to include
"perm =" part into data_race() macro, for perm is a local variable
that cannot be accessed by other threads.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/util.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index af8cd2af3466d..6799b1122c9d8 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1056,7 +1056,6 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list,
 				srcu_read_lock_held(&tomoyo_ss)) {
 		u16 perm;
-		u8 i;
 
 		if (ptr->is_deleted)
 			continue;
@@ -1067,23 +1066,23 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		 */
 		switch (ptr->type) {
 		case TOMOYO_TYPE_PATH_ACL:
-			data_race(perm = container_of(ptr, struct tomoyo_path_acl, head)->perm);
+			perm = data_race(container_of(ptr, struct tomoyo_path_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_PATH2_ACL:
-			data_race(perm = container_of(ptr, struct tomoyo_path2_acl, head)->perm);
+			perm = data_race(container_of(ptr, struct tomoyo_path2_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_PATH_NUMBER_ACL:
-			data_race(perm = container_of(ptr, struct tomoyo_path_number_acl, head)
+			perm = data_race(container_of(ptr, struct tomoyo_path_number_acl, head)
 				  ->perm);
 			break;
 		case TOMOYO_TYPE_MKDEV_ACL:
-			data_race(perm = container_of(ptr, struct tomoyo_mkdev_acl, head)->perm);
+			perm = data_race(container_of(ptr, struct tomoyo_mkdev_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_INET_ACL:
-			data_race(perm = container_of(ptr, struct tomoyo_inet_acl, head)->perm);
+			perm = data_race(container_of(ptr, struct tomoyo_inet_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_UNIX_ACL:
-			data_race(perm = container_of(ptr, struct tomoyo_unix_acl, head)->perm);
+			perm = data_race(container_of(ptr, struct tomoyo_unix_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_MANUAL_TASK_ACL:
 			perm = 0;
@@ -1091,9 +1090,7 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		default:
 			perm = 1;
 		}
-		for (i = 0; i < 16; i++)
-			if (perm & (1 << i))
-				count++;
+		count += hweight16(perm);
 	}
 	if (count < tomoyo_profile(domain->ns, domain->profile)->
 	    pref[TOMOYO_PREF_MAX_LEARNING_ENTRY])
-- 
2.34.1

