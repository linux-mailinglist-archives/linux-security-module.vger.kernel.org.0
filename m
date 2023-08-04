Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446F76F613
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Aug 2023 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHCXUb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Aug 2023 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHCXU3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 19:20:29 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95604A2
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 16:20:28 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d299ed34bacso3810751276.1
        for <linux-security-module@vger.kernel.org>; Thu, 03 Aug 2023 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691104828; x=1691709628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MXeaLjfcWtzHxNdYmCOMyJP3zSmOKDao0jQ+QjgI/I=;
        b=V3EVTxtA5ED7sOkPK0jQ3poEb+JOcy9zDlw9VNp5kgG1quKmr1FEp+PpRFhnnodiYT
         AynTIHgSu90a1r2GIXqd9+O+scLQx71THTiHWJf05YWlO5IUdAVU56wJpz4bhXBM1XO5
         ond3AGqBZsQzIBOKDSLaKts71NuUZPAqp3URluGxd8Zh/sl7LacCfHujcnE7O8w5Z6Pk
         O7VNOiY1eouL2UBcFzuYCIJU1o4tOT5ek2mJ8povllL9fOGQCq5+qvE+nf0aER/yX2FM
         N/kzPA4KiqhPVrBi35/ynNvcZWBhtih7rkhNsuH59Ibhho7+wNqpUd16SGbdcZi1oQGS
         C2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104828; x=1691709628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MXeaLjfcWtzHxNdYmCOMyJP3zSmOKDao0jQ+QjgI/I=;
        b=U3Fb1URVRL3+ACpscvZys+GT5eGw0BMKbLAWTBrsgWV3tb3D9plJZcb5D39ga+/oTD
         AlrVxmtP57Ik6m32jVge0gTfriWQDHlNxhOhw2na9yPpPleQkyyqRt+hJtRpKX7RqJfJ
         RgM7dUkva1x3nfuqwnJx/zLurwqEzGPqqJ+lX+irGumBRgZdjGPXhFNQ5EoSFoDsrH8i
         bkwgnkIu3yCKlMUd3hQ1rYZhxsXeoWnzQPj3K8zWCwoFLnXos6UwQXs1dZlyJvbdmEVQ
         hORhJdOYawqNPMmzaBy/t3VV2lWEnTOLdJ9IA9ChWhK5DZU/buoOrGCE6mhnGV+jXNHT
         qK+w==
X-Gm-Message-State: AOJu0YynJXFu0DxkCkIqfHLbfTUm2wMLXOsmg2wi3lWlupFllGOtrotu
        YUplFnfUy8Cb269LydYvF2X3c0Z1tAq6fl1hvjry
X-Google-Smtp-Source: AGHT+IGP6dy+Ma9towFfeW4EYpOXpR399CS3Lux2gOMhtGk1oQrNm0ERb+nZF8/LAWRnUxAeXy0cxrfXLYsO+s9GLNU=
X-Received: by 2002:a0d:e24d:0:b0:577:186c:2a3c with SMTP id
 l74-20020a0de24d000000b00577186c2a3cmr188706ywe.19.1691104827768; Thu, 03 Aug
 2023 16:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230621074623.498647-1-cuigaosheng1@huawei.com>
 <CAHC9VhQzZYg1HH_Q6OYytkp-uYOmCAnpzHb9tiRA-YC0VNha9A@mail.gmail.com>
 <CAHC9VhQaWM=eC98ezfKmOA6sd9wzxQ0PFp5EysUKLZFEt=yB=A@mail.gmail.com>
 <CAHC9VhTibk2tFPt7ZjFL9ps9NO6_sCQwXtbF1pQCXO+jGhshpg@mail.gmail.com> <31a5aed2f075b69705142ff6f558e8cd8ccb9cd8.camel@linux.ibm.com>
In-Reply-To: <31a5aed2f075b69705142ff6f558e8cd8ccb9cd8.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Aug 2023 19:20:16 -0400
Message-ID: <CAHC9VhRQBOfdcYO5QLRgVGdbqLFrogXeVD3FT2cETmLhP5uz3A@mail.gmail.com>
Subject: Re: [PATCH -next] trusted-keys: Fix kernel-doc warnings in trusted-keys
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, jarkko@kernel.org,
        dhowells@redhat.com, jejb@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 3, 2023 at 6:21=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Thu, 2023-08-03 at 18:00 -0400, Paul Moore wrote:
> > On Tue, Jul 25, 2023 at 4:49=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, Jun 21, 2023 at 9:33=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Wed, Jun 21, 2023 at 3:46=E2=80=AFAM Gaosheng Cui <cuigaosheng1@=
huawei.com> wrote:
> > > > >
> > > > > Fix kernel-doc warnings in trusted-keys:
> > > > >
> > > > > security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting
> > > > > prototype for tpm_buf_append_auth(). Prototype was for
> > > > > tpm2_buf_append_auth() instead.
> > > > >
> > > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > > > > ---
> > > > >  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Jarkko, David, can one of you pick this up into your tree?
> >
> > Guys, this patch is both trivial and obviously correct, please pick it
> > up so it can go up during the next merge window.
>
> Paul, either Jarkko or I can queue a trusted-keys patch.  As this isn't
> on the top of Jarkko's radar, I'll queue it.

Ah ha!  I was working under the assumption that everything under
security/keys/ was David and Jarko's responsibility, but now that I'm
looking at MAINTAINERS I see that isn't the case.  In fact it looks
like there are five (!) different "subsystems" under security/keys/
... I don't currently know enough about the different divisions there,
but it seems like we might want to see if we can do some consolidation
...

Anyway, thanks for picking this up Mimi.

--=20
paul-moore.com
