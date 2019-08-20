Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730EC952B1
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2019 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfHTAS1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 19 Aug 2019 20:18:27 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40522 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfHTAS1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:27 -0400
Received: by mail-pl1-f201.google.com with SMTP id s13so2937220plp.7
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aETaOEPelySVl3QKK9Qr+qOWAsUAyXrm7SwwhN9vG4c=;
        b=KhujlyI2R6CEvYLT/F0SfZBAYudHduHuG5bZC22M5mysowFDhbeQ+KtmAa2GL+arTd
         ftXTboaJS5SyEuwjIFnjLzFD3F1edbJS+pifqs9WbNF9zE/hyk6bk+GHH5cqSmJPImAW
         9Cavog1sTHJeQrWVJgdqMWImMQMxJFER0njBKXSFJMCBMzAX2DjrIIB05xDViM7bEXC6
         Tolcpnnock/s2dnEVBo4OaAKzHAQ4bXrZLiRP/b1kKxHg9G0JLEAtNuA8C5e+3eNGEh9
         yXCIfRVuj2JYvB/WKS9SEa1/3vFVqnmUa8t7IVZi8dFGhhhyFvgweYkxnUpU0ufI66MY
         ZcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aETaOEPelySVl3QKK9Qr+qOWAsUAyXrm7SwwhN9vG4c=;
        b=hQbmdqfg+H4hRQrYAFQ/qNs7vMAUq3XzisQc2lOc0T+S1a/uYS26f3dkS4gh0quPUw
         vglD0tMdaFPBdj+whT4KS5iX63QYlHYAkDQIv+FD0A4fMDnOuhGYvw4xiZkuZUzNkC6N
         5ZCYlgMm2Bb3K0gzpUohR4Q7ezh6Ult8ndaFRzWEqu6SdiwRllJ/vKl7g8C/LmeM9ZqC
         xWq/vTejQO1Yjs65IVTp9daYmVO39ZsXjteCfk39T3Do3A7AwhaoTASOZb06RSuRO0uo
         bMxANODZUU6lS8ZI1eEM9GOrUFMWhwph5XYhI4AOSh56YD6DF/cJFKbPHuFEbl5Z4rv4
         jnJA==
X-Gm-Message-State: APjAAAUaEBmrJvvucoAMvfH0dTxgPq6ZBZXjXhdXV+PaF5bM1iroyCP9
        NGIrKVpLVEDIpcGIJ2c7PHpDrh2r7oXYiAOezsuoyg==
X-Google-Smtp-Source: APXvYqxt9fKQKKi62I+GkCF0wfAZRlblyWdliDLN4eHPxebId9zCOjr5b3+iDLV02ahbYcnIO+WGHbzpGbSnhPlGkECVJA==
X-Received: by 2002:a63:ff03:: with SMTP id k3mr22704545pgi.40.1566260305794;
 Mon, 19 Aug 2019 17:18:25 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:42 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 06/29] kexec_load: Disable at runtime if the kernel is
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
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index e5dd446ef35b..b607a8ac97fe 100644
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
index 240ecaa10a1d..aaf30ad351f9 100644
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
2.23.0.rc1.153.gdeed80330f-goog

