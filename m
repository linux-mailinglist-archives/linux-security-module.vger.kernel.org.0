Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7333CFB7FB
	for <lists+linux-security-module@lfdr.de>; Wed, 13 Nov 2019 19:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKMSrP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 Nov 2019 13:47:15 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43344 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfKMSrE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Nov 2019 13:47:04 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED11F20B4904;
        Wed, 13 Nov 2019 10:47:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED11F20B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573670823;
        bh=DKCaB/fse/DmuVBERqJi6zlr2kjIKA9EFo+2/yYf1DA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iieNDePtOMwQYbIUxCM8KyrQE3/t/JQ5JbXXc8gUKNVe5RKcTPRqUYAq3PIPES0Sn
         M19RKfCZh2HdoiZolTtQyaGdB6bk3eaUesRXI+lK+rrXN92RJqx8I7ddq41OGoEx5W
         iu79XxRvO9mfOFrBTrB7xyAvDGcwycqib9uglyJg=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
Date:   Wed, 13 Nov 2019 10:46:57 -0800
Message-Id: <20191113184658.2862-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113184658.2862-1-nramas@linux.microsoft.com>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Measure asymmetric keys used for verifying file signatures,
certificates, etc.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

Note that currently IMA subsystem can be enabled without
enabling KEYS subsystem.

Adding support for measuring asymmetric keys in IMA requires KEYS
subsystem to be enabled. To handle this dependency a new config
namely CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS has been added. Enabling
this config requires the following configs to be enabled:
    CONFIG_IMA, CONFIG_KEYS, CONFIG_ASYMMETRIC_KEY_TYPE, and
    CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE.

CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is off by default.

The IMA hook is defined in a new file namely ima_asymmetric_keys.c
which is built only if CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig               | 14 ++++++
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima_asymmetric_keys.c | 51 ++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 838476d780e5..c6d14884bc19 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -310,3 +310,17 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_MEASURE_ASYMMETRIC_KEYS
+	bool "Enable measuring asymmetric keys on key create or update"
+	depends on IMA
+	depends on KEYS
+	depends on ASYMMETRIC_KEY_TYPE
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	default n
+	help
+	   This option enables measuring asymmetric keys when
+	   the key is created or updated. Additionally, IMA policy
+	   needs to be configured to either measure keys linked to
+	   any keyring or only measure keys linked to the keyrings
+	   specified in the IMA policy through the keyrings= option.
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 31d57cdf2421..3e9d0ad68c7b 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
new file mode 100644
index 000000000000..f6884641a622
--- /dev/null
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_asymmetric_keys.c
+ *       Defines an IMA hook to measure asymmetric keys on key
+ *       create or update.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include "ima.h"
+
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	const struct public_key *pk;
+
+	/* Only asymmetric keys are handled by this hook. */
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	/* Get the public_key of the given asymmetric key to measure. */
+	pk = key->payload.data[asym_crypto];
+
+	/*
+	 * keyring->description points to the name of the keyring
+	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
+	 * which the given key is linked to.
+	 *
+	 * The name of the keyring is passed in the "eventname"
+	 * parameter to process_buffer_measurement() and is set
+	 * in the "eventname" field in ima_event_data for
+	 * the key measurement IMA event.
+	 */
+	process_buffer_measurement(pk->key, pk->keylen,
+				   keyring->description, KEY_CHECK, 0);
+}
-- 
2.17.1

