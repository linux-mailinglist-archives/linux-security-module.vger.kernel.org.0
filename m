Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601FD79F258
	for <lists+linux-security-module@lfdr.de>; Wed, 13 Sep 2023 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjIMTqs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 Sep 2023 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjIMTqq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Sep 2023 15:46:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C419B6
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 12:46:42 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5922380064bso2118287b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694634401; x=1695239201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/OX7SUI+TV9lsk0zyT19UZ7Vdm3M4MGEQYsybw2ZhA=;
        b=LqAHEMNlR6CRb9x/uCTC0bvAmrxfALOTZPhn0tJBPuuzjxYQm9NGPCzMbWjYMnxHGn
         E95IcaLupBO5wbbRaKjbnJAb0u62dV+GW6PBH3n2+nNGtEwWKrd5fL/cWO5BfCxla3+5
         d7qXYcUsEWbm2fRcFJDS/AEyxCtiVndUq6UD/kQJUklGGwDreETiezDJqaTJdDCTv1la
         76Fx2cwX0k8o3pqzjEMcuSE8+5VNlKAtVvy3Ns5DBYjQkS+0oEN2ZdyqdsXqUE1nnUy8
         ktqXe6OlRxGf6SkjNCjXR57tVYKpk1IFQQYcWKo68Q2hSQmJA8luGCBZ45YPGZGlabL+
         YjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694634401; x=1695239201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/OX7SUI+TV9lsk0zyT19UZ7Vdm3M4MGEQYsybw2ZhA=;
        b=wMcJkElzqb99a51KBLGnWdaSRbTOvf25TIavYyEHqYRq28+RhOU615SCEA936gk6hu
         B2/Uyr2DCQ+IJFX5XKaS3GMAAkmCU/x2xognm/8lY+aBzUeHE3hmtS8/b/4zO3KlrArD
         DULc1FWXeSmHE6I6PT/xRv03DVMqP9Q8eI6Ak1d/wuBg2szZMfc1loF4gjVCHNXbzyat
         HxONTO/2MevhKtMdMjx9t/orSoE6KKeWZzohJe2w2XMMotO8iw2qgbLbexjoYFIwx5vI
         S+x6rbA/JGIac4U6US366gWxaibzqoG25ooCYseRq+CXORdYptO6vwH6Qlr4UBQhKE3t
         6tJA==
X-Gm-Message-State: AOJu0YxkpJ22+T0mPtDc8ADs19J0o1fMTHa2nTDqFJ0tXlWSFP8xkpfd
        c4BZ60VBCDnITF8sbwY/9NsEciP2N5ES+B4U4uO/
X-Google-Smtp-Source: AGHT+IEUYEj3pCHmYPs/MV/l+zmgRpa8oA0zWigLy+E71zw0bdC0l4mRdGHHMouTJX24bfby8ruk+XKd89KWikpapXc=
X-Received: by 2002:a0d:e406:0:b0:586:9ce4:14e8 with SMTP id
 n6-20020a0de406000000b005869ce414e8mr2889046ywe.52.1694634401218; Wed, 13 Sep
 2023 12:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230729024026.32228-1-yuehaibing@huawei.com> <CAHC9VhRW0Jt0pitVx1cw-zJGWfTmvTU4RSmOFKANYJA7CeEF7g@mail.gmail.com>
 <CAHC9VhSisEfQd0KCu7f8yKBwnrduFOPhP2SzWDfXiuvGh2g13A@mail.gmail.com> <CVI1FHKRSG47.2CV547I19B9ZT@suppilovahvero>
In-Reply-To: <CVI1FHKRSG47.2CV547I19B9ZT@suppilovahvero>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 15:46:30 -0400
Message-ID: <CAHC9VhRA-V==Q-H_0V=-ic4eBrVJtDfpUvUX9Sp80SRt3DQUTQ@mail.gmail.com>
Subject: Re: [PATCH v3 -next] keys: Remove unused extern declarations
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com, Yue Haibing <yuehaibing@huawei.com>,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 13, 2023 at 3:31=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Wed Sep 13, 2023 at 9:00 PM EEST, Paul Moore wrote:
> > On Mon, Aug 7, 2023 at 5:46=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Fri, Jul 28, 2023 at 10:40=E2=80=AFPM Yue Haibing <yuehaibing@huaw=
ei.com> wrote:
> > > >
> > > > From: YueHaibing <yuehaibing@huawei.com>
> > > >
> > > > Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring"=
)
> > > > iterate_over_keyring() is never used, so can be removed.
> > > >
> > > > And commit b5f545c880a2 ("[PATCH] keys: Permit running process to i=
nstantiate keys")
> > > > left behind keyring_search_instkey().
> > > >
> > > > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > > > Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to insta=
ntiate keys")
> > > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > > ---
> > > > v3: Add Fixes tag
> > > > v2: Also remove keyring_search_instkey()
> > > > ---
> > > >  security/keys/internal.h | 7 -------
> > > >  1 file changed, 7 deletions(-)
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Jarkko or David, please merge this or explain what is wrong with this p=
atch.
>
> Sorry, I was aiming to pick this, and thanks for reminding.
>
> Applied.

Thanks.

--=20
paul-moore.com
