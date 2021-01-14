Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7C2F645A
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Jan 2021 16:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbhANPUo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Jan 2021 10:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbhANPUk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jan 2021 10:20:40 -0500
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25DAC061796
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 07:19:14 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DGnz50q17zMqjbw;
        Thu, 14 Jan 2021 16:19:13 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DGnz45YjMzlh8TJ;
        Thu, 14 Jan 2021 16:19:12 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 07/10] certs: Factor out the blacklist hash creation
Date:   Thu, 14 Jan 2021 16:19:06 +0100
Message-Id: <20210114151909.2344974-8-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114151909.2344974-1-mic@digikod.net>
References: <20210114151909.2344974-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Factor out the blacklist hash creation with the get_raw_hash() helper.
This also centralize the "tbs" and "bin" prefixes and make them private,
which help to manage them consistently.

Cc: David Howells <dhowells@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---

Changes since v2:
* Add Jarkko's Acked-by.
---
 certs/blacklist.c                             | 73 ++++++++++++++-----
 crypto/asymmetric_keys/x509_public_key.c      |  3 +-
 include/keys/system_keyring.h                 | 14 +++-
 .../platform_certs/keyring_handler.c          | 26 +------
 4 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 334ab7b964bc..1e63971bea94 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -103,11 +103,43 @@ static struct key_type key_type_blacklist = {
 	.describe		= blacklist_describe,
 };
 
+static char *get_raw_hash(const u8 *hash, size_t hash_len,
+		enum blacklist_hash_type hash_type)
+{
+	size_t type_len;
+	const char *type_prefix;
+	char *buffer, *p;
+
+	switch (hash_type) {
+	case BLACKLIST_HASH_X509_TBS:
+		type_len = sizeof(tbs_prefix) - 1;
+		type_prefix = tbs_prefix;
+		break;
+	case BLACKLIST_HASH_BINARY:
+		type_len = sizeof(bin_prefix) - 1;
+		type_prefix = bin_prefix;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return ERR_PTR(-EINVAL);
+	}
+	buffer = kmalloc(type_len + 1 + hash_len * 2 + 1, GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	p = memcpy(buffer, type_prefix, type_len);
+	p += type_len;
+	*p++ = ':';
+	bin2hex(p, hash, hash_len);
+	p += hash_len * 2;
+	*p = '\0';
+	return buffer;
+}
+
 /**
- * mark_hash_blacklisted - Add a hash to the system blacklist
+ * mark_raw_hash_blacklisted - Add a hash to the system blacklist
  * @hash: The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
  */
-int mark_hash_blacklisted(const char *hash)
+static int mark_raw_hash_blacklisted(const char *hash)
 {
 	key_ref_t key;
 
@@ -127,29 +159,33 @@ int mark_hash_blacklisted(const char *hash)
 	return 0;
 }
 
+int mark_hash_blacklisted(const u8 *hash, size_t hash_len,
+		enum blacklist_hash_type hash_type)
+{
+	const char *buffer;
+
+	buffer = get_raw_hash(hash, hash_len, hash_type);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+	kfree(buffer);
+	return 0;
+}
 /**
  * is_hash_blacklisted - Determine if a hash is blacklisted
  * @hash: The hash to be checked as a binary blob
  * @hash_len: The length of the binary hash
- * @type: Type of hash
+ * @hash_type: Type of hash
  */
-int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
+int is_hash_blacklisted(const u8 *hash, size_t hash_len,
+		enum blacklist_hash_type hash_type)
 {
 	key_ref_t kref;
-	size_t type_len = strlen(type);
-	char *buffer, *p;
+	const char *buffer;
 	int ret = 0;
 
-	buffer = kmalloc(type_len + 1 + hash_len * 2 + 1, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-	p = memcpy(buffer, type, type_len);
-	p += type_len;
-	*p++ = ':';
-	bin2hex(p, hash, hash_len);
-	p += hash_len * 2;
-	*p = 0;
-
+	buffer = get_raw_hash(hash, hash_len, hash_type);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
 	kref = keyring_search(make_key_ref(blacklist_keyring, true),
 			      &key_type_blacklist, buffer, false);
 	if (!IS_ERR(kref)) {
@@ -164,7 +200,8 @@ EXPORT_SYMBOL_GPL(is_hash_blacklisted);
 
 int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 {
-	if (is_hash_blacklisted(hash, hash_len, "bin") == -EKEYREJECTED)
+	if (is_hash_blacklisted(hash, hash_len, BLACKLIST_HASH_BINARY) ==
+			-EKEYREJECTED)
 		return -EPERM;
 
 	return 0;
@@ -194,7 +231,7 @@ static int __init blacklist_init(void)
 		panic("Can't allocate system blacklist keyring\n");
 
 	for (bl = blacklist_hashes; *bl; bl++)
-		if (mark_hash_blacklisted(*bl) < 0)
+		if (mark_raw_hash_blacklisted(*bl) < 0)
 			pr_err("- blacklisting failed\n");
 	return 0;
 }
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index ae450eb8be14..3b7dba5e4cd9 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -81,7 +81,8 @@ int x509_get_sig_params(struct x509_certificate *cert)
 	if (ret < 0)
 		goto error_2;
 
-	ret = is_hash_blacklisted(sig->digest, sig->digest_size, "tbs");
+	ret = is_hash_blacklisted(sig->digest, sig->digest_size,
+				  BLACKLIST_HASH_X509_TBS);
 	if (ret == -EKEYREJECTED) {
 		pr_err("Cert %*phN is blacklisted\n",
 		       sig->digest_size, sig->digest);
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..b184d8743e23 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -10,6 +10,13 @@
 
 #include <linux/key.h>
 
+enum blacklist_hash_type {
+	/* TBSCertificate hash */
+	BLACKLIST_HASH_X509_TBS = 1,
+	/* Raw data hash */
+	BLACKLIST_HASH_BINARY = 2,
+};
+
 #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
 
 extern int restrict_link_by_builtin_trusted(struct key *keyring,
@@ -32,13 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #endif
 
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
-extern int mark_hash_blacklisted(const char *hash);
+extern int mark_hash_blacklisted(const u8 *hash, size_t hash_len,
+			       enum blacklist_hash_type hash_type);
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
-			       const char *type);
+			       enum blacklist_hash_type hash_type);
 extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
 #else
 static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
-				      const char *type)
+				      enum blacklist_hash_type hash_type)
 {
 	return 0;
 }
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index c5ba695c10e3..4a78fa1fde53 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -15,35 +15,13 @@ static efi_guid_t efi_cert_x509_sha256_guid __initdata =
 	EFI_CERT_X509_SHA256_GUID;
 static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
 
-/*
- * Blacklist a hash.
- */
-static __init void uefi_blacklist_hash(const char *source, const void *data,
-				       size_t len, const char *type,
-				       size_t type_len)
-{
-	char *hash, *p;
-
-	hash = kmalloc(type_len + len * 2 + 1, GFP_KERNEL);
-	if (!hash)
-		return;
-	p = memcpy(hash, type, type_len);
-	p += type_len;
-	bin2hex(p, data, len);
-	p += len * 2;
-	*p = 0;
-
-	mark_hash_blacklisted(hash);
-	kfree(hash);
-}
-
 /*
  * Blacklist an X509 TBS hash.
  */
 static __init void uefi_blacklist_x509_tbs(const char *source,
 					   const void *data, size_t len)
 {
-	uefi_blacklist_hash(source, data, len, "tbs:", 4);
+	mark_hash_blacklisted(data, len, BLACKLIST_HASH_X509_TBS);
 }
 
 /*
@@ -52,7 +30,7 @@ static __init void uefi_blacklist_x509_tbs(const char *source,
 static __init void uefi_blacklist_binary(const char *source,
 					 const void *data, size_t len)
 {
-	uefi_blacklist_hash(source, data, len, "bin:", 4);
+	mark_hash_blacklisted(data, len, BLACKLIST_HASH_BINARY);
 }
 
 /*
-- 
2.30.0

