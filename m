Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83B73240A
	for <lists+linux-security-module@lfdr.de>; Fri, 16 Jun 2023 02:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjFPAFB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 15 Jun 2023 20:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjFPAE7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Jun 2023 20:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417BECD
        for <linux-security-module@vger.kernel.org>; Thu, 15 Jun 2023 17:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C775761ABC
        for <linux-security-module@vger.kernel.org>; Fri, 16 Jun 2023 00:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81E8C433CD;
        Fri, 16 Jun 2023 00:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686873897;
        bh=nD/PAItKeoTMgHPEQBE/n5z09K6jHL6KsNlglfkGAN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoIGYg3yorNRjZ0tAtrOnXNlVHHNIVwrXvrTqV0X0oLFC7j1KBHkPfw8UOdQID6Jd
         Y0utcfb9iDlNWp8KdJj15Npav/FPFnyrmz4ky0FkW+yAwe/mbl1qRYgGI5YPMYugjK
         zm1Nj5LC3ge/lF4nJy5asYPwjPLbxd83g3cpBfgj5bWlxiMqmFSJn4tPQDoOvyQ0Ta
         f4DuLopGm45NzeFqyFqPlYfxGFZmCuoiXcZ/gDN5bJdh78Rb23q38fx3Vqtaj4ixVM
         HPfAXYP0dnt3u6ZBWRXMocKNkXgjL15tFx3hHx3yJnlVGu04lJ42SKELjikeobBWR3
         ZlUUC2chHVi/w==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        jannh@google.com, Kui-Feng Lee <sinquersw@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 2/5] security: Count the LSMs enabled at compile time
Date:   Fri, 16 Jun 2023 02:04:38 +0200
Message-ID: <20230616000441.3677441-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230616000441.3677441-1-kpsingh@kernel.org>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These macros are a clever trick to determine a count of the number of
LSMs that are enabled in the config to ascertain the maximum number of
static calls that need to be configured per LSM hook.

Without this one would need to generate static calls for (number of
possible LSMs * number of LSM hooks) which ends up being quite wasteful
especially when some LSMs are not compiled into the kernel.

Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_count.h | 131 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 include/linux/lsm_count.h

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
new file mode 100644
index 000000000000..818f62ffa723
--- /dev/null
+++ b/include/linux/lsm_count.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2023 Google LLC.
+ */
+
+#ifndef __LINUX_LSM_COUNT_H
+#define __LINUX_LSM_COUNT_H
+
+#include <linux/kconfig.h>
+
+/*
+ * Macros to count the number of LSMs enabled in the kernel at compile time.
+ */
+
+#define __LSM_COUNT_15(x, y...) 15
+#define __LSM_COUNT_14(x, y...) 14
+#define __LSM_COUNT_13(x, y...) 13
+#define __LSM_COUNT_12(x, y...) 12
+#define __LSM_COUNT_11(x, y...) 11
+#define __LSM_COUNT_10(x, y...) 10
+#define __LSM_COUNT_9(x, y...) 9
+#define __LSM_COUNT_8(x, y...) 8
+#define __LSM_COUNT_7(x, y...) 7
+#define __LSM_COUNT_6(x, y...) 6
+#define __LSM_COUNT_5(x, y...) 5
+#define __LSM_COUNT_4(x, y...) 4
+#define __LSM_COUNT_3(x, y...) 3
+#define __LSM_COUNT_2(x, y...) 2
+#define __LSM_COUNT_1(x, y...) 1
+#define __LSM_COUNT_0(x, y...) 0
+
+#define __LSM_COUNT1_15(x, y...) __LSM_COUNT ## x ## _15(y)
+#define __LSM_COUNT1_14(x, y...) __LSM_COUNT ## x ## _14(y)
+#define __LSM_COUNT1_13(x, y...) __LSM_COUNT ## x ## _13(y)
+#define __LSM_COUNT1_12(x, y...) __LSM_COUNT ## x ## _12(y)
+#define __LSM_COUNT1_10(x, y...) __LSM_COUNT ## x ## _11(y)
+#define __LSM_COUNT1_9(x, y...) __LSM_COUNT ## x ## _10(y)
+#define __LSM_COUNT1_8(x, y...) __LSM_COUNT ## x ## _9(y)
+#define __LSM_COUNT1_7(x, y...) __LSM_COUNT ## x ## _8(y)
+#define __LSM_COUNT1_6(x, y...) __LSM_COUNT ## x ## _7(y)
+#define __LSM_COUNT1_5(x, y...) __LSM_COUNT ## x ## _6(y)
+#define __LSM_COUNT1_4(x, y...) __LSM_COUNT ## x ## _5(y)
+#define __LSM_COUNT1_3(x, y...) __LSM_COUNT ## x ## _4(y)
+#define __LSM_COUNT1_2(x, y...) __LSM_COUNT ## x ## _3(y)
+#define __LSM_COUNT1_1(x, y...) __LSM_COUNT ## x ## _2(y)
+#define __LSM_COUNT1_0(x, y...) __LSM_COUNT ## x ## _1(y)
+#define __LSM_COUNT(x, y...) __LSM_COUNT ## x ## _0(y)
+
+#define __LSM_COUNT_EXPAND(x...) __LSM_COUNT(x)
+
+#if IS_ENABLED(CONFIG_SECURITY)
+#define CAPABILITIES_ENABLED 1,
+#else
+#define CAPABILITIES_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
+#define SELINUX_ENABLED 1,
+#else
+#define SELINUX_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SMACK)
+#define SMACK_ENABLED 1,
+#else
+#define SMACK_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
+#define APPARMOR_ENABLED 1,
+#else
+#define APPARMOR_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
+#define TOMOYO_ENABLED 1,
+#else
+#define TOMOYO_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_YAMA)
+#define YAMA_ENABLED 1,
+#else
+#define YAMA_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
+#define LOADPIN_ENABLED 1,
+#else
+#define LOADPIN_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
+#define LOCKDOWN_ENABLED 1,
+#else
+#define LOCKDOWN_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_BPF_LSM)
+#define BPF_LSM_ENABLED 1,
+#else
+#define BPF_LSM_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_BPF_LSM)
+#define BPF_LSM_ENABLED 1,
+#else
+#define BPF_LSM_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
+#define LANDLOCK_ENABLED 1,
+#else
+#define LANDLOCK_ENABLED
+#endif
+
+#define MAX_LSM_COUNT			\
+	__LSM_COUNT_EXPAND(		\
+		CAPABILITIES_ENABLED	\
+		SELINUX_ENABLED		\
+		SMACK_ENABLED		\
+		APPARMOR_ENABLED	\
+		TOMOYO_ENABLED		\
+		YAMA_ENABLED		\
+		LOADPIN_ENABLED		\
+		LOCKDOWN_ENABLED	\
+		BPF_LSM_ENABLED		\
+		LANDLOCK_ENABLED)
+
+#endif  /* __LINUX_LSM_COUNT_H */
-- 
2.41.0.162.gfafddb0af9-goog

