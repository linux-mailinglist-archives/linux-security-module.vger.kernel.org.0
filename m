Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6562481EA
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Aug 2020 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHRJas (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 18 Aug 2020 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHRJan (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 05:30:43 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6FC061389
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 02:30:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so21219870ejb.11
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6i6GBK3wCZWsxoTDmOd3ySKBv/GJjmU+V1QuwmXmlk=;
        b=ovlkGX8qod/bhtZAl4qKbrC5By2+6D1ouRJLhibBITDMjhaNSGfIZF8qD5afYOF5Nw
         cV3HmxMj4H3TwTUZZL+0v5NHdrDqt/ZYDq/gwxcfRy2TrsVF+JbuOfSgvwm+uVCQwinw
         +XSe4C1sN6eZB5AEceOR647X9E3OJg51aCnWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6i6GBK3wCZWsxoTDmOd3ySKBv/GJjmU+V1QuwmXmlk=;
        b=KIHEQH5ObhuLd6ririBwLMuHjnYyuJ3UO0v+2LLdMe7hkx3XBKft9wR01X6JjT7p3o
         jwylatBlT1vq4eWmXbXc+6Q0Tzdopp2LXrCEYIaURosApqWUp8fTq0Y3r4LCVAoEp6jh
         4y5pmPIbUNjefsonMywuKriHCSlyXfkhX9XW5/asvSAezvbRUHBkwYqA9P1JeC8iKviN
         JTz8CdQA/HPTH+0f7kpaeq4iT2NxYvCWrdMwh0xPZR8bI05N0+UcBljSZBH9KFJ4gxKu
         UOamARj20/49SK33H9qX6VCdG5M3f/NmjcB8txvASAJnY+AKuCG7v3/AMbvfJeuSqEYm
         CrdA==
X-Gm-Message-State: AOAM530puMEWZ/2f5gAsysH2DDBxfpApCEipGX6Z1BNb6XU1d4C619Pf
        c0A7NK788SuyXCZMuIUmxRRKmyjnejzxKWLJdi20mA==
X-Google-Smtp-Source: ABdhPJyWhZ+Aimi0ZuSzLKiWku7A6fJlEGDRdk6YXN2wx1FCgab6GIvDYrRG/JdcRLqANDa9XagvVxIlvjL5Gz03FEI=
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr18796618ejw.443.1597743042044;
 Tue, 18 Aug 2020 02:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk> <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk> <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
 <20200812163347.GS1236603@ZenIV.linux.org.uk> <CAJfpegv8MTnO9YAiFUJPjr3ryeT82=KWHUpLFmgRNOcQfeS17w@mail.gmail.com>
 <20200812173911.GT1236603@ZenIV.linux.org.uk> <20200812183326.GU1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812183326.GU1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 11:30:30 +0200
Message-ID: <CAJfpegs2EkMNthnMvdr5NtLKxfQjTgJYSNhHOMROm0S98OJb4A@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 12, 2020 at 8:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 06:39:11PM +0100, Al Viro wrote:
> > On Wed, Aug 12, 2020 at 07:16:37PM +0200, Miklos Szeredi wrote:
> > > On Wed, Aug 12, 2020 at 6:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Wed, Aug 12, 2020 at 05:13:14PM +0200, Miklos Szeredi wrote:
> > >
> > > > > Why does it have to have a struct mount?  It does not have to use
> > > > > dentry/mount based path lookup.
> > > >
> > > > What the fuck?  So we suddenly get an additional class of objects
> > > > serving as kinda-sorta analogues of dentries *AND* now struct file
> > > > might refer to that instead of a dentry/mount pair - all on the VFS
> > > > level?  And so do all the syscalls you want to allow for such "pathnames"?
> > >
> > > The only syscall I'd want to allow is open, everything else would be
> > > on the open files themselves.
> > >
> > > file->f_path can refer to an anon mount/inode, the real object is
> > > referred to by file->private_data.
> > >
> > > The change to namei.c would be on the order of ~10 lines.  No other
> > > parts of the VFS would be affected.
> >
> > If some of the things you open are directories (and you *have* said that
> > directories will be among those just upthread, and used references to
> > readdir() as argument in favour of your approach elsewhere in the thread),
> > you will have to do something about fchdir().  And that's the least of
> > the issues.
>
> BTW, what would such opened files look like from /proc/*/fd/* POV?  And
> what would happen if you walk _through_ that symlink, with e.g. ".."
> following it?  Or with names of those attributes, for that matter...
> What about a normal open() of such a sucker?  It won't know where to
> look for your ->private_data...
>
> FWIW, you keep refering to regularity of this stuff from the syscall
> POV, but it looks like you have no real idea of what subset of the
> things available for normal descriptors will be available for those.

I have said that IMO using a non-seekable anon-file would be okay for
those.   All the answers fall out of that:  nothing works on those
fd's except read/write/getdents.  No fchdir(), no /proc/*/fd deref,
etc...

Starting with a very limited functionality and expanding on that if
necessary is I think a good way to not get bogged down with the
details.

Thanks,
Miklos
