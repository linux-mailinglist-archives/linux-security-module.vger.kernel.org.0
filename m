Return-Path: <linux-security-module+bounces-1112-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CE83B236
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jan 2024 20:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD31F24125
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jan 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA87E778;
	Wed, 24 Jan 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OhyMlP9w"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FC132C03
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124160; cv=none; b=bIH3ACebmiYX2EJFpm0w1mfeLjGUUGGKRqhvOKQM0wu0HEY23U9UXC/isr8zdeu1QvOG8pJxxPM1vxmM0LAb1r+ZA3XzTEFnxxEDKGpvzE+1fLmRrxMOqPt4y5EDySuS7GrtheBl1nLB7OO4e9aTcvRMkoMdhYZCGQTgjbobd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124160; c=relaxed/simple;
	bh=1gaILVY/H6stGS/EvSXd6ZL/n9yg9wEbY6RbWPaWb/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJ1wsFaourZUnnFXePule+hEPy3i1L6lz7rfug96ZE4o0bhpEUG9vk/sZMbKBxecIInrRfBfH3TfwEnabPgvaWHVBGf7yPqa3FK/s5AfSfAc3SVVCel/oy2bh5NfmcXSxlzpSPbg/qmps/t3RvHx29pJ4yCnaC4ebNiI9SNag6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OhyMlP9w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7354ba334so36977695ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 11:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706124158; x=1706728958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmd6L4iLZNNyzU97sSrER5LIO6nwo17DPDhcgnpVxag=;
        b=OhyMlP9wfqzkEkBZYSaSnI/a/DVDGNLpoHCyyRrsjXhwi4U37k1/oTrW3+GX2KLXCi
         5W32pHPP2ce6ilKavafL9TLoF//1tL2bxGial5zq9d6+65tbHWCNkpRzpc4pfbGzYyvg
         oScuvJnw7B2RGvYcZcoLde4foNod+djOxgZqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124158; x=1706728958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmd6L4iLZNNyzU97sSrER5LIO6nwo17DPDhcgnpVxag=;
        b=PQqJiinayYukIMQi5PXQinZaIPSLTuG0P0NySUd4lF8OCUURPoQ1lPTGEA3GGApYaj
         OZDbAhPzJxzemLmZboA55t6kz4uJQCVR/+YkSHu377neYTGiEFEI1m+NKSAGw6Kun1oY
         vLUu/vgxfd5fKWgP4tPTKzoyD7ol6t6HRalDGXO9yGEZdr8GAkXbJnJqnssKw/XeLjX4
         7EDrUc2m9HXvqIzCf84jhR/3mpMVeyki+AD1VpKwIjR7+3Qbl47FY72RH0akXUuRgDGa
         NWdbe/Tgyrqz8voes+P4y0R+gKnyqImI6zGSCtAQ3NC/ucNhzkG5yk+lOkexCufeFLgY
         zmzw==
X-Gm-Message-State: AOJu0YxJgjOuEC7P2S7/J1zM+r5gW3qPooFs/fQuSwO8KVfHcmUVUTbu
	Nm50CRB1t6Uu8WOJRxu2vWlrbVTLpCi1uD42zHuWtgqlnnl577amAB08TFNZbw==
X-Google-Smtp-Source: AGHT+IF0/ne04PCSUjBX3tqlCMh/doof5H2bjt5d6Ac8doIh9yQFPCSnvtLvQuFNGnyGzSnBUJ/aAA==
X-Received: by 2002:a17:902:6949:b0:1d4:b50d:dba9 with SMTP id k9-20020a170902694900b001d4b50ddba9mr1254455plt.71.1706124158168;
        Wed, 24 Jan 2024 11:22:38 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s21-20020a17090330d500b001d6fbaaeb56sm8636308plc.145.2024.01.24.11.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:22:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Josh Triplett <josh@joshtriplett.org>,
	Kevin Locke <kevin@kevinlocke.name>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Date: Wed, 24 Jan 2024 11:22:32 -0800
Message-Id: <20240124192228.work.788-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=keescook@chromium.org;
 h=from:subject:message-id; bh=1gaILVY/H6stGS/EvSXd6ZL/n9yg9wEbY6RbWPaWb/g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlsWN4cgMm3ifa4AxYv0rR1P9nb2T7XG8BeE5dh
 dQdKGdd8U+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbFjeAAKCRCJcvTf3G3A
 Jj8eEACdqWJsXSjCuU2ZGkwBhmHssL73vpbJm9vow7VcgTvUcgVoF7WjPAqU3SkkUee2vuDuEEC
 uG3G42UgwdGwzUcascCCo7wkaex/Ac7gDV7BRBywIyjF/vLDCeQ5HhIqatIu/mH44Ebni5aTAQU
 hUYp/I3213FNl/oN3a+PJoqHHB5ORr/0z+NOMW3XT/pJ5DU0fMqAxTHtrF2s/IE9WWreJ4PP9dD
 X5FSgLuUtR0LuJ8/8gRd5EFCycwwUXuvOBcR9Nt4fBBQcU02uF3kcXzm4eF9JJyib+jYDu2tNP3
 eouwdnVwePLu9Xbr2l2lFju9lrgM9QjR7aLXB4J6Bw1nlyZHuj6Hjrc+EYzI1fpVDfrBSTQtFfj
 Skv/zZriwMgLINYrOds5qiWwNPLT7pTEychRittwryFFuoqSyJwLS/5PkycmxUNlwqaQl4NU5S5
 aP++f2Hfr2S7lrzFV1waa0HOn4J2drH3GfOqw+oPKvq/DxMlScVwY76Uvpncoov/alR5EnKKzn4
 Pr66BX8S4pcrokYTbSm4BLat0ulOpUJgRCL1ixDnhwT4ftGIkEFBz8KiIYbfwT/bZCe9VHxD8/s
 bpXJ4Z6N1DuM1EnVnoMQy4GyH63CVXzi2u+ZM1eMNszMiKfYeeWkpZ+ljiyoNyt9iy/mx7u3pPW
 6+jc5CV pbke/Mtw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

After commit 978ffcbf00d8 ("execve: open the executable file before
doing anything else"), current->in_execve was no longer in sync with the
open(). This broke AppArmor and TOMOYO which depend on this flag to
distinguish "open" operations from being "exec" operations.

Instead of moving around in_execve, switch to using __FMODE_EXEC, which
is where the "is this an exec?" intent is stored. Note that TOMOYO still
uses in_execve around cred handling.

Reported-by: Kevin Locke <kevin@kevinlocke.name>
Closes: https://lore.kernel.org/all/ZbE4qn9_h14OqADK@kevinlocke.name
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 978ffcbf00d8 ("execve: open the executable file before doing anything else")
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/lsm.c  | 4 +++-
 security/tomoyo/tomoyo.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7717354ce095..98e1150bee9d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -469,8 +469,10 @@ static int apparmor_file_open(struct file *file)
 	 * Cache permissions granted by the previous exec check, with
 	 * implicit read and executable mmap which are required to
 	 * actually execute the image.
+	 *
+	 * Illogically, FMODE_EXEC is in f_flags, not f_mode.
 	 */
-	if (current->in_execve) {
+	if (file->f_flags & __FMODE_EXEC) {
 		fctx->allow = MAY_EXEC | MAY_READ | AA_EXEC_MMAP;
 		return 0;
 	}
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 3c3af149bf1c..04a92c3d65d4 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -328,7 +328,8 @@ static int tomoyo_file_fcntl(struct file *file, unsigned int cmd,
 static int tomoyo_file_open(struct file *f)
 {
 	/* Don't check read permission here if called from execve(). */
-	if (current->in_execve)
+	/* Illogically, FMODE_EXEC is in f_flags, not f_mode. */
+	if (f->f_flags & __FMODE_EXEC)
 		return 0;
 	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
 					    f->f_flags);
-- 
2.34.1


