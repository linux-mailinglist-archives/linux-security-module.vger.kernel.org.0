Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7307792E2
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Aug 2023 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjHKPVJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Aug 2023 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbjHKPU3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Aug 2023 11:20:29 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B34226
        for <linux-security-module@vger.kernel.org>; Fri, 11 Aug 2023 08:20:10 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-313c930ee0eso1224131f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Aug 2023 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691767206; x=1692372006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzePDYsycDhwr+IPrP4iKR8Awa/mk+LR9zGcfd9N2nE=;
        b=10PLZEHNHZ/ExNrV42MYDUP99UuAAVIdy55Hd7YOK/eHnLYUUyD7ve7NVrw3aO7CdM
         vWBMzbvzxgWLvhVnsphCgW8uohRzzBKAodzg63mpNv0kfIkeiZhzoClaIzj97HkkS2Lk
         iWbjWQuFhnLq9DvRa0wtjNDCeDyfnyv3WoXyhIp3GxwuB1sI2t8kz0UMxWfEap/n9djV
         /2cFEaEyzZxFkmBILF8aLsRKpkWrBu5Qa7Kzirz5w+TLtlCFMR/ay5oYyb0D9TOYaB/e
         ChrcClwsZwB85k4HDOSrHQdLnMpxjk/mslXOBnCi9KYIp7Vyxg9rq0If0NYuQ7ExjM+8
         kQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767206; x=1692372006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzePDYsycDhwr+IPrP4iKR8Awa/mk+LR9zGcfd9N2nE=;
        b=Fa/zv/fIXRKpsrPiIYP9PYSw37J/s+rgyRLLgTxHbl6XEwZSpZKeY9p2triAkqGhCo
         fsk+I09OnawaPRjMbJv733vFaVDOo4dvHdFLyiRQH+Vi6zomX+EinIAvQaPrET7HblL9
         hkQuvd7NBYGmHEVes2ZiSDtrOz4isQyWhgY/prk4+VK5Ww0BCuOiI4vCMnX0cChuIML0
         wS0Cwa1lt39uKUoXY0rYv/3yHkeIHkyAwtqwDYP+Yv0CxcNkS1z7kqGLZ/t7Y89c2Etv
         EBCyu6BW34x1MfsjEiPXRAu2s0iKZP5h4jPSqQAi7ca4AYbVwte0BD9RSggRRuTitC14
         WjyA==
X-Gm-Message-State: AOJu0YwYJru1Ot4a2PPaXOK8lUECJYCGW2cxSA0k8sHQagWyMaw1SbQx
        SrbK8RiOQHGekQkUdXUrZdUcrJWqWw==
X-Google-Smtp-Source: AGHT+IEGl+QWst925OBey2b/n22pg/pEC+s7Iu4Jwd9U6CEcZriGyM4oqqfEappi55i2VjBAWfl0++It4g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8dc0:5176:6fda:46a0])
 (user=elver job=sendgmr) by 2002:a05:6000:1819:b0:317:41be:d871 with SMTP id
 m25-20020a056000181900b0031741bed871mr16440wrh.14.1691767206297; Fri, 11 Aug
 2023 08:20:06 -0700 (PDT)
Date:   Fri, 11 Aug 2023 17:18:41 +0200
In-Reply-To: <20230811151847.1594958-1-elver@google.com>
Mime-Version: 1.0
References: <20230811151847.1594958-1-elver@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230811151847.1594958-4-elver@google.com>
Subject: [PATCH v4 4/4] hardening: Move BUG_ON_DATA_CORRUPTION to hardening options
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

BUG_ON_DATA_CORRUPTION is turning detected corruptions of list data
structures from WARNings into BUGs. This can be useful to stop further
corruptions or even exploitation attempts.

However, the option has less to do with debugging than with hardening.
With the introduction of LIST_HARDENED, it makes more sense to move it
to the hardening options, where it selects LIST_HARDENED instead.

Without this change, combining BUG_ON_DATA_CORRUPTION with LIST_HARDENED
alone wouldn't be possible, because DEBUG_LIST would always be selected
by BUG_ON_DATA_CORRUPTION.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* New patch, after LIST_HARDENED was made independent of DEBUG_LIST, and
  now DEBUG_LIST depends on LIST_HARDENED.
---
 lib/Kconfig.debug          | 12 +-----------
 security/Kconfig.hardening | 10 ++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c38745ad46eb..c7348d1fabe5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1673,7 +1673,7 @@ menu "Debug kernel data structures"
 
 config DEBUG_LIST
 	bool "Debug linked list manipulation"
-	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
+	depends on DEBUG_KERNEL
 	select LIST_HARDENED
 	help
 	  Enable this to turn on extended checks in the linked-list walking
@@ -1715,16 +1715,6 @@ config DEBUG_NOTIFIERS
 	  This is a relatively cheap check but if you care about maximum
 	  performance, say N.
 
-config BUG_ON_DATA_CORRUPTION
-	bool "Trigger a BUG when data corruption is detected"
-	select DEBUG_LIST
-	help
-	  Select this option if the kernel should BUG when it encounters
-	  data corruption in kernel memory structures when they get checked
-	  for validity.
-
-	  If unsure, say N.
-
 config DEBUG_MAPLE_TREE
 	bool "Debug maple trees"
 	depends on DEBUG_KERNEL
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index ffc3c702b461..2cff851ebfd7 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -290,6 +290,16 @@ config LIST_HARDENED
 
 	  If unsure, say N.
 
+config BUG_ON_DATA_CORRUPTION
+	bool "Trigger a BUG when data corruption is detected"
+	select LIST_HARDENED
+	help
+	  Select this option if the kernel should BUG when it encounters
+	  data corruption in kernel memory structures when they get checked
+	  for validity.
+
+	  If unsure, say N.
+
 endmenu
 
 config CC_HAS_RANDSTRUCT
-- 
2.41.0.694.ge786442a9b-goog

