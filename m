Return-Path: <linux-security-module+bounces-4198-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61592CA44
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Jul 2024 07:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F65282180
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Jul 2024 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36641A84;
	Wed, 10 Jul 2024 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVqbcfVd"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113E15CB;
	Wed, 10 Jul 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590737; cv=none; b=m0Szq54zEQjiApu8N7XkkeXnxvaUa1CccykpbKjLXvKWqq9dzXUzChv6eMnrGYDM0j3IS73R8zUElWelsMGX3v05wxsdHPgfmieM2+fp1oyRNdK9i9uLkNk3L5Ci18PbJM07zopxyrowo1qFx7fBuc6NAAdNWqquaOSqIEdNxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590737; c=relaxed/simple;
	bh=7LL+Ff7Y0QqOl8nVmsoGJ2m7iN8u9RmmQDcVI++dqyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX071303fPsuAfOtim8sXB82+n/mkPMk1LF68ZdQ5xvQ8XSfUB5oRnxIcQ7sSIer2fZVmP0vXoeXE3UftmIvwgcJB6Z6OqBaisg91+MPBLvvrbFLsWrme5Hyk1yAqizSIQCEEVHGMPtUho4EgNbowwq/k8amsmEO+6f+qOHB5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVqbcfVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E365C32781;
	Wed, 10 Jul 2024 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720590736;
	bh=7LL+Ff7Y0QqOl8nVmsoGJ2m7iN8u9RmmQDcVI++dqyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVqbcfVdgWfrFpck6mJywu/tapj+CKvrnt8aVNkRcYyc6Chy+oHw30rwDfAW5CaKG
	 2BCPuhWgs0AIkuTg4k3rOCKahu8GDs7uH30MNYfLUZFi77sceutMieg3Oea05hKzJa
	 MXy5NP83B8JfrDFevk8BkzZFBNRZQxyi1y0PPu9h3glxPLsAa91kPkWxFMAg/Pf49O
	 40kuX6fCjW9411TmJvjHS+jf0KTD1jIaZGcI5+3Yrtd9QpxRPwvCS4gA0r9B/abJIp
	 71ktPVZH6sMnWg3maSkoyz+r8f1mUqFx0fmvIanPtVIB0S2aZaTFqxUfGDhpc8Ug76
	 NhpiBuGoWiEag==
Date: Wed, 10 Jul 2024 07:52:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240710-sagenhaft-rednerpult-81de44066c91@brauner>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <20240708.ig8Kucapheid@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708.ig8Kucapheid@digikod.net>

On Mon, Jul 08, 2024 at 04:11:41PM GMT, Mickaël Salaün wrote:
> On Thu, Jun 27, 2024 at 02:28:03PM -0400, Paul Moore wrote:
> > On Thu, Jun 27, 2024 at 9:34 AM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > I didn't find specific issues with Landlock's code except the extra
> > > check in hook_inode_free_security().  It looks like inode->i_security is
> > > a dangling pointer, leading to UAF.
> > >
> > > Reading security_inode_free() comments, two things looks weird to me:
> > >
> > > > /**
> > > >  * security_inode_free() - Free an inode's LSM blob
> > > >  * @inode: the inode
> > > >  *
> > > >  * Deallocate the inode security structure and set @inode->i_security to NULL.
> > >
> > > I don't see where i_security is set to NULL.
> > 
> > The function header comments are known to be a bit suspect, a side
> > effect of being detached from the functions for many years, this may
> > be one of those cases.  I tried to fix up the really awful ones when I
> > moved the comments back, back I didn't have time to go through each
> > one in detail.  Patches to correct the function header comments are
> > welcome and encouraged! :)
> > 
> > > >  */
> > > > void security_inode_free(struct inode *inode)
> > > > {
> > >
> > > Shouldn't we add this check here?
> > > if (!inode->i_security)
> > >         return;
> > 
> > Unless I'm remembering something wrong, I believe we *should* always
> > have a valid i_security pointer each time we are called, if not
> > something has gone wrong, e.g. the security_inode_free() hook is no
> > longer being called from the right place.  If we add a NULL check, we
> > should probably have a WARN_ON(), pr_err(), or something similar to
> > put some spew on the console/logs.
> > 
> > All that said, it would be good to hear some confirmation from the VFS
> > folks that the security_inode_free() hook is located in a spot such
> > that once it exits it's current RCU critical section it is safe to
> > release the associated LSM state.
> > 
> > It's also worth mentioning that while we always allocate i_security in
> > security_inode_alloc() right now, I can see a world where we allocate
> > the i_security field based on need using the lsm_blob_size info (maybe
> > that works today?  not sure how kmem_cache handled 0 length blobs?).
> > The result is that there might be a legitimate case where i_security
> > is NULL, yet we still want to call into the LSM using the
> > inode_free_security() implementation hook.
> > 
> > > >       call_void_hook(inode_free_security, inode);
> > > >       /*
> > > >        * The inode may still be referenced in a path walk and
> > > >        * a call to security_inode_permission() can be made
> > > >        * after inode_free_security() is called. Ideally, the VFS
> > > >        * wouldn't do this, but fixing that is a much harder
> > > >        * job. For now, simply free the i_security via RCU, and
> > > >        * leave the current inode->i_security pointer intact.
> > > >        * The inode will be freed after the RCU grace period too.
> > >
> > > It's not clear to me why this should be safe if an LSM try to use the
> > > partially-freed blob after the hook calls and before the actual blob
> > > free.
> > 
> > I had the same thought while looking at this just now.  At least in
> > the SELinux case I think this "works" simply because SELinux doesn't
> > do much here, it just drops the inode from a SELinux internal list
> > (long story) and doesn't actually release any memory or reset the
> > inode's SELinux state (there really isn't anything to "free" in the
> > SELinux case).  I haven't checked the other LSMs, but they may behave
> > similarly.
> > 
> > We may want (need?) to consider two LSM implementation hooks called
> > from within security_inode_free(): the first where the existing
> > inode_free_security() implementation hook is called, the second inside
> > the inode_free_by_rcu() callback immediately before the i_security
> > data is free'd.
> 
> Couldn't we call everything in inode_free_by_rcu()?
> I replied here instead:
> https://lore.kernel.org/r/20240708.hohNgieja0av@digikod.net
> 
> > 
> > ... or we find a better placement in the VFS for
> > security_inode_free(), is that is possible.  It may not be, our VFS
> > friends should be able to help here.
> 
> Christian? Al?
> 
> > 
> > > >        */
> > > >       if (inode->i_security)
> > > >               call_rcu((struct rcu_head *)inode->i_security,
> > > >                        inode_free_by_rcu);
> > >
> > > And then:
> > > inode->i_security = NULL;
> > 
> > According to the comment we may still need i_security for permission
> > checks.  See my comment about decomposing the LSM implementation into
> > two hooks to better handle this for LSMs.
> 
> That was my though too, but maybe not if the path walk just ends early.
> 
> > 
> > > But why call_rcu()?  i_security is not protected by RCU barriers.
> > 
> > I believe the issue is that the inode is protected by RCU and that
> > affects the lifetime of the i_security blob.
> 
> It seems to be related to commit fa0d7e3de6d6 ("fs: icache RCU free
> inodes").

Path walking can happen in RCU- and ref-mode. We'll try RCU first and
fallback to ref mode if it fails with ECHILD. In RCU mode it's possible
to call inode_permission() on nd->inode (e.g., in may_lookup()) while
dentry->d_inode has changed (rename or similar)). This would be detected
later when we validate that the parent child relationship hasn't changed
while we were under RCU and would force a drop out of RCU into ref
walking mode.

