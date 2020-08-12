Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB461242E76
	for <lists+linux-security-module@lfdr.de>; Wed, 12 Aug 2020 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLSSt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 12 Aug 2020 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLSSq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 14:18:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077BAC061383
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 11:18:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so3304074ljj.7
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=US2q3MwnTSjWfqpie9O3CRcizx9uSCz4S3vkL7p/ooj414+R066sTYC3Q4A4VD1OD6
         WbBdeRdiPaC//fSZsRo3WOoZpu8gTtAt7k7tMZ8hwJVqEhGHjLO4oOIslMbvG22T1LrR
         FvpBZZmDKWHcNGLeiM+6hKFDuuH8IvkNuF9T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=btMVC3Z3VpzNGKETNAYXOlQ8/a9JHSUYuxfAJGUU3tJyHUyGXb7TrHiQQzt3ypnAVR
         /PjY9erF3OcXpMIili8lPoIrfffmGmIFCkP2JkQXTKMVe5AfM2SS8WH7L1Ilgfw/eq9I
         3ZQ/9bF58BKe9nehP3cMnpypa5Lie+Di96gA59Htfm2DE2u/nxEt4dWoKbV9S0Ral+q2
         mj0eGkqEi9Rr36jA74OpVZXY9Mn6NmIn23UklhAvsU18HALiSMQWaKYUcmzfSSgoaSez
         HlYz1/H8bOyMVkwyAqt6HdJN31rMXQjx5qcwD2oYIp1cSL4gQdSJSSYZCABoA0KA54/1
         DNDg==
X-Gm-Message-State: AOAM532vbV+w4JeiCqAIWhEpajk5FIOu7QQMfe85uQIEYnCmYCoyeWGF
        +giVV3gdmHGmcXIdOY2+30zuvmws/0U=
X-Google-Smtp-Source: ABdhPJw55Z9Glgol8Hmh84d0Gy7/09r5q/4vqWuZkhJm3E532R9y5LpZkkvrz0H10q+vFTsY6YG6SA==
X-Received: by 2002:a05:651c:3cd:: with SMTP id f13mr220048ljp.207.1597256324039;
        Wed, 12 Aug 2020 11:18:44 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f3sm600969ljo.81.2020.08.12.11.18.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 11:18:41 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i80so1644122lfi.13
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr315813lfa.192.1597256320205;
 Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
In-Reply-To: <52483.1597190733@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 11:18:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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

On Tue, Aug 11, 2020 at 5:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Well, the start of it was my proposal of an fsinfo() system call.

Ugh. Ok, it's that thing.

This all seems *WAY* over-designed - both your fsinfo and Miklos' version.

What's wrong with fstatfs()? All the extra magic metadata seems to not
really be anything people really care about.

What people are actually asking for seems to be some unique mount ID,
and we have 16 bytes of spare information in 'struct statfs64'.

All the other fancy fsinfo stuff seems to be "just because", and like
complete overdesign.

Let's not add system calls just because we can.

             Linus
