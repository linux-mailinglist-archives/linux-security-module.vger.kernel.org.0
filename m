Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130A5E5368
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Sep 2022 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIUSyg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Sep 2022 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIUSye (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Sep 2022 14:54:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62ACE00
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 11:54:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b21so6563623plz.7
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ViFWE8rUGPahmQO2QhLJH1++s3o9nLBPv3NoSy15NQg=;
        b=J4XLQhN5fJick2CTLnFgqVsB0WVB8mRp9qiiQPvIe01XWRbwaf930Sn/GDQt74GgtV
         TVd3gUm7LnVgQgUjjvji+omlUDNpd/gjm7njKbdP7eRexBMe5KBryOQI0q/fsIS5y2VS
         4pgACHUyqD2Ny9cT9DE5WFvQHjECWKqPAxjrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ViFWE8rUGPahmQO2QhLJH1++s3o9nLBPv3NoSy15NQg=;
        b=tr2nNCfTqB9k9APAz7DhbqDUvbRhT2LeaLIwoFxu/UiH4iEj5GU92IjqsNoy48UyuA
         Axb9SJLG3Z7oNokdeV3xwtSUe9IU8OEG6q+g/4ZR+PdIufnu6hIQxi76NGiBANUAMIZj
         ZVOw15ABLVRJvh+8SJZfTm/9iG+7cox27YgaaFYDTOuGs+EjVLWb9GAksEvr9vuNEizD
         GZoFioPJXC0TCL1yiA2rqA0bgrlCODeqHRYQP5GAVEn9zJhOxH7pGNPpF/1f63o8p//g
         ZpxDW6a+RhDIHRZSjwMDtoBd2nXEoycEbDi0gngRv9VjxktUCrAsFUkVhxr/X+haZnGN
         ZUDw==
X-Gm-Message-State: ACrzQf0Sy1TYAFYGU3yxT2mbIEQ/AoU6M8WEA+HMPFr9YhLaOpwU6DRT
        h1O7W8GHbXzBrSp2xpkJ62Xlkw==
X-Google-Smtp-Source: AMsMyM5L2SYyoILQbW6sygnDjWLiJfwJGmrsuK6GFOlavVJgsCAQLpcTf9B5Q0vd1FNnph12l1t5gg==
X-Received: by 2002:a17:902:f68e:b0:178:3ede:a147 with SMTP id l14-20020a170902f68e00b001783edea147mr6029297plg.136.1663786472993;
        Wed, 21 Sep 2022 11:54:32 -0700 (PDT)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b0016ed8af2ec0sm2430838plg.29.2022.09.21.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:54:32 -0700 (PDT)
From:   jeffxu@chromium.org
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
Date:   Wed, 21 Sep 2022 18:54:25 +0000
Message-Id: <20220921185426.1663357-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@chromium.org>

This patch was originally developed by Luis Hector Chavez
<lhchavez@chromium.org>

For systems that use SECURITY_SELINUX_DEVELOP=y and allow permissive
domains. The audit log from permissive domains can be excessive in
practice, and this patch is useful to avoid the log spam.

Luis Hector Chavez (1):
  Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT

 security/selinux/Kconfig | 10 ++++++++++
 security/selinux/avc.c   |  9 +++++++++
 2 files changed, 19 insertions(+)

--
2.37.3.968.ga6b4b080e4-goog

