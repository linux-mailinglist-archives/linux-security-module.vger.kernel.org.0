Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD681DE6F4
	for <lists+linux-security-module@lfdr.de>; Fri, 22 May 2020 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgEVMdf (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 22 May 2020 08:33:35 -0400
Received: from mail.astralinux.ru ([217.74.38.120]:52373 "EHLO astralinux.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729446AbgEVMdf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 May 2020 08:33:35 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 08:33:34 EDT
Received: from [46.148.196.138] (HELO mastykin.cct.rbt)
  by astralinux.ru (CommuniGate Pro SMTP 6.2.7)
  with ESMTPS id 1973379; Fri, 22 May 2020 14:33:14 +0300
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
Cc:     dmastykin@astralinux.ru, Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] commoncap: Make cap_inode_killpriv ignore other LSM xattr
Date:   Fri, 22 May 2020 14:32:25 +0300
Message-Id: <20200522113225.29980-1-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Other LSM may set own capabilities to files. But its inode_killpriv
hook may not be called because cap_inode_killpriv breaks
the chain returning -ENODATA on remove xattr other than
XATTR_NAME_CAPS.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
 security/commoncap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..0c12ecf5676f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -314,7 +314,7 @@ int cap_inode_killpriv(struct dentry *dentry)
 	int error;
 
 	error = __vfs_removexattr(dentry, XATTR_NAME_CAPS);
-	if (error == -EOPNOTSUPP)
+	if (error == -ENODATA || error == -EOPNOTSUPP)
 		error = 0;
 	return error;
 }
-- 
2.23.0

