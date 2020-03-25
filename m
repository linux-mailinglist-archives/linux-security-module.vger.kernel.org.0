Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6719262B
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Mar 2020 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYKty (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Mar 2020 06:49:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2591 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgCYKty (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 06:49:54 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 67A1A494717F79CB74E9;
        Wed, 25 Mar 2020 10:49:52 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 10:49:43 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 4/7] ima: Switch to dynamically allocated buffer for template digests
Date:   Wed, 25 Mar 2020 11:47:09 +0100
Message-ID: <20200325104712.25694-5-roberto.sassu@huawei.com>
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

This patch dynamically allocates the array of tpm_digest structures in
ima_alloc_init_template() and ima_restore_template_data(). The size of the
array is equal to the number of PCR banks plus ima_extra_slots, to make
room for SHA1 and the IMA default hash algorithm, when PCR banks with those
algorithms are not allocated.

Calculating the SHA1 digest is mandatory, as SHA1 still remains the default
hash algorithm for the measurement list. When IMA will support the Crypto
Agile format, remaining digests will be also provided.

The position in the measurement entry array of the SHA1 digest is stored in
the ima_sha1_idx global variable and is determined at IMA initialization
time.

Changelog

v3:
- improve comment for ima_extra_slots (suggested by Mimi)
- declare local variable digests in ima_alloc_init_template() and
  ima_restore_template_data() (suggested by Mimi)

v2:
- add NR_BANKS macro to return zero if ima_tpm_chip is NULL
- replace ima_num_template_digests with
  NR_BANKS(ima_tpm_chip) + ima_extra_slots (suggested by Mimi)
- add __ro_after_init to declaration of ima_sha1_idx and ima_extra_slots
  (suggested by Mimi)

v1:
- move ima_sha1_idx to ima_crypto.c
- introduce ima_num_template_digests (suggested by Mimi)

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  6 +++++-
 security/integrity/ima/ima_api.c      | 10 ++++++++++
 security/integrity/ima/ima_crypto.c   | 10 +++++++++-
 security/integrity/ima/ima_fs.c       |  4 ++--
 security/integrity/ima/ima_queue.c    | 10 ++++++----
 security/integrity/ima/ima_template.c | 15 +++++++++++++--
 6 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a2dfe24e04c7..2a7ed68e6414 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -45,11 +45,15 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 #define IMA_TEMPLATE_IMA_NAME "ima"
 #define IMA_TEMPLATE_IMA_FMT "d|n"
 
+#define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
 /* set during initialization */
 extern int ima_hash_algo;
+extern int ima_sha1_idx __ro_after_init;
+extern int ima_extra_slots __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 
@@ -92,7 +96,7 @@ struct ima_template_desc {
 
 struct ima_template_entry {
 	int pcr;
-	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
+	struct tpm_digest *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
 	struct ima_field_data template_data[0];	/* template related data */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 2ef5a40c7ca5..78e0b0a7723e 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -27,6 +27,7 @@ void ima_free_template_entry(struct ima_template_entry *entry)
 	for (i = 0; i < entry->template_desc->num_fields; i++)
 		kfree(entry->template_data[i].data);
 
+	kfree(entry->digests);
 	kfree(entry);
 }
 
@@ -38,6 +39,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_desc *desc)
 {
 	struct ima_template_desc *template_desc;
+	struct tpm_digest *digests;
 	int i, result = 0;
 
 	if (desc)
@@ -50,6 +52,14 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	if (!*entry)
 		return -ENOMEM;
 
+	digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+			  sizeof(*digests), GFP_NOFS);
+	if (!digests) {
+		result = -ENOMEM;
+		goto out;
+	}
+
+	(*entry)->digests = digests;
 	(*entry)->template_desc = template_desc;
 	for (i = 0; i < template_desc->num_fields; i++) {
 		const struct ima_template_field *field =
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 03d73a4009ab..fe02eb28b32b 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -57,6 +57,13 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
 static struct crypto_shash *ima_shash_tfm;
 static struct crypto_ahash *ima_ahash_tfm;
 
+int ima_sha1_idx __ro_after_init;
+/*
+ * Additional number of slots reserved, as needed, for SHA1
+ * and IMA default algo.
+ */
+int ima_extra_slots __ro_after_init = 1;
+
 int __init ima_init_crypto(void)
 {
 	long rc;
@@ -502,7 +509,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 	}
 
 	if (!rc)
-		rc = crypto_shash_final(shash, entry->digest);
+		rc = crypto_shash_final(shash,
+					entry->digests[ima_sha1_idx].digest);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a71e822a6e92..8b030a1c5e0d 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -150,7 +150,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -233,7 +233,7 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	seq_printf(m, "%2d ", e->pcr);
 
 	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digest, TPM_DIGEST_SIZE);
+	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 8753212ddb18..49db71c200b4 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -55,7 +55,8 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
-		rc = memcmp(qe->entry->digest, digest_value, TPM_DIGEST_SIZE);
+		rc = memcmp(qe->entry->digests[ima_sha1_idx].digest,
+			    digest_value, TPM_DIGEST_SIZE);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
 			ret = qe;
 			break;
@@ -75,7 +76,7 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
 	int size = 0;
 
 	size += sizeof(u32);	/* pcr */
-	size += sizeof(entry->digest);
+	size += TPM_DIGEST_SIZE;
 	size += sizeof(int);	/* template name size field */
 	size += strlen(entry->template_desc->name);
 	size += sizeof(entry->template_data_len);
@@ -107,7 +108,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 
 	atomic_long_inc(&ima_htable.len);
 	if (update_htable) {
-		key = ima_hash_key(entry->digest);
+		key = ima_hash_key(entry->digests[ima_sha1_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
 	}
 
@@ -171,7 +172,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 
 	mutex_lock(&ima_extend_list_mutex);
 	if (!violation) {
-		memcpy(digest, entry->digest, sizeof(digest));
+		memcpy(digest, entry->digests[ima_sha1_idx].digest,
+		       sizeof(digest));
 		if (ima_lookup_digest_entry(digest, entry->pcr)) {
 			audit_cause = "hash_exists";
 			result = -EEXIST;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 062d9ad49afb..de84252e65e9 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -301,6 +301,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 				     int template_data_size,
 				     struct ima_template_entry **entry)
 {
+	struct tpm_digest *digests;
 	int ret = 0;
 	int i;
 
@@ -309,11 +310,21 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	if (!*entry)
 		return -ENOMEM;
 
+	digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+			  sizeof(*digests), GFP_NOFS);
+	if (!digests) {
+		kfree(*entry);
+		return -ENOMEM;
+	}
+
+	(*entry)->digests = digests;
+
 	ret = ima_parse_buf(template_data, template_data + template_data_size,
 			    NULL, template_desc->num_fields,
 			    (*entry)->template_data, NULL, NULL,
 			    ENFORCE_FIELDS | ENFORCE_BUFEND, "template data");
 	if (ret < 0) {
+		kfree((*entry)->digests);
 		kfree(*entry);
 		return ret;
 	}
@@ -445,8 +456,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		if (ret < 0)
 			break;
 
-		memcpy(entry->digest, hdr[HDR_DIGEST].data,
-		       hdr[HDR_DIGEST].len);
+		memcpy(entry->digests[ima_sha1_idx].digest,
+		       hdr[HDR_DIGEST].data, hdr[HDR_DIGEST].len);
 		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
-- 
2.17.1

