Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC5738541
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jun 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjFUNdm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Jun 2023 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFUNdl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jun 2023 09:33:41 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5141998
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 06:33:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5704fce0f23so62638997b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687354419; x=1689946419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji1YtGnThMF/zK8VE191zTAcogOENfq1V0tkk/VUYjo=;
        b=V4UxPnFH4ln6ZGyjuNoc+Oiw9Llx7pQaTjerMTMYgKBgjAthksT2JZul3yFIoXpFed
         D9AM1Ytxmzvee9vRBqU8mrSNF+rq5rfNQcmoWKKNXccz0gHziMDPiMi3lp6quiWUMNnv
         ZFMPV4NgDRbAYepkwjlwduVRG57siJkUMAqL9gJW/TbnkklnwGUlYqfvQWR4LlHhEL+H
         CWF32HN6kDZGpTv0RxEzIdslnxABH6MlOv3HVelLWk6eRLFzzBJTT6XalAIvjOldBuuj
         cogCNVekHntmmXlR7eBaehrzty4tQovc+FuFYqJJPIVf8odLznZXqNSQgXBRM7ajn8d9
         XtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354419; x=1689946419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji1YtGnThMF/zK8VE191zTAcogOENfq1V0tkk/VUYjo=;
        b=e0eOckMKUKWWI4YtRms3ZOBONrcL9riYxZQnu5o8r3dMYih0Ml7KF9tQ7Qv9l7jhzp
         YDpPj9m1IcqjPKW35MpmEJQAwtCCLRpwDGKAqsqmOe5W4srBMzHCh9+ryJyqFzrkqNw9
         qAurfeJHGk0D2ysM8ZrYpSTRaW1NWeziXY71zRc5RK3J8yUaK3s3aWbyMlS7/7WamJq5
         rK2o0DvT2yFv7li/GGLLqxgi583B656rUZ/Wui5LaKRKPNJPjZtwgoTOnar8Iz97X2eY
         GZXnHvvKCsqdNV/mVE32Ondfx+XbR7hHEdxHnT6/5ObNnjLqAk2T0+UzIGq/tmY9NLqs
         OyMg==
X-Gm-Message-State: AC+VfDyXe5cPHA62PUsAxTG9aCIbMsY4z2iqPmYmd1IlxdZMAoceCuJd
        Bdys4cpbdjbwWXtdT0uEZgFBLPse/cFL/kqZQJz6
X-Google-Smtp-Source: ACHHUZ4RWLGRYMd7PHbOgAOEUWtpyPoSAYyOCqPLHCtz3P0sTH7ZfdCDYrjMQpuiS8azCZQsq+wmZs2eh8KvNrIbnvw=
X-Received: by 2002:a81:8496:0:b0:56f:ff70:dbb7 with SMTP id
 u144-20020a818496000000b0056fff70dbb7mr14302548ywf.12.1687354419650; Wed, 21
 Jun 2023 06:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230621074623.498647-1-cuigaosheng1@huawei.com>
In-Reply-To: <20230621074623.498647-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Jun 2023 09:33:28 -0400
Message-ID: <CAHC9VhQzZYg1HH_Q6OYytkp-uYOmCAnpzHb9tiRA-YC0VNha9A@mail.gmail.com>
Subject: Re: [PATCH -next] trusted-keys: Fix kernel-doc warnings in trusted-keys
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
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

On Wed, Jun 21, 2023 at 3:46=E2=80=AFAM Gaosheng Cui <cuigaosheng1@huawei.c=
om> wrote:
>
> Fix kernel-doc warnings in trusted-keys:
>
> security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting
> prototype for tpm_buf_append_auth(). Prototype was for
> tpm2_buf_append_auth() instead.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
