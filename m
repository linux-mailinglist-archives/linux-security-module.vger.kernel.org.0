Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300FF3B04D4
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Jun 2021 14:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFVMmB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 22 Jun 2021 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFVMlK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jun 2021 08:41:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4676C061756
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jun 2021 05:38:51 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lvffW-0001dp-6e; Tue, 22 Jun 2021 14:38:18 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lvffS-0002QN-PX; Tue, 22 Jun 2021 14:38:14 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Date:   Tue, 22 Jun 2021 14:37:52 +0200
Message-Id: <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
built into many newer i.MX and QorIQ SoCs by NXP.

The CAAM does crypto acceleration, hardware number generation and
has a blob mechanism for encapsulation/decapsulation of sensitive material.

This blob mechanism depends on a device specific random 256-bit One Time
Programmable Master Key that is fused in each SoC at manufacturing
time. This key is unreadable and can only be used by the CAAM for AES
encryption/decryption of user data.

This makes it a suitable backend (source) for kernel trusted keys.

Previous commits generalized trusted keys to support multiple backends
and added an API to access the CAAM blob mechanism. Based on these,
provide the necessary glue to use the CAAM for trusted keys.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
To: Jonathan Corbet <corbet@lwn.net>
To: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <jejb@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Udit Agarwal <udit.agarwal@nxp.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt   |  1 +-
 Documentation/security/keys/trusted-encrypted.rst | 42 ++++++++-
 include/keys/trusted_caam.h                       | 11 ++-
 security/keys/trusted-keys/Kconfig                | 11 +-
 security/keys/trusted-keys/Makefile               |  2 +-
 security/keys/trusted-keys/trusted_caam.c         | 74 ++++++++++++++++-
 security/keys/trusted-keys/trusted_core.c         |  6 +-
 7 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 include/keys/trusted_caam.h
 create mode 100644 security/keys/trusted-keys/trusted_caam.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f8bdc898c354..4a95369c2bc7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5639,6 +5639,7 @@
 			sources:
 			- "tpm"
 			- "tee"
+			- "caam"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 3fb5562ee937..3461746b1fbd 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -35,6 +35,13 @@ safe.
          Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
          fuses and is accessible to TEE only.
 
+     (3) CAAM (Cryptographic Acceleration and Assurance Module: IP on NXP SoCs)
+
+         When High Assurance Boot (HAB) is enabled and the CAAM is in secure
+         mode, trust is rooted to the OTPMK, a never-disclosed 256-bit key
+         randomly generated and fused into each SoC at manufacturing time.
+         Otherwise, a common fixed test key is used instead.
+
   *  Execution isolation
 
      (1) TPM
@@ -46,6 +53,10 @@ safe.
          Customizable set of operations running in isolated execution
          environment verified via Secure/Trusted boot process.
 
+     (3) CAAM
+
+         Fixed set of operations running in isolated execution environment.
+
   * Optional binding to platform integrity state
 
      (1) TPM
@@ -63,6 +74,11 @@ safe.
          Relies on Secure/Trusted boot process for platform integrity. It can
          be extended with TEE based measured boot process.
 
+     (3) CAAM
+
+         Relies on the High Assurance Boot (HAB) mechanism of NXP SoCs
+         for platform integrity.
+
   *  Interfaces and APIs
 
      (1) TPM
@@ -74,10 +90,13 @@ safe.
          TEEs have well-documented, standardized client interface and APIs. For
          more details refer to ``Documentation/staging/tee.rst``.
 
+     (3) CAAM
+
+         Interface is specific to silicon vendor.
 
   *  Threat model
 
-     The strength and appropriateness of a particular TPM or TEE for a given
+     The strength and appropriateness of a particular trust source for a given
      purpose must be assessed when using them to protect security-relevant data.
 
 
@@ -104,8 +123,14 @@ selected trust source:
      from platform specific hardware RNG or a software based Fortuna CSPRNG
      which can be seeded via multiple entropy sources.
 
+  *  CAAM: Kernel RNG
+
+     The normal kernel random number generator is used. To seed it from the
+     CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the device
+     can be probed.
+
 Optionally, users may specify ``trusted.kernel_rng=1`` on the kernel
-command-line to override the used RNG with the kernel's random number pool.
+command-line to force use of the kernel's random number pool.
 
 Encrypted Keys
 --------------
@@ -192,6 +217,19 @@ Usage::
 specific to TEE device implementation.  The key length for new keys is always
 in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
 
+Trusted Keys usage: CAAM
+------------------------
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
+specific to CAAM device implementation.  The key length for new keys is always
+in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
 Trusted Keys: import plain-text key for development
 ---------------------------------------------------
 
diff --git a/include/keys/trusted_caam.h b/include/keys/trusted_caam.h
new file mode 100644
index 000000000000..2fba0996b0b0
--- /dev/null
+++ b/include/keys/trusted_caam.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#ifndef __CAAM_TRUSTED_KEY_H
+#define __CAAM_TRUSTED_KEY_H
+
+extern struct trusted_key_ops caam_trusted_key_ops;
+
+#endif
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index 8bd69b252bf9..641bed8923ec 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -20,7 +20,16 @@ config TRUSTED_KEYS_TEE
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
+config TRUSTED_KEYS_CAAM
+	bool "CAAM-based trusted keys"
+	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
+	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
+	default y
+	help
+	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
+	  (CAAM) as trusted key backend.
+
+if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
 comment "No trust source selected!"
 endif
 
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 96fc6c377398..5788bc07a2ab 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -14,3 +14,5 @@ trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
 trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
 
 trusted-$(CONFIG_TEE) += trusted_tee.o
+
+trusted-$(CONFIG_TRUSTED_KEYS_CAAM) += trusted_caam.o
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
new file mode 100644
index 000000000000..01adfd18adda
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#include <keys/trusted_caam.h>
+#include <keys/trusted-type.h>
+#include <linux/build_bug.h>
+#include <linux/key-type.h>
+#include <soc/fsl/caam-blob.h>
+
+static struct caam_blob_priv *blobifier;
+
+#define KEYMOD "kernel:trusted"
+
+static_assert(MAX_KEY_SIZE + CAAM_BLOB_OVERHEAD <= CAAM_BLOB_MAX_LEN);
+static_assert(MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN);
+
+static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
+{
+	int length = p->key_len + CAAM_BLOB_OVERHEAD;
+	int ret;
+
+	ret = caam_encap_blob(blobifier, KEYMOD, p->key, p->blob, length);
+	if (ret)
+		return ret;
+
+	p->blob_len = length;
+	return 0;
+}
+
+static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
+{
+	int length = p->blob_len;
+	int ret;
+
+	ret = caam_decap_blob(blobifier, KEYMOD, p->blob, p->key, length);
+	if (ret)
+		return ret;
+
+	p->key_len = length - CAAM_BLOB_OVERHEAD;
+	return 0;
+}
+
+static int trusted_caam_init(void)
+{
+	int ret;
+
+	blobifier = caam_blob_gen_init();
+	if (IS_ERR(blobifier)) {
+		pr_err("Job Ring Device allocation for transform failed\n");
+		return PTR_ERR(blobifier);
+	}
+
+	ret = register_key_type(&key_type_trusted);
+	if (ret)
+		caam_blob_gen_exit(blobifier);
+
+	return ret;
+}
+
+static void trusted_caam_exit(void)
+{
+	unregister_key_type(&key_type_trusted);
+	caam_blob_gen_exit(blobifier);
+}
+
+struct trusted_key_ops caam_trusted_key_ops = {
+	.migratable = 0, /* non-migratable */
+	.init = trusted_caam_init,
+	.seal = trusted_caam_seal,
+	.unseal = trusted_caam_unseal,
+	.exit = trusted_caam_exit,
+};
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 8d829e6866ca..21997a5debde 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -9,6 +9,7 @@
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/trusted_tee.h>
+#include <keys/trusted_caam.h>
 #include <keys/trusted_tpm.h>
 #include <linux/capability.h>
 #include <linux/err.h>
@@ -29,7 +30,7 @@ MODULE_PARM_DESC(kernel_rng, "Generate key material from kernel RNG");
 
 static char *trusted_key_source;
 module_param_named(source, trusted_key_source, charp, 0);
-MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
+MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or caam)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
 #if defined(CONFIG_TRUSTED_KEYS_TPM)
@@ -38,6 +39,9 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #if defined(CONFIG_TRUSTED_KEYS_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
+#if defined(CONFIG_TRUSTED_KEYS_CAAM)
+	{ "caam", &caam_trusted_key_ops },
+#endif
 };
 
 DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
-- 
git-series 0.9.1
