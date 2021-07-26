Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A783D649A
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jul 2021 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbhGZP74 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Jul 2021 11:59:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3491 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbhGZP7G (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Jul 2021 11:59:06 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYQQ86Yg8z6G9Rr;
        Tue, 27 Jul 2021 00:30:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 18:39:32 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 07/12] diglim: Interfaces - digest_lists_loaded
Date:   Mon, 26 Jul 2021 18:36:55 +0200
Message-ID: <20210726163700.2092768-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726163700.2092768-1-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Introduce the digest_lists_loaded directory in
<securityfs>/integrity/diglim.

It contains two files for each loaded digest list: one shows the digest
list in binary format, and the other (with .ascii prefix) shows the digest
list in ASCII format.

Files are added and removed at the same time digest lists are added and
removed.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/diglim/fs.c | 307 ++++++++++++++++++++++++++++++++-
 1 file changed, 304 insertions(+), 3 deletions(-)

diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
index 07a0d75a0e33..caf2923c9146 100644
--- a/security/integrity/diglim/fs.c
+++ b/security/integrity/diglim/fs.c
@@ -25,6 +25,17 @@
 #define MAX_DIGEST_LIST_SIZE (64 * 1024 * 1024 - 1)
 
 static struct dentry *diglim_dir;
+/**
+ * DOC: digest_lists_loaded
+ *
+ * digest_lists_loaded is a directory containing two files for each
+ * loaded digest list: one shows the digest list in binary format, and the
+ * other (with .ascii prefix) shows the digest list in ASCII format.
+ *
+ * Files are added and removed at the same time digest lists are added and
+ * removed.
+ */
+static struct dentry *digest_lists_loaded_dir;
 /**
  * DOC: digest_list_add
  *
@@ -47,6 +58,245 @@ static struct dentry *digest_list_add_dentry;
 static struct dentry *digest_list_del_dentry;
 char digest_label[NAME_MAX + 1];
 
+static int parse_digest_list_filename(const char *digest_list_filename,
+				      u8 *digest, enum hash_algo *algo)
+{
+	int i;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++)
+		if (!strncmp(digest_list_filename, hash_algo_name[i],
+			     strlen(hash_algo_name[i])))
+			break;
+
+	if (i == HASH_ALGO__LAST)
+		return -ENOENT;
+
+	*algo = i;
+	return hex2bin(digest, strchr(digest_list_filename, '-') + 1,
+		       hash_digest_size[*algo]);
+}
+
+/* *pos is the offset of the digest list data to show. */
+static void *digest_list_start(struct seq_file *m, loff_t *pos)
+{
+	struct digest_item *d;
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	enum hash_algo algo;
+	struct digest_list_item *digest_list;
+	int ret;
+
+	if (m->private) {
+		digest_list = (struct digest_list_item *)m->private;
+
+		if (*pos == digest_list->size)
+			return NULL;
+
+		return digest_list->buf + *pos;
+	}
+
+	ret = parse_digest_list_filename(file_dentry(m->file)->d_name.name,
+					 digest, &algo);
+	if (ret < 0)
+		return NULL;
+
+	d = __digest_lookup(digest, algo, COMPACT_DIGEST_LIST, NULL, NULL);
+	if (!d)
+		return NULL;
+
+	digest_list = list_first_entry(&d->refs,
+				struct digest_list_item_ref, list)->digest_list;
+	m->private = digest_list;
+	return digest_list->buf;
+}
+
+static void *digest_list_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct compact_list_hdr *hdr;
+	struct digest_list_item *digest_list =
+					(struct digest_list_item *)m->private;
+	void *bufp = digest_list->buf;
+	bool is_header = false;
+
+	/* Determine if v points to a header or a digest. */
+	while (bufp <= v) {
+		hdr = (struct compact_list_hdr *)bufp;
+		if (bufp == v) {
+			is_header = true;
+			break;
+		}
+
+		bufp += sizeof(*hdr) + hdr->datalen;
+	}
+
+	if (is_header)
+		*pos += sizeof(*hdr);
+	else
+		*pos += hash_digest_size[hdr->algo];
+
+	if (*pos == digest_list->size)
+		return NULL;
+
+	return digest_list->buf + *pos;
+}
+
+static void digest_list_stop(struct seq_file *m, void *v)
+{
+}
+
+static void print_digest(struct seq_file *m, u8 *digest, u32 size)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++)
+		seq_printf(m, "%02x", *(digest + i));
+}
+
+static void digest_list_putc(struct seq_file *m, void *data, int datalen)
+{
+	while (datalen--)
+		seq_putc(m, *(char *)data++);
+}
+
+static int digest_list_show_common(struct seq_file *m, void *v, bool binary)
+{
+	struct compact_list_hdr *hdr;
+	struct digest_list_item *digest_list =
+					(struct digest_list_item *)m->private;
+	void *bufp = digest_list->buf;
+	bool is_header = false;
+
+	/* Determine if v points to a header or a digest. */
+	while (bufp <= v) {
+		hdr = (struct compact_list_hdr *)bufp;
+		if (bufp == v) {
+			is_header = true;
+			break;
+		}
+
+		bufp += sizeof(*hdr) + hdr->datalen;
+	}
+
+	if (is_header) {
+		if (binary)
+			digest_list_putc(m, v, sizeof(*hdr));
+		else
+			seq_printf(m,
+				"actions: %d, version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n",
+				digest_list->actions, hdr->version,
+				hash_algo_name[hdr->algo], hdr->type,
+				hdr->modifiers, hdr->count, hdr->datalen);
+		return 0;
+	}
+
+	if (binary) {
+		digest_list_putc(m, v, hash_digest_size[hdr->algo]);
+	} else {
+		print_digest(m, v, hash_digest_size[hdr->algo]);
+		seq_puts(m, "\n");
+	}
+
+	return 0;
+}
+
+static int digest_list_show(struct seq_file *m, void *v)
+{
+	return digest_list_show_common(m, v, true);
+}
+
+static int digest_list_ascii_show(struct seq_file *m, void *v)
+{
+	return digest_list_show_common(m, v, false);
+}
+
+static const struct seq_operations digest_list_seqops = {
+	.start = digest_list_start,
+	.next = digest_list_next,
+	.stop = digest_list_stop,
+	.show = digest_list_show
+};
+
+static int digest_list_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &digest_list_seqops);
+}
+
+static const struct file_operations digest_list_ops = {
+	.open = digest_list_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct seq_operations digest_list_ascii_seqops = {
+	.start = digest_list_start,
+	.next = digest_list_next,
+	.stop = digest_list_stop,
+	.show = digest_list_ascii_show
+};
+
+static int digest_list_ascii_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &digest_list_ascii_seqops);
+}
+
+static const struct file_operations digest_list_ascii_ops = {
+	.open = digest_list_ascii_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int digest_list_get_secfs_files(char *label, u8 *digest,
+				       enum hash_algo algo, enum ops op,
+				       struct dentry **dentry,
+				       struct dentry **dentry_ascii)
+{
+	char digest_list_filename[NAME_MAX + 1] = { 0 };
+	u8 digest_str[IMA_MAX_DIGEST_SIZE * 2 + 1] = { 0 };
+	char *dot, *label_ptr;
+
+	label_ptr = strrchr(label, '/');
+	if (label_ptr)
+		label = label_ptr + 1;
+
+	bin2hex(digest_str, digest, hash_digest_size[algo]);
+
+	snprintf(digest_list_filename, sizeof(digest_list_filename),
+		 "%s-%s-%s.ascii", hash_algo_name[algo], digest_str, label);
+
+	dot = strrchr(digest_list_filename, '.');
+
+	*dot = '\0';
+	if (op == DIGEST_LIST_ADD)
+		*dentry = securityfs_create_file(digest_list_filename, 0440,
+						 digest_lists_loaded_dir, NULL,
+						 &digest_list_ops);
+	else
+		*dentry = lookup_positive_unlocked(digest_list_filename,
+						digest_lists_loaded_dir,
+						strlen(digest_list_filename));
+	*dot = '.';
+	if (IS_ERR(*dentry))
+		return PTR_ERR(*dentry);
+
+	if (op == DIGEST_LIST_ADD)
+		*dentry_ascii = securityfs_create_file(digest_list_filename,
+						0440, digest_lists_loaded_dir,
+						NULL, &digest_list_ascii_ops);
+	else
+		*dentry_ascii = lookup_positive_unlocked(digest_list_filename,
+						digest_lists_loaded_dir,
+						strlen(digest_list_filename));
+	if (IS_ERR(*dentry_ascii)) {
+		if (op == DIGEST_LIST_ADD)
+			securityfs_remove(*dentry);
+
+		return PTR_ERR(*dentry_ascii);
+	}
+
+	return 0;
+}
+
 /*
  * digest_list_read: read and parse the digest list from the path
  */
@@ -60,6 +310,7 @@ static ssize_t digest_list_read(char *path, enum ops op)
 	char event_name[NAME_MAX + 9 + 1];
 	u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
 	enum hash_algo algo;
+	struct dentry *dentry, *dentry_ascii;
 	int rc, pathlen = strlen(path);
 
 	/* Remove \n. */
@@ -95,9 +346,27 @@ static ssize_t digest_list_read(char *path, enum ops op)
 	if (!rc || rc == -EEXIST)
 		actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
 
-	rc = digest_list_parse(size, data, op, actions, digest, algo, "");
+	rc = digest_list_get_secfs_files(path, digest, algo, op, &dentry,
+					 &dentry_ascii);
+	if (rc < 0)
+		goto out_vfree;
+
+	rc = digest_list_parse(size, data, op, actions, digest, algo,
+			       dentry->d_name.name);
 	if (rc < 0)
 		pr_err("unable to upload digest list %s (%d)\n", path, rc);
+
+	/* Release reference taken in digest_list_get_secfs_files(). */
+	if (op == DIGEST_LIST_DEL) {
+		dput(dentry);
+		dput(dentry_ascii);
+	}
+
+	if ((rc < 0 && op == DIGEST_LIST_ADD) ||
+	    (rc == size && op == DIGEST_LIST_DEL)) {
+		securityfs_remove(dentry);
+		securityfs_remove(dentry_ascii);
+	}
 out_vfree:
 	vfree(data);
 out:
@@ -116,9 +385,10 @@ static ssize_t digest_list_write(struct file *file, const char __user *buf,
 				 size_t datalen, loff_t *ppos)
 {
 	char *data;
+	char *digest_label_ptr;
 	ssize_t result;
 	enum ops op = DIGEST_LIST_ADD;
-	struct dentry *dentry = file_dentry(file);
+	struct dentry *dentry = file_dentry(file), *dentry_ascii;
 	u8 digest[IMA_MAX_DIGEST_SIZE];
 	char event_name[NAME_MAX + 11 + 1];
 	enum hash_algo algo;
@@ -147,6 +417,10 @@ static ssize_t digest_list_write(struct file *file, const char __user *buf,
 	if (data[0] == '/') {
 		result = digest_list_read(data, op);
 	} else {
+		/* Remove \n. */
+		digest_label_ptr = digest_label;
+		strsep(&digest_label_ptr, "\n");
+
 		snprintf(event_name, sizeof(event_name), "%s_buffer_%s",
 			 op == DIGEST_LIST_ADD ? "add" : "del", digest_label);
 
@@ -164,12 +438,33 @@ static ssize_t digest_list_write(struct file *file, const char __user *buf,
 		if (!result || result == -EEXIST)
 			actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
 
+		result = digest_list_get_secfs_files(digest_label[0] != '\0' ?
+						     digest_label : "parser",
+						     digest, algo, op,
+						     &dentry, &dentry_ascii);
+		if (result < 0)
+			goto out_kfree;
+
+		memset(digest_label, 0, sizeof(digest_label));
+
 		result = digest_list_parse(datalen, data, op, actions, digest,
-					   algo, "");
+					   algo, dentry->d_name.name);
 		if (result != datalen) {
 			pr_err("unable to upload generated digest list\n");
 			result = -EINVAL;
 		}
+
+		/* Release reference taken in digest_list_get_secfs_files(). */
+		if (op == DIGEST_LIST_DEL) {
+			dput(dentry);
+			dput(dentry_ascii);
+		}
+
+		if ((result < 0 && op == DIGEST_LIST_ADD) ||
+		    (result == datalen && op == DIGEST_LIST_DEL)) {
+			securityfs_remove(dentry);
+			securityfs_remove(dentry_ascii);
+		}
 	}
 out_kfree:
 	kfree(data);
@@ -216,6 +511,11 @@ static int __init diglim_fs_init(void)
 	if (IS_ERR(diglim_dir))
 		return -1;
 
+	digest_lists_loaded_dir = securityfs_create_dir("digest_lists_loaded",
+							diglim_dir);
+	if (IS_ERR(digest_lists_loaded_dir))
+		goto out;
+
 	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
 						diglim_dir, NULL,
 						&digest_list_upload_ops);
@@ -232,6 +532,7 @@ static int __init diglim_fs_init(void)
 out:
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
+	securityfs_remove(digest_lists_loaded_dir);
 	securityfs_remove(diglim_dir);
 	return -1;
 }
-- 
2.25.1

