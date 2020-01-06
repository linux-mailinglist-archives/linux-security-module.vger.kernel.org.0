Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86441315FD
	for <lists+linux-security-module@lfdr.de>; Mon,  6 Jan 2020 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgAFQZi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 6 Jan 2020 11:25:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52591 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQZh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jan 2020 11:25:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so15572280wmc.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jan 2020 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS5YFX7furb1E7YBMiNhB8siqUqQS9rjD7CX2ldMqVA=;
        b=PPHmWu+c6yvDKp1Q9H/cO+GtgibJISU7h0fhA4woQEIgOMAXrGc5hXZoTx0RUR011d
         IyCH12diQiVi6LilzAyHJFgNRFZtG2nhLbGQOuoJ5Q8CIxtqs8j0n5rTR+BV2MNfib/w
         pLCmVFCMD2g6gV5jhOtekyvDHh4WLnvL6oLfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS5YFX7furb1E7YBMiNhB8siqUqQS9rjD7CX2ldMqVA=;
        b=NYuhxX3OUjElD5pHeRzExMGNGhbUxWNQRZG/ZU62ZxxB12ByfmGfpil6Ab8e4aGPEN
         T8INtnNFq9Alu3Gy3x/ng7plC2D29veB7GY6UYdExggUZYthvQLrgY3pp5t6irA7YKAL
         VUKSp0aglCERLya8+iT9zwVejL9dDnLUnpeNd1d5mr/VMwk/MjzTrcjb6ab6HbBSfRAl
         omjnInC0dRXHzWIUfJMRr385XtyiKwUInS15ZdCN7zoect+CxFpBlIFvrIdfPZNjcnVI
         aFaiuBB9+JrzxCFIsUtMvcEXJl2Yh8GpZus3RFeJOfEeDnNivhElgzM5reEWfayk+1By
         f1Aw==
X-Gm-Message-State: APjAAAVkNh4UfRtOdTxjTcvGuf5x+1MqST3Gv4gOxtpb+VbgdiH2tR6m
        Vz3zqp6sux6P3vTeNPk6mjqrz+OpB3lD0xDS
X-Google-Smtp-Source: APXvYqyeyBWZK+/gtY+xcC0LYjaXdpfGMsN3mTwHq4pttnlG5UJ/8hgPJKqwa0qLSwKKuax+D+zFYg==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr33163904wmi.10.1578327935932;
        Mon, 06 Jan 2020 08:25:35 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id b10sm75393458wrt.90.2020.01.06.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:25:35 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, zohar@linux.ibm.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: [PATCH v2] ima: add the ability to query the hash of a given file.
Date:   Mon,  6 Jan 2020 17:25:24 +0100
Message-Id: <20200106162524.164650-1-revest@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Florent Revest <revest@google.com>

This allows other parts of the kernel (perhaps a stacked LSM allowing
system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
of a given file from IMA if it's present in the iint cache.

It's true that the existence of the hash means that it's also in the
audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
but it can be difficult to pull that information out for every
subsequent exec.  This is especially true if a given host has been up
for a long time and the file was first measured a long time ago.

This is based on Peter Moody's patch:
 https://sourceforge.net/p/linux-ima/mailman/message/33036180/

[1] https://lkml.org/lkml/2019/9/10/393

Signed-off-by: Florent Revest <revest@google.com>
---
 include/linux/ima.h               |  6 ++++
 security/integrity/ima/ima_main.c | 46 +++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..d621c65ba9a5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
@@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..3799b6c6c3b8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -445,6 +445,52 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
+/**
+ * ima_file_hash - return the stored measurement if a file has been hashed.
+ * @file: pointer to the file
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, return the hash algorithm (as defined in the enum hash_algo).
+ * If buf is not NULL, this function also outputs the hash into buf.
+ * If the hash is larger than buf_size, then only buf_size bytes will be copied.
+ * It generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	struct inode *inode;
+	struct integrity_iint_cache *iint;
+	int hash_algo;
+
+	if (!file)
+		return -EINVAL;
+
+	if (!ima_policy_flag)
+		return -EOPNOTSUPP;
+
+	inode = file_inode(file);
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&iint->mutex);
+	if (buf) {
+		size_t copied_size;
+
+		copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
+		memcpy(buf, iint->ima_hash->digest, copied_size);
+	}
+	hash_algo = iint->ima_hash->algo;
+	mutex_unlock(&iint->mutex);
+
+	return hash_algo;
+}
+EXPORT_SYMBOL_GPL(ima_file_hash);
+
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @file : newly created tmpfile
-- 
2.24.1.735.g03f4e72817-goog

