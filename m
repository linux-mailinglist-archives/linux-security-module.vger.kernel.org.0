Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5606C4D04
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Mar 2023 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCVOIE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 22 Mar 2023 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCVOIC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Mar 2023 10:08:02 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A74AD06
        for <linux-security-module@vger.kernel.org>; Wed, 22 Mar 2023 07:08:00 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5445009c26bso340286777b3.8
        for <linux-security-module@vger.kernel.org>; Wed, 22 Mar 2023 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679494079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EakOMVvmjMrpb457OnFfYZClCBACmlWo/Bdwpmz3ho=;
        b=Bq0nLj0I4jhCoeI2O/FcBp826/00O1M1O0TDmkYE5MBR1Yw2ZzBCSrh+slr/9y6MKk
         WhLZHaDuSoJCTuKHwMclihwWBvyAwU7M3Z2xjWTSy4cuqGOAB1lJlwCS5qH4dMSxGZba
         iUW76DCjYQLx7FJvnh0eB9Ie1EWVbMCzK/ke58iKlYlBzg4Zw/hk54ZOC7xPuZn2sLvE
         IHEniGW2jl979RkJGqZrM6MN+MssrXP2j9d/4rcnilRJ6oGC4EgFNU1ZunF69PI3HMUy
         h5BZxjPJ7ssMceCccT/j7Awzy//rHe8Nc+AtqZlsxX8tVJapXASBrrhjj7qE4SQ7MLXi
         glUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EakOMVvmjMrpb457OnFfYZClCBACmlWo/Bdwpmz3ho=;
        b=GBF4O5HK0jHcxRPvLf9xi6qQb720KVG3gVBygqC/KJ3nEN9NxOhBcyeieELmA6VeWn
         c9VX3vKlgIVxsUdFlYOWjAZh90taBg8xdjWvbn+kHVyL38oAVoJIZG0tpCUev7oBawuE
         dSpQ4Rzyli0ohxaZiXYRF6rAxF8u7Zrh42u2YiObUZF5v4umsGJXC/LgOTocLqJcz6oT
         +4BalXP/GcexQ+/9nqvYzgoTsyxCAt6+fdFio7d5m6YXds2atCDLF8TCuPvQr932kvaw
         KQwlwEcD3h1K/FBIWxKA6PRPxjexspn6KDFnbPio9yyBNi8ZfZcLFb5NAZZUxV0y3HnC
         a6sQ==
X-Gm-Message-State: AAQBX9exrOs102uLlb1GdzFaRN2oqDwnKenvjfaokEiQe7DjMMwnFMzp
        mZf9f83aJaTw4c75ASyQmh0dBPmK+ScTI9rCkLDV
X-Google-Smtp-Source: AKy350YJvYPmZdXNUJfmC7kxcMB9gDrOVe3l06Mal5Xkb0cXB7QE+r2GmVHGornORg0Jzt4IPVF/0t2Zye7NOAwla6I=
X-Received: by 2002:a81:ac62:0:b0:541:7f7b:a2ff with SMTP id
 z34-20020a81ac62000000b005417f7ba2ffmr3075152ywj.8.1679494079305; Wed, 22 Mar
 2023 07:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com> <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
 <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
 <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
 <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
 <YitWOqzIRjnP1lok@redhat.com> <CAHC9VhQ+x3ko+=oU-P+w4ssqyyskRxaKsBGJLnXtP_NzWNuxHg@mail.gmail.com>
 <20230322072850.GA18056@suse.de> <CAOQ4uxgH905R1dkQy5=tuG4nnB-p2XUWcf91vvYbfu2DyftzPw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgH905R1dkQy5=tuG4nnB-p2XUWcf91vvYbfu2DyftzPw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Mar 2023 10:07:48 -0400
Message-ID: <CAHC9VhQMixtPrUmqBKrEWeT-BshyP35By71h-QSXj1zoJBba4A@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Johannes Segitz <jsegitz@suse.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 22, 2023 at 8:48=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> If the security guys are going to be in LSS in Vancouver, perhaps
> we can have a meetup with overlayfs developers on the overlap
> day with LSFMM (May 10) to try and figure out a path forward.

At the very least I currently plan to be at LSS-NA in Vancouver and
would be very happy to discuss this with anyone who wants to talk
about it.  I'm also happy to continue to conversation here too, for
the sake of those who might not be able to travel to LSS-NA and/or
LSFMM.

--=20
paul-moore.com
