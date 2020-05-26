Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD251C533F
	for <lists+linux-security-module@lfdr.de>; Tue,  5 May 2020 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgEEK11 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 5 May 2020 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728793AbgEEK10 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 06:27:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B785C061BD3
        for <linux-security-module@vger.kernel.org>; Tue,  5 May 2020 03:27:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 188so910439lfa.10
        for <linux-security-module@vger.kernel.org>; Tue, 05 May 2020 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRiFBDOnGQBRLjLzMXuEXvNbksG32oUXPct1JY4cmik=;
        b=LFmC24mPBJC0sTlA2HASUPylx7foxAbwXYu3Lk7iButcxcHNtKnJ9lU/C4qoLZUUZp
         9gcow66TgPpxKKSj1IKgjRrTNP09KsitmqgKx/T+saPhx2zgVUHLUJE0SElbTerGNBB2
         N1M9L/FP0OTK3YV9nMHdb+Zwgw2fOaQzOWs0IBTvB0/pn68wDdlncjfg5ow1XEq6KG3z
         Dj4pa2pjB+/4XZ3K6MmQULKqZKZpZGPsw6ZILzLD6IlxgjzJgYYD9gtJVI457FxJb58C
         lqIOaSu8waDl9z6CemsMW6fvNn5COuvgzZnVRPwGJYBQDx8QXIEOXu9OCCUowwSlF83U
         SvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRiFBDOnGQBRLjLzMXuEXvNbksG32oUXPct1JY4cmik=;
        b=aDI+viKMsgawAjCLtZLi567biuVGTNyMeIPGzOTbUzIDxJf5dycvFa48Z+QDZi1od5
         JSR3v/cnpJYq0eRxPThKdQnVCOIg6OKi4D3IEk3XKhtdCJ9iQ0HBMiBSCrsY23gDQMO+
         icygHc7o4BLcLO4zwixaL/LTNQj3/SzAl0LnwbTWBOA1Wb5Xjee1Bgabgtve1LQeVWX7
         86awBLbKZVJMOQ+aRZEbkS8IDCMNRBJLy5c4s5O03ujdt96SSKbwoU9YucxxkPcPRPvB
         3lxWzVt7T36qTagsdvR56+ajMlGWlDSuMcXPSrBkC29cP4zRsLtc+GstAJLtJTUl9W89
         sXTA==
X-Gm-Message-State: AGi0Pualg+nJ8X3cQRlkr0OY6RSKnw2tv0dp701tqpqTeQrZ83RVEWEK
        wq/muLNecJPbVQ9TDO+0aFQ/sA==
X-Google-Smtp-Source: APiQypIR9GXpeGznyTPzxxPMH60S70qpkz8Pdow9IgLyad003qeOI5oG/v94+jJLJGDddGEEFDFCTA==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr1203102lfg.122.1588674443487;
        Tue, 05 May 2020 03:27:23 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id b2sm1598931lfi.14.2020.05.05.03.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:22 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        brendanhiggins@google.com, =linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 4/6] drivers: base: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:19 +0200
Message-Id: <20200505102719.8071-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
someone wants that even though KUNIT_RUN_ALL is enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/base/Kconfig      | 3 ++-
 drivers/base/test/Kconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 5f0bc74d2409..c48e6e4ef367 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  test this functionality.
 
 config PM_QOS_KUNIT_TEST
-	bool "KUnit Test for PM QoS features"
+	bool "KUnit Test for PM QoS features" if !KUNIT_RUN_ALL
 	depends on KUNIT=y
+	default KUNIT_RUN_ALL
 
 config HMEM_REPORTING
 	bool
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 305c7751184a..0d662d689f6b 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
 
 	  If unsure say N.
 config KUNIT_DRIVER_PE_TEST
-	bool "KUnit Tests for property entry API"
+	bool "KUnit Tests for property entry API" if !KUNIT_RUN_ALL
 	depends on KUNIT=y
+	default KUNIT_RUN_ALL
-- 
2.20.1

