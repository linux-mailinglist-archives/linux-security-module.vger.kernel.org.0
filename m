Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C546FFF2
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Dec 2021 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhLJLga (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 Dec 2021 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhLJLg3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 06:36:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD9C061746;
        Fri, 10 Dec 2021 03:32:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C686B827CA;
        Fri, 10 Dec 2021 11:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FBBC00446;
        Fri, 10 Dec 2021 11:32:47 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:32:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
Message-ID: <20211210113244.odv2ibrifz2jzft5@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
 <20211209191109.o3x7nynnm52zhygz@wittgenstein>
 <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 09, 2021 at 07:57:02PM -0500, Stefan Berger wrote:
> 
> On 12/9/21 14:11, Christian Brauner wrote:
> > 
> >  From 1f03dc427c583d5e9ebc9ebe9de77c3c535bbebe Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > Date: Thu, 9 Dec 2021 20:07:02 +0100
> > Subject: [PATCH] !!!! HERE BE DRAGONS - UNTESTED !!!!
> > 
> > ---
> >   security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++----
> >   1 file changed, 38 insertions(+), 5 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > index 583462b29cb5..d5b302b925b8 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -317,10 +317,14 @@ static ssize_t ima_read_policy(char *path)
> >   static ssize_t ima_write_policy(struct file *file, const char __user *buf,
> >   				size_t datalen, loff_t *ppos)
> >   {
> > -	struct ima_namespace *ns = get_current_ns();
> > +	struct ima_namespace *ns;
> > +	struct user_namespace *user_ns;
> >   	char *data;
> >   	ssize_t result;
> > +	user_ns = ima_filp_private(filp);
> > +	ns = user_ns->ima_ns
> > +
> >   	if (datalen >= PAGE_SIZE)
> >   		datalen = PAGE_SIZE - 1;
> > @@ -373,26 +377,51 @@ static const struct seq_operations ima_policy_seqops = {
> >   };
> >   #endif
> > +static struct user_namespace *ima_filp_private(struct file *filp)
> > +{
> > +	if (!(filp->f_flags & O_WRONLY)) {
> > +#ifdef CONFIG_IMA_READ_POLICY
> > +		struct seq_file *seq;
> > +
> > +		seq = filp->private_data;
> > +		return seq->private;
> > +#endif
> > +	}
> > +	return filp->private_data;
> > +}
> > +
> >   /*
> >    * ima_open_policy: sequentialize access to the policy file
> >    */
> >   static int ima_open_policy(struct inode *inode, struct file *filp)
> >   {
> > -	struct ima_namespace *ns = get_current_ns();
> > +	struct user_namespace *user_ns = current_user_ns();
> 
> 
> Do we have to take a reference on the user namespace assuming one can open
> the file, pass the fd down the hierarchy, and then the user namespace with
> the opened file goes away? Or is there anything else that keeps the user
> namespace alive?

No, we don't. When ima_policy_open() is called we do current_user_ns()
but that will be guaranteed to be identical to filp->f_cred->user_ns.
And f_cred is a reference that has been taken when the vfs allocated a
struct file for this .open call so won't go away until the last fput.

My proposal is also too complicated, I think.
(The booster is giving me the same side-effects as my second shot so
this looks like two good days of fever and headache. So I'll use that as
an excuse. :))

Your patch series as it stands has a bit of a security issue with those
get_current_ns() calls across differnet file/seq_file operations.

You have to make an architectural decision, I think. I see two sensible
options:
1. The relevant ima_ns that .open/.read/.write operate on is always taken
   to be the ima_ns of the filesystem's userns, i.e.
   sb->s_user_ns->ima_ns.
   This - but I'm not an ima person - makes the most sense to me and the
   semantics are straightforward. If I write to a file to alter some
   policy then I expect the ima namespace of the user namespace to be
   affected that the securityfs instance was mounted in.
2. The relevant ima_ns that .open/.read/.write operate on is always
   taken to be the one of the opener. I don't really like that as that
   gets weird if for some complicated reason the caller is not located
   in the userns the filesystem was mounted in (weird mount propagation
   scenario or sm). It also feels strange to operate on an ima_ns that's
   different from s_user_ns->ima_ns in a securityfs instance.

So I think I would propose you do sm:

From 6c8018f14f22e7bc2255dcebab96f9b8c39a8459 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 10 Dec 2021 10:31:27 +0100
Subject: [PATCH 1/2] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!

The relevant ima_ns that .open/.read/.write operate on is always taken to be
the ima_ns of the filesystem's userns, i.e.  sb->s_user_ns->ima_ns. This - but
I'm not an ima person - makes the most sense to me and the semantics are
straightforward. If I write to a file to alter some policy then I expect the
ima namespace of the user namespace to be affected that the securityfs instance
was mounted in.
---
 security/integrity/ima/ima_fs.c     | 30 ++++++++++++++++++-----------
 security/integrity/ima/ima_policy.c |  8 ++++++--
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 778983fd9a73..95b7b9ec2a76 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -49,7 +49,8 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.violations);
 }
@@ -63,7 +64,8 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
@@ -76,7 +78,9 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	const struct file *filp = m->file;
+	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -94,7 +98,9 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	const struct file *filp = m->file;
+	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -273,9 +279,8 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 {
-	struct ima_namespace *ns = get_current_ns();
 	void *data = NULL;
 	char *datap;
 	size_t size;
@@ -317,7 +322,8 @@ static ssize_t ima_read_policy(char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = file->f_path.mnt->mnt_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 	char *data;
 	ssize_t result;
 
@@ -340,7 +346,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_policy(ns, data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
@@ -378,7 +384,8 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = inode->i_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -386,7 +393,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!mac_admin_ns_capable(ns->user_ns))
+		if (!mac_admin_ns_capable(user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
@@ -405,7 +412,8 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = inode->i_sb->s_user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 747dca6131d6..41e5f17ec44d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1908,7 +1908,9 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	const struct file *filp = m->file;
+	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1928,7 +1930,9 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct ima_rule_entry *entry = v;
-	struct ima_namespace *ns = get_current_ns();
+	const struct file *filp = m->file;
+	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->user_ns;
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	rcu_read_lock();
 	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
-- 
2.30.2

From ecf25d6b2b5895005d4103169bdb55d970e7a865 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 10 Dec 2021 11:56:25 +0100
Subject: [PATCH 2/2] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!

securityfs: don't allow mounting from outside the filesystem's userns

If we ever need to allow that we should revisit the semantics.
---
 security/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index eaccba7017d9..71f9634228f3 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -43,7 +43,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
 	struct user_namespace *ns = fc->user_ns;
-	int error;
+	int error = -EINVAL;
+
+	if (WARN_ON(ns != current_user_ns()))
+		return error;
 
 	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
 	if (error)
-- 
2.30.2

