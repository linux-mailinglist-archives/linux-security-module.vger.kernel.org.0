Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5FBCABC4
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Oct 2019 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfJCP7z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Oct 2019 11:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbfJCP7z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C441720700;
        Thu,  3 Oct 2019 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118394;
        bh=M5k0BU5EeWicDdY1kbiDXTopE3+Q1rOXUHpx4wMdFFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqJOsLlA57YvIQtyiNmMxH/ILJQ4lmXO9FdsziGMEew/X07/dBE8NNPqn3BMJWPLD
         LHvrCaSdAU4u4xvTq9PsDH+wTbUwP0E2CA5SEngclPPv643JGqpS/8HD4w0LzpvPVL
         0MiAFVI0timWAPl6CWfNlmWhya+GUhutdYi0JK/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 96/99] ovl: filter of trusted xattr results in audit
Date:   Thu,  3 Oct 2019 17:53:59 +0200
Message-Id: <20191003154342.358048872@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mark Salyzyn <salyzyn@android.com>

commit 5c2e9f346b815841f9bed6029ebcb06415caf640 upstream.

When filtering xattr list for reading, presence of trusted xattr
results in a security audit log.  However, if there is other content
no errno will be set, and if there isn't, the errno will be -ENODATA
and not -EPERM as is usually associated with a lack of capability.
The check does not block the request to list the xattrs present.

Switch to ns_capable_noaudit to reflect a more appropriate check.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # v3.18+
Fixes: a082c6f680da ("ovl: filter trusted xattr for non-admin")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -292,7 +292,8 @@ static bool ovl_can_list(const char *s)
 		return true;
 
 	/* Never list trusted.overlay, list other trusted for superuser only */
-	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+	return !ovl_is_private_xattr(s) &&
+	       ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)


