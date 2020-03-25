Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D3192627
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Mar 2020 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCYKto (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Mar 2020 06:49:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgCYKtn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 06:49:43 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4567F91104790E47CE1C;
        Wed, 25 Mar 2020 10:49:42 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 10:49:33 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 3/7] ima: Store template digest directly in ima_template_entry
Date:   Wed, 25 Mar 2020 11:47:08 +0100
Message-ID: <20200325104712.25694-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325104712.25694-1-roberto.sassu@huawei.com>
References: <20200325104712.25694-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In preparation for the patch that calculates a digest for each allocated
PCR bank, this patch passes to ima_calc_field_array_hash() the
ima_template_entry structure, so that digests can be directly stored in
that structure instead of ima_digest_data.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  3 +--
 security/integrity/ima/ima_api.c    | 12 +-----------
 security/integrity/ima/ima_crypto.c | 18 +++++++-----------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64317d95363e..a2dfe24e04c7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -138,8 +138,7 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
 int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
-			      struct ima_template_desc *desc, int num_fields,
-			      struct ima_digest_data *hash);
+			      struct ima_template_entry *entry);
 int __init ima_calc_boot_aggregate(struct ima_digest_data *hash);
 void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f6bc00914aa5..2ef5a40c7ca5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -96,26 +96,16 @@ int ima_store_template(struct ima_template_entry *entry,
 	static const char audit_cause[] = "hashing_error";
 	char *template_name = entry->template_desc->name;
 	int result;
-	struct {
-		struct ima_digest_data hdr;
-		char digest[TPM_DIGEST_SIZE];
-	} hash;
 
 	if (!violation) {
-		int num_fields = entry->template_desc->num_fields;
-
-		/* this function uses default algo */
-		hash.hdr.algo = HASH_ALGO_SHA1;
 		result = ima_calc_field_array_hash(&entry->template_data[0],
-						   entry->template_desc,
-						   num_fields, &hash.hdr);
+						   entry);
 		if (result < 0) {
 			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
 					    template_name, op,
 					    audit_cause, result, 0);
 			return result;
 		}
-		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
 	}
 	entry->pcr = pcr;
 	result = ima_add_template_entry(entry, violation, op, inode, filename);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 8e445a671225..03d73a4009ab 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -464,18 +464,16 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
  * Calculate the hash of template data
  */
 static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
-					 struct ima_template_desc *td,
-					 int num_fields,
-					 struct ima_digest_data *hash,
+					 struct ima_template_entry *entry,
 					 struct crypto_shash *tfm)
 {
 	SHASH_DESC_ON_STACK(shash, tfm);
+	struct ima_template_desc *td = entry->template_desc;
+	int num_fields = entry->template_desc->num_fields;
 	int rc, i;
 
 	shash->tfm = tfm;
 
-	hash->length = crypto_shash_digestsize(tfm);
-
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
 		return rc;
@@ -504,24 +502,22 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 	}
 
 	if (!rc)
-		rc = crypto_shash_final(shash, hash->digest);
+		rc = crypto_shash_final(shash, entry->digest);
 
 	return rc;
 }
 
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
-			      struct ima_template_desc *desc, int num_fields,
-			      struct ima_digest_data *hash)
+			      struct ima_template_entry *entry)
 {
 	struct crypto_shash *tfm;
 	int rc;
 
-	tfm = ima_alloc_tfm(hash->algo);
+	tfm = ima_alloc_tfm(HASH_ALGO_SHA1);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	rc = ima_calc_field_array_hash_tfm(field_data, desc, num_fields,
-					   hash, tfm);
+	rc = ima_calc_field_array_hash_tfm(field_data, entry, tfm);
 
 	ima_free_tfm(tfm);
 
-- 
2.17.1

