Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD762152945
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Feb 2020 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgBEKfo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 Feb 2020 05:35:44 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2371 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbgBEKfo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Feb 2020 05:35:44 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5B65D9E37F969482C370;
        Wed,  5 Feb 2020 10:35:42 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 5 Feb 2020 10:35:34 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 6/8] ima: Allocate and initialize tfm for each PCR bank
Date:   Wed, 5 Feb 2020 11:33:15 +0100
Message-ID: <20200205103317.29356-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205103317.29356-1-roberto.sassu@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch creates a crypto_shash structure for each allocated PCR bank and
for SHA1 if a bank with that algorithm is not currently allocated.

Changelog

v1:
- determine ima_num_template_digests before allocating ima_algo_array
  (suggested by Mimi)
- replace kmalloc_array() with kcalloc() in ima_init_crypto() (suggested by
  Mimi)
- check tfm first in ima_alloc_tfm()
- check if ima_tpm_chip is NULL

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_crypto.c | 143 +++++++++++++++++++++++-----
 1 file changed, 118 insertions(+), 25 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 31f2497a3ab8..3101c343f963 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -59,10 +59,17 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
 static struct crypto_shash *ima_shash_tfm;
 static struct crypto_ahash *ima_ahash_tfm;
 
+struct ima_algo_desc {
+	struct crypto_shash *tfm;
+	enum hash_algo algo;
+};
+
 int ima_sha1_idx;
-int ima_num_template_digests = 1;
+int ima_num_template_digests;
 
-int __init ima_init_crypto(void)
+static struct ima_algo_desc *ima_algo_array;
+
+int __init ima_init_ima_crypto(void)
 {
 	long rc;
 
@@ -81,26 +88,120 @@ int __init ima_init_crypto(void)
 static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 {
 	struct crypto_shash *tfm = ima_shash_tfm;
-	int rc;
+	int rc, i;
 
 	if (algo < 0 || algo >= HASH_ALGO__LAST)
 		algo = ima_hash_algo;
 
-	if (algo != ima_hash_algo) {
-		tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);
-		if (IS_ERR(tfm)) {
-			rc = PTR_ERR(tfm);
-			pr_err("Can not allocate %s (reason: %d)\n",
-			       hash_algo_name[algo], rc);
-		}
+	if (algo == ima_hash_algo)
+		return tfm;
+
+	for (i = 0; i < ima_num_template_digests; i++)
+		if (ima_algo_array[i].tfm && ima_algo_array[i].algo == algo)
+			return ima_algo_array[i].tfm;
+
+	tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);
+	if (IS_ERR(tfm)) {
+		rc = PTR_ERR(tfm);
+		pr_err("Can not allocate %s (reason: %d)\n",
+		       hash_algo_name[algo], rc);
 	}
 	return tfm;
 }
 
+int __init ima_init_crypto(void)
+{
+	enum hash_algo algo;
+	long rc;
+	int i, nr_allocated_banks = 0;
+
+	rc = ima_init_ima_crypto();
+	if (rc)
+		return rc;
+
+	if (ima_tpm_chip)
+		nr_allocated_banks = ima_tpm_chip->nr_allocated_banks;
+
+	ima_sha1_idx = -1;
+	ima_num_template_digests = nr_allocated_banks;
+
+	for (i = 0; i < nr_allocated_banks; i++) {
+		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+		if (algo == HASH_ALGO_SHA1)
+			ima_sha1_idx = i;
+	}
+
+	if (ima_sha1_idx < 0)
+		ima_sha1_idx = ima_num_template_digests++;
+
+	ima_algo_array = kcalloc(ima_num_template_digests,
+				 sizeof(*ima_algo_array), GFP_KERNEL);
+	if (!ima_algo_array) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < nr_allocated_banks; i++) {
+		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+		ima_algo_array[i].algo = algo;
+
+		/* unknown TPM algorithm */
+		if (algo == HASH_ALGO__LAST)
+			continue;
+
+		if (algo == ima_hash_algo) {
+			ima_algo_array[i].tfm = ima_shash_tfm;
+			continue;
+		}
+
+		ima_algo_array[i].tfm = ima_alloc_tfm(algo);
+		if (IS_ERR(ima_algo_array[i].tfm)) {
+			if (algo == HASH_ALGO_SHA1) {
+				rc = PTR_ERR(ima_algo_array[i].tfm);
+				ima_algo_array[i].tfm = NULL;
+				goto out_array;
+			}
+
+			ima_algo_array[i].tfm = NULL;
+		}
+	}
+
+	if (ima_sha1_idx >= nr_allocated_banks) {
+		ima_algo_array[i].tfm = ima_alloc_tfm(HASH_ALGO_SHA1);
+		if (IS_ERR(ima_algo_array[i].tfm)) {
+			rc = PTR_ERR(ima_algo_array[i].tfm);
+			goto out_array;
+		}
+
+		ima_algo_array[i].algo = HASH_ALGO_SHA1;
+	}
+
+	return 0;
+out_array:
+	for (i = 0; i < ima_num_template_digests; i++) {
+		if (!ima_algo_array[i].tfm ||
+		    ima_algo_array[i].tfm == ima_shash_tfm)
+			continue;
+
+		crypto_free_shash(ima_algo_array[i].tfm);
+	}
+out:
+	crypto_free_shash(ima_shash_tfm);
+	return rc;
+}
+
 static void ima_free_tfm(struct crypto_shash *tfm)
 {
-	if (tfm != ima_shash_tfm)
-		crypto_free_shash(tfm);
+	int i;
+
+	if (tfm == ima_shash_tfm)
+		return;
+
+	for (i = 0; i < ima_num_template_digests; i++)
+		if (ima_algo_array[i].tfm == tfm)
+			return;
+
+	crypto_free_shash(tfm);
 }
 
 /**
@@ -468,14 +569,14 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
  */
 static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 					 struct ima_template_entry *entry,
-					 struct crypto_shash *tfm)
+					 int tfm_idx)
 {
-	SHASH_DESC_ON_STACK(shash, tfm);
+	SHASH_DESC_ON_STACK(shash, ima_algo_array[tfm_idx].tfm);
 	struct ima_template_desc *td = entry->template_desc;
 	int num_fields = entry->template_desc->num_fields;
 	int rc, i;
 
-	shash->tfm = tfm;
+	shash->tfm = ima_algo_array[tfm_idx].tfm;
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
@@ -506,7 +607,7 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 
 	if (!rc)
 		rc = crypto_shash_final(shash,
-					entry->digests[ima_sha1_idx].digest);
+					entry->digests[tfm_idx].digest);
 
 	return rc;
 }
@@ -514,17 +615,9 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry)
 {
-	struct crypto_shash *tfm;
 	int rc;
 
-	tfm = ima_alloc_tfm(HASH_ALGO_SHA1);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	rc = ima_calc_field_array_hash_tfm(field_data, entry, tfm);
-
-	ima_free_tfm(tfm);
-
+	rc = ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
 	return rc;
 }
 
-- 
2.17.1

