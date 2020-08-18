Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849A1248218
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Aug 2020 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHRJlq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 18 Aug 2020 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRJlo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 05:41:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA3CC061343
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 02:41:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p24so21260921ejf.13
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dv1Xhl1bS+5jEQYbFML/aNrkT6FMSIT4YIWLINTkYuA=;
        b=TKBIZQ9cEM0s7XlAhqk+9WuMaJ5WAzHt28fYx7z2YcY+Ky15uWjPK9XQAlE4GEUNqa
         mV0SnmJ2Gpom5vx/h8sEIfNfZa5zbCrKs2dnoVh0T89qV+LR7R+5+3MROncxObXPQArg
         /jnklxkh2Vw4IJ9BkaOQd5d8BqCmxE3VXbUS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dv1Xhl1bS+5jEQYbFML/aNrkT6FMSIT4YIWLINTkYuA=;
        b=XjNtPKOh4cOnl9wZEHz2UU7ljRUDCDLzacimI06Bg2tOOnt+VQ1xe1S7IBxxZUVyXM
         XlUW1pfe7omRtmCf8W3vGKmGpEJdJlt0WzKqyCE1JrYyM5P6Hnto4RM47/aAsVfA0aFT
         lXwrd6J8ysiaywsqrFzLN7Gwj1itKtgVcwFQCmP9cOxLo0WSRA4a1xJpM05sLW/ncWkH
         U6gLuqZyMBRj9BKPYuEpvdWdE7q44nBpoWGq3PmWaoC/vC7QX2KGaOrXsRhQ8Qn3CtbT
         Xb+OIkx15MZDcipW21UxgsF2g5qagwPaVhm8ZquC+XuuYk8iYzKWmDI4DTaIBIndrL9o
         MajA==
X-Gm-Message-State: AOAM530+6hZAiTD8ZEJ4bsZIDDdWQGyEc2CGlSHiDYPs43+kUrarwWEs
        xziDzQ3y7QGfwPEZW82RnsP/Wt4L7rgtoYjr1ehQuA==
X-Google-Smtp-Source: ABdhPJzt1EdcvKZCvCY2Z46UPxjvinPUBrda1Z9vw7Mvqcsu6bquKdK/yTIXHnA8ZslRVtZfcgEoy+b/s/oUX8tNtng=
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr19044858ejc.110.1597743701266;
 Tue, 18 Aug 2020 02:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk> <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk> <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
 <20200812163347.GS1236603@ZenIV.linux.org.uk> <CAJfpegv8MTnO9YAiFUJPjr3ryeT82=KWHUpLFmgRNOcQfeS17w@mail.gmail.com>
 <20200812173911.GT1236603@ZenIV.linux.org.uk> <20200812183326.GU1236603@ZenIV.linux.org.uk>
 <20200812213041.GV1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812213041.GV1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 11:41:29 +0200
Message-ID: <CAJfpeguyQhfxrSnaH1mZkncgfiLFB2yM2ZgdMBzuhAdKdmmuxA@mail.gmail.com>
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

On Wed, Aug 12, 2020 at 11:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 07:33:26PM +0100, Al Viro wrote:
>
> > BTW, what would such opened files look like from /proc/*/fd/* POV?  And
> > what would happen if you walk _through_ that symlink, with e.g. ".."
> > following it?  Or with names of those attributes, for that matter...
> > What about a normal open() of such a sucker?  It won't know where to
> > look for your ->private_data...
> >
> > FWIW, you keep refering to regularity of this stuff from the syscall
> > POV, but it looks like you have no real idea of what subset of the
> > things available for normal descriptors will be available for those.
>
> Another question: what should happen with that sucker on umount of
> the filesystem holding the underlying object?  Should it be counted
> as pinning that fs?

Obviously yes.

> Who controls what's in that tree?

It could be several entities:

 - global (like mount info)
 - per inode (like xattr)
 - per fs (fs specific inode attributes)
 - etc..

>  If we plan to have xattrs there,
> will they be in a flat tree, or should it mirror the hierarchy of
> xattrs?  When is it populated?  open() time?  What happens if we
> add/remove an xattr after that point?

From the interface perspective it would be dynamic (i.e. would get
updated on open or read).  From an implementation POV it could have
caching, but that's not how I'd start out.

> If we open the same file several times, what should we get?  A full
> copy of the tree every time, with all coherency being up to whatever's
> putting attributes there?
>
> What are the permissions needed to do lookups in that thing?

That would depend on what would need to be looked up.  Top level would
be world readable, otherwise it would be up to the attribute/group.

>
> All of that is about semantics and the answers are needed before we
> start looking into implementations.  "Whatever my implementation
> does" is _not_ a good way to go, especially since that'll be cast
> in stone as soon as API becomes exposed to userland...

Fine.

Thanks,
Miklos
