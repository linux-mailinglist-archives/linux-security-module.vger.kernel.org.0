Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C422D7F0E
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Dec 2020 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbgLKTEn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Dec 2020 14:04:43 -0500
Received: from smtp-8fae.mail.infomaniak.ch ([83.166.143.174]:49729 "EHLO
        smtp-8fae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390603AbgLKTEk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Dec 2020 14:04:40 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ct0Yw2lSLzlhMl7;
        Fri, 11 Dec 2020 20:03:48 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ct0Yw0ZPPzlppyl;
        Fri, 11 Dec 2020 20:03:48 +0100 (CET)
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
Subject: [PATCH v2 4/5] certs: Allow root user to append signed hashes to the blacklist keyring
Date:   Fri, 11 Dec 2020 20:03:29 +0100
Message-Id: <20201211190330.2586116-5-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211190330.2586116-1-mic@digikod.net>
References: <20201211190330.2586116-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
to dynamically add new keys to the blacklist keyring.  This enables to
invalidate new certificates, either from being loaded in a keyring, or
from being trusted in a PKCS#7 certificate chain.  This also enables to
add new file hashes to be denied by the integrity infrastructure.

Being able to untrust a certificate which could have normaly been
trusted is a sensitive operation.  This is why adding new hashes to the
blacklist keyring is only allowed when these hashes are signed and
vouched by the builtin trusted keyring.  A blacklist hash is stored as a
key description.  The PKCS#7 signature of this description must be
provided as the key payload.

Marking a certificate as untrusted should be enforced while the system
is running.  It is then forbiden to remove such blacklist keys.

Update blacklist keyring and blacklist key access rights:
* allows the root user to search for a specific blacklisted hash, which
  make sense because the descriptions are already viewable;
* forbids key update;
* restricts kernel rights on the blacklist keyring to align with the
  root user rights.

See the help in tools/certs/print-cert-tbs-hash.sh provided by a
following commit.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---
 certs/Kconfig     | 10 ++++++
 certs/blacklist.c | 85 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d8bccf..35fe9989e7b9 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -83,4 +83,14 @@ config SYSTEM_BLACKLIST_HASH_LIST
 	  wrapper to incorporate the list into the kernel.  Each <hash> should
 	  be a string of hex digits.
 
+config SYSTEM_BLACKLIST_AUTH_UPDATE
+	bool "Allow root to add signed blacklist keys"
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on SYSTEM_DATA_VERIFICATION
+	help
+	  If set, provide the ability to load new blacklist keys at run time if
+	  they are signed and vouched by a certificate from the builtin trusted
+	  keyring.  The PKCS#7 signature of the description is set in the key
+	  payload.  Blacklist keys cannot be removed.
+
 endmenu
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 18653c1db6bd..111d3bcea1e4 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/uidgid.h>
+#include <linux/verification.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
 
@@ -25,6 +26,9 @@
  */
 #define MAX_HASH_LEN	128
 
+#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
+			    KEY_USR_SEARCH | KEY_USR_VIEW)
+
 static const char tbs_prefix[] = "tbs";
 static const char bin_prefix[] = "bin";
 
@@ -74,19 +78,46 @@ static int blacklist_vet_description(const char *desc)
 	return 0;
 }
 
-/*
- * The hash to be blacklisted is expected to be in the description.  There will
- * be no payload.
- */
-static int blacklist_preparse(struct key_preparsed_payload *prep)
+static int blacklist_key_instantiate(struct key *key,
+		struct key_preparsed_payload *prep)
 {
-	if (prep->datalen > 0)
-		return -EINVAL;
-	return 0;
+#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
+	int err;
+#endif
+
+	/* Sets safe default permissions for keys loaded by user space. */
+	key->perm = BLACKLIST_KEY_PERM;
+
+	/*
+	 * Skips the authentication step for builtin hashes, they are not
+	 * signed but still trusted.
+	 */
+	if (key->flags & (1 << KEY_FLAG_BUILTIN))
+		goto out;
+
+#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
+	/*
+	 * Verifies the description's PKCS#7 signature against the builtin
+	 * trusted keyring.
+	 */
+	err = verify_pkcs7_signature(key->description,
+			strlen(key->description), prep->data, prep->datalen,
+			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
+	if (err)
+		return err;
+#else
+	WARN_ON_ONCE(1);
+	return -EPERM;
+#endif
+
+out:
+	return generic_key_instantiate(key, prep);
 }
 
-static void blacklist_free_preparse(struct key_preparsed_payload *prep)
+static int blacklist_key_update(struct key *key,
+		struct key_preparsed_payload *prep)
 {
+	return -EPERM;
 }
 
 static void blacklist_describe(const struct key *key, struct seq_file *m)
@@ -97,9 +128,8 @@ static void blacklist_describe(const struct key *key, struct seq_file *m)
 static struct key_type key_type_blacklist = {
 	.name			= "blacklist",
 	.vet_description	= blacklist_vet_description,
-	.preparse		= blacklist_preparse,
-	.free_preparse		= blacklist_free_preparse,
-	.instantiate		= generic_key_instantiate,
+	.instantiate		= blacklist_key_instantiate,
+	.update			= blacklist_key_update,
 	.describe		= blacklist_describe,
 };
 
@@ -148,8 +178,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
 				   hash,
 				   NULL,
 				   0,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW),
+				   BLACKLIST_KEY_PERM,
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
@@ -208,25 +237,43 @@ int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 }
 EXPORT_SYMBOL_GPL(is_binary_blacklisted);
 
+static int restrict_link_for_blacklist(struct key *dest_keyring,
+		const struct key_type *type, const union key_payload *payload,
+		struct key *restrict_key)
+{
+	if (type != &key_type_blacklist)
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Initialise the blacklist
  */
 static int __init blacklist_init(void)
 {
 	const char *const *bl;
+	struct key_restriction *restriction;
 
 	if (register_key_type(&key_type_blacklist) < 0)
 		panic("Can't allocate system blacklist key type\n");
 
+	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
+	if (!restriction)
+		panic("Can't allocate blacklist keyring restriction\n");
+	restriction->check = restrict_link_for_blacklist;
+
 	blacklist_keyring =
 		keyring_alloc(".blacklist",
 			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
-			      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			      KEY_USR_VIEW | KEY_USR_READ |
-			      KEY_USR_SEARCH,
-			      KEY_ALLOC_NOT_IN_QUOTA |
+			      KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
+			      KEY_POS_WRITE |
+			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH
+#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
+			      | KEY_USR_WRITE
+#endif
+			      , KEY_ALLOC_NOT_IN_QUOTA |
 			      KEY_ALLOC_SET_KEEP,
-			      NULL, NULL);
+			      restriction, NULL);
 	if (IS_ERR(blacklist_keyring))
 		panic("Can't allocate system blacklist keyring\n");
 
-- 
2.29.2

