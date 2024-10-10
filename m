Return-Path: <linux-security-module+bounces-6038-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5847998B7B
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015931C267BE
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1631CCEDF;
	Thu, 10 Oct 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gKW1gsty"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0B1CC8BB
	for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574029; cv=none; b=pV+YePCePonwDJYpPa5hjinxPNEjGArT/KWnMr/nkZECWwmsR639xJdKfB4YzBgPr6KJDghJU+j5M79qkZmsC2YGdcPN2w1OLPeN/ufatD09qKnRGUqFtnAlpipsUvSCOZ3oNZ/OsifxI0ao3gSRcWGXbhZKzAkrzXuEaFBUdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574029; c=relaxed/simple;
	bh=IP04WyH8b5ClX6RyMbLRjoix/rEmabeVB5T705Da+EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lB7yN8z3RU+Ye5pdJBBmWq/KX1IM7fGZAJ+Ag2zY9rg6NIMXUqUc0BH3P2Sra+N1kW2e1jBChkMAU64MvaDZswLT0nZmQ3RUoBfi0zCQ7o9NEKyoo2ZMOFV8rb+c2LTN1RE73od/2WYZhO87C2UvjFH3sZDqCweQ9guOL2pDVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gKW1gsty; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX13NR6zVX;
	Thu, 10 Oct 2024 17:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574017;
	bh=Df586XROJKMF1yQSr381EiSbt/vI6xpJkJY3x0sWo24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKW1gstyIqxFplH2KkdMo3/4XmIDKzp7/O2Ibj1sLoDJfTS6MRKhEY4nvBxMuja5W
	 bYy0A4L+fiNz/URueq3YROpu+osO3p+sBKsvN5EUPTCIl8TWIenJiDHdm8IPu39l1f
	 +y6wzQ55DHIZMxcNqruev0BkrBpS0PAFPPVEOm7g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX06nnGz9Rb;
	Thu, 10 Oct 2024 17:26:56 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Eric Paris <eparis@redhat.com>
Subject: [RFC PATCH v1 2/7] audit: Fix inode numbers
Date: Thu, 10 Oct 2024 17:26:42 +0200
Message-ID: <20241010152649.849254-2-mic@digikod.net>
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

Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/lsm_audit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..c39a22b27cce 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -227,7 +227,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 		break;
 	}
@@ -240,7 +240,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 		break;
 	}
@@ -253,7 +253,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 
 		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
@@ -271,7 +271,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 		break;
 	}
@@ -290,7 +290,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		rcu_read_unlock();
 		break;
 	}
-- 
2.46.1


