Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EE4F26D
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFVAEr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:04:47 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45341 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFVAEq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:46 -0400
Received: by mail-vs1-f74.google.com with SMTP id v20so2855333vsi.12
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D0cR1P9fRxl7I0Frc/NTBEIf+XZBbF2jRPFJwWOLz+E=;
        b=FN6rV7g1wI/cQULj1NeHY25dTFSqkhZVIJO87pMC8h34LSqiJQhwzDrpYiiyO8S5jK
         5WuO9AZdivmx/IHth4tUCWQsu6aK1fXCa5IPsW5FyAyGqhS8o7SCfRLNWeyr907mEW59
         BAJPQagNPHWoiAygcQ0WsleyxggB3QLnTgAO+0Zr4NToG2qapy/zD98DVHT5+cl8/EFi
         akZMCzlatqaUHLdwExao4rabh18Lcd6oOW0GtIjJk38zWfTVsXKKAKOuzq3RsSad3pYx
         ZB4xF7cn+5hEak/ocAoFV8txF3GMIWM+p7k63J35lWdSBGYy+9L8ZWheJ2dRmhfe0fOx
         k6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D0cR1P9fRxl7I0Frc/NTBEIf+XZBbF2jRPFJwWOLz+E=;
        b=njt3UL14uAcpAaaL1TZ0kONE4rJTleiju6VQNt2/H23MzhngxnFdTQy+TeLBqT/ZWw
         440StxSyMIuMphmSPuZKbks/otJPGwAs5IDt5RMEuah95s+dKqwEkZ6C3C7NAu7LBNTq
         aWuBSJmT3SuVpgDTr1+8RS39HbJeudrTqUQwakUcSR8RabC7pEfYhrTHRzu0hufrzYNV
         fS5Z3zEwt7u3XsA3zFn9UMZv+FDGiVix6Zgw/vQdXVk1AX73WgKHd1IYdcvX9Ta0oqrT
         4Qm/p9BGMlzRZmAVI/BP8IBXgV87jV5Suh4w2pLcZdqCXZIskMSUJFHg/wWXKVQD2QOd
         B6fw==
X-Gm-Message-State: APjAAAVKSL1gPiB1yJ4kK6T1ic2gfJt+ZYd5w9p9rkhSo9ICYehTxSSy
        mF0cLAebH7qAyQQHqlWSNwSssxYXmdhdtkeTsIAc7A==
X-Google-Smtp-Source: APXvYqw4d96MTv19mVO5YEXSxlhDKP6hJERH9aHPkctv1fha/0XtsJ8LHhcPxfrH3Kta8gdSMFY016WdHwGhe4DrOfdB7Q==
X-Received: by 2002:ab0:7618:: with SMTP id o24mr14156916uap.39.1561161885166;
 Fri, 21 Jun 2019 17:04:45 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:46 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
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
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..379c53610102 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1578,6 +1579,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc2b5ee4cadd..03c125b277ca 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -90,6 +90,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 1725224f0024..7be3e8fb5847 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

