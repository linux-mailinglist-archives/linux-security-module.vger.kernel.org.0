Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C971B7AA028
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Sep 2023 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjIUUdZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 21 Sep 2023 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjIUUdG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 16:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF586111
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:37:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA39C4E757
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695305649;
        bh=KlkOjcXb0cHh5t1CjCCbqUvSBR8pKSTpPS0Loql+GfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u0sg6t4I4yW/mXkFHpdpXqosGHgg7C0+IV+BY+W6mVIY8P+yKbZ2fD9aqOmhIlBHc
         mOgQ6MikpwoaQnR0U3WyVVpu+ayIB2aCEeg690Czy05Qrpq0sUmLYwxDcGSCvLvs1h
         z0aPd/1Mci+VmKilxFun3t84JYofL4DzOAEeyVda1sEZ3O5oJ3DZk00+jyQv0cWqJb
         x7NoMYCmiuXH6kVu8omdmXcRvLbjfvz6J+azzQkesL/SBgiUqpFDpEG1WSFZLXGhk6
         ewCYu0qX2q8xOYTJKo0INGnSozOPcbbpPYKHobf6mE3CqdxSOXcPy0weive1ApLaQc
         pgx+OYDD6PRHw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5043120ffbcso877607e87.2
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 07:14:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YzPEnrgIK9Kcq3K9cIKcHIkg2NqbZYOyfamfJR4drpYXoLQyurc
        DGF3xU0TLj+356KdbbdcmY7ZZPzVfoLeQbWrTcbISw==
X-Google-Smtp-Source: AGHT+IGasP641htQm4SmX0/XiYvGFP4Ximw7EqIZmOnsOZKkzf1zkCc5ySy88IqgOGqKy92hPytG1LuADlQ401mvN2s=
X-Received: by 2002:a19:3813:0:b0:4ff:7046:984a with SMTP id
 f19-20020a193813000000b004ff7046984amr4432863lfa.7.1695305647578; Thu, 21 Sep
 2023 07:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
In-Reply-To: <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 21 Sep 2023 16:13:56 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Dn=W1Kd5M_bXOzoomzdjMXBoEZZo5k=cgQ4R6f5G+vw@mail.gmail.com>
Message-ID: <CACYkzJ7Dn=W1Kd5M_bXOzoomzdjMXBoEZZo5k=cgQ4R6f5G+vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 21, 2023 at 3:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/19 6:24, KP Singh wrote:
> > These macros are a clever trick to determine a count of the number of
> > LSMs that are enabled in the config to ascertain the maximum number of
> > static calls that need to be configured per LSM hook.
>
> As a LKM-based LSM user, indirect function calls using a linked list have
> an advantage which this series kills. There always is a situation where a
> LSM cannot be built into vmlinux (and hence has to be loaded as a LKM-bas=
ed
> LSM) due to distributor's support policy. Therefore, honestly speaking,
> I don't want LSM infrastructure to define the maximum number of "slots" o=
r
> "static calls"...
>
> >
> > Without this one would need to generate static calls for (number of
> > possible LSMs * number of LSM hooks) which ends up being quite wasteful
> > especially when some LSMs are not compiled into the kernel.
>
> I can't interpret "number of possible LSMs * number of LSM hooks" part.
> Is this tokenized as "number of possible LSMs" (an integer) * (multipled =
by)
> "number of LSM hooks" (an integer) ? But the next patch includes
>

The tokenization is in the name of the static call slots. you cannot
have __SCT__lsm_static_call_bprm_check_security_1+1+1 it's not a valid
name. You may want to build security/security.i to see what's going on
(and actually try disabling some of the DEFINE_STATIC_CALL macros to
reduce further expansion of macros.

>   struct lsm_static_calls_table {
>   #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>                 struct lsm_static_call NAME[MAX_LSM_COUNT];

Each LSM that is compiled in the kernel can theoretically register a
callback, so we add MAX_LSM_COUNT slots. Now the word "possible"
because one may compile the LSM but not choose to enable it with the
lsm=3D parameter.


>         #include <linux/lsm_hook_defs.h>
>         #undef LSM_HOOK
>   } __randomize_layout;
>
> which seems to me that lsm_static_calls_table will get "number of possibl=
e
> LSMs" static calls for each LSM hook defined in linux/lsm_hook_defs.h .
> How did this patch help reducing static calls? What does "possible LSMs" =
mean?

If the kernel is compiled only with CONFIG_BPF_LSM, CONFIG_SELINUX and
CONFIG_SECURITY (for capabilities) and not any other LSM, then one
does not need to generate 12 slots for all each LSM hook when there
are only 3 LSMs compiled in (capabilities being implicitly behind
CONFIG_SECURITY).

> Should "number of possible LSMs" be replaced with "number of built-in LSM=
s" ?

Sure. I think "compiled LSMs" is a better word here.


>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org
>
> Trailing ">" is missing.

Fixed.

>
> > +/*
> > + * Macros to count the number of LSMs enabled in the kernel at compile=
 time.
> > + */
> > +#define MAX_LSM_COUNT                        \
> > +     ___COUNT_COMMAS(                \
> > +             CAPABILITIES_ENABLED    \
> > +             SELINUX_ENABLED         \
> > +             SMACK_ENABLED           \
> > +             APPARMOR_ENABLED        \
> > +             TOMOYO_ENABLED          \
> > +             YAMA_ENABLED            \
> > +             LOADPIN_ENABLED         \
> > +             LOCKDOWN_ENABLED        \
> > +             BPF_LSM_ENABLED         \
> > +             LANDLOCK_ENABLED)
>
> Since IS_ENABLED(CONFIG_FOO) is evaluated to either 1 or 0, why can't you=
 directly
> do like IS_ENABLED(CONFIG_FOO) + IS_ENABLED(CONFIG_BAR) + IS_ENABLED(CONF=
IG_BUZ) ?
> If you can't do direct "+", can't you still do indirect "+" like somethin=
g below?
>
> #if IS_ENABLED(CONFIG_FOO)
> #define FOO_ENABLED 1
> #else
> #define FOO_ENABLED 0
> #endif
>
