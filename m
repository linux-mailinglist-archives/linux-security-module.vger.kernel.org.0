Return-Path: <linux-security-module+bounces-6064-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F999A10D
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2024 12:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697BB1F2179A
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2024 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022B19B5B2;
	Fri, 11 Oct 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pKcjefcl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAF28EB
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641743; cv=none; b=Fc6oI5OGisRECuMEIci2wevqNPgM6CJfNJnUYR+MN//m3wTHBwE1KA2McQY2jLPedjM4xbAPmR/JPFe0gERPekMIjsJRWKfcw/7kvWXmDY+qRSAQdutxy3uB1zXAZY3C1EcgriGhq36ETpjxWJV6JAkclwOR3dmA2fdg3TP8K7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641743; c=relaxed/simple;
	bh=DvGh1jzQdIG76djlkpxOSy+n0zhC4VcSnTJZy9SRChw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmR4ZWpdyv9nxv1w8Hw+NeBQPCYEySRVO9+HP+3JB7+DSa5SqbTPfeqkpHecFPpth3Vj4xPRmA7G6IzeqKEPIHex3iWaFKrAmxiElLP1BqnPMKCukHsoA/2KVyFF5VSabRu77/942cx+vLdv1Uy9vjZvZcEALjOX5Ie+Q2cJV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pKcjefcl; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ2ZJ1H3QzTZP;
	Fri, 11 Oct 2024 12:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728641736;
	bh=4+FqVs3iwtwCdc+msnWPPtMVkkX10X7OGzWNq6muFuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKcjefclPdoOVlFHoxbgd4WiRQxwF7IkFgf3o9sGy4WBv0GWGD6T6C2iEZWp2HuTG
	 /UuOsubc+wVSQcOu6zl8Q+eQlovH9sUcN2N0tGHewpEylS+TVG0Vfh0crA07SkZFYX
	 fottoitAUehzoQqn4GyC1POwrSFmkIim4jzgYv4E=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ2ZH4LCkz8Vh;
	Fri, 11 Oct 2024 12:15:35 +0200 (CEST)
Date: Fri, 11 Oct 2024 12:15:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.xaeMo6Fohj3h@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <fd90d5d173a47732da87d31aed8a955f73ea086e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd90d5d173a47732da87d31aed8a955f73ea086e.camel@kernel.org>
X-Infomaniak-Routing: alpha

On Thu, Oct 10, 2024 at 03:28:12PM -0400, Trond Myklebust wrote:
> On Thu, 2024-10-10 at 17:26 +0200, Mickaël Salaün wrote:
> > When a filesystem manages its own inode numbers, like NFS's fileid
> > shown
> > to user space with getattr(), other part of the kernel may still
> > expose
> > the private inode->ino through kernel logs and audit.
> > 
> > Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> > whereas the user space's view of an inode number can still be 64
> > bits.
> > 
> > Add a new inode_get_ino() helper calling the new struct
> > inode_operations' get_ino() when set, to get the user space's view of
> > an
> > inode number.  inode_get_ino() is called by generic_fillattr().
> > 
> > Implement get_ino() for NFS.
> > 
> > Cc: Trond Myklebust <trondmy@kernel.org>
> > Cc: Anna Schumaker <anna@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > I'm not sure about nfs_namespace_getattr(), please review carefully.
> > 
> > I guess there are other filesystems exposing inode numbers different
> > than inode->i_ino, and they should be patched too.
> > ---
> >  fs/nfs/inode.c     | 6 ++++--
> >  fs/nfs/internal.h  | 1 +
> >  fs/nfs/namespace.c | 2 ++
> >  fs/stat.c          | 2 +-
> >  include/linux/fs.h | 9 +++++++++
> >  5 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 542c7d97b235..5dfc176b6d92 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -83,18 +83,19 @@ EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
> >  
> >  /**
> >   * nfs_compat_user_ino64 - returns the user-visible inode number
> > - * @fileid: 64-bit fileid
> > + * @inode: inode pointer
> >   *
> >   * This function returns a 32-bit inode number if the boot parameter
> >   * nfs.enable_ino64 is zero.
> >   */
> > -u64 nfs_compat_user_ino64(u64 fileid)
> > +u64 nfs_compat_user_ino64(const struct *inode)
> >  {
> >  #ifdef CONFIG_COMPAT
> >  	compat_ulong_t ino;
> >  #else	
> >  	unsigned long ino;
> >  #endif
> > +	u64 fileid = NFS_FILEID(inode);
> >  
> >  	if (enable_ino64)
> >  		return fileid;
> > @@ -103,6 +104,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
> >  		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
> >  	return ino;
> >  }
> > +EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
> >  
> >  int nfs_drop_inode(struct inode *inode)
> >  {
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 430733e3eff2..f5555a71a733 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -451,6 +451,7 @@ extern void nfs_zap_acl_cache(struct inode
> > *inode);
> >  extern void nfs_set_cache_invalid(struct inode *inode, unsigned long
> > flags);
> >  extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
> >  extern int nfs_wait_bit_killable(struct wait_bit_key *key, int
> > mode);
> > +extern u64 nfs_compat_user_ino64(const struct *inode);
> >  
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  /* localio.c */
> > diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> > index e7494cdd957e..d9b1e0606833 100644
> > --- a/fs/nfs/namespace.c
> > +++ b/fs/nfs/namespace.c
> > @@ -232,11 +232,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap,
> > struct dentry *dentry,
> >  const struct inode_operations nfs_mountpoint_inode_operations = {
> >  	.getattr	= nfs_getattr,
> >  	.setattr	= nfs_setattr,
> > +	.get_ino	= nfs_compat_user_ino64,
> >  };
> >  
> >  const struct inode_operations nfs_referral_inode_operations = {
> >  	.getattr	= nfs_namespace_getattr,
> >  	.setattr	= nfs_namespace_setattr,
> > +	.get_ino	= nfs_compat_user_ino64,
> >  };
> >  
> >  static void nfs_expire_automounts(struct work_struct *work)
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 41e598376d7e..05636919f94b 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -50,7 +50,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32
> > request_mask,
> >  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> >  
> >  	stat->dev = inode->i_sb->s_dev;
> > -	stat->ino = inode->i_ino;
> > +	stat->ino = inode_get_ino(inode);
> >  	stat->mode = inode->i_mode;
> >  	stat->nlink = inode->i_nlink;
> >  	stat->uid = vfsuid_into_kuid(vfsuid);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e3c603d01337..0eba09a21cf7 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2165,6 +2165,7 @@ struct inode_operations {
> >  			    struct dentry *dentry, struct fileattr
> > *fa);
> >  	int (*fileattr_get)(struct dentry *dentry, struct fileattr
> > *fa);
> >  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> > +	u64 (*get_ino)(const struct inode *inode);
> >  } ____cacheline_aligned;
> >  
> >  static inline int call_mmap(struct file *file, struct vm_area_struct
> > *vma)
> > @@ -2172,6 +2173,14 @@ static inline int call_mmap(struct file *file,
> > struct vm_area_struct *vma)
> >  	return file->f_op->mmap(file, vma);
> >  }
> >  
> > +static inline u64 inode_get_ino(struct inode *inode)
> > +{
> > +	if (unlikely(inode->i_op->get_ino))
> > +		return inode->i_op->get_ino(inode);
> > +
> > +	return inode->i_ino;
> > +}
> > +
> >  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t
> > *);
> >  extern ssize_t vfs_write(struct file *, const char __user *, size_t,
> > loff_t *);
> >  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct
> > file *,
> 
> There should be no need to add this callback to generic_fillattr().
> 
> generic_fillattr() is a helper function for use by the filesystems
> themselves. It should never be called from any outside functions, as
> the inode number would be far from the only attribute that will be
> incorrect.

This change will not impact filesystems except the ones that implement the new
get_ino() operation, and I suspect NFS is not or will not be the only one.  We
need to investigate on other filesystems but I wanted to get a first feedback
before.  Using get_ino() in generic_fillattr() should guarantee a consistent
getattr() wrt inode numbers.  I forgot to remove the now-useless call to
nfs_compat_user_ino64() in nfs_getattr() for this to make sense:

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..78a9e907c905 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -981,7 +983,6 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
        stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;

        generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-       stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
        stat->change_cookie = inode_peek_iversion_raw(inode);
        stat->attributes_mask |= STATX_ATTR_CHANGE_MONOTONIC;
        if (server->change_attr_type != NFS4_CHANGE_TYPE_IS_UNDEFINED)

Al, Christian, what do you think about this generic_fillattr() change?

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

