Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8805526560
	for <lists+linux-security-module@lfdr.de>; Fri, 13 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381559AbiEMO6F (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 May 2022 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381556AbiEMO6E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 10:58:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED42715C
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 07:58:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1npWjS-0002Mt-CF; Fri, 13 May 2022 16:57:30 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1npWjR-0026HH-Ss; Fri, 13 May 2022 16:57:28 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1npWjO-008jCf-VH; Fri, 13 May 2022 16:57:26 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     kernel@pengutronix.de, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v10 0/7] KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Date:   Fri, 13 May 2022 16:56:58 +0200
Message-Id: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Series applies on top of v5.18-rc6. Would be great if this could make it
into v5.19.

v9 was here:
https://lore.kernel.org/linux-integrity/20220506062553.1068296-1-a.fatoum@pengutronix.de

Changelog is beneath each individual patch. Compared to v9, only code
change is checking whether CAAM can support blobbing at init-time for
CAAM revisions < 10 (such as LS1046A) to avoid a cryptic error message
at first use.


The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
built into many newer i.MX and QorIQ SoCs by NXP.

Its blob mechanism can AES encrypt/decrypt user data using a unique
never-disclosed device-specific key.

There has been multiple discussions on how to represent this within the kernel:

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
   Udit Agarwal added[2] a new "secure" key type with the CAAM as backend.
   The key material stays within the kernel only.
   Mimi and James agreed that this needs a generic interface, not specific
   to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
   basis for TEE-backed keys.

 - [RFC] drivers: crypto: caam: key: Add caam_tk key type
   Franck added[3] a new "caam_tk" key type based on Udit's work. This time
   it uses CAAM "black blobs" instead of "red blobs", so key material stays
   within the CAAM and isn't exposed to kernel in plaintext.
   James voiced the opinion that there should be just one user-facing generic
   wrap/unwrap key type with multiple possible handlers.
   David suggested trusted keys.

 - Introduce TEE based Trusted Keys support
   Sumit reworked[4] trusted keys to support multiple possible backends with
   one chosen at boot time and added a new TEE backend along with TPM.
   This now sits in Jarkko's master branch to be sent out for v5.13

This patch series builds on top of Sumit's rework to have the CAAM as yet another
trusted key backend.

The CAAM bits are based on Steffen's initial patch from 2015. His work had been
used in the field for some years now, so I preferred not to deviate too much from it.

This series has been tested with dmcrypt[5] on an i.MX6Q/DL, i.MX8M[6]
and LS1028[7].

Looking forward to your feedback.

Cheers,
Ahmad

 [1]: https://lore.kernel.org/linux-crypto/1447082306-19946-2-git-send-email-s.trumtrar@pengutronix.de/
 [2]: https://lore.kernel.org/linux-integrity/20180723111432.26830-1-udit.agarwal@nxp.com/
 [3]: https://lore.kernel.org/lkml/1551456599-10603-2-git-send-email-franck.lenormand@nxp.com/
 [4]: https://lore.kernel.org/lkml/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/
 [5]: https://lore.kernel.org/linux-integrity/20210122084321.24012-2-a.fatoum@pengutronix.de/
 [6]: https://lore.kernel.org/linux-integrity/DU2PR04MB8630D83FE9BBC0D782C4FAF595089@DU2PR04MB8630.eurprd04.prod.outlook.com/
 [7]: https://lore.kernel.org/linux-integrity/49e1738c55c73819ee0e2cac0be74d81@walle.cc/

---
To: Jarkko Sakkinen <jarkko@kernel.org>
To: "Horia Geantă" <horia.geanta@nxp.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
To: James Bottomley <jejb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Andreas Rammhold <andreas@rammhold.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Michael Walle <michael@walle.cc>
Cc: John Ernberg <john.ernberg@actia.se>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org



Ahmad Fatoum (7):
  KEYS: trusted: allow use of TEE as backend without TCG_TPM support
  KEYS: trusted: allow use of kernel RNG for key material
  crypto: caam - determine whether CAAM supports blob encap/decap
  crypto: caam - add in-kernel interface for blob generator
  KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
  doc: trusted-encrypted: describe new CAAM trust source
  MAINTAINERS: add KEYS-TRUSTED-CAAM

 .../admin-guide/kernel-parameters.txt         |  11 ++
 .../security/keys/trusted-encrypted.rst       |  60 +++++-
 MAINTAINERS                                   |   9 +
 drivers/crypto/caam/Kconfig                   |   3 +
 drivers/crypto/caam/Makefile                  |   1 +
 drivers/crypto/caam/blob_gen.c                | 182 ++++++++++++++++++
 drivers/crypto/caam/ctrl.c                    |  17 +-
 drivers/crypto/caam/intern.h                  |   1 +
 drivers/crypto/caam/regs.h                    |   4 +-
 include/keys/trusted-type.h                   |   2 +-
 include/keys/trusted_caam.h                   |  11 ++
 include/soc/fsl/caam-blob.h                   | 103 ++++++++++
 security/keys/Kconfig                         |  18 +-
 security/keys/trusted-keys/Kconfig            |  38 ++++
 security/keys/trusted-keys/Makefile           |  10 +-
 security/keys/trusted-keys/trusted_caam.c     |  80 ++++++++
 security/keys/trusted-keys/trusted_core.c     |  45 ++++-
 17 files changed, 563 insertions(+), 32 deletions(-)
 create mode 100644 drivers/crypto/caam/blob_gen.c
 create mode 100644 include/keys/trusted_caam.h
 create mode 100644 include/soc/fsl/caam-blob.h
 create mode 100644 security/keys/trusted-keys/Kconfig
 create mode 100644 security/keys/trusted-keys/trusted_caam.c

-- 
2.30.2

