Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F72A0EF0
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Oct 2020 20:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgJ3T42 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 30 Oct 2020 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgJ3T41 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Oct 2020 15:56:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B773C0613D5
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 12:56:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q1so1216654qvn.5
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCXdIDDEOQ4sp35BxxEEwDK4u7wEsOXSjw7fR5lQ1JM=;
        b=vSrIWJfPbZcyzboU1vKIyWhst9w6jkZcPg2Fd/Tyr/+5CsiSbu6ptsTz5Soh4jBnSD
         3d1HnaDhJZn9EjJglKvv49w7CobE+jurkMtZr4ontDfkag7fi8SMbKRE9K9iDEHM8d/r
         b8PaN2BYUxO4vhprE3ysd+Nz+bafxOlSE52B/xKdBxRMgEE82BqyuUTkV/sN9j1nm33W
         5pwRVCFeS/MgH+7kB9uvyyhPHbpiukb9ZrmJCP4YffU4dVFLpi0rS8nLvgsZQvkPSGxm
         A0+7Vg38JWaO54eyWDMDNHz8l0xAi5gk8+WQSphC/9CaBpqNYnuF2s2KwntRGphDdthR
         J1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCXdIDDEOQ4sp35BxxEEwDK4u7wEsOXSjw7fR5lQ1JM=;
        b=VPdhx9iL6jswRY6eMFvyUMcVVb6wos/40quxdGocEi6ZUHglKKAXaXNv/k7bPjQEIv
         kuRhWJ3MtN4oVjaGxdxFYeb37sYslReurZOTDdhk2ATOQDdbiLuoiTA9zydYyXBUYNkw
         kVuWeGB/NOpGmm4/TpoCSD8HNZe30+MJuinh0PdyUyFi66dQHLK96BdAk2oEUvYPsIm3
         HH55sJyyEsKI808qRCGWftei4sCoHon3984DGQ6Fkphb17Fzq0DRY3zYK+HgZAgcM0TA
         /Lh0zywzmTXwdEk23vY4wewjLbJw7lUMuQEuIcrmzZmz9rtoJ1/VpPOuRjaQahU3S+OL
         gM8Q==
X-Gm-Message-State: AOAM531aQvG4eGrzpHC5rIO87R+PnyI4IiOCLfLXf0peJy06kfGYvXZW
        PnlmETF26/sOS4RS8OjO1GwpHlvzHard4f/Yqn16Wg==
X-Google-Smtp-Source: ABdhPJxs/TiX12vaQ2OCHQSHT0seDFqKNQ1HIDLofONsrmnhk8Sokx0OyG77Wl1u033wcuYrmkJaHnokNGqh8OxS2bo=
X-Received: by 2002:a0c:8d8b:: with SMTP id t11mr11297208qvb.13.1604087786355;
 Fri, 30 Oct 2020 12:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008caae305ab9a5318@google.com> <000000000000a726a405ada4b6cf@google.com>
 <CAFqZXNvQcjp201ahjLBhYJJCuYqZrYLGDA-wE3hXiJpRNgbTKg@mail.gmail.com>
 <CAJfpegtzQB09ind8tkYzaiu6ODJvhMKj3myxVS75vbjTcOxU8g@mail.gmail.com>
 <CACT4Y+Yyxdju4FR-E3bc5ERM6xhecnos6mkJR5==xS+RS_DUuw@mail.gmail.com> <CAJfpegsAabASuHYtoi_DoooV1vM7Evfrd8ESZDDTx2oXHiR6cw@mail.gmail.com>
In-Reply-To: <CAJfpegsAabASuHYtoi_DoooV1vM7Evfrd8ESZDDTx2oXHiR6cw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 30 Oct 2020 20:56:14 +0100
Message-ID: <CACT4Y+a2aSoEZpytAGKnx77a012z0yzOSu6P2rKQpoBYFBzBDg@mail.gmail.com>
Subject: Re: general protection fault in security_inode_getattr
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 30, 2020 at 8:21 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > On Mon, Aug 24, 2020 at 11:00 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 24, 2020 at 9:37 PM syzbot
> > > > <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com> wrote:
> > > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > Looping in fsdevel and OverlayFS maintainers, as this seems to be
> > > > FS/OverlayFS related...
> > >
> > > Hmm, the oopsing code is always something like:
> > >
> > > All code
> > > ========
> > >    0: 1b fe                sbb    %esi,%edi
> > >    2: 49 8d 5e 08          lea    0x8(%r14),%rbx
> > >    6: 48 89 d8              mov    %rbx,%rax
> > >    9: 48 c1 e8 03          shr    $0x3,%rax
> > >    d: 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1)
> > >   12: 74 08                je     0x1c
> > >   14: 48 89 df              mov    %rbx,%rdi
> > >   17: e8 bc b4 5b fe        callq  0xfffffffffe5bb4d8
> > >   1c: 48 8b 1b              mov    (%rbx),%rbx
> > >   1f: 48 83 c3 68          add    $0x68,%rbx
> > >   23: 48 89 d8              mov    %rbx,%rax
> > >   26: 48 c1 e8 03          shr    $0x3,%rax
> > >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
> > >   2f: 74 08                je     0x39
> > >   31: 48 89 df              mov    %rbx,%rdi
> > >   34: e8 9f b4 5b fe        callq  0xfffffffffe5bb4d8
> > >   39: 48 8b 1b              mov    (%rbx),%rbx
> > >   3c: 48 83 c3 0c          add    $0xc,%rbx
> > >
> > >
> > > And that looks (to me) like the unrolled loop in call_int_hook().  I
> > > don't see how that could be related to overlayfs, though it's
> > > definitely interesting why it only triggers from
> > > overlay->vfs_getattr()->security_inode_getattr()...
> >
> >
> > >   26: 48 c1 e8 03          shr    $0x3,%rax
> > >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
> >
> >
> > This access is part of KASAN check. But the original address kernel
> > tries to access is NULL, so it's not an issue with KASAN.
> >
> > The line is this:
> >
> > int security_inode_getattr(const struct path *path)
> > {
> >     if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
> >         return 0;
> >
> > So it's either path is NULL, or something in d_backing_inode
> > dereferences NULL path->dentry.
> >
> > The reproducer does involve overlayfs:
> >
> > mkdir(&(0x7f0000000240)='./file1\x00', 0x0)
> > mkdir(&(0x7f0000000300)='./bus\x00', 0x0)
> > r0 = creat(&(0x7f00000000c0)='./bus/file1\x00', 0x0)
> > mkdir(&(0x7f0000000080)='./file0\x00', 0x0)
> > mount$overlay(0x400002, &(0x7f0000000000)='./bus\x00',
> > &(0x7f0000000100)='overlay\x00', 0x0,
> > &(0x7f00000003c0)=ANY=[@ANYBLOB='upperdir=./file1,lowerdir=./bus,workdir=./file0,metacopy=on'])
> > link(&(0x7f0000000200)='./bus/file1\x00', &(0x7f00000002c0)='./bus/file0\x00')
> > write$RDMA_USER_CM_CMD_RESOLVE_ADDR(r0, 0x0, 0x0)
> > acct(&(0x7f0000000040)='./bus/file0\x00')
> >
> > Though, it may be overlayfs-related, or it may be a generic bug that
> > requires a tricky reproducer and the only reproducer syzbot come up
> > with happened to involve overlayfs.
> > But there are 4 reproducers on syzbot dashboard and all of them
> > involve overlayfs and they are somewhat different. So my bet would be
> > on overlayfs.
>
> Seems there's no C reproducer, though.   Can this be reproduced
> without KASAN obfuscating the oops?

I guess so.
If you are interest in what exact field is NULL, I think there is
enough info in the asm already:

> > >    2: 49 8d 5e 08          lea    0x8(%r14),%rbx
> > >    6: 48 89 d8              mov    %rbx,%rax
> > >    9: 48 c1 e8 03          shr    $0x3,%rax
> > >    d: 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1)
> > >   12: 74 08                je     0x1c
> > >   14: 48 89 df              mov    %rbx,%rdi
> > >   17: e8 bc b4 5b fe        callq  0xfffffffffe5bb4d8
> > >   1c: 48 8b 1b              mov    (%rbx),%rbx
> > >   1f: 48 83 c3 68          add    $0x68,%rbx
> > >   23: 48 89 d8              mov    %rbx,%rax
> > >   26: 48 c1 e8 03          shr    $0x3,%rax
> > >   2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction

The access via the NULL pointer happens with offset 0x68:

> > >   1f: 48 83 c3 68          add    $0x68,%rbx

So we just need to find what's here accesses with offset 0x68:

> >     if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))

And that pointer itself was loaded from something at offset 0x8 previously:

> > >    2: 49 8d 5e 08          lea    0x8(%r14),%rbx
