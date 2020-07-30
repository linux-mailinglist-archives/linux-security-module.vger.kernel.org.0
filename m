Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4E2333E7
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Jul 2020 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgG3OIF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 Jul 2020 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgG3OH0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB15C06179F
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2020 07:07:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so14482320wrc.7
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2020 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvythMvxMwHQ+Vh/SpXYfWnzorc+PKamtxFCojLQew4=;
        b=VtRpG2lJgk2+F5m/LzEQ9rYZcqLyzi8Li8ua3QD0xDYVuOh/fXc67fC4UbND83AdVy
         d6ixG0MkWulVCFgqrLcMAKFN+IWegtw5tUK9EpklHV++aLBkvs+drQO3PQXO5s/nSrdk
         gLVhd6CR1gC5v3rQQhsOmPCKsqg4g2HxusuaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvythMvxMwHQ+Vh/SpXYfWnzorc+PKamtxFCojLQew4=;
        b=WF7jIp4e6KXwHi7FpsNOuEmzvaKEUu+IUMjE8MyBJ63FEz2MnM+uMiPrkuoTik5BMq
         GrbPO9Jtdow/6ZpSjDLPxN9oPfSjrlRSgrazXtPlPl5Iv3M+3mbuS9xyLkcAeGBVM8KF
         6GGORJ1HrxTPtemPgTI2sY1MeyH68hCZxymKWcPD03ZpvDq7DcWRdA939w2ECrkg5CLa
         kVZVvCZDzVRCfh5gYCfKNa2VRS+wxngDOVAvHtFsq8Y1aBF7+CIA5KlblJLYefMMAYTT
         +3M/wW8gDIwhOuuI7MnJIMnHDZlzf4+MKO4US00chXZLtUScFgISgMpqK2+bOeFi+uJP
         HbTg==
X-Gm-Message-State: AOAM5304D3QyJYc3A/3tHpiwgPrN0XoLZvpPpaX/VJKIlX3KW72xkEEe
        dKy1q8+J8puRlYkqYgKpM4hfXNmK3ZBeHw==
X-Google-Smtp-Source: ABdhPJwWJHM/kfxdqMOw3qygkTDW3CYgM4eTrWCT9PKJCMkucKt6ufYOgE9J+V2rASbTL6N5+mtD4g==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr3221589wrn.116.1596118043375;
        Thu, 30 Jul 2020 07:07:23 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a10sm19088599wmd.3.2020.07.30.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:07:22 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v7 1/7] A purely mechanical change to split the renaming from the actual generalization.
Date:   Thu, 30 Jul 2020 16:07:10 +0200
Message-Id: <20200730140716.404558-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200730140716.404558-1-kpsingh@chromium.org>
References: <20200730140716.404558-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Flags/consts:

  SK_STORAGE_CREATE_FLAG_MASK	BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
  BPF_SK_STORAGE_CACHE_SIZE	BPF_LOCAL_STORAGE_CACHE_SIZE
  MAX_VALUE_SIZE		BPF_LOCAL_STORAGE_MAX_VALUE_SIZE

Structs:

  bucket			bpf_local_storage_map_bucket
  bpf_sk_storage_map		bpf_local_storage_map
  bpf_sk_storage_data		bpf_local_storage_data
  bpf_sk_storage_elem		bpf_local_storage_elem
  bpf_sk_storage		bpf_local_storage

The "sk" member in bpf_local_storage is also updated to "owner"
in preparation for changing the type to void * in a subsequent patch.

Functions:

  selem_linked_to_sk			selem_linked_to_storage
  selem_alloc				bpf_selem_alloc
  __selem_unlink_sk			bpf_selem_unlink_storage
  __selem_link_sk			bpf_selem_link_storage
  selem_unlink_sk			__bpf_selem_unlink_storage
  sk_storage_update			bpf_local_storage_update
  __sk_storage_lookup			bpf_local_storage_lookup
  bpf_sk_storage_map_free		bpf_local_storage_map_free
  bpf_sk_storage_map_alloc		bpf_local_storage_map_alloc
  bpf_sk_storage_map_alloc_check	bpf_local_storage_map_alloc_check
  bpf_sk_storage_map_check_btf		bpf_local_storage_map_check_btf

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/sock.h        |   4 +-
 net/core/bpf_sk_storage.c | 455 +++++++++++++++++++-------------------
 2 files changed, 233 insertions(+), 226 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2cc3ba667908..685aee71b91a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -246,7 +246,7 @@ struct sock_common {
 	/* public: */
 };
 
-struct bpf_sk_storage;
+struct bpf_local_storage;
 
 /**
   *	struct sock - network layer representation of sockets
@@ -517,7 +517,7 @@ struct sock {
 	void                    (*sk_destruct)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
 #ifdef CONFIG_BPF_SYSCALL
-	struct bpf_sk_storage __rcu	*sk_bpf_storage;
+	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
 };
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d3377c90a291..a5cc218834ee 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -12,33 +12,32 @@
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
 
-#define SK_STORAGE_CREATE_FLAG_MASK					\
-	(BPF_F_NO_PREALLOC | BPF_F_CLONE)
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
-struct bucket {
+struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
 };
 
-/* Thp map is not the primary owner of a bpf_sk_storage_elem.
- * Instead, the sk->sk_bpf_storage is.
+/* Thp map is not the primary owner of a bpf_local_storage_elem.
+ * Instead, the container object (eg. sk->sk_bpf_storage) is.
  *
- * The map (bpf_sk_storage_map) is for two purposes
- * 1. Define the size of the "sk local storage".  It is
+ * The map (bpf_local_storage_map) is for two purposes
+ * 1. Define the size of the "local storage".  It is
  *    the map's value_size.
  *
  * 2. Maintain a list to keep track of all elems such
  *    that they can be cleaned up during the map destruction.
  *
  * When a bpf local storage is being looked up for a
- * particular sk,  the "bpf_map" pointer is actually used
+ * particular object,  the "bpf_map" pointer is actually used
  * as the "key" to search in the list of elem in
- * sk->sk_bpf_storage.
+ * the respective bpf_local_storage owned by the object.
  *
- * Hence, consider sk->sk_bpf_storage is the mini-map
- * with the "bpf_map" pointer as the searching key.
+ * e.g. sk->sk_bpf_storage is the mini-map with the "bpf_map" pointer
+ * as the searching key.
  */
-struct bpf_sk_storage_map {
+struct bpf_local_storage_map {
 	struct bpf_map map;
 	/* Lookup elem does not require accessing the map.
 	 *
@@ -46,55 +45,57 @@ struct bpf_sk_storage_map {
 	 * link/unlink the elem from the map.  Having
 	 * multiple buckets to improve contention.
 	 */
-	struct bucket *buckets;
+	struct bpf_local_storage_map_bucket *buckets;
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
 };
 
-struct bpf_sk_storage_data {
+struct bpf_local_storage_data {
 	/* smap is used as the searching key when looking up
-	 * from sk->sk_bpf_storage.
+	 * from the object's bpf_local_storage.
 	 *
 	 * Put it in the same cacheline as the data to minimize
 	 * the number of cachelines access during the cache hit case.
 	 */
-	struct bpf_sk_storage_map __rcu *smap;
+	struct bpf_local_storage_map __rcu *smap;
 	u8 data[] __aligned(8);
 };
 
-/* Linked to bpf_sk_storage and bpf_sk_storage_map */
-struct bpf_sk_storage_elem {
-	struct hlist_node map_node;	/* Linked to bpf_sk_storage_map */
-	struct hlist_node snode;	/* Linked to bpf_sk_storage */
-	struct bpf_sk_storage __rcu *sk_storage;
+/* Linked to bpf_local_storage and bpf_local_storage_map */
+struct bpf_local_storage_elem {
+	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
+	struct hlist_node snode;	/* Linked to bpf_local_storage */
+	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
 	/* 8 bytes hole */
 	/* The data is stored in aother cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
-	struct bpf_sk_storage_data sdata ____cacheline_aligned;
+	struct bpf_local_storage_data sdata ____cacheline_aligned;
 };
 
-#define SELEM(_SDATA) container_of((_SDATA), struct bpf_sk_storage_elem, sdata)
+#define SELEM(_SDATA)							\
+	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_SK_STORAGE_CACHE_SIZE	16
+#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
 static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_SK_STORAGE_CACHE_SIZE];
+static u64 cache_idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
 
-struct bpf_sk_storage {
-	struct bpf_sk_storage_data __rcu *cache[BPF_SK_STORAGE_CACHE_SIZE];
-	struct hlist_head list;	/* List of bpf_sk_storage_elem */
-	struct sock *sk;	/* The sk that owns the the above "list" of
-				 * bpf_sk_storage_elem.
+struct bpf_local_storage {
+	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
+	struct hlist_head list; /* List of bpf_local_storage_elem */
+	struct sock *owner;	/* The object that owns the the above "list" of
+				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
 };
 
-static struct bucket *select_bucket(struct bpf_sk_storage_map *smap,
-				    struct bpf_sk_storage_elem *selem)
+static struct bpf_local_storage_map_bucket *
+select_bucket(struct bpf_local_storage_map *smap,
+	      struct bpf_local_storage_elem *selem)
 {
 	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
 }
@@ -111,21 +112,21 @@ static int omem_charge(struct sock *sk, unsigned int size)
 	return -ENOMEM;
 }
 
-static bool selem_linked_to_sk(const struct bpf_sk_storage_elem *selem)
+static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
 }
 
-static bool selem_linked_to_map(const struct bpf_sk_storage_elem *selem)
+static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
 }
 
-static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
-					       struct sock *sk, void *value,
-					       bool charge_omem)
+static struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
+		void *value, bool charge_omem)
 {
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_elem *selem;
 
 	if (charge_omem && omem_charge(sk, smap->elem_size))
 		return NULL;
@@ -147,85 +148,86 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
-			      struct bpf_sk_storage_elem *selem,
-			      bool uncharge_omem)
+static bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
+				     struct bpf_local_storage_elem *selem,
+				     bool uncharge_omem)
 {
-	struct bpf_sk_storage_map *smap;
-	bool free_sk_storage;
+	struct bpf_local_storage_map *smap;
+	bool free_local_storage;
 	struct sock *sk;
 
 	smap = rcu_dereference(SDATA(selem)->smap);
-	sk = sk_storage->sk;
+	sk = local_storage->owner;
 
 	/* All uncharging on sk->sk_omem_alloc must be done first.
-	 * sk may be freed once the last selem is unlinked from sk_storage.
+	 * sk may be freed once the last selem is unlinked from local_storage.
 	 */
 	if (uncharge_omem)
 		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
 
-	free_sk_storage = hlist_is_singular_node(&selem->snode,
-						 &sk_storage->list);
-	if (free_sk_storage) {
-		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
-		sk_storage->sk = NULL;
+	free_local_storage = hlist_is_singular_node(&selem->snode,
+						    &local_storage->list);
+	if (free_local_storage) {
+		atomic_sub(sizeof(struct bpf_local_storage), &sk->sk_omem_alloc);
+		local_storage->owner = NULL;
 		/* After this RCU_INIT, sk may be freed and cannot be used */
 		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
 
-		/* sk_storage is not freed now.  sk_storage->lock is
-		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
+		/* local_storage is not freed now.  local_storage->lock is
+		 * still held and raw_spin_unlock_bh(&local_storage->lock)
 		 * will be done by the caller.
 		 *
 		 * Although the unlock will be done under
 		 * rcu_read_lock(),  it is more intutivie to
-		 * read if kfree_rcu(sk_storage, rcu) is done
-		 * after the raw_spin_unlock_bh(&sk_storage->lock).
+		 * read if kfree_rcu(local_storage, rcu) is done
+		 * after the raw_spin_unlock_bh(&local_storage->lock).
 		 *
-		 * Hence, a "bool free_sk_storage" is returned
+		 * Hence, a "bool free_local_storage" is returned
 		 * to the caller which then calls the kfree_rcu()
 		 * after unlock.
 		 */
 	}
 	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) ==
+	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
 	    SDATA(selem))
-		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
+		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	kfree_rcu(selem, rcu);
 
-	return free_sk_storage;
+	return free_local_storage;
 }
 
-static void selem_unlink_sk(struct bpf_sk_storage_elem *selem)
+static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage *sk_storage;
-	bool free_sk_storage = false;
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
 
-	if (unlikely(!selem_linked_to_sk(selem)))
+	if (unlikely(!selem_linked_to_storage(selem)))
 		/* selem has already been unlinked from sk */
 		return;
 
-	sk_storage = rcu_dereference(selem->sk_storage);
-	raw_spin_lock_bh(&sk_storage->lock);
-	if (likely(selem_linked_to_sk(selem)))
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
-	raw_spin_unlock_bh(&sk_storage->lock);
+	local_storage = rcu_dereference(selem->local_storage);
+	raw_spin_lock_bh(&local_storage->lock);
+	if (likely(selem_linked_to_storage(selem)))
+		free_local_storage =
+			bpf_selem_unlink_storage(local_storage, selem, true);
+	raw_spin_unlock_bh(&local_storage->lock);
 
-	if (free_sk_storage)
-		kfree_rcu(sk_storage, rcu);
+	if (free_local_storage)
+		kfree_rcu(local_storage, rcu);
 }
 
-static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
-			    struct bpf_sk_storage_elem *selem)
+static void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
+				   struct bpf_local_storage_elem *selem)
 {
-	RCU_INIT_POINTER(selem->sk_storage, sk_storage);
-	hlist_add_head(&selem->snode, &sk_storage->list);
+	RCU_INIT_POINTER(selem->local_storage, local_storage);
+	hlist_add_head(&selem->snode, &local_storage->list);
 }
 
-static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
+static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
 
 	if (unlikely(!selem_linked_to_map(selem)))
 		/* selem has already be unlinked from smap */
@@ -239,10 +241,10 @@ static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void selem_link_map(struct bpf_sk_storage_map *smap,
-			   struct bpf_sk_storage_elem *selem)
+static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			       struct bpf_local_storage_elem *selem)
 {
-	struct bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 
 	raw_spin_lock_bh(&b->lock);
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
@@ -250,31 +252,31 @@ static void selem_link_map(struct bpf_sk_storage_map *smap,
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void selem_unlink(struct bpf_sk_storage_elem *selem)
+static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
-	/* Always unlink from map before unlinking from sk_storage
+	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
-	 * the sk_storage.
+	 * the local_storage.
 	 */
-	selem_unlink_map(selem);
-	selem_unlink_sk(selem);
+	bpf_selem_unlink_map(selem);
+	__bpf_selem_unlink_storage(selem);
 }
 
-static struct bpf_sk_storage_data *
-__sk_storage_lookup(struct bpf_sk_storage *sk_storage,
-		    struct bpf_sk_storage_map *smap,
-		    bool cacheit_lockit)
+static struct bpf_local_storage_data *
+bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
+			 struct bpf_local_storage_map *smap,
+			 bool cacheit_lockit)
 {
-	struct bpf_sk_storage_data *sdata;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_elem *selem;
 
 	/* Fast path (cache hit) */
-	sdata = rcu_dereference(sk_storage->cache[smap->cache_idx]);
+	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
 	if (sdata && rcu_access_pointer(sdata->smap) == smap)
 		return sdata;
 
 	/* Slow path (cache miss) */
-	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode)
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode)
 		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
 			break;
 
@@ -286,33 +288,33 @@ __sk_storage_lookup(struct bpf_sk_storage *sk_storage,
 		/* spinlock is needed to avoid racing with the
 		 * parallel delete.  Otherwise, publishing an already
 		 * deleted sdata to the cache will become a use-after-free
-		 * problem in the next __sk_storage_lookup().
+		 * problem in the next bpf_local_storage_lookup().
 		 */
-		raw_spin_lock_bh(&sk_storage->lock);
-		if (selem_linked_to_sk(selem))
-			rcu_assign_pointer(sk_storage->cache[smap->cache_idx],
+		raw_spin_lock_bh(&local_storage->lock);
+		if (selem_linked_to_storage(selem))
+			rcu_assign_pointer(local_storage->cache[smap->cache_idx],
 					   sdata);
-		raw_spin_unlock_bh(&sk_storage->lock);
+		raw_spin_unlock_bh(&local_storage->lock);
 	}
 
 	return sdata;
 }
 
-static struct bpf_sk_storage_data *
+static struct bpf_local_storage_data *
 sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 {
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_map *smap;
 
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		return NULL;
 
-	smap = (struct bpf_sk_storage_map *)map;
-	return __sk_storage_lookup(sk_storage, smap, cacheit_lockit);
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
-static int check_flags(const struct bpf_sk_storage_data *old_sdata,
+static int check_flags(const struct bpf_local_storage_data *old_sdata,
 		       u64 map_flags)
 {
 	if (old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
@@ -327,10 +329,10 @@ static int check_flags(const struct bpf_sk_storage_data *old_sdata,
 }
 
 static int sk_storage_alloc(struct sock *sk,
-			    struct bpf_sk_storage_map *smap,
-			    struct bpf_sk_storage_elem *first_selem)
+			    struct bpf_local_storage_map *smap,
+			    struct bpf_local_storage_elem *first_selem)
 {
-	struct bpf_sk_storage *prev_sk_storage, *sk_storage;
+	struct bpf_local_storage *prev_sk_storage, *sk_storage;
 	int err;
 
 	err = omem_charge(sk, sizeof(*sk_storage));
@@ -344,10 +346,10 @@ static int sk_storage_alloc(struct sock *sk,
 	}
 	INIT_HLIST_HEAD(&sk_storage->list);
 	raw_spin_lock_init(&sk_storage->lock);
-	sk_storage->sk = sk;
+	sk_storage->owner = sk;
 
-	__selem_link_sk(sk_storage, first_selem);
-	selem_link_map(smap, first_selem);
+	bpf_selem_link_storage(sk_storage, first_selem);
+	bpf_selem_link_map(smap, first_selem);
 	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
 	 * Hence, atomic ops is used to set sk->sk_bpf_storage
 	 * from NULL to the newly allocated sk_storage ptr.
@@ -357,10 +359,10 @@ static int sk_storage_alloc(struct sock *sk,
 	 * the sk->sk_bpf_storage, the sk_storage->lock must
 	 * be held before setting sk->sk_bpf_storage to NULL.
 	 */
-	prev_sk_storage = cmpxchg((struct bpf_sk_storage **)&sk->sk_bpf_storage,
+	prev_sk_storage = cmpxchg((struct bpf_local_storage **)&sk->sk_bpf_storage,
 				  NULL, sk_storage);
 	if (unlikely(prev_sk_storage)) {
-		selem_unlink_map(first_selem);
+		bpf_selem_unlink_map(first_selem);
 		err = -EAGAIN;
 		goto uncharge;
 
@@ -387,15 +389,14 @@ static int sk_storage_alloc(struct sock *sk,
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
-						     struct bpf_map *map,
-						     void *value,
-						     u64 map_flags)
+static struct bpf_local_storage_data *
+bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
+			 u64 map_flags)
 {
-	struct bpf_sk_storage_data *old_sdata = NULL;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -404,15 +405,15 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
 		return ERR_PTR(-EINVAL);
 
-	smap = (struct bpf_sk_storage_map *)map;
-	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage || hlist_empty(&sk_storage->list)) {
-		/* Very first elem for this sk */
+	smap = (struct bpf_local_storage_map *)map;
+	local_storage = rcu_dereference(sk->sk_bpf_storage);
+	if (!local_storage || hlist_empty(&local_storage->list)) {
+		/* Very first elem for this object */
 		err = check_flags(NULL, map_flags);
 		if (err)
 			return ERR_PTR(err);
 
-		selem = selem_alloc(smap, sk, value, true);
+		selem = bpf_selem_alloc(smap, sk, value, true);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
@@ -428,25 +429,26 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 
 	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
 		/* Hoping to find an old_sdata to do inline update
-		 * such that it can avoid taking the sk_storage->lock
+		 * such that it can avoid taking the local_storage->lock
 		 * and changing the lists.
 		 */
-		old_sdata = __sk_storage_lookup(sk_storage, smap, false);
+		old_sdata =
+			bpf_local_storage_lookup(local_storage, smap, false);
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_sk(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
 			copy_map_value_locked(map, old_sdata->data,
 					      value, false);
 			return old_sdata;
 		}
 	}
 
-	raw_spin_lock_bh(&sk_storage->lock);
+	raw_spin_lock_bh(&local_storage->lock);
 
-	/* Recheck sk_storage->list under sk_storage->lock */
-	if (unlikely(hlist_empty(&sk_storage->list))) {
-		/* A parallel del is happening and sk_storage is going
+	/* Recheck local_storage->list under local_storage->lock */
+	if (unlikely(hlist_empty(&local_storage->list))) {
+		/* A parallel del is happening and local_storage is going
 		 * away.  It has just been checked before, so very
 		 * unlikely.  Return instead of retry to keep things
 		 * simple.
@@ -455,7 +457,7 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		goto unlock_err;
 	}
 
-	old_sdata = __sk_storage_lookup(sk_storage, smap, false);
+	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
 	err = check_flags(old_sdata, map_flags);
 	if (err)
 		goto unlock_err;
@@ -466,50 +468,51 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		goto unlock;
 	}
 
-	/* sk_storage->lock is held.  Hence, we are sure
+	/* local_storage->lock is held.  Hence, we are sure
 	 * we can unlink and uncharge the old_sdata successfully
 	 * later.  Hence, instead of charging the new selem now
 	 * and then uncharge the old selem later (which may cause
 	 * a potential but unnecessary charge failure),  avoid taking
 	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during __selem_unlink_sk().
+	 * old_sdata will not be uncharged later during
+	 * bpf_selem_unlink_storage().
 	 */
-	selem = selem_alloc(smap, sk, value, !old_sdata);
+	selem = bpf_selem_alloc(smap, sk, value, !old_sdata);
 	if (!selem) {
 		err = -ENOMEM;
 		goto unlock_err;
 	}
 
 	/* First, link the new selem to the map */
-	selem_link_map(smap, selem);
+	bpf_selem_link_map(smap, selem);
 
-	/* Second, link (and publish) the new selem to sk_storage */
-	__selem_link_sk(sk_storage, selem);
+	/* Second, link (and publish) the new selem to local_storage */
+	bpf_selem_link_storage(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
-		selem_unlink_map(SELEM(old_sdata));
-		__selem_unlink_sk(sk_storage, SELEM(old_sdata), false);
+		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_storage(local_storage, SELEM(old_sdata), false);
 	}
 
 unlock:
-	raw_spin_unlock_bh(&sk_storage->lock);
+	raw_spin_unlock_bh(&local_storage->lock);
 	return SDATA(selem);
 
 unlock_err:
-	raw_spin_unlock_bh(&sk_storage->lock);
+	raw_spin_unlock_bh(&local_storage->lock);
 	return ERR_PTR(err);
 }
 
 static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	sdata = sk_storage_lookup(sk, map, false);
 	if (!sdata)
 		return -ENOENT;
 
-	selem_unlink(SELEM(sdata));
+	bpf_selem_unlink(SELEM(sdata));
 
 	return 0;
 }
@@ -521,7 +524,7 @@ static u16 cache_idx_get(void)
 
 	spin_lock(&cache_idx_lock);
 
-	for (i = 0; i < BPF_SK_STORAGE_CACHE_SIZE; i++) {
+	for (i = 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
 		if (cache_idx_usage_counts[i] < min_usage) {
 			min_usage = cache_idx_usage_counts[i];
 			res = i;
@@ -548,8 +551,8 @@ static void cache_idx_free(u16 idx)
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *sk_storage;
 	bool free_sk_storage = false;
 	struct hlist_node *n;
 
@@ -574,8 +577,9 @@ void bpf_sk_storage_free(struct sock *sk)
 		/* Always unlink from map before unlinking from
 		 * sk_storage.
 		 */
-		selem_unlink_map(selem);
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
+		bpf_selem_unlink_map(selem);
+		free_sk_storage =
+			bpf_selem_unlink_storage(sk_storage, selem, true);
 	}
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
@@ -584,14 +588,14 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
-static void bpf_sk_storage_map_free(struct bpf_map *map)
+static void bpf_local_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
 	unsigned int i;
 
-	smap = (struct bpf_sk_storage_map *)map;
+	smap = (struct bpf_local_storage_map *)map;
 
 	cache_idx_free(smap->cache_idx);
 
@@ -615,10 +619,10 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 		rcu_read_lock();
 		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
-						 struct bpf_sk_storage_elem,
-						 map_node))) {
-			selem_unlink(selem);
+		while ((selem = hlist_entry_safe(
+				rcu_dereference_raw(hlist_first_rcu(&b->list)),
+				struct bpf_local_storage_elem, map_node))) {
+			bpf_selem_unlink(selem);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
@@ -631,7 +635,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 	 *
 	 * However, the bpf_sk_storage_free() still needs to access
 	 * the smap->elem_size to do the uncharging in
-	 * __selem_unlink_sk().
+	 * bpf_selem_unlink_storage().
 	 *
 	 * Hence, wait another rcu grace period for the
 	 * bpf_sk_storage_free() to finish.
@@ -645,14 +649,15 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 /* U16_MAX is much more than enough for sk local storage
  * considering a tcp_sock is ~2k.
  */
-#define MAX_VALUE_SIZE							\
+#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				\
 	min_t(u32,							\
-	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem)), \
-	      (U16_MAX - sizeof(struct bpf_sk_storage_elem)))
+	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -			\
+	       sizeof(struct bpf_local_storage_elem)),			\
+	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
-static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
+static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
-	if (attr->map_flags & ~SK_STORAGE_CREATE_FLAG_MASK ||
+	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
 	    attr->max_entries ||
 	    attr->key_size != sizeof(int) || !attr->value_size ||
@@ -663,15 +668,15 @@ static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
 	if (!bpf_capable())
 		return -EPERM;
 
-	if (attr->value_size > MAX_VALUE_SIZE)
+	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
 
 	return 0;
 }
 
-static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
+static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
 	u64 cost;
@@ -707,7 +712,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
+	smap->elem_size = sizeof(struct bpf_local_storage_elem) + attr->value_size;
 	smap->cache_idx = cache_idx_get();
 
 	return &smap->map;
@@ -719,10 +724,10 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
-					const struct btf *btf,
-					const struct btf_type *key_type,
-					const struct btf_type *value_type)
+static int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+					   const struct btf *btf,
+					   const struct btf_type *key_type,
+					   const struct btf_type *value_type)
 {
 	u32 int_data;
 
@@ -738,7 +743,7 @@ static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
 
 static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
 	int fd, err;
 
@@ -756,14 +761,15 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 					 void *value, u64 map_flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
 	int fd, err;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
-		sdata = sk_storage_update(sock->sk, map, value, map_flags);
+		sdata = bpf_local_storage_update(sock->sk, map, value,
+						 map_flags);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -787,14 +793,14 @@ static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-static struct bpf_sk_storage_elem *
+static struct bpf_local_storage_elem *
 bpf_sk_storage_clone_elem(struct sock *newsk,
-			  struct bpf_sk_storage_map *smap,
-			  struct bpf_sk_storage_elem *selem)
+			  struct bpf_local_storage_map *smap,
+			  struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage_elem *copy_selem;
+	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = selem_alloc(smap, newsk, NULL, true);
+	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true);
 	if (!copy_selem)
 		return NULL;
 
@@ -810,9 +816,9 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 {
-	struct bpf_sk_storage *new_sk_storage = NULL;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage *new_sk_storage = NULL;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
 	int ret = 0;
 
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
@@ -824,8 +830,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		goto out;
 
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
-		struct bpf_sk_storage_elem *copy_selem;
-		struct bpf_sk_storage_map *smap;
+		struct bpf_local_storage_elem *copy_selem;
+		struct bpf_local_storage_map *smap;
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
@@ -849,8 +855,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			selem_link_map(smap, copy_selem);
-			__selem_link_sk(new_sk_storage, copy_selem);
+			bpf_selem_link_map(smap, copy_selem);
+			bpf_selem_link_storage(new_sk_storage, copy_selem);
 		} else {
 			ret = sk_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
@@ -861,7 +867,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 				goto out;
 			}
 
-			new_sk_storage = rcu_dereference(copy_selem->sk_storage);
+			new_sk_storage =
+				rcu_dereference(copy_selem->local_storage);
 		}
 		bpf_map_put(map);
 	}
@@ -879,7 +886,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	if (flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
@@ -895,7 +902,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	     *  destruction).
 	     */
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
-		sdata = sk_storage_update(sk, map, value, BPF_NOEXIST);
+		sdata = bpf_local_storage_update(sk, map, value, BPF_NOEXIST);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -922,15 +929,15 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops = {
-	.map_alloc_check = bpf_sk_storage_map_alloc_check,
-	.map_alloc = bpf_sk_storage_map_alloc,
-	.map_free = bpf_sk_storage_map_free,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = bpf_local_storage_map_alloc,
+	.map_free = bpf_local_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
 	.map_update_elem = bpf_fd_sk_storage_update_elem,
 	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
-	.map_check_btf = bpf_sk_storage_map_check_btf,
-	.map_btf_name = "bpf_sk_storage_map",
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_btf_name = "bpf_local_storage_map",
 	.map_btf_id = &sk_storage_map_btf_id,
 };
 
@@ -1022,7 +1029,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 	u32 nr_maps = 0;
 	int rem, err;
 
-	/* bpf_sk_storage_map is currently limited to CAP_SYS_ADMIN as
+	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
 	 * the map_alloc_check() side also does.
 	 */
 	if (!bpf_capable())
@@ -1072,13 +1079,13 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 }
 EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
 
-static int diag_get(struct bpf_sk_storage_data *sdata, struct sk_buff *skb)
+static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 {
 	struct nlattr *nla_stg, *nla_value;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 
 	/* It cannot exceed max nlattr's payload */
-	BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < MAX_VALUE_SIZE);
+	BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < BPF_LOCAL_STORAGE_MAX_VALUE_SIZE);
 
 	nla_stg = nla_nest_start(skb, SK_DIAG_BPF_STORAGE);
 	if (!nla_stg)
@@ -1114,9 +1121,9 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 {
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -1169,8 +1176,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 {
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_data *sdata;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -1197,8 +1204,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 	saved_len = skb->len;
 	for (i = 0; i < diag->nr_maps; i++) {
-		sdata = __sk_storage_lookup(sk_storage,
-				(struct bpf_sk_storage_map *)diag->maps[i],
+		sdata = bpf_local_storage_lookup(sk_storage,
+				(struct bpf_local_storage_map *)diag->maps[i],
 				false);
 
 		if (!sdata)
@@ -1235,19 +1242,19 @@ struct bpf_iter_seq_sk_storage_map_info {
 	unsigned skip_elems;
 };
 
-static struct bpf_sk_storage_elem *
+static struct bpf_local_storage_elem *
 bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
-				 struct bpf_sk_storage_elem *prev_selem)
+				 struct bpf_local_storage_elem *prev_selem)
 {
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
 	u32 skip_elems = info->skip_elems;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 	u32 bucket_id = info->bucket_id;
 	u32 i, count, n_buckets;
-	struct bucket *b;
+	struct bpf_local_storage_map_bucket *b;
 
-	smap = (struct bpf_sk_storage_map *)info->map;
+	smap = (struct bpf_local_storage_map *)info->map;
 	n_buckets = 1U << smap->bucket_log;
 	if (bucket_id >= n_buckets)
 		return NULL;
@@ -1257,7 +1264,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 	count = 0;
 	while (selem) {
 		selem = hlist_entry_safe(selem->map_node.next,
-					 struct bpf_sk_storage_elem, map_node);
+					 struct bpf_local_storage_elem, map_node);
 		if (!selem) {
 			/* not found, unlock and go to the next bucket */
 			b = &smap->buckets[bucket_id++];
@@ -1265,7 +1272,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 			skip_elems = 0;
 			break;
 		}
-		sk_storage = rcu_dereference_raw(selem->sk_storage);
+		sk_storage = rcu_dereference_raw(selem->local_storage);
 		if (sk_storage) {
 			info->skip_elems = skip_elems + count;
 			return selem;
@@ -1278,7 +1285,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 		raw_spin_lock_bh(&b->lock);
 		count = 0;
 		hlist_for_each_entry(selem, &b->list, map_node) {
-			sk_storage = rcu_dereference_raw(selem->sk_storage);
+			sk_storage = rcu_dereference_raw(selem->local_storage);
 			if (sk_storage && count >= skip_elems) {
 				info->bucket_id = i;
 				info->skip_elems = count;
@@ -1297,7 +1304,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 
 static void *bpf_sk_storage_map_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_elem *selem;
 
 	selem = bpf_sk_storage_map_seq_find_next(seq->private, NULL);
 	if (!selem)
@@ -1330,11 +1337,11 @@ DEFINE_BPF_ITER_FUNC(bpf_sk_storage_map, struct bpf_iter_meta *meta,
 		     void *value)
 
 static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
-					 struct bpf_sk_storage_elem *selem)
+					 struct bpf_local_storage_elem *selem)
 {
 	struct bpf_iter_seq_sk_storage_map_info *info = seq->private;
 	struct bpf_iter__bpf_sk_storage_map ctx = {};
-	struct bpf_sk_storage *sk_storage;
+	struct bpf_local_storage *sk_storage;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int ret = 0;
@@ -1345,8 +1352,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.meta = &meta;
 		ctx.map = info->map;
 		if (selem) {
-			sk_storage = rcu_dereference_raw(selem->sk_storage);
-			ctx.sk = sk_storage->sk;
+			sk_storage = rcu_dereference_raw(selem->local_storage);
+			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
 		ret = bpf_iter_run_prog(prog, &ctx);
@@ -1363,13 +1370,13 @@ static int bpf_sk_storage_map_seq_show(struct seq_file *seq, void *v)
 static void bpf_sk_storage_map_seq_stop(struct seq_file *seq, void *v)
 {
 	struct bpf_iter_seq_sk_storage_map_info *info = seq->private;
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
 
 	if (!v) {
 		(void)__bpf_sk_storage_map_seq_show(seq, v);
 	} else {
-		smap = (struct bpf_sk_storage_map *)info->map;
+		smap = (struct bpf_local_storage_map *)info->map;
 		b = &smap->buckets[info->bucket_id];
 		raw_spin_unlock_bh(&b->lock);
 	}
-- 
2.28.0.rc0.142.g3c755180ce-goog

