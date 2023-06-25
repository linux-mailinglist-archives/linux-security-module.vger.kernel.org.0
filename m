Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2373CDA6
	for <lists+linux-security-module@lfdr.de>; Sun, 25 Jun 2023 03:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjFYBNy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 24 Jun 2023 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFYBNx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF9B8
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:52 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QpXz33DRszTlBb;
        Sun, 25 Jun 2023 09:13:03 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:13:50 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next 00/11] Fix kernel-doc warnings in apparmor
Date:   Sun, 25 Jun 2023 09:13:38 +0800
Message-ID: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix kernel-doc warnings in apparmor, thanks very much!

Gaosheng Cui (11):
  apparmor: Fix kernel-doc warnings in apparmor/audit.c
  apparmor: Fix kernel-doc warnings in apparmor/capability.c
  apparmor: Fix kernel-doc warnings in apparmor/domain.c
  apparmor: Fix kernel-doc warnings in apparmor/file.c
  apparmor: Fix kernel-doc warnings in apparmor/label.c
  apparmor: Fix kernel-doc warnings in apparmor/lib.c
  apparmor: Fix kernel-doc warnings in apparmor/match.c
  apparmor: Fix kernel-doc warnings in apparmor/resource.c
  apparmor: Fix kernel-doc warnings in apparmor/policy_unpack.c
  apparmor: Fix kernel-doc warnings in apparmor/policy_compat.c
  apparmor: Fix kernel-doc warnings in apparmor/policy.c

 security/apparmor/audit.c         |  1 +
 security/apparmor/capability.c    |  4 ++--
 security/apparmor/domain.c        | 10 ++++++----
 security/apparmor/file.c          |  6 +++---
 security/apparmor/label.c         | 20 +++++++++++---------
 security/apparmor/lib.c           |  4 ++--
 security/apparmor/match.c         |  4 ++--
 security/apparmor/policy.c        | 17 ++++++++++-------
 security/apparmor/policy_compat.c |  1 +
 security/apparmor/policy_unpack.c |  2 +-
 security/apparmor/resource.c      |  8 ++++----
 11 files changed, 43 insertions(+), 34 deletions(-)

-- 
2.25.1

