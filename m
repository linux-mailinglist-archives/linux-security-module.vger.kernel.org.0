Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0506F33269F
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Mar 2021 14:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCINV1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 9 Mar 2021 08:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231140AbhCINU5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 08:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615296057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0v5d73hbP9IPd5Z+h3RwmKlsJS1Sk4x2R5yccH4ZMQY=;
        b=QXmKl7DAanyfD54hdN96xpeLmKKLLzVGEpKRsSmeSAKH7yibZGr/oocnq5v8BKHPOrLYhd
        i+79aFR532V2QLQAwrCBH+NXa818ATxM4c7JEPguebnLcmIbgyQ+2FkLCnmR435E09+3Tm
        HTlIgyaLNEqmqvL4QckkbgkKBDSS+jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-2OW-8Uf3OLmsXuZTF_z-Sw-1; Tue, 09 Mar 2021 08:20:54 -0500
X-MC-Unique: 2OW-8Uf3OLmsXuZTF_z-Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B2211084D6B;
        Tue,  9 Mar 2021 13:20:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D6D41ACBA;
        Tue,  9 Mar 2021 13:20:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 1/4] certs: Add EFI_CERT_X509_GUID support for dbx entries
From:   David Howells <dhowells@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Arnd Bergmann <arnd@kernel.org>, keyrings@vger.kernel.org,
        dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Mar 2021 13:20:50 +0000
Message-ID: <161529605075.163428.14625520893961300757.stgit@warthog.procyon.org.uk>
In-Reply-To: <161529604216.163428.4905283330048991183.stgit@warthog.procyon.org.uk>
References: <161529604216.163428.4905283330048991183.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Eric Snowberg <eric.snowberg@oracle.com>

This fixes CVE-2020-26541.

The Secure Boot Forbidden Signature Database, dbx, contains a list of now
revoked signatures and keys previously approved to boot with UEFI Secure
Boot enabled.  The dbx is capable of containing any number of
EFI_CERT_X509_SHA256_GUID, EFI_CERT_SHA256_GUID, and EFI_CERT_X509_GUID
entries.

Currently when EFI_CERT_X509_GUID are contained in the dbx, the entries are
skipped.

Add support for EFI_CERT_X509_GUID dbx entries. When a EFI_CERT_X509_GUID
is found, it is added as an asymmetrical key to the .blacklist keyring.
Anytime the .platform keyring is used, the keys in the .blacklist keyring
are referenced, if a matching key is found, the key will be rejected.

[DH: Made the following changes:
 - Added to have a config option to enable the facility.  This allows a
   Kconfig solution to make sure that pkcs7_validate_trust() is enabled.
 - Moved the functions out from the middle of the blacklist functions.
 - Added kerneldoc comments.]

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: Mickaël Salaün <mic@digikod.net>
cc: Arnd Bergmann <arnd@kernel.org>
cc: keyrings@vger.kernel.org
Link: https://lore.kernel.org/r/20200901165143.10295-1-eric.snowberg@oracle.com/
Link: https://lore.kernel.org/r/20200909172736.73003-1-eric.snowberg@oracle.com/ # v2
Link: https://lore.kernel.org/r/20200911182230.62266-1-eric.snowberg@oracle.com/ # v3
Link: https://lore.kernel.org/r/20200916004927.64276-1-eric.snowberg@oracle.com/ # v4
Link: https://lore.kernel.org/r/2660556.1610545213@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/20210122181054.32635-2-eric.snowberg@oracle.com/ # v5
Link: https://lore.kernel.org/r/bc2c24e3-ed68-2521-0bf4-a1f6be4a895d@infradead.org/
Link: https://lore.kernel.org/r/20210225125638.1841436-1-arnd@kernel.org/
Link: https://lore.kernel.org/r/161428672051.677100.11064981943343605138.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/161433310942.902181.4901864302675874242.stgit@warthog.procyon.org.uk/ # v2
---

 certs/Kconfig                                      |    9 ++++
 certs/blacklist.c                                  |   43 ++++++++++++++++++++
 certs/blacklist.h                                  |    2 +
 certs/system_keyring.c                             |    6 +++
 include/keys/system_keyring.h                      |   15 +++++++
 .../integrity/platform_certs/keyring_handler.c     |   11 +++++
 6 files changed, 86 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d8bccf..76e469b56a77 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -83,4 +83,13 @@ config SYSTEM_BLACKLIST_HASH_LIST
 	  wrapper to incorporate the list into the kernel.  Each <hash> should
 	  be a string of hex digits.
 
+config SYSTEM_REVOCATION_LIST
+	bool "Provide system-wide ring of revocation certificates"
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on PKCS7_MESSAGE_PARSER=y
+	help
+	  If set, this allows revocation certificates to be stored in the
+	  blacklist keyring and implements a hook whereby a PKCS#7 message can
+	  be checked to see if it matches such a certificate.
+
 endmenu
diff --git a/certs/blacklist.c b/certs/blacklist.c
index bffe4c6f4a9e..2b8644123d5f 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -145,6 +145,49 @@ int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 }
 EXPORT_SYMBOL_GPL(is_binary_blacklisted);
 
+#ifdef CONFIG_SYSTEM_REVOCATION_LIST
+/**
+ * add_key_to_revocation_list - Add a revocation certificate to the blacklist
+ * @data: The data blob containing the certificate
+ * @size: The size of data blob
+ */
+int add_key_to_revocation_list(const char *data, size_t size)
+{
+	key_ref_t key;
+
+	key = key_create_or_update(make_key_ref(blacklist_keyring, true),
+				   "asymmetric",
+				   NULL,
+				   data,
+				   size,
+				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW),
+				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN);
+
+	if (IS_ERR(key)) {
+		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
+		return PTR_ERR(key);
+	}
+
+	return 0;
+}
+
+/**
+ * is_key_on_revocation_list - Determine if the key for a PKCS#7 message is revoked
+ * @pkcs7: The PKCS#7 message to check
+ */
+int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
+{
+	int ret;
+
+	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
+
+	if (ret == 0)
+		return -EKEYREJECTED;
+
+	return -ENOKEY;
+}
+#endif
+
 /*
  * Initialise the blacklist
  */
diff --git a/certs/blacklist.h b/certs/blacklist.h
index 1efd6fa0dc60..51b320cf8574 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,5 @@
 #include <linux/kernel.h>
+#include <linux/errno.h>
+#include <crypto/pkcs7.h>
 
 extern const char __initconst *const blacklist_hashes[];
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 4b693da488f1..ed98754d5795 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -242,6 +242,12 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 			pr_devel("PKCS#7 platform keyring is not available\n");
 			goto error;
 		}
+
+		ret = is_key_on_revocation_list(pkcs7);
+		if (ret != -ENOKEY) {
+			pr_devel("PKCS#7 platform key is on revocation list\n");
+			goto error;
+		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..875e002a4180 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -31,6 +31,7 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
@@ -49,6 +50,20 @@ static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 }
 #endif
 
+#ifdef CONFIG_SYSTEM_REVOCATION_LIST
+extern int add_key_to_revocation_list(const char *data, size_t size);
+extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7);
+#else
+static inline int add_key_to_revocation_list(const char *data, size_t size)
+{
+	return 0;
+}
+static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
+{
+	return -ENOKEY;
+}
+#endif
+
 #ifdef CONFIG_IMA_BLACKLIST_KEYRING
 extern struct key *ima_blacklist_keyring;
 
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index c5ba695c10e3..5604bd57c990 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -55,6 +55,15 @@ static __init void uefi_blacklist_binary(const char *source,
 	uefi_blacklist_hash(source, data, len, "bin:", 4);
 }
 
+/*
+ * Add an X509 cert to the revocation list.
+ */
+static __init void uefi_revocation_list_x509(const char *source,
+					     const void *data, size_t len)
+{
+	add_key_to_revocation_list(data, len);
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI db and MokListRT tables.
@@ -76,5 +85,7 @@ __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type)
 		return uefi_blacklist_x509_tbs;
 	if (efi_guidcmp(*sig_type, efi_cert_sha256_guid) == 0)
 		return uefi_blacklist_binary;
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return uefi_revocation_list_x509;
 	return 0;
 }


