Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD91D790F
	for <lists+linux-security-module@lfdr.de>; Mon, 18 May 2020 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgERM5A (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 May 2020 08:57:00 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:35572 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgERM47 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 08:56:59 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 0BEDD20479;
        Mon, 18 May 2020 12:56:52 +0000 (UTC)
Date:   Mon, 18 May 2020 14:56:48 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-next@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] proc: proc_pid_ns takes super_block as an argument
Message-ID: <20200518125648.robgr7mud7esao2o@comp-core-i7-2640m-0182e6>
References: <87lfltcbc4.fsf@x220.int.ebiederm.org>
 <20200518111716.2896385-1-gladkov.alexey@gmail.com>
 <871rnh78di.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rnh78di.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Mon, 18 May 2020 12:56:56 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 18, 2020 at 07:08:57AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > The proc_pid_ns() can be used for both inode and dentry. To avoid making
> > two identical functions, change the argument type of the proc_pid_ns().
> >
> > Link: https://lore.kernel.org/lkml/c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp/
> > Reported-by: syzbot+c1af344512918c61362c@syzkaller.appspotmail.com
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> 
> So overall this looks good.
> 
> However, the description leaves a little bit to be desired as it does
> not describe why it is bad to use dentry->d_sb.  A fixes tag would be
> nice if for no other reason than to help anyone who decides to backport
> this.

OK. I will add it.

> And can you please compile test this?
> 
> There is a very silly typo in proc that keeps this from compiling.

I compiled the kernel with this patch and ran the kernel, but accidentally
did not check children_seq_show(). Sorry.

> Thank you,
> Eric
> 
> > ---
> >  fs/locks.c                 |  4 ++--
> >  fs/proc/array.c            |  2 +-
> >  fs/proc/base.c             | 10 +++++-----
> >  fs/proc/self.c             |  2 +-
> >  fs/proc/thread_self.c      |  2 +-
> >  include/linux/proc_fs.h    |  4 ++--
> >  kernel/fork.c              |  2 +-
> >  net/ipv6/ip6_flowlabel.c   |  2 +-
> >  security/tomoyo/realpath.c |  2 +-
> >  9 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 399c5dbb72c4..ab702d6efb55 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2823,7 +2823,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> >  {
> >  	struct inode *inode = NULL;
> >  	unsigned int fl_pid;
> > -	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
> > +	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
> >  
> >  	fl_pid = locks_translate_pid(fl, proc_pidns);
> >  	/*
> > @@ -2901,7 +2901,7 @@ static int locks_show(struct seq_file *f, void *v)
> >  {
> >  	struct locks_iterator *iter = f->private;
> >  	struct file_lock *fl, *bfl;
> > -	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
> > +	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
> >  
> >  	fl = hlist_entry(v, struct file_lock, fl_link);
> >  
> > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > index 8e16f14bb05a..a4d4763731e0 100644
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -728,7 +728,7 @@ static int children_seq_show(struct seq_file *seq, void *v)
> >  {
> >  	struct inode *inode = file_inode(seq->file);
> >  
> > -	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(inode)));
> > +	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(inode)->i_sb));
> >  	return 0;
> >  }
> >  
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 5a307b3bb2d1..30c9fceca0b7 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -754,7 +754,7 @@ static const struct inode_operations proc_def_inode_operations = {
> >  static int proc_single_show(struct seq_file *m, void *v)
> >  {
> >  	struct inode *inode = m->private;
> > -	struct pid_namespace *ns = proc_pid_ns(inode);
> > +	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
> >  	struct pid *pid = proc_pid(inode);
> >  	struct task_struct *task;
> >  	int ret;
> > @@ -1423,7 +1423,7 @@ static const struct file_operations proc_fail_nth_operations = {
> >  static int sched_show(struct seq_file *m, void *v)
> >  {
> >  	struct inode *inode = m->private;
> > -	struct pid_namespace *ns = proc_pid_ns(inode);
> > +	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
> >  	struct task_struct *p;
> >  
> >  	p = get_proc_task(inode);
> > @@ -2466,7 +2466,7 @@ static int proc_timers_open(struct inode *inode, struct file *file)
> >  		return -ENOMEM;
> >  
> >  	tp->pid = proc_pid(inode);
> > -	tp->ns = proc_pid_ns(inode);
> > +	tp->ns = proc_pid_ns(inode->i_sb);
> >  	return 0;
> >  }
> >  
> > @@ -3377,7 +3377,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
> >  {
> >  	struct tgid_iter iter;
> >  	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
> > -	struct pid_namespace *ns = proc_pid_ns(file_inode(file));
> > +	struct pid_namespace *ns = proc_pid_ns(file_inode(file)->i_sb);
> >  	loff_t pos = ctx->pos;
> >  
> >  	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
> > @@ -3730,7 +3730,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> >  	/* f_version caches the tgid value that the last readdir call couldn't
> >  	 * return. lseek aka telldir automagically resets f_version to 0.
> >  	 */
> > -	ns = proc_pid_ns(inode);
> > +	ns = proc_pid_ns(inode->i_sb);
> >  	tid = (int)file->f_version;
> >  	file->f_version = 0;
> >  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
> > diff --git a/fs/proc/self.c b/fs/proc/self.c
> > index 309301ac0136..ca5158fa561c 100644
> > --- a/fs/proc/self.c
> > +++ b/fs/proc/self.c
> > @@ -12,7 +12,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
> >  				      struct inode *inode,
> >  				      struct delayed_call *done)
> >  {
> > -	struct pid_namespace *ns = proc_pid_ns(inode);
> > +	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
> >  	pid_t tgid = task_tgid_nr_ns(current, ns);
> >  	char *name;
> >  
> > diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> > index 2493cbbdfa6f..ac284f409568 100644
> > --- a/fs/proc/thread_self.c
> > +++ b/fs/proc/thread_self.c
> > @@ -12,7 +12,7 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
> >  					     struct inode *inode,
> >  					     struct delayed_call *done)
> >  {
> > -	struct pid_namespace *ns = proc_pid_ns(inode);
> > +	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
> >  	pid_t tgid = task_tgid_nr_ns(current, ns);
> >  	pid_t pid = task_pid_nr_ns(current, ns);
> >  	char *name;
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index 2cb424e6f36a..6ec524d8842c 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -202,9 +202,9 @@ int open_related_ns(struct ns_common *ns,
> >  		   struct ns_common *(*get_ns)(struct ns_common *ns));
> >  
> >  /* get the associated pid namespace for a file in procfs */
> > -static inline struct pid_namespace *proc_pid_ns(const struct inode *inode)
> > +static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
> >  {
> > -	return proc_sb_info(inode->i_sb)->pid_ns;
> > +	return proc_sb_info(sb)->pid_ns;
> >  }
> >  
> >  #endif /* _LINUX_PROC_FS_H */
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 4385f3d639f2..e7bdaccad942 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1745,7 +1745,7 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
> >  	pid_t nr = -1;
> >  
> >  	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
> > -		ns = proc_pid_ns(file_inode(m->file));
> > +		ns = proc_pid_ns(file_inode(m->file)->i_sb);
> >  		nr = pid_nr_ns(pid, ns);
> >  	}
> >  
> > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > index d64b83e85642..ce4fbba4acce 100644
> > --- a/net/ipv6/ip6_flowlabel.c
> > +++ b/net/ipv6/ip6_flowlabel.c
> > @@ -779,7 +779,7 @@ static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
> >  {
> >  	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
> >  
> > -	state->pid_ns = proc_pid_ns(file_inode(seq->file));
> > +	state->pid_ns = proc_pid_ns(file_inode(seq->file)->i_sb);
> >  
> >  	rcu_read_lock_bh();
> >  	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
> > diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
> > index 08b096e2f7e3..df4798980416 100644
> > --- a/security/tomoyo/realpath.c
> > +++ b/security/tomoyo/realpath.c
> > @@ -162,7 +162,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
> >  	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
> >  		char *ep;
> >  		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
> > -		struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
> > +		struct pid_namespace *proc_pidns = proc_pid_ns(sb);
> >  
> >  		if (*ep == '/' && pid && pid ==
> >  		    task_tgid_nr_ns(current, proc_pidns)) {
> 

-- 
Rgrds, legion

