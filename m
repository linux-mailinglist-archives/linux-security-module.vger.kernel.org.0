Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D02427FE
	for <lists+linux-security-module@lfdr.de>; Wed, 12 Aug 2020 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHLKE3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 12 Aug 2020 06:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgHLKE2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 06:04:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A0C061787
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 03:04:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so1090988eds.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kveMn0CgVzgGdVO37SLre07hhA5DE1v0+4qD8NOY8tw=;
        b=meHCbgohoEeC4hc/3sMZ6QCAEA9FUFcIJ64vE/4XOtBGCJ8LFfjQFEgukMJIh2Pvot
         /fmUuiXKdoiBfNWEPbdJ4AkbQdQM3NmC8zm334GGtWtQYCqSraq0qRmdpMys765+69Pb
         tPGVyqcwlBQnoez3b76geaZ2Dtsd59vUcEg7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kveMn0CgVzgGdVO37SLre07hhA5DE1v0+4qD8NOY8tw=;
        b=NX33KsDWCZ0OAHuB/bzLg0QZAW4IQZqpsV2RrbOMfktnsw2H+zHuSzLZvayQfChyAe
         4hiJhh2YxfvbKtrFy2x1k/Ycjmp760N9pzRVBE4VWfpYeszfExq4RknmH48JHgB9OVar
         REY5Nlou3jwTbGKnaUudDWvK2DNSiTq/lPsxLGKAaEhz7M4N2FPEy72D0XhFMKHLL2ON
         zMj0OUZA1b3LzvYtMw3POM1FQB6fI/Zu3Vv5UNEyDyxd+4+IvQYID1f9zQaZmlVjf8YB
         ENvZ08lGai/iTtiIL9e2oH1XaxR5kLQpRToH58XYWjbhFiotugtZQ529Vb+9tDHTtNgK
         gUrw==
X-Gm-Message-State: AOAM533tv3TD5Fbr3Df93Cq/ra1dW2fyuLc9p62xRnwXT1rLKY8d9p1u
        DKnNCNBJShtpqH794oG39+owF4NB9ecndzy4its1gw==
X-Google-Smtp-Source: ABdhPJwfjFZ9rdnzWnYSUjRsmmzORGZKTAagxP8wu7SkP1m0JpqC5Md7Y+EUKS8tVWs1GLaPgrI/CGuiH4LIFXoeUG4=
X-Received: by 2002:aa7:d688:: with SMTP id d8mr30572344edr.168.1597226666050;
 Wed, 12 Aug 2020 03:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk> <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
 <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com>
In-Reply-To: <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 12:04:14 +0200
Message-ID: <CAJfpeguMjU+n-JXE6aUQQGeMpCS4bsy4HQ37NHJ8aD8Aeg2qhA@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Wed, Aug 12, 2020 at 11:43 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> Hi,
>
> On 12/08/2020 09:37, Miklos Szeredi wrote:
> [snip]
> >
> > b) The awarded performance boost is not warranted for the use cases it
> > is designed for.

>
> This is a key point. One of the main drivers for this work is the
> efficiency improvement for large numbers of mounts. Ian and Karel have
> already provided performance measurements showing a significant benefit
> compared with what we have today. If you want to propose this
> alternative interface then you need to show that it can sustain similar
> levels of performance, otherwise it doesn't solve the problem. So
> performance numbers here would be helpful.

Definitely.   Will measure performance with the interface which Linus proposed.

I'm not worried, though; the problem with the previous interface was
that it resulted in the complete mount table being re-parsed on each
individual event resulting in quadratic behavior.  This doesn't affect
any interface that can query individual mount/superblock objects.

> Also - I may have missed this earlier in the discussion, what are the
> atomicity guarantees with this proposal? This is the other key point for
> the API, so it would be good to see that clearly stated (i.e. how does
> one use it in combination with the notifications to provide an up to
> date, consistent view of the kernel's mounts)

fsinfo(2) provides version counters on mount and superblock objects to
verify consistency of returned data, since not all data is returned in
a single call.  Same method could be used with the open/read based
interface to verify consistency in case multiple attributes/attribute
groups need to be queried.

Thanks,
Miklos
