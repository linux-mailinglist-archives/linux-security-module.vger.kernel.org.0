Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57D57039F
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Jul 2019 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGVPXn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 22 Jul 2019 11:23:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43980 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfGVPXn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 11:23:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so39827172wru.10
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2019 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNIXtMoWHaULzjujraJ7oGg3HCXmRUXf1Hrg+5gPseg=;
        b=Yy0am124r9rOBj+kg/aTljeUfCtQ4wcSIbHJjqJalwkmicDObwQ/YjVsDhv3CjNRsw
         XzngO8FH+3mjssmlknvKnaNiq6lUk8XBHDkyw4vjcCZ650BdJn5b0b1lnXQMh/lmJCpA
         YtFG4I+MH6TlE9DPz70y5vKVrNXLN4sKzFb+C/aRPAwAm8OQWUB3EeaFPLDWITfKYL/H
         uEIDU01tHxYtFak5OWPbRv2gqP0RlWUaS200C489PN4bSRYeObWs4uPIdBQD+1l9u0CP
         bu4Bkz3oHYWLaEalTpJmMBvzPkpCihkXPLFu0UAXggsxQDcbxhy5c54bKxMLp/s0Ye9X
         LhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNIXtMoWHaULzjujraJ7oGg3HCXmRUXf1Hrg+5gPseg=;
        b=punUr/LBYLkzC0xphx2kyxe6ZXcLozbnVQ38TOrmSgqdzkdabmqFXLYjZy/PEJ15KR
         azsDD07UcfrS1V9r5Eo3KgIati413ndBCV3fMZ1jHV8DEfhk+gdTxtkEtukx6M1q8XEN
         8PJKaDWXgQHM4YdPG7zbeqAp+KTBK80igAj+bIbg18HGaesAnz/YTKVbcc1WC+jmr22n
         kMYvDDjxy8kNvd2r+Vz4dy/5HzhUgBM95Vmu0gj1gKZnY37yQ5c7q+W1tvBosfiK1Ovo
         GL51WcvlSOfbQNRYFoA0sw/Awp8Grf1mqmF8RbIeKsxdFaQ/ra9/m8z2yZ3k06LAdFz0
         G57w==
X-Gm-Message-State: APjAAAUP+iqA5c6HMG2dyOmmhadzaowMKPR7ZtJy993t0u6MkUttETfR
        8+EPEnKZudUMpJsVSaVG0leVyx531fmdjqiPNUzytg==
X-Google-Smtp-Source: APXvYqwTtSxr9PAJX9GCQlNlRd7RPOpeKWvqKIkFUyFkVxIfLUXksDf0pIpfWonDTV1oMZAtgfu1AnvjLd8DXlRdLLY=
X-Received: by 2002:a5d:5388:: with SMTP id d8mr75033157wrv.299.1563809020856;
 Mon, 22 Jul 2019 08:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190722114134.3123901-1-arnd@arndb.de> <CAG_fn=UxowACw5w+erKaAPRr4SWk3WbLTfAgJj=cOL4HgZHK=Q@mail.gmail.com>
 <CAK8P3a28c5V5VnsFrttgtCC5+i87yuAT-G5xx50KOsKUJ6-VKg@mail.gmail.com>
In-Reply-To: <CAK8P3a28c5V5VnsFrttgtCC5+i87yuAT-G5xx50KOsKUJ6-VKg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 22 Jul 2019 17:23:28 +0200
Message-ID: <CAG_fn=U60gv-zWiVZS5Z++1fMcLwDmOgoF8gpJY3c+4dGHBhvw@mail.gmail.com>
Subject: Re: [PATCH] [RESEND v2] structleak: disable STRUCTLEAK_BYREF in
 combination with KASAN_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 22, 2019 at 4:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 22, 2019 at 3:43 PM Alexander Potapenko <glider@google.com> w=
rote:
> > On Mon, Jul 22, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > KASAN_STACK is currently implied by KASAN on gcc, but could be made a
> > > user selectable option if we want to allow combining (non-stack) KASA=
N
> > > with GCC_PLUGIN_STRUCTLEAK_BYREF.
> > >
> > > Note that it would be possible to specifically address the files that
> > > print the warning, but presumably the overall stack usage is still
> > > significantly higher than in other configurations, so this would not
> > > address the full problem.
> > >
> > > I could not test this with CONFIG_INIT_STACK_ALL, which may or may no=
t
> > > suffer from a similar problem.
> > We would love to be able to run KASAN together with
> > CONFIG_INIT_STACK_ALL on syzbot, as this will potentially reduce the
> > number of flaky errors.
>
> Doesn't that just limit the usefulness of KASAN, as you no longer catch
> actual accesses to unintialized variables that KASAN is designed to find?
KASAN (unlike KMSAN) doesn't detect accesses to uninitialized variables.
It can of course detect bugs induced by e.g. treating an uninitialized
variable as a pointer or an array index.
Depending on the pattern used to initialize those variables, this can
indeed mask some bugs, but OTOH others will become more reproducible.

I'm not really sure KASAN+CONFIG_INIT_STACK_ALL is a problem right
now, will need to take a look.
> > Given that we already increase the stack size in KASAN builds, how big
> > of a problem are these warnings?
> > Perhaps it's better to disable them in this configuration, or push the =
limit up?
>
> I'm really hoping to lower the per-function limit for 'allmodconfig' buil=
ds,
> since both a high limit and lots of bogus warnings prevent us from
> noticing any newly introduced functions that use a lot of kernel stack
> without KASAN.
>
> An allmodconfig build (and ideally also any randconfig build) should alwa=
ys
> complete without warnings to be useful for compile testing.
>
>        Arnd



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
