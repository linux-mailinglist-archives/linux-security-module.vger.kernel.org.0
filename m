Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC9323D33
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Feb 2021 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhBXNFZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 24 Feb 2021 08:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233311AbhBXMxh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Feb 2021 07:53:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AF3764DAF;
        Wed, 24 Feb 2021 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614171085;
        bh=wmPTz/Z+8VLI3N2noswwUlvlvKWvtkX+qXjt5MCWKWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA3YFQ3zGTm4sMH9I7PRxWHJL9nbj9MPKofDvHTXxkeKoa9uVYLembBlkOzM1KP7i
         sTGU/OM/pocQSabVtuoKGSIpnzdIWcUJ4ahu7f5K8sKF3z0G9XUOcH7eQExQjfOKW1
         7SWKpzUR3hxRWUOiOmiMNq7xloE6iiBPyYtSlVaupQOdOwZ689soqBcszwbr5dGmij
         UieaIGXDloQ8z/dWd8pGK5Y4dY2wp+IuC5ybf8cMCLQvFOALw7ddB8dNme/KEa/vLr
         7d0s6Y1Z5uiOTQOZzUZVoggRbHxG2lIPu4jGqI2TLE8ALkHHdx0oKDy7p+KRHaCIQq
         YaGCN0pV8YGcQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+0789a72b46fd91431bd8@syzkaller.appspotmail.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 43/67] tomoyo: ignore data race while checking quota
Date:   Wed, 24 Feb 2021 07:50:01 -0500
Message-Id: <20210224125026.481804-43-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125026.481804-1-sashal@kernel.org>
References: <20210224125026.481804-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 5797e861e402fff2bedce4ec8b7c89f4248b6073 ]

syzbot is reporting that tomoyo's quota check is racy [1]. But this check
is tolerant of some degree of inaccuracy. Thus, teach KCSAN to ignore
this data race.

[1] https://syzkaller.appspot.com/bug?id=999533deec7ba6337f8aa25d8bd1a4d5f7e50476

Reported-by: syzbot <syzbot+0789a72b46fd91431bd8@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/file.c    | 16 ++++++++--------
 security/tomoyo/network.c |  8 ++++----
 security/tomoyo/util.c    | 24 ++++++++++++------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 051f7297877cb..1e6077568fdec 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -362,14 +362,14 @@ static bool tomoyo_merge_path_acl(struct tomoyo_acl_info *a,
 {
 	u16 * const a_perm = &container_of(a, struct tomoyo_path_acl, head)
 		->perm;
-	u16 perm = *a_perm;
+	u16 perm = READ_ONCE(*a_perm);
 	const u16 b_perm = container_of(b, struct tomoyo_path_acl, head)->perm;
 
 	if (is_delete)
 		perm &= ~b_perm;
 	else
 		perm |= b_perm;
-	*a_perm = perm;
+	WRITE_ONCE(*a_perm, perm);
 	return !perm;
 }
 
@@ -437,7 +437,7 @@ static bool tomoyo_merge_mkdev_acl(struct tomoyo_acl_info *a,
 {
 	u8 *const a_perm = &container_of(a, struct tomoyo_mkdev_acl,
 					 head)->perm;
-	u8 perm = *a_perm;
+	u8 perm = READ_ONCE(*a_perm);
 	const u8 b_perm = container_of(b, struct tomoyo_mkdev_acl, head)
 		->perm;
 
@@ -445,7 +445,7 @@ static bool tomoyo_merge_mkdev_acl(struct tomoyo_acl_info *a,
 		perm &= ~b_perm;
 	else
 		perm |= b_perm;
-	*a_perm = perm;
+	WRITE_ONCE(*a_perm, perm);
 	return !perm;
 }
 
@@ -517,14 +517,14 @@ static bool tomoyo_merge_path2_acl(struct tomoyo_acl_info *a,
 {
 	u8 * const a_perm = &container_of(a, struct tomoyo_path2_acl, head)
 		->perm;
-	u8 perm = *a_perm;
+	u8 perm = READ_ONCE(*a_perm);
 	const u8 b_perm = container_of(b, struct tomoyo_path2_acl, head)->perm;
 
 	if (is_delete)
 		perm &= ~b_perm;
 	else
 		perm |= b_perm;
-	*a_perm = perm;
+	WRITE_ONCE(*a_perm, perm);
 	return !perm;
 }
 
@@ -655,7 +655,7 @@ static bool tomoyo_merge_path_number_acl(struct tomoyo_acl_info *a,
 {
 	u8 * const a_perm = &container_of(a, struct tomoyo_path_number_acl,
 					  head)->perm;
-	u8 perm = *a_perm;
+	u8 perm = READ_ONCE(*a_perm);
 	const u8 b_perm = container_of(b, struct tomoyo_path_number_acl, head)
 		->perm;
 
@@ -663,7 +663,7 @@ static bool tomoyo_merge_path_number_acl(struct tomoyo_acl_info *a,
 		perm &= ~b_perm;
 	else
 		perm |= b_perm;
-	*a_perm = perm;
+	WRITE_ONCE(*a_perm, perm);
 	return !perm;
 }
 
diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index f9ff121d7e1eb..a89ed55d85d41 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -233,14 +233,14 @@ static bool tomoyo_merge_inet_acl(struct tomoyo_acl_info *a,
 {
 	u8 * const a_perm =
 		&container_of(a, struct tomoyo_inet_acl, head)->perm;
-	u8 perm = *a_perm;
+	u8 perm = READ_ONCE(*a_perm);
 	const u8 b_perm = container_of(b, struct tomoyo_inet_acl, head)->perm;
 
 	if (is_delete)
 		perm &= ~b_perm;
 	else
 		perm |= b_perm;
-	*a_perm = perm;
+	WRITE_ONCE(*a_perm, perm);
 	return !perm;
 }
 
@@ -259,14 +259,14 @@ static bool tomoyo_merge_unix_acl(struct tomoyo_acl_info *a,
 {
 	u8 * const a_perm =
 		&container_of(a, struct tomoyo_unix_acl, head)->perm;
-	u8 perm = *a_perm;
+	u8 perm = READ_ONCE(*a_perm);
 	const u8 b_perm = container_of(b, struct tomoyo_unix_acl, head)->perm;
 
 	if (is_delete)
 		perm &= ~b_perm;
 	else
 		perm |= b_perm;
-	*a_perm = perm;
+	WRITE_ONCE(*a_perm, perm);
 	return !perm;
 }
 
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 176b803ebcfc9..e89cac913583c 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1058,30 +1058,30 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 
 		if (ptr->is_deleted)
 			continue;
+		/*
+		 * Reading perm bitmap might race with tomoyo_merge_*() because
+		 * caller does not hold tomoyo_policy_lock mutex. But exceeding
+		 * max_learning_entry parameter by a few entries does not harm.
+		 */
 		switch (ptr->type) {
 		case TOMOYO_TYPE_PATH_ACL:
-			perm = container_of(ptr, struct tomoyo_path_acl, head)
-				->perm;
+			data_race(perm = container_of(ptr, struct tomoyo_path_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_PATH2_ACL:
-			perm = container_of(ptr, struct tomoyo_path2_acl, head)
-				->perm;
+			data_race(perm = container_of(ptr, struct tomoyo_path2_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_PATH_NUMBER_ACL:
-			perm = container_of(ptr, struct tomoyo_path_number_acl,
-					    head)->perm;
+			data_race(perm = container_of(ptr, struct tomoyo_path_number_acl, head)
+				  ->perm);
 			break;
 		case TOMOYO_TYPE_MKDEV_ACL:
-			perm = container_of(ptr, struct tomoyo_mkdev_acl,
-					    head)->perm;
+			data_race(perm = container_of(ptr, struct tomoyo_mkdev_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_INET_ACL:
-			perm = container_of(ptr, struct tomoyo_inet_acl,
-					    head)->perm;
+			data_race(perm = container_of(ptr, struct tomoyo_inet_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_UNIX_ACL:
-			perm = container_of(ptr, struct tomoyo_unix_acl,
-					    head)->perm;
+			data_race(perm = container_of(ptr, struct tomoyo_unix_acl, head)->perm);
 			break;
 		case TOMOYO_TYPE_MANUAL_TASK_ACL:
 			perm = 0;
-- 
2.27.0

