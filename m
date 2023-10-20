Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F155E7D13EE
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Oct 2023 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJTQZb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Oct 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJTQZa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Oct 2023 12:25:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE91A4;
        Fri, 20 Oct 2023 09:25:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso1539232a12.1;
        Fri, 20 Oct 2023 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697819127; x=1698423927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Zh2IXK6vdHBvlCvwZsvPMmXUhqBdB70AvUaXtJ3lng=;
        b=FBiYMpU8uptcyIUEjnm6JlOah1D2zGrqOhYwlNIjEkvdx+dbpgyxm7QFRmrG7Rva6J
         IvrwGeijCv4QYfDSYpYLw5RIk9iB4E/K9D4QSvuPM/SDmJqGuTKQ+2jmBBGE89y+mIQm
         8eXBXJt0z9S0RpqcPVSLwPcVQitLOsCxsC6GV+tqXWLejnPhoC8GVx5A802ovnufF16N
         YMWBIEsHoFvxrsPxkiP4y53Tey8nloSXd6DAqIBqE7b0tLC1tHkMY2li4TNR41MMxZUn
         XFXvFiIPyijy2p3CUmDMNrmkN3WPe0lqvI4TB9PoNnFmnEK+EvNfiZnvaz9hzp+qAe2Y
         RwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819127; x=1698423927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Zh2IXK6vdHBvlCvwZsvPMmXUhqBdB70AvUaXtJ3lng=;
        b=uo+uhrQW7eGCZqnN2cf4UTEMdYU+RCkhY907CZZWFWiATUxIRRDYotXgqwPu/gyLA1
         CA0/fLhAjjtkj+3owPHzl0J2lC8aHHLPG5ISbSerOWZleoaW3fnGFirISLxL4jKFgIZp
         j1CQrgI3NeiMfWQPqXbwbco2CLvtlaKgovH/4n6SlR8lgwd+7HRzj8dok6qccTbd6GiM
         lYDVYZTNNwrztkC7psuIR+YEEZ70lOkD5mrxAFUtU7llBdA1J/XA0MDGOnui7bCE9l4E
         o4KCEf05rBsSJg0XVM/yBrCcIxsXXXAACAu/aMi7aS8AWCK50o0K1hJzq0JA9eB/xRhA
         UIKA==
X-Gm-Message-State: AOJu0YzoGpcIrMZCKZA5PdFn0xQbtRGsxilMaOWf1LjPgs6DFXssgLV8
        3p3rWtTz2ZEA39QVDqNw+b1fOzi24wyWfYD6Lyk=
X-Google-Smtp-Source: AGHT+IHR3P0GY5oHeM7ZfYPG/nM9zShbnUgp0/H4u/l4uQFiRoimeJtGseDXHUsWqIm3AUVKeuFWnhB+ruOti/4Xtqk=
X-Received: by 2002:a05:6402:430f:b0:53e:2a65:1d9c with SMTP id
 m15-20020a056402430f00b0053e2a651d9cmr2171650edc.25.1697819126717; Fri, 20
 Oct 2023 09:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org> <CAN+4W8hu+zWiWejWtc72WwQb6ydL3U3LXvaFBdc0o826JKzoAQ@mail.gmail.com>
In-Reply-To: <CAN+4W8hu+zWiWejWtc72WwQb6ydL3U3LXvaFBdc0o826JKzoAQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Oct 2023 09:25:15 -0700
Message-ID: <CAEf4BzbK2JkJwcwtXzhnazxT7dasjpSbScOoE=N9wkcepJu81w@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To:     Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 20, 2023 at 6:18=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isovalen=
t.com> wrote:
>
> On Mon, Oct 16, 2023 at 7:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> ...
> > This patch set adds a basic minimum of functionality to make BPF token =
idea
> > useful and to discuss API and functionality. Currently only low-level l=
ibbpf
> > APIs support creating and passing BPF token around, allowing to test ke=
rnel
> > functionality, but for the most part is not sufficient for real-world
> > applications, which typically use high-level libbpf APIs based on `stru=
ct
> > bpf_object` type. This was done with the intent to limit the size of pa=
tch set
> > and concentrate on mostly kernel-side changes. All the necessary plumbi=
ng for
> > libbpf will be sent as a separate follow up patch set kernel support ma=
kes it
> > upstream.
> >
> > Another part that should happen once kernel-side BPF token is establish=
ed, is
> > a set of conventions between applications (e.g., systemd), tools (e.g.,
> > bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
> > instance(s) at well-defined locations to allow applications take advant=
age of
> > this in automatic fashion without explicit code changes on BPF applicat=
ion's
> > side. But I'd like to postpone this discussion to after BPF token conce=
pt
> > lands.
>
> In the patch set you've extended MAP_CREATE, PROG_LOAD and BTF_LOAD to
> accept an additional token_fd. How many more commands will need a
> token as a context like this? It would cause a lot of churn to support

There are few more commands that do capable() checks (GET_NEXT_ID and
GET_FD_BY_ID commands, TASK_QUERY, maybe few others), so if those
would be necessary to delegate, we can probably add token support
there as well. Other than that LINK_CREATE seems like a likely
candidate in the future. This will probably be driven by concrete
customer use cases.

> many BPF commands like this, since every command will have token_fd at
> a different offset in bpf_attr. This means we need to write extra code
> for each new command, both in kernel as well as user space.

Yes, but that's generally true for anything else added to BPF syscall
(like verifier log, for example). Luckily it's not really a lot of
commands and definitely not a lot of code.

>
> Could we pass the token in a way that is uniform across commands?
> Something like additional arg to the syscall or similar.

Adding a new argument means adding a new syscall (bpf2()) due to
backwards compatibility requirements. Adding bpf2() syscall means
adding even more code to all existing libraries to support them (and
still keeping backwards compatibility with bpf() syscall).

It doesn't really seem worth it just for passing token_fd to a few
commands, IMO.

>
> Lorenz
