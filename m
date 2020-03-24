Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8644C190B3F
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Mar 2020 11:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCXKjP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 24 Mar 2020 06:39:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38831 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCXKjP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 06:39:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so20757804wrv.5
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WNURfYwUOPAnuz+U3UbPZyrljqXKCvMA7vRxyxXRqHM=;
        b=h5BvdxgSXNE2/jma/jYDLUTdGPiB158yhJaCdf6uihjZuDF6ED9XbYBj9gs+33cFnL
         BR1q8lLb2zZjJ4RN+Z9haG820tRE9+3+kaOsQwpzzfqSE2Up3YZf6krsbiTbZGf9WN4m
         xsvkfvQuQ/lQQBEIFooS67t8NoZu9oZvSpcBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WNURfYwUOPAnuz+U3UbPZyrljqXKCvMA7vRxyxXRqHM=;
        b=Gmiu7k9b1hBup6g0J8sgn1VoZBdRursxLaJaYdgt7p1eNNZclE9OHsbqUY7FECVrFX
         R4sM89iUg/5ZY7IsQlLq95WtZzhQy7rDOUBOeGEqcyfy3PDxv1Bf1j2oOgb1hL2pK6yy
         oZ3baYT7ZqpxNVQpBvHHTe3te0E1ih9skJ8XxdUr+ffiffA+Rqxwf0JEk3fVZL+FOB6S
         YzchzwFTpB2V9JSRQfmxnxEbyirXyQI/JsXclN87LyYRZBHA+58bA98a8C5WzfOyd9sR
         6fRpxIZRVEqLSqOJAnbLGHGyyukJWi0X7KHXmPltMTFe8qz/InZdMpoqH3dl08VFgsRN
         UN5A==
X-Gm-Message-State: ANhLgQ2Nnz/0physDDp8ZzNBvv75fQsQRQgzABoP5tdvcMAxp3D/LUjB
        EZt/1qrJryXSEnueKqiXw2PEFw==
X-Google-Smtp-Source: ADFU+vutESD3P5pBkNWr+6YYHHHInBJvKSWgEdKsOHk7IwwLDwihiRPSXNB3MeFkJv8Gax2/4ZxY2A==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr12220191wru.419.1585046353498;
        Tue, 24 Mar 2020 03:39:13 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id b187sm3828624wmb.42.2020.03.24.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:39:12 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 11:39:10 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200324103910.GA7135@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
 <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-M�r 12:59, Andrii Nakryiko wrote:
> On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> > generated for each LSM hook. These nops are initialized as LSM hooks in
> > a subsequent patch.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> >  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >  create mode 100644 include/linux/bpf_lsm.h
> >
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > new file mode 100644
> > index 000000000000..c6423a140220
> > --- /dev/null
> > +++ b/include/linux/bpf_lsm.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +
> > +#ifndef _LINUX_BPF_LSM_H
> > +#define _LINUX_BPF_LSM_H
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/lsm_hooks.h>
> > +
> > +#ifdef CONFIG_BPF_LSM
> > +
> > +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> > +#include <linux/lsm_hook_names.h>
> > +#undef LSM_HOOK
> > +
> > +#endif /* CONFIG_BPF_LSM */
> > +
> > +#endif /* _LINUX_BPF_LSM_H */
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 82875039ca90..530d137f7a84 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -7,6 +7,25 @@
> >  #include <linux/filter.h>
> >  #include <linux/bpf.h>
> >  #include <linux/btf.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/bpf_lsm.h>
> > +
> > +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > + * function where a BPF program can be attached as an fexit trampoline.
> > + */
> > +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> > +
> > +#define LSM_HOOK_int(NAME, ...)                        \
> > +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)        \
> > +{                                              \
> > +       return 0;                               \
> > +}
> > +
> > +#define LSM_HOOK_void(NAME, ...) \
> > +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > +
> 
> Could unify with:
> 
> #define LSM_HOOK(RET, NAME, ...) noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)
> {
>     return (RET)0;
> }
> 
> then you don't need LSM_HOOK_int and LSM_HOOK_void.

Nice.

But, given that we are adding default values and that
they are only needed for int hooks, we will need to keep the macros
separate for int and void. Or, Am I missing a trick here?

- KP

> 
> > +#include <linux/lsm_hook_names.h>
> > +#undef LSM_HOOK
> >
> >  const struct bpf_prog_ops lsm_prog_ops = {
> >  };
> > --
> > 2.20.1
> >
