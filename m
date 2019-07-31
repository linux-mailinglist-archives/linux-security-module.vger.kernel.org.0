Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89E67D0C2
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2019 00:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfGaWRj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 18:17:39 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:46458 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbfGaWRj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:39 -0400
Received: by mail-vk1-f201.google.com with SMTP id j63so29956503vkc.13
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BzJTfX0sYPsZSKyjJWnAiNewKfNmb8++vKsSknaZcxY=;
        b=NQeE8brzaM3nBKem2ZVyyY3FlEol8+CrHwKsZLyG2nOLqNXrqwU1ggJ6taMJBGtcvu
         u7ivnCOY/vCLH1PL1/ogOR1ufcUTaOZ5A/mx04CAwV3BoOuxIBirZiRs95dk3JRblihh
         tXPBxMpECDPUl9yY6d9SLCc2j/+TY7PF7+dohxG/zRAacI1a3PqRwnerhdX3/TNysAoS
         v/R6NSDtkIvFt4+d+hrBiGHwm3+8hQa3NyNj3mVZY9VVwj/L7gOlu1B21IDKaq5Gi8qX
         tOMgZItvzzSlRYr4GQVKc1U79UZPz8SKxqxaYhkJRhn4p2NfwVnpKyTpZK6Vvz1uJwiT
         QjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BzJTfX0sYPsZSKyjJWnAiNewKfNmb8++vKsSknaZcxY=;
        b=fOWyrJy8vm5fG/1vxXGNAH1jIk69QS3SEsKQtwbZAj9dRdpw9sKAIb1OfAzyHO+TOf
         wwStZahySpJi/blgfbyyhBOdmzyJelrrLSQZl0jw/hTf34to8ExL6tI1OfQfQ9Qepx21
         PXENMxNfEz0slfGQjVMb/fba2OaZQ6HU7aj9R2zhN/W2xB8Yr4k4Md+rlIK1vSDsgteX
         z8/xYRtYkrgN5qF4C4Xr+QFAnPs399oN8K1DCWbb6zP+MRdTViwFhGdAAuUhlaB4BQeY
         P3HuQzfBVE7bKaAXrals43n1JnvlnfL237LKgGx9j11wEdGr1RA+4AwwFnDRmJidWGF7
         e/6A==
X-Gm-Message-State: APjAAAUjibi3BgRsXmwy30e5qNLhKOY7RKQKsZ490lT4VV4tgHwAZ6E3
        xvO+uGTsNKIPdmnbrhXMYNlnbNihHKYq7P3Re1SE7A==
X-Google-Smtp-Source: APXvYqxXL/N38PSOgMKwgKt2xZvaRoxQEDDLyN7w15v7c2XIakO5nBHL6rYO8tJ55Q7U2Z/pstfcpGH7UN4+XC4dCW0dhQ==
X-Received: by 2002:a67:8907:: with SMTP id l7mr80628361vsd.194.1564611458042;
 Wed, 31 Jul 2019 15:17:38 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:16 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..776f479e5499 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.770.g0f2c4a37fd-goog

