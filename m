Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3269C2D
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jul 2019 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfGOUAc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jul 2019 16:00:32 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37601 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbfGOUAb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:31 -0400
Received: by mail-yw1-f74.google.com with SMTP id f11so14497134ywc.4
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZEWny5IFVoAY7+7cwG/iN1wA0h299zlUxTBItvDj0ts=;
        b=Zfkc7JwT5DU9z/o6qruZxUvtSG5dHseEY5MyWv9EfNowXWpECqNH74HmrCMpY6Lsun
         3lxELHqfkmTXqStjmCVEcrC3IDwxUkHckii/7WySAhjlykpTyjBF/liwYjw9UnL/kVae
         6ClWIRuDpOr2LvVMtLUJHKoWljg+4Ia5S3WKrOGk7PtbLhtvrFnyIgSOjTwxG00RrlCb
         3oWH8ea4VF9Ft1q0IQz4DKN+4VMPrFH5nCiC93O9QyydA33KSjv/A+IzI++Hmng0T7tw
         9HMZSl3RRI4QVLFy5s5SjteInYvM820efwrlprc802kSCOH8bjGGcPa4+zTPM19yVLAS
         8Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZEWny5IFVoAY7+7cwG/iN1wA0h299zlUxTBItvDj0ts=;
        b=I7fVMOWmSXLZpDX5x+Hw3pP69TqK0ErUQboYHtqrdzzRCW4XhukfXO/qH+j7HyLKEz
         N14R3pM9QrY8/zjgslWdDugTbFOC08rw9ZE+RisRa+u3wtFBQOndfyABMma5L466NP7N
         9bqrMx5nj+fbQhAsguU3I//Jnn/NKgbEtyzpSSgSCMmFnUN+32HKpugXmjq87AwyjAGi
         bd7NvEp+mzMvrsSbsJkPL2UqMIjcjhvPGrZngzX1uGkIsVL+ZnETg4lcwZqau+08/hjs
         9fqNeR2mI5lPd+/PllMjet3xVfNvI6TYTfF6vH8D2w1SSEibKJiiP+9UFLszt/aJ/ngF
         soCw==
X-Gm-Message-State: APjAAAX09KdyeTYu788cmQyqVQURh/er0Gc4uu5zllE/zUR9+v2MkFMg
        gxjFjDvYxSwPLmJjG5nZhWT5fVgVNDbVbGYwFKPWmQ==
X-Google-Smtp-Source: APXvYqyzP/ucQqITruoZ0U+xlf6n9TF8TcpzkJcXEBuAaYKylOcVnzZ/5O1mjzra9mVwgBw/6PyLE7/KRPqtyFMjsNtNrA==
X-Received: by 2002:a81:1d05:: with SMTP id d5mr15971402ywd.299.1563220830741;
 Mon, 15 Jul 2019 13:00:30 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:31 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 14/29] ACPI: Limit access to custom_method when the kernel
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
index d99c0bee739d..67dbc5c70ea0 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

