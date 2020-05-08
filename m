Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13D51CA70F
	for <lists+linux-security-module@lfdr.de>; Fri,  8 May 2020 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEHJWl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 8 May 2020 05:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEHJWk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 05:22:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C541C05BD43;
        Fri,  8 May 2020 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dQWwowQZzF+sZwOgwUAsHjLJmSCQ+nMIyBlQWLSvPPg=; b=olPPvebgLSHNjuC6Rk6QAPIcKP
        BoVfkzI516eXvEO2vp1hVAtK5STLXpFefNyIXwN7JszvH9FXoVr/CdLDykp71LE5v5nPxCvwzumqI
        1ypE2tmEHIvuKCr6M7W94ITB/ZpInQlvXvI06NvooHcDsb6YY8DU59jDcvGwOuvoFoAAdS1y3yrfi
        q/hKup0NEAX9Kx6htRi4ZaTl7q2zNNC0q6eD+qC/oL/kaONcnl7JVO9yoPHeOtagp9ypu2T3ngBe/
        wcLge5FQ7NLaPiJTbycJFn/qrj6naIyi3yrGo6heJNMbEFCl/XSBT82D+7vT2WOHQekJR8zf9EKI8
        mtOkdS5g==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDM-0008LT-07; Fri, 08 May 2020 09:22:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 06/11] fs: don't change the address limit for ->write_iter in __kernel_write
Date:   Fri,  8 May 2020 11:22:17 +0200
Message-Id: <20200508092222.2097-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508092222.2097-1-hch@lst.de>
References: <20200508092222.2097-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If we write to a file that implements ->write_iter there is no need
to change the address limit if we send a kvec down.  Implement that
case, and prefer it over using plain ->write with a changed address
limit if available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 67a035782874b..8a55e81bd9ac7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -488,10 +488,9 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	return ret;
 }
 
-ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
+ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
+		loff_t *pos)
 {
-	mm_segment_t old_fs;
-	const char __user *p;
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_WRITE))
@@ -500,18 +499,29 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		return -EINVAL;
 
 	file_start_write(file);
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->write)
-		ret = file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		ret = new_sync_write(file, p, count, pos);
-	else
+	if (file->f_op->write_iter) {
+		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
+		struct kiocb kiocb;
+		struct iov_iter iter;
+
+		init_sync_kiocb(&kiocb, file);
+		kiocb.ki_pos = *pos;
+		iov_iter_kvec(&iter, WRITE, &iov, 1, count);
+		ret = file->f_op->write_iter(&kiocb, &iter);
+		if (ret > 0)
+			*pos = kiocb.ki_pos;
+	} else if (file->f_op->write) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
+		ret = file->f_op->write(file, (__force const char __user *)buf,
+				count, pos);
+		set_fs(old_fs);
+	} else {
 		ret = -EINVAL;
-	set_fs(old_fs);
+	}
 	if (ret > 0) {
 		fsnotify_modify(file);
 		add_wchar(current, ret);
-- 
2.26.2

