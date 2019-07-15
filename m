Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6769C41
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jul 2019 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfGOUCj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jul 2019 16:02:39 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35627 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbfGOUAK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:10 -0400
Received: by mail-qk1-f201.google.com with SMTP id 5so14730229qki.2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eu667FWqsyv1eiS+2MgLd1pI1Yi90NnjxQ1QKJHeSZs=;
        b=Ly3WMPXU1S4RyjVKw9rxuEW+oUhZzw9lqnq9BFk1blOsZzlx/rv+LHMtWwkLypsNsx
         xt5ySUIqKJcr2jhA4IxpsEio1sZN2ApfyF8YkWF2rTk9JRLWdO+EDXKFGtk9/Hk/swju
         sd96PlDKVvhKzefI9kwmhbQGiMg1JMKrirK+n0sTUK2AqbqHWilAYbF7KCFH8y7SWqwq
         E7vPiwA5s8TjPUrxfIczXqHjBQtJNa3meRsTMYOaYy30NqAvW8svCofDEcOSQgL+ST08
         6g2Yaua9ngtJj5E574QVzroVOioZSTkRPYWXHp9zVKq8+iIIKNmi9s0OOSF4e4mVx3X9
         HwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eu667FWqsyv1eiS+2MgLd1pI1Yi90NnjxQ1QKJHeSZs=;
        b=EOdNtC4WimO8ifBW4/7Q3NR+tq3CDfpAZEUiMAqgUHdXnHUm7zN/Dfc2WE2BhHrlU3
         oMc4/iXQfNG08RMaZAkP0VFi4tEu0DyFeLXh4KiuZ4Bht7H5iYcxcwPJ5Psi/Wkc+mkJ
         hv01X4F+ChXiOd3ZNb18Xwo8rMfylM79ALMcv5AZcVloDWFi8VYW5CcfLws963NtiYWs
         /8e62NE5qyMd5LAYqyLooioT9V5kLDloUIyb9nRsr9dTG6QypMRPhrBiRLW4cKIN4/yO
         vSAMI6hM9JUNLJFGggn1nlVN1yURGxXV8WJIpIvqlh1jaWfzMHP1MQsYr7pf+fCD4cP8
         m65Q==
X-Gm-Message-State: APjAAAWd40t6iIOg2kjFaSmMDGBLvwOIpAod/XwvjjvJMhmK19PEBJoC
        +T9DMJf7kOdam3k4r5N8kzYxmctQMy26Dx6KyxuQYA==
X-Google-Smtp-Source: APXvYqy7oiu794xVtd5fUDkrGDGk/p0p31oCH0KAa0a2Zo9FPzjquLWnnXJBeY4GZfWjZ6zXgQvIPVxrTG9JXHGjBxXoDA==
X-Received: by 2002:a05:620a:142e:: with SMTP id k14mr18219466qkj.336.1563220809135;
 Mon, 15 Jul 2019 13:00:09 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:23 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9458152601b5..69c5de539e9a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..bc933c0db9bf 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -205,6 +205,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	result = security_locked_down(LOCKDOWN_KEXEC);
+	if (result)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d2ef29d9f0b2..6f302c156bc8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

