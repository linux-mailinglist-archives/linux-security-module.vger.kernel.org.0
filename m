Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84DE7D6E55
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Oct 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjJYOEL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Oct 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjJYODu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257919D
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqU5OFpUfnWoX0zEapwC2eTdGB2uJF4AL25ESnXjaJg=;
        b=YMmo9E7NoTDbNSP0bNZNmrggXL+5KkQUJb2mgyXqPpIP2raLcJNk2ZHUEufsXiFbutgIhX
        oS8v1IBj24jDhNUxPIaLcxZfr795//FS3IqwV8O25qHvQm5KqCkZR+Qa9J6UD0z/zGo5tg
        +xEXHcb6aPPBl+Fj7p3lrMJfYKFU8l0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-nE7PjPi-OYSDXPVoXbwD4g-1; Wed, 25 Oct 2023 10:02:12 -0400
X-MC-Unique: nE7PjPi-OYSDXPVoXbwD4g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c15543088aso101220766b.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242531; x=1698847331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqU5OFpUfnWoX0zEapwC2eTdGB2uJF4AL25ESnXjaJg=;
        b=pI7XxMMkH05FqqXFFZnjci/8jf3H9rubPNHGRMvaCk1wrLPMqB1hzW1C32zzwqkfpm
         U1ih1virg2JSgTKDkpIsJXkIZlos7nncpeg0CFCDF5FKZQQloqsx+GFnl9LCGQGYfAnk
         E0IQty9Hfwh/SOsDa/MUy9zZYuCe9QJI6GpyizbOuCE3HivN9RbgTUTxpGL4LsKxhlv6
         d7Xy45kYyAKad5KdrVQnGEHMrb4kr/6AeOckRI307aOLS5XuIH+nUzEKe1Eyt9JGxfCM
         3QiF3Rt4THd043/ENMKj5My7J84z9La413EqMsYf/y4VLknt1Pmx75h8sF1gu9FwHBx6
         uDHg==
X-Gm-Message-State: AOJu0YxcjK4hARaRo7GYBY6zLszhsKf690LbYmwfg+o0m51TiDTwXQDN
        rtFfK0957g7t5VxWQxIoYjnLsCFSdHx3dbIujMDcQXN8QKUpUxh1YhKK1CNmC6lq9X+rKxveUD1
        AH58iBXtJ9CkAoY/aMWu4eNLS1MfV7Mku5/Cj
X-Received: by 2002:a17:907:7e8b:b0:9a9:fa4a:5a4e with SMTP id qb11-20020a1709077e8b00b009a9fa4a5a4emr17952676ejc.13.1698242530681;
        Wed, 25 Oct 2023 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbrxV78iGRyEXr71q2p/3MfdOAn7enEaIs3/+ho4rI94gfuZM96AuUtMY9RGXlfJnr6Bb2PA==
X-Received: by 2002:a17:907:7e8b:b0:9a9:fa4a:5a4e with SMTP id qb11-20020a1709077e8b00b009a9fa4a5a4emr17952652ejc.13.1698242530313;
        Wed, 25 Oct 2023 07:02:10 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:09 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
Date:   Wed, 25 Oct 2023 16:02:00 +0200
Message-ID: <20231025140205.3586473-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When adding a mount to a namespace insert it into an rbtree rooted in the
mnt_namespace instead of a linear list.

The mnt.mnt_list is still used to set up the mount tree and for
propagation, but not after the mount has been added to a namespace.  Hence
mnt_list can live in union with rb_node.  Use MNT_ONRB mount flag to
validate that the mount is on the correct list.

This allows removing the cursor used for reading /proc/$PID/mountinfo.  The
mnt_id_unique of the next mount can be used as an index into the seq file.

Tested by inserting 100k bind mounts, unsharing the mount namespace, and
unmounting.  No performance regressions have been observed.

For the last mount in the 100k list the statmount() call was more than 100x
faster due to the mount ID lookup not having to do a linear search.  This
patch makes the overhead of mount ID lookup non-observable in this range.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h            |  24 +++---
 fs/namespace.c        | 190 ++++++++++++++++++++----------------------
 fs/pnode.c            |   2 +-
 fs/proc_namespace.c   |   3 -
 include/linux/mount.h |   5 +-
 5 files changed, 106 insertions(+), 118 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index a14f762b3f29..4a42fc68f4cc 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -8,19 +8,13 @@
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
-	/*
-	 * Traversal and modification of .list is protected by either
-	 * - taking namespace_sem for write, OR
-	 * - taking namespace_sem for read AND taking .ns_lock.
-	 */
-	struct list_head	list;
-	spinlock_t		ns_lock;
+	struct rb_root		mounts; /* Protected by namespace_sem */
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	u64			seq;	/* Sequence number to prevent loops */
 	wait_queue_head_t poll;
 	u64 event;
-	unsigned int		mounts; /* # of mounts in the namespace */
+	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 } __randomize_layout;
 
@@ -55,7 +49,10 @@ struct mount {
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
-	struct list_head mnt_list;
+	union {
+		struct rb_node mnt_node;	/* Under ns->mounts */
+		struct list_head mnt_list;
+	};
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct list_head mnt_share;	/* circular list of shared mounts */
 	struct list_head mnt_slave_list;/* list of slave mounts */
@@ -128,7 +125,6 @@ struct proc_mounts {
 	struct mnt_namespace *ns;
 	struct path root;
 	int (*show)(struct seq_file *, struct vfsmount *);
-	struct mount cursor;
 };
 
 extern const struct seq_operations mounts_op;
@@ -147,4 +143,12 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
+static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
+{
+	WARN_ON(!(mnt->mnt.mnt_flags & MNT_ONRB));
+	mnt->mnt.mnt_flags &= ~MNT_ONRB;
+	rb_erase(&mnt->mnt_node, &mnt->mnt_ns->mounts);
+	list_add_tail(&mnt->mnt_list, dt_list);
+}
+
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
diff --git a/fs/namespace.c b/fs/namespace.c
index e02bc5f41c7b..0eab47ffc76c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -732,21 +732,6 @@ struct vfsmount *lookup_mnt(const struct path *path)
 	return m;
 }
 
-static inline void lock_ns_list(struct mnt_namespace *ns)
-{
-	spin_lock(&ns->ns_lock);
-}
-
-static inline void unlock_ns_list(struct mnt_namespace *ns)
-{
-	spin_unlock(&ns->ns_lock);
-}
-
-static inline bool mnt_is_cursor(struct mount *mnt)
-{
-	return mnt->mnt.mnt_flags & MNT_CURSOR;
-}
-
 /*
  * __is_local_mountpoint - Test to see if dentry is a mountpoint in the
  *                         current mount namespace.
@@ -765,19 +750,15 @@ static inline bool mnt_is_cursor(struct mount *mnt)
 bool __is_local_mountpoint(struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
-	struct mount *mnt;
+	struct mount *mnt, *n;
 	bool is_covered = false;
 
 	down_read(&namespace_sem);
-	lock_ns_list(ns);
-	list_for_each_entry(mnt, &ns->list, mnt_list) {
-		if (mnt_is_cursor(mnt))
-			continue;
+	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
 		is_covered = (mnt->mnt_mountpoint == dentry);
 		if (is_covered)
 			break;
 	}
-	unlock_ns_list(ns);
 	up_read(&namespace_sem);
 
 	return is_covered;
@@ -1024,6 +1005,30 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	mnt_add_count(old_parent, -1);
 }
 
+static inline struct mount *node_to_mount(struct rb_node *node)
+{
+	return rb_entry(node, struct mount, mnt_node);
+}
+
+static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
+{
+	struct rb_node **link = &ns->mounts.rb_node;
+	struct rb_node *parent = NULL;
+
+	WARN_ON(mnt->mnt.mnt_flags & MNT_ONRB);
+	mnt->mnt_ns = ns;
+	while (*link) {
+		parent = *link;
+		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique)
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+	rb_link_node(&mnt->mnt_node, parent, link);
+	rb_insert_color(&mnt->mnt_node, &ns->mounts);
+	mnt->mnt.mnt_flags |= MNT_ONRB;
+}
+
 /*
  * vfsmount lock must be held for write
  */
@@ -1037,12 +1042,13 @@ static void commit_tree(struct mount *mnt)
 	BUG_ON(parent == mnt);
 
 	list_add_tail(&head, &mnt->mnt_list);
-	list_for_each_entry(m, &head, mnt_list)
-		m->mnt_ns = n;
+	while (!list_empty(&head)) {
+		m = list_first_entry(&head, typeof(*m), mnt_list);
+		list_del(&m->mnt_list);
 
-	list_splice(&head, n->list.prev);
-
-	n->mounts += n->pending_mounts;
+		mnt_add_to_ns(n, m);
+	}
+	n->nr_mounts += n->pending_mounts;
 	n->pending_mounts = 0;
 
 	__attach_mnt(mnt, parent);
@@ -1190,7 +1196,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_ONRB);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1415,65 +1421,57 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
 	return &p->mnt;
 }
 
-#ifdef CONFIG_PROC_FS
-static struct mount *mnt_list_next(struct mnt_namespace *ns,
-				   struct list_head *p)
+/*
+ * Returns the mount which either has the specified mnt_id, or has the next
+ * smallest id afer the specified one.
+ */
+static struct mount *mnt_find_id_at(struct mnt_namespace *ns, u64 mnt_id)
 {
-	struct mount *mnt, *ret = NULL;
+	struct rb_node *node = ns->mounts.rb_node;
+	struct mount *ret = NULL;
 
-	lock_ns_list(ns);
-	list_for_each_continue(p, &ns->list) {
-		mnt = list_entry(p, typeof(*mnt), mnt_list);
-		if (!mnt_is_cursor(mnt)) {
-			ret = mnt;
-			break;
+	while (node) {
+		struct mount *m = node_to_mount(node);
+
+		if (mnt_id <= m->mnt_id_unique) {
+			ret = node_to_mount(node);
+			if (mnt_id == m->mnt_id_unique)
+				break;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
 		}
 	}
-	unlock_ns_list(ns);
-
 	return ret;
 }
 
+#ifdef CONFIG_PROC_FS
+
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
-	struct list_head *prev;
 
 	down_read(&namespace_sem);
-	if (!*pos) {
-		prev = &p->ns->list;
-	} else {
-		prev = &p->cursor.mnt_list;
 
-		/* Read after we'd reached the end? */
-		if (list_empty(prev))
-			return NULL;
-	}
-
-	return mnt_list_next(p->ns, prev);
+	return mnt_find_id_at(p->ns, *pos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct proc_mounts *p = m->private;
-	struct mount *mnt = v;
+	struct mount *next = NULL, *mnt = v;
+	struct rb_node *node = rb_next(&mnt->mnt_node);
 
 	++*pos;
-	return mnt_list_next(p->ns, &mnt->mnt_list);
+	if (node) {
+		next = node_to_mount(node);
+		*pos = next->mnt_id_unique;
+	}
+	return next;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct proc_mounts *p = m->private;
-	struct mount *mnt = v;
-
-	lock_ns_list(p->ns);
-	if (mnt)
-		list_move_tail(&p->cursor.mnt_list, &mnt->mnt_list);
-	else
-		list_del_init(&p->cursor.mnt_list);
-	unlock_ns_list(p->ns);
 	up_read(&namespace_sem);
 }
 
@@ -1491,14 +1489,6 @@ const struct seq_operations mounts_op = {
 	.show	= m_show,
 };
 
-void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
-{
-	down_read(&namespace_sem);
-	lock_ns_list(ns);
-	list_del(&cursor->mnt_list);
-	unlock_ns_list(ns);
-	up_read(&namespace_sem);
-}
 #endif  /* CONFIG_PROC_FS */
 
 /**
@@ -1640,7 +1630,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	/* Gather the mounts to umount */
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		p->mnt.mnt_flags |= MNT_UMOUNT;
-		list_move(&p->mnt_list, &tmp_list);
+		if (p->mnt.mnt_flags & MNT_ONRB)
+			move_from_ns(p, &tmp_list);
+		else
+			list_move(&p->mnt_list, &tmp_list);
 	}
 
 	/* Hide the mounts from mnt_mounts */
@@ -1660,7 +1653,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		list_del_init(&p->mnt_list);
 		ns = p->mnt_ns;
 		if (ns) {
-			ns->mounts--;
+			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
 		}
 		p->mnt_ns = NULL;
@@ -1786,14 +1779,16 @@ static int do_umount(struct mount *mnt, int flags)
 
 	event++;
 	if (flags & MNT_DETACH) {
-		if (!list_empty(&mnt->mnt_list))
+		if (mnt->mnt.mnt_flags & MNT_ONRB ||
+		    !list_empty(&mnt->mnt_list))
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
-			if (!list_empty(&mnt->mnt_list))
+			if (mnt->mnt.mnt_flags & MNT_ONRB ||
+			    !list_empty(&mnt->mnt_list))
 				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 			retval = 0;
 		}
@@ -2211,9 +2206,9 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 	unsigned int mounts = 0;
 	struct mount *p;
 
-	if (ns->mounts >= max)
+	if (ns->nr_mounts >= max)
 		return -ENOSPC;
-	max -= ns->mounts;
+	max -= ns->nr_mounts;
 	if (ns->pending_mounts >= max)
 		return -ENOSPC;
 	max -= ns->pending_mounts;
@@ -2357,8 +2352,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
+			LIST_HEAD(head);
+
 			/* move from anon - the caller will destroy */
-			list_del_init(&source_mnt->mnt_ns->list);
+			for (p = source_mnt; p; p = next_mnt(p, source_mnt))
+				move_from_ns(p, &head);
+			list_del_init(&head);
 		}
 		if (beneath)
 			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
@@ -2669,11 +2668,10 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 
 	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		p->mnt_ns = ns;
-		ns->mounts++;
+		mnt_add_to_ns(ns, p);
+		ns->nr_mounts++;
 	}
 	ns->root = mnt;
-	list_add_tail(&ns->list, &mnt->mnt_list);
 	mntget(&mnt->mnt);
 	unlock_mount_hash();
 	namespace_unlock();
@@ -3736,9 +3734,8 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	if (!anon)
 		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
 	refcount_set(&new_ns->ns.count, 1);
-	INIT_LIST_HEAD(&new_ns->list);
+	new_ns->mounts = RB_ROOT;
 	init_waitqueue_head(&new_ns->poll);
-	spin_lock_init(&new_ns->ns_lock);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3785,7 +3782,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		unlock_mount_hash();
 	}
 	new_ns->root = new;
-	list_add_tail(&new_ns->list, &new->mnt_list);
 
 	/*
 	 * Second pass: switch the tsk->fs->* elements and mark new vfsmounts
@@ -3795,8 +3791,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	p = old;
 	q = new;
 	while (p) {
-		q->mnt_ns = new_ns;
-		new_ns->mounts++;
+		mnt_add_to_ns(new_ns, q);
+		new_ns->nr_mounts++;
 		if (new_fs) {
 			if (&p->mnt == new_fs->root.mnt) {
 				new_fs->root.mnt = mntget(&q->mnt);
@@ -3838,10 +3834,9 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 		mntput(m);
 		return ERR_CAST(ns);
 	}
-	mnt->mnt_ns = ns;
 	ns->root = mnt;
-	ns->mounts++;
-	list_add(&mnt->mnt_list, &ns->list);
+	ns->nr_mounts++;
+	mnt_add_to_ns(ns, mnt);
 
 	err = vfs_path_lookup(m->mnt_root, m,
 			name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
@@ -4019,10 +4014,9 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		goto err_path;
 	}
 	mnt = real_mount(newmount.mnt);
-	mnt->mnt_ns = ns;
 	ns->root = mnt;
-	ns->mounts = 1;
-	list_add(&mnt->mnt_list, &ns->list);
+	ns->nr_mounts = 1;
+	mnt_add_to_ns(ns, mnt);
 	mntget(newmount.mnt);
 
 	/* Attach to an apparent O_PATH fd with a note that we need to unmount
@@ -4693,10 +4687,9 @@ static void __init init_mount_tree(void)
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
 	m = real_mount(mnt);
-	m->mnt_ns = ns;
 	ns->root = m;
-	ns->mounts = 1;
-	list_add(&m->mnt_list, &ns->list);
+	ns->nr_mounts = 1;
+	mnt_add_to_ns(ns, m);
 	init_task.nsproxy->mnt_ns = ns;
 	get_mnt_ns(ns);
 
@@ -4823,18 +4816,14 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 				int *new_mnt_flags)
 {
 	int new_flags = *new_mnt_flags;
-	struct mount *mnt;
+	struct mount *mnt, *n;
 	bool visible = false;
 
 	down_read(&namespace_sem);
-	lock_ns_list(ns);
-	list_for_each_entry(mnt, &ns->list, mnt_list) {
+	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
 		struct mount *child;
 		int mnt_flags;
 
-		if (mnt_is_cursor(mnt))
-			continue;
-
 		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
@@ -4882,7 +4871,6 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 	next:	;
 	}
 found:
-	unlock_ns_list(ns);
 	up_read(&namespace_sem);
 	return visible;
 }
diff --git a/fs/pnode.c b/fs/pnode.c
index e4d0340393d5..a799e0315cc9 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -468,7 +468,7 @@ static void umount_one(struct mount *mnt, struct list_head *to_umount)
 	mnt->mnt.mnt_flags |= MNT_UMOUNT;
 	list_del_init(&mnt->mnt_child);
 	list_del_init(&mnt->mnt_umounting);
-	list_move_tail(&mnt->mnt_list, to_umount);
+	move_from_ns(mnt, to_umount);
 }
 
 /*
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 250eb5bf7b52..73d2274d5f59 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -283,8 +283,6 @@ static int mounts_open_common(struct inode *inode, struct file *file,
 	p->ns = ns;
 	p->root = root;
 	p->show = show;
-	INIT_LIST_HEAD(&p->cursor.mnt_list);
-	p->cursor.mnt.mnt_flags = MNT_CURSOR;
 
 	return 0;
 
@@ -301,7 +299,6 @@ static int mounts_release(struct inode *inode, struct file *file)
 	struct seq_file *m = file->private_data;
 	struct proc_mounts *p = m->private;
 	path_put(&p->root);
-	mnt_cursor_del(p->ns, &p->cursor);
 	put_mnt_ns(p->ns);
 	return seq_release_private(inode, file);
 }
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 4f40b40306d0..7952eddc835c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -50,8 +50,7 @@ struct path;
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
-			    MNT_CURSOR)
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | MNT_ONRB)
 
 #define MNT_INTERNAL	0x4000
 
@@ -65,7 +64,7 @@ struct path;
 #define MNT_SYNC_UMOUNT		0x2000000
 #define MNT_MARKED		0x4000000
 #define MNT_UMOUNT		0x8000000
-#define MNT_CURSOR		0x10000000
+#define MNT_ONRB		0x10000000
 
 struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
-- 
2.41.0

