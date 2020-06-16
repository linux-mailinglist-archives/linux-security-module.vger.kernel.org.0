Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057211FAA6D
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jun 2020 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgFPHuH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Jun 2020 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgFPHt6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 03:49:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F746C008630
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 00:49:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n9so8031540plk.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXEYLD7af7LJOjB8xnPNTPrt+WaWXkTb11rPY8DaG9o=;
        b=h2BrY8BKMYCkCsU3ZiGHQqvWYu+MzqkLnnp8a6bzu9p+/NEaFXUfSdN4wBcE1aqXeV
         LA1oJJ0czwCl5t+MiPZRo6sJHzWOJHE16oztLq7Xpft20dvdV3hag8ApW2Y4RoJ5MLKb
         wvY/4ueFcil/Y8V4OtWUc2a6E2mKkX2HP0OWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXEYLD7af7LJOjB8xnPNTPrt+WaWXkTb11rPY8DaG9o=;
        b=TH9O2T2gdVsiYXJP31iKWdXfBl6MV846nvM2d3wZGBFc6WUXDqCjTOUtiIdb6460qI
         tF/AhUaYrqOAHCkQ4MqCFVNnXV6n+raULODlXDhGIryfPdov67CcxG5T1qQ1eXPpfHlL
         ek3meCuWXZSWVr7Vyat1GpV7/kp459D6MxJoBC4mezO5cyic7xdjCK5Pxd8UsMeuee9U
         pb+234p4TijmahWMF5QZCC2Tq43jQibiQ7KgLn9gJTokezgaxOrDUqPv/V5ohDeLd58O
         AQUXVpoj1GxfgIwwycEL6TheaPJ651aWqyElpfAkrrdnYrpNs1FMcnxgHSb1fFlJQ/rm
         AwwQ==
X-Gm-Message-State: AOAM533vigwcGL5t2eo/cyxC/rBOhOWIqikkop4Wgr+4cNY1CgtnjUkF
        jadYfnchVg6FAx1S08znNDGzbQ==
X-Google-Smtp-Source: ABdhPJws+IxzhfQqZ/B7NKXZPC6tuHYhP5yRNSlhuhhCXbsMlnjbimxI9zgc2yJDjJa4JxGBDknPEA==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr1033453plr.210.1592293789983;
        Tue, 16 Jun 2020 00:49:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x8sm1650796pje.31.2020.06.16.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 8/8] [DEBUG] seccomp: Report bitmap coverage ranges
Date:   Tue, 16 Jun 2020 00:49:34 -0700
Message-Id: <20200616074934.1600036-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is what I've been using to explore actual bitmap results for
real-world filters.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 2fbe7d2260f7..370b7ed9273b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -715,6 +715,85 @@ static void seccomp_update_bitmap(struct seccomp_filter *filter,
 	}
 }
 
+static void __report_bitmap(const char *arch, u32 ret, int start, int finish)
+{
+	int gap;
+	char *name;
+
+	if (finish == -1)
+		return;
+
+	switch (ret) {
+	case UINT_MAX:
+		name = "filter";
+		break;
+	case SECCOMP_RET_ALLOW:
+		name = "SECCOMP_RET_ALLOW";
+		break;
+	case SECCOMP_RET_KILL_PROCESS:
+		name = "SECCOMP_RET_KILL_PROCESS";
+		break;
+	case SECCOMP_RET_KILL_THREAD:
+		name = "SECCOMP_RET_KILL_THREAD";
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		name = "unknown";
+		break;
+	}
+
+	gap = 0;
+	if (start < 100)
+		gap++;
+	if (start < 10)
+		gap++;
+	if (finish < 100)
+		gap++;
+	if (finish < 10)
+		gap++;
+
+	if (start == finish)
+		pr_info("%s     %3d: %s\n", arch, start, name);
+	else if (start + 1 == finish)
+		pr_info("%s %*s%d,%d: %s\n", arch, gap, "", start, finish, name);
+	else
+		pr_info("%s %*s%d-%d: %s\n", arch, gap, "", start, finish, name);
+}
+
+static void report_bitmap(struct seccomp_bitmaps *bitmaps, const char *arch)
+{
+	u32 nr;
+	int start = 0, finish = -1;
+	u32 ret = UINT_MAX;
+	struct report_states {
+		unsigned long *bitmap;
+		u32 ret;
+	} states[] = {
+		{ .bitmap = bitmaps->allow,	   .ret = SECCOMP_RET_ALLOW, },
+		{ .bitmap = bitmaps->kill_process, .ret = SECCOMP_RET_KILL_PROCESS, },
+		{ .bitmap = bitmaps->kill_thread,  .ret = SECCOMP_RET_KILL_THREAD, },
+		{ .bitmap = NULL,		   .ret = UINT_MAX, },
+	};
+
+	for (nr = 0; nr < NR_syscalls; nr++) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(states); i++) {
+			if (!states[i].bitmap || test_bit(nr, states[i].bitmap)) {
+				if (ret != states[i].ret) {
+					__report_bitmap(arch, ret, start, finish);
+					ret = states[i].ret;
+					start = nr;
+				}
+				finish = nr;
+				break;
+			}
+		}
+	}
+	if (start != nr)
+		__report_bitmap(arch, ret, start, finish);
+}
+
 static void seccomp_update_bitmaps(struct seccomp_filter *filter,
 				   void *pagepair)
 {
@@ -724,6 +803,20 @@ static void seccomp_update_bitmaps(struct seccomp_filter *filter,
 	seccomp_update_bitmap(filter, pagepair, SECCOMP_ARCH_COMPAT,
 			      &current->seccomp.compat);
 #endif
+	if (strncmp(current->comm, "test-", 5) == 0 ||
+	    strcmp(current->comm, "seccomp_bpf") == 0 ||
+	    /*
+	     * Why are systemd's process names head-truncated to 8 bytes
+	     * and wrapped in parens!?
+	     */
+	    (current->comm[0] == '(' && strrchr(current->comm, ')') != NULL)) {
+		pr_info("reporting syscall bitmap usage for %d (%s):\n",
+			task_pid_nr(current), current->comm);
+		report_bitmap(&current->seccomp.native, "native");
+#ifdef CONFIG_COMPAT
+		report_bitmap(&current->seccomp.compat, "compat");
+#endif
+	}
 }
 #else
 static void seccomp_update_bitmaps(struct seccomp_filter *filter,
@@ -783,6 +876,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	filter->prev = current->seccomp.filter;
 	current->seccomp.filter = filter;
 	atomic_inc(&current->seccomp.filter_count);
+	if (atomic_read(&current->seccomp.filter_count) > 10)
+		pr_info("%d filters: %d (%s)\n",
+			atomic_read(&current->seccomp.filter_count),
+			task_pid_nr(current), current->comm);
 
 	/* Evaluate filter for new known-outcome syscalls */
 	seccomp_update_bitmaps(filter, pagepair);
@@ -2131,6 +2228,16 @@ static int __init seccomp_sysctl_init(void)
 		pr_warn("sysctl registration failed\n");
 	else
 		kmemleak_not_leak(hdr);
+#ifndef CONFIG_HAVE_ARCH_SECCOMP_BITMAP
+	pr_info("arch lacks support for constant action bitmaps\n");
+#else
+	pr_info("NR_syscalls: %d\n", NR_syscalls);
+	pr_info("arch: 0x%x\n", SECCOMP_ARCH);
+#ifdef CONFIG_COMPAT
+	pr_info("compat arch: 0x%x\n", SECCOMP_ARCH_COMPAT);
+#endif
+#endif
+	pr_info("sizeof(struct seccomp_bitmaps): %zu\n", sizeof(struct seccomp_bitmaps));
 
 	return 0;
 }
-- 
2.25.1

