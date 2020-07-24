Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6322D0C4
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Jul 2020 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGXVhQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 Jul 2020 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGXVgz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA1C0619E4
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2020 14:36:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so6126900pge.12
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2020 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snum0LDOOmwoCERcfxqLkgilyaEMJiIllHC/Y59Q/IE=;
        b=T2ncoDQLQlOZzMXhnR0wFJRriW5h7nmKcGWHusRRfC7lI6yGOzgH/DtKKi67QbPNfy
         mdxfj7DWeUjM2aNaUl5ZK4KoGKdFIO/PdlpbUzEaOHCqTWOHepJ0oX+ezARdf2+ejrjx
         BlfJZMuYgHFWSDVX+oY1w6U5ZgZe3dU7X2z14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snum0LDOOmwoCERcfxqLkgilyaEMJiIllHC/Y59Q/IE=;
        b=nHJEt3a4qOG+UmxcN74zgUsuJd90/oYchBmnu7kFutbN1aS60oyaqG9uJh4sqpGf2Y
         j9/oJfEWiEogopJ499sxxkK+8bps3cWNsvj+ukFT9CQUjlTUR6GiosGNjNJV7KCBIc+0
         j/qALoZriw211/gldXIKYK7ZQ6xUP15NbeHOyVQ6jy6EGWZeO0M49tV3N9Cg2pNme/Tm
         nuSQKTb0CHctLIZRdxh4a9Pu639ovqkCpKUT7QXYlZ8J+oyiOB0x8gW5YDu9C8mNjeAX
         hmv7bOsNyrYLW6PfZa+7Uo+g4kwQPXc1mA8WnXIkxWP+nMtlWa2hPog65Ia6ONgwtluM
         OYUw==
X-Gm-Message-State: AOAM531NaJ+JuJ0XoPNNHM0Swb2KWQub7w0vUS5SOJa9rurUUkYwEmMw
        aSreZs1WndW3QJqfu7/VwmhldA==
X-Google-Smtp-Source: ABdhPJy/mBvMTAyBEtuwHpXZDJfy+zSTFKZxLLmkzpdRD0qHuJg0JD8KD2Ox+IopIRqKgX0Tqr1jhw==
X-Received: by 2002:a62:1494:: with SMTP id 142mr10148083pfu.216.1595626614442;
        Fri, 24 Jul 2020 14:36:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br9sm6384670pjb.56.2020.07.24.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/19] module: Call security_kernel_post_load_data()
Date:   Fri, 24 Jul 2020 14:36:34 -0700
Message-Id: <20200724213640.389191-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d56cb34d9a2f..90a4788dff9d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2967,7 +2967,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -2977,11 +2977,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE);
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

