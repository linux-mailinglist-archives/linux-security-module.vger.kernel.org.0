Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AB743326
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Jun 2023 05:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjF3DZm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 29 Jun 2023 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF3DZk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 23:25:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426535A1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:25:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668711086f4so884136b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG0p2NxJxfYPPHk57XaDb7PRgK5Ncrcc/zrK6bcWJBo=;
        b=bWbcBjLe/HmjBUDi0chJKHI1VfwXeVHFrwoWQ6d5F3ktM+1Hx4SU0oGAk43uPUCNJS
         fay+/AQYi1YyouUv9X87uiVa71QR3+42BgL6odKqwm0xDf4ur4NY6vRttiQcU8fa9H7C
         BbtQfAx2ouVJRy+ccgkoOOaFpSGcWKEme9h7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG0p2NxJxfYPPHk57XaDb7PRgK5Ncrcc/zrK6bcWJBo=;
        b=DVNmXkOwRm7QwgGi2RZk++3qF7ja9r+s8/h+n1a3dGpPnc8XJ6sUgrcpD9P5ocfZ/e
         TEDGOlcTDtN1GZ/Cna5Y27RymhEuA39VIu5WDzBHxsmaB1X/MHTi61QnV9qxPdYMYrlG
         fwAw0ifgHBVxD82x79Cuqqenqn6JszqwYBPa9x7HK5DlZy2kfbP6QKDciJ2hDNSYsdD0
         7q+EJ47Xd8yvX8P/x5eHhqejs8bzQa5vJPL5TDtN+wbc9tu10B18/Sh6CsFPoAxRk4qF
         VuNA1LHpm1WtGgIDtbePCxBfKIlpDzcwR6yZ432A7GvoEYfaoPHjzVlKD2poW2KH1UMf
         JB2g==
X-Gm-Message-State: AC+VfDwCWYYdDbC/Pd/CQ+VbCQ6zq1PV4dCenqohkxqumPS64ekAajdF
        9Fkz6lA9KWnbu1l/WKbiKvnV+A==
X-Google-Smtp-Source: ACHHUZ5TBCQc99UAuCTq/sSZmqcHuuEfzJMPoZsd6eNZgMDz7INWJtHCNyWIS/wMBM2hYLOZS6QS3A==
X-Received: by 2002:a05:6a00:27aa:b0:657:1fe5:eb63 with SMTP id bd42-20020a056a0027aa00b006571fe5eb63mr7433745pfb.7.1688095538633;
        Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id f4-20020aa78b04000000b0064fd4a6b306sm8973599pfd.76.2023.06.29.20.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 1/1] Documentation: mm/memfd: vm.memfd_noexec
Date:   Fri, 30 Jun 2023 03:25:35 +0000
Message-ID: <20230630032535.625390-2-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630032535.625390-1-jeffxu@google.com>
References: <20230630032535.625390-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 45ba1f4dc004..621588041a9e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -424,6 +424,36 @@ e.g., up to one or two maps per allocation.
 
 The default value is 65530.
 
+memfd_noexec:
+=============
+This pid namespaced sysctl controls memfd_create().
+
+The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
+application to set executable bit at creation time.
+
+When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
+(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
+be executable (mode: 0777) after creation.
+
+when MFD_EXEC flag is set, memfd is created with executable bit
+(mode:0777), this is the same as the old behavior of memfd_create.
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_EXEC was set.
+1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_NOEXEC_SEAL was set.
+2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The default value is 0.
+
+Once set, it can't be downgraded at runtime, i.e. 2=>1, 1=>0
+are denied.
+
+This is pid namespaced sysctl, child processes inherit the parent
+process's memfd_noexec at the time of fork. Changes to the parent
+process after fork are not automatically propagated to the child
+process.
 
 memory_failure_early_kill:
 ==========================
-- 
2.41.0.255.g8b1d071c50-goog

