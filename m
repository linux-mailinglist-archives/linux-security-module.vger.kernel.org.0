Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1A32C311
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Mar 2021 01:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCCX7t (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 3 Mar 2021 18:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835207AbhCCS67 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 13:58:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8AC0613D8
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 10:58:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u17so28094371ybi.10
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8A+Vn1cjgQFOcnDW+QJHWNfY0Snfwko60G1y42Y3xgQ=;
        b=EpO/7HH81xcIMjmISnM93Lf1cTCniUoMKyu7mC95M0PrCQYm7LXCrQJFJxnhZLebYL
         7pgo4FkTt/mXEQZGUDVK60yhEbDk+l70ihk7fVZRA7q4x00fCo4K0ZLzvUGDVBUCJ/Ip
         XMq1817dtkxXcudmkwE9YXFa5LjA/esowmInvI2pZ8JnNxJ4EKkvy5wviOMspFd3DJJE
         WO7EY93hE9dI9+/koHkwJLl1Bja54aqa7WzriMyAQE1AIbkNDaRz1Gy29w6vUOJQSNRX
         Ov3RIk4m9opjmKSFTrlLQYe7ndJ/OAJuKsGAHDXeZtV2/2JBNiFf7obXAg8Vb1Pdkhkz
         ILqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8A+Vn1cjgQFOcnDW+QJHWNfY0Snfwko60G1y42Y3xgQ=;
        b=b7m0hIVsGhHqaHHmysPdMi4dCetwYRoPZ0805kjwjhTKG8I2BywiFfK2ZwkBMaEuKO
         QU9dBs1dXfs/Mroz6oMy4chsO0zYpss8BABugLULlrDUm6FcLijyTfKwVUwG5wIlJs0a
         fU4NNQDtGBUWzHjqs9mjZIqBja58BseK8ypL+397JY0PvYzjqJmWahfp8YFBvGQSwYRu
         dVJItdfi5wYZamibOyDUtZE9qBEcNw0AqRz2umzXQi69bzIikEeo3ouwR4r+oB7X1YIV
         rc58/mfKzVRhLG/gRulpXLjqYUmYTlA2V9+UJ0FhRYgYmI6dnqknZdiOktTsRcS7NLrv
         G+Fg==
X-Gm-Message-State: AOAM531hMYRs/i0AzkM1tAlhtwQ0Lw/0SBWE1I+qkA/b1bX/pHZTzy2Q
        HTsaSsWQr5Vx8mX3+xbQnl5k0PkJUaM=
X-Google-Smtp-Source: ABdhPJw5vqMC1rNuxjPhDpEuhkpA8XxV6s45QZbFWYlu/dQ45hxGXNv7dGL1NqqF16Ah3hvn7L52qLtxWkQ=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f028:1b0b:1705:8ebb])
 (user=surenb job=sendgmr) by 2002:a25:f40e:: with SMTP id q14mr1113934ybd.230.1614797898171;
 Wed, 03 Mar 2021 10:58:18 -0800 (PST)
Date:   Wed,  3 Mar 2021 10:58:07 -0800
Message-Id: <20210303185807.2160264-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        fweimer@redhat.com, oleg@redhat.com, jmorris@namei.org,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

process_madvise currently requires ptrace attach capability.
PTRACE_MODE_ATTACH gives one process complete control over another
process. It effectively removes the security boundary between the
two processes (in one direction). Granting ptrace attach capability
even to a system process is considered dangerous since it creates an
attack surface. This severely limits the usage of this API.
The operations process_madvise can perform do not affect the correctness
of the operation of the target process; they only affect where the data
is physically located (and therefore, how fast it can be accessed).
What we want is the ability for one process to influence another process
in order to optimize performance across the entire system while leaving
the security boundary intact.
Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
and CAP_SYS_NICE for influencing process performance.

Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Acked-by: David Rientjes <rientjes@google.com>
---
changes in v3
- Added Reviewed-by: Kees Cook <keescook@chromium.org>
- Created man page for process_madvise per Andrew's request: https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=a144f458bad476a3358e3a45023789cb7bb9f993
- cc'ed stable@vger.kernel.org # 5.10+ per Andrew's request
- cc'ed linux-security-module@vger.kernel.org per James Morris's request

 mm/madvise.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index df692d2e35d4..01fef79ac761 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1198,12 +1198,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_task;
 	}
 
-	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (IS_ERR_OR_NULL(mm)) {
 		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
 		goto release_task;
 	}
 
+	/*
+	 * Require CAP_SYS_NICE for influencing process performance. Note that
+	 * only non-destructive hints are currently supported.
+	 */
+	if (!capable(CAP_SYS_NICE)) {
+		ret = -EPERM;
+		goto release_mm;
+	}
+
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
@@ -1218,6 +1228,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	if (ret == 0)
 		ret = total_len - iov_iter_count(&iter);
 
+release_mm:
 	mmput(mm);
 release_task:
 	put_task_struct(task);
-- 
2.30.1.766.gb4fecdf3b7-goog

