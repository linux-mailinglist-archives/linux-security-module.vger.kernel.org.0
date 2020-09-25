Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD26278FBF
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Sep 2020 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgIYRid (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 25 Sep 2020 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYRid (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 Sep 2020 13:38:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B74CC0613CE
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2020 10:38:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y11so3709773lfl.5
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2020 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xV1ixFKYBYzs9xQqtXfpj87vpxE9fe3bTqmPmwrmWRA=;
        b=fx6QQkhaEaLL0IKUt52H3mzpFGb3zgZouYy5OWhuqmRYp9EJXuJxfucb1VNywFmJBp
         z+VoiRTM4dfJhadiLfJOAFLLSWYu9fOPhVDXnKtf+Uut9p4/+eQ39wnmESomu2cg7F9e
         jWPjxuon8GFrLiwrLCrEukW0y5tUfyxnjOFNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xV1ixFKYBYzs9xQqtXfpj87vpxE9fe3bTqmPmwrmWRA=;
        b=IrJ3b7comdHdQkHrp5ljeW4ak5/w0zpDecrx7hjTqEnXv/GiZ/l4jbgpfYK9YiB4jz
         w17CcXmv+PfX57zuPtUv4sVRXaS80qtgWychQycHW7sx1KBQJm+IIyKrY0QdZFkoTzgb
         fIbdhPg83C+VIMboYQYW+XvOLnFUFgNkB6ZAeduz8YFbON3JiLbHcGJEIRe4XASLi8R/
         lG7K5AaNkv5hRJjKFvBGSxDpsMfPogw07plB7XDKlzAA7tkhyxDEgcf9on6k8pf9XgAt
         ec1RxSz/vD0oOsDbjEmHUbKvacC8b1Yz0RZBAyNEbODS5RTKfGzpPn6718v6WmYPty4f
         93CQ==
X-Gm-Message-State: AOAM531kSaHV0gR8g1ADXnFZRoVp/mxdrH5tHFeRbst2CKthzAHgDQrj
        VFJkr1J578JwcNVgeIqKJ2oANdedhds3Sg==
X-Google-Smtp-Source: ABdhPJxyUup5bdsE9O9VT77Rjkuxce4gZzDYHeoyEANnSTgWGkmjeWghUHNKMF5dwVau3h1mCENzVA==
X-Received: by 2002:a19:4a8a:: with SMTP id x132mr1619174lfa.423.1601055510639;
        Fri, 25 Sep 2020 10:38:30 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 73sm2771493lfi.229.2020.09.25.10.38.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:38:29 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s205so3125031lja.7
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2020 10:38:29 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr1638882ljj.102.1601055508689;
 Fri, 25 Sep 2020 10:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
 <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com> <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
In-Reply-To: <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 10:38:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
Message-ID: <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 25, 2020 at 6:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Sep 24, 2020 at 4:16 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Up-thread I thought Linus indicated he didn't really want a flag to
> > disable pemission checking due to potential abuse (and I agree).
>
> IIUC he was against adding an FMODE flag, while I was rather
> suggesting a new function parameter (I realize it probably wasn't
> clear from what I wrote).

I really would prefer neither.

Any kind of dynamic behavior that depends on a flag is generally worse
than something that can be statically seen.

Now, if the flag is _purely_ a constant argument in every single user,
and there's no complex flow through multiple different layers, an
argument flag is certainly fairly close to just having two different
functions for two different behaviors.

But I don't really see much of an advantage to adding a new argument
to kernel_write() for this - because absolutely *nobody* should ever
use it apart from this very special autofs case.

So I'd rather just re-export the old __kernel_write() (or whatever it
was that broke autofs) that didn't do that particular check. We
already use it for splice and core dumping.

autofs isn't that different from those two, and I think the only real
difference is that autofs is a module. No?

So I think the fix is as simple as exporting __kernel_write() again -
and let's just make it a GPL-only export since we really don't want
anybody to use it - and revert  commit 13c164b1a186 ("autofs: switch
to kernel_write").

Hmm?

             Linus
