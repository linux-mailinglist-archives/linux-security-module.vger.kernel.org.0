Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76A9100D6E
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Nov 2019 22:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKRVJ0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 Nov 2019 16:09:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41538 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKRVJ0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Nov 2019 16:09:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so10968406pfq.8
        for <linux-security-module@vger.kernel.org>; Mon, 18 Nov 2019 13:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=brNqL6zVPSQ5JwzRtAwRvqEQVxU2P5eqAvSAOt7aHtM=;
        b=XQ6hYXLYNFdMJoP1GZVRliyiJQVEbteGvbXFZF1JTflyx/WMljc3NDpIeLFmJ3DWmp
         GG/P3cyqEgHEmUYIP3yH6SudKNm86c9ObEHQYLbq6Y+oKpxKqSBjL5rxns0mO231ltlx
         5EddBxhbWUcKPvULCBAfpmVdBQtRNgw5I9ezk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=brNqL6zVPSQ5JwzRtAwRvqEQVxU2P5eqAvSAOt7aHtM=;
        b=Fs5VyhI/Q4wL1mvi/Wu/7ZP/dH/S8r7SDD0oKbe2PQ3sh0ZGavCxGk8dBdFzFN6UG+
         jZKKplI83kBb4gZgofKChmL/bfiZo/JvLFGZO452nMlwJU5WohkclmLuoR93cBOqOC6l
         2GPuAiayLT6WhXoDlPiWF4Vj5Wmd6W5wwBdYvearDkFeaj5AMOtBaaJX+W1iIyUw4kp9
         dR3ZfOvKmbRLtDVWqEh8F67hw40/cRl5Ut/3tcY5HsppMUZo999Xoget1yuQ7edTPZXJ
         uB3nwOlVGdcOyzjYYoaEyfycoixCNCCL/wVR9fmkq5l8y3MH/hZyKjI25P83PkRE19XZ
         eCBw==
X-Gm-Message-State: APjAAAV0seWdVMsNxxx8Dhbla8IAdNR9jarCpn0GjI0kIdeSRm3HWRDW
        1yZTEDr2vt9Rt266zMy/qxh5Jg==
X-Google-Smtp-Source: APXvYqxwXeAUBUepsAEyBkqI42nmhRb0cKtGnZWmzakoUDnAD+nn1I2/bwkDIrKBj6rjEJFhXiDckg==
X-Received: by 2002:a63:731a:: with SMTP id o26mr1504137pgc.108.1574111363777;
        Mon, 18 Nov 2019 13:09:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm8346900pgl.73.2019.11.18.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:09:22 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:09:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        tyhicks@canonical.com, colin.king@canonical.com,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH] x86/mtrr: Require CAP_SYS_ADMIN for all access
Message-ID: <201911181308.63F06502A1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Zhang Xiaoxu noted that physical address locations for MTRR were
visible to non-root users, which could be considered an information
leak. In discussing[1] the options for solving this, it sounded like
just moving the capable check into open() was the first step. If this
breaks userspace, then we will have a test case for the more conservative
approaches discussed in the thread. In summary:

- MTRR should check capabilities at open time (or retain the
  checks on the opener's permissions for later checks).

- changing the DAC permissions might break something that expects to
  open mtrr when not uid 0.

- if we leave the DAC permissions alone and just move the capable check
  to the opener, we should get the desired protection. (i.e. check
  against CAP_SYS_ADMIN not just the wider uid 0.)

- if that still breaks things, as in userspace expects to be able to
  read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN, then
  we need to censor the contents using the opener's permissions. For
  example, as done in other /proc cases, like commit 51d7b120418e
  ("/proc/iomem: only expose physical resource addresses to privileged
  users").

[1] https://lore.kernel.org/lkml/201911110934.AC5BA313@keescook/

Reported-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/cpu/mtrr/if.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4d36dcc1cf87..9c86aeae1b14 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -101,9 +101,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	int length;
 	size_t linelen;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	memset(line, 0, LINE_SIZE);
 
 	len = min_t(size_t, len, LINE_SIZE - 1);
@@ -226,8 +223,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 0);
@@ -236,24 +231,18 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
 		break;
 	case MTRRIOC_DEL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
 		break;
 	case MTRRIOC_KILL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_ENTRY:
@@ -279,8 +268,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 1);
@@ -289,8 +276,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
 		break;
@@ -298,16 +283,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
 		break;
 	case MTRRIOC_KILL_PAGE_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_PAGE_ENTRY:
@@ -381,6 +362,8 @@ static int mtrr_open(struct inode *inode, struct file *file)
 		return -EIO;
 	if (!mtrr_if->get)
 		return -ENXIO;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	return single_open(file, mtrr_seq_show, NULL);
 }
 
-- 
2.17.1


-- 
Kees Cook
