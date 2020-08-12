Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81E242BF3
	for <lists+linux-security-module@lfdr.de>; Wed, 12 Aug 2020 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHLPNa (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 12 Aug 2020 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgHLPN3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 11:13:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573DC061385
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 08:13:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cq28so1790894edb.10
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VN6ir83bMjgYQIdeAbdj93K7AbOe8f4BRPi3nEgO7zE=;
        b=VndYFHLsjboSueemTm/gTWyU/6d+bUbeH7HKxWM99Yng+XUQUYNG/AbXbblBZBH/An
         /D674H4Y7QIjzxINCgZkEWjRdtLus6PyQhylX/IDuaUQ2j/48lydT4RO0vFLUPvqjs0i
         laNjZmgU04BRpDmsumDv8mvr+p3mwHETI4Oyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VN6ir83bMjgYQIdeAbdj93K7AbOe8f4BRPi3nEgO7zE=;
        b=PrPW88Rt6lMtD1ZZCjdfzEh6TBz/KSWvA6SOBEx6z41HtMWetY97MYmGmtJ/AFcSzS
         E69HZVuXgdGLcfqAHXlrUWd7lK8vVG2ORwhf+2Wo1zsWuYwo3ZHrjx54Z9lp8jTBQ3Rs
         vVx5O3di/boB8ULjacKXHGPY84pkyKhUVynAom09+cp7WEYB2E4juOJL1Rqf7imhGEKo
         s2+J1y46QF+a/EDZsZih7fhlvrd4ZwZ0lvLgRp0Xj672oGaEz1EPyjkg67A/F1RBxxnV
         Ia/z1yQpO1+7AE6d7Ecz8Add7SNGSu8RyQcNeASbvLrHc4sjlUhSQWU52oIoL+49TDSi
         +ThA==
X-Gm-Message-State: AOAM532N2D9wxqwEd2BHg6cV4/lBLdScTEl3HyD3ZbLFHfgoSDotJ4NA
        qu2PtIlBhy9GVvUG/CwjI3RH5P4YYTpXAAsL72bXYQ==
X-Google-Smtp-Source: ABdhPJx4u1q1FLW556zPlIsLcP302q5ujVZaE+rGeWv7TC31XhI4j+ua8W7rg17I4ZmHnOSV4oPmxDB/frsEThGPkcc=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr368514edx.161.1597245205349;
 Wed, 12 Aug 2020 08:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk> <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812150807.GR1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 17:13:14 +0200
Message-ID: <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
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

On Wed, Aug 12, 2020 at 5:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 04:46:20PM +0200, Miklos Szeredi wrote:
>
> > > "Can those suckers be passed to
> > > ...at() as starting points?
> >
> > No.
>
> Lovely.  And what of fchdir() to those?

Not allowed.

> Are they all non-directories?
> Because the starting point of ...at() can be simulated that way...
>
> > >  Can they be bound in namespace?
> >
> > No.
> >
> > > Can something be bound *on* them?
> >
> > No.
> >
> > >  What do they have for inodes
> > > and what maintains their inumbers (and st_dev, while we are at
> > > it)?
> >
> > Irrelevant.  Can be some anon dev + shared inode.
> >
> > The only attribute of an attribute that I can think of that makes
> > sense would be st_size, but even that is probably unimportant.
> >
> > >  Can _they_ have secondaries like that (sensu Swift)?
> >
> > Reference?
>
> http://www.online-literature.com/swift/3515/
>         So, naturalists observe, a flea
>         Has smaller fleas that on him prey;
>         And these have smaller still to bite 'em,
>         And so proceed ad infinitum.
> of course ;-)
> IOW, can the things in those trees have secondary trees on them, etc.?
> Not "will they have it in your originally intended use?" - "do we need
> the architecture of the entire thing to be capable to deal with that?"

No.

>
> > > Is that a flat space, or can they be directories?"
> >
> > Yes it has a directory tree.   But you can't mkdir, rename, link,
> > symlink, etc on anything in there.
>
> That kills the "shared inode" part - you'll get deadlocks from
> hell that way.

No.  The shared inode is not for lookup, just for the open file.

>  "Can't mkdir" doesn't save you from that.  BTW,
> what of unlink()?  If the tree shape is not a hardwired constant,
> you get to decide how it's initially populated...
>
> Next: what will that tree be attached to?  As in, "what's the parent
> of its root"?  And while we are at it, what will be the struct mount
> used with those - same as the original file, something different
> attached to it, something created on the fly for each pathwalk and
> lazy-umounted?  And see above re fchdir() - if they can be directories,
> it's very much in the game.

Why does it have to have a struct mount?  It does not have to use
dentry/mount based path lookup.

Thanks,
Miklos
