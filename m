Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F517A5078
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Sep 2023 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjIRRHE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 Sep 2023 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRRHD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BA94
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 10:06:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso7662082e87.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695056815; x=1695661615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PomBX+56H7vrYuyW5mK+RISliEIE/fWMnEIx5++eWoM=;
        b=K1Cx1ugIjqoeo8R7drjdK753s1LB0JY1q/7ziUzD/wDsksPInI8iIWEWIkxwC7zpwR
         Tf3iR+oMhLkiMa235lheRlFdODuSLnmsT6uIEB1Gb58FJ8pWuqSlXUVZojuUAcIB/3zf
         QIQmnjC7JmhXSCRPvFH6X7DR3WcmsAjbfPrxCHl/+kVB9liC1lSL5vZS5SFXL2L0dq7G
         czSxEYqVeuCsFotr/G33oNHbyiknHatbk6J/ZZyzaZct0L/0HaOoyBPmxXDnB9HJGFK0
         slAmeiDAHtFgtJdP1HOncruk1Bo+eUGKLQflH22tOkEmkYjN3NZu/OzhxutsrIzjA4WP
         UOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056815; x=1695661615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PomBX+56H7vrYuyW5mK+RISliEIE/fWMnEIx5++eWoM=;
        b=ccG69vPEsLVXj/KKYSZlGpADAYNbWfcSknPvEs0jZLwZOCy6zNw9sQApdix6Q8lZoY
         GKU0iBiMANG3sLCSMDJLvtJLdzSOgcifgCyVlB1GAMU7r5VIECd/UuQkEd7CRWLqgaBv
         VmwMa1mmVeCyrC9WSerhxk/8UexOPUDLzu25h/V3sglfPhDuGLAa3X8HYciNoIgvh5Xe
         ONph2F4Nr5L0Vy9C1V47ThHHReNMRvtrwCCE1kN8pcKLRNxbRk2c+c4qwLG3joeOYmhf
         rZ+LKA4WGErKQBkZDxzd9zrvqwGtVT+7/nWTjJ1yxKTMUcXyzMYGM1sIkAX65wdu00Jf
         Fg+g==
X-Gm-Message-State: AOJu0YwD/U6rFJl6CfUJxtdsUhyjvgnhlCqoJIpM8nDC3P0OxkGLiHS/
        lAqWvZ3zutp2e18qfa7IfsMtStGIpyqpHagQUKSC6Q==
X-Google-Smtp-Source: AGHT+IE7PudVFRyVTSCFUj5G+MB8048X5oL3dmIhNpgsFEidEOg0vjf8zvgHSO8ppzPINT/Im8PoZw==
X-Received: by 2002:a17:906:3158:b0:9ad:c763:c3fd with SMTP id e24-20020a170906315800b009adc763c3fdmr7616048eje.28.1695046717137;
        Mon, 18 Sep 2023 07:18:37 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id jg36-20020a170907972400b009adc743340fsm5470921ejc.197.2023.09.18.07.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:18:36 -0700 (PDT)
From:   David Gstir <david@sigma-star.at>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     David Gstir <david@sigma-star.at>, Shawn Guo <shawnguo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        sigma star Kernel Team <upstream+dcp@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 1/3] crypto: mxs-dcp: Add support for hardware provided keys
Date:   Mon, 18 Sep 2023 16:18:23 +0200
Message-ID: <20230918141826.8139-2-david@sigma-star.at>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230918141826.8139-1-david@sigma-star.at>
References: <20230918141826.8139-1-david@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

DCP is capable to performing AES with hardware-bound keys.
These keys are not stored in main memory and are therefore not directly
accessible by the operating system.

So instead of feeding the key into DCP, we need to place a
reference to such a key before initiating the crypto operation.
Keys are referenced by a one byte identifiers.

DCP supports 6 different keys: 4 slots in the secure memory area,
a one time programmable key which can be burnt via on-chip fuses
and an unique device key.

Using these keys is restricted to in-kernel users that use them as building
block for other crypto tools such as trusted keys. Allowing userspace
(e.g. via AF_ALG) to use these keys to crypt or decrypt data is a security
risk, because there is no access control mechanism.

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
---
 drivers/crypto/mxs-dcp.c | 104 ++++++++++++++++++++++++++++++++++-----
 include/soc/fsl/dcp.h    |  17 +++++++
 2 files changed, 110 insertions(+), 11 deletions(-)
 create mode 100644 include/soc/fsl/dcp.h

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index f6b7bce0e656..2dc664fb2faf 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/stmp_device.h>
 #include <linux/clk.h>
+#include <soc/fsl/dcp.h>
 
 #include <crypto/aes.h>
 #include <crypto/sha1.h>
@@ -101,6 +102,7 @@ struct dcp_async_ctx {
 	struct crypto_skcipher		*fallback;
 	unsigned int			key_len;
 	uint8_t				key[AES_KEYSIZE_128];
+	bool				key_referenced;
 };
 
 struct dcp_aes_req_ctx {
@@ -155,6 +157,7 @@ static struct dcp *global_sdcp;
 #define MXS_DCP_CONTROL0_HASH_TERM		(1 << 13)
 #define MXS_DCP_CONTROL0_HASH_INIT		(1 << 12)
 #define MXS_DCP_CONTROL0_PAYLOAD_KEY		(1 << 11)
+#define MXS_DCP_CONTROL0_OTP_KEY		(1 << 10)
 #define MXS_DCP_CONTROL0_CIPHER_ENCRYPT		(1 << 8)
 #define MXS_DCP_CONTROL0_CIPHER_INIT		(1 << 9)
 #define MXS_DCP_CONTROL0_ENABLE_HASH		(1 << 6)
@@ -168,6 +171,8 @@ static struct dcp *global_sdcp;
 #define MXS_DCP_CONTROL1_CIPHER_MODE_ECB	(0 << 4)
 #define MXS_DCP_CONTROL1_CIPHER_SELECT_AES128	(0 << 0)
 
+#define MXS_DCP_CONTROL1_KEY_SELECT_SHIFT	8
+
 static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
 {
 	int dma_err;
@@ -224,13 +229,16 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	struct dcp *sdcp = global_sdcp;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
 	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	bool key_referenced = actx->key_referenced;
 	int ret;
 
-	key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
-				  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
-	ret = dma_mapping_error(sdcp->dev, key_phys);
-	if (ret)
-		return ret;
+	if (!key_referenced) {
+		key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
+					  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
+		ret = dma_mapping_error(sdcp->dev, key_phys);
+		if (ret)
+			return ret;
+	}
 
 	src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
 				  DCP_BUF_SZ, DMA_TO_DEVICE);
@@ -255,8 +263,12 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 		    MXS_DCP_CONTROL0_INTERRUPT |
 		    MXS_DCP_CONTROL0_ENABLE_CIPHER;
 
-	/* Payload contains the key. */
-	desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
+	if (key_referenced)
+		/* Set OTP key bit to select the key via KEY_SELECT. */
+		desc->control0 |= MXS_DCP_CONTROL0_OTP_KEY;
+	else
+		/* Payload contains the key. */
+		desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
 
 	if (rctx->enc)
 		desc->control0 |= MXS_DCP_CONTROL0_CIPHER_ENCRYPT;
@@ -270,6 +282,9 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	else
 		desc->control1 |= MXS_DCP_CONTROL1_CIPHER_MODE_CBC;
 
+	if (key_referenced)
+		desc->control1 |= sdcp->coh->aes_key[0] << MXS_DCP_CONTROL1_KEY_SELECT_SHIFT;
+
 	desc->next_cmd_addr = 0;
 	desc->source = src_phys;
 	desc->destination = dst_phys;
@@ -284,9 +299,9 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 err_dst:
 	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
 err_src:
-	dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
-			 DMA_TO_DEVICE);
-
+	if (!key_referenced)
+		dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
+				 DMA_TO_DEVICE);
 	return ret;
 }
 
@@ -453,7 +468,7 @@ static int mxs_dcp_aes_enqueue(struct skcipher_request *req, int enc, int ecb)
 	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
 	int ret;
 
-	if (unlikely(actx->key_len != AES_KEYSIZE_128))
+	if (unlikely(actx->key_len != AES_KEYSIZE_128 && !actx->key_referenced))
 		return mxs_dcp_block_fallback(req, enc);
 
 	rctx->enc = enc;
@@ -500,6 +515,7 @@ static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	 * there can still be an operation in progress.
 	 */
 	actx->key_len = len;
+	actx->key_referenced = false;
 	if (len == AES_KEYSIZE_128) {
 		memcpy(actx->key, key, len);
 		return 0;
@@ -516,6 +532,32 @@ static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return crypto_skcipher_setkey(actx->fallback, key, len);
 }
 
+static int mxs_dcp_aes_setrefkey(struct crypto_skcipher *tfm, const u8 *key,
+				 unsigned int len)
+{
+	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
+
+	if (len != DCP_PAES_KEYSIZE)
+		return -EINVAL;
+
+	switch (key[0]) {
+	case DCP_PAES_KEY_SLOT0:
+	case DCP_PAES_KEY_SLOT1:
+	case DCP_PAES_KEY_SLOT2:
+	case DCP_PAES_KEY_SLOT3:
+	case DCP_PAES_KEY_UNIQUE:
+	case DCP_PAES_KEY_OTP:
+		memcpy(actx->key, key, len);
+		actx->key_len = len;
+		actx->key_referenced = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mxs_dcp_aes_fallback_init_tfm(struct crypto_skcipher *tfm)
 {
 	const char *name = crypto_tfm_alg_name(crypto_skcipher_tfm(tfm));
@@ -539,6 +581,13 @@ static void mxs_dcp_aes_fallback_exit_tfm(struct crypto_skcipher *tfm)
 	crypto_free_skcipher(actx->fallback);
 }
 
+static int mxs_dcp_paes_init_tfm(struct crypto_skcipher *tfm)
+{
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct dcp_aes_req_ctx));
+
+	return 0;
+}
+
 /*
  * Hashing (SHA1/SHA256)
  */
@@ -889,6 +938,39 @@ static struct skcipher_alg dcp_aes_algs[] = {
 		.ivsize			= AES_BLOCK_SIZE,
 		.init			= mxs_dcp_aes_fallback_init_tfm,
 		.exit			= mxs_dcp_aes_fallback_exit_tfm,
+	}, {
+		.base.cra_name		= "ecb(paes)",
+		.base.cra_driver_name	= "ecb-paes-dcp",
+		.base.cra_priority	= 401,
+		.base.cra_alignmask	= 15,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DCP_PAES_KEYSIZE,
+		.max_keysize		= DCP_PAES_KEYSIZE,
+		.setkey			= mxs_dcp_aes_setrefkey,
+		.encrypt		= mxs_dcp_aes_ecb_encrypt,
+		.decrypt		= mxs_dcp_aes_ecb_decrypt,
+		.init			= mxs_dcp_paes_init_tfm,
+	}, {
+		.base.cra_name		= "cbc(paes)",
+		.base.cra_driver_name	= "cbc-paes-dcp",
+		.base.cra_priority	= 401,
+		.base.cra_alignmask	= 15,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DCP_PAES_KEYSIZE,
+		.max_keysize		= DCP_PAES_KEYSIZE,
+		.setkey			= mxs_dcp_aes_setrefkey,
+		.encrypt		= mxs_dcp_aes_cbc_encrypt,
+		.decrypt		= mxs_dcp_aes_cbc_decrypt,
+		.ivsize			= AES_BLOCK_SIZE,
+		.init			= mxs_dcp_paes_init_tfm,
 	},
 };
 
diff --git a/include/soc/fsl/dcp.h b/include/soc/fsl/dcp.h
new file mode 100644
index 000000000000..cda89e260c46
--- /dev/null
+++ b/include/soc/fsl/dcp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 sigma star gmbh
+ */
+
+#ifndef MXS_DCP_H
+#define MXS_DCP_H
+
+#define DCP_PAES_KEYSIZE 1
+#define DCP_PAES_KEY_SLOT0 0x00
+#define DCP_PAES_KEY_SLOT1 0x01
+#define DCP_PAES_KEY_SLOT2 0x02
+#define DCP_PAES_KEY_SLOT3 0x03
+#define DCP_PAES_KEY_UNIQUE 0xfe
+#define DCP_PAES_KEY_OTP 0xff
+
+#endif /* MXS_DCP_H */
-- 
2.35.3

