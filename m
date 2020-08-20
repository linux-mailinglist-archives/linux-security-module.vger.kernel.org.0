Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D224C61C
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Aug 2020 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHTTE4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 20 Aug 2020 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgHTTEv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Aug 2020 15:04:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA23C061386
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2020 12:04:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ba10so2507868edb.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2020 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xswSx5sBRdGqWy7m+JAEwKsyUNhOueCNUf2Bs425COY=;
        b=YgjQySlg/iJIcLjVeYMYfs6nHZ0TBX0Osdu5/PR0ioBTn1qODpMbK2EvPQHig4GYxX
         3WqnjZQFDbDAJOmcrdXxf9yGlAUj6v9DGoFpNDoQYOpcL6UJ/mWdSdo+iexH/aZk2MQw
         vzWyUetDMt9/nhrDW7Jz7QSVwNgmiP+PPChHP8KG3i0kmjU665QRM1KUHpfzQtCWp0nR
         ej5+V+jONMstbL1hYaigI9G9+K1lQePpUskJuhCCauQM6/FVNpiH+5cGabC/a2DSndz2
         4l/DzmqjsMkSjLmuLFt/MM4eqvsC8rkiJUBmlpfNSHGRwQq9K+/xkrnR79i9uBrhBG6f
         yi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xswSx5sBRdGqWy7m+JAEwKsyUNhOueCNUf2Bs425COY=;
        b=OmGKfw0yHl27NOLYmlW8EwM63giOi5xSf74sKDgMWdOj96T0w+QqBCjnAGC2HAQG5Q
         2LAUOCgTvOzLy/gyRgePqbKBZAM/YH3fg/ALiPH+4KULihHTsH97PaXuK19Pa2HjU/5C
         L23VkhKko2Q0f+R4Coth3do2k0IcA87cVYGcLnl6tV/75zFVOvH08laeaC0zgf6o9eyV
         5Qf8E+rRDrpz2qu+A01/4O9UWlKZ1ePMuwwny2CI8VtxHSuOn3YvJdSZf+rduwIKEi3X
         5yg1Pgjcm+EqDINcVnJwWPrVtDSavEVR1YatVnosInjUa0szUKTvsslB47hBxVPahCsw
         t3PA==
X-Gm-Message-State: AOAM530LTtLmiRJEZMNNU+z7SKUs30vp7l+Sy8CG62/dl0RpLCN5JpD3
        LAdX7imyX3skp9ywh+rJKi0gBvc57Pt1kILRk/p9
X-Google-Smtp-Source: ABdhPJxP3ZKSyXy41c6/AE/a3lVkXSCBvxh/urAETB5iN6TCyPfAI8mpYN9YzofauaWw8j1r3dwYubGPqJNkYDdTbtc=
X-Received: by 2002:aa7:cf19:: with SMTP id a25mr4175514edy.67.1597950288828;
 Thu, 20 Aug 2020 12:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200820164753.3256899-1-jackmanb@chromium.org> <alpine.LRH.2.21.2008210439190.29407@namei.org>
In-Reply-To: <alpine.LRH.2.21.2008210439190.29407@namei.org>
From:   KP Singh <kpsingh@google.com>
Date:   Thu, 20 Aug 2020 21:04:32 +0200
Message-ID: <CAFLU3KsS40ANOS=t1gPo7_iL=xzHGAbqyXCjHpVZGM5vLYwEZg@mail.gmail.com>
Subject: Re: [RFC] security: replace indirect calls with static calls
To:     James Morris <jmorris@namei.org>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        keescook@chromium.org, thgarnie@chromium.org,
        paul.renauld.epfl@gmail.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 20, 2020 at 8:43 PM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 20 Aug 2020, Brendan Jackman wrote:
>
> > With this implementation, any overhead of the indirect call in the LSM
> > framework is completely mitigated (performance results: [7]). This
> > facilitates the adoption of "bpf" LSM on production machines and also
> > benefits all other LSMs.
>
> This looks like a potentially useful improvement, although I wonder if it
> would be overshadowed by an LSM hook doing real work.
>

Thanks for taking a look!

We can surely look at other examples, but the real goal is to
optimize the case where the "bpf" LSM adds callbacks to every LSM hook
which don't do any real work and cause an avoidable overhead.

This makes it not very practical for data center environments where
one would want a framework that adds a zero base case overhead and
allows the user to decide where to hook / add performance penalties.
(at boot time for other LSMs and at runtime for bpf)

I also think this would be beneficial for LSMs which use a cache for
a faster policy decision (e.g. access vector caching in SELinux).

- KP

> Do you have any more benchmarking beyond eventfd_write() ?
>
>
>
> >
> > [1]: https://lwn.net/ml/linux-kernel/20200710133831.943894387@infradead.org/

[...]

> >
> >  /* Security operations */
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
