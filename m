Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B805BCAC
	for <lists+linux-security-module@lfdr.de>; Mon,  1 Jul 2019 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGANPO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Jul 2019 09:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGANPO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Jul 2019 09:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDC53AD78;
        Mon,  1 Jul 2019 13:15:10 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH] Revert "tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()"
Date:   Mon,  1 Jul 2019 15:15:05 +0200
Message-Id: <20190701131505.17759-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid following crash:

    BUG: Kernel NULL pointer dereference at 0x00000012
    Faulting instruction address: 0xc000000000897908
    Oops: Kernel access of bad area, sig: 11 [#1]
    LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc6-2.gf99f70b-default #1 openSUSE Tumbleweed (unreleased)
    NIP:  c000000000897908 LR: c000000000897860 CTR: 0000000000000009
    REGS: c000000004eb7550 TRAP: 0380   Not tainted  (5.2.0-rc6-2.gf99f70b-default)
    MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 88000224  XER: 20040001
    CFAR: c000000000c4e964 IRQMASK: 0
    GPR00: c000000000897860 c000000004eb77e0 c0000000015ced00 0000000000000000
    GPR04: 0000000000000003 0000000000000001 0000000022000000 000000000000000e
    GPR08: c0000005b46b0000 0000000000010000 0000000000000022 0000000010325476
    GPR12: 0000000048000222 c0000000019a0000 c000000000010b70 0000000000000000
    GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
    GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
    GPR24: c000000000eded00 c0000000014ecb60 c000000000ccedf8 c0000005b5c9d000
    GPR28: 000000000000000a 0000000000000012 c000000000f01180 c00c0000016d1ac0
    NIP [c000000000897908] tpm1_pcr_extend+0x118/0x1d0
    LR [c000000000897860] tpm1_pcr_extend+0x70/0x1d0
    Call Trace:
    [c000000004eb77e0] [c000000000897860] tpm1_pcr_extend+0x70/0x1d0 (unreliable)
    [c000000004eb7890] [c0000000008964e4] tpm_pcr_extend+0xe4/0x170
    [c000000004eb78d0] [c000000000667bac] ima_add_template_entry+0x1ac/0x350
    [c000000004eb79b0] [c00000000066ad04] ima_store_template+0xc4/0x150
    [c000000004eb7a30] [c000000001021a4c] ima_add_boot_aggregate+0xec/0x17c
    [c000000004eb7b30] [c000000001021b70] ima_init+0x94/0xbc
    [c000000004eb7b90] [c000000001021ce0] init_ima+0x44/0xec
    [c000000004eb7c10] [c000000000010694] do_one_initcall+0x64/0x2b0
    [c000000004eb7ce0] [c000000000fd445c] kernel_init_freeable+0x2e4/0x3cc
    [c000000004eb7db0] [c000000000010b94] kernel_init+0x2c/0x148
    [c000000004eb7e20] [c00000000000bc54] ret_from_kernel_thread+0x5c/0x68
    Instruction dump:
    90c80002 81410070 714a0001 e9010078 39480002 7d40542c 79470020 4082003c
    394a0014 7c0a4840 41810090 5546c03e <e87d0000> e89d0008 80bd0010 7d283a14
    ---[ end trace 786ebab24be797a3 ]---
---
 drivers/char/tpm/tpm-interface.c   | 30 +++++++++++++--------
 drivers/char/tpm/tpm.h             |  2 +-
 drivers/char/tpm/tpm2-cmd.c        | 10 ++++---
 include/linux/tpm.h                |  5 ++--
 security/integrity/ima/ima.h       |  1 -
 security/integrity/ima/ima_init.c  |  4 ---
 security/integrity/ima/ima_queue.c | 27 +------------------
 security/keys/trusted.c            | 42 ++++++------------------------
 8 files changed, 38 insertions(+), 83 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..dda742184ce2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -303,34 +303,42 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
  * tpm_pcr_extend - extend a PCR value in SHA1 bank.
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  * @pcr_idx:	the PCR to be retrieved
- * @digests:	array of tpm_digest structures used to extend PCRs
+ * @hash:	the hash value used to extend the PCR value
  *
- * Note: callers must pass a digest for every allocated PCR bank, in the same
- * order of the banks in chip->allocated_banks.
+ * Note: with TPM 2.0 extends also those banks for which no digest was
+ * specified in order to prevent malicious use of those PCR banks.
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-		   struct tpm_digest *digests)
+int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
+	struct tpm_digest *digest_list;
 	int i;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	for (i = 0; i < chip->nr_allocated_banks; i++)
-		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
-			return -EINVAL;
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
+		digest_list = kcalloc(chip->nr_allocated_banks,
+				      sizeof(*digest_list), GFP_KERNEL);
+		if (!digest_list)
+			return -ENOMEM;
+
+		for (i = 0; i < chip->nr_allocated_banks; i++) {
+			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
+			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
+		}
+
+		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_allocated_banks,
+				     digest_list);
+		kfree(digest_list);
 		tpm_put_ops(chip);
 		return rc;
 	}
 
-	rc = tpm1_pcr_extend(chip, pcr_idx, digests[0].digest,
+	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
 			     "attempting extend a PCR value");
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc3aa39..3cf8ed290305 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -436,7 +436,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
-int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4de49924cfc4..231937d5f58c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -242,11 +242,12 @@ struct tpm2_null_auth_area {
  *
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR.
+ * @count:	number of digests passed.
  * @digests:	list of pcr banks and corresponding digest values to extend.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
@@ -254,6 +255,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
+	if (count > chip->nr_allocated_banks)
+		return -EINVAL;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc)
 		return rc;
@@ -268,9 +272,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
 	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
 		       sizeof(auth_area));
-	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
+	tpm_buf_append_u32(&buf, count);
 
-	for (i = 0; i < chip->nr_allocated_banks; i++) {
+	for (i = 0; i < count; i++) {
 		tpm_buf_append_u16(&buf, digests[i].alg_id);
 		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
 			       chip->allocated_banks[i].digest_size);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 53c0ea9ec9df..d4516164dc9f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -166,8 +166,7 @@ struct tpm_chip {
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
-extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-			  struct tpm_digest *digests);
+extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern int tpm_seal_trusted(struct tpm_chip *chip,
@@ -190,7 +189,7 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 }
 
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-				 struct tpm_digest *digests)
+				 const u8 *hash)
 {
 	return -ENODEV;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ca10917b5f89..bf7178ef1619 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -149,7 +149,6 @@ int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
-int __init ima_init_digests(void);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 1e47c1026471..cf7a2f58077e 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -119,12 +119,8 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
-	/* It can be called before ima_init_digests(), it does not use TPM. */
 	ima_load_kexec_buffer();
 
-	rc = ima_init_digests();
-	if (rc != 0)
-		return rc;
 	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..03afa67c2e04 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -23,9 +23,6 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
-/* pre-allocated array of tpm_digest structures to extend a PCR */
-static struct tpm_digest *digests;
-
 LIST_HEAD(ima_measurements);	/* list of all measurements */
 #ifdef CONFIG_IMA_KEXEC
 static unsigned long binary_runtime_size;
@@ -139,15 +136,11 @@ unsigned long ima_get_binary_runtime_size(void)
 static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
-	int i;
 
 	if (!ima_tpm_chip)
 		return result;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
-		memcpy(digests[i].digest, hash, TPM_DIGEST_SIZE);
-
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests);
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
@@ -214,21 +207,3 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 	mutex_unlock(&ima_extend_list_mutex);
 	return result;
 }
-
-int __init ima_init_digests(void)
-{
-	int i;
-
-	if (!ima_tpm_chip)
-		return 0;
-
-	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
-			  GFP_NOFS);
-	if (!digests)
-		return -ENOMEM;
-
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
-		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
-
-	return 0;
-}
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 9a94672e7adc..287553039f0f 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -32,7 +32,6 @@
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
 static struct tpm_chip *chip;
-static struct tpm_digest *digests;
 
 struct sdesc {
 	struct shash_desc shash;
@@ -386,10 +385,15 @@ EXPORT_SYMBOL_GPL(trusted_tpm_send);
  */
 static int pcrlock(const int pcrnum)
 {
+	unsigned char hash[SHA1_DIGEST_SIZE];
+	int ret;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-
-	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
+	ret = tpm_get_random(chip, hash, SHA1_DIGEST_SIZE);
+	if (ret != SHA1_DIGEST_SIZE)
+		return ret;
+	return tpm_pcr_extend(chip, pcrnum, hash) ? -EINVAL : 0;
 }
 
 /*
@@ -1226,29 +1230,6 @@ static int __init trusted_shash_alloc(void)
 	return ret;
 }
 
-static int __init init_digests(void)
-{
-	u8 digest[TPM_MAX_DIGEST_SIZE];
-	int ret;
-	int i;
-
-	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
-		return ret;
-	if (ret < TPM_MAX_DIGEST_SIZE)
-		return -EFAULT;
-
-	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
-			  GFP_KERNEL);
-	if (!digests)
-		return -ENOMEM;
-
-	for (i = 0; i < chip->nr_allocated_banks; i++)
-		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
-
-	return 0;
-}
-
 static int __init init_trusted(void)
 {
 	int ret;
@@ -1259,21 +1240,15 @@ static int __init init_trusted(void)
 	chip = tpm_default_chip();
 	if (!chip)
 		return 0;
-
-	ret = init_digests();
-	if (ret < 0)
-		goto err_put;
 	ret = trusted_shash_alloc();
 	if (ret < 0)
-		goto err_free;
+		goto err_put;
 	ret = register_key_type(&key_type_trusted);
 	if (ret < 0)
 		goto err_release;
 	return 0;
 err_release:
 	trusted_shash_release();
-err_free:
-	kfree(digests);
 err_put:
 	put_device(&chip->dev);
 	return ret;
@@ -1283,7 +1258,6 @@ static void __exit cleanup_trusted(void)
 {
 	if (chip) {
 		put_device(&chip->dev);
-		kfree(digests);
 		trusted_shash_release();
 		unregister_key_type(&key_type_trusted);
 	}
-- 
2.21.0

