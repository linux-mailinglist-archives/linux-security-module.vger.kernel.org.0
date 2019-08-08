Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8463D856F7
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Aug 2019 02:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbfHHAIu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Aug 2019 20:08:50 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37843 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389785AbfHHAIi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:08:38 -0400
Received: by mail-qk1-f202.google.com with SMTP id d203so2584576qke.4
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BzJTfX0sYPsZSKyjJWnAiNewKfNmb8++vKsSknaZcxY=;
        b=nJHg7sy82b57LQq6OZ5Pf4z3qb6gZmem/mTeHt5LmL/ZwHqh7qt371cdCMvAqVRODb
         bwZWz0T0ZOqhRlaeupaidr4a7bJMM+B4xYX67B5jWiaE2yNY81ExTPnuiPCyd4mCYcNq
         i8I+CcrVNTjxGO4n3pDZJ+7F93wOcwJuMuP8L2A4k1/vHi05KGWHeGV2VG2piwD+cpE/
         rggZZOn6CADIkZ33i6wNWnbZyKerxNimATuXIGYxfGICDUNduiyYt5tR+iYZCxAyOg3g
         XgXLWAfiGsatUaL9beVqeZdGiFZodkVInPxNZzO5DXKH4HZ63I1yh0B8lAyCS9zEKF1B
         h0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BzJTfX0sYPsZSKyjJWnAiNewKfNmb8++vKsSknaZcxY=;
        b=IDf7kIbt5SeMfaMbePlb9iDxe0/xcK4Sfu4tpO+yO5FFIcD8REzJvC0Rm1Ojwt5Nts
         uTvDCqs4yo4dhgChLyoocPpxMDKcsyG2W/PFjW7mSqYPS/efqRIRwVWAaFKPLU6VvQpP
         Vt5E5Oq7k9njVZzpsqA3aH4nOnokauDgOuatBC/qo/6pklwzKG1WLkn2nW442BVCNFMh
         OORKJAMUC9JGYlrFukd2g2VPBD5+X4sUnrm+EOs8kT3aqnaI5B3WYiVewJoT+em1hE3s
         ilM/1BWizL9seyx18365209m8XosehR5xkrXkp4ZkqBp6GZ17MvitqNSaOHnnDLK8O08
         mmdg==
X-Gm-Message-State: APjAAAV1aB+oeZgyK4AUY0s96Z6ZJm64qRyICYopImrPTWTzgclBW9yO
        +kzKj7uUI+sSSg+bEiTZu7eL2fmt7oLceTFNBugGsw==
X-Google-Smtp-Source: APXvYqyvZfkOri6UbL4qGMH2UeWvOCRGustMcDzwi5yLryEoH6XTQW9zJhcXl2bbpjl7+UMpQR03FtJUAmzCW+Wk9ekSlg==
X-Received: by 2002:ae9:ef0b:: with SMTP id d11mr10735109qkg.295.1565222917093;
 Wed, 07 Aug 2019 17:08:37 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:20 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 28/29] efi: Restrict efivar_ssdt_load when the kernel is
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

