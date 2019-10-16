Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8FD87E7
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Oct 2019 07:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfJPFPi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Oct 2019 01:15:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfJPFPi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Oct 2019 01:15:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so13925870pff.9
        for <linux-security-module@vger.kernel.org>; Tue, 15 Oct 2019 22:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lr1ltVMZNqbgjZMUm9NKbSHi7sLeyoSPXYNew21imkQ=;
        b=QL3E/QPMmbyB52TQp/G8qykxMJ/QFaGgFAeeBiGKV9sEtQKY7A1KzrA77EPKahkgj+
         gyGN5P3YBeW/x3rHnCt1wlT0S2tFupYOtPImoj1VlarDxZE8T2ImRs7ZB9D9AU72GQ9j
         3h93dCmKGYTVJ4eANRmBjL7U3lP835bvDOGI1OzI8Se91QuAN3qS5D9Efbe/QMJm+nFZ
         VnbKvpDRuFPk/Tv0KNtwYILYaF6yNSYFpYtAvl9Z9j/nvjnAF5ht+0DhERI0E8Y4kI0z
         i22qzXhMdnBrsENun9yohBJnoqYiiq+wj69fiMWL8kdjuqWvGQ3ZtQe4rbxPYxbV04DZ
         1+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lr1ltVMZNqbgjZMUm9NKbSHi7sLeyoSPXYNew21imkQ=;
        b=jWOBx9o14k5aDSdpmBiu8gGtWcPT25TGisaHAhbiDUS0VI7mr3YXv1WOwEIsG2pyur
         6TmUYnOrriBa3Aa96JJRA1F5Kn+w3HW87pLdOUCMqqzfk17DBTU1O1mOz5B5tA6ukzbA
         23bcuauzAaXfB8oVm1U1UPJqgrgAK7hGWliZjGBgi+cPD+Jy+tAAjL+K/Ra6sdex5IHS
         LoknxKZeSkcU2IdhjMlE0Kcpn5pW4byYjmuTZnero4LaOQhdBOmV7b9ko5BzvOtpzIwp
         ukXOU2Fseqw69L82C2nl7c8xO3Dh+DoyiIIjRZQr3ndHWTrkc2TLd9COs//84JwrkehI
         a64w==
X-Gm-Message-State: APjAAAWKOclBdnx/ivx09ZmE6NT61fzAP51ja8pqpmJ+ypRR696v2QcF
        LpKRpRJhrQeoKzSE+KeHSn3o8A==
X-Google-Smtp-Source: APXvYqwu8YtsgHG3UD1uoJm34B9DvbCWYUTPpN/FjRHRGhX62HvOjaecCdKjqp1pTDr++qPmFs80TQ==
X-Received: by 2002:a63:81:: with SMTP id 123mr43384443pga.47.1571202936741;
        Tue, 15 Oct 2019 22:15:36 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.194])
        by smtp.gmail.com with ESMTPSA id r81sm953297pgr.17.2019.10.15.22.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Oct 2019 22:15:35 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v8 2/4] KEYS: Use common tpm_buf for trusted and asymmetric keys
Date:   Wed, 16 Oct 2019 10:44:53 +0530
Message-Id: <1571202895-32651-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571202895-32651-1-git-send-email-sumit.garg@linaro.org>
References: <1571202895-32651-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Switch to utilize common heap based tpm_buf code for TPM based trusted
and asymmetric keys rather than using stack based tpm1_buf code. Also,
remove tpm1_buf code.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 crypto/asymmetric_keys/asym_tpm.c | 107 ++++++++++++++++----------------------
 include/keys/trusted.h            |  37 +------------
 security/keys/trusted.c           |  98 +++++++++++++++-------------------
 3 files changed, 89 insertions(+), 153 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index b88968d..a2b2a61 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -21,17 +21,13 @@
 #define TPM_ORD_LOADKEY2	65
 #define TPM_ORD_UNBIND		30
 #define TPM_ORD_SIGN		60
-#define TPM_LOADKEY2_SIZE		59
-#define TPM_FLUSHSPECIFIC_SIZE		18
-#define TPM_UNBIND_SIZE			63
-#define TPM_SIGN_SIZE			63
 
 #define TPM_RT_KEY                      0x00000001
 
 /*
  * Load a TPM key from the blob provided by userspace
  */
-static int tpm_loadkey2(struct tpm1_buf *tb,
+static int tpm_loadkey2(struct tpm_buf *tb,
 			uint32_t keyhandle, unsigned char *keyauth,
 			const unsigned char *keyblob, int keybloblen,
 			uint32_t *newhandle)
@@ -68,16 +64,13 @@ static int tpm_loadkey2(struct tpm1_buf *tb,
 		return ret;
 
 	/* build the request buffer */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_LOADKEY2_SIZE + keybloblen);
-	store32(tb, TPM_ORD_LOADKEY2);
-	store32(tb, keyhandle);
-	storebytes(tb, keyblob, keybloblen);
-	store32(tb, authhandle);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_LOADKEY2);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append(tb, keyblob, keybloblen);
+	tpm_buf_append_u32(tb, authhandle);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -99,14 +92,11 @@ static int tpm_loadkey2(struct tpm1_buf *tb,
 /*
  * Execute the FlushSpecific TPM command
  */
-static int tpm_flushspecific(struct tpm1_buf *tb, uint32_t handle)
+static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
 {
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_FLUSHSPECIFIC_SIZE);
-	store32(tb, TPM_ORD_FLUSHSPECIFIC);
-	store32(tb, handle);
-	store32(tb, TPM_RT_KEY);
+	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_FLUSHSPECIFIC);
+	tpm_buf_append_u32(tb, handle);
+	tpm_buf_append_u32(tb, TPM_RT_KEY);
 
 	return trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 }
@@ -115,7 +105,7 @@ static int tpm_flushspecific(struct tpm1_buf *tb, uint32_t handle)
  * Decrypt a blob provided by userspace using a specific key handle.
  * The handle is a well known handle or previously loaded by e.g. LoadKey2
  */
-static int tpm_unbind(struct tpm1_buf *tb,
+static int tpm_unbind(struct tpm_buf *tb,
 			uint32_t keyhandle, unsigned char *keyauth,
 			const unsigned char *blob, uint32_t bloblen,
 			void *out, uint32_t outlen)
@@ -155,17 +145,14 @@ static int tpm_unbind(struct tpm1_buf *tb,
 		return ret;
 
 	/* build the request buffer */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_UNBIND_SIZE + bloblen);
-	store32(tb, TPM_ORD_UNBIND);
-	store32(tb, keyhandle);
-	store32(tb, bloblen);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_UNBIND);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append_u32(tb, bloblen);
+	tpm_buf_append(tb, blob, bloblen);
+	tpm_buf_append_u32(tb, authhandle);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -201,7 +188,7 @@ static int tpm_unbind(struct tpm1_buf *tb,
  * up to key_length_in_bytes - 11 and not be limited to size 20 like the
  * TPM_SS_RSASSAPKCS1v15_SHA1 signature scheme.
  */
-static int tpm_sign(struct tpm1_buf *tb,
+static int tpm_sign(struct tpm_buf *tb,
 		    uint32_t keyhandle, unsigned char *keyauth,
 		    const unsigned char *blob, uint32_t bloblen,
 		    void *out, uint32_t outlen)
@@ -241,17 +228,14 @@ static int tpm_sign(struct tpm1_buf *tb,
 		return ret;
 
 	/* build the request buffer */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_SIGN_SIZE + bloblen);
-	store32(tb, TPM_ORD_SIGN);
-	store32(tb, keyhandle);
-	store32(tb, bloblen);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_SIGN);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append_u32(tb, bloblen);
+	tpm_buf_append(tb, blob, bloblen);
+	tpm_buf_append_u32(tb, authhandle);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -519,7 +503,7 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 			   struct kernel_pkey_params *params,
 			   const void *in, void *out)
 {
-	struct tpm1_buf *tb;
+	struct tpm_buf tb;
 	uint32_t keyhandle;
 	uint8_t srkauth[SHA1_DIGEST_SIZE];
 	uint8_t keyauth[SHA1_DIGEST_SIZE];
@@ -533,14 +517,14 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 	if (strcmp(params->encoding, "pkcs1"))
 		return -ENOPKG;
 
-	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
+	r = tpm_buf_init(&tb, 0, 0);
+	if (r)
+		return r;
 
 	/* TODO: Handle a non-all zero SRK authorization */
 	memset(srkauth, 0, sizeof(srkauth));
 
-	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+	r = tpm_loadkey2(&tb, SRKHANDLE, srkauth,
 				tk->blob, tk->blob_len, &keyhandle);
 	if (r < 0) {
 		pr_devel("loadkey2 failed (%d)\n", r);
@@ -550,16 +534,16 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 	/* TODO: Handle a non-all zero key authorization */
 	memset(keyauth, 0, sizeof(keyauth));
 
-	r = tpm_unbind(tb, keyhandle, keyauth,
+	r = tpm_unbind(&tb, keyhandle, keyauth,
 		       in, params->in_len, out, params->out_len);
 	if (r < 0)
 		pr_devel("tpm_unbind failed (%d)\n", r);
 
-	if (tpm_flushspecific(tb, keyhandle) < 0)
+	if (tpm_flushspecific(&tb, keyhandle) < 0)
 		pr_devel("flushspecific failed (%d)\n", r);
 
 error:
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 	pr_devel("<==%s() = %d\n", __func__, r);
 	return r;
 }
@@ -643,7 +627,7 @@ static int tpm_key_sign(struct tpm_key *tk,
 			struct kernel_pkey_params *params,
 			const void *in, void *out)
 {
-	struct tpm1_buf *tb;
+	struct tpm_buf tb;
 	uint32_t keyhandle;
 	uint8_t srkauth[SHA1_DIGEST_SIZE];
 	uint8_t keyauth[SHA1_DIGEST_SIZE];
@@ -681,15 +665,14 @@ static int tpm_key_sign(struct tpm_key *tk,
 		goto error_free_asn1_wrapped;
 	}
 
-	r = -ENOMEM;
-	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
-	if (!tb)
+	r = tpm_buf_init(&tb, 0, 0);
+	if (r)
 		goto error_free_asn1_wrapped;
 
 	/* TODO: Handle a non-all zero SRK authorization */
 	memset(srkauth, 0, sizeof(srkauth));
 
-	r = tpm_loadkey2(tb, SRKHANDLE, srkauth,
+	r = tpm_loadkey2(&tb, SRKHANDLE, srkauth,
 			 tk->blob, tk->blob_len, &keyhandle);
 	if (r < 0) {
 		pr_devel("loadkey2 failed (%d)\n", r);
@@ -699,15 +682,15 @@ static int tpm_key_sign(struct tpm_key *tk,
 	/* TODO: Handle a non-all zero key authorization */
 	memset(keyauth, 0, sizeof(keyauth));
 
-	r = tpm_sign(tb, keyhandle, keyauth, in, in_len, out, params->out_len);
+	r = tpm_sign(&tb, keyhandle, keyauth, in, in_len, out, params->out_len);
 	if (r < 0)
 		pr_devel("tpm_sign failed (%d)\n", r);
 
-	if (tpm_flushspecific(tb, keyhandle) < 0)
+	if (tpm_flushspecific(&tb, keyhandle) < 0)
 		pr_devel("flushspecific failed (%d)\n", r);
 
 error_free_tb:
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 error_free_asn1_wrapped:
 	kfree(asn1_wrapped);
 	pr_devel("<==%s() = %d\n", __func__, r);
diff --git a/include/keys/trusted.h b/include/keys/trusted.h
index 841ae11..29e3e9b 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted.h
@@ -5,10 +5,6 @@
 /* implementation specific TPM constants */
 #define MAX_BUF_SIZE			1024
 #define TPM_GETRANDOM_SIZE		14
-#define TPM_OSAP_SIZE			36
-#define TPM_OIAP_SIZE			10
-#define TPM_SEAL_SIZE			87
-#define TPM_UNSEAL_SIZE			104
 #define TPM_SIZE_OFFSET			2
 #define TPM_RETURN_OFFSET		6
 #define TPM_DATA_OFFSET			10
@@ -17,13 +13,6 @@
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
 #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
 
-struct tpm1_buf {
-	int len;
-	unsigned char data[MAX_BUF_SIZE];
-};
-
-#define INIT_BUF(tb) (tb->len = 0)
-
 struct osapsess {
 	uint32_t handle;
 	unsigned char secret[SHA1_DIGEST_SIZE];
@@ -46,7 +35,7 @@ int TSS_checkhmac1(unsigned char *buffer,
 			  unsigned int keylen, ...);
 
 int trusted_tpm_send(unsigned char *cmd, size_t buflen);
-int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce);
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
 
 #define TPM_DEBUG 0
 
@@ -109,28 +98,4 @@ static inline void dump_tpm_buf(unsigned char *buf)
 {
 }
 #endif
-
-static inline void store8(struct tpm1_buf *buf, const unsigned char value)
-{
-	buf->data[buf->len++] = value;
-}
-
-static inline void store16(struct tpm1_buf *buf, const uint16_t value)
-{
-	*(uint16_t *) & buf->data[buf->len] = htons(value);
-	buf->len += sizeof value;
-}
-
-static inline void store32(struct tpm1_buf *buf, const uint32_t value)
-{
-	*(uint32_t *) & buf->data[buf->len] = htonl(value);
-	buf->len += sizeof value;
-}
-
-static inline void storebytes(struct tpm1_buf *buf, const unsigned char *in,
-			      const int len)
-{
-	memcpy(buf->data + buf->len, in, len);
-	buf->len += len;
-}
 #endif
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 4cfae208..7071011 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -395,7 +395,7 @@ static int pcrlock(const int pcrnum)
 /*
  * Create an object specific authorisation protocol (OSAP) session
  */
-static int osap(struct tpm1_buf *tb, struct osapsess *s,
+static int osap(struct tpm_buf *tb, struct osapsess *s,
 		const unsigned char *key, uint16_t type, uint32_t handle)
 {
 	unsigned char enonce[TPM_NONCE_SIZE];
@@ -406,13 +406,10 @@ static int osap(struct tpm1_buf *tb, struct osapsess *s,
 	if (ret != TPM_NONCE_SIZE)
 		return ret;
 
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_OSAP_SIZE);
-	store32(tb, TPM_ORD_OSAP);
-	store16(tb, type);
-	store32(tb, handle);
-	storebytes(tb, ononce, TPM_NONCE_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OSAP);
+	tpm_buf_append_u16(tb, type);
+	tpm_buf_append_u32(tb, handle);
+	tpm_buf_append(tb, ononce, TPM_NONCE_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0)
@@ -430,17 +427,14 @@ static int osap(struct tpm1_buf *tb, struct osapsess *s,
 /*
  * Create an object independent authorisation protocol (oiap) session
  */
-int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce)
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
 	if (!chip)
 		return -ENODEV;
 
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_OIAP_SIZE);
-	store32(tb, TPM_ORD_OIAP);
+	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OIAP);
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0)
 		return ret;
@@ -464,7 +458,7 @@ struct tpm_digests {
  * Have the TPM seal(encrypt) the trusted key, possibly based on
  * Platform Configuration Registers (PCRs). AUTH1 for sealing key.
  */
-static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
+static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 		    uint32_t keyhandle, const unsigned char *keyauth,
 		    const unsigned char *data, uint32_t datalen,
 		    unsigned char *blob, uint32_t *bloblen,
@@ -535,20 +529,17 @@ static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
 		goto out;
 
 	/* build and send the TPM request packet */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_SEAL_SIZE + pcrinfosize + datalen);
-	store32(tb, TPM_ORD_SEAL);
-	store32(tb, keyhandle);
-	storebytes(tb, td->encauth, SHA1_DIGEST_SIZE);
-	store32(tb, pcrinfosize);
-	storebytes(tb, pcrinfo, pcrinfosize);
-	store32(tb, datalen);
-	storebytes(tb, data, datalen);
-	store32(tb, sess.handle);
-	storebytes(tb, td->nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, td->pubauth, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_SEAL);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append(tb, td->encauth, SHA1_DIGEST_SIZE);
+	tpm_buf_append_u32(tb, pcrinfosize);
+	tpm_buf_append(tb, pcrinfo, pcrinfosize);
+	tpm_buf_append_u32(tb, datalen);
+	tpm_buf_append(tb, data, datalen);
+	tpm_buf_append_u32(tb, sess.handle);
+	tpm_buf_append(tb, td->nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, td->pubauth, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0)
@@ -579,7 +570,7 @@ static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
 /*
  * use the AUTH2_COMMAND form of unseal, to authorize both key and blob
  */
-static int tpm_unseal(struct tpm1_buf *tb,
+static int tpm_unseal(struct tpm_buf *tb,
 		      uint32_t keyhandle, const unsigned char *keyauth,
 		      const unsigned char *blob, int bloblen,
 		      const unsigned char *blobauth,
@@ -628,20 +619,17 @@ static int tpm_unseal(struct tpm1_buf *tb,
 		return ret;
 
 	/* build and send TPM request packet */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH2_COMMAND);
-	store32(tb, TPM_UNSEAL_SIZE + bloblen);
-	store32(tb, TPM_ORD_UNSEAL);
-	store32(tb, keyhandle);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle1);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata1, SHA1_DIGEST_SIZE);
-	store32(tb, authhandle2);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata2, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH2_COMMAND, TPM_ORD_UNSEAL);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append(tb, blob, bloblen);
+	tpm_buf_append_u32(tb, authhandle1);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata1, SHA1_DIGEST_SIZE);
+	tpm_buf_append_u32(tb, authhandle2);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata2, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -670,23 +658,23 @@ static int tpm_unseal(struct tpm1_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
-	struct tpm1_buf *tb;
+	struct tpm_buf tb;
 	int ret;
 
-	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
+	ret = tpm_buf_init(&tb, 0, 0);
+	if (ret)
+		return ret;
 
 	/* include migratable flag at end of sealed key */
 	p->key[p->key_len] = p->migratable;
 
-	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
+	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
 	if (ret < 0)
 		pr_info("trusted_key: srkseal failed (%d)\n", ret);
 
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 	return ret;
 }
 
@@ -696,14 +684,14 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
-	struct tpm1_buf *tb;
+	struct tpm_buf tb;
 	int ret;
 
-	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
+	ret = tpm_buf_init(&tb, 0, 0);
+	if (ret)
+		return ret;
 
-	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
+	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
 			 o->blobauth, p->key, &p->key_len);
 	if (ret < 0)
 		pr_info("trusted_key: srkunseal failed (%d)\n", ret);
@@ -711,7 +699,7 @@ static int key_unseal(struct trusted_key_payload *p,
 		/* pull migratable flag out of sealed key */
 		p->migratable = p->key[--p->key_len];
 
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 	return ret;
 }
 
-- 
2.7.4

