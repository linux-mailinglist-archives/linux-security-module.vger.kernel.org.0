Return-Path: <linux-security-module+bounces-5417-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC885973B15
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2024 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6181C23C47
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2024 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A2199E9D;
	Tue, 10 Sep 2024 15:10:57 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE79190692;
	Tue, 10 Sep 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981057; cv=none; b=airjo5KwhWBgiPpXEgtPZz2JCrgpwpJw0No9Jb2+9RVUYpeCurfb3y2QJL2s2IusGgYJ4kcmZYqdLQTrq9xtQs9PiD2i5O3q/jNO2RF3n3kbLkDIJZbghDe5wkPJDz3IOwogY1P+TQqD+nVUH/AHrHBjJeEeCqhE+LikbXJFFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981057; c=relaxed/simple;
	bh=RvEkzoRGZncxU99yocU8RtcF6DBBtuY0n5G8kA1fg6s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=qrCSHzjIDvUOOMcfgFijJ4Ly/A/pDDRpiGLSmF9dUBMoPDWFoVNy2J4mc2lKS3v70hPae+yrujmtjpenlSR2Ut14co7Abz++c6gfPI7pvLiRcI0gNekSs84NPf2PX6KGQM+2+muY43BGITY1nFsuREB1KuLyYEZ/phMlwMKfGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 054EC10323569;
	Tue, 10 Sep 2024 17:10:52 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id C709660A8B01;
	Tue, 10 Sep 2024 17:10:51 +0200 (CEST)
X-Mailbox-Line: From 743afd4f298a3fad03e42ab46f913d1f51cb8b7c Mon Sep 17 00:00:00 2001
Message-ID: <743afd4f298a3fad03e42ab46f913d1f51cb8b7c.1725972335.git.lukas@wunner.de>
In-Reply-To: <cover.1725972333.git.lukas@wunner.de>
References: <cover.1725972333.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 10 Sep 2024 16:30:16 +0200
Subject: [PATCH v2 06/19] crypto: rsassa-pkcs1 - Migrate to sig_alg backend
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, Tadeusz Struk <tstruk@gigaio.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Zaborowski <andrew.zaborowski@intel.com>, Saulo Alessandre <saulo.alessandre@tse.jus.br>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ignat Korchagin <ignat@cloudflare.com>, Marek Behun <kabel@kernel.org>, Varad Gautam <varadgautam@google.com>, Stephan Mueller <smueller@chronox.de>, Denis Kenzior <denkenz@gmail.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

A sig_alg backend has just been introduced with the intent of moving all
asymmetric sign/verify algorithms to it one by one.

Migrate the sign/verify operations from rsa-pkcs1pad.c to a separate
rsassa-pkcs1.c which uses the new backend.

Consequently there are now two templates which build on the "rsa"
akcipher_alg:

* The existing "pkcs1pad" template, which is instantiated as an
  akcipher_instance and retains the encrypt/decrypt operations of
  RSAES-PKCS1-v1_5 (RFC 8017 sec 7.2).

* The new "pkcs1" template, which is instantiated as a sig_instance
  and contains the sign/verify operations of RSASSA-PKCS1-v1_5
  (RFC 8017 sec 8.2).

In a separate step, rsa-pkcs1pad.c could optionally be renamed to
rsaes-pkcs1.c for clarity.  Additional "oaep" and "pss" templates
could be added for RSAES-OAEP and RSASSA-PSS.

Note that it's currently allowed to allocate a "pkcs1pad(rsa)" transform
without specifying a hash algorithm.  That makes sense if the transform
is only used for encrypt/decrypt and continues to be supported.  But for
sign/verify, such transforms previously did not insert the Full Hash
Prefix into the padding.  The resulting message encoding was incompliant
with EMSA-PKCS1-v1_5 (RFC 8017 sec 9.2) and therefore nonsensical.

From here on in, it is no longer allowed to allocate a transform without
specifying a hash algorithm if the transform is used for sign/verify
operations.  This simplifies the code because the insertion of the Full
Hash Prefix is no longer optional, so various "if (digest_info)" clauses
can be removed.

There has been a previous attempt to forbid transform allocation without
specifying a hash algorithm, namely by commit c0d20d22e0ad ("crypto:
rsa-pkcs1pad - Require hash to be present").  It had to be rolled back
with commit b3a8c8a5ebb5 ("crypto: rsa-pkcs1pad: Allow hash to be
optional [ver #2]"), presumably because it broke allocation of a
transform which was solely used for encrypt/decrypt, not sign/verify.
Avoid such breakage by allowing transform allocation for encrypt/decrypt
with and without specifying a hash algorithm (and simply ignoring the
hash algorithm in the former case).

So again, specifying a hash algorithm is now mandatory for sign/verify,
but optional and ignored for encrypt/decrypt.

The new sig_alg API uses kernel buffers instead of sglists, which
avoids the overhead of copying signature and digest from sglists back
into kernel buffers.  rsassa-pkcs1.c is thus simplified quite a bit.

sig_alg is always synchronous, whereas the underlying "rsa" akcipher_alg
may be asynchronous.  So await the result of the akcipher_alg, similar
to crypto_akcipher_sync_{en,de}crypt().

As part of the migration, rename "rsa_digest_info" to "hash_prefix" to
adhere to the spec language in RFC 9580.  Otherwise keep the code
unmodified wherever possible to ease reviewing and bisecting.  Leave
several simplification and hardening opportunities to separate commits.

rsassa-pkcs1.c uses modern __free() syntax for allocation of buffers
which need to be freed by kfree_sensitive(), hence a DEFINE_FREE()
clause for kfree_sensitive() is introduced herein as a byproduct.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/Kconfig                      |   1 +
 crypto/Makefile                     |   1 +
 crypto/asymmetric_keys/public_key.c |  10 +-
 crypto/rsa-pkcs1pad.c               | 341 ++--------------------
 crypto/rsa.c                        |  17 +-
 crypto/rsassa-pkcs1.c               | 422 ++++++++++++++++++++++++++++
 crypto/testmgr.c                    |  22 +-
 crypto/testmgr.h                    |   3 +-
 include/crypto/internal/rsa.h       |   1 +
 include/linux/slab.h                |   1 +
 security/integrity/ima/ima_main.c   |   6 +-
 11 files changed, 480 insertions(+), 345 deletions(-)
 create mode 100644 crypto/rsassa-pkcs1.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e8488b8c45e3..94ef57c9e936 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -250,6 +250,7 @@ config CRYPTO_RSA
 	tristate "RSA (Rivest-Shamir-Adleman)"
 	select CRYPTO_AKCIPHER
 	select CRYPTO_MANAGER
+	select CRYPTO_SIG
 	select MPILIB
 	select ASN1
 	help
diff --git a/crypto/Makefile b/crypto/Makefile
index 4c99e5d376f6..7de29bf843e9 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -48,6 +48,7 @@ rsa_generic-y += rsaprivkey.asn1.o
 rsa_generic-y += rsa.o
 rsa_generic-y += rsa_helper.o
 rsa_generic-y += rsa-pkcs1pad.o
+rsa_generic-y += rsassa-pkcs1.o
 obj-$(CONFIG_CRYPTO_RSA) += rsa_generic.o
 
 $(obj)/ecdsasignature.asn1.o: $(obj)/ecdsasignature.asn1.c $(obj)/ecdsasignature.asn1.h
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 422940a6706a..3fb27ecd65f6 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -83,13 +83,19 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		if (strcmp(encoding, "pkcs1") == 0) {
 			*sig = op == kernel_pkey_sign ||
 			       op == kernel_pkey_verify;
-			if (!hash_algo) {
+			if (!*sig) {
+				/*
+				 * For encrypt/decrypt, hash_algo is not used
+				 * but allowed to be set for historic reasons.
+				 */
 				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
 					     "pkcs1pad(%s)",
 					     pkey->pkey_algo);
 			} else {
+				if (!hash_algo)
+					return -EINVAL;
 				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
-					     "pkcs1pad(%s,%s)",
+					     "pkcs1(%s,%s)",
 					     pkey->pkey_algo, hash_algo);
 			}
 			return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index 3c5fe8c93938..50bdb18e7b48 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -16,101 +16,6 @@
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 
-/*
- * Hash algorithm OIDs plus ASN.1 DER wrappings [RFC4880 sec 5.2.2].
- */
-static const u8 rsa_digest_info_md5[] = {
-	0x30, 0x20, 0x30, 0x0c, 0x06, 0x08,
-	0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x02, 0x05, /* OID */
-	0x05, 0x00, 0x04, 0x10
-};
-
-static const u8 rsa_digest_info_sha1[] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
-	0x2b, 0x0e, 0x03, 0x02, 0x1a,
-	0x05, 0x00, 0x04, 0x14
-};
-
-static const u8 rsa_digest_info_rmd160[] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
-	0x2b, 0x24, 0x03, 0x02, 0x01,
-	0x05, 0x00, 0x04, 0x14
-};
-
-static const u8 rsa_digest_info_sha224[] = {
-	0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x04,
-	0x05, 0x00, 0x04, 0x1c
-};
-
-static const u8 rsa_digest_info_sha256[] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
-	0x05, 0x00, 0x04, 0x20
-};
-
-static const u8 rsa_digest_info_sha384[] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02,
-	0x05, 0x00, 0x04, 0x30
-};
-
-static const u8 rsa_digest_info_sha512[] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03,
-	0x05, 0x00, 0x04, 0x40
-};
-
-static const u8 rsa_digest_info_sha3_256[] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x08,
-	0x05, 0x00, 0x04, 0x20
-};
-
-static const u8 rsa_digest_info_sha3_384[] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x09,
-	0x05, 0x00, 0x04, 0x30
-};
-
-static const u8 rsa_digest_info_sha3_512[] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x0A,
-	0x05, 0x00, 0x04, 0x40
-};
-
-static const struct rsa_asn1_template {
-	const char	*name;
-	const u8	*data;
-	size_t		size;
-} rsa_asn1_templates[] = {
-#define _(X) { #X, rsa_digest_info_##X, sizeof(rsa_digest_info_##X) }
-	_(md5),
-	_(sha1),
-	_(rmd160),
-	_(sha256),
-	_(sha384),
-	_(sha512),
-	_(sha224),
-#undef _
-#define _(X) { "sha3-" #X, rsa_digest_info_sha3_##X, sizeof(rsa_digest_info_sha3_##X) }
-	_(256),
-	_(384),
-	_(512),
-#undef _
-	{ NULL }
-};
-
-static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
-{
-	const struct rsa_asn1_template *p;
-
-	for (p = rsa_asn1_templates; p->name; p++)
-		if (strcmp(name, p->name) == 0)
-			return p;
-	return NULL;
-}
-
 struct pkcs1pad_ctx {
 	struct crypto_akcipher *child;
 	unsigned int key_size;
@@ -118,7 +23,6 @@ struct pkcs1pad_ctx {
 
 struct pkcs1pad_inst_ctx {
 	struct crypto_akcipher_spawn spawn;
-	const struct rsa_asn1_template *digest_info;
 };
 
 struct pkcs1pad_request {
@@ -148,9 +52,9 @@ static unsigned int pkcs1pad_get_max_size(struct crypto_akcipher *tfm)
 	struct pkcs1pad_ctx *ctx = akcipher_tfm_ctx(tfm);
 
 	/*
-	 * The maximum destination buffer size for the encrypt/sign operations
+	 * The maximum destination buffer size for the encrypt operation
 	 * will be the same as for RSA, even though it's smaller for
-	 * decrypt/verify.
+	 * decrypt.
 	 */
 
 	return ctx->key_size;
@@ -168,7 +72,7 @@ static void pkcs1pad_sg_set_buf(struct scatterlist *sg, void *buf, size_t len,
 		sg_chain(sg, nsegs, next);
 }
 
-static int pkcs1pad_encrypt_sign_complete(struct akcipher_request *req, int err)
+static int pkcs1pad_encrypt_complete(struct akcipher_request *req, int err)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct pkcs1pad_ctx *ctx = akcipher_tfm_ctx(tfm);
@@ -207,14 +111,14 @@ static int pkcs1pad_encrypt_sign_complete(struct akcipher_request *req, int err)
 	return err;
 }
 
-static void pkcs1pad_encrypt_sign_complete_cb(void *data, int err)
+static void pkcs1pad_encrypt_complete_cb(void *data, int err)
 {
 	struct akcipher_request *req = data;
 
 	if (err == -EINPROGRESS)
 		goto out;
 
-	err = pkcs1pad_encrypt_sign_complete(req, err);
+	err = pkcs1pad_encrypt_complete(req, err);
 
 out:
 	akcipher_request_complete(req, err);
@@ -255,7 +159,7 @@ static int pkcs1pad_encrypt(struct akcipher_request *req)
 
 	akcipher_request_set_tfm(&req_ctx->child_req, ctx->child);
 	akcipher_request_set_callback(&req_ctx->child_req, req->base.flags,
-			pkcs1pad_encrypt_sign_complete_cb, req);
+			pkcs1pad_encrypt_complete_cb, req);
 
 	/* Reuse output buffer */
 	akcipher_request_set_crypt(&req_ctx->child_req, req_ctx->in_sg,
@@ -263,7 +167,7 @@ static int pkcs1pad_encrypt(struct akcipher_request *req)
 
 	err = crypto_akcipher_encrypt(&req_ctx->child_req);
 	if (err != -EINPROGRESS && err != -EBUSY)
-		return pkcs1pad_encrypt_sign_complete(req, err);
+		return pkcs1pad_encrypt_complete(req, err);
 
 	return err;
 }
@@ -368,195 +272,6 @@ static int pkcs1pad_decrypt(struct akcipher_request *req)
 	return err;
 }
 
-static int pkcs1pad_sign(struct akcipher_request *req)
-{
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct pkcs1pad_ctx *ctx = akcipher_tfm_ctx(tfm);
-	struct pkcs1pad_request *req_ctx = akcipher_request_ctx(req);
-	struct akcipher_instance *inst = akcipher_alg_instance(tfm);
-	struct pkcs1pad_inst_ctx *ictx = akcipher_instance_ctx(inst);
-	const struct rsa_asn1_template *digest_info = ictx->digest_info;
-	int err;
-	unsigned int ps_end, digest_info_size = 0;
-
-	if (!ctx->key_size)
-		return -EINVAL;
-
-	if (digest_info)
-		digest_info_size = digest_info->size;
-
-	if (req->src_len + digest_info_size > ctx->key_size - 11)
-		return -EOVERFLOW;
-
-	if (req->dst_len < ctx->key_size) {
-		req->dst_len = ctx->key_size;
-		return -EOVERFLOW;
-	}
-
-	req_ctx->in_buf = kmalloc(ctx->key_size - 1 - req->src_len,
-				  GFP_KERNEL);
-	if (!req_ctx->in_buf)
-		return -ENOMEM;
-
-	ps_end = ctx->key_size - digest_info_size - req->src_len - 2;
-	req_ctx->in_buf[0] = 0x01;
-	memset(req_ctx->in_buf + 1, 0xff, ps_end - 1);
-	req_ctx->in_buf[ps_end] = 0x00;
-
-	if (digest_info)
-		memcpy(req_ctx->in_buf + ps_end + 1, digest_info->data,
-		       digest_info->size);
-
-	pkcs1pad_sg_set_buf(req_ctx->in_sg, req_ctx->in_buf,
-			ctx->key_size - 1 - req->src_len, req->src);
-
-	akcipher_request_set_tfm(&req_ctx->child_req, ctx->child);
-	akcipher_request_set_callback(&req_ctx->child_req, req->base.flags,
-			pkcs1pad_encrypt_sign_complete_cb, req);
-
-	/* Reuse output buffer */
-	akcipher_request_set_crypt(&req_ctx->child_req, req_ctx->in_sg,
-				   req->dst, ctx->key_size - 1, req->dst_len);
-
-	err = crypto_akcipher_decrypt(&req_ctx->child_req);
-	if (err != -EINPROGRESS && err != -EBUSY)
-		return pkcs1pad_encrypt_sign_complete(req, err);
-
-	return err;
-}
-
-static int pkcs1pad_verify_complete(struct akcipher_request *req, int err)
-{
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct pkcs1pad_ctx *ctx = akcipher_tfm_ctx(tfm);
-	struct pkcs1pad_request *req_ctx = akcipher_request_ctx(req);
-	struct akcipher_instance *inst = akcipher_alg_instance(tfm);
-	struct pkcs1pad_inst_ctx *ictx = akcipher_instance_ctx(inst);
-	const struct rsa_asn1_template *digest_info = ictx->digest_info;
-	const unsigned int sig_size = req->src_len;
-	const unsigned int digest_size = req->dst_len;
-	unsigned int dst_len;
-	unsigned int pos;
-	u8 *out_buf;
-
-	if (err)
-		goto done;
-
-	err = -EINVAL;
-	dst_len = req_ctx->child_req.dst_len;
-	if (dst_len < ctx->key_size - 1)
-		goto done;
-
-	out_buf = req_ctx->out_buf;
-	if (dst_len == ctx->key_size) {
-		if (out_buf[0] != 0x00)
-			/* Decrypted value had no leading 0 byte */
-			goto done;
-
-		dst_len--;
-		out_buf++;
-	}
-
-	err = -EBADMSG;
-	if (out_buf[0] != 0x01)
-		goto done;
-
-	for (pos = 1; pos < dst_len; pos++)
-		if (out_buf[pos] != 0xff)
-			break;
-
-	if (pos < 9 || pos == dst_len || out_buf[pos] != 0x00)
-		goto done;
-	pos++;
-
-	if (digest_info) {
-		if (digest_info->size > dst_len - pos)
-			goto done;
-		if (crypto_memneq(out_buf + pos, digest_info->data,
-				  digest_info->size))
-			goto done;
-
-		pos += digest_info->size;
-	}
-
-	err = 0;
-
-	if (digest_size != dst_len - pos) {
-		err = -EKEYREJECTED;
-		req->dst_len = dst_len - pos;
-		goto done;
-	}
-	/* Extract appended digest. */
-	sg_pcopy_to_buffer(req->src,
-			   sg_nents_for_len(req->src, sig_size + digest_size),
-			   req_ctx->out_buf + ctx->key_size,
-			   digest_size, sig_size);
-	/* Do the actual verification step. */
-	if (memcmp(req_ctx->out_buf + ctx->key_size, out_buf + pos,
-		   digest_size) != 0)
-		err = -EKEYREJECTED;
-done:
-	kfree_sensitive(req_ctx->out_buf);
-
-	return err;
-}
-
-static void pkcs1pad_verify_complete_cb(void *data, int err)
-{
-	struct akcipher_request *req = data;
-
-	if (err == -EINPROGRESS)
-		goto out;
-
-	err = pkcs1pad_verify_complete(req, err);
-
-out:
-	akcipher_request_complete(req, err);
-}
-
-/*
- * The verify operation is here for completeness similar to the verification
- * defined in RFC2313 section 10.2 except that block type 0 is not accepted,
- * as in RFC2437.  RFC2437 section 9.2 doesn't define any operation to
- * retrieve the DigestInfo from a signature, instead the user is expected
- * to call the sign operation to generate the expected signature and compare
- * signatures instead of the message-digests.
- */
-static int pkcs1pad_verify(struct akcipher_request *req)
-{
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct pkcs1pad_ctx *ctx = akcipher_tfm_ctx(tfm);
-	struct pkcs1pad_request *req_ctx = akcipher_request_ctx(req);
-	const unsigned int sig_size = req->src_len;
-	const unsigned int digest_size = req->dst_len;
-	int err;
-
-	if (WARN_ON(req->dst) || WARN_ON(!digest_size) ||
-	    !ctx->key_size || sig_size != ctx->key_size)
-		return -EINVAL;
-
-	req_ctx->out_buf = kmalloc(ctx->key_size + digest_size, GFP_KERNEL);
-	if (!req_ctx->out_buf)
-		return -ENOMEM;
-
-	pkcs1pad_sg_set_buf(req_ctx->out_sg, req_ctx->out_buf,
-			    ctx->key_size, NULL);
-
-	akcipher_request_set_tfm(&req_ctx->child_req, ctx->child);
-	akcipher_request_set_callback(&req_ctx->child_req, req->base.flags,
-			pkcs1pad_verify_complete_cb, req);
-
-	/* Reuse input buffer, output to a new buffer */
-	akcipher_request_set_crypt(&req_ctx->child_req, req->src,
-				   req_ctx->out_sg, sig_size, ctx->key_size);
-
-	err = crypto_akcipher_encrypt(&req_ctx->child_req);
-	if (err != -EINPROGRESS && err != -EBUSY)
-		return pkcs1pad_verify_complete(req, err);
-
-	return err;
-}
-
 static int pkcs1pad_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct akcipher_instance *inst = akcipher_alg_instance(tfm);
@@ -598,7 +313,6 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 	struct akcipher_instance *inst;
 	struct pkcs1pad_inst_ctx *ctx;
 	struct akcipher_alg *rsa_alg;
-	const char *hash_name;
 	int err;
 
 	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_AKCIPHER, &mask);
@@ -624,36 +338,15 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 	}
 
 	err = -ENAMETOOLONG;
-	hash_name = crypto_attr_alg_name(tb[2]);
-	if (IS_ERR(hash_name)) {
-		if (snprintf(inst->alg.base.cra_name,
-			     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s)",
-			     rsa_alg->base.cra_name) >= CRYPTO_MAX_ALG_NAME)
-			goto err_free_inst;
-
-		if (snprintf(inst->alg.base.cra_driver_name,
-			     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s)",
-			     rsa_alg->base.cra_driver_name) >=
-			     CRYPTO_MAX_ALG_NAME)
-			goto err_free_inst;
-	} else {
-		ctx->digest_info = rsa_lookup_asn1(hash_name);
-		if (!ctx->digest_info) {
-			err = -EINVAL;
-			goto err_free_inst;
-		}
-
-		if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
-			     "pkcs1pad(%s,%s)", rsa_alg->base.cra_name,
-			     hash_name) >= CRYPTO_MAX_ALG_NAME)
-			goto err_free_inst;
-
-		if (snprintf(inst->alg.base.cra_driver_name,
-			     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s,%s)",
-			     rsa_alg->base.cra_driver_name,
-			     hash_name) >= CRYPTO_MAX_ALG_NAME)
-			goto err_free_inst;
-	}
+	if (snprintf(inst->alg.base.cra_name,
+		     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s)",
+		     rsa_alg->base.cra_name) >= CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	if (snprintf(inst->alg.base.cra_driver_name,
+		     CRYPTO_MAX_ALG_NAME, "pkcs1pad(%s)",
+		     rsa_alg->base.cra_driver_name) >= CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
 
 	inst->alg.base.cra_priority = rsa_alg->base.cra_priority;
 	inst->alg.base.cra_ctxsize = sizeof(struct pkcs1pad_ctx);
@@ -663,8 +356,6 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	inst->alg.encrypt = pkcs1pad_encrypt;
 	inst->alg.decrypt = pkcs1pad_decrypt;
-	inst->alg.sign = pkcs1pad_sign;
-	inst->alg.verify = pkcs1pad_verify;
 	inst->alg.set_pub_key = pkcs1pad_set_pub_key;
 	inst->alg.set_priv_key = pkcs1pad_set_priv_key;
 	inst->alg.max_size = pkcs1pad_get_max_size;
diff --git a/crypto/rsa.c b/crypto/rsa.c
index d9be9e86097e..89e9fd9f6d7f 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -402,16 +402,25 @@ static int __init rsa_init(void)
 		return err;
 
 	err = crypto_register_template(&rsa_pkcs1pad_tmpl);
-	if (err) {
-		crypto_unregister_akcipher(&rsa);
-		return err;
-	}
+	if (err)
+		goto err_unregister_rsa;
+
+	err = crypto_register_template(&rsassa_pkcs1_tmpl);
+	if (err)
+		goto err_unregister_rsa_pkcs1pad;
 
 	return 0;
+
+err_unregister_rsa_pkcs1pad:
+	crypto_unregister_template(&rsa_pkcs1pad_tmpl);
+err_unregister_rsa:
+	crypto_unregister_akcipher(&rsa);
+	return err;
 }
 
 static void __exit rsa_exit(void)
 {
+	crypto_unregister_template(&rsassa_pkcs1_tmpl);
 	crypto_unregister_template(&rsa_pkcs1pad_tmpl);
 	crypto_unregister_akcipher(&rsa);
 }
diff --git a/crypto/rsassa-pkcs1.c b/crypto/rsassa-pkcs1.c
new file mode 100644
index 000000000000..779c080fc013
--- /dev/null
+++ b/crypto/rsassa-pkcs1.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RSA Signature Scheme with Appendix - PKCS #1 v1.5 (RFC 8017 sec 8.2)
+ *
+ * https://www.rfc-editor.org/rfc/rfc8017#section-8.2
+ *
+ * Copyright (c) 2015 - 2024 Intel Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <crypto/akcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/sig.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/internal/sig.h>
+
+/*
+ * Full Hash Prefix for EMSA-PKCS1-v1_5 encoding method (RFC 9580 table 24)
+ *
+ * RSA keys are usually much larger than the hash of the message to be signed.
+ * The hash is therefore prepended by the Full Hash Prefix and a 0xff padding.
+ * The Full Hash Prefix is an ASN.1 SEQUENCE containing the hash algorithm OID.
+ *
+ * https://www.rfc-editor.org/rfc/rfc9580#table-24
+ */
+
+static const u8 hash_prefix_md5[] = {
+	0x30, 0x20, 0x30, 0x0c, 0x06, 0x08,	  /* SEQUENCE (SEQUENCE (OID */
+	0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x02, 0x05,	/*	<algorithm>, */
+	0x05, 0x00, 0x04, 0x10		      /* NULL), OCTET STRING <hash>) */
+};
+
+static const u8 hash_prefix_sha1[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
+	0x2b, 0x0e, 0x03, 0x02, 0x1a,
+	0x05, 0x00, 0x04, 0x14
+};
+
+static const u8 hash_prefix_rmd160[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
+	0x2b, 0x24, 0x03, 0x02, 0x01,
+	0x05, 0x00, 0x04, 0x14
+};
+
+static const u8 hash_prefix_sha224[] = {
+	0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x04,
+	0x05, 0x00, 0x04, 0x1c
+};
+
+static const u8 hash_prefix_sha256[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
+	0x05, 0x00, 0x04, 0x20
+};
+
+static const u8 hash_prefix_sha384[] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02,
+	0x05, 0x00, 0x04, 0x30
+};
+
+static const u8 hash_prefix_sha512[] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03,
+	0x05, 0x00, 0x04, 0x40
+};
+
+static const u8 hash_prefix_sha3_256[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x08,
+	0x05, 0x00, 0x04, 0x20
+};
+
+static const u8 hash_prefix_sha3_384[] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x09,
+	0x05, 0x00, 0x04, 0x30
+};
+
+static const u8 hash_prefix_sha3_512[] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x0a,
+	0x05, 0x00, 0x04, 0x40
+};
+
+static const struct hash_prefix {
+	const char	*name;
+	const u8	*data;
+	size_t		size;
+} hash_prefixes[] = {
+#define _(X) { #X, hash_prefix_##X, sizeof(hash_prefix_##X) }
+	_(md5),
+	_(sha1),
+	_(rmd160),
+	_(sha256),
+	_(sha384),
+	_(sha512),
+	_(sha224),
+#undef _
+#define _(X) { "sha3-" #X, hash_prefix_sha3_##X, sizeof(hash_prefix_sha3_##X) }
+	_(256),
+	_(384),
+	_(512),
+#undef _
+	{ NULL }
+};
+
+static const struct hash_prefix *rsassa_pkcs1_find_hash_prefix(const char *name)
+{
+	const struct hash_prefix *p;
+
+	for (p = hash_prefixes; p->name; p++)
+		if (strcmp(name, p->name) == 0)
+			return p;
+	return NULL;
+}
+
+struct rsassa_pkcs1_ctx {
+	struct crypto_akcipher *child;
+	unsigned int key_size;
+};
+
+struct rsassa_pkcs1_inst_ctx {
+	struct crypto_akcipher_spawn spawn;
+	const struct hash_prefix *hash_prefix;
+};
+
+static int rsassa_pkcs1_sign(struct crypto_sig *tfm,
+			     const void *src, unsigned int slen,
+			     void *dst, unsigned int dlen)
+{
+	struct sig_instance *inst = sig_alg_instance(tfm);
+	struct rsassa_pkcs1_inst_ctx *ictx = sig_instance_ctx(inst);
+	const struct hash_prefix *hash_prefix = ictx->hash_prefix;
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+	unsigned int child_reqsize = crypto_akcipher_reqsize(ctx->child);
+	struct akcipher_request *child_req __free(kfree_sensitive) = NULL;
+	struct scatterlist in_sg[2], out_sg;
+	struct crypto_wait cwait;
+	unsigned int pad_len;
+	unsigned int ps_end;
+	unsigned int len;
+	u8 *in_buf;
+	int err;
+
+	if (!ctx->key_size)
+		return -EINVAL;
+
+	if (dlen < ctx->key_size)
+		return -EOVERFLOW;
+
+	if (slen + hash_prefix->size > ctx->key_size - 11)
+		return -EOVERFLOW;
+
+	child_req = kmalloc(sizeof(*child_req) + child_reqsize +
+			    ctx->key_size - 1 - slen, GFP_KERNEL);
+	if (!child_req)
+		return -ENOMEM;
+
+	/* RFC 8017 sec 8.2.1 step 1 - EMSA-PKCS1-v1_5 encoding generation */
+	in_buf = (u8 *)(child_req + 1) + child_reqsize;
+	ps_end = ctx->key_size - hash_prefix->size - slen - 2;
+	in_buf[0] = 0x01;
+	memset(in_buf + 1, 0xff, ps_end - 1);
+	in_buf[ps_end] = 0x00;
+	memcpy(in_buf + ps_end + 1, hash_prefix->data, hash_prefix->size);
+
+	/* RFC 8017 sec 8.2.1 step 2 - RSA signature */
+	crypto_init_wait(&cwait);
+	sg_init_table(in_sg, 2);
+	sg_set_buf(&in_sg[0], in_buf, ctx->key_size - 1 - slen);
+	sg_set_buf(&in_sg[1], src, slen);
+	sg_init_one(&out_sg, dst, dlen);
+	akcipher_request_set_tfm(child_req, ctx->child);
+	akcipher_request_set_crypt(child_req, in_sg, &out_sg,
+				   ctx->key_size - 1, dlen);
+	akcipher_request_set_callback(child_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	err = crypto_akcipher_decrypt(child_req);
+	err = crypto_wait_req(err, &cwait);
+	if (err)
+		return err;
+
+	len = child_req->dst_len;
+	pad_len = ctx->key_size - len;
+
+	/* Four billion to one */
+	if (unlikely(pad_len)) {
+		memmove(dst + pad_len, dst, len);
+		memset(dst, 0, pad_len);
+	}
+
+	return 0;
+}
+
+static int rsassa_pkcs1_verify(struct crypto_sig *tfm,
+			       const void *src, unsigned int slen,
+			       const void *digest, unsigned int dlen)
+{
+	struct sig_instance *inst = sig_alg_instance(tfm);
+	struct rsassa_pkcs1_inst_ctx *ictx = sig_instance_ctx(inst);
+	const struct hash_prefix *hash_prefix = ictx->hash_prefix;
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+	unsigned int child_reqsize = crypto_akcipher_reqsize(ctx->child);
+	struct akcipher_request *child_req __free(kfree_sensitive) = NULL;
+	struct scatterlist in_sg, out_sg;
+	struct crypto_wait cwait;
+	unsigned int dst_len;
+	unsigned int pos;
+	u8 *out_buf;
+	int err;
+
+	/* RFC 8017 sec 8.2.2 step 1 - length checking */
+	if (!ctx->key_size ||
+	    slen != ctx->key_size ||
+	    !dlen)
+		return -EINVAL;
+
+	/* RFC 8017 sec 8.2.2 step 2 - RSA verification */
+	child_req = kmalloc(sizeof(*child_req) + child_reqsize + ctx->key_size,
+			    GFP_KERNEL);
+	if (!child_req)
+		return -ENOMEM;
+
+	out_buf = (u8 *)(child_req + 1) + child_reqsize;
+
+	crypto_init_wait(&cwait);
+	sg_init_one(&in_sg, src, slen);
+	sg_init_one(&out_sg, out_buf, ctx->key_size);
+	akcipher_request_set_tfm(child_req, ctx->child);
+	akcipher_request_set_crypt(child_req, &in_sg, &out_sg,
+				   slen, ctx->key_size);
+	akcipher_request_set_callback(child_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	err = crypto_akcipher_encrypt(child_req);
+	err = crypto_wait_req(err, &cwait);
+	if (err)
+		return err;
+
+	/* RFC 8017 sec 8.2.2 step 3 - EMSA-PKCS1-v1_5 encoding verification */
+	dst_len = child_req->dst_len;
+	if (dst_len < ctx->key_size - 1)
+		return -EINVAL;
+
+	if (dst_len == ctx->key_size) {
+		if (out_buf[0] != 0x00)
+			/* Encrypted value had no leading 0 byte */
+			return -EINVAL;
+
+		dst_len--;
+		out_buf++;
+	}
+
+	if (out_buf[0] != 0x01)
+		return -EBADMSG;
+
+	for (pos = 1; pos < dst_len; pos++)
+		if (out_buf[pos] != 0xff)
+			break;
+
+	if (pos < 9 || pos == dst_len || out_buf[pos] != 0x00)
+		return -EBADMSG;
+	pos++;
+
+	if (hash_prefix->size > dst_len - pos)
+		return -EBADMSG;
+	if (crypto_memneq(out_buf + pos, hash_prefix->data, hash_prefix->size))
+		return -EBADMSG;
+	pos += hash_prefix->size;
+
+	/* RFC 8017 sec 8.2.2 step 4 - comparison of digest with out_buf */
+	if (dlen != dst_len - pos)
+		return -EKEYREJECTED;
+	if (memcmp(digest, out_buf + pos, dlen) != 0)
+		return -EKEYREJECTED;
+
+	return 0;
+}
+
+static unsigned int rsassa_pkcs1_max_size(struct crypto_sig *tfm)
+{
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+
+	return ctx->key_size;
+}
+
+static int rsassa_pkcs1_set_pub_key(struct crypto_sig *tfm,
+				    const void *key, unsigned int keylen)
+{
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+
+	return rsa_set_key(ctx->child, &ctx->key_size, RSA_PUB, key, keylen);
+}
+
+static int rsassa_pkcs1_set_priv_key(struct crypto_sig *tfm,
+				     const void *key, unsigned int keylen)
+{
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+
+	return rsa_set_key(ctx->child, &ctx->key_size, RSA_PRIV, key, keylen);
+}
+
+static int rsassa_pkcs1_init_tfm(struct crypto_sig *tfm)
+{
+	struct sig_instance *inst = sig_alg_instance(tfm);
+	struct rsassa_pkcs1_inst_ctx *ictx = sig_instance_ctx(inst);
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+	struct crypto_akcipher *child_tfm;
+
+	child_tfm = crypto_spawn_akcipher(&ictx->spawn);
+	if (IS_ERR(child_tfm))
+		return PTR_ERR(child_tfm);
+
+	ctx->child = child_tfm;
+
+	return 0;
+}
+
+static void rsassa_pkcs1_exit_tfm(struct crypto_sig *tfm)
+{
+	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
+
+	crypto_free_akcipher(ctx->child);
+}
+
+static void rsassa_pkcs1_free(struct sig_instance *inst)
+{
+	struct rsassa_pkcs1_inst_ctx *ctx = sig_instance_ctx(inst);
+	struct crypto_akcipher_spawn *spawn = &ctx->spawn;
+
+	crypto_drop_akcipher(spawn);
+	kfree(inst);
+}
+
+static int rsassa_pkcs1_create(struct crypto_template *tmpl, struct rtattr **tb)
+{
+	struct rsassa_pkcs1_inst_ctx *ctx;
+	struct akcipher_alg *rsa_alg;
+	struct sig_instance *inst;
+	const char *hash_name;
+	u32 mask;
+	int err;
+
+	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_SIG, &mask);
+	if (err)
+		return err;
+
+	inst = kzalloc(sizeof(*inst) + sizeof(*ctx), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	ctx = sig_instance_ctx(inst);
+
+	err = crypto_grab_akcipher(&ctx->spawn, sig_crypto_instance(inst),
+				   crypto_attr_alg_name(tb[1]), 0, mask);
+	if (err)
+		goto err_free_inst;
+
+	rsa_alg = crypto_spawn_akcipher_alg(&ctx->spawn);
+
+	if (strcmp(rsa_alg->base.cra_name, "rsa") != 0) {
+		err = -EINVAL;
+		goto err_free_inst;
+	}
+
+	hash_name = crypto_attr_alg_name(tb[2]);
+	if (IS_ERR(hash_name)) {
+		err = PTR_ERR(hash_name);
+		goto err_free_inst;
+	}
+
+	ctx->hash_prefix = rsassa_pkcs1_find_hash_prefix(hash_name);
+	if (!ctx->hash_prefix) {
+		err = -EINVAL;
+		goto err_free_inst;
+	}
+
+	err = -ENAMETOOLONG;
+	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
+		     "pkcs1(%s,%s)", rsa_alg->base.cra_name,
+		     hash_name) >= CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	if (snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
+		     "pkcs1(%s,%s)", rsa_alg->base.cra_driver_name,
+		     hash_name) >= CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	inst->alg.base.cra_priority = rsa_alg->base.cra_priority;
+	inst->alg.base.cra_ctxsize = sizeof(struct rsassa_pkcs1_ctx);
+
+	inst->alg.init = rsassa_pkcs1_init_tfm;
+	inst->alg.exit = rsassa_pkcs1_exit_tfm;
+
+	inst->alg.sign = rsassa_pkcs1_sign;
+	inst->alg.verify = rsassa_pkcs1_verify;
+	inst->alg.max_size = rsassa_pkcs1_max_size;
+	inst->alg.set_pub_key = rsassa_pkcs1_set_pub_key;
+	inst->alg.set_priv_key = rsassa_pkcs1_set_priv_key;
+
+	inst->free = rsassa_pkcs1_free;
+
+	err = sig_register_instance(tmpl, inst);
+	if (err) {
+err_free_inst:
+		rsassa_pkcs1_free(inst);
+	}
+	return err;
+}
+
+struct crypto_template rsassa_pkcs1_tmpl = {
+	.name = "pkcs1",
+	.create = rsassa_pkcs1_create,
+	.module = THIS_MODULE,
+};
+
+MODULE_ALIAS_CRYPTO("pkcs1");
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 0542817a9456..91dc29e79dd6 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5548,34 +5548,38 @@ static const struct alg_test_desc alg_test_descs[] = {
 			.cipher = __VECS(fcrypt_pcbc_tv_template)
 		}
 	}, {
-		.alg = "pkcs1pad(rsa,sha224)",
+		.alg = "pkcs1(rsa,sha224)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
-		.alg = "pkcs1pad(rsa,sha256)",
-		.test = alg_test_akcipher,
+		.alg = "pkcs1(rsa,sha256)",
+		.test = alg_test_sig,
 		.fips_allowed = 1,
 		.suite = {
-			.akcipher = __VECS(pkcs1pad_rsa_tv_template)
+			.sig = __VECS(pkcs1_rsa_tv_template)
 		}
 	}, {
-		.alg = "pkcs1pad(rsa,sha3-256)",
+		.alg = "pkcs1(rsa,sha3-256)",
+		.test = alg_test_null,
+		.fips_allowed = 1,
+	}, {
+		.alg = "pkcs1(rsa,sha3-384)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
-		.alg = "pkcs1pad(rsa,sha3-384)",
+		.alg = "pkcs1(rsa,sha3-512)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
-		.alg = "pkcs1pad(rsa,sha3-512)",
+		.alg = "pkcs1(rsa,sha384)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
-		.alg = "pkcs1pad(rsa,sha384)",
+		.alg = "pkcs1(rsa,sha512)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
-		.alg = "pkcs1pad(rsa,sha512)",
+		.alg = "pkcs1pad(rsa)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index fd4823c26d93..d29d03fec852 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1268,7 +1268,7 @@ static const struct sig_testvec ecrdsa_tv_template[] = {
 /*
  * PKCS#1 RSA test vectors. Obtained from CAVS testing.
  */
-static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
+static const struct sig_testvec pkcs1_rsa_tv_template[] = {
 	{
 	.key =
 	"\x30\x82\x04\xa5\x02\x01\x00\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
@@ -1380,7 +1380,6 @@ static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
 	"\xda\x62\x8d\xe1\x2a\x71\x91\x43\x40\x61\x3c\x5a\xbe\x86\xfc\x5b"
 	"\xe6\xf9\xa9\x16\x31\x1f\xaf\x25\x6d\xc2\x4a\x23\x6e\x63\x02\xa2",
 	.c_size = 256,
-	.siggen_sigver_test = true,
 	}
 };
 
diff --git a/include/crypto/internal/rsa.h b/include/crypto/internal/rsa.h
index 754f687134df..071a1951b992 100644
--- a/include/crypto/internal/rsa.h
+++ b/include/crypto/internal/rsa.h
@@ -82,4 +82,5 @@ static inline int rsa_set_key(struct crypto_akcipher *child,
 }
 
 extern struct crypto_template rsa_pkcs1pad_tmpl;
+extern struct crypto_template rsassa_pkcs1_tmpl;
 #endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..11b620b0ba1d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -280,6 +280,7 @@ void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
 DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
+DEFINE_FREE(kfree_sensitive, void *, if (_T) kfree_sensitive(_T))
 
 /**
  * ksize - Report actual allocation size of associated object
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..280a3feeba45 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1114,7 +1114,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 
 /**
- * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
+ * ima_kernel_module_request - Prevent crypto-pkcs1(rsa,*) requests
  * @kmod_name: kernel module name
  *
  * Avoid a verification loop where verifying the signature of the modprobe
@@ -1128,7 +1128,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
  * algorithm on the fly, but crypto_larval_lookup() will try to use alg_name
  * in order to load a kernel module with same name.
  *
- * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
+ * Since we don't have any real "crypto-pkcs1(rsa,*)" kernel modules,
  * we are safe to fail such module request from crypto_larval_lookup(), and
  * avoid the verification loop.
  *
@@ -1136,7 +1136,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
  */
 static int ima_kernel_module_request(char *kmod_name)
 {
-	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
+	if (strncmp(kmod_name, "crypto-pkcs1(rsa,", 17) == 0)
 		return -EINVAL;
 
 	return 0;
-- 
2.43.0


