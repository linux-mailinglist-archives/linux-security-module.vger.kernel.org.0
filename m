Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B505123243C
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jul 2020 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgG2SAW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 29 Jul 2020 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgG2R6z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jul 2020 13:58:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891BC0619D9
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 10:58:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so12151361pls.5
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HjX3I6MUip4Fi6mrcrqGUTu4mjaatj7TaSRJ7Kpnbs=;
        b=JouYoLibHzxGq9Tia/G2XKM0Pb5E4nYUOUqYs+MPZGp5GijUgb3iUjYeu+cELUFDdt
         H303xAy/Z1MSIR/9N8m0lErdSoQqpTF5RIVZtd8SuoBzkXTHkDJMSLw+61XEXxzNcQZi
         cw+HoU5EWlrF4bw436jtimiB3q8pMUyiGckyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HjX3I6MUip4Fi6mrcrqGUTu4mjaatj7TaSRJ7Kpnbs=;
        b=PwWqw460aZU4qogv06Sqp2s/DIvS0GDt5SJ5oYzcBxIKDIkheAMCiXmjIBfHSaouPA
         6cfAvkSVMv44IBUV995NBO1uRUnaWQm0U77i+XirYhl7O2KNab8HwD1n+u12v5trubOW
         3mfVgKmGSXjlIxYHplbI2X7/KSW93gSwtRwsagNL4SubGliea97RGK+ov3NIGmT3Uj3z
         jN+5MyUzWQwmh4Dr3Szcr7IjaZmCLd1ZtI6nF5tgGxgp+twSjjnmVOpMY8tf+UUnwbyO
         SxffdoSGANAWc5B1H2mfuoCu8aOoSV7kNwGpF/19oUCExkXif57OWyYw5Yk0GDcGC9vv
         dWhQ==
X-Gm-Message-State: AOAM5322nEMPx0EyndNsY2pfyAhTt29nf4mWH24pgw2mONDR8Nkb45PD
        pAHXWdvu7gV9EQnt3sXemPeQ6A==
X-Google-Smtp-Source: ABdhPJzOQSPyPPbca4bdXvhVQPbDmuxdTaAXuuAwi3ioxNYnjv4nD6uGvsUE0we+fUNaZtSsT0xvhQ==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id gt23mr11119581pjb.0.1596045535204;
        Wed, 29 Jul 2020 10:58:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y196sm3166458pfc.202.2020.07.29.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:58:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, Takashi Iwai <tiwai@suse.de>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/17] fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
Date:   Wed, 29 Jul 2020 10:58:31 -0700
Message-Id: <20200729175845.1745471-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
should not be distinguished separately from just "FIRMWARE", as this
confuses the LSMs about what is being loaded. Additionally, there was
no actual validation of the firmware contents happening.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
Cc: stable@vger.kernel.org
Acked-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To aid in backporting, this change is made before moving
kernel_read_file() to separate header/source files.
---
 drivers/base/firmware_loader/fallback_platform.c | 2 +-
 include/linux/fs.h                               | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 685edb7dd05a..6958ab1a8059 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+	rc = security_kernel_load_data(LOADING_FIRMWARE);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f34d47ba49de..0d4f7aacf286 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2993,11 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-/* This is a list of *what* is being read, not *how*. */
+/* This is a list of *what* is being read, not *how* nor *where*. */
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.25.1

