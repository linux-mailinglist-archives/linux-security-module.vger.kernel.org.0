Return-Path: <linux-security-module+bounces-1531-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5A85ABBB
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Feb 2024 20:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E797284FD2
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Feb 2024 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235562E408;
	Mon, 19 Feb 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oYEBpSyH"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1698495E2
	for <linux-security-module@vger.kernel.org>; Mon, 19 Feb 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369448; cv=none; b=CBKp4rcNGOHms9/zlFZofCo7VgW2y8kXDRymP3yAUG8U4UrPOj8FBQOJC8UmF929XbfLzOvWDVR8mBcW0e8zntJb56oAuuZMs/OPIsPUTRgsr3PUTX1oNX6nH9fB0rFd555wUsAgHqSt4s2mAqLD8KnvxQn4rGJ6oWwLKsgdqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369448; c=relaxed/simple;
	bh=2Hj9UWhrDgzjOkOL5rsGTh1N6ZOemj+WfIpokHEQmEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwnAidx8xszXWotFN6reWkOf3Ej0DpYrdbZxPWjFMQhPg7DG4ETOBuwnxcJEh3y8lUWD/rwQN5QQq79DdldnFOfiTvXoSa37e0eBNrKxuTxXnRigglzbpl3BbFPJLG8fLACW9e0YBp+8uJXvWeqSicOnXHtCUIdTWKemta0RYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oYEBpSyH; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TdsQN4czSzMq2jt;
	Mon, 19 Feb 2024 20:03:56 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TdsQM6BKYzHc4;
	Mon, 19 Feb 2024 20:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708369436;
	bh=2Hj9UWhrDgzjOkOL5rsGTh1N6ZOemj+WfIpokHEQmEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oYEBpSyHPf3yCOV1oKVMu8oMFvPoQCSBIkNLD+IxvPoRrocGTlH6/8tVFY6grA/4c
	 HrGPkpJHLNPY4iMEKl0tx04ZbxKvFox0qZDC43+cqxrcm7kdx5k9AWmXmBj0QePO/+
	 gDw7Cba472cs3BaH1+HVVVML+M4YsWMtlhVpbagM=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jann Horn <jannh@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Kees Cook <keescook@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] landlock: Fix asymmetric private inodes referring
Date: Mon, 19 Feb 2024 20:03:45 +0100
Message-ID: <20240219190345.2928627-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

When linking or renaming a file, if only one of the source or
destination directory is backed by an S_PRIVATE inode, then the related
set of layer masks would be used as uninitialized by
is_access_to_paths_allowed().  This would result to indeterministic
access for one side instead of always being allowed.

This bug could only be triggered with a mounted filesystem containing
both S_PRIVATE and !S_PRIVATE inodes, which doesn't seem possible.

The collect_domain_accesses() calls return early if
is_nouser_or_private() returns false, which means that the directory's
superblock has SB_NOUSER or its inode has S_PRIVATE.  Because rename or
link actions are only allowed on the same mounted filesystem, the
superblock is always the same for both source and destination
directories.  However, it might be possible in theory to have an
S_PRIVATE parent source inode with an !S_PRIVATE parent destination
inode, or vice versa.

To make sure this case is not an issue, explicitly initialized both set
of layer masks to 0, which means to allow all actions on the related
side.  If at least on side has !S_PRIVATE, then
collect_domain_accesses() and is_access_to_paths_allowed() check for the
required access rights.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Shervin Oloumi <enlightened@chromium.org>
Cc: stable@vger.kernel.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 90f7f6db1e87..f243c6a392ee 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1093,8 +1093,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS],
-		layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS];
+	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
+		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	if (!dom)
 		return 0;
-- 
2.43.0


