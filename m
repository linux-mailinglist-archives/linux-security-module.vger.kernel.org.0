Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C817C339465
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Mar 2021 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCLRNx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 12 Mar 2021 12:13:53 -0500
Received: from smtp-190d.mail.infomaniak.ch ([185.125.25.13]:50413 "EHLO
        smtp-190d.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhCLRNU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Mar 2021 12:13:20 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DxspN6DS9zMqPjw;
        Fri, 12 Mar 2021 18:13:16 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DxspN3yKfzlh8TB;
        Fri, 12 Mar 2021 18:13:16 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 3/5] certs: Make blacklist_vet_description() more strict
Date:   Fri, 12 Mar 2021 18:12:30 +0100
Message-Id: <20210312171232.2681989-4-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312171232.2681989-1-mic@digikod.net>
References: <20210312171232.2681989-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Before exposing this new key type to user space, make sure that only
meaningful blacklisted hashes are accepted.  This is also checked for
builtin blacklisted hashes, but a following commit make sure that the
user will notice (at built time) and will fix the configuration if it
already included errors.

Check that a blacklist key description starts with a valid prefix and
then a valid hexadecimal string.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20210312171232.2681989-4-mic@digikod.net
---

Changes since v5:
* Add Reviewed-by Jarkko.

Changes since v2:
* Fix typo in blacklist_vet_description() comment, spotted by Tyler
  Hicks.
* Add Jarkko's Acked-by.

Changes since v1:
* Return ENOPKG (instead of EINVAL) when a hash is greater than the
  maximum currently known hash (suggested by David Howells).
---
 certs/blacklist.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index c9a435b15af4..97a35cf9a62c 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -19,6 +19,16 @@
 #include "blacklist.h"
 #include "common.h"
 
+/*
+ * According to crypto/asymmetric_keys/x509_cert_parser.c:x509_note_pkey_algo(),
+ * the size of the currently longest supported hash algorithm is 512 bits,
+ * which translates into 128 hex characters.
+ */
+#define MAX_HASH_LEN	128
+
+static const char tbs_prefix[] = "tbs";
+static const char bin_prefix[] = "bin";
+
 static struct key *blacklist_keyring;
 
 #ifdef CONFIG_SYSTEM_REVOCATION_LIST
@@ -32,24 +42,40 @@ extern __initconst const unsigned long revocation_certificate_list_size;
  */
 static int blacklist_vet_description(const char *desc)
 {
-	int n = 0;
-
-	if (*desc == ':')
-		return -EINVAL;
-	for (; *desc; desc++)
-		if (*desc == ':')
-			goto found_colon;
+	int i, prefix_len, tbs_step = 0, bin_step = 0;
+
+	/* The following algorithm only works if prefix lengths match. */
+	BUILD_BUG_ON(sizeof(tbs_prefix) != sizeof(bin_prefix));
+	prefix_len = sizeof(tbs_prefix) - 1;
+	for (i = 0; *desc; desc++, i++) {
+		if (*desc == ':') {
+			if (tbs_step == prefix_len)
+				goto found_colon;
+			if (bin_step == prefix_len)
+				goto found_colon;
+			return -EINVAL;
+		}
+		if (i >= prefix_len)
+			return -EINVAL;
+		if (*desc == tbs_prefix[i])
+			tbs_step++;
+		if (*desc == bin_prefix[i])
+			bin_step++;
+	}
 	return -EINVAL;
 
 found_colon:
 	desc++;
-	for (; *desc; desc++) {
+	for (i = 0; *desc && i < MAX_HASH_LEN; desc++, i++) {
 		if (!isxdigit(*desc) || isupper(*desc))
 			return -EINVAL;
-		n++;
 	}
+	if (*desc)
+		/* The hash is greater than MAX_HASH_LEN. */
+		return -ENOPKG;
 
-	if (n == 0 || n & 1)
+	/* Checks for an even number of hexadecimal characters. */
+	if (i == 0 || i & 1)
 		return -EINVAL;
 	return 0;
 }
-- 
2.30.2

