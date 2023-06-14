Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D755D730A05
	for <lists+linux-security-module@lfdr.de>; Wed, 14 Jun 2023 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjFNVwh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 14 Jun 2023 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjFNVwg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Jun 2023 17:52:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1862695
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jun 2023 14:52:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-570002c9b38so13082787b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jun 2023 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686779553; x=1689371553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZdhhM2WIyksS9SFgf4otvNoFB1EwxYBOF+gAHVPmG8=;
        b=PXcQGsEt07YObxGudBvyTcBccv2Fq4xmvl5I8Pwzb6hW5+XL6GHtreR0xSZeiFk95+
         1klsNd4sLvF6ujNQPsQJljmBXx8XNwsGmW/XLwPKhq3qlGWRQwZwNLlxQ5MmW33JF9Qj
         ur1nzu6EdzzCxGNuFB7WMxNOmcYad8GBFCOD7LJ6Q96GjWg6BTQfWRiRKYMWPy3Zul9k
         o15bIaLGmgcE+DqUAJ+zHsf8bnesjOZ8UoTwzmpzp16cH4jIO3xno6ET6xXlUkrce35G
         m3SObnctwwIBp5WEJ4Dpnqc+oE+6qiGUrUfbCB93Tgra9QrWl8S+dClrreqAnVQ7Y1Ly
         5xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686779553; x=1689371553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZdhhM2WIyksS9SFgf4otvNoFB1EwxYBOF+gAHVPmG8=;
        b=Uju0li6tV/lmMQX3gcqh73+rn6sjpisiRzyxbm5mh5JskS7L3NM7+WqtktX/wM0C0T
         dHlQdUAmeKDae4sAWMNK53vJ3szgUDZNYLbK0Uoal8QSw63WgRoLjjneL5UhTUMR+YXw
         HYT7x3Qx0kO8dIZkfOcUCZEzWcKVjedSiX3L+1retMeHKbkvfQ5xz7/UZXU7v76zqQce
         JxUR0Ekc5cTBRq5okbY7iIQDY4P2YvAIDLFRX/G0Thetfn0beEfS0O6KPbr5JUA5ElNm
         YpkmtcgaXVHF6FHigeXbLVXVG2JPM851NWMKjLHQbwhFowcYTT8JCYJ5hiQ9w8qCVcWB
         AeJw==
X-Gm-Message-State: AC+VfDzEl6uhnEXtevuokcz9CTo+FeQ9dUoLDCrMecqR56JEEsfMOBpm
        hRcYA18cAGryVSI0AG6DlLhf32SPh0mMWlCm6YYs
X-Google-Smtp-Source: ACHHUZ4sqJvwja7uZm1iFvMQmSoLOgVR1pgw6VNNtcCP2rOQqydJR0z8aPP5tWbHLjsYAPK9c1Y1duM2yF8XSfnLyQ8=
X-Received: by 2002:a81:8205:0:b0:565:a081:a925 with SMTP id
 s5-20020a818205000000b00565a081a925mr3516080ywf.29.1686779553237; Wed, 14 Jun
 2023 14:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614021825.64333-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230614021825.64333-1-jiapeng.chong@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Jun 2023 17:52:22 -0400
Message-ID: <CAHC9VhSUz1zXBTFjaCDMzFCuAY6t3zG4WyXyKWBjNTwjLxZS+Q@mail.gmail.com>
Subject: Re: [PATCH] security: keys: Modify mismatched function name
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 13, 2023 at 10:18=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting prototy=
pe for tpm_buf_append_auth(). Prototype was for tpm2_buf_append_auth() inst=
ead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5524
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
