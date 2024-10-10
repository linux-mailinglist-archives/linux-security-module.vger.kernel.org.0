Return-Path: <linux-security-module+bounces-6042-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEC998B7F
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F71C267BE
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F191CDA09;
	Thu, 10 Oct 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="viQD5Unf"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF321CCB28
	for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574029; cv=none; b=W9cqGhWRf7R68WMnrMHkeCmgzSRAIxy5QIrRVCjEgTqmaOWur1oaWGUQPreOzpHfy1GwCEWeJmm5k/WDNWqA16iAm+WJufgSXj95i1uyNZYvxt1okQldYQEscs91ik4uacsfB/DDXVSn1b5+Q1wo+XstPlMYiIzy5ic9Fqrc1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574029; c=relaxed/simple;
	bh=eOBhKnEXSIV7rYPECudDK6DtOaktNZ5HqAb3X21chGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy/jBQwGrpvhow9EGFB+zoyVcnhECUonYc/a3RksescesQmSwdLHMJsvvQy804jTzLOikzipDDjf16eOaPkkpH7O4YJ8DfLzEfJd8F7t6zlnTCR7h+3MGY84/URzZKOd7YDDfbVADuwO/bja+tt1CkGKE3ptJBGn4uxsMc7uwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=viQD5Unf; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX95RxLzskR;
	Thu, 10 Oct 2024 17:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574025;
	bh=h+xbwtkv9Q0HfRvF0JnaC1JBpxwqk3C/8JEj+tSRoi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=viQD5UnfVVrkQwxXvKuz2f8rvu3AVr0TTmAand/JkKo3azywinegXl/kkpQsafg0T
	 VQAeNcmxNnuaEkRDlnYVYMVwL/OwkRbvbJxuhpY+kyzuPzTSkeAyzN/77uV+zFXT/O
	 S5ARmU3HrWJQxDdjj9voLP/BZlG+B6mJcPMGTKYg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX72DrWzBR4;
	Thu, 10 Oct 2024 17:27:03 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH v1 7/7] tomoyo: Fix inode numbers in logs
Date: Thu, 10 Oct 2024 17:26:47 +0200
Message-ID: <20241010152649.849254-7-mic@digikod.net>
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the new inode_get_ino() helper to log the user space's view of
inode's numbers instead of the private kernel values.

Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Because of the required type changes, there might be some side effects.
Please review carefully.
---
 security/tomoyo/common.h    | 4 ++--
 security/tomoyo/condition.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..c670a8e3c351 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -524,7 +524,7 @@ struct tomoyo_name_union {
 
 /* Structure for holding a number. */
 struct tomoyo_number_union {
-	unsigned long values[2];
+	u64 values[2];
 	struct tomoyo_group *group; /* Maybe NULL. */
 	/* One of values in "enum tomoyo_value_type". */
 	u8 value_type[2];
@@ -567,7 +567,7 @@ struct tomoyo_address_group {
 struct tomoyo_mini_stat {
 	kuid_t uid;
 	kgid_t gid;
-	ino_t ino;
+	u64 ino;
 	umode_t mode;
 	dev_t dev;
 	dev_t rdev;
diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index f8bcc083bb0d..a44ea574fd89 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -741,7 +741,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 
 			stat->uid  = inode->i_uid;
 			stat->gid  = inode->i_gid;
-			stat->ino  = inode->i_ino;
+			stat->ino  = inode_get_ino(inode);
 			stat->mode = inode->i_mode;
 			stat->dev  = inode->i_sb->s_dev;
 			stat->rdev = inode->i_rdev;
@@ -766,8 +766,8 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 		      const struct tomoyo_condition *cond)
 {
 	u32 i;
-	unsigned long min_v[2] = { 0, 0 };
-	unsigned long max_v[2] = { 0, 0 };
+	u64 min_v[2] = { 0, 0 };
+	u64 max_v[2] = { 0, 0 };
 	const struct tomoyo_condition_element *condp;
 	const struct tomoyo_number_union *numbers_p;
 	const struct tomoyo_name_union *names_p;
@@ -834,7 +834,7 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
 		/* Check numeric or bit-op expressions. */
 		for (j = 0; j < 2; j++) {
 			const u8 index = j ? right : left;
-			unsigned long value = 0;
+			u64 value = 0;
 
 			switch (index) {
 			case TOMOYO_TASK_UID:
-- 
2.46.1


