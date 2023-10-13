Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFB7C7A86
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Oct 2023 01:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJLXnV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 12 Oct 2023 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJLXnU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Oct 2023 19:43:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF87FC0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 16:43:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso1726556276.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697154198; x=1697758998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyXNgmUaPF1bv9pyp6gE2Z2gQrV0/t7IYlhVwPny5tY=;
        b=bzmlk2KZj4Jtu+hM3G+s6mJEtca8aDKDM5tuEVKxpZf2X7LbRC5bHehBOoc+rYLH0d
         aHbWdKG1ozG4SJpqCLWWekCZk/mAZgUtsab1UvcQweRMN4pFYe8qX/scLJ0KsyaHGKFu
         sadZPYf1UeQr8+tQpW1NTkVedIiYwZ8uv0R2BMDI3FlLwmzs80L57GzsK+X9bDJNhizZ
         GiV8I+ADDLVpV/H9JxJQbl3P3HRn0wao8U9l1HBDw3FHtF5RzS37l1fguWzIYBoJTrlF
         byBrhWilcQh/mmf6FXTbRir/LWHUxCNQIAr6KeNc34M+2XXP/Q9sB9kpGMt9xatQVYyr
         BDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154198; x=1697758998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyXNgmUaPF1bv9pyp6gE2Z2gQrV0/t7IYlhVwPny5tY=;
        b=JGCLuHQcIEf4ML1PzmUTrZ2+ycyMC3+rBLjQTDPb5qdCkPSkWJah/NSm69IQIxuezY
         4ZsVctnoOCbtQNiMPXIlCVLNHvB2POwBiqhDyiZUtdNLKbfCSkNS1kFtB1lRfzJJC1TT
         yFWBSrzhKubifZie0dNZyuC1rwcTmaZleXl2eHloMLvbPtP0l076I6B05HiHelBex78U
         TUo1AIjq9LTR7sRCWTOI0DwWdERbtVWv1Mdv347REsE7C4v/VVPxaPBW3Q5QADHoKnFS
         mk9PEznkxN2Xa1Oh2tD/wvQOn/iI5glOgY7tRjkodyVUGCCwMQTgSzUpHmIS4bkWXMAm
         wkVw==
X-Gm-Message-State: AOJu0YwL3FnOJtIW1mmds5f9edezQ/Mu0D8t+V181jjcf4zL4nrZST5h
        UMKzsJGjH1kG7UZOTagUQ+xz0LA2rsYg3wtRG+Ztt9NoKASErpk=
X-Google-Smtp-Source: AGHT+IFcGjYof8uqwKQYOb5HB7EJH671qYdyyUP/MYsADQEZKIOvJNUJNMPujVOol3jT7OajE1YEovrl2MC9mWZ3EfE=
X-Received: by 2002:a5b:708:0:b0:d9a:d2eb:7dcf with SMTP id
 g8-20020a5b0708000000b00d9ad2eb7dcfmr2908615ybq.41.1697154198040; Thu, 12 Oct
 2023 16:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230927225809.2049655-4-andrii@kernel.org> <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
 <CAEf4BzaTZ_EY4JVZ3ozGzed1PeD+HNGgkDw6jGpWYD_K9c8RFw@mail.gmail.com> <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com>
In-Reply-To: <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Oct 2023 19:43:07 -0400
Message-ID: <CAHC9VhQuoPUwctgUFNEkXZmutweEpGMVBAx5NmE7PvbE7oeR=g@mail.gmail.com>
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 12, 2023 at 5:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Oct 11, 2023 at 5:31=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > ok, so I guess I'll have to add all four variants:
> > security_bpf_token_{cmd,map_type,prog_type,attach_type}, right?
> >
>
> Thinking a bit more about this, I think this is unnecessary. All these
> allow checks to control other BPF commands (BPF map creation, BPF
> program load, bpf() syscall command, etc). We have dedicated LSM hooks
> for each such operation, most importantly security_bpf_prog_load() and
> security_bpf_map_create(). I'm extending both of those to be
> token-aware, and struct bpf_token is one of the input arguments, so if
> LSM need to override BPF token allow_* checks, they can do in
> respective more specialized hooks.
>
> Adding so many token hooks, one for each different allow mask (or any
> other sort of "allow something" parameter) seems to be excessive. It
> will both add too many super-detailed LSM hooks and will unnecessarily
> tie BPF token implementation details to LSM hook implementations, IMO.
> I'll send v7 with just security_bpf_token_{create,free}(), please take
> a look and let me know if you are still not convinced.

I'm hoping my last email better explains why we only really need
security_bpf_token_cmd() and security_bpf_token_capable() as opposed
to the full list of security_bpf_token_XXX().  If not, please let me
know and I'll try to do a better job explaining my reasoning :)

One thing I didn't discuss in my last email was why there is value in
having both security_bpf_token_{cmd,capable}() as well as
security_bpf_prog_load(); I'll try to do that below.

As we talked about previously, the reason for having
security_bpf_prog_load() is to provide a token-aware version of
security_bpf().  Currently the LSMs enforce their access controls
around BPF commands using the security_bpf() hook which is
unfortunately well before we have access to the BPF token.  If we want
to be able to take the BPF token into account we need to have a hook
placed after the token is retrieved and validated, hence the
security_bpf_prog_load() hook.  In a kernel that provides BPF tokens,
I would expect that LSMs would use security_bpf() to control access to
BPF operations where a token is not a concern, and new token-aware
security_bpf_OPERATION() hooks when the LSM needs to consider the BPF
token.

With the understanding that security_bpf_prog_load() is essentially a
token-aware version of security_bpf(), I'm hopeful that you can begin
to understand that it  serves a different purpose than
security_bpf_token_{cmd,capable}().  The simple answer is that
security_bpf_token_cmd() applies to more than just BPF_PROG_LOAD, but
the better answer is that it has the ability to impact more than just
the LSM authorization decision.  Hooking the LSM into the
bpf_token_allow_cmd() function allows the LSM to authorize the
individual command overrides independent of the command specific LSM
hook, if one exists.  The security_bpf_token_cmd() hook can allow or
disallow the use of a token for all aspects of a specific BPF
operation including all of the token related logic outside of the LSM,
something the security_bpf_prog_load() hook could never do.

I'm hoping that makes sense :)

--=20
paul-moore.com
