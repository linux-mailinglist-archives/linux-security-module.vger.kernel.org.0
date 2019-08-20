Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1467395252
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2019 02:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfHTASY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 19 Aug 2019 20:18:24 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33355 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHTASY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id r130so3533189pfc.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KEN1/621HMw7IMfp8Bhrbn/lMKb+FMpWN6y+R4B0zXU=;
        b=DnG3SLg+kryCv883pYqzrppk2z/DgKjwrD4Sghbocds356yt5bJDzjzQb1b+wveJDe
         1H79mW4g8luPWRTilF0N4iZ/U7F+W91vu3dXhCdCQZhqRx8+sFVTXbiFHFTKZXAewmB5
         46PiuAXySCSkliboNVn6zkBBwNsW0UkhHmUeR9+fwM4rBk4oq1wE2NCml1IQEsdPUxPj
         U8LftEt/jHOXe4DBSa4/VkbXgiMCFwq7AKbR5NVsLcT/uwzf2vvmZh83OgT0RNRBc7bZ
         V+ksZ0m0vn8rJUbVwZF0XuOrBWK7HDBzHHS38G68udbIipnGCbofxTBqMxOTRP4yP8Vn
         uH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KEN1/621HMw7IMfp8Bhrbn/lMKb+FMpWN6y+R4B0zXU=;
        b=ozdXAt9OftndEq0bhEceJFI5e1XjNhVF2LFmUXMCD4pDwKF9CZxLdBkzg3nxz7bkD+
         xxN43UFjFnDMKdb6NLsNpJxvjTnRUbck9AEhcsazsrTCxHDBYYQtmXJasXGUspaEWVn9
         1u0RWWpzsUIRHyd4Gbo2ULMGrlF56mzB7zkz7NmV/zBW0rqYhzOVFd1z5Fi7LjMv+WOZ
         lY/yFR0cUFd8e8t0P07mADgUpUQ0JDFIXzQxcPlk7SF5EC4T+YlovXGh+nGiqTGJ7Dp7
         RoJyqrSai5SyS5mLFtVGC8KrGSF5qVkDmISZXilScHnTwwLo30tqsBDJzVrQkfIVLGOC
         G9Iw==
X-Gm-Message-State: APjAAAVJqrKIw/JXPKzNOAizxS+fekW8CZWLNEDA3rNCZbomNV7ZWTKL
        xij1F2mvGywp3vUB2CHKyvI7yfk6rYrfCBf388uR7w==
X-Google-Smtp-Source: APXvYqzu5BEv2mtJKqJd6UcBWYswLbyp2Wvqob1sMe+SQF24ZfScjj7xKDwMAvtmGOpUZt7gdkbtAJE2Vkut4H1ejF1s9A==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr22292240pgo.221.1566260303010;
 Mon, 19 Aug 2019 17:18:23 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:41 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 05/29] lockdown: Restrict /dev/{mem,kmem,port} when the
 kernel is locked down
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
Signed-off-by: James Morris <jmorris@namei.org>
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
index 9e8abb60a99f..e5dd446ef35b 100644
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
index d8e42125a5dd..240ecaa10a1d 100644
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
2.23.0.rc1.153.gdeed80330f-goog

