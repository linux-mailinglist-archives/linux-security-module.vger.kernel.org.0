Return-Path: <linux-security-module+bounces-2784-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312ED8AB304
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Apr 2024 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633F91C20AD9
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Apr 2024 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE1131BAD;
	Fri, 19 Apr 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4LK2No8l"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3F1311BF
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543121; cv=none; b=VhKf7llhE37Lu2hnL4Y15xNa0qtBk4fJsDA0hTXmdjuqW7aukLrPbnpXtIOMoXN8YTJ8UWmD2IABQo9/lWI0Fd0KL4HMez6WS3pVZTKtmykA8ee8UF+GjukHmRnMey2QyGAcLpRFrcRXeOrAY4iXdYkqD02AouoVsHU7GVY8/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543121; c=relaxed/simple;
	bh=8Sbz6xPy4d51xqBFXjUr7rr4WXtoUD0T6JNeQh6Hv+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRKXLMzV1Ck3TWZLG8JhQVwCPt7GNei3Zkt6/qBcS+28lcf4BI1KfaY4JjqhuDOYdrksisnfZbtwFuX8ntiE6SezPJ6WexMpu5ZThvw62Ro4hBuVpnZrnCec6P1x0NDDPCbfSbpUAyRAq+ueg4StPz4U2cu3cpeXWZUmqDJAJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4LK2No8l; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a5568b24531so167069866b.1
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543118; x=1714147918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYJ1G6THEcze8HV6qNPokLaKgVvE2KbB4dc/k79IC8Q=;
        b=4LK2No8loMrTom6nTOt5Upwto8B+/3gWA4nfb6XfjTaj1MMf3bg7wUsZ0SrSRpGGea
         i/mXaNJkzbxSuiWPh5VIK5l76pVasaY0kHba8GfTK+CtB8Qak/0xoA8cdG7BdrlTLYLB
         kr8edCqt+MLM+YT07m+z0POlwYNXF4L8ofnfXZy4u0wGBGFbaZhTGHAtjPAC8ngZTQev
         lhVRDIn4VDRFDZJVHsqo0mDaJYnnUVuVZzgjbgma9R/BSlg2Ejkf9OQVtDHKEGFbve+j
         FeCnO4Yk328RqRLDIwAtBf2ysBICS948Cafi9LVmemwfEniLBAhHgtwEbbS7eTRhb/Yz
         4PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543118; x=1714147918;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYJ1G6THEcze8HV6qNPokLaKgVvE2KbB4dc/k79IC8Q=;
        b=pMj1gsGG9o9qwIUOoXzh+ynk+dF+bZq+rG7wziE1Y+tl2GYLwX4zEOO+EaVbxIWChl
         zFK5UCpEq8Jno7bmDxO9uneUkQ8aAX26lGWE6c3WyErstOLdw7k+PSRJOy94Fm05ZEXZ
         85WFpT0dRAi5pbUcx7wVhis1fex5zxu58WObd5CyfpoUS3fiyvBV7WZslx0AIyxKS7lA
         OkHwiWpfjLxOQOf0B1J69eK4TX3y4CM9KGJwel2PXKrRMBez87rtNFG7rJtVe8kkUMab
         JfZ4J7fA07g8Rg1HgT29cX2YFtbLOEvQQor9tmdb8sk1s+x/+Q3xcy2g3rpPiOuGH3Eg
         qIDg==
X-Gm-Message-State: AOJu0YyxmM8VDsjvOhpcsR+bOJvRVjX7we/8wd90WKB3RjbHxoQkcbq1
	DA94+cdZdtLwlpAJsfd5er/SP/Su+MfWdyJema3tcdt/po7ttPvDRstrCOzuP5/+PlJn6EVncuu
	RZI0uvMH5b23KtRam634gQacpK72aP0pEmyPC2ir8Ezh0B4qQkBznLTWLDQL6mCuHozcuZym5Nq
	RNSBTGU1oFa/s8CCtqiFwpva3plJdg1/SsdjZaF7ks8FYuzigBsIx9
X-Google-Smtp-Source: AGHT+IHuqJ6fDnXePgWibwQg8qrPjCoaQNWEKwLlyy2KbeP1gomSkjsl8Zno26ZWu1ih/CLcKUSmw/5lUOY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5408:b0:56e:480f:c98c with SMTP id
 ev8-20020a056402540800b0056e480fc98cmr3192edb.5.1713543117257; Fri, 19 Apr
 2024 09:11:57 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:22 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-12-gnoack@google.com>
Subject: [PATCH v15 11/11] fs/ioctl: Add a comment to keep the logic in sync
 with LSM policies
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Landlock's IOCTL support needs to partially replicate the list of
IOCTLs from do_vfs_ioctl().  The list of commands implemented in
do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.

Suggested-by: Paul Moore <paul@paul-moore.com>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index fb0628e680c4..64776891120c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
+ *
+ * The LSM mailing list should also be notified of any command additions o=
r
+ * changes, as specific LSMs may be affected.
  */
 static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 			unsigned int cmd, unsigned long arg)
--=20
2.44.0.769.g3c40516874-goog


