Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5300ACACAB
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Oct 2019 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbfJCQOQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Oct 2019 12:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbfJCQOP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Oct 2019 12:14:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832032054F;
        Thu,  3 Oct 2019 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119255;
        bh=yj49ZFTGd94w6BIGaonON0vn7CB2KRR7SGrVAmFkRp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRbGsAJKKPzTuE6TLy7BthvDIVFl7RUwsq5c5t4kp7/+vJR/fWRb6Uqu/LHXhIwpO
         rj69LRBukA8fHuRFvSCWmG04p/Czc1m0AceNbybIEcIwXBIM/XMW6fMmKJxbZOcglv
         vrP06HpiaMzZ6H5nnmaWoBhQqocXOd37zBl5Rjls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 166/185] ovl: filter of trusted xattr results in audit
Date:   Thu,  3 Oct 2019 17:54:04 +0200
Message-Id: <20191003154516.782998221@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
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
@@ -265,7 +265,8 @@ static bool ovl_can_list(const char *s)
 		return true;
 
 	/* Never list trusted.overlay, list other trusted for superuser only */
-	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+	return !ovl_is_private_xattr(s) &&
+	       ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)


