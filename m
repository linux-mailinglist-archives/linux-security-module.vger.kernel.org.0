Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A603711ED0B
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2019 22:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfLMVkF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Dec 2019 16:40:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbfLMVkF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Dec 2019 16:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576273204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgOXIag/oVgErX13K0wlqJ230VPf+71NlCt27NFhOC8=;
        b=fa5MdWSE+yr0QbII1ZjOkAwPlUZ0EiOxvOB0mlcU7x7do3fn1CmSkRh4xlmVtvh4Nqf+h/
        FBcVLfFdsl6cL8wyDU36s6nM1lTqm/BKZRm5oPrDNm3xVuZHfdKg93l2QWmdzErnr9h9fM
        EbwJ7dojO7FJZ7u1twsb6IkLv9Smjck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-j09TGu7gOzS_Le1gjjpMpA-1; Fri, 13 Dec 2019 16:40:01 -0500
X-MC-Unique: j09TGu7gOzS_Le1gjjpMpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68993593A4;
        Fri, 13 Dec 2019 21:39:59 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB63C5D9CA;
        Fri, 13 Dec 2019 21:39:58 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 6505E20694; Fri, 13 Dec 2019 16:39:58 -0500 (EST)
Date:   Fri, 13 Dec 2019 16:39:58 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH v6 00/27] nfs: Mount API conversion
Message-ID: <20191213213958.GY4276@coeurl.usersys.redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
 <498258bf630d4c2667920f21341a2a6e82a3788d.camel@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498258bf630d4c2667920f21341a2a6e82a3788d.camel@netapp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 10 Dec 2019, Schumaker, Anna wrote:

> Hi Scott,
> 
> On Tue, 2019-12-10 at 07:30 -0500, Scott Mayhew wrote:
> > Hi Anna, Trond,
> > 
> > Here's a set of patches that converts NFS to use the mount API.  Note that
> > there are a lot of preliminary patches, some from David and some from Al.
> > The final patch (the one that does the actual conversion) from the David's
> > initial posting has been split into 5 separate patches, and the entire set
> > has been rebased on top of v5.5-rc1.
> 
> Thanks for the updated patches! Everything looks okay to me, but I've only
> tested with the legacy mount command. I'm curious if you've tested it using the
> new system?

I've hacked up mount.nfs for testing the new syscalls (for mounting... I
haven't quite figured out remounting yet) here:
https://github.com/scottmayhew/nfs-utils/tree/fscontext

It seems to be working okay, with one exception.  If I mount the same
NFS export with the same mount options multiple times, then I get
multiple mounts:

[root@fedora30 ~]# mount.nfs nfs:/export /mnt/t
[root@fedora30 ~]# mount.nfs nfs:/export /mnt/t
[root@fedora30 ~]# grep /mnt/t /proc/mounts
nfs:/export /mnt/t nfs rw,seclabel,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5,clientaddr=192.168.122.239,local_lock=none,addr=192.168.122.3 0 0
nfs:/export /mnt/t nfs rw,seclabel,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5,clientaddr=192.168.122.239,local_lock=none,addr=192.168.122.3 0 0

That doesn't happen with the mount() syscall:

[root@fedora30 ~]# mount.nfs.old nfs:/export /mnt/t
[root@fedora30 ~]# mount.nfs.old nfs:/export /mnt/t
[root@fedora30 ~]# grep /mnt/t /proc/mounts
nfs:/export /mnt/t nfs rw,seclabel,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5,clientaddr=192.168.122.239,local_lock=none,addr=192.168.122.3 0 0

-Scott

> 
> Thanks,
> Anna
> 
> > 
> > Changes since v5:
> > - fixed possible derefence of error pointer in nfs4_validate_fspath()
> >   reported by Dan Carpenter
> > - rebased on top of v5.5-rc1
> > Changes since v4:
> > - further split the original "NFS: Add fs_context support" patch (new
> >   patch is about 25% smaller than the v4 patch)
> > - fixed NFSv4 referral mounts (broken in the original patch)
> > - fixed leak of nfs_fattr when fs_context is freed
> > Changes since v3:
> > - changed license and copyright text in fs/nfs/fs_context.c
> > Changes since v2:
> > - fixed the conversion of the nconnect= option
> > - added '#if IS_ENABLED(CONFIG_NFS_V4)' around nfs4_parse_monolithic()
> >   to avoid unused-function warning when compiling with v4 disabled
> > Chagnes since v1:
> > - split up patch 23 into 4 separate patches
> > 
> > -Scott
> > 
> > Al Viro (15):
> >   saner calling conventions for nfs_fs_mount_common()
> >   nfs: stash server into struct nfs_mount_info
> >   nfs: lift setting mount_info from nfs4_remote{,_referral}_mount
> >   nfs: fold nfs4_remote_fs_type and nfs4_remote_referral_fs_type
> >   nfs: don't bother setting/restoring export_path around
> >     do_nfs_root_mount()
> >   nfs4: fold nfs_do_root_mount/nfs_follow_remote_path
> >   nfs: lift setting mount_info from nfs_xdev_mount()
> >   nfs: stash nfs_subversion reference into nfs_mount_info
> >   nfs: don't bother passing nfs_subversion to ->try_mount() and
> >     nfs_fs_mount_common()
> >   nfs: merge xdev and remote file_system_type
> >   nfs: unexport nfs_fs_mount_common()
> >   nfs: don't pass nfs_subversion to ->create_server()
> >   nfs: get rid of mount_info ->fill_super()
> >   nfs_clone_sb_security(): simplify the check for server bogosity
> >   nfs: get rid of ->set_security()
> > 
> > David Howells (8):
> >   NFS: Move mount parameterisation bits into their own file
> >   NFS: Constify mount argument match tables
> >   NFS: Rename struct nfs_parsed_mount_data to struct nfs_fs_context
> >   NFS: Split nfs_parse_mount_options()
> >   NFS: Deindent nfs_fs_context_parse_option()
> >   NFS: Add a small buffer in nfs_fs_context to avoid string dup
> >   NFS: Do some tidying of the parsing code
> >   NFS: Add fs_context support.
> > 
> > Scott Mayhew (4):
> >   NFS: rename nfs_fs_context pointer arg in a few functions
> >   NFS: Convert mount option parsing to use functionality from
> >     fs_parser.h
> >   NFS: Additional refactoring for fs_context conversion
> >   NFS: Attach supplementary error information to fs_context.
> > 
> >  fs/nfs/Makefile         |    2 +-
> >  fs/nfs/client.c         |   80 +-
> >  fs/nfs/fs_context.c     | 1424 +++++++++++++++++++++++++
> >  fs/nfs/fscache.c        |    2 +-
> >  fs/nfs/getroot.c        |   73 +-
> >  fs/nfs/internal.h       |  132 +--
> >  fs/nfs/namespace.c      |  146 ++-
> >  fs/nfs/nfs3_fs.h        |    2 +-
> >  fs/nfs/nfs3client.c     |    6 +-
> >  fs/nfs/nfs3proc.c       |    2 +-
> >  fs/nfs/nfs4_fs.h        |    9 +-
> >  fs/nfs/nfs4client.c     |   99 +-
> >  fs/nfs/nfs4file.c       |    1 +
> >  fs/nfs/nfs4namespace.c  |  292 +++---
> >  fs/nfs/nfs4proc.c       |    2 +-
> >  fs/nfs/nfs4super.c      |  257 ++---
> >  fs/nfs/proc.c           |    2 +-
> >  fs/nfs/super.c          | 2217 +++++----------------------------------
> >  include/linux/nfs_xdr.h |    9 +-
> >  19 files changed, 2287 insertions(+), 2470 deletions(-)
> >  create mode 100644 fs/nfs/fs_context.c
> > 

