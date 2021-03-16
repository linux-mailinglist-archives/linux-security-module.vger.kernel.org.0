Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9333DA22
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Mar 2021 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhCPRCp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Mar 2021 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbhCPRCP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Mar 2021 13:02:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F48C0613DF
        for <linux-security-module@vger.kernel.org>; Tue, 16 Mar 2021 10:02:12 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lMD4c-0000Nr-4C; Tue, 16 Mar 2021 18:01:38 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lMD4Y-0000VZ-G5; Tue, 16 Mar 2021 18:01:34 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     kernel@pengutronix.de, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@penutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Date:   Tue, 16 Mar 2021 18:01:15 +0100
Message-Id: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

Its blob mechanism can AES encrypt/decrypt user data using a unique
never-disclosed device-specific key. There has been multiple
discussions on how to represent this within the kernel:

 - [RFC] crypto: caam - add red blobifier
   Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
   best integrate the blob mechanism.
   Mimi suggested that it could be used to implement trusted keys.
   Trusted keys back then were a TPM-only feature.

 - security/keys/secure_key: Adds the secure key support based on CAAM.
   Udit added[2] a new "secure" key type with the CAAM as backend. The key
   material stays within the kernel only.
   Mimi and James agreed that this needs a generic interface, not specific
   to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
   basis for TEE-backed keys.

 - [RFC] drivers: crypto: caam: key: Add caam_tk key type
   Franck added[3] a new "caam_tk" key type based on Udit's work. The key
   material stays within the kernel only, but can optionally be user-set
   instead of coming from RNG. James voiced the opinion that there should
   be just one user-facing generic wrap/unwrap key type with multiple
   possible handlers. David suggested trusted keys.

 - Introduce TEE based Trusted Keys support
   Sumit reworked[4] trusted keys to support multiple possible backends with
   one chosen at boot time and added a new TEE backend along with TPM.
   This now sits in Jarkko's master branch to be sent out for v5.13

This patch series builds on top of Sumit's rework to have the CAAM as yet another
trusted key backend.

The CAAM bits are based on Steffen's initial patch from 2015. His work had been
used in the field for some years now, so I preferred not to deviate too much from it.

This series has been tested with dmcrypt[5] on an i.MX6DL.

Looking forward to your feedback.

Cheers,
Ahmad

 [1]: https://lore.kernel.org/linux-crypto/1447082306-19946-2-git-send-email-s.trumtrar@pengutronix.de/
 [2]: https://lore.kernel.org/linux-integrity/20180723111432.26830-1-udit.agarwal@nxp.com/
 [3]: https://lore.kernel.org/lkml/1551456599-10603-2-git-send-email-franck.lenormand@nxp.com/
 [4]: https://lore.kernel.org/lkml/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/
 [5]: https://lore.kernel.org/linux-integrity/20210122084321.24012-2-a.fatoum@pengutronix.de/

---
To: Jarkko Sakkinen <jarkko@kernel.org>
To: "Horia Geantă" <horia.geanta@nxp.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: Aymen Sghaier <aymen.sghaier@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
To: James Bottomley <jejb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Udit Agarwal <udit.agarwal@nxp.com>
Cc: Jan Luebbe <j.luebbe@penutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org

Ahmad Fatoum (3):
  crypto: caam - add in-kernel interface for blob generator
  KEYS: trusted: implement fallback to kernel RNG
  KEYS: trusted: Introduce support for NXP CAAM-based trusted keys

 Documentation/admin-guide/kernel-parameters.txt |   1 +-
 drivers/crypto/caam/Kconfig                     |   4 +-
 drivers/crypto/caam/Makefile                    |   1 +-
 drivers/crypto/caam/blob_gen.c                  | 230 +++++++++++++++++-
 include/keys/trusted-type.h                     |   2 +-
 include/keys/trusted_caam.h                     |  11 +-
 include/soc/fsl/caam-blob.h                     |  54 ++++-
 security/keys/trusted-keys/Makefile             |   1 +-
 security/keys/trusted-keys/trusted_caam.c       |  74 +++++-
 security/keys/trusted-keys/trusted_core.c       |  17 +-
 10 files changed, 392 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/caam/blob_gen.c
 create mode 100644 include/keys/trusted_caam.h
 create mode 100644 include/soc/fsl/caam-blob.h
 create mode 100644 security/keys/trusted-keys/trusted_caam.c

base-commit: 8a3fa8ade8a35d8f7c178f5680f07f223da41b87
-- 
git-series 0.9.1
