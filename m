Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6A12833D
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Dec 2019 21:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLTU0A (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Dec 2019 15:26:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55293 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfLTU0A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Dec 2019 15:26:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so10178417wmj.4
        for <linux-security-module@vger.kernel.org>; Fri, 20 Dec 2019 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F82w7O7bJQNF28hWs+lvXnW6i1xfy6pLutpLzqWVADE=;
        b=XIY3mwDVRWbgQsu1LOMVixa4JMZIeF7X2NtQhRyTtgFRuhG6u0pej3NjeNbkWrktPp
         nyfx4XLoMMkdlF5U1HD8pGqwwCCksL0Nnl88wnXDnidBkqsuNGn0sbr40lOJJ0fjwIAp
         ndP+M0FET6N5v0qnxkETQDVpktPiZK9YO0Ln4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F82w7O7bJQNF28hWs+lvXnW6i1xfy6pLutpLzqWVADE=;
        b=T5vHkkMAp+/IEJijIkX3fH5AwMY6MlXvtbqcVe6eD0i0pbQICgrarsO9ukrpBtSl3N
         yQnIhfReTs1bbtE1ijsj26PVt1iNtlLWMEIL7Bzu+AqWjWpyqtQax1AQywORBCSwRQR2
         ACxK9KiArPoHbPTK4fjnN0tAJR4YWtmoVwDnEaRKvZXQ8vTo7yQiW/ILo+nm55UYy7WB
         V5Ed2gRi5KdCwCFR4eqED0iVXn0Ww8oGfveMhltrkSpBTLyxhQ8gK0IKTXyzsrR0P8z6
         LLJFRL+MYA37Wa66wbb88N1Wr3sAvaOs1iRWC9ZYUeRQdWW74N+J374gubP4sKIu4wOH
         GNKg==
X-Gm-Message-State: APjAAAXBBgMV5JZlzbdpwlQh9WamiY9Ebn6ZPezHaIWL00V5//7N6Ek2
        7iDzYATkdum+JxlC2SPQ2V24CA==
X-Google-Smtp-Source: APXvYqzD0jVBmTut405aAOK5HL7tHQeeRybVZVUmzZpeoqsKMzWWXEjxNE9my1uUxNnwgOqmoouKfg==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr5723657wmb.162.1576873556996;
        Fri, 20 Dec 2019 12:25:56 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w13sm11215931wru.38.2019.12.20.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 12:25:56 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 20 Dec 2019 21:26:02 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor BPF_EVENT context macros
 to its own header.
Message-ID: <20191220202602.GA20287@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-2-kpsingh@chromium.org>
 <CAEf4BzZJf_GBCXYYmE0Hk7O2GdeOr-3VCxdAaxCUk-MHRar3Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZJf_GBCXYYmE0Hk7O2GdeOr-3VCxdAaxCUk-MHRar3Og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 20-Dez 12:10, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > These macros are useful for other program types than tracing.
> > i.e. KRSI (an upccoming BPF based LSM) which does not use
> > BPF_PROG_TYPE_TRACE but uses verifiable BTF accesses similar
> > to raw tracepoints.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  include/linux/bpf_event.h | 78 +++++++++++++++++++++++++++++++++++++++
> >  include/trace/bpf_probe.h | 30 +--------------
> >  kernel/trace/bpf_trace.c  | 24 +-----------
> >  3 files changed, 81 insertions(+), 51 deletions(-)
> >  create mode 100644 include/linux/bpf_event.h
> >
> > diff --git a/include/linux/bpf_event.h b/include/linux/bpf_event.h
> > new file mode 100644
> > index 000000000000..353eb1f5a3d0
> > --- /dev/null
> > +++ b/include/linux/bpf_event.h
> > @@ -0,0 +1,78 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +
> > +/*
> > + * Copyright (c) 2018 Facebook
> > + * Copyright 2019 Google LLC.
> > + */
> > +
> > +#ifndef _LINUX_BPF_EVENT_H
> > +#define _LINUX_BPF_EVENT_H
> > +
> > +#ifdef CONFIG_BPF_EVENTS
> > +
> > +/* cast any integer, pointer, or small struct to u64 */
> > +#define UINTTYPE(size) \
> > +       __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
> > +                  __builtin_choose_expr(size == 2, (u16)2, \
> > +                  __builtin_choose_expr(size == 4, (u32)3, \
> > +                  __builtin_choose_expr(size == 8, (u64)4, \
> > +                                        (void)5)))))
> > +#define __CAST_TO_U64(x) ({ \
> > +       typeof(x) __src = (x); \
> > +       UINTTYPE(sizeof(x)) __dst; \
> > +       memcpy(&__dst, &__src, sizeof(__dst)); \
> > +       (u64)__dst; })
> > +
> > +#define __CAST0(...) 0
> > +#define __CAST1(a, ...) __CAST_TO_U64(a)
> > +#define __CAST2(a, ...) __CAST_TO_U64(a), __CAST1(__VA_ARGS__)
> > +#define __CAST3(a, ...) __CAST_TO_U64(a), __CAST2(__VA_ARGS__)
> > +#define __CAST4(a, ...) __CAST_TO_U64(a), __CAST3(__VA_ARGS__)
> > +#define __CAST5(a, ...) __CAST_TO_U64(a), __CAST4(__VA_ARGS__)
> > +#define __CAST6(a, ...) __CAST_TO_U64(a), __CAST5(__VA_ARGS__)
> > +#define __CAST7(a, ...) __CAST_TO_U64(a), __CAST6(__VA_ARGS__)
> > +#define __CAST8(a, ...) __CAST_TO_U64(a), __CAST7(__VA_ARGS__)
> > +#define __CAST9(a, ...) __CAST_TO_U64(a), __CAST8(__VA_ARGS__)
> > +#define __CAST10(a ,...) __CAST_TO_U64(a), __CAST9(__VA_ARGS__)
> > +#define __CAST11(a, ...) __CAST_TO_U64(a), __CAST10(__VA_ARGS__)
> > +#define __CAST12(a, ...) __CAST_TO_U64(a), __CAST11(__VA_ARGS__)
> > +/* tracepoints with more than 12 arguments will hit build error */
> > +#define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > +
> > +#define UINTTYPE(size) \
> > +       __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
> > +                  __builtin_choose_expr(size == 2, (u16)2, \
> > +                  __builtin_choose_expr(size == 4, (u32)3, \
> > +                  __builtin_choose_expr(size == 8, (u64)4, \
> > +                                        (void)5)))))
> 
> Is it the same macro as above?

Yes, sorry did not notice this. Will fix it in the next revision.

- KP

> 
> > +
> 
> [...]
