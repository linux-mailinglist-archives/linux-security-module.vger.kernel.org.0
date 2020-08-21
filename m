Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83224E02A
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Aug 2020 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHUS5i (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Aug 2020 14:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHUS5Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Aug 2020 14:57:24 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C42C061798
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2020 11:57:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id 95so1615575pla.14
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2020 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jVLhG26j0g4oYt7jIfPtnDxpuHYDlj/214ZL14WP/Sk=;
        b=vwQVBiprHAiepUeziUAmXMPnXPrm21lsu9ZQLqwD/3Ekt6DeuCDlFHPbpPggU2JuSz
         M4ENMcaNUnHjBlf6EfU8sJ9Js3SsW7a8EGJn6BhHZ8nb1yz8FVtYOO81hItAEp/z6LlW
         Pfm2l+rkwHKhVaQsneS2lbzs43xjWbT/2syO+XMmE/Bo7eYZIfNVh/Ha1tn5jMSn4Klm
         KeBAbKZrLpHD9Zguk9n6wxyX+NYibZUyOBg1BQywTLQFhWxwkilzvaMX9qz5T7XeBZJH
         FQ3i471yBzS4Ds9g0kFL19LGi7oB+t4SH9Z9kMKzCtTsIxL4R5vtyQcfiDCpZ/4Wy+bp
         nW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jVLhG26j0g4oYt7jIfPtnDxpuHYDlj/214ZL14WP/Sk=;
        b=DWsVn9861yuso4nENtVMSweF5L1ZKQFhsjsHshVVMju39aLhkvzDPsY5n2dOVxY6Qc
         kgYLUhalczCJYDsBARVT5eJfs+hRRzGwextusVSANc0PXSM1mu+ynnESpdVaLLOeRW+5
         58W0tko8agAxflSj/l9AzHSyFYDquxVQkaQcQXyM+q+ZKFctpwYqZbjwqTh/qnaYo5Tm
         VqXoWx8MO1WWnnrPBKiG9Xc39H9liObENpa/FNIU3RYysrCdFMr4i8dW3TD6STccVwG2
         N+z2O1zA3FdlWZuoX1trxiNUUDxRw2AMuTPSkzN/H3qlZqgYVmhgxChEPF2kyoh43kVI
         FwLg==
X-Gm-Message-State: AOAM532cKZehnkqPLIrRDVNhyCmJrvNsiLYak+qK9/QbgJ0Ov5RQ5v7f
        ++bOZbCplMg3rHWdSZvO+OcxtIwJzLezFqFgtw==
X-Google-Smtp-Source: ABdhPJxmOnSni/US2BlY0LuzRn+aJGmH5W/FPDKUxNo3b7/sWxYRdDgcXUvUCZqVnrPR68eVnETAOW91SeIWZECakw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:77ca:: with SMTP id
 e10mr3494476pjs.150.1598036243267; Fri, 21 Aug 2020 11:57:23 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:56:45 -0700
In-Reply-To: <20200821185645.801971-1-lokeshgidra@google.com>
Message-Id: <20200821185645.801971-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200821185645.801971-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v7 3/3] Wire UFFD up to SELinux
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Daniel Colascione <dancol@google.com>

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>

[Remove owner inode from userfaultfd_ctx]
[Use anon_inode_getfd_secure() instead of anon_inode_getfile_secure()
 in userfaultfd syscall]
[Use inode of file in userfaultfd_read() in resolve_userfault_fork()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..46ea552fe7c4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -978,14 +978,16 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations userfaultfd_fops;
 
-static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
-				  struct userfaultfd_ctx *new,
+static int resolve_userfault_fork(struct userfaultfd_ctx *new,
+				  struct inode *inode,
 				  struct uffd_msg *msg)
 {
 	int fd;
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
-			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure(
+		"[userfaultfd]", &userfaultfd_fops, new,
+		O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS),
+		inode);
 	if (fd < 0)
 		return fd;
 
@@ -995,7 +997,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 }
 
 static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
-				    struct uffd_msg *msg)
+				    struct uffd_msg *msg, struct inode *inode)
 {
 	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1106,7 +1108,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	spin_unlock_irq(&ctx->fd_wqh.lock);
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
-		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
+		ret = resolve_userfault_fork(fork_nctx, inode, msg);
 		spin_lock_irq(&ctx->event_wqh.lock);
 		if (!list_empty(&fork_event)) {
 			/*
@@ -1166,6 +1168,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
 	int no_wait = file->f_flags & O_NONBLOCK;
+	struct inode *inode = file_inode(file);
 
 	if (ctx->state == UFFD_STATE_WAIT_API)
 		return -EINVAL;
@@ -1173,7 +1176,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	for (;;) {
 		if (count < sizeof(msg))
 			return ret ? ret : -EINVAL;
-		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg);
+		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
 		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
@@ -1995,8 +1998,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure("[userfaultfd]",
+		&userfaultfd_fops, ctx,
+		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+		NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.28.0.297.g1956fa8f8d-goog

