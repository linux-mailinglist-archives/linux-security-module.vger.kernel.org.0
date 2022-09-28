Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B855EDFDF
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Sep 2022 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiI1PMq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 28 Sep 2022 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiI1PMl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Sep 2022 11:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC76AE9C6;
        Wed, 28 Sep 2022 08:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94E0161EE5;
        Wed, 28 Sep 2022 15:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E236C433C1;
        Wed, 28 Sep 2022 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664377959;
        bh=6IyVL9TbEjMfY0QzyVfs04IhTz64bGpDYzqLGqd9Htw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqVoEEwPTA7v3reaLRs5ZzCG3Urp3ZkCjdT2mFbJjDDXCGJirqzyPLOXpRwIBL07Q
         n1I3FtO5UudXMaxhUjbqTm/65dRHhx6WV3Pt6P1dMlV8Lpid1tphKv99dS5VHh/JLO
         8wg5imaq2qeKds8WiCow1PWPS060ut6VIcJYN7iIVI1e+6/L64W7G1QEFnjRUot968
         6IO3k0EiC+vStTtqms2dfMW5/YU+JbHjFDU70MODWSm6R63eR/VlJLVivTMNOcQW+p
         gkKzBdfFIgF43PPeGI1rLvqCSJz7csfMoPuYaLoiwCSHEkRVozHCLsOKXm9BYgZi7h
         414niue/FTXBw==
Date:   Wed, 28 Sep 2022 17:12:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 16/30] acl: add vfs_get_acl()
Message-ID: <20220928151233.f7iqegfk4q6v22fe@wittgenstein>
References: <20220926140827.142806-1-brauner@kernel.org>
 <20220926140827.142806-17-brauner@kernel.org>
 <CAHC9VhSyf9c-EtD_V856ZGTbFamwWh=bxPh7aPdarkqhdE7WZw@mail.gmail.com>
 <20220928074030.3dnytkvt7fibytlu@wittgenstein>
 <CAHC9VhSNOPCOjZ3ucqzrTd01a_o54xfnA137893TkHQMpQXoPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhSNOPCOjZ3ucqzrTd01a_o54xfnA137893TkHQMpQXoPw@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 28, 2022 at 10:58:33AM -0400, Paul Moore wrote:
> On Wed, Sep 28, 2022 at 3:40 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Sep 27, 2022 at 06:55:25PM -0400, Paul Moore wrote:
> > > On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > In previous patches we implemented get and set inode operations for all
> > > > non-stacking filesystems that support posix acls but didn't yet
> > > > implement get and/or set acl inode operations. This specifically
> > > > affected cifs and 9p.
> > > >
> > > > Now we can build a posix acl api based solely on get and set inode
> > > > operations. We add a new vfs_get_acl() api that can be used to get posix
> > > > acls. This finally removes all type unsafety and type conversion issues
> > > > explained in detail in [1] that we aim to get rid of.
> > > >
> > > > After we finished building the vfs api we can switch stacking
> > > > filesystems to rely on the new posix api and then finally switch the
> > > > xattr system calls themselves to rely on the posix acl api.
> > > >
> > > > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > > ---
> > > >
> > > > Notes:
> > > >     /* v2 */
> > > >     unchanged
> > > >
> > > >  fs/posix_acl.c                  | 131 ++++++++++++++++++++++++++++++--
> > > >  include/linux/posix_acl.h       |   9 +++
> > > >  include/linux/posix_acl_xattr.h |  10 +++
> > > >  3 files changed, 142 insertions(+), 8 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > > index ef0908a4bc46..18873be583a9 100644
> > > > --- a/fs/posix_acl.c
> > > > +++ b/fs/posix_acl.c
> > > > @@ -1369,3 +1439,48 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > > >         return error;
> > > >  }
> > > >  EXPORT_SYMBOL(vfs_set_acl);
> > > > +
> > > > +/**
> > > > + * vfs_get_acl - get posix acls
> > > > + * @mnt_userns: user namespace of the mount
> > > > + * @dentry: the dentry based on which to retrieve the posix acls
> > > > + * @acl_name: the name of the posix acl
> > > > + *
> > > > + * This function retrieves @kacl from the filesystem. The caller must all
> > > > + * posix_acl_release() on @kacl.
> > > > + *
> > > > + * Return: On success POSIX ACLs in VFS format, on error negative errno.
> > > > + */
> > > > +struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
> > > > +                             struct dentry *dentry, const char *acl_name)
> > > > +{
> > > > +       struct inode *inode = d_inode(dentry);
> > > > +       struct posix_acl *acl;
> > > > +       int acl_type, error;
> > > > +
> > > > +       acl_type = posix_acl_type(acl_name);
> > > > +       if (acl_type < 0)
> > > > +               return ERR_PTR(-EINVAL);
> > > > +
> > > > +       /*
> > > > +        * The VFS has no restrictions on reading POSIX ACLs so calling
> > > > +        * something like xattr_permission() isn't needed. Only LSMs get a say.
> > > > +        */
> > > > +       error = security_inode_getxattr(dentry, acl_name);
> > > > +       if (error)
> > > > +               return ERR_PTR(error);
> > >
> > > I understand the desire to reuse the security_inode_getxattr() hook
> > > here, it makes perfect sense, but given that this patchset introduces
> > > an ACL specific setter hook I think it makes sense to have a matching
> > > getter hook.  It's arguably a little silly given the current crop of
> > > LSMs and their approach to ACLs, but if we are going to differentiate
> > > on the write side I think we might as well be consistent and
> > > differentiate on the read side as well.
> >
> > Sure, I don't mind doing that. I'll add the infrastructure and then the
> > individual LSMs can add their own hooks.
> 
> Adding the ACL hook infrastructure, including the call in
> vfs_get_acl(), without the LSM implementations would result in an
> access control regression for both SELinux and Smack.  Similar issues
> with the removexattr hook, although that looks to have IMA/EVM calls
> too (which may be noops in the case of an ACL, I haven't checked).
> 
> The good news is that the individual LSM implementations should be
> trivial, and if you wanted to just have the new ACL hook
> implementations call into the existing xattr implementations inside
> each LSM I think that would be okay to start.

Yeah, I realized right after I sent the mail that I'd need to implement
them. I think I came up with something fairly minimal for all lsms and
the integrity modules. I folded the trivial patches for adding get, set,
and remove hooks for the individual modules together to not needlessly
inflate the security portion of the patchset.
