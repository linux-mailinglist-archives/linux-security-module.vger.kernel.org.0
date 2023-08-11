Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1027792DE
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Aug 2023 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjHKPUu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Aug 2023 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjHKPUY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Aug 2023 11:20:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64003581
        for <linux-security-module@vger.kernel.org>; Fri, 11 Aug 2023 08:20:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d41fa6e7103so2052620276.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Aug 2023 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691767201; x=1692372001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr1U486Irq718Y5Vjn28mDb0feV+v+GYGzM/Kj2uczY=;
        b=m1/D3Wz2gi9Cs3OHDg7iK6vUaVmjXR/mBEkssZ6eiDX4uK2cf5n12+/DqBceY9qgAr
         9c5mIs9OODdG0vj3Z1SdlT0fcTpSrTZNrf/sOTYryKqshqCTGV356GH4eUt6zYsDL6Y7
         dhMd/RtYG371nzP2IXzmFytLbc22DzMJFtuwlKSf8hoJMP1OexW4RlZQDVTt3UVia3+H
         pDSddYYq+Gn5j6jgcFealLLycpGh3wDmyJdE0k4/jmlKu4U6VgcoLiWmdS/kwl9mu3qH
         lOvk1dXUz8tGeXyNfGd+iGsp/NUCifEEp+7HMAhvrl9Lr4g/6LKr5IJiM6YpAahM049Y
         ri8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767201; x=1692372001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr1U486Irq718Y5Vjn28mDb0feV+v+GYGzM/Kj2uczY=;
        b=U+m7WwFfz7BcBI0QilfGuW7mQQSr+KNtAzDPrUhP81OM46W+dxUHXaUOSS0JxTQ3o9
         ijlPbtDF4uFvG0bpmzgrr1MSGIKgKR76Ef6rwoSPSLkUPnHkWrC3CWjEoOuWlgXuEgg4
         r12SuVNCfbaQlD7+Pq3cX6VLiTNhmzbwGewisEtSAva6pXn3Hl9NQa7Ia2sOAr8Li2Dv
         WXbvoGN4q7NdPG+hOr2bmefgTA0TxW/cjfcIqo5tv2uduEvmIehhtqRqkt3lxUht3gd5
         9YLvhx+4o4Hq2KxsVg8KJ+uY2+p80jX13Qfn/q0r2fA4I44TvVFp875gNjD5CSYDpcFl
         7ECQ==
X-Gm-Message-State: AOJu0Yxc+p1vLoU818U/wM8NjofFwmA2MKWRdJ94rXJw5xW7yM9rOA2D
        hxJcQWIb/fm8qztP/v48Z1JKE+lk4A==
X-Google-Smtp-Source: AGHT+IE1ZLq4HueLWE6jbB2RlK4FqkKfdhzzoJrlx4qj6MjWBU1TM0fjy97D10E3vXrsojL+UjJkhk8T/Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8dc0:5176:6fda:46a0])
 (user=elver job=sendgmr) by 2002:a25:b190:0:b0:d06:cbd:1f3e with SMTP id
 h16-20020a25b190000000b00d060cbd1f3emr33009ybj.3.1691767200863; Fri, 11 Aug
 2023 08:20:00 -0700 (PDT)
Date:   Fri, 11 Aug 2023 17:18:39 +0200
In-Reply-To: <20230811151847.1594958-1-elver@google.com>
Mime-Version: 1.0
References: <20230811151847.1594958-1-elver@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230811151847.1594958-2-elver@google.com>
Subject: [PATCH v4 2/4] list_debug: Introduce inline wrappers for debug checks
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Turn the list debug checking functions __list_*_valid() into inline
functions that wrap the out-of-line functions. Care is taken to ensure
the inline wrappers are always inlined, so that additional compiler
instrumentation (such as sanitizers) does not result in redundant
outlining.

This change is preparation for performing checks in the inline wrappers.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Rename ___list_*_valid() to __list_*_valid_or_report().
* Some documentation.
---
 arch/arm64/kvm/hyp/nvhe/list_debug.c |  6 ++---
 include/linux/list.h                 | 37 +++++++++++++++++++++++++---
 lib/list_debug.c                     | 11 ++++-----
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
index d68abd7ea124..16266a939a4c 100644
--- a/arch/arm64/kvm/hyp/nvhe/list_debug.c
+++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
@@ -26,8 +26,8 @@ static inline __must_check bool nvhe_check_data_corruption(bool v)
 
 /* The predicates checked here are taken from lib/list_debug.c. */
 
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
+				struct list_head *next)
 {
 	if (NVHE_CHECK_DATA_CORRUPTION(next->prev != prev) ||
 	    NVHE_CHECK_DATA_CORRUPTION(prev->next != next) ||
@@ -37,7 +37,7 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 	return true;
 }
 
-bool __list_del_entry_valid(struct list_head *entry)
+bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
 
diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..130c6a1bb45c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -39,10 +39,39 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 }
 
 #ifdef CONFIG_DEBUG_LIST
-extern bool __list_add_valid(struct list_head *new,
-			      struct list_head *prev,
-			      struct list_head *next);
-extern bool __list_del_entry_valid(struct list_head *entry);
+/*
+ * Performs the full set of list corruption checks before __list_add().
+ * On list corruption reports a warning, and returns false.
+ */
+extern bool __list_add_valid_or_report(struct list_head *new,
+				       struct list_head *prev,
+				       struct list_head *next);
+
+/*
+ * Performs list corruption checks before __list_add(). Returns false if a
+ * corruption is detected, true otherwise.
+ */
+static __always_inline bool __list_add_valid(struct list_head *new,
+					     struct list_head *prev,
+					     struct list_head *next)
+{
+	return __list_add_valid_or_report(new, prev, next);
+}
+
+/*
+ * Performs the full set of list corruption checks before __list_del_entry().
+ * On list corruption reports a warning, and returns false.
+ */
+extern bool __list_del_entry_valid_or_report(struct list_head *entry);
+
+/*
+ * Performs list corruption checks before __list_del_entry(). Returns false if a
+ * corruption is detected, true otherwise.
+ */
+static __always_inline bool __list_del_entry_valid(struct list_head *entry)
+{
+	return __list_del_entry_valid_or_report(entry);
+}
 #else
 static inline bool __list_add_valid(struct list_head *new,
 				struct list_head *prev,
diff --git a/lib/list_debug.c b/lib/list_debug.c
index d98d43f80958..2def33b1491f 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -17,8 +17,8 @@
  * attempt).
  */
 
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
+				struct list_head *next)
 {
 	if (CHECK_DATA_CORRUPTION(prev == NULL,
 			"list_add corruption. prev is NULL.\n") ||
@@ -37,9 +37,9 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 
 	return true;
 }
-EXPORT_SYMBOL(__list_add_valid);
+EXPORT_SYMBOL(__list_add_valid_or_report);
 
-bool __list_del_entry_valid(struct list_head *entry)
+bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
 
@@ -65,6 +65,5 @@ bool __list_del_entry_valid(struct list_head *entry)
 		return false;
 
 	return true;
-
 }
-EXPORT_SYMBOL(__list_del_entry_valid);
+EXPORT_SYMBOL(__list_del_entry_valid_or_report);
-- 
2.41.0.694.ge786442a9b-goog

