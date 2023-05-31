Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9952A718B98
	for <lists+linux-security-module@lfdr.de>; Wed, 31 May 2023 23:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjEaVLI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 May 2023 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaVLH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 May 2023 17:11:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11312C
        for <linux-security-module@vger.kernel.org>; Wed, 31 May 2023 14:11:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55db055b412so22074927b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 31 May 2023 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685567462; x=1688159462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBVvWrCiTxtzHEDX16BAY1j+7bSgZNwLuSAk5FN/PvE=;
        b=TwLEaj52ZRYp1qrngqFFdT+akHp+jZIAWRAdGud0wjJdUD4VkESfBuc6KLIlfu8B5T
         DgNKWh06VarQ4XX9e9KMMm5PtqzyNgpUqCbt+Y8S1Q1C/8aNlhBqc13ZylPQKggZDYKX
         pnyoa4nRSnRPzUQ+qcNq1rQIeUKcZajMCXWourOAY8fqZmfv6B6JDsArMK4fTRZ6xPAY
         OCIo4rSLKXNOBSDrnnzZgrwxLFPxBYv8VHimlaWGUv5g6K4vtJEQXv/gS7lHmDOBbTat
         e9iWQpf/s0j6qomZp10nGeexnSsquf5XQShkTy8HKjgy6fmopr2RE0RKe/jGwqehsCzS
         Qbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685567462; x=1688159462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBVvWrCiTxtzHEDX16BAY1j+7bSgZNwLuSAk5FN/PvE=;
        b=fCui0GsrSzrfvFUCyP0UDCzOke3HQBdM9355yH7Ch4o5tsC3Wvu609PubycW0qWzme
         LIXPKw/xAOKHszk67Ww2p2C/HiVfnsCq4XAjwSeIAbgKrODjtWMQ66fDdDF5sgW1qRpS
         lvJaG9gAt3AdMNVg8NyoX8pgzG8PBYDJOeSpM5/kNdgBD/LwOMJ12mJlqCFdJHRFHm8C
         X1uUcxqEgkghmYipPthiLtwY/IrsrVC3AfQ9vfFNRAEoTv1dUHDjJt2elmtY6mVj96zI
         U2T/7c0dVQs27iOosn7K+RvwbaSSSehOCwEE16Vl6+1VbCnk4LVM3nNuRx6FqdTA0u71
         WOSA==
X-Gm-Message-State: AC+VfDwtlTNaWkGTAuAt69dLsTym2K0on2PjT/Db3irs5dnHJ2+8K5At
        a5y3YIuPuklGLJL2XBGj5SXI7teDct6Np9jkxp+5
X-Google-Smtp-Source: ACHHUZ5boVf27k0iS5jfVFPwokYp9Hw5Z8flmgxYi0TeT/CNKztyX3P6jG/zcmXClc1Sq25xkYFiyrh068Lne5GH+OA=
X-Received: by 2002:a05:690c:ed5:b0:565:34bb:9009 with SMTP id
 cs21-20020a05690c0ed500b0056534bb9009mr24254648ywb.16.1685567462010; Wed, 31
 May 2023 14:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531110506.142951-1-gongruiqi@huaweicloud.com> <fe6a0f1e-6378-a4f2-f995-46799ed5248e@schaufler-ca.com>
In-Reply-To: <fe6a0f1e-6378-a4f2-f995-46799ed5248e@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 May 2023 17:10:51 -0400
Message-ID: <CAHC9VhQHUKXLejiMvETYE_PJz3cyHPF5z+T1ifUCD9ezMztcSQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: Infrastructure management of the sock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
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

On Wed, May 31, 2023 at 10:00=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 5/31/2023 4:05 AM, GONG, Ruiqi wrote:
> > As the security infrastructure has taken over the management of multipl=
e
> > *_security blobs that are accessed by multiple security modules, and
> > sk->sk_security shares the same situation, move its management out of
> > individual security modules and into the security infrastructure as
> > well. The infrastructure does the memory allocation, and each relavant
> > module uses its own share.
>
> Do you have a reason to make this change? The LSM infrastructure
> manages other security blobs to enable multiple concurrently active
> LSMs to use the blob. If only one LSM on a system can use the
> socket blob there's no reason to move the management.

I think an argument could be made for consistent handling of security
blobs, but with the LSM stacking work in development the argument for
merging this patch needs to be a lot stronger than just "consistency".

--=20
paul-moore.com
