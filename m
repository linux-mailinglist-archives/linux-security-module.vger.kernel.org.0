Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54ED248FB9
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Aug 2020 22:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRUxd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 18 Aug 2020 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgHRUxc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 16:53:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A280C061389
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 13:53:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so22991292ljk.6
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44jjlz9gHZ8bxkxJCT+KFdrq1JkP5ys9BBa+Qk39NAU=;
        b=KmKfogzwUujvQb/F0JA/vopaWbvFysSlsxJrpItNo5RKDQ8MIZrythcEa0jhqcR97h
         6k/jvzQGWfMSCchn3FxL3xWMnBP2o1wmrl8y6sRimpA8Bh+iDfzxbjypP5Ke/mhWrexJ
         Ac+8fu9qUv1fiSsbJIE2/XWj5iLbyNhOIcPwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44jjlz9gHZ8bxkxJCT+KFdrq1JkP5ys9BBa+Qk39NAU=;
        b=sHwxuuANzeOtJp7mvV6hhv8psNwhfGGc8hnlXjThJQUDxZka/zYeA4I0ykUP38GehA
         VHbDjD3ufbQqreByrsJHBp7vTZX0Qkco2IxMB+SY5fqp3hikbi+8u9rHQsDU/EbQHZKt
         CX+oupYwYzZyBRYWLMD9qEik4BV9zJESbG39xclxWfAOgGRu+bzVugpB7HS6NCHQ+FDT
         5h77y9wOVvTOrucLVJEejKgJea0RvmEiC7LB4pdyLJb/qOlk/16j0YhaaZ8n0vv8OYvP
         vIZRwuu62ZWMVj5kCJW6dJ/i3ROO9Qk6J3IwyXh48x5YU1AQlMT8HaOgHeULAx0hSuBO
         yetw==
X-Gm-Message-State: AOAM531jaWSThktZeoNJrk/Ej7ZJSqI9dCLoNfSVUsc3fFwvWwq9FfcC
        uoXKyCR3lJRlfwCZyQsWuqhvmRvShz6ybg==
X-Google-Smtp-Source: ABdhPJyjmWpDgd2FQU8abx6XPTz25LHwl/qpUn4AcghRzYkgtr4HdOybkXnICE1a9ylNQoVjzBWjvw==
X-Received: by 2002:a2e:9a0b:: with SMTP id o11mr4112185lji.352.1597784009211;
        Tue, 18 Aug 2020 13:53:29 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d26sm6764433lfq.73.2020.08.18.13.53.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 13:53:28 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id f26so22961018ljc.8
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 13:53:27 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr9400093ljk.421.1597784007533;
 Tue, 18 Aug 2020 13:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
 <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
 <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com> <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com>
In-Reply-To: <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 13:53:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUcfgC1PdbS_4mfAj2+VTacOwD_uUu6krSxjpvh42T7A@mail.gmail.com>
Message-ID: <CAHk-=wiUcfgC1PdbS_4mfAj2+VTacOwD_uUu6krSxjpvh42T7A@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
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

On Tue, Aug 18, 2020 at 1:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> So why mix a binary structure into it?  Would it not make more sense
> to make it text only?

.. because for basic and standard stuff, the binary structure just
makes sense and is easier for everybody.

When I want to get the size of a file, I do "stat()" on it, and get
the size from st.st_size. That's convenient, and there's no reason
_not_ to do it. Returning the size as an ASCII string would be
completely pointless and annoying as hell.

So binary formats have their places. But those places are for standard
and well-understood fields that are commonly accessed and do not have
any free-form or wild components to them that needs to be marshalled
into some binary format.

Whenever you have free-form data, just use ASCII.

It's what "mount" already uses, for chrissake. We pass in mount
options as ASCII for a good reason.

Basically, I think a rough rule of thumb can and should be:

 - stuff that the VFS knows about natively and fully is clearly pretty
mount-agnostic and generic, and can be represented in whatever
extended "struct statfs_x" directly.

 - anything that is variable-format and per-fs should be expressed in
the ASCII buffer

Look at our fancy new fs_context - that's pretty much what it does
even inside the kernel. Sure, we have "binary" fields there for core
basic information ("struct dentry *root", but also things like flags
with MNT_NOSUID), but the configuration stuff is ASCII that the
filesystem can parse itself.

Exactly because some things are very much specific to some
filesystems, not generic things.

So we fundamentally already have a mix of "standard FS data" and
"filesystem-specific options", and it's already basically split that
way: binary flag fields for the generic stuff, and ASCII text for the
odd options.

Again: binary data isn't wrong when it's a fixed structure that didn't
need some odd massaging or marshalling or parsing. Just a simple fixed
structure. That is _the_ most common kernel interface, used for almost
everything.  Sometimes we have arrays of them, but most of the time
it's a single struct pointer.

But binary data very much is wrong the moment you think you need to
have a parser to read it, or a marshaller to write it. Just use ASCII.

I really would prefer for the free-form data to have a lot of
commonalities with the /proc/mounts line. Not because that's a
wonderful format, but because there are very very few truly wonderful
formats out there, and in the absense of "wonderful", I'd much prefer
"familiar" and "able to use common helpers" (hopefully both on the
kernel side and the user side)..

               Linus
