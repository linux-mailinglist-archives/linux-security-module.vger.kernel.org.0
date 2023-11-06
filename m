Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB87E3022
	for <lists+linux-security-module@lfdr.de>; Mon,  6 Nov 2023 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjKFWrC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 6 Nov 2023 17:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjKFWrB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 17:47:01 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D71ED73
        for <linux-security-module@vger.kernel.org>; Mon,  6 Nov 2023 14:46:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so5282441276.3
        for <linux-security-module@vger.kernel.org>; Mon, 06 Nov 2023 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699310816; x=1699915616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+CxpgcL4aexq1pxQBuG46UP8l7bbeWIcVPQNBNf8iQ=;
        b=K8JQoSb7el9HTL9KRhQwzID5BJfxMEh/9nax4gEB6w7NPNEUYMyYB/g5L9qgZaDn7h
         7TZkBg5w6YKMDW67kybRRR9kTpRtf9LgBNLx6hPbdYKiR3LJ+LC+3v2//hhs2cGHDFgx
         bfLfPcybjI8GvoOypMOxUJ1Tvnzt971EBpiefS6dJyI1SE9/N80EiKeCplENtAsuTdEx
         s0PFvxsUv5UK4OzRfWKmGAKM7aPPA290XxufpylJCIUb1wvEwKbFNcSukSJtF97GewSV
         TrEovf/8cY15HXZ8+TYBAqCj4Il1L41gfLotRIyJf+l2Jss66pPuZ7bu9J+qd96V+E/o
         xy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310816; x=1699915616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+CxpgcL4aexq1pxQBuG46UP8l7bbeWIcVPQNBNf8iQ=;
        b=jVDPI7fYxYrW6cZCkrAKJ9dCbrZ5IbxRq88ha+RuCBhUZ+8B74aRlnJdlOyQaHWeUz
         gHcpbrk76ivXS47Fx6lseMm8N2eIGem0xY7J0M0xLX414PKjiJwgbklDFOM2AlJbL+vz
         ib/jLnizd6npEDtK3cZgRB9r4CVGrlEBBx9ICo2tbWAg+Usgt1ytV49UOp6zsgDhjBK8
         NDiV9+qkXjikF+6csmf9sccDIiFKBjrgJoIwU8z37hqjIANU9dp4oKcYdBRfoSky8a0c
         cj6nCtKF5wf3h/FzU/xA94d/hW5all4xyCT3VhksJr/7bXSU+spDrbRA7b5z++sdQJrZ
         99jg==
X-Gm-Message-State: AOJu0YxPszGlI0eCviUzC9YcFP+Vtf/9mH+xEBqzjbhdI6sbMkV+MJGJ
        NP9wUYSwIfhciOpY36WZ751vzpZOxSxXTorvYvdN
X-Google-Smtp-Source: AGHT+IGXWhDoSXxeBh7Czg+txU8kbw2mYBGyDM2qVw79VBO13uUkESRzx7ovAgOHJjgxfDNHWL6IeHZWWm76GepPGGc=
X-Received: by 2002:a25:ad14:0:b0:d9a:e397:3b4 with SMTP id
 y20-20020a25ad14000000b00d9ae39703b4mr30117731ybi.46.1699310816479; Mon, 06
 Nov 2023 14:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20231103190523.6353-12-andrii@kernel.org> <9d2b920cb7e59dfd56f763bdd4e53abd.paul@paul-moore.com>
 <CAEf4BzbGjLQV0CsTwawiqHaGf4eObMQBJT-bpDpWOoQ8hNNcVQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbGjLQV0CsTwawiqHaGf4eObMQBJT-bpDpWOoQ8hNNcVQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Nov 2023 17:46:45 -0500
Message-ID: <CAHC9VhSkt8SgmJuBzd7cRf-MpZT2rwkp2ndPukCmYftNb62zmg@mail.gmail.com>
Subject: Re: [PATCH v9 11/17] bpf,lsm: add BPF token LSM hooks
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 6, 2023 at 2:17=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Sun, Nov 5, 2023 at 9:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
> > > allocate LSM security blob (we add `void *security` field to struct
> > > bpf_token for that), but also control who can instantiate BPF token.
> > > This follows existing pattern for BPF map and BPF prog.
> > >
> > > Also add security_bpf_token_allow_cmd() and security_bpf_token_capabl=
e()
> > > LSM hooks that allow LSM implementation to control and negate (if
> > > necessary) BPF token's delegation of a specific bpf_cmd and capabilit=
y,
> > > respectively.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h           |  3 ++
> > >  include/linux/lsm_hook_defs.h |  5 +++
> > >  include/linux/security.h      | 25 +++++++++++++++
> > >  kernel/bpf/bpf_lsm.c          |  4 +++
> > >  kernel/bpf/token.c            | 13 ++++++--
> > >  security/security.c           | 60 +++++++++++++++++++++++++++++++++=
++
> > >  6 files changed, 107 insertions(+), 3 deletions(-)
> >
> > ...
> >
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 08fd777cbe94..1d6edbf45d1c 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -60,6 +60,7 @@ struct fs_parameter;
> > >  enum fs_value_type;
> > >  struct watch;
> > >  struct watch_notification;
> > > +enum bpf_cmd;
> >
> > Yes, I think it's fine to include bpf.h in security.h instead of the
> > forward declaration.
> >
> > >  /* Default (no) options for the capable function */
> > >  #define CAP_OPT_NONE 0x0
> > > @@ -2031,6 +2032,11 @@ extern void security_bpf_map_free(struct bpf_m=
ap *map);
> > >  extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_a=
ttr *attr,
> > >                                 struct bpf_token *token);
> > >  extern void security_bpf_prog_free(struct bpf_prog *prog);
> > > +extern int security_bpf_token_create(struct bpf_token *token, union =
bpf_attr *attr,
> > > +                                  struct path *path);
> > > +extern void security_bpf_token_free(struct bpf_token *token);
> > > +extern int security_bpf_token_allow_cmd(const struct bpf_token *toke=
n, enum bpf_cmd cmd);
> > > +extern int security_bpf_token_capable(const struct bpf_token *token,=
 int cap);
> > >  #else
> > >  static inline int security_bpf(int cmd, union bpf_attr *attr,
> > >                                            unsigned int size)
> > > @@ -2065,6 +2071,25 @@ static inline int security_bpf_prog_load(struc=
t bpf_prog *prog, union bpf_attr *
> > >
> > >  static inline void security_bpf_prog_free(struct bpf_prog *prog)
> > >  { }
> > > +
> > > +static inline int security_bpf_token_create(struct bpf_token *token,=
 union bpf_attr *attr,
> > > +                                  struct path *path)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static inline void security_bpf_token_free(struct bpf_token *token)
> > > +{ }
> > > +
> > > +static inline int security_bpf_token_allow_cmd(const struct bpf_toke=
n *token, enum bpf_cmd cmd)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static inline int security_bpf_token_capable(const struct bpf_token =
*token, int cap)
> > > +{
> > > +     return 0;
> > > +}
> >
> > Another nitpick, but I would prefer to shorten
> > security_bpf_token_allow_cmd() renamed to security_bpf_token_cmd() both
> > to shorten the name and to better fit convention.  I realize the caller
> > is named bpf_token_allow_cmd() but I'd still rather see the LSM hook
> > with the shorter name.
>
> Makes sense, renamed to security_bpf_token_cmd() and updated hook name as=
 well

Thanks.

> > > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > > index 35e6f55c2a41..5d04da54faea 100644
> > > --- a/kernel/bpf/token.c
> > > +++ b/kernel/bpf/token.c
> > > @@ -7,11 +7,12 @@
> > >  #include <linux/idr.h>
> > >  #include <linux/namei.h>
> > >  #include <linux/user_namespace.h>
> > > +#include <linux/security.h>
> > >
> > >  bool bpf_token_capable(const struct bpf_token *token, int cap)
> > >  {
> > >       /* BPF token allows ns_capable() level of capabilities */
> > > -     if (token) {
> > > +     if (token && security_bpf_token_capable(token, cap) =3D=3D 0) {
> > >               if (ns_capable(token->userns, cap))
> > >                       return true;
> > >               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns,=
 CAP_SYS_ADMIN))
> >
> > We typically perform the capability based access controls prior to the
> > LSM controls, meaning if we want to the token controls to work in a
> > similar way we should do something like this:
> >
> >   bool bpf_token_capable(...)
> >   {
> >     if (token) {
> >       if (ns_capable(token, cap) ||
> >           (cap !=3D ADMIN && ns_capable(token, ADMIN)))
> >         return security_bpf_token_capable(token, cap);
> >     }
> >     return capable(cap) || (cap !=3D ADMIN && capable(...))
> >   }
>
> yep, makes sense, I changed it as you suggested above

Thanks again.

> > > @@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
> > >
> > >  static void bpf_token_free(struct bpf_token *token)
> > >  {
> > > +     security_bpf_token_free(token);
> > >       put_user_ns(token->userns);
> > >       kvfree(token);
> > >  }
> > > @@ -172,6 +174,10 @@ int bpf_token_create(union bpf_attr *attr)
> > >       token->allowed_progs =3D mnt_opts->delegate_progs;
> > >       token->allowed_attachs =3D mnt_opts->delegate_attachs;
> > >
> > > +     err =3D security_bpf_token_create(token, attr, &path);
> > > +     if (err)
> > > +             goto out_token;
> > > +
> > >       fd =3D get_unused_fd_flags(O_CLOEXEC);
> > >       if (fd < 0) {
> > >               err =3D fd;
> > > @@ -216,8 +222,9 @@ bool bpf_token_allow_cmd(const struct bpf_token *=
token, enum bpf_cmd cmd)
> > >  {
> > >       if (!token)
> > >               return false;
> > > -
> > > -     return token->allowed_cmds & (1ULL << cmd);
> > > +     if (!(token->allowed_cmds & (1ULL << cmd)))
> > > +             return false;
> > > +     return security_bpf_token_allow_cmd(token, cmd) =3D=3D 0;
> >
> > I'm not sure how much it really matters, but someone might prefer
> > the '!!' approach/style over '=3D=3D 0'.
>
> it would have to be !security_bpf_token_cmd(), right?

Yeah :P

In most, although definitely not all, kernel functions when something
returns 0 we consider that the positive/success case, with non-zero
values being some sort of failure.  I must have defaulted to that
logic here, but you are correct that just a single negation would be
needed here.

> And that single
> negation is just very confusing when dealing with int-returning
> function. I find it much easier to make sure the logic is correct when
> we have explicit `=3D=3D 0`.

That's fine, it's something I've seen mentioned over the years and
thought I might offer it as a comment.  I can read either approach
just fine :)

Anyway, with the other changes mentioned above, e.g. naming and
permission ordering, feel free to add my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
