Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264C1248E2F
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Aug 2020 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRSvx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 18 Aug 2020 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSvq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 14:51:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648E3C061342
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 11:51:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so22567675ljj.7
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7uYPAcT0a2iCnawB895QmRQ5uyxHh+JN3tvANE4Kno=;
        b=OfpfhktcB0EPTZRtZL54l/zyIACV/6gX4M1jGmcmJz+vzsbzEUHkXqlwyyhXnVEw/b
         pb0mQNipDGcNuotJJcAm05QIjnugVLc3nSBHazWgWqbIC1R7nPjSnZAExUgdxpbrDVDF
         qQ/ANj0NRdAF1Kakd5EKBxqxVxEd2U/8zf13I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7uYPAcT0a2iCnawB895QmRQ5uyxHh+JN3tvANE4Kno=;
        b=UOxqQuHzDgcSicAH9RLVUwg71Z6VomrOHRh8L/h2eUgLJUErAhpkois/lMa77wLnLw
         8Vn6u12nGjtNg1KDJRMzV7Hi2mnRvmyKm0mQSPpmwsnE6cUHDc6W88Gx+bNeWTeKHu/V
         UT/Et8FDt+nlKm920SGfnDZ0C8LDwCtuHs9fzBmcA7iDzC3MxkJxePLLI0jb9u87vT1H
         dnFvyfyGfcWCdeQO7ec5p5OltaMmfKGQxXxVJ+LWYA23JBLXkhnd6bag8glC6Le85LqC
         9pwead6nlDKRYDmp9Ui/GB3pImoh9Yst+CTwLq//DF7UpSLrN1pC6Gx9OgDyel44iqE3
         QJEA==
X-Gm-Message-State: AOAM5316FnNhz9wn7kwSQWPdxX6TD39i8e7xiEjcku/o2OKMdN0z4oFQ
        7Ynbc2hv6KZR9bdiFCfO8aNg/ug5whZpGw==
X-Google-Smtp-Source: ABdhPJzi2DRjFSfrnEPfwCsMbAjxs1T7z0dF/fFbj6jmgkTiFD0CYyRlrZtTMHJr/VWgkVnHxYyp9Q==
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr10808206ljp.179.1597776703421;
        Tue, 18 Aug 2020 11:51:43 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id i16sm6115575ljn.100.2020.08.18.11.51.41
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 11:51:42 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i19so10761805lfj.8
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 11:51:41 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr10615970lfo.142.1597776701601;
 Tue, 18 Aug 2020 11:51:41 -0700 (PDT)
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
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com> <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
In-Reply-To: <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 11:51:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
Message-ID: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 5:50 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> How do you propose handling variable size attributes, like the list of
> fs options?

I really REALLY think those things should just be ASCII data.

I think marshalling binary data is actively evil and wrong. It's great
for well-specified wire protocols. It's great for internal
communication in user space. It's *NOT* great for a kernel system call
interface.

One single simple binary structure? Sure. That's how system calls
work. I'm not claiming that things like "stat()" are wrong because
they take binary data.

But marshalling random binary structures into some buffer? Let's avoid
that. Particularly for these kinds of fairly free-form things like fs
options.

Those things *are* strings, most of them. Exactly because it needs a
level of flexibility that binary data just doesn't have.

So I'd suggest something that is very much like "statfsat()", which
gets a buffer and a length, and returns an extended "struct statfs"
*AND* just a string description at the end.

And if you don't pass a sufficiently big buffer, it will not do some
random "continuations". No state between system calls. It gets
truncated, and you need to pass a bigger buffer, kind of like
"snprintf()".

I think people who have problems parsing plain ASCII text are just
wrong. It's not that expensive. The thing that makes /proc/mounts
expensive is not the individual lines - it's that there are a lot of
them.

                     Linus
