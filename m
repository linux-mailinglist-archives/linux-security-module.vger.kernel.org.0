Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2702852AEB1
	for <lists+linux-security-module@lfdr.de>; Wed, 18 May 2022 01:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiEQXfK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 17 May 2022 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiEQXfI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 May 2022 19:35:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B44527E0
        for <linux-security-module@vger.kernel.org>; Tue, 17 May 2022 16:35:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so611946pgc.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 May 2022 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDud8QpcHOOGMYFVwG6KRCTw7kIHDGrPd+sI68v2xZg=;
        b=GPXx2iWGpvjahWJ/eNt1vuxX+XfXwsKDhFEE5llZ+iBUQkHBDl8Q1os/RQzkoSp4Xw
         oTtcxIKjZMu/LrvUzup2xopqBZYgA6GQbmmxYEoGNvGbf76Qscn6owliQXAnB1t6K2DR
         4P2qMtKQ+M3+qEFrUp0umfBe7sJ+lxeus7J2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDud8QpcHOOGMYFVwG6KRCTw7kIHDGrPd+sI68v2xZg=;
        b=7NwFgwLOIl02bKs8NguJQNWDcphIP8bYL7+8IoNPG0DYqFd9a6w4bnseSmR7h0aTfQ
         uSu7T8wqcMu0NUMfOkXv5cdlZIyV4t+Tcf5JJBdMiTrfMM8G4anglJjGzSAqnmmjKpbl
         ka0rHRqIUEN309Uiqmd+XUNWbsHq3zvwp9/0I5BWP8XWrF5ufbWjL1riX49fdVQF5aXb
         HmNv3hZfLqwB9b+e3yKpr4YQLexIgwRuYg9oU1/OjLtOEgloAP8IiMyiFJ68jaDwCKNn
         S4wUZaKzYht9GSrc9FaDvf8zYXlwdpOA1ekyr6MbRwWhVVWVmujl68+a0J4/ZrioblX+
         jgHg==
X-Gm-Message-State: AOAM531X1sJoZGeqzWmre/EqJTV645z6vIFjtllm10BdCrCWtgRPFW5y
        tU8VKwFD0hbtRnuBHpId1x6v1Q==
X-Google-Smtp-Source: ABdhPJyZj+2Vn+6W69AKPRTh2wk4PKvqzqVqTA63hYJRVSIAYcQ/O1m9fMYTQtqsbh7pki5RFa2oow==
X-Received: by 2002:a05:6a00:298a:b0:50e:8e3:b673 with SMTP id cj10-20020a056a00298a00b0050e08e3b673mr24631943pfb.28.1652830505085;
        Tue, 17 May 2022 16:35:05 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a14:3166:4b67:b688])
        by smtp.gmail.com with UTF8SMTPSA id l17-20020a170903245100b001617e18e253sm162705pls.143.2022.05.17.16.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 16:35:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Date:   Tue, 17 May 2022 16:34:57 -0700
Message-Id: <20220517163437.v4.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220517233457.1123309-1-mka@chromium.org>
References: <20220517233457.1123309-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The verity glue for LoadPin is only needed when CONFIG_SECURITY_LOADPIN_VERITY
is set, use this option for conditional compilation instead of the combo of
CONFIG_DM_VERITY and CONFIG_SECURITY_LOADPIN.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none

 drivers/md/Makefile               | 7 +------
 include/linux/dm-verity-loadpin.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 71771901c823..a96441752ec7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_DM_LOG_WRITES)	+= dm-log-writes.o
 obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
+obj-$(CONFIG_SECURITY_LOADPIN_VERITY)	+= dm-verity-loadpin.o
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
@@ -108,12 +109,6 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
 dm-verity-objs			+= dm-verity-verify-sig.o
 endif
 
-ifeq ($(CONFIG_DM_VERITY),y)
-ifeq ($(CONFIG_SECURITY_LOADPIN),y)
-dm-verity-objs			+= dm-verity-loadpin.o
-endif
-endif
-
 ifeq ($(CONFIG_DM_AUDIT),y)
 dm-mod-objs			+= dm-audit.o
 endif
diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
index c2bfd2b9c651..dd66ece9a751 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -15,7 +15,7 @@ struct trusted_root_digest {
 	u8 data[];
 };
 
-#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
 bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
 #else
 static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
-- 
2.36.0.550.gb090851708-goog

