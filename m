Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97631266832
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Sep 2020 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIKSXW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Sep 2020 14:23:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50448 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKSXS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Sep 2020 14:23:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BIEiAM045415;
        Fri, 11 Sep 2020 18:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=3S1LDGLJaTqbdvySV2cTAYdJo5YXwcqyQi6kW67a7DE=;
 b=CYiWmeOGdV8dH6jV4AMQJ3SdmOSa/0rNJ+6dkScfiBAn5j7F+zqZ32EQANA7xNWY0L4u
 nLxoE9DQMhhbGxcknHFCvz5JvWb2lM7a5jXC4M1kfIBH6aSptmUPUfiGKdMuEN7SsBds
 a0Xvk0alG6RhRwgkUfk10Rhfm0V5OkWehrxoJ7guG//hyvmra0+ebevPkOm3FcuIM/jJ
 MZI7/2R+h95oJu/j435UpbUTxOJdr7CzHslHCgRqmms+hRWXk5m9zqLXWOp7oeNzmFWj
 cE9z9kmW3IMG4qCYsL7h0hd4GDkbFW5AtAixovebr4t1++Ez/bQCCQPntfBImc6X8mlL Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mmfsj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 18:22:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BIFCAI191067;
        Fri, 11 Sep 2020 18:22:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33cmkdpkf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 18:22:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08BIMjor025328;
        Fri, 11 Sep 2020 18:22:45 GMT
Received: from localhost.us.oracle.com (/10.147.27.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 11:22:45 -0700
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        jarkko.sakkinen@linux.intel.com
Cc:     jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        erichte@linux.ibm.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        eric.snowberg@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH v3] certs: Add EFI_CERT_X509_GUID support for dbx entries
Date:   Fri, 11 Sep 2020 14:22:30 -0400
Message-Id: <20200911182230.62266-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110147
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

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

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3:
Fixed an issue when CONFIG_PKCS7_MESSAGE_PARSER is not builtin and defined
as a module instead, pointed out by Randy Dunlap

v2: 
Fixed build issue reported by kernel test robot <lkp@intel.com>
Commit message update (suggested by Jarkko Sakkinen)
---
 certs/blacklist.c                             | 33 +++++++++++++++++++
 certs/blacklist.h                             | 12 +++++++
 certs/system_keyring.c                        |  6 ++++
 include/keys/system_keyring.h                 | 11 +++++++
 .../platform_certs/keyring_handler.c          | 11 +++++++
 5 files changed, 73 insertions(+)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6514f9ebc943..3d1514ba5d47 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -100,6 +100,39 @@ int mark_hash_blacklisted(const char *hash)
 	return 0;
 }
 
+int mark_key_revocationlisted(const char *data, size_t size)
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
+int is_key_revocationlisted(struct pkcs7_message *pkcs7)
+{
+	int ret;
+
+	ret = validate_trust(pkcs7, blacklist_keyring);
+
+	if (ret == 0)
+		return -EKEYREJECTED;
+
+	return -ENOKEY;
+}
+EXPORT_SYMBOL_GPL(is_key_revocationlisted);
+
 /**
  * is_hash_blacklisted - Determine if a hash is blacklisted
  * @hash: The hash to be checked as a binary blob
diff --git a/certs/blacklist.h b/certs/blacklist.h
index 1efd6fa0dc60..420bb7c86e07 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,15 @@
 #include <linux/kernel.h>
+#include <linux/errno.h>
+#include <crypto/pkcs7.h>
 
 extern const char __initconst *const blacklist_hashes[];
+
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+#define validate_trust pkcs7_validate_trust
+#else
+static inline int validate_trust(struct pkcs7_message *pkcs7,
+				 struct key *trust_keyring)
+{
+	return -ENOKEY;
+}
+#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..f8ea96219155 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -241,6 +241,12 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 			pr_devel("PKCS#7 platform keyring is not available\n");
 			goto error;
 		}
+
+		ret = is_key_revocationlisted(pkcs7);
+		if (ret != -ENOKEY) {
+			pr_devel("PKCS#7 platform key revocationlisted\n");
+			goto error;
+		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..b6991cfe1b6d 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -31,11 +31,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
+extern int mark_key_revocationlisted(const char *data, size_t size);
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 			       const char *type);
 extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
+extern int is_key_revocationlisted(struct pkcs7_message *pkcs7);
 #else
 static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 				      const char *type)
@@ -47,6 +50,14 @@ static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 {
 	return 0;
 }
+static inline int mark_key_revocationlisted(const char *data, size_t size)
+{
+	return 0;
+}
+static inline int is_key_revocationlisted(struct pkcs7_message *pkcs7)
+{
+	return -ENOKEY;
+}
 #endif
 
 #ifdef CONFIG_IMA_BLACKLIST_KEYRING
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index c5ba695c10e3..cc5a43804bc4 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -55,6 +55,15 @@ static __init void uefi_blacklist_binary(const char *source,
 	uefi_blacklist_hash(source, data, len, "bin:", 4);
 }
 
+/*
+ * Revocationlist the X509 cert
+ */
+static __init void uefi_revocationlist_x509(const char *source,
+					    const void *data, size_t len)
+{
+	mark_key_revocationlisted(data, len);
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
+		return uefi_revocationlist_x509;
 	return 0;
 }
-- 
2.18.1

