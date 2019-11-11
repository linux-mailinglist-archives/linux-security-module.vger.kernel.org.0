Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB45F8009
	for <lists+linux-security-module@lfdr.de>; Mon, 11 Nov 2019 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKKTdT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 11 Nov 2019 14:33:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44852 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfKKTdK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id D27BF20B4907;
        Mon, 11 Nov 2019 11:33:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D27BF20B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500789;
        bh=OgU4RosYDDili/HfJXIWfaINwd/GWDYvrkC5K+otw4Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cTNKNJhTeUXNjcjVGnZR/7EC273kOm68YCZvSbJmNSbAjeOCar8Or2XFhHLBVCdLV
         exDFMLjazMfDsJ2PUNOGwaIwjlg7dpIB0+20PIf6jamCsLTXpvqyzSHgWNEO4XxU23
         qYQuHvl1QjFxF0rQkGXdE7aj+0ymzszd0D6fMR00=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/10] KEYS: Call the IMA hook to measure key when a new key is created or an existing key is updated
Date:   Mon, 11 Nov 2019 11:33:00 -0800
Message-Id: <20191111193303.12781-8-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

key_create_or_update function needs to call the IMA hook to measure
the key when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update
function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h | 13 +++++++++++++
 security/keys/key.c |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..ec5afe319ab7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -25,6 +25,12 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  unsigned long flags, bool create);
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -101,6 +107,13 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
+#ifndef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 unsigned long flags,
+						 bool create) {}
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..9782d4d046fd 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
+#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the ima module know about the created key. */
+	ima_post_key_create_or_update(keyring, key, flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+
+	/* let the ima module know about the updated key. */
+	if (!IS_ERR(key_ref))
+		ima_post_key_create_or_update(keyring, key, flags, false);
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1

