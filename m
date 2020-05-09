Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74061CC0D9
	for <lists+linux-security-module@lfdr.de>; Sat,  9 May 2020 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEILUh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 9 May 2020 07:20:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbgEILUh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 07:20:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02D1B46098E61140D581;
        Sat,  9 May 2020 19:20:33 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 19:20:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <casey@schaufler-ca.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <tglx@linutronix.de>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Smack: Remove unused inline function smk_ad_setfield_u_fs_path_mnt
Date:   Sat, 9 May 2020 19:20:19 +0800
Message-ID: <20200509112019.54164-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit a269434d2fb4 ("LSM: separate LSM_AUDIT_DATA_DENTRY from LSM_AUDIT_DATA_PATH")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/smack/smack.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 62529f382942..f244c9d10004 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -505,10 +505,6 @@ static inline void smk_ad_setfield_u_fs_path_dentry(struct smk_audit_info *a,
 						    struct dentry *d)
 {
 }
-static inline void smk_ad_setfield_u_fs_path_mnt(struct smk_audit_info *a,
-						 struct vfsmount *m)
-{
-}
 static inline void smk_ad_setfield_u_fs_inode(struct smk_audit_info *a,
 					      struct inode *i)
 {
-- 
2.17.1


