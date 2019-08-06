Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66AB83707
	for <lists+linux-security-module@lfdr.de>; Tue,  6 Aug 2019 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfHFQc0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 6 Aug 2019 12:32:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44492 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbfHFQcZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Aug 2019 12:32:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so43822961otl.11
        for <linux-security-module@vger.kernel.org>; Tue, 06 Aug 2019 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBxXq8YTWqrzjOONyNdo67CLVjbGNpjfYUbKMPMPSDc=;
        b=I621EdGhepEbCNMhRh/ZLPcDGselbtxmltdR802wrqrXLRID4S5GgQmJEtmeHcB6CX
         AZ7IWSkq384F70ACBOlYgpZHby9PusV2Ob/dS5I2cU/rpeh6VZOVpXML8HzoV12TEIxh
         +MHRnEfuTt8BDqW57xvh2YdBYXbD9YHYhCU6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBxXq8YTWqrzjOONyNdo67CLVjbGNpjfYUbKMPMPSDc=;
        b=Z+sFfadMxYyUzGfM+YTHx2TNme062NmZ/y4shaxJU+WV+KQSzoGI+MnV+rgCmNXRvM
         p70v+u2Jrr8vkOVLRDc1cyw/agF/Zr2lYOjrkV3diZRVpXmUouDT+/UBLoyjhGGjCH6E
         CO26/Dhgt/I3wxkSuZwsyZ19DHs6sf26xvPWn7wKRnZtOjOAjyIKHjXKJt+fjXyYF+co
         SGAioyZ7jffkFS3BPH0s0jy7krL2USGwIEAROwFZAGHTIkIPfiKvmgF3QP93xrQ7xRaM
         SH0sp97eBeFUbBpU1vx611yNoCaUt3nkN5GOIILBCy7MfAQwYNUhra9/TBs/sF6UGrfI
         nmdA==
X-Gm-Message-State: APjAAAU23WPNgHN9Dvd5kZfbFnFU9G/xksv4mYt8F4BPC6Ua4SlJNK05
        On+dOXWzbcUWPU3GfYq8GWNAZAV/k+P3Cjh9za5uLA==
X-Google-Smtp-Source: APXvYqyoPmb4InoTECAZM2ixU1RK2J1UKKqwBWQUbzMA9FlBRHuKXtJkWqf6x4AfDRv9GhjmviHmJs99wWNE6FVoQLI=
X-Received: by 2002:a5d:9bc6:: with SMTP id d6mr4118794ion.160.1565109144963;
 Tue, 06 Aug 2019 09:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
 <20190805142756.GA4887@chatter.i7.local> <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
 <20190805191136.GB4887@chatter.i7.local> <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
 <20190805192727.GA15470@chatter.i7.local>
In-Reply-To: <20190805192727.GA15470@chatter.i7.local>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 6 Aug 2019 09:32:14 -0700
Message-ID: <CAJ-EccPFnR7fTFee3s_1Er+-zbhD8AqaJu_ifTLwHUykKmwJLg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 5, 2019 at 12:27 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, Aug 05, 2019 at 12:17:49PM -0700, Linus Torvalds wrote:
> >> However, I suspect that getting message-ids for all your pull
> >> requests
> >> would significantly complicate your workflow.
> >
> >Yeah, that would be a noticeable annoyance. If I were to process pull
> >requests the way I used to process emailed patches (ie "git am -s" on
> >a mailbox) that would be a natural thing to perhaps do, but it's not
> >at all how it ends up working. Having to save the pull request email
> >to then process it with some script would turn it into a chore.
> >
> >I think the pr-tracker-bot clearly catches most cases as it is, and
> >it's only the occasional "somebody did something odd" that then misses
> >an automated response. Not a huge deal. For me it was actually more
> >the "I didn't understand why the response didn't happen", not so much
> >"I really want to always see responses".
>
> Ok, let me add a fix for Re: at the start -- this won't make things
> significantly more expensive, but will catch this particular corner
> case.
>
> Best regards,
> -K

Linus, thanks for the tips earlier about gitk. I'll use that in the future.

Unfortunately I didn't have the mental model quite right of what
happens during the pull request. I was thinking along the lines of my
commits being cherry picked onto your tree, rather than how it
actually happens with git merge where my tree's commit history needs
to match yours perfectly.
