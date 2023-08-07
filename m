Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9354773197
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Aug 2023 23:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjHGVrl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Aug 2023 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHGVrk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 17:47:40 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7521724
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 14:47:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a76cbd4bbfso3899306b6e.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Aug 2023 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691444808; x=1692049608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSz5PVzqt7CmpPxza5f2Q+P+IvWh7hQl7DHAoSvt6MM=;
        b=TJnqnhrgU8PXGDgjVamGFgK7WOorgF6pv2x4ZtnZoTvfAidZQO5+DIiHIxnFCcAOAu
         tS7oSGw4GPC0JF7tRyiVW7JkDonI1eqwPQmbYIHNMB88MPDzIZBzFdAPv64PmmqjVqy/
         xMd0vPeDtt3kyJ/B1mIV3LeX/sKjGD+taAJaTdK/49CIPdzV9MG4DAKt2RKMN1RBI9SH
         MCIzGB9R9ub+Ntky+vBlJnePjr9tlCOgBV5EJfF+tIWacv+UsHHbys2GFDL34I1IwGhz
         z8/AD9ipOY50UpLO5TCtUuPhy+9gw/UuMvtLzNHcwpD3n99gWuWZtkBQBQU2dub0tEWG
         03sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444808; x=1692049608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSz5PVzqt7CmpPxza5f2Q+P+IvWh7hQl7DHAoSvt6MM=;
        b=dZjEmEXRARXVfMK0FDURIzDCj0aCzlCN9rHEmNisf/rQS29KbB2f91OWGkE2nGxFAl
         s2brFvEaNUwiQ9EDQpaeduhg+bDgGR8HXfkXOPfaSeg7p5uh4ytYYUxVfavLEBKbWNUH
         EpLV/3WkA5A6oaTSMkbgsZfoaGbQK4omAeYTRFD9lJWUEaF4uKaKR1ZXuYBTRCQJZV+C
         lWrO9/z94nwF++WBFhhB09qHmKeLnIOb6hhxsFkYPYanDeQOsNFQlPUgJdkEjFp5aLRk
         MsWz2eoHq+0+0Bow/RS0pJlO73R3i+9MBoU373A7kf4eN6103T/yuBg1Bve8zSSLyG4V
         Xksg==
X-Gm-Message-State: AOJu0YzwRrRrkP1TT94AQZGki2p7CqYeVCaVaQUkvcSWTW0KWyebU+ev
        x8DSsOhTTHS5j58ce6OtOPalomJrLDE/uf0p40Ek
X-Google-Smtp-Source: AGHT+IFwSDKlOGWgqvs4YaQVopmHIzWi/qN8dtjMIK1xfa/ev+Mu5Odk1TFjShesKmhrlSjajMtsNg5jyS1S6i4B8Y0=
X-Received: by 2002:a05:6358:4303:b0:131:127d:4b59 with SMTP id
 r3-20020a056358430300b00131127d4b59mr7295326rwc.23.1691444808247; Mon, 07 Aug
 2023 14:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230729024026.32228-1-yuehaibing@huawei.com>
In-Reply-To: <20230729024026.32228-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 17:46:35 -0400
Message-ID: <CAHC9VhRW0Jt0pitVx1cw-zJGWfTmvTU4RSmOFKANYJA7CeEF7g@mail.gmail.com>
Subject: Re: [PATCH v3 -next] keys: Remove unused extern declarations
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 28, 2023 at 10:40=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> iterate_over_keyring() is never used, so can be removed.
>
> And commit b5f545c880a2 ("[PATCH] keys: Permit running process to instant=
iate keys")
> left behind keyring_search_instkey().
>
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate=
 keys")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: Add Fixes tag
> v2: Also remove keyring_search_instkey()
> ---
>  security/keys/internal.h | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 3c1e7122076b..471cf36dedc0 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -109,13 +109,6 @@ extern void __key_link_end(struct key *keyring,
>  extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
>                                     const struct keyring_index_key *index=
_key);
>
> -extern struct key *keyring_search_instkey(struct key *keyring,
> -                                         key_serial_t target_id);
> -
> -extern int iterate_over_keyring(const struct key *keyring,
> -                               int (*func)(const struct key *key, void *=
data),
> -                               void *data);
> -
>  struct keyring_search_context {
>         struct keyring_index_key index_key;
>         const struct cred       *cred;
> --
> 2.34.1

--=20
paul-moore.com
