Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80AA39B1C8
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Jun 2021 07:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhFDFGg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 4 Jun 2021 01:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFDFGf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Jun 2021 01:06:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BEC061760
        for <linux-security-module@vger.kernel.org>; Thu,  3 Jun 2021 22:04:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jt22so12545677ejb.7
        for <linux-security-module@vger.kernel.org>; Thu, 03 Jun 2021 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4KNkxgVBE2IaKKrWIflXpiMTxbcNGtO3JcMgEhgrn4=;
        b=o94bs7U9IPq9Pa1huceut2mtx1/qS1BIzr2m7/D0ElSnvLcgt/EZJzk5KB3yZ4Skz8
         o90x3f6tanRZ1P65uIu/7LtBEKoZ7BXvggS5EGo5YSO41QLKC9oI16QIQhUwg4JOUL8d
         JslQuUfN6xT67ucLy6w+SLo2zZNYLDC7n4wH/8coHXDqIRphosK91tA1d/iUaT/itW40
         TzTUGjHJH7VgOgntc+QjbNxfCSId1gNZ2lzAIOvt2s1XPzUirumPWP9K/SmySReNkdOi
         uJNHPw5+1cE6NMrrKaEyRYIH3hizdNeDjUGUKNZlCY/Vi/Z1SEPuW1foC3jGUA2xY2cy
         PYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4KNkxgVBE2IaKKrWIflXpiMTxbcNGtO3JcMgEhgrn4=;
        b=Hg00g66aJ7U4dYCm3SCrVuhQSkp7S6l8ZMPooukK2Uwn3bJNuR5a20T894hQ5P6ZRU
         HGJKcCtoJOwp8TtUEUknZ+BnRUGQ7FnGZ+fi0VsFpN4YAVAQrM2rtRkyXy2nS1W/JtJL
         SP5KklyimwHrOAxc1exyy1VmUobVfzHJzZGnI4WNJFQB6LYP4cL82AYBQjcOgeXkGc5D
         /6NeYI/VLn2r9kp60Dqx5ymxO3Fqx5ccd++QpBt9/zzbrdIK9LUfaKp3rIk8fYYtZt7s
         IOdtBxO7Oz8EW9h3RTaIaUFBAlsUNDFbYfIpeyBgx+NivaPrMF94shUKQbphlrYFnXz7
         lYBw==
X-Gm-Message-State: AOAM532B+iyriJmGXua/SHy73P86zNN8TrYC0gm/Diw35Nb2Rm3hhBCz
        QWyWR76V1G26TCNM1gAqSQ5jjsmpDhlZhKqcF/dG
X-Google-Smtp-Source: ABdhPJwJrbIpifPHt0RmxDhbFGonFTcmrxomuiF8TJjro/LYRcNy1Ukcm+dNkb4N5xI5Zs6y+uH7Kz1ctjm94ABTP34=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr2438703ejk.488.1622783076402;
 Thu, 03 Jun 2021 22:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <162163379461.8379.9691291608621179559.stgit@sifl> <f07bd213-6656-7516-9099-c6ecf4174519@gmail.com>
 <CAHC9VhRjzWxweB8d8fypUx11CX6tRBnxSWbXH+5qM1virE509A@mail.gmail.com>
 <162219f9-7844-0c78-388f-9b5c06557d06@gmail.com> <CAHC9VhSJuddB+6GPS1+mgcuKahrR3UZA=1iO8obFzfRE7_E0gA@mail.gmail.com>
 <8943629d-3c69-3529-ca79-d7f8e2c60c16@kernel.dk> <CAHC9VhTYBsh4JHhqV0Uyz=H5cEYQw48xOo=CUdXV0gDvyifPOQ@mail.gmail.com>
 <9e69e4b6-2b87-a688-d604-c7f70be894f5@kernel.dk> <3bef7c8a-ee70-d91d-74db-367ad0137d00@kernel.dk>
 <fa7bf4a5-5975-3e8c-99b4-c8d54c57da10@kernel.dk> <a7669e4a-e7a7-7e94-f6ce-fa48311f7175@kernel.dk>
 <CAHC9VhSKPzADh=qcPp7r7ZVD2cpr2m8kQsui43LAwPr-9BNaxQ@mail.gmail.com>
 <b20f0373-d597-eb0e-5af3-6dcd8c6ba0dc@kernel.dk> <CAHC9VhRZEwtsxjhpZM1DXGNJ9yL59B7T_p2B60oLmC_YxCrOiw@mail.gmail.com>
 <CAHC9VhSK9PQdxvXuCA2NMC3UUEU=imCz_n7TbWgKj2xB2T=fOQ@mail.gmail.com> <46381e4e-a65d-f217-1d0d-43d1fa8a99aa@kernel.dk>
In-Reply-To: <46381e4e-a65d-f217-1d0d-43d1fa8a99aa@kernel.dk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Jun 2021 01:04:25 -0400
Message-ID: <CAHC9VhSMhygpyDQVv+BM9aq7z6_7grEYWKZA5Mb5zvV3eA+_6w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] audit,io_uring,io-wq: add some basic audit
 support to io_uring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 3, 2021 at 11:54 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 5/28/21 10:02 AM, Paul Moore wrote:
> > On Wed, May 26, 2021 at 4:19 PM Paul Moore <paul@paul-moore.com> wrote:
> >> ... If we moved the _entry
> >> and _exit calls into the individual operation case blocks (quick
> >> openat example below) so that only certain operations were able to be
> >> audited would that be acceptable assuming the high frequency ops were
> >> untouched?  My initial gut feeling was that this would involve >50% of
> >> the ops, but Steve Grubb seems to think it would be less; it may be
> >> time to look at that a bit more seriously, but if it gets a NACK
> >> regardless it isn't worth the time - thoughts?
> >>
> >>   case IORING_OP_OPENAT:
> >>     audit_uring_entry(req->opcode);
> >>     ret = io_openat(req, issue_flags);
> >>     audit_uring_exit(!ret, ret);
> >>     break;
> >
> > I wanted to pose this question again in case it was lost in the
> > thread, I suspect this may be the last option before we have to "fix"
> > things at the Kconfig level.  I definitely don't want to have to go
> > that route, and I suspect most everyone on this thread feels the same,
> > so I'm hopeful we can find a solution that is begrudgingly acceptable
> > to both groups.
>
> Sorry for the lack of response here, but to sum up my order of
> preference:
>
> 1) It's probably better to just make the audit an opt-out in io_op_defs
>    for each opcode, and avoid needing boiler plate code for each op
>    handler. The opt-out would ensure that new opcodes get it by default
>    it someone doesn't know what it is, and the io_op_defs addition would
>    mean that it's in generic code rather then in the handlers. Yes it's
>    a bit slower, but it's saner imho.
>
> 2) With the above, I'm fine with adding this to io_uring. I don't think
>    going the route of mutual exclusion in kconfig helps anyone, it'd
>    be counter productive to both sides.
>
> Hope that works and helps move this forward. I'll be mostly out of touch
> the next week and a half, but wanted to ensure that I sent out my
> (brief) thoughts before going away.

Thanks Jens.  I'll revise the patchset based on this (basically doing
an opt-out version of what you did on May 26th) and do a v2 post with
the other accumulated fixes/changes.  If there is anything else that
needs discussion/review I'm sure Pavel can help us out, he's been
helpful thus far.

--
paul moore
www.paul-moore.com
