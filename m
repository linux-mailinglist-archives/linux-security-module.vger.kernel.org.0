Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77084192647
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Mar 2020 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYKzj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Mar 2020 06:55:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgCYKzj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 06:55:39 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E65CBD8BB181EA3BD277;
        Wed, 25 Mar 2020 10:55:36 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 10:55:27 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 6/7] ima: Calculate and extend PCR with digests in ima_template_entry
Date:   Wed, 25 Mar 2020 11:53:50 +0100
Message-ID: <20200325105350.26534-1-roberto.sassu@huawei.com>
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

This patch modifies ima_calc_field_array_hash() to calculate a template
digest for each allocated PCR bank and SHA1. It also passes the tpm_digest
array of the template entry to ima_pcr_extend() or in case of a violation,
the pre-initialized digests array filled with 0xff.

Padding with zeros is still done if the mapping between TPM algorithm ID
and crypto ID is unknown.

This patch calculates again the template digest when a measurement list is
restored. Copying only the SHA1 digest (due to the limitation of the
current measurement list format) is not sufficient, as hash collision
detection will be done on the digest calculated with the IMA default hash
algorithm.

Changelog
v2:
- replace ima_num_template_digests with
  NR_BANKS(ima_tpm_chip) + ima_extra_slots (suggested by Mimi)

v1:
- replace ima_tpm_chip->nr_allocated_banks with ima_num_template_digests
  (suggested by Mimi)
- retrieve alg_id only if i < ima_tpm_chip->nr_allocated_banks
- check if ima_tpm_chip is NULL

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_crypto.c   | 29 +++++++++++++++++++++++++-
 security/integrity/ima/ima_queue.c    | 30 ++++++++++++++++-----------
 security/integrity/ima/ima_template.c | 14 +++++++++++--
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index ab1c05ad1314..a94972d3f929 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -619,9 +619,36 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry)
 {
-	int rc;
+	u16 alg_id;
+	int rc, i;
 
 	rc = ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
+	if (rc)
+		return rc;
+
+	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
+
+	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+		if (i == ima_sha1_idx)
+			continue;
+
+		if (i < NR_BANKS(ima_tpm_chip)) {
+			alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
+			entry->digests[i].alg_id = alg_id;
+		}
+
+		/* for unmapped TPM algorithms digest is still a padded SHA1 */
+		if (!ima_algo_array[i].tfm) {
+			memcpy(entry->digests[i].digest,
+			       entry->digests[ima_sha1_idx].digest,
+			       TPM_DIGEST_SIZE);
+			continue;
+		}
+
+		rc = ima_calc_field_array_hash_tfm(field_data, entry, i);
+		if (rc)
+			return rc;
+	}
 	return rc;
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 49db71c200b4..82a9ca43b989 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -135,18 +135,14 @@ unsigned long ima_get_binary_runtime_size(void)
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
 };
 
-static int ima_pcr_extend(const u8 *hash, int pcr)
+static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result = 0;
-	int i;
 
 	if (!ima_tpm_chip)
 		return result;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
-		memcpy(digests[i].digest, hash, TPM_DIGEST_SIZE);
-
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests);
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
@@ -164,7 +160,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename)
 {
-	u8 digest[TPM_DIGEST_SIZE];
+	u8 *digest = entry->digests[ima_sha1_idx].digest;
+	struct tpm_digest *digests_arg = entry->digests;
 	const char *audit_cause = "hash_added";
 	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
 	int audit_info = 1;
@@ -172,8 +169,6 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 
 	mutex_lock(&ima_extend_list_mutex);
 	if (!violation) {
-		memcpy(digest, entry->digests[ima_sha1_idx].digest,
-		       sizeof(digest));
 		if (ima_lookup_digest_entry(digest, entry->pcr)) {
 			audit_cause = "hash_exists";
 			result = -EEXIST;
@@ -189,9 +184,9 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	}
 
 	if (violation)		/* invalidate pcr */
-		memset(digest, 0xff, sizeof(digest));
+		digests_arg = digests;
 
-	tpmresult = ima_pcr_extend(digest, entry->pcr);
+	tpmresult = ima_pcr_extend(digests_arg, entry->pcr);
 	if (tpmresult != 0) {
 		snprintf(tpm_audit_cause, AUDIT_CAUSE_LEN_MAX, "TPM_error(%d)",
 			 tpmresult);
@@ -217,6 +212,8 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 
 int __init ima_init_digests(void)
 {
+	u16 digest_size;
+	u16 crypto_id;
 	int i;
 
 	if (!ima_tpm_chip)
@@ -227,8 +224,17 @@ int __init ima_init_digests(void)
 	if (!digests)
 		return -ENOMEM;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
+		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
+		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
+
+		/* for unmapped TPM algorithms digest is still a padded SHA1 */
+		if (crypto_id == HASH_ALGO__LAST)
+			digest_size = SHA1_DIGEST_SIZE;
+
+		memset(digests[i].digest, 0xff, digest_size);
+	}
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index de84252e65e9..5a2def40a733 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -357,6 +357,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 int ima_restore_measurement_list(loff_t size, void *buf)
 {
 	char template_name[MAX_TEMPLATE_NAME_LEN];
+	unsigned char zero[TPM_DIGEST_SIZE] = { 0 };
 
 	struct ima_kexec_hdr *khdr = buf;
 	struct ima_field_data hdr[HDR__LAST] = {
@@ -456,8 +457,17 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		if (ret < 0)
 			break;
 
-		memcpy(entry->digests[ima_sha1_idx].digest,
-		       hdr[HDR_DIGEST].data, hdr[HDR_DIGEST].len);
+		if (memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero))) {
+			ret = ima_calc_field_array_hash(
+						&entry->template_data[0],
+						entry);
+			if (ret < 0) {
+				pr_err("cannot calculate template digest\n");
+				ret = -EINVAL;
+				break;
+			}
+		}
+
 		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
-- 
2.17.1

