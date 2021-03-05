Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D77F32EEA6
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Mar 2021 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCEPWn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 5 Mar 2021 10:22:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2634 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEPWY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Mar 2021 10:22:24 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DsWZk14q1z67tqN;
        Fri,  5 Mar 2021 23:18:06 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 16:22:22 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 11/11] ima: Don't remove security.ima if file must not be appraised
Date:   Fri, 5 Mar 2021 16:19:23 +0100
Message-ID: <20210305151923.29039-12-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305151923.29039-1-roberto.sassu@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Files might come from a remote source and might have xattrs, including
security.ima. It should not be IMA task to decide whether security.ima
should be kept or not. This patch removes the removexattr() system
call in ima_inode_post_setattr().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 538ccbf972c8..45e244fc2ef2 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -532,8 +532,6 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 		return;
 
 	action = ima_must_appraise(mnt_userns, inode, MAY_ACCESS, POST_SETATTR);
-	if (!action)
-		__vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
-- 
2.26.2

