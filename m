Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1426DBC3
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Sep 2020 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIQMkX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 17 Sep 2020 08:40:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbgIQMkL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 08:40:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54A5E59A57131FDCA942;
        Thu, 17 Sep 2020 20:22:26 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 20:22:25 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <john.johansen@canonical.com>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] apparmor: Fix several kernel-doc warnings
Date:   Thu, 17 Sep 2020 08:32:50 -0400
Message-ID: <20200917123250.206639-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes the following W=1 kernel build warning(s):

security/apparmor/apparmorfs.c:2127: warning: Excess function parameter 'profile' description in '__next_profile'
security/apparmor/domain.c:1292: warning: Excess function parameter 'onexec' description in 'aa_change_profile'
security/apparmor/domain.c:136: warning: Excess function parameter 'start' description in 'label_compound_match'

Rename profile to p.
@onexec in 'aa_change_profile' and @start in 'label_compound_match' are not in use, Remove it.

Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 security/apparmor/apparmorfs.c | 2 +-
 security/apparmor/domain.c     | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5fd4a64e431f..f00a372be7b6 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2116,7 +2116,7 @@ static struct aa_profile *__first_profile(struct aa_ns *root,
 
 /**
  * __next_profile - step to the next profile in a profile tree
- * @profile: current profile in tree (NOT NULL)
+ * @p: current profile in tree (NOT NULL)
  *
  * Perform a depth first traversal on the profile tree in a namespace
  *
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f919ebd042fd..12a9d80cd63a 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -178,7 +178,6 @@ static int label_compound_match(struct aa_profile *profile,
  * @profile: profile to find perms for
  * @label: label to check access permissions for
  * @stack: whether this is a stacking request
- * @start: state to start match in
  * @subns: whether to do permission checks on components in a subns
  * @request: permissions to request
  * @perms: an initialized perms struct to add accumulation to
@@ -1277,14 +1276,11 @@ static int change_profile_perms_wrapper(const char *op, const char *name,
 /**
  * aa_change_profile - perform a one-way profile transition
  * @fqname: name of profile may include namespace (NOT NULL)
- * @onexec: whether this transition is to take place immediately or at exec
  * @flags: flags affecting change behavior
  *
  * Change to new profile @name.  Unlike with hats, there is no way
  * to change back.  If @name isn't specified the current profile name is
  * used.
- * If @onexec then the transition is delayed until
- * the next exec.
  *
  * Returns %0 on success, error otherwise.
  */
-- 
2.25.1

