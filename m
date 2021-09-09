Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652C340549E
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Sep 2021 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353809AbhIINAm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 Sep 2021 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356152AbhIIMxL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Sep 2021 08:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B1BA6322A;
        Thu,  9 Sep 2021 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188658;
        bh=EEHQ1d8gR7F3f2HKF5MPibPuc1dcWw0bigEbiiBw87s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9GS6DC0fytGQVCXmp7JGP0OjNcRc9JQ8JsdevMJGjVW9k2kUpasbCnlsHoiQMqoo
         NDlgMsaXBvCdY7QHKVfP/7PujXrALomxJba7Sq5LAhJY6TAS7c9hjJzC2wXa6/1aQ1
         H/LOpsDDyZ20/b2AyR81Kt1q0e1L1bx+7giRRXzaPmpc0gRPjW7PpMU5H8vsawI406
         rEKrp23imJwULveUOZlXryeCpt03A7AwaJMHYCYUlGXrkOA8iM8ZuDzt4gitsMN1+b
         +++9lcXPEsY/oDLEPua00ses/UgieZfFdTqV6yVUv9Uon18aHelIxe0iIGnDB3c75J
         GsLS+kUPeSytA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/74] Smack: Fix wrong semantics in smk_access_entry()
Date:   Thu,  9 Sep 2021 07:56:21 -0400
Message-Id: <20210909115726.149004-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115726.149004-1-sashal@kernel.org>
References: <20210909115726.149004-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

[ Upstream commit 6d14f5c7028eea70760df284057fe198ce7778dd ]

In the smk_access_entry() function, if no matching rule is found
in the rust_list, a negative error code will be used to perform bit
operations with the MAY_ enumeration value. This is semantically
wrong. This patch fixes this issue.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_access.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index a7855c61c05c..07d23b4f76f3 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -85,23 +85,22 @@ int log_policy = SMACK_AUDIT_DENIED;
 int smk_access_entry(char *subject_label, char *object_label,
 			struct list_head *rule_list)
 {
-	int may = -ENOENT;
 	struct smack_rule *srp;
 
 	list_for_each_entry_rcu(srp, rule_list, list) {
 		if (srp->smk_object->smk_known == object_label &&
 		    srp->smk_subject->smk_known == subject_label) {
-			may = srp->smk_access;
-			break;
+			int may = srp->smk_access;
+			/*
+			 * MAY_WRITE implies MAY_LOCK.
+			 */
+			if ((may & MAY_WRITE) == MAY_WRITE)
+				may |= MAY_LOCK;
+			return may;
 		}
 	}
 
-	/*
-	 * MAY_WRITE implies MAY_LOCK.
-	 */
-	if ((may & MAY_WRITE) == MAY_WRITE)
-		may |= MAY_LOCK;
-	return may;
+	return -ENOENT;
 }
 
 /**
-- 
2.30.2

