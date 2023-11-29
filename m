Return-Path: <linux-security-module+bounces-114-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA07FCBB0
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Nov 2023 01:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70133283253
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Nov 2023 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651C1878
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Nov 2023 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGQ2raRz"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1717F9;
	Wed, 29 Nov 2023 00:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64215C433C9;
	Wed, 29 Nov 2023 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218236;
	bh=QfM3a9ZhMANQpwP1T5b23KK+Y08XGJxzrDIfy4DAcuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGQ2raRzpjq1JBq4lZCkPxgBIpX5kqZnlAm8sat6qhrHHLmrV8P7CNOarRAl24jWq
	 FGJF9ez4BFfD2N3uMYi6/HODEUUpvN1R4XVrgf6lUAQ4c7P9a+ZNhniUdw20NGjwPE
	 hfJlLHsCI+03IE/VWH4n4KYEswzxk2SPWBxoh2OZGubjP4vt/ivwtryH5IMnhdwxf8
	 ohVEM7fgCg9p8a/4XmWRIRDkYqC7ixzD1HyBWNaje9zyfVzZsZd8z1zxVTqxTc7Qwa
	 9L5jn6Bz32p6WV5hIi2aWjgqyN9IvKy8M8sp0hKBBap8aYoob0ok1kyoo/r6gi7TXr
	 zWLROIZoF9SFQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v14 bpf-next 2/6] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
Date: Tue, 28 Nov 2023 16:36:52 -0800
Message-Id: <20231129003656.1165061-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129003656.1165061-1-song@kernel.org>
References: <20231129003656.1165061-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsverity provides fast and reliable hash of files, namely fsverity_digest.
The digest can be used by security solutions to verify file contents.

Add new kfunc bpf_get_fsverity_digest() so that we can access fsverity from
BPF LSM programs. This kfunc is added to fs/verity/measure.c because some
data structure used in the function is private to fsverity
(fs/verity/fsverity_private.h).

To avoid recursion, bpf_get_fsverity_digest is only allowed in BPF LSM
programs.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h | 10 +++++
 fs/verity/init.c             |  1 +
 fs/verity/measure.c          | 84 ++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index d071a6e32581..a6a6b2749241 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -100,6 +100,16 @@ fsverity_msg(const struct inode *inode, const char *level,
 #define fsverity_err(inode, fmt, ...)		\
 	fsverity_msg((inode), KERN_ERR, fmt, ##__VA_ARGS__)
 
+/* measure.c */
+
+#ifdef CONFIG_BPF_SYSCALL
+void __init fsverity_init_bpf(void);
+#else
+static inline void fsverity_init_bpf(void)
+{
+}
+#endif
+
 /* open.c */
 
 int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
diff --git a/fs/verity/init.c b/fs/verity/init.c
index a29f062f6047..1e207c0f71de 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -69,6 +69,7 @@ static int __init fsverity_init(void)
 	fsverity_init_workqueue();
 	fsverity_init_sysctl();
 	fsverity_init_signature();
+	fsverity_init_bpf();
 	return 0;
 }
 late_initcall(fsverity_init)
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index eec5956141da..bf7a5f4cccaf 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -7,6 +7,8 @@
 
 #include "fsverity_private.h"
 
+#include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/uaccess.h>
 
 /**
@@ -100,3 +102,85 @@ int fsverity_get_digest(struct inode *inode,
 	return hash_alg->digest_size;
 }
 EXPORT_SYMBOL_GPL(fsverity_get_digest);
+
+#ifdef CONFIG_BPF_SYSCALL
+
+/* bpf kfuncs */
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_get_fsverity_digest: read fsverity digest of file
+ * @file: file to get digest from
+ * @digest_ptr: (out) dynptr for struct fsverity_digest
+ *
+ * Read fsverity_digest of *file* into *digest_ptr*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_kern *digest_ptr)
+{
+	const struct inode *inode = file_inode(file);
+	u32 dynptr_sz = __bpf_dynptr_size(digest_ptr);
+	struct fsverity_digest *arg;
+	const struct fsverity_info *vi;
+	const struct fsverity_hash_alg *hash_alg;
+	int out_digest_sz;
+
+	if (dynptr_sz < sizeof(struct fsverity_digest))
+		return -EINVAL;
+
+	arg = __bpf_dynptr_data_rw(digest_ptr, dynptr_sz);
+	if (!arg)
+		return -EINVAL;
+
+	if (!IS_ALIGNED((uintptr_t)arg, __alignof__(*arg)))
+		return -EINVAL;
+
+	vi = fsverity_get_info(inode);
+	if (!vi)
+		return -ENODATA; /* not a verity file */
+
+	hash_alg = vi->tree_params.hash_alg;
+
+	arg->digest_algorithm = hash_alg - fsverity_hash_algs;
+	arg->digest_size = hash_alg->digest_size;
+
+	out_digest_sz = dynptr_sz - sizeof(struct fsverity_digest);
+
+	/* copy digest */
+	memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest_size, out_digest_sz));
+
+	/* fill the extra buffer with zeros */
+	if (out_digest_sz > hash_alg->digest_size)
+		memset(arg->digest + arg->digest_size, 0, out_digest_sz - hash_alg->digest_size);
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_SET8_START(fsverity_set_ids)
+BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
+BTF_SET8_END(fsverity_set_ids)
+
+static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&fsverity_set_ids, kfunc_id))
+		return 0;
+
+	/* Only allow to attach from LSM hooks, to avoid recursion */
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+static const struct btf_kfunc_id_set bpf_fsverity_set = {
+	.owner = THIS_MODULE,
+	.set = &fsverity_set_ids,
+	.filter = bpf_get_fsverity_digest_filter,
+};
+
+void __init fsverity_init_bpf(void)
+{
+	register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fsverity_set);
+}
+
+#endif /* CONFIG_BPF_SYSCALL */
-- 
2.34.1


