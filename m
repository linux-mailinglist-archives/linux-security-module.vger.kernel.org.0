Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2350558F10F
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Aug 2022 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiHJRBV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Aug 2022 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiHJRBK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Aug 2022 13:01:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A65960F6;
        Wed, 10 Aug 2022 10:01:09 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2x673NVnz67vrS;
        Thu, 11 Aug 2022 01:01:03 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 19:01:05 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <corbet@lwn.net>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
Date:   Wed, 10 Aug 2022 18:59:28 +0200
Message-ID: <20220810165932.2143413-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810165932.2143413-1-roberto.sassu@huawei.com>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
kfuncs, to respectively search a key with a given serial and flags, obtain
a key from a pre-determined ID defined in include/linux/verification.h, and
cleanup.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf.h      |   6 ++
 kernel/trace/bpf_trace.c | 146 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a82f8c559ae2..d415e5e97551 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2573,4 +2573,10 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
 static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
 #endif /* CONFIG_BPF_LSM */
 
+#ifdef CONFIG_KEYS
+struct bpf_key {
+	struct key *key;
+	bool has_ref;
+};
+#endif /* CONFIG_KEYS */
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..a607bb0be738 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,8 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/key.h>
+#include <linux/verification.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1183,150 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+#ifdef CONFIG_KEYS
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+/**
+ * bpf_lookup_user_key - lookup a key by its serial
+ * @serial: key serial
+ * @flags: lookup-specific flags
+ *
+ * Search a key with a given *serial* and the provided *flags*. The
+ * returned key, if found, has the reference count incremented by
+ * one, and is stored in a bpf_key structure, returned to the caller.
+ * The bpf_key structure must be passed to bpf_key_put() when done
+ * with it, so that the key reference count is decremented and the
+ * bpf_key structure is freed.
+ *
+ * Permission checks are deferred to the time the key is used by
+ * one of the available key-specific kfuncs.
+ *
+ * Set *flags* with 1, to attempt creating a requested special
+ * keyring (e.g. session keyring), if it doesn't yet exist. Set
+ * *flags* with 2 to lookup a key without waiting for the key
+ * construction, and to retrieve uninstantiated keys (keys without
+ * data attached to them).
+ *
+ * Return: a bpf_key pointer with a valid key pointer if the key is found, a
+ *         NULL pointer otherwise.
+ */
+struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
+{
+	key_ref_t key_ref;
+	struct bpf_key *bkey;
+
+	/* Keep in sync with include/linux/key.h. */
+	if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
+		return NULL;
+
+	/*
+	 * Permission check is deferred until actual kfunc using the key,
+	 * since here the intent of the caller is not yet known.
+	 *
+	 * We cannot trust the caller to provide the needed permission as
+	 * argument, since nothing prevents the caller from using the
+	 * obtained key for a different purpose than the one declared.
+	 */
+	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
+	if (IS_ERR(key_ref))
+		return NULL;
+
+	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
+	if (!bkey) {
+		key_put(key_ref_to_ptr(key_ref));
+		return NULL;
+	}
+
+	bkey->key = key_ref_to_ptr(key_ref);
+	bkey->has_ref = true;
+
+	return bkey;
+}
+
+/**
+ * bpf_lookup_system_key - lookup a key by a system-defined ID
+ * @id: key ID
+ *
+ * Obtain a bpf_key structure with a key pointer set to the passed key ID.
+ * The key pointer is marked as invalid, to prevent bpf_key_put() from
+ * attempting to decrement the key reference count on that pointer. The key
+ * pointer set in such way is currently understood only by
+ * verify_pkcs7_signature().
+ *
+ * Set *id* to one of the values defined in include/linux/verification.h:
+ * 0 for the primary keyring (immutable keyring of system keys); 1 for both
+ * the primary and secondary keyring (where keys can be added only if they
+ * are vouched for by existing keys in those keyrings); 2 for the platform
+ * keyring (primarily used by the integrity subsystem to verify a kexec'ed
+ * kerned image and, possibly, the initramfs signature).
+ *
+ * Return: a bpf_key pointer with an invalid key pointer set from the
+ *         pre-determined ID on success, a NULL pointer otherwise
+ */
+struct bpf_key *bpf_lookup_system_key(u64 id)
+{
+	struct bpf_key *bkey;
+
+	/* Keep in sync with defs in include/linux/verification.h. */
+	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
+		return NULL;
+
+	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
+	if (!bkey)
+		return NULL;
+
+	bkey->key = (struct key *)(unsigned long)id;
+	bkey->has_ref = false;
+
+	return bkey;
+}
+
+/**
+ * bpf_key_put - decrement key reference count if key is valid and free bpf_key
+ * @bkey: bpf_key structure
+ *
+ * Decrement the reference count of the key inside *bkey*, if the pointer
+ * is valid, and free *bkey*.
+ */
+void bpf_key_put(struct bpf_key *bkey)
+{
+	if (bkey->has_ref)
+		key_put(bkey->key);
+
+	kfree(bkey);
+}
+
+__diag_pop();
+
+BTF_SET8_START(key_sig_kfunc_set)
+BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
+BTF_SET8_END(key_sig_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &key_sig_kfunc_set,
+};
+
+static int __init bpf_key_sig_kfuncs_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_key_sig_kfunc_set);
+	if (!ret)
+		return 0;
+
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					 &bpf_key_sig_kfunc_set);
+}
+
+late_initcall(bpf_key_sig_kfuncs_init);
+#endif /* CONFIG_KEYS */
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.25.1

