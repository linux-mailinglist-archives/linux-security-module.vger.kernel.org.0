Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7631D7089
	for <lists+linux-security-module@lfdr.de>; Mon, 18 May 2020 07:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgERFzF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 May 2020 01:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERFzF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 01:55:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAAC05BD0A
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so3786300plr.3
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqoAMRX7wxsSb3WRBfGTpx7Vdjfk1DDyWehVnZdqaPc=;
        b=iPdCIuodVe5O6Y9ChtFIm2Hlao68lOyF+W/VygID/lC8nvKNzExgKWiDWDQYSfE6Ws
         NXGXi57yli53j0OKI6sOLP5g4xEhQxBEicn/cVDGcrAVLtT6zS31eXoxEgtA9D9CkEDb
         eTnreSfpze86cnK21joYmXHRajv47usyuyoV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqoAMRX7wxsSb3WRBfGTpx7Vdjfk1DDyWehVnZdqaPc=;
        b=gKLW/WfngWeslB0XY2RHQTb0IVO8q/cQbUoxC59zv2HCzLqME8WTJfZdJY84KxFxbc
         MOlFvion4E0OYYEV/240+MqEs58ioHqUNzFXBGtyk6ZLw0yHAPiBUU/pOU//apDRxigo
         pj0V5YT5feXGoWjkDFdQx/vthsOS9MXwJ6NF3qycTSgIZz8/ougFip6ih0LwrDciPrdg
         lSnvDSlwnbMGatVwL42ZJp2xnY5WLuu8tep/R6nnwXRubfCuoRBgvb8mdLGwECCVGlMB
         CHuN6b+le4L+b6qn5LF8rnD9Zbw0zAOyZHDUsPuqxcRbO7q3y3dfKd7gQekKi+Z9E2ZD
         AxVA==
X-Gm-Message-State: AOAM531Rwml8hzY5FPgffGgtf+gcNFp2/EwYb3RBAQfWs34whA0lzuuQ
        UBg/ANr1IgkHXinyV09ITiLsrQ==
X-Google-Smtp-Source: ABdhPJzqFQpSdN+uRCCkWVuBHptM2WUFgXL9WcyP7kLck5t9EEsmWDqczZXvSl+XuOCzmITNCTsZrw==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr10496035pjt.30.1589781304301;
        Sun, 17 May 2020 22:55:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18sm7591576pjl.14.2020.05.17.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] exec: Relocate path_noexec() check
Date:   Sun, 17 May 2020 22:54:56 -0700
Message-Id: <20200518055457.12302-4-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518055457.12302-1-keescook@chromium.org>
References: <20200518055457.12302-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The path_noexec() check, like the regular file check, was happening too
late, letting LSMs see impossible execve()s. Check it earlier as well
and collect the redundant fs/exec.c path_noexec() test under the same
robustness comment as the S_ISREG() check.

My notes on the call path, and related arguments, checks, etc:

do_open_execat()
    struct open_flags open_exec_flags = {
        .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC, ...
    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            /* f_mode populated from open_flags in alloc_empty_file() */
            file = alloc_empty_file(open_flags, current_cred());
            do_open(nameidata, file, open_flags)
                /* new location of FMODE_EXEC vs path_noexec() test */
                may_open(path, acc_mode, open_flag)
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        security_file_open(f)
                        open()
    /* old location of path_noexec() test */

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c  | 6 ++----
 fs/namei.c | 5 +++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f0c80a8b9ccd..a34093323aa1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -140,13 +140,12 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 		goto out;
 
 	/*
-	 * do_open() has already checked for this, but we can be extra
+	 * do_open() has already checked for these, but we can be extra
 	 * cautious and check again at the very end too.
 	 */
 	error = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
-
 	if (path_noexec(&file->f_path))
 		goto exit;
 
@@ -865,13 +864,12 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 		goto out;
 
 	/*
-	 * do_open() has already checked for this, but we can be extra
+	 * do_open() has already checked for these, but we can be extra
 	 * cautious and check again at the very end too.
 	 */
 	err = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
-
 	if (path_noexec(&file->f_path))
 		goto exit;
 
diff --git a/fs/namei.c b/fs/namei.c
index b9408aacaaa4..6bb1b6624bad 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3212,8 +3212,9 @@ static int do_open(struct nameidata *nd,
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
-	/* Any file opened for execution has to be a regular file. */
-	if ((file->f_flags & FMODE_EXEC) && !d_is_reg(nd->path.dentry))
+	/* Opening for execution requires a regular file on an exec mnt. */
+	if ((file->f_flags & FMODE_EXEC) && (!d_is_reg(nd->path.dentry) ||
+					     path_noexec(&nd->path)))
 		return -EACCES;
 
 	do_truncate = false;
-- 
2.20.1

