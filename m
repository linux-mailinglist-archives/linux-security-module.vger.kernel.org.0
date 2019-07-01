Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 802774F26F
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFVAEx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:04:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46950 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfFVAEx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id a125so5316249pfa.13
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PrHz11Fkohxiw/KAEo+rgP52AAtQBps1BcwB0CKo3qA=;
        b=JFwCQU3VW6N8fQbj5QygplLOospCB4WZ2mimGCOP6n+WOhSurcQpgYKoX9iw+cZ2K6
         lfr0JV9a5FEYabcfgKFD2n6Oe6+2jlR6WwmG5IJWl6TSHGZbMzYhWldPaBoWulWPSt2Q
         n6nwq8yowPRfRHqRBFYCGiKeHVxfu8hk5JpXAy9ZSyUlF8mKnwxIGeYB/JaeT0mfCdVH
         jsnv53RcgGR+gNUsAtx76M4TpYdiprXQiVmjKDZ3WUiyWxBtk+IPYE4Tqu3u+i1Sl/Bv
         2XAbs7AoszictGZ1JEiOzfUFw9KrUEgZ3ZX1sk/r5opiNHJKIXKeADFd8BG+XePh9aML
         4/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PrHz11Fkohxiw/KAEo+rgP52AAtQBps1BcwB0CKo3qA=;
        b=PY7xZYPsLrF2knEUiZORDv+9/WCCLXY+mCHCHgFTspt+IgjSo9xwfv7CvDVQROqe2N
         KC5pUKWAF12Y19jrBW7QJb3JiknqJSUfYP0WNXC0lqHXELgmzCHdiI1Zv0DnWrLuBWpK
         prlA25Mb9A+F9Kn7f+vZPNtfJs5MDP5KtOjOPSYBddYseNH1XEFLeu9dG6zpBFw4b9dL
         KS45YQPkz7FmXXLnQOKDFcR+cNiS6vvRN4EGsDwK2gGscsN+6PUgKLmLA0HxEHF9wIfB
         wzNeQoKMfDsgDUPTJM0Hbj9blzgHGaw05qC1hfhDRVYU7qnZ/4rVEZ9xSbF0PJTXagBG
         5nEA==
X-Gm-Message-State: APjAAAV1eKSmgI+uTjzgGC+RFalq/YsNsBgGVaiMMEc0hRrw23z6G1lP
        1wnc4T1QR+nN0wJIOWY7OtwWOSFYg5P1yGYFqy8H2g==
X-Google-Smtp-Source: APXvYqxHPrRmaCO3xqjug+sv8qg9vhcJoBN5OdWTZlBjLu//lwEN4PjtXf5eSjG7q2BsNifXC/ydRjwvulqX9FFBZNjGHQ==
X-Received: by 2002:a63:6146:: with SMTP id v67mr15959623pgb.116.1561161892042;
 Fri, 21 Jun 2019 17:04:52 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:49 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 20/29] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c  | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..6b9486baa2e9 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -114,6 +115,10 @@ static void do_test_bulk_ioremapping(void)
 static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
+	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
+
+	if (ret)
+		return ret;
 
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
diff --git a/include/linux/security.h b/include/linux/security.h
index 88064d7f6827..c649cb91e762 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d03c4c296af7..cd86ed9f4d4b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

