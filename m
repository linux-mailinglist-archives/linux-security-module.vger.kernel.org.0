Return-Path: <linux-security-module+bounces-8408-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59657A4B0F6
	for <lists+linux-security-module@lfdr.de>; Sun,  2 Mar 2025 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C4E18918E4
	for <lists+linux-security-module@lfdr.de>; Sun,  2 Mar 2025 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F81D5CC6;
	Sun,  2 Mar 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b="a/4JD3wu"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A2155C96
	for <linux-security-module@vger.kernel.org>; Sun,  2 Mar 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740911821; cv=none; b=W4XWjb5Y4ERgJFOsaZ9LgVE7kdWiidHsfEeRy4cgbTJy0ExMeTN/t13LK2cdWispf0vd2PCWE766BF3l+0gK4lnkONN+stUG+K4+f+zirZbIWxSi9R3PUfUoXc1vHV7FGmipvwjGNLzRBHco06qgYIHwCf1x2kYCPs6cX89qFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740911821; c=relaxed/simple;
	bh=9ObLwWetwtzNhXXbgbELVfFkcrYsTXdZou0f7q/WYzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPFem5jxbcCKWogObFF13nau3bDVM6eIQX8DU7c/A2AFKVyumDC4LnT/P2fBHWnZOU+2mZBLcfYF6dQkRW8lQNvR+YNQ9/5P44uTTElBhXNA4r+O67mB8rPOM2BDAFqw/jyNk6TEMxK+dZzHVbO5R0xyeVKTp+u5rXCpyJL06Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b=a/4JD3wu; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250302103649b8b3b9d950df8bfb9c
        for <linux-security-module@vger.kernel.org>;
        Sun, 02 Mar 2025 11:36:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=arulpandiyan.vadivel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=93sRwriU6vMZv4PkYvvaMFg50M9J7+f+RW4GYhOC00k=;
 b=a/4JD3wux3FQExDa5oORNBeaFq3hX2SN6rEYB42U1mRhXNlmqv1zePd4SBenFJbqDyGloT
 fzCbV7VvxOL/6SKpS6g7jPHtAAaMTxcrOyJgVcZGHQ3V3i2YIH43yez72l3wvwy3wXT6Qfr7
 ZPnpxV8R8T3cFuJQf5tLrYXOnU837HeCsFAlAAxiO6kVhYdPE5NgeScgjVFc5E9BlAnx5qwv
 3ti6ZAxOJ2Ay0qwPbl86XgulGb5XGrmL/8a4NWj9vijfP7hXNWZ9l+U1NTlj7Km7XO8nElQm
 qTx3Dz+w/2aZfSwMPggB5rxVy7JR8gebZ9yGbFBVzytF6eQuiQuYxtpQ==;
From: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
To: linux-security-module@vger.kernel.org
Cc: cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com,
	linux-modules@vger.kernel.org,
	paul@paul-moore.com,
	kees@kernel.org,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Subject: [PATCH V3] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
Date: Sun,  2 Mar 2025 16:08:31 +0530
Message-Id: <20250302103831.285381-1-arulpandiyan.vadivel@siemens.com>
In-Reply-To: <202502281136.66F12960A1@keescook>
References: <202502281136.66F12960A1@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328317:519-21489:flowmailer

Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no longer
available from kernel modules. As MODULE_COMPRESS and MODULE_DECOMPRESS
depends on MODULES removing MODULES as well.

Fixes: c7ff693fa209 ("module: Split modules_install compression and in-kernel decompression")
Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
---
Changes in v3:
Remove MODULES as suggested

Changes in v2:
Reword the commit message
Modify logic and add Fixes tag.
---
 security/loadpin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 848f8b4a60190..aef63d3e30dfa 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
 	depends on SECURITY_LOADPIN
 	# Module compression breaks LoadPin unless modules are decompressed in
 	# the kernel.
-	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
+	depends on !MODULE_COMPRESS || MODULE_DECOMPRESS
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
-- 
2.39.5


