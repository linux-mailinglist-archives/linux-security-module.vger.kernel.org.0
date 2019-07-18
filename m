Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29B6D511
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Jul 2019 21:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbfGRTo4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Jul 2019 15:44:56 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39322 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403817AbfGRTo4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:56 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so17219150pfi.6
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RmH/lQXgmHpT1wDdkDviRnHZue3oZYbqIfCTXvy7fCM=;
        b=sr+U+0BUhfEnXadfS3Td1uoyOy7MyzT1cfjoaE68UBw1WhRqNJMBFgpLkQFYR8CYek
         KMLLN+smdCN2smIEcLzxglZftb5hu87OZDSnHoh58j9iUJ9WtMY8gtatqIWRzLoReE4k
         rOXwOJJUY3pNC9LTVR+45zWViuky5wZ5OsqQmEH21XbkAZ2iczTBIY0BDe0O6ftn+0Nd
         N8VHxUEL9vzNp13MjZ/HenFMfJvjHjVq4+s9MH40Hv98la5iFc/+chgCT/UbR25vQQo8
         f1K5mSd6Q5IDsOeHHgZ8Jj3sZRtyFkxD9BOWOQoOTJwCQ5ZkVLIwSvMUjWHIe2vcYKG3
         IrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RmH/lQXgmHpT1wDdkDviRnHZue3oZYbqIfCTXvy7fCM=;
        b=icHRuK/m3iPlP7kIDl3paC9eodZmqzTmsYUgndHoc9f1bO4E0DaSxTQzNk/vBXt3gV
         lyaYrCijTdr26oDIE+JS2llCMkmzPpb/nMD5D7RXKSnYQywoT61hxiGm7vWsjkBVdqMP
         lvJjWC/C9veOIjaQG0RvKw6Un1J76J7nQ6lxzr5X5nEfdlZeIT/AdmNY+5nEWWsdm9TX
         tfwjlD+3ZiI4unpoXr4FyDkoXdZyejet+hoqaWiXAQEkKqhMwws+TEJL8aZNwD8DRR3w
         2RO6tP4Dc8fu+t89cKxBWlP0dQs0I0oJg7ydc5Pp7d5RGOvKrVGWctK4BSBoGnCHlzX0
         fUeg==
X-Gm-Message-State: APjAAAXW1jn7LcO3PRT9nHzfItDzUr1NIFpYxhn1bD60HqBJFqaaoz/u
        kRdjlIZyg7qaTomnwFCy6SUTSlFYm6Nf6x1VViXQ5g==
X-Google-Smtp-Source: APXvYqyeJB/q+rqGISfS2YyA1gmULiVA9NiMn8MYvGu0Kh+AP7Ivcdvfi4JVaIEOuKfNlKBPpuhBRNRFf/1QBiVgkwqkhQ==
X-Received: by 2002:a63:460c:: with SMTP id t12mr49204271pga.69.1563479094865;
 Thu, 18 Jul 2019 12:44:54 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:00 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b2ef4c2ec955..7031307becd7 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,6 +30,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
 	struct acpi_table_header table;
 	acpi_status status;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+	if (ret)
+		return ret;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
diff --git a/include/linux/security.h b/include/linux/security.h
index 155ff026eca4..1c32522b3c5a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -110,6 +110,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d99c0bee739d..ecb51b1a5c03 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

