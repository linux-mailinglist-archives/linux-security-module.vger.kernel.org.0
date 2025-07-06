Return-Path: <linux-security-module+bounces-10928-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52F2AF89B6
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Jul 2025 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F256C1C880BF
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Jul 2025 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A98283FCD;
	Fri,  4 Jul 2025 07:40:35 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854A27A10A;
	Fri,  4 Jul 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614835; cv=none; b=F/JyV8NaFJdzvErCDfhnTZ9iY1V2dsOfqKRVk649Cw+zJhZqmmYF4YansE6kPlaO3q8cxEShvP0TepoD6zsK+zJmyGCyrfmZJFsU4FnCrLekhsS3TbRmD86td4GjToARqOaGC9rpCLoiuAnEH5fGG3wq+PYoV6yXLTQXySGXYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614835; c=relaxed/simple;
	bh=3Gq7q6sk1e4OCAoXoS9edGKymQuwCCfAdN07peh6VIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAIZI6cORfT9m9nXShL9OmmpBAcfUzkrVoMmpYoy2SjTGyo8u+RBvQYPot+mZIpzLjTEsyHAj78tiPJAzmI9OLhADa2O599G4ojkMJBuWB362Rw/aeNRy/AReV98MIqoWuhWBXaHCs7hLgElMNlArLUafRE2XhrSLHHVMwS9QZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bYQTf1r75z1d1t7;
	Fri,  4 Jul 2025 15:37:58 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 538D6140156;
	Fri,  4 Jul 2025 15:40:30 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 15:40:29 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <keyrings@vger.kernel.org>, Lu Jialin
	<lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH v4 2/2] integrity: Extract secure boot enquiry function out of IMA
Date: Fri, 4 Jul 2025 15:51:14 +0800
Message-ID: <20250704075114.3709609-3-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250704075114.3709609-1-gongruiqi1@huawei.com>
References: <20250704075114.3709609-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Commit 92ad19559ea9 ("integrity: Do not load MOK and MOKx when secure
boot be disabled") utilizes arch_ima_get_secureboot() to perform a
secure boot status check before loading the Machine Owner Key (MOK).

However, only when CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y can this
function be functional, while this config could be turned on/off
parallelly with CONFIG_LOAD_UEFI_KEYS. So the kernel could behave
unintuitively in case that CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n and
CONFIG_LOAD_UEFI_KEYS=y, as it would refuse to load MOK even if secure
boot is enabled.

Given that what arch_ima_get_secureboot() does is just to retrieve
secure boot status via EFI interfaces and can be decoupled with IMA,
refactor this functionality into integrity_get_efi_secureboot(), a
general helper in the integrity subsystem that both MOK loading and IMA
can make use of. By using the new helper, the implicit dependence of
CONFIG_LOAD_UEFI_KEYS on CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is
removed.

Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 include/linux/integrity.h                     |  1 +
 security/integrity/Makefile                   |  1 +
 security/integrity/efi_secureboot.c           | 46 +++++++++++++++++++
 security/integrity/ima/ima_efi.c              | 42 +----------------
 security/integrity/platform_certs/load_uefi.c |  3 +-
 5 files changed, 51 insertions(+), 42 deletions(-)
 create mode 100644 security/integrity/efi_secureboot.c

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359b..157d29cab5cd 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -61,5 +61,6 @@ integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
 		!inode_eq_iversion(inode, attrs->version));
 }
 
+extern bool integrity_get_efi_secureboot(void);
 
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 92b63039c654..45dfdedbdad4 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -18,6 +18,7 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
                                      platform_certs/load_powerpc.o \
                                      platform_certs/keyring_handler.o
+integrity-$(CONFIG_EFI) += efi_secureboot.o
 # The relative order of the 'ima' and 'evm' LSMs depends on the order below.
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
diff --git a/security/integrity/efi_secureboot.c b/security/integrity/efi_secureboot.c
new file mode 100644
index 000000000000..64207ae37e6b
--- /dev/null
+++ b/security/integrity/efi_secureboot.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Huawei Technologies Co., Ltd
+ */
+#include <linux/efi.h>
+#include <linux/integrity.h>
+#include <asm/efi.h>
+
+#ifndef arch_integrity_efi_boot_mode
+#define arch_integrity_efi_boot_mode efi_secureboot_mode_unset
+#endif
+
+static enum efi_secureboot_mode get_sb_mode(void)
+{
+	enum efi_secureboot_mode mode;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		pr_info("integrity: secureboot mode unknown, no efi\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_disabled)
+		pr_info("integrity: secureboot mode disabled\n");
+	else if (mode == efi_secureboot_mode_unknown)
+		pr_info("integrity: secureboot mode unknown\n");
+	else
+		pr_info("integrity: secureboot mode enabled\n");
+	return mode;
+}
+
+bool integrity_get_efi_secureboot(void)
+{
+	static enum efi_secureboot_mode sb_mode;
+	static bool initialized;
+
+	if (!initialized && efi_enabled(EFI_BOOT)) {
+		sb_mode = arch_integrity_efi_boot_mode;
+
+		if (sb_mode == efi_secureboot_mode_unset)
+			sb_mode = get_sb_mode();
+		initialized = true;
+	}
+
+	return sb_mode == efi_secureboot_mode_enabled;
+}
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 9f9c30dcde17..3cf08f8ca3b7 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -2,51 +2,13 @@
 /*
  * Copyright (C) 2018 IBM Corporation
  */
-#include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ima.h>
-#include <asm/efi.h>
-
-#ifndef arch_integrity_efi_boot_mode
-#define arch_integrity_efi_boot_mode efi_secureboot_mode_unset
-#endif
-
-static enum efi_secureboot_mode get_sb_mode(void)
-{
-	enum efi_secureboot_mode mode;
-
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
-		pr_info("ima: secureboot mode unknown, no efi\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	mode = efi_get_secureboot_mode(efi.get_variable);
-	if (mode == efi_secureboot_mode_disabled)
-		pr_info("ima: secureboot mode disabled\n");
-	else if (mode == efi_secureboot_mode_unknown)
-		pr_info("ima: secureboot mode unknown\n");
-	else
-		pr_info("ima: secureboot mode enabled\n");
-	return mode;
-}
+#include <linux/integrity.h>
 
 bool arch_ima_get_secureboot(void)
 {
-	static enum efi_secureboot_mode sb_mode;
-	static bool initialized;
-
-	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode = arch_integrity_efi_boot_mode;
-
-		if (sb_mode == efi_secureboot_mode_unset)
-			sb_mode = get_sb_mode();
-		initialized = true;
-	}
-
-	if (sb_mode == efi_secureboot_mode_enabled)
-		return true;
-	else
-		return false;
+	return integrity_get_efi_secureboot();
 }
 
 /* secureboot arch rules */
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index d1fdd113450a..deebdbf4393e 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -7,7 +7,6 @@
 #include <linux/err.h>
 #include <linux/efi.h>
 #include <linux/slab.h>
-#include <linux/ima.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
@@ -212,7 +211,7 @@ static int __init load_uefi_certs(void)
 	}
 
 	/* the MOK/MOKx can not be trusted when secure boot is disabled */
-	if (!arch_ima_get_secureboot())
+	if (!integrity_get_efi_secureboot())
 		return 0;
 
 	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
-- 
2.25.1


