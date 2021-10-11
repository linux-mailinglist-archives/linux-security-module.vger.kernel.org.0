Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1216D428A61
	for <lists+linux-security-module@lfdr.de>; Mon, 11 Oct 2021 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhJKKFQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 11 Oct 2021 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhJKKFP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Oct 2021 06:05:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B778C061762
        for <linux-security-module@vger.kernel.org>; Mon, 11 Oct 2021 03:03:15 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1mZs8v-0006Sl-Gx; Mon, 11 Oct 2021 12:02:49 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1mZs8r-0002cs-UL; Mon, 11 Oct 2021 12:02:45 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 3/5] KEYS: trusted: allow trust sources to use kernel RNG for key material
Date:   Mon, 11 Oct 2021 12:02:36 +0200
Message-Id: <9431f31594f9ea693b201cfbfa9e7b221e500e6a.1633946449.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The two existing trusted key sources don't make use of the kernel RNG,
but instead let the hardware that does the sealing/unsealing also
generate the random key material. While a previous change offers users
the choice to use the kernel RNG instead for both, new trust sources
may want to unconditionally use the kernel RNG for generating key
material, like it's done elsewhere in the kernel.

This is especially prudent for hardware that has proven-in-production
HWRNG drivers implemented, as otherwise code would have to be duplicated
only to arrive at a possibly worse result.

Make this possible by turning struct trusted_key_ops::get_random
into an optional member. If a driver leaves it NULL, kernel RNG
will be used instead.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: David Gstir <david@sigma-star.at>
Tested-By: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
To: James Bottomley <jejb@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
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
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 include/keys/trusted-type.h               | 2 +-
 security/keys/trusted-keys/trusted_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index d89fa2579ac0..4eb64548a74f 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -64,7 +64,7 @@ struct trusted_key_ops {
 	/* Unseal a key. */
 	int (*unseal)(struct trusted_key_payload *p, char *datablob);
 
-	/* Get a randomized key. */
+	/* Optional: Get a randomized key. */
 	int (*get_random)(unsigned char *key, size_t key_len);
 
 	/* Exit key interface. */
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 569af9af8df0..d2b7626cde8b 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -334,7 +334,7 @@ static int __init init_trusted(void)
 			continue;
 
 		get_random = trusted_key_sources[i].ops->get_random;
-		if (trusted_kernel_rng)
+		if (trusted_kernel_rng || !get_random)
 			get_random = kernel_get_random;
 
 		static_call_update(trusted_key_init,
-- 
git-series 0.9.1
