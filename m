Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB94E936
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Jun 2019 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfFUNcw (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 09:32:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36916 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUNcw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 09:32:52 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so1811810iok.4
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOu+sVSXpOqICESmggSM2r4CPCyuPx9bs4vYuIKuU68=;
        b=G3vi2AAOl4hhhusP8y7LXnvpUAsLTdGJFfvknAJ17R1YOy9TvoJJ3x7kaY/yQ4gr7a
         g6a7wOgKUJn9B7X1Wy6wO2KCv+8vRXCkrWcO+VKunYTrgBfaEZq9uyvo/pQQxhF6M0SG
         py8beLFr5Lg5jBqNXGNLWrUfPx7UJMX/0QYzTkkfSkX3opZgtR7tg5A8s/pLHnXvOzF/
         mEFa9x4BTkqGp3bWQ5ZC2svEcgAY9/BX6yekUT6McoUBo4wfUx1f3GcYNs5n6YpCoZdF
         mv2+WJ0uUtJRVmJITvuMqg9rf0Y0r8Sjeb9VAh/s5Mdklc02L9tX5a88QkRnlEBhNTqp
         wiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOu+sVSXpOqICESmggSM2r4CPCyuPx9bs4vYuIKuU68=;
        b=RNWqXbEw6dP1voCkiqbO1RF8wG+J1wephdxx0rFK1XnH4ddAc9dLmtY3lfmgcQb+LX
         jjmtv7C1tO8CkHBm5jXzNWi7GxVMUgnzCtAv1dphpC+n1O6M3xNE3XYr6/FN5xWo/LLU
         QSUQAJDDR74K9fkI/k7YTRqrFwgacmo4JUmYGmUgLDL9hv2C+S2hAVt2jYjQW5DHWry5
         uXXloYx8XBfM94QrOy7nNDTyVFOXFtx87xCwIBrPKemQIvGVq4/H4oTjJuLQD6Y/jixb
         PSmBRmNf3PPe2a3QQqdAHlNayevENN1kWMZRsWWUHeqZd/ElrOSJd2QlszKkNV7sHvTZ
         /Agg==
X-Gm-Message-State: APjAAAUWZCq/iPEotzIX4houiDofHFcFSZWDNuyvvwSK0n/eYCbzvqSi
        imKWlsoYiVH1CbvY/NNtJ10qng9MU3WbWXM3/vgRXQ==
X-Google-Smtp-Source: APXvYqywBx+off9TrCkhXHGnxEFiuOzAKv+SiaNKvZJdidbzBrWYeoOWgFVT6uKrIaXpibz3u3FQ/cPBVwvmh4sxkd0=
X-Received: by 2002:a02:1a86:: with SMTP id 128mr8265567jai.95.1561123971509;
 Fri, 21 Jun 2019 06:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190618094731.3677294-1-arnd@arndb.de> <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
In-Reply-To: <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 15:32:40 +0200
Message-ID: <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 21 Jun 2019 at 11:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 20, 2019 at 7:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> > > The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> > > leads to much larger kernel stack usage, as seen from the warnings
> > > about functions that now exceed the 2048 byte limit:
> >
> > Is the preference that this go into v5.2 (there's not much time left),
> > or should this be v5.3? (You didn't mark it as Cc: stable?)
>
> Having it in 5.2 would be great. I had not done much build testing in the last
> months, so I didn't actually realize that your patch was merged a while ago
> rather than only in linux-next.
>
> BTW, I have now run into a small number of files that are still affected
> by a stack overflow warning from STRUCTLEAK_BYREF_ALL. I'm trying
> to come up with patches for those as well, we can probably do it in a way
> that also improves the affected drivers. I'll put you on Cc when I
> find another one.
>

There is something fundamentally wrong here, though. BYREF_ALL only
initializes variables that have their address taken, which does not
explain why the size of the stack frame should increase (since in
order to have an address in the first place, the variable must already
have a stack slot assigned)

So I suspect that BYREF_ALL is defeating some optimizations where.
e.g., the call involving the address of the variable is optimized
away, but the the initialization remains, thus forcing the variable to
be allocated in the stack frame even though the initializer is the
only thing that references it.
