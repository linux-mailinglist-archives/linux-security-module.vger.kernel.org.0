Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF348C24
	for <lists+linux-security-module@lfdr.de>; Mon, 17 Jun 2019 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFQShx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 17 Jun 2019 14:37:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQShw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Jun 2019 14:37:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so6132168pfe.11;
        Mon, 17 Jun 2019 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iingJn35PfXiFELQGwi9zLNPjCZgv0Bhfrzd1uEUrgA=;
        b=g/GKRLN8CI1MOivVNS73mS5WWZB3FHDwnzZIsi1xO1vaQzwonvS2q0+YPkgdwlv1Tb
         dUy/GU/JBAV1XQbJx+Pvv5H5XZT2aX4BBe/VoLdH4iDb6Es0PnaoVcxuwVgsWWbmDnZO
         VP4rHkLiC3T7lxTHerkvP0aOfIqgoRU143OT6kUCs7fm9ORu1fN5ofw7VIGyplkGWeZ+
         v67WsuoYz/mBZMyaTk/gnSO1aA5B/1YA/Mu1KX6uYftlTouIjkwfjcO++ukC1hv9Boqy
         RUMUuwxvMweeMAv1BzFgpUfFYwF1MxwyGYn2oy5GRyaBVs2Ye3rvuzbnqCBfcAsFR0tF
         WJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iingJn35PfXiFELQGwi9zLNPjCZgv0Bhfrzd1uEUrgA=;
        b=Qz+qonJE1C++tv7OKZ3MjcJ5XWCa0lihgTST1EAgDHIvf2iSUFboMm8YiITZlJlm3l
         lPO7L6YnYLGHKqVF4C8YqvBG6vTvSFDkDGurQ1NjynuTt1aS+trS0LYUxTVPP1/i2QpG
         MwGNFGuLoiCvi6KIky8aE6k730SCt32PnACn62b+fbN+EU6eK2vMOvrpxb9lO+J5L2VT
         trq0c4j9ubhqz0G0AO+yRbdKA1mtxixwuB89k/8RGGq3jwi63ElroVHvwltBDqeCkgo6
         tXX2wm3fFFCsOoAeuX+VaRdSI3seV+FTpheRIJq6gZBGaBZxyqpsObBJMkZeJlJlsWIG
         P3qg==
X-Gm-Message-State: APjAAAXd+lcjJvTW0k8sQ82gRK7lc5kgHPxewDVzEUafwdAxxROkkvjT
        mbI3WeCArljUaaE9OHlNW+QU06tG
X-Google-Smtp-Source: APXvYqy6tiM86DwpjA9UqK99vHR7eVZNqdTpGnhondAUf3BFQCayeikZGi9GVIT5dfhXSkAV7PNTWw==
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr45416193pfr.88.1560796670993;
        Mon, 17 Jun 2019 11:37:50 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f17sm13104817pgv.16.2019.06.17.11.37.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:37:50 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V9 1/3] IMA:Define a new hook to measure the kexec boot command line arguments
Date:   Mon, 17 Jun 2019 11:37:36 -0700
Message-Id: <20190617183738.14484-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190617183738.14484-1-prsriva02@gmail.com>
References: <20190617183738.14484-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently during soft reboot(kexec_file_load) boot command line
arguments are not measured. Define hooks needed to measure kexec
command line arguments during soft reboot(kexec_file_load).

- A new ima hook ima_kexec_cmdline is defined to be called by the
kexec code.
- A new function process_buffer_measurement is defined to measure
the buffer hash into the IMA measurement list.
- A new func policy KEXEC_CMDLINE is defined to control the
 measurement.[Suggested by Mimi]

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 include/linux/ima.h                  |  2 +
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  1 +
 security/integrity/ima/ima_main.c    | 74 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  7 +++
 6 files changed, 86 insertions(+)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index b383c1763610..fc376a323908 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -28,6 +28,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[KEXEC_CMDLINE]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index fd9f7cf4cdf5..b42f5a006042 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern void ima_kexec_cmdline(const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -92,6 +93,7 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline void ima_kexec_cmdline(const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 18b48a6d0b80..a4ad1270bffa 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -185,6 +185,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(KEXEC_CMDLINE)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 78eb11c7ac07..ea7d8cbf712f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -176,6 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	| KEXEC_CMDLINE
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index af341a80118f..1e233417a7af 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -605,6 +605,80 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
+/*
+ * process_buffer_measurement - Measure the buffer to ima log.
+ * @buf: pointer to the buffer that needs to be added to the log.
+ * @size: size of buffer(in bytes).
+ * @eventname: event name to be used for the buffer entry.
+ * @cred: a pointer to a credentials structure for user validation.
+ * @secid: the secid of the task to be validated.
+ *
+ * Based on policy, the buffer is measured into the ima log.
+ */
+static void process_buffer_measurement(const void *buf, int size,
+				       const char *eventname,
+				       const struct cred *cred, u32 secid)
+{
+	int ret = 0;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache iint = {};
+	struct ima_event_data event_data = {.iint = &iint };
+	struct ima_template_desc *template_desc = NULL;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash = {};
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	int action = 0;
+
+	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
+				&template_desc);
+	if (!(action & IMA_MEASURE))
+		goto out;
+
+	event_data.filename = eventname;
+
+	iint.ima_hash = &hash.hdr;
+	iint.ima_hash->algo = ima_hash_algo;
+	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
+	if (ret < 0)
+		goto out;
+
+	if (action & IMA_MEASURE)
+		ret = ima_store_template(entry, violation, NULL, buf, pcr);
+
+	if (ret < 0)
+		ima_free_template_entry(entry);
+
+out:
+	return;
+}
+
+/**
+ * ima_kexec_cmdline - measure kexec cmdline boot args
+ * @buf: pointer to buffer
+ * @size: size of buffer
+ *
+ * Buffers can only be measured, not appraised.
+ */
+void ima_kexec_cmdline(const void *buf, int size)
+{
+	u32 secid;
+
+	if (buf && size != 0) {
+		security_task_getsecid(current, &secid);
+		process_buffer_measurement(buf, size, "kexec-cmdline",
+					   current_cred(), secid);
+	}
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd9b01881d17..4e8bb7eecd08 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -292,6 +292,11 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
+	if (func == KEXEC_CMDLINE) {
+		if ((rule->flags & IMA_FUNC) && (rule->func == func))
+			return true;
+		return false;
+	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
@@ -880,6 +885,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
+				entry->func = KEXEC_CMDLINE;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.19.1

