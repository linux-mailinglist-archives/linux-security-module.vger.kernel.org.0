Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734E78F041
	for <lists+linux-security-module@lfdr.de>; Thu, 31 Aug 2023 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbjHaP1O (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 31 Aug 2023 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbjHaP1N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Aug 2023 11:27:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2AE4C
        for <linux-security-module@vger.kernel.org>; Thu, 31 Aug 2023 08:27:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579de633419so11009597b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 31 Aug 2023 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693495629; x=1694100429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p4KVcplnkmAq97aJFuRfPluC00MQY2jsCtIut4Z1Gw=;
        b=DQBGsuogfAfIuaqpGxsVAGXkchKMaZDVSLGUmnqMpHQ9GBbEDh8NoGsYinCnTMy+o8
         WkEP0ZrBdyEctGnC1R39gRkr9G4WgQvt3TCWXr5QN065qOvUP2noBYmO46C5AZCZKbSK
         cK8CeOzgsEI7RbisvKeCT+41AS7Aiwl6bv5ikWmep8+9tLb/7ZcN/XraE02UOq8rj3mq
         Qjxtyz0LMkf93mneJc+vbZg4CA4TqSIJPvkBYzWuGC5d+rUMabPVvlKn4JEcBeMUseK4
         4ZMc843c7Vtc/ObMtSZVMRS2eV7Yme+5X4fIgTGPF16Tv4lQ37qwaIUSBE0s4H6Z9adc
         V0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495629; x=1694100429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p4KVcplnkmAq97aJFuRfPluC00MQY2jsCtIut4Z1Gw=;
        b=C3JDttWsjPoE5z3dGh4OIMJf5hJncTg5PpGen12EAvxL/MasSPeECmTXzMUICSlfBV
         GnvcvxDPlf+XfE8iIR0CJVMmdzChP2lWn/ZxUwwjSJ6R9gMC5NEF0DjDwf+7qiggxsAA
         K2n3mkU3u6gtN9OfDKf48aaVFsRTRTK/2IToRRy7/WQJlw48jnRBd19AOxcB7PafwXRt
         fZTYwtURJ1mUqiqX/eWucUZB0GPP92wGXUvVltYFaiElbYZh3VyzpOKh+QWn5d13l6v3
         KxB3jIcRNPiTHztL5Uvib55YJiYbLAMtQ2oi4x6vf1ircJYmWoYQ2pgH6PDeHgERkYDW
         fRcQ==
X-Gm-Message-State: AOJu0Yx8/9wzh+xhKv+gkJGfjQzRbp2g8Sax9IO7TAzhFnnhFbcNwoXS
        4zcssrzY/OYb/T4w1T12E+wTKWgz8RmYP67ZQtfQ
X-Google-Smtp-Source: AGHT+IEbAPJPHeshhRY/Lhxcw/6oRYRPRw32NnYy3eYgXlznsnIjt+TNPp9z+bpcymHvBZK/BtkQ6Ltb5kMj49p25ig=
X-Received: by 2002:a81:6cd8:0:b0:58f:a19f:2b79 with SMTP id
 h207-20020a816cd8000000b0058fa19f2b79mr6137570ywc.9.1693495629007; Thu, 31
 Aug 2023 08:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
 <f75539a8-adf0-159b-15b9-4cc4a674e623@google.com> <20230831-nachverfolgen-meditation-dcde56b10df7@brauner>
 <cd76e05c82d294a9d0965a2d98b8e51782489b5f.camel@linux.ibm.com>
In-Reply-To: <cd76e05c82d294a9d0965a2d98b8e51782489b5f.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 11:26:58 -0400
Message-ID: <CAHC9VhRLJ+WLBAq_2mDWEC06Umx3Fj-z-2Qem_50izZHYF-vJQ@mail.gmail.com>
Subject: Re: LSM hook ordering in shmem_mknod() and shmem_tmpfile()?
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-mm@kvack.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 31, 2023 at 11:13=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Thu, 2023-08-31 at 14:36 +0200, Christian Brauner wrote:
> > On Thu, Aug 31, 2023 at 02:19:20AM -0700, Hugh Dickins wrote:
> > > On Wed, 30 Aug 2023, Paul Moore wrote:
> > >
> > > > Hello all,
> > > >
> > > > While looking at some recent changes in mm/shmem.c I noticed that t=
he
> > > > ordering between simple_acl_create() and
> > > > security_inode_init_security() is different between shmem_mknod() a=
nd
> > > > shmem_tmpfile().  In shmem_mknod() the ACL call comes before the LS=
M
> > > > hook, and in shmem_tmpfile() the LSM call comes before the ACL call=
.
> > > >
> > > > Perhaps this is correct, but it seemed a little odd to me so I want=
ed
> > > > to check with all of you to make sure there is a good reason for th=
e
> > > > difference between the two functions.  Looking back to when
> > > > shmem_tmpfile() was created ~2013 I don't see any explicit mention =
as
> > > > to why the ordering is different so I'm looking for a bit of a sani=
ty
> > > > check to see if I'm missing something obvious.
> > > >
> > > > My initial thinking this morning is that the
> > > > security_inode_init_security() call should come before
> > > > simple_acl_create() in both cases, but I'm open to different opinio=
ns
> > > > on this.
> > >
> > > Good eye.  The crucial commit here appears to be Mimi's 3.11 commit
> > > 37ec43cdc4c7 "evm: calculate HMAC after initializing posix acl on tmp=
fs"
> > > which intentionally moved shmem_mknod()'s generic_acl_init() up befor=
e
> > > the security_inode_init_security(), around the same time as Al was
> > > copying shmem_mknod() to introduce shmem_tmpfile().
> > >
> > > I'd have agreed with you, Paul, until reading Mimi's commit:
> > > now it looks more like shmem_tmpfile() is the one to be changed,
> > > except (I'm out of my depth) maybe it's irrelevant on tmpfiles.
> >
> > POSIX ACLs generally need to be set first as they are may change inode
> > properties that security_inode_init_security() may rely on to be stable=
.
> > That specifically incudes inode->i_mode:
> >
> > * If the filesystem doesn't support POSIX ACLs then the umask is
> >   stripped in the VFS before it ever gets to the filesystems. For such
> >   cases the order of *_init_security() and setting POSIX ACLs doesn't
> >   matter.
> > * If the filesystem does support POSIX ACLs and the directory of the
> >   resulting file does have default POSIX ACLs with mode settings then
> >   the inode->i_mode will be updated.
> > * If the filesystem does support POSIX ACLs but the directory doesn't
> >   have default POSIX ACLs the umask will be stripped.
> >
> > (roughly from memory)
> >
> > If tmpfs is compiled with POSIX ACL support the mode might change and i=
f
> > anything in *_init_security() relies on inode->i_mode being stable it
> > needs to be called after they have been set.
> >
> > EVM hashes do use the mode and the hash gets updated when POSIX ACLs ar=
e
> > changed - which caused me immense pain when I redid these codepaths las=
t
> > year.
> >
> > IMHO, the easiest fix really is to lump all this together for all
> > creation paths. This is what most filesystems do. For examples, see
> >
> > xfs_generic_create()
> > -> posix_acl_create(&mode)
> > -> xfs_create{_tmpfile}(mode)
> > -> xfs_inode_init_security()
> >
> > or
> >
> > __ext4_new_inode()
> > -> ext4_init_acl()
> > -> ext4_init_security()
>
> Agreed.  Thanks, Hugh, Christian for the clear explanation.

Yes, thanks all.  I figured something was a little wonky but wasn't
smart enough to know the correct fix.

So .... who wants to submit a patch?

--=20
paul-moore.com
