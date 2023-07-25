Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE47C7623E4
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Jul 2023 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGYUta (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 25 Jul 2023 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGYUt3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jul 2023 16:49:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2AE47
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jul 2023 13:49:28 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d09ba80fbcaso3998886276.2
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jul 2023 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690318167; x=1690922967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pwzeRqLrOu101EZj93ajzmGLiXWtx4Lx2tZaqti1o0=;
        b=Hh/HC0+qnNN//N2674LUhq6HbwnHiNo1PDmLrC1e+CdqY75ZziXo9pTY4iKpbk/gd0
         plhdDad7ChstXPNgLsf8z57pTOXbqW8LsnIQ5fP92Hwq0YnN9cncvs+XI1vw14TFe25K
         XfzLmDMen1Q45DYsB5PhTSXNrtSJE9yDRGKEED/BzJfoNehFztzKYFJaytST45fRa6NV
         hhrX7XL7WZITM3VcV2ZmHNHw7xoAlByGb0BCGhpLWmmjRmiTyhbn3tpjIRJK/jYYGxKS
         6uOmYWHtgDPxNSooNJ9M/Y6Gz/f3IXcErDydA6ShSTxvfwEBPX6QHFhRmscBte1cO1Af
         0lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318167; x=1690922967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pwzeRqLrOu101EZj93ajzmGLiXWtx4Lx2tZaqti1o0=;
        b=YcG0B66gy8UQ6eHLcT7T7vIh6ZEhr+lKcBLMZSMeLBgjhoB+1S2nn1e91r3OpzKfOy
         qpbxjVRHP3PRR5SeqvsBFVXzUZtel/16zCPC4MTWp4flTvbBYUhSiokznzo/XIpaDwir
         JI/lEolc1aieL9rw6Y84XS+8h1mUUzCdP9+9tZg7hWjFpu6WHtw6BG/WYqFqTAwCnN25
         zh/rx+wbDAG31aFiaDle4X+vZXPQwtXlvTF77V6tz8UcTb8tBmlw0weyiQJoTPSSRLhY
         TYdgzu0s3OHOnxAuOqNR8wZwUX3t4A1XxKWoJpqqvgUA4mdLHdjHtijPGmOfi3HLvr9H
         UmCQ==
X-Gm-Message-State: ABy/qLZcQvETvi5/BYBo8wtFZ1Qve40FCbI32g9T1MUYRzv7yX6QPpsj
        rrUqe8ll8wV3opK+OgLRas+II5KGuCitzdQOdxUO
X-Google-Smtp-Source: APBJJlGvY5SGqy1Os5nPgpNzQzxzQStG90itaVOA8RiEXFuePCRItZAjJXzNQ/cP6kMXAXFkLDQCwbpel0vTHMCu/kw=
X-Received: by 2002:a25:d494:0:b0:d10:d237:b03d with SMTP id
 m142-20020a25d494000000b00d10d237b03dmr101831ybf.53.1690318167278; Tue, 25
 Jul 2023 13:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230621074623.498647-1-cuigaosheng1@huawei.com> <CAHC9VhQzZYg1HH_Q6OYytkp-uYOmCAnpzHb9tiRA-YC0VNha9A@mail.gmail.com>
In-Reply-To: <CAHC9VhQzZYg1HH_Q6OYytkp-uYOmCAnpzHb9tiRA-YC0VNha9A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jul 2023 16:49:16 -0400
Message-ID: <CAHC9VhQaWM=eC98ezfKmOA6sd9wzxQ0PFp5EysUKLZFEt=yB=A@mail.gmail.com>
Subject: Re: [PATCH -next] trusted-keys: Fix kernel-doc warnings in trusted-keys
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, jarkko@kernel.org,
        dhowells@redhat.com
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 21, 2023 at 9:33=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jun 21, 2023 at 3:46=E2=80=AFAM Gaosheng Cui <cuigaosheng1@huawei=
.com> wrote:
> >
> > Fix kernel-doc warnings in trusted-keys:
> >
> > security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting
> > prototype for tpm_buf_append_auth(). Prototype was for
> > tpm2_buf_append_auth() instead.
> >
> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Jarkko, David, can one of you pick this up into your tree?

--=20
paul-moore.com
