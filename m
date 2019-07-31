Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985447D0EC
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2019 00:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfGaWTC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 18:19:02 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56781 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfGaWRK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:10 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so44197134pfa.23
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dLYiAr9hqix+w29Ej2S74ESH31+c2YOxCuX5zuQe/lQ=;
        b=J+R9NUO+EGzhsAS+m7c7T6iL5dyKw3ljJgj6BiTleClCqjtCkL+kDdezdvcfJsGDJ3
         4cZ/Pja44HS7lRZcjKwU+essKoGJAGX49BZChnDX5eS3gUwv132EaOLiDNO5ingG5GjE
         Hltl6luJSw70OVN8qxNs+3AsY1u8GWtW5bBKTx6/LtlzUyenj1VnNDQo5j53whvNvE5S
         3f/HX7+8T9WT81XFNhC83MGeSW2rLzVeUBBdJUwfOrA1GWSDXG+SZizQGxgdAofeB7+V
         5mqdOiQZj3P1HA5clhctegxqzkvrJ15LJWEBdBUrocyOqFQzzQSuDIddJnpvNnIkBYoO
         sD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dLYiAr9hqix+w29Ej2S74ESH31+c2YOxCuX5zuQe/lQ=;
        b=jPJxQvKSCePHKdmFk86nb9Fe908Ai/N3Bw//RkC3QSY6dY2gcSA9RjlIwhVQxO6phe
         IOL+xJrDz7m9t3o9+dEDyIRfaJSNzD3jLY6CnBJReaK+7/2bY5HVVHN7IOBsDuatpKT0
         79eybL4TCy5h8RUmtJ3H+mhGdeYleF5c+qqI9K4gtqfXxbon4edjcsDsY5/Z3tFasgyB
         xMzcynONpP7OANPvDQR9JRxMvlln4ZpEzJuDnfKonF1kpUCutd6I7g5f496FqahLWk3F
         25Trw6R/M1Cn7GDGkEPS2Y/XpY6k8S73W+fS1StD2B7zn9cz/qRHabNq6IzU+vyyw49L
         TUpg==
X-Gm-Message-State: APjAAAUvo8Bx/Qc7xe/z1r3jwbOect9ADRpVtBiyZEdqCB33GPXCIhlc
        cn36qa4186nMXmqIiEXv0sMc6Pnb3xO5iZChbFX0NQ==
X-Google-Smtp-Source: APXvYqwQus0lJGImYcSy61wdfORdev9zJKBsUr+9s8EamtAjx/4lM5SZqKuI6SuBut2QwhBzvMi/sB17oQh+vRzaoIESNQ==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr107976504pgc.248.1564611429249;
 Wed, 31 Jul 2019 15:17:09 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:05 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..629359fe3513 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1575,6 +1576,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1c32522b3c5a..3773ad09b831 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -111,6 +111,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index ecb51b1a5c03..22482e1b9a77 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

