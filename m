Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17907D102
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2019 00:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfGaWQl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 18:16:41 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55029 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbfGaWQk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:40 -0400
Received: by mail-pf1-f201.google.com with SMTP id y66so44179473pfb.21
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YL983DZYCsDH2/bxBW55mkIkXEZ4iV1BlOwZ0Y9UQbo=;
        b=BtsXIa2eTEgrtDB3YoZh0Vr0MqF3zG2HREwRJPT9j0PLXfgg2j3hG32IB5dfHPMy/2
         rm0uDDUk38QtwLylkx1PGSeLlU64Nva0fuH1JwNUQQUtkhm7QfgTLm2TKTf/7+OlZbSE
         fMXuJiJQwb9yTj6TCX6++29P/Sr4XGuR2UAS6+U8dUUzVj4VaEGg/YflN76TaB4J/tiX
         9P2rzS75rZnOJtKNVpeLvatDRMWkjQSQe5lvohC6vizpCaIU2VSR6OYNm/FVr5BdlKXj
         3mBodw3Mi95WtWxKxlSO4spjGTI5UzD68Uck0JfqLAxfMZdWLWt5aR3iMBTcoph2ExUE
         Px0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YL983DZYCsDH2/bxBW55mkIkXEZ4iV1BlOwZ0Y9UQbo=;
        b=QAvUT/fF9WbKES2LtUrfUguQZzbFwmuq7qyDmpexXlQXrUVjdW9fzf5IcNqwW7vP8D
         lt6gj3PDw4nJazMXe2bGPtf/E+0th00pXHJ9DggHeV53N5e9DNvNV797Fdczbk0aXMLi
         3tpYIFdYkjqArawINtWEc1H9tdT3gqFyewSNnaT8w0TdBKNii03XVzWupoQt6GCtvxYi
         FHzO29fUQNKGvewU9hBcx4+3Rhhoa1WTINr1jxylB/eHR1432g6Gl0suCGmHaQ5+0fMi
         Xwr8Iw5o7zUwfifP4hpy04s/ItaFuAjYLdEGKbAwzbG9qfeEtw09LyAUl6Ua1ScBPOy5
         IFjQ==
X-Gm-Message-State: APjAAAWAjXiGdVUUrfwg4O+K9YF/6G+hcdkgi1wEuli//MzdkAv/Xer+
        WKfzNosKkCATgbdwl5Z1zo4Xnx9nlSPaGNtdrWSdIw==
X-Google-Smtp-Source: APXvYqym1pasXsOwhBqWzoGZgVhOVBlOvMeVYgs8AnlFQw7KxjvustScOG1wWEkF3l3iPObYZMa3I6zo5k9FCZj91H7lgg==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr69696974pgs.288.1564611398925;
 Wed, 31 Jul 2019 15:16:38 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:53 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 05/29] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
---
 drivers/char/mem.c           | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..d0148aee1aab 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -29,8 +29,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/uio.h>
-
 #include <linux/uaccess.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -786,7 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	return security_locked_down(LOCKDOWN_DEV_MEM);
 }
 
 #define zero_lseek	null_lseek
diff --git a/include/linux/security.h b/include/linux/security.h
index 8e70063074a1..9458152601b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -104,6 +104,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2c53fd9f5c9b..d2ef29d9f0b2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

