Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69F61FAA61
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jun 2020 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFPHuA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Jun 2020 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgFPHtt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 03:49:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0376BC03E97C
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d8so8013451plo.12
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiCnefOEfqSi7wYDZ0Ly9qFUXTY1JQW6i7HQc69RyoQ=;
        b=IcgNnBPcUI4XxaHRZv+68h1umX7cyvIMCP36Q7y+O5a5sA6ytY5XtslKRv21o3+cf9
         X+FMmnNEztj2FpFUzVzclsbAf//w6fXPH21coPI4d9FweeYzdb0yM25T7mcIhl6EITHx
         x7tTwGEQtIjtktlXFsLdB31FXf9xbkZG5U6Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiCnefOEfqSi7wYDZ0Ly9qFUXTY1JQW6i7HQc69RyoQ=;
        b=pC0iQw/qUl9FbhYKiadyL/93bgMn+SBGV/DQgOsFMUiVtv0PQba7A6SbNAjA38zaYq
         V7pZdgmcxJBKtdQGwKJSVALoH0+DEzeTV2EKczkfZRtnGQcQFyWdGm+tOTlQjy6NMML7
         wgRsqqYEK1AfTM2r3Rct7xiY9eh0VoFq2/9Eh/gdHQKlRliF7rYwVi5oSgte8cIxdLns
         GNGBLiDpntC7o15BnMoeHazHB73Delu5f0IOrQ87n+BiRpLyNBJHav0WZ7+YNA/iHYvH
         M0d1Oaz7tWQl+7Bzx0iSIAs+hqser4ej/PwEH+N1gmIxV9OQ2rV/kxI7mvMtoM/DuvKD
         6TVw==
X-Gm-Message-State: AOAM531hKfQNA7Xr59DImOdmS2U6JryBhGOJgnoWRJWHt0GhJoWOSNyr
        e532tRZI9980t18+TugVr8bsLg==
X-Google-Smtp-Source: ABdhPJxhW3y6afh5FWceB3QtLHRl8svdq02t3gc51fHES1LTZe4hExYi0JoBBUl7YmojYiOSd5noTw==
X-Received: by 2002:a17:90a:4d4e:: with SMTP id l14mr1619537pjh.10.1592293784832;
        Tue, 16 Jun 2020 00:49:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1sm1612258pjz.10.2020.06.16.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
Date:   Tue, 16 Jun 2020 00:49:29 -0700
Message-Id: <20200616074934.1600036-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

For systems that provide multiple syscall maps based on architectures
(e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
a fast way to pin the process to a specific syscall mapping, instead of
needing to generate all filters with an architecture check as the first
filter action.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/seccomp.h      |  3 +++
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 37 ++++++++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index babcd6c02d09..6525ddec177a 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -30,6 +30,9 @@ struct seccomp_filter;
  */
 struct seccomp {
 	int mode;
+#ifdef CONFIG_COMPAT
+	u32 arch;
+#endif
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
 };
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index c1735455bc53..84e89bb201ae 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_PIN_ARCHITECTURE	4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index a319700c04c4..43edf53c2d84 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -268,9 +268,16 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			       struct seccomp_filter **match)
 {
 	u32 ret = SECCOMP_RET_ALLOW;
+	struct seccomp_filter *f;
+
+#ifdef CONFIG_COMPAT
+	/* Block mismatched architectures. */
+	if (current->seccomp.arch && current->seccomp.arch != sd->arch)
+		return SECCOMP_RET_KILL_PROCESS;
+#endif
+
 	/* Make sure cross-thread synced filter points somewhere sane. */
-	struct seccomp_filter *f =
-			READ_ONCE(current->seccomp.filter);
+	f = READ_ONCE(current->seccomp.filter);
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
 	if (WARN_ON(f == NULL))
@@ -478,6 +485,11 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		if (task_no_new_privs(caller))
 			task_set_no_new_privs(thread);
 
+#ifdef CONFIG_COMPAT
+		/* Copy any pinned architecture. */
+		thread->seccomp.arch = caller->seccomp.arch;
+#endif
+
 		/*
 		 * Opt the other thread into seccomp if needed.
 		 * As threads are considered to be trust-realm
@@ -1456,6 +1468,20 @@ static long seccomp_get_notif_sizes(void __user *usizes)
 	return 0;
 }
 
+static long seccomp_pin_architecture(void)
+{
+#ifdef CONFIG_COMPAT
+	u32 arch = syscall_get_arch(current);
+
+	/* How did you even get here? */
+	if (current->seccomp.arch && current->seccomp.arch != arch)
+		return -EBUSY;
+
+	current->seccomp.arch = arch;
+#endif
+	return 0;
+}
+
 /* Common entry point for both prctl and syscall. */
 static long do_seccomp(unsigned int op, unsigned int flags,
 		       void __user *uargs)
@@ -1477,6 +1503,13 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_get_notif_sizes(uargs);
+	case SECCOMP_PIN_ARCHITECTURE:
+		if (flags != 0)
+			return -EINVAL;
+		if (uargs != NULL)
+			return -EINVAL;
+
+		return seccomp_pin_architecture();
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

