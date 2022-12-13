Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B053964AE55
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Dec 2022 04:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLMDkN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 12 Dec 2022 22:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiLMDkM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Dec 2022 22:40:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153861B9CE;
        Mon, 12 Dec 2022 19:40:11 -0800 (PST)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWPPH32PyzJqPH;
        Tue, 13 Dec 2022 11:39:15 +0800 (CST)
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 11:40:06 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
To:     <linux-security-module@vger.kernel.org>
CC:     <paul@paul-moore.com>, <jamorris@linux.microsoft.com>,
        <selinux@vger.kernel.org>, <stephen.smalley.work@gmail.com>,
        <artem.kuzin@huawei.com>, <hw.likun@huawei.com>,
        <alexander.kozhevnikov@huawei-partners.com>,
        <xiujianfeng@huawei.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: [PATCH 0/1][RFC] SELINUX: Remove obsolete deferred inode security
Date:   Tue, 13 Dec 2022 11:39:47 +0800
Message-ID: <20221213033948.73512-1-alexander.kozhevnikov@huawei-partners.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.219.174.70]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is Version 0.1. updated following discussions in
https://lore.kernel.org/selinux/CAHC9VhSogM2_WrOWTEJAeWz3Pw39fU5L3ioR8425Kxq-W7LiNw@mail.gmail.com/T/#t

 security/selinux/hooks.c          | 91 ++++---------------------------
 security/selinux/include/objsec.h |  3 -
 2 files changed, 11 insertions(+), 83 deletions(-)

-- 
2.31.1

