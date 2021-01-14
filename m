Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6492F6E9D
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Jan 2021 23:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbhANWvi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Jan 2021 17:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbhANWvh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jan 2021 17:51:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10FC061757
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 14:50:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r5so7474687eda.12
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 14:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeoL+rYHRCbasM2MDskzXuaIRoYc6D44ZyyDiGPDO/w=;
        b=ClFJZo+BJk+87jvAan7WQo9aS+l9tB+E2az4yrz+MpLvi/9fHWesT1nzF0xSXzhZCc
         RcJoLJz5dACLZmtWv2+nlv3CqzQEDL0hjiupvp2YCB89Xzux0kim1rXAGMcO9ILhR5NF
         ap+XpTjn6tNdf4OFIkPleEyfTOB7kAxAs/+hXc1CCHpR9/zb0btfVC0YnJjGv6Cy0j8R
         BEox7tEqvkj32hABqbcIkkSkwpLR2P+u4xrAsFnQKZiANB9aGkPrH/BzcV6aEeZIN+s4
         6cUxyKcITIdXdddyv2p5qmqAVaL7wzbAvBtnyiaRfVIbU2O8iNEEAv5xbdySCtn7QmTw
         lJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeoL+rYHRCbasM2MDskzXuaIRoYc6D44ZyyDiGPDO/w=;
        b=Zmv2DnKT/9RcfJqZSKoj4tA8eYGH0vGspzN8k54jlrxdWqgYzDLp6SdAYarjfUrO4N
         Uc7jW+6MistEyD4CFEa5B1UaEe3Txdcy8N3m8E0NTvuj5vm3OLCFMPnl228VGUDX9KCc
         IWxEwMqNt7JzDjNNH0lYwM+FZgsq2s5GTn3uCJrLh3fcOWFhb/B4rjT+NNNTMOlwWVEL
         5rgEGTLpBRV0dObHcp5enSsHPYgfiaUwcQsRofboVIcmcnoPdyTMkjYN35tHS0UQfmzd
         6vRCpZXEOQTqgHYxT+/moW9P3hqMItNA5yHIHGU/IrZJIjRGgC9vvUcaIVEkjSb5CMY6
         l92Q==
X-Gm-Message-State: AOAM532N7XDw8Oi51A215m/L/mjuaxfh6SCzQ3sH5KaZ6GLqscCTGu+2
        Ti5zNNs3d9skFSYLXvlrBts40IQ5JIf+WTdljDwTBQ==
X-Google-Smtp-Source: ABdhPJwLGBXalWJsx6TApXUYEwR9vPwAwFhtNqwvKEo7UM+rk8tYy5H8fbrDp2tRSXTRqBa3IjZfbVbM/R4B97HOXRg=
X-Received: by 2002:aa7:c0c2:: with SMTP id j2mr7423719edp.343.1610664655156;
 Thu, 14 Jan 2021 14:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20210108222223.952458-1-lokeshgidra@google.com>
 <CAHC9VhSLFUyeo8he4t7rFoHgRHfpB=URoAioF+a3+xjZP8JdSQ@mail.gmail.com> <CAHC9VhRGZCRV2T6y80MXtutsZRw4hR+wxgte3__vyG50yAn4qw@mail.gmail.com>
In-Reply-To: <CAHC9VhRGZCRV2T6y80MXtutsZRw4hR+wxgte3__vyG50yAn4qw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 14 Jan 2021 14:50:44 -0800
Message-ID: <CA+EESO5NMjDbJ2wFuvmK8Zkrm1Aafdaf8GZPZkPrK9xeqLH4Ng@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] SELinux support for anonymous inodes and UFFD
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 14, 2021 at 2:47 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Jan 12, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 5:22 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > >
> > > Userfaultfd in unprivileged contexts could be potentially very
> > > useful. We'd like to harden userfaultfd to make such unprivileged use
> > > less risky. This patch series allows SELinux to manage userfaultfd
> > > file descriptors and in the future, other kinds of
> > > anonymous-inode-based file descriptor.
> >
> > ...
> >
> > > Daniel Colascione (3):
> > >   fs: add LSM-supporting anon-inode interface
> > >   selinux: teach SELinux about anonymous inodes
> > >   userfaultfd: use secure anon inodes for userfaultfd
> > >
> > > Lokesh Gidra (1):
> > >   security: add inode_init_security_anon() LSM hook
> > >
> > >  fs/anon_inodes.c                    | 150 ++++++++++++++++++++--------
> > >  fs/libfs.c                          |   5 -
> > >  fs/userfaultfd.c                    |  19 ++--
> > >  include/linux/anon_inodes.h         |   5 +
> > >  include/linux/lsm_hook_defs.h       |   2 +
> > >  include/linux/lsm_hooks.h           |   9 ++
> > >  include/linux/security.h            |  10 ++
> > >  security/security.c                 |   8 ++
> > >  security/selinux/hooks.c            |  57 +++++++++++
> > >  security/selinux/include/classmap.h |   2 +
> > >  10 files changed, 213 insertions(+), 54 deletions(-)
> >
> > With several rounds of reviews done and the corresponding SELinux test
> > suite looking close to being ready I think it makes sense to merge
> > this via the SELinux tree.  VFS folks, if you have any comments or
> > objections please let me know soon.  If I don't hear anything within
> > the next day or two I'll go ahead and merge this for linux-next.
>
> With no comments over the last two days I merged the patchset into
> selinux/next.  Thanks for all your work and patience on this Lokesh.
>
Thanks so much.

> Also, it looks like you are very close to getting the associated
> SELinux test suite additions merged, please continue to work with
> Ondrej to get those merged soon.
>
Certainly! I'm waiting for his reviews for the latest patch.

> --
> paul moore
> www.paul-moore.com
