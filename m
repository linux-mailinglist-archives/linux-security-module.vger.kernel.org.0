Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137501CDAF7
	for <lists+linux-security-module@lfdr.de>; Mon, 11 May 2020 15:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgEKNOl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 11 May 2020 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgEKNOk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 09:14:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A4C05BD0A
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 06:14:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so9405146lja.13
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOQlRoobz/JSTnw7jwwegH0gSDxJKtqarUsKs1ALhNM=;
        b=O7IbKpf3NxRDO3Qz4E22XOJiODI89ShsyRIBjfFqiBxYbmyzjqlqyDUUuluKWLondb
         zvLmdYtEfINYouhmprMb9bnYeW2ULG+ffMYDS3Hyz1jLdR29D6t24/4zBAL1Xh3W4jti
         57sw25xbYMqSo0NWD6CftkCY5w24yKxWy6bIE4qRU3l4Y9UiMKz1Oz0GVyviY4znjJzR
         dvF1SHdR6PDuhh59w/+680xYeLXE4uIspt4BilLfsI9Hg3T886eg9gExkPngkIkQNVzP
         WOROjQRPgANTvGvNhKsku53v7mZiLgZ2QOJ0u2I+DZa+VkNc5AwzgG0w1M6UW63HzuDm
         E85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOQlRoobz/JSTnw7jwwegH0gSDxJKtqarUsKs1ALhNM=;
        b=G3G0fEKeHsx6TRwwCFNc1yNKSV098YG+zUuYJARHrOxdMmbJqYPgUJTXMzrWz523T7
         tqkbClyhW8WoFssKmfiZy3OBgBVOKGyJ0t7lwQ7H0fHfAbikUn0FkxATae4TccQgly8R
         KWPhP6UHlAgCzavdVmkdqtZ0nTAUYRQR+11whar+WO8+nE+FNCDKfENg0FWwKjsRDiXp
         yupKgue1TPXMlkFWmIndTE0ENP/M6/iI3zHUbYB6WSGH9r5VICfCSEfUhFKEaJwYxILT
         9tA5QBH9G3VdNozRej3J18P32kscGvamKxaEPb0bPV3yuxSSKk7xTGsyYRRLvWWdC+XG
         hufg==
X-Gm-Message-State: AOAM532ksGhWdP9tbW2PbTy7DqzLJORn1yURexgZlJs5sForSz8b35bl
        2J9VfJ834x7tuZRlEJQAC4G7CA==
X-Google-Smtp-Source: ABdhPJzPQ63qDskczu5x6qrSWwXrg8R2UiUYIP4y4l+9X8DXtfBS8B2MRyrIgyTM1DH5gchXnwWtIw==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr466938ljj.283.1589202877635;
        Mon, 11 May 2020 06:14:37 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id i1sm36800lja.3.2020.05.11.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:37 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 4/6] drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
Date:   Mon, 11 May 2020 15:14:33 +0200
Message-Id: <20200511131433.29905-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_ALL_TESTS' so individual tests can not be turned off.
Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
menuconfig.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/base/Kconfig      | 3 ++-
 drivers/base/test/Kconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 5f0bc74d2409..8d7001712062 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  test this functionality.
 
 config PM_QOS_KUNIT_TEST
-	bool "KUnit Test for PM QoS features"
+	bool "KUnit Test for PM QoS features" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
 
 config HMEM_REPORTING
 	bool
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 305c7751184a..ba225eb1b761 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
 
 	  If unsure say N.
 config KUNIT_DRIVER_PE_TEST
-	bool "KUnit Tests for property entry API"
+	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
-- 
2.20.1

