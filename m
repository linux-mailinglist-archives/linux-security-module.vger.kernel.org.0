Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234737E2CBD
	for <lists+linux-security-module@lfdr.de>; Mon,  6 Nov 2023 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjKFTTI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 6 Nov 2023 14:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjKFTTI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 14:19:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A74F3;
        Mon,  6 Nov 2023 11:19:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso18909966b.2;
        Mon, 06 Nov 2023 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699298343; x=1699903143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYDiviYoRRp+UlmjRFSwEZtGM6DYURzv5qiroeVPjH8=;
        b=Ms0gxG0a6TCe6MqG9K0ec7bCiQn2VtnYc/H3HE/dXwlCpDtaPP/IN9jpYllVTQjlpa
         XstDGjC92jSDQAEq2Wod28LpTryqx+fXNGYn1w6iNp+z2f6Jcc9HYy3D/BaHRp3qPZF3
         EzBrLwH+2bluPGoPtkZx1EYbItDLVV+vW0dNaFUEl7u2TE7D5hwjD4tWaE67fTKxflhf
         QlJ6nBqmIRA/oTCYn0tPG1l1BFyXqJKaHWuTiBfnhCATlLMACnfRDw4GNCwjTSLy8fnh
         vL30NHGzP0OJIpRd94+ocL2ObFvZilbEOFCmv+q3DukujQn8g0pJqPLp2BWIOdpmdjQw
         WIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298343; x=1699903143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYDiviYoRRp+UlmjRFSwEZtGM6DYURzv5qiroeVPjH8=;
        b=YHEQ9hYDj4VO7EfNx+Bp5hV3vW9A7A0EEOrcN1ISpNNa/vp0lNdTtpdch+NWXjtS9x
         BCe1W9kot6OstNMyWSnLpYqgu7WNk+SMzrdIDmjF63NZv+uTwXZqsIZoGtr+O/rbxt+x
         hEy+muJ6j3/vl8GjCEWCluEPetrV7jOvpAox+iDKX2e2f5n209r8xAxvcIA0U2jc9pUK
         HRoRmeD8MyI1yqlDV9an5c/HWBvVdM5ZAMAVyQ/NKIuVltATxXKur7sPNy4+E8YW4Bia
         L/2BAtAl4MSaMgYGNcIAXkAYt5EstzDnUkLI/cwWHxIKmVrdtxgSF9u3aGJgQz5n5MOw
         x8Ng==
X-Gm-Message-State: AOJu0YyqU0vkEijvLHdv48zlZ+PkuZ9l1L0ws/N3Dez5FT2cm2MUUVUs
        epwxCyxMCrEKHcVqZgWHaj3oFXQtWK6YcxLSYww=
X-Google-Smtp-Source: AGHT+IGVElRobG1K0nL0GdFqR+QCWREPKzfmA/2hwZhLIGiCWQ+Cl0Q6Mkn0P/gWkkrYoe4d6jzxJLKKMvfFtqVpCg4=
X-Received: by 2002:a17:907:1b22:b0:9c2:a072:78c4 with SMTP id
 mp34-20020a1709071b2200b009c2a07278c4mr13758897ejc.25.1699298343110; Mon, 06
 Nov 2023 11:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20231103190523.6353-18-andrii@kernel.org> <257c16919acd2ec98dac2e6c4f21c906.paul@paul-moore.com>
In-Reply-To: <257c16919acd2ec98dac2e6c4f21c906.paul@paul-moore.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Nov 2023 11:18:51 -0800
Message-ID: <CAEf4BzY8xtLoecxdgau=4p2rnAJTREOHnJo8YTGsobKgVdPE4g@mail.gmail.com>
Subject: Re: [PATCH v9 17/17] bpf,selinux: allocate bpf_security_struct per
 BPF token
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Nov 5, 2023 at 9:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Utilize newly added bpf_token_create/bpf_token_free LSM hooks to
> > allocate struct bpf_security_struct for each BPF token object in
> > SELinux. This just follows similar pattern for BPF prog and map.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  security/selinux/hooks.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
>
> Thanks Andrii, we'll need some additional code to fully enable the
> BPF tokens on a SELinux system but I can help provide that if you'd
> like.  Although I might not be able to get to that until after the
> merge window closes.

Yep, I'd appreciate your help with the SELinux side. Until after the
merge window is fine, yes.

Thanks for reviewing the patch set!

>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 002351ab67b7..1501e95366a1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6828,6 +6828,29 @@ static void selinux_bpf_prog_free(struct bpf_pro=
g *prog)
> >       prog->aux->security =3D NULL;
> >       kfree(bpfsec);
> >  }
> > +
> > +static int selinux_bpf_token_create(struct bpf_token *token, union bpf=
_attr *attr,
> > +                                 struct path *path)
> > +{
> > +     struct bpf_security_struct *bpfsec;
> > +
> > +     bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> > +     if (!bpfsec)
> > +             return -ENOMEM;
> > +
> > +     bpfsec->sid =3D current_sid();
> > +     token->security =3D bpfsec;
> > +
> > +     return 0;
> > +}
> > +
> > +static void selinux_bpf_token_free(struct bpf_token *token)
> > +{
> > +     struct bpf_security_struct *bpfsec =3D token->security;
> > +
> > +     token->security =3D NULL;
> > +     kfree(bpfsec);
> > +}
> >  #endif
> >
> >  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> > @@ -7183,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >       LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
> >       LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
> >       LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
> > +     LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
> >  #endif
> >
> >  #ifdef CONFIG_PERF_EVENTS
> > @@ -7241,6 +7265,7 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >  #ifdef CONFIG_BPF_SYSCALL
> >       LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
> >       LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
> > +     LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
> >  #endif
> >  #ifdef CONFIG_PERF_EVENTS
> >       LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> > --
> > 2.34.1
>
> --
> paul-moore.com
