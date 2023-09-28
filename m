Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320E27B0EF8
	for <lists+linux-security-module@lfdr.de>; Thu, 28 Sep 2023 00:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI0Wht (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 27 Sep 2023 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0Wht (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Sep 2023 18:37:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57AC102
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 15:37:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62553C433D9
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695854267;
        bh=B0S2n6HCp+FeFWR6Fny0wbL6CcXc6eGDsU9YyqjQlDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lk90xudp6/8jNffKHL0+ctBHAh2C+7MErHcFEykSY8gKo1VbBhlSutF8ESPm0c2xP
         WlU906JtcQINTY45c/ArpqmWXFopWHhpmXgol8/6t0T++LZ1Ikmf5QXPm1roTEDtlW
         LGbyIvYsWfuxDlSDJNEog2d32jqc1LqrBsUSCneJf9pwKP1IjMKhoPORuUFe0v8FQl
         owluvSmhphiW1OGU1pPnqsyPeVgXa9LX188JErBqpdfQCMQIb3oHrG0lr+8mTXUHrN
         jYY6OtgiiWUrSmWt7EFdhbfm4L+hRWds4s1B2yqH9vvyf0Fb9kqgwmAPQwqjqg5cY9
         PRgrTvjuh3kHA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50444e756deso15812158e87.0
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 15:37:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyduz93oQt7ua30X6l0DKPdxaUUVQOjqpyoMU8I5JctisOTC9wz
        F5tY2ADOqzi8RPs1qf3WLQYNkEKD1TRG1RNfMQwQXQ==
X-Google-Smtp-Source: AGHT+IFOdQVmyavPxMnA/9OYQyOmx+BCIQjxi2syAwTxGcpfr9IvvpQAP08ajlezmoqX2DNS8flu/11a5lqqfyIKKz8=
X-Received: by 2002:ac2:58e7:0:b0:504:3c1f:cbd1 with SMTP id
 v7-20020ac258e7000000b005043c1fcbd1mr2785491lfo.12.1695854265473; Wed, 27 Sep
 2023 15:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922145505.4044003-3-kpsingh@kernel.org>
 <202309220848.010A198E7@keescook> <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
In-Reply-To: <CACYkzJ4yCuQTbxPMVc5T=KO-jeu8=0mCUNcVapacJpOxPOp=EQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 28 Sep 2023 00:37:34 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5Th50nOsgxxNqJNMjWZBSPPD9wxRX7YLui5_LHbc43vw@mail.gmail.com>
Message-ID: <CACYkzJ5Th50nOsgxxNqJNMjWZBSPPD9wxRX7YLui5_LHbc43vw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 6:07=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Fri, Sep 22, 2023 at 5:50=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On Fri, Sep 22, 2023 at 04:55:02PM +0200, KP Singh wrote:
> > > These macros are a clever trick to determine a count of the number of
> > > LSMs that are enabled in the config to ascertain the maximum number o=
f
> > > static calls that need to be configured per LSM hook.
> > >
> > > Without this one would need to generate static calls for the total
> > > number of LSMs in the kernel (even if they are not compiled) times th=
e
> > > number of LSM hooks which ends up being quite wasteful.
> > >
> > > Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Acked-by: Song Liu <song@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> >
> > Thought below, but regardless of result:
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> >
> > > ---
> > >  include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 107 insertions(+)
> > >  create mode 100644 include/linux/lsm_count.h
> > >
> > > diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> > > new file mode 100644
> > > index 000000000000..4d6dac6efb75
> > > --- /dev/null
> > > +++ b/include/linux/lsm_count.h
> > > @@ -0,0 +1,107 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (C) 2023 Google LLC.
> > > + */
> > > +
> > > +#ifndef __LINUX_LSM_COUNT_H
> > > +#define __LINUX_LSM_COUNT_H
> > > +
> > > +#include <linux/args.h>
> > > +
> > > +#ifdef CONFIG_SECURITY
> > > +
> > > +/*
> > > + * Macros to count the number of LSMs enabled in the kernel at compi=
le time.
> > > + */
> > > +
> > > +/*
> > > + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> > > + */
> > > +#if IS_ENABLED(CONFIG_SECURITY)
> > > +#define CAPABILITIES_ENABLED 1,
> > > +#else
> > > +#define CAPABILITIES_ENABLED
> > > +#endif
> >
> > We're in an #ifdef CONFIG_SECURITY, so CAPABILITIES_ENABLED will always
> > be set. As such, we could leave off the trailing comma and list it
> > _last_ in the macro, and then ...
> >
> > > +/*
> > > + *  There is a trailing comma that we need to be accounted for. This=
 is done by
> > > + *  using a skipped argument in __COUNT_LSMS
> > > + */
> > > +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> > > +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
> >
> > This wouldn't be needed...
>
> Slight preference for explicitly having the capabilities listed than
> implicitly over counting. But no strong opinion, fine with either
> approches.

Actually it's not just a preference but really required. When the
CAPABILITIES is absent and all other LSMs are disabled it leads to
COUNT_ARGS() which evaluates to 0

This also happens here:

https://lore.kernel.org/bpf/202309271206.d7fb60f9-oliver.sang@intel.com/

and to fix this we need:

-#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
+#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)

And I checked the edge cases with a simple c file

int test(void) {
   int count =3D MAX_LSM_COUNT;
}

and make security/count.i:

for just CONFIG_SECURITY enabled:

int test(void) {
  int count =3D 1;
}

with another LSM:

int test(void) {
  int count =3D 2;
}


- KP
>
> >
> > > +
> > > +#define MAX_LSM_COUNT                        \
> > > +     COUNT_LSMS(                     \
> > > +             CAPABILITIES_ENABLED    \
> > > +             SELINUX_ENABLED         \
> > > +             SMACK_ENABLED           \
> > > +             APPARMOR_ENABLED        \
> > > +             TOMOYO_ENABLED          \
> > > +             YAMA_ENABLED            \
> > > +             LOADPIN_ENABLED         \
> > > +             LOCKDOWN_ENABLED        \
> > > +             BPF_LSM_ENABLED         \
> > > +             LANDLOCK_ENABLED)
> >
> >
> >         COUNT_ARGS(                     \
> >                 SELINUX_ENABLED         \
> >                 SMACK_ENABLED           \
> >                 ...
> >                 CAPABILITIES_ENABLED)
> >
> > -Kees
> >
> > --
> > Kees Cook
