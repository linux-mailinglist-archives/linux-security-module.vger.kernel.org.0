Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91946F847B
	for <lists+linux-security-module@lfdr.de>; Fri,  5 May 2023 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjEEOEC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 5 May 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjEEOEA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 May 2023 10:04:00 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DED61B4
        for <linux-security-module@vger.kernel.org>; Fri,  5 May 2023 07:03:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9e2f227640so2375053276.3
        for <linux-security-module@vger.kernel.org>; Fri, 05 May 2023 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683295439; x=1685887439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Zj99bBAIm1UppyS4HU4KQkIjs/a4617Uy0NiG4+A34=;
        b=QG6VoJ7jXS9uKFBCFU5JHUoI75Tbl5ySfi/w5V5JTB1ZC+14ZR2C4vL+QBP6vpcJWV
         GfLYeX5wZNmQt17b9LtpBYTWSjqzsV0I+Zxx8HAVnb8qtHLd7esItovGR2/k73NU/qoi
         MesWqFqbteKlk8g2f0iGH/J/8F3LASopYq+pqPs4t6jIg31MaGlFiSdZryWt7YnxpFA1
         f4VHRIA1cL7fu4Q4qZKPXGhio+pWcv9UPXm3Dws/0RrrvW14scp7RrpjQNagNvxhYWhj
         aVVPKuPRNXjtrK5USm9AU7PM9k488EbTPZZi9APwKD7Tns1e7+RntA1HGAN0/22g1KBx
         CDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295439; x=1685887439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Zj99bBAIm1UppyS4HU4KQkIjs/a4617Uy0NiG4+A34=;
        b=hUKEq7EuCU4Uf76TMkRQrIDlfzHyIKUzkzVl7XhCs19Ms5EzhRysjfyLIREF9J5zT0
         /eJxgHInGIqAKE8neSf1Z2ZhpWyNeNddkEXjg77hyo/y9lp7Ovg8hOfeU/+cJYLORA1s
         s1MP9nw8Md2BS2BeyY3d2tGJYB8EWyjcPT+xEf27ZFnH4f4EppM8d7sfEliZO7KYWcG7
         Di3VIuzX6MCdTlu4ePlrNw3n1dyNzORgDQUhEeq3dLwJ8aNKLNa8MuFChHLUK1pYdtDK
         IwsNkGy/HTrUHZfg4ypPn+2AT1nUz8NCnAi6v+K6Aomn2BJotXx2t68k7KbOQ1tlUYaL
         3nag==
X-Gm-Message-State: AC+VfDyaysDjirY1jH6o7BCH1JR+l89GJN8G1fcz0mWwHENfPMA0OXCZ
        NhvP+7NKHVfNm1Vjt2GiBI7kTd4zTodxp3a1sKU/PgH2LsYqCrCK7w==
X-Google-Smtp-Source: ACHHUZ7dI6w54B6ymUq8pT1avcQtWdIkOdaUQwoSihiaxU4HnhOSY7DDr5WC06x+5srMXKFtKMgV9QbUtNZ9UqvuxNs=
X-Received: by 2002:a25:aea0:0:b0:ba1:6097:999b with SMTP id
 b32-20020a25aea0000000b00ba16097999bmr1685198ybj.4.1683295438927; Fri, 05 May
 2023 07:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <1923bc2f330f576cd246856f976af448c035d02e.camel@huaweicloud.com> <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
In-Reply-To: <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 May 2023 10:03:48 -0400
Message-ID: <CAHC9VhQu7GQ54H0k=C8ZWU-5zOX35QNWrBMEyNTE1AU_e8DcPQ@mail.gmail.com>
Subject: Re: NFS mount fail
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 4, 2023 at 9:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 5/4/2023 9:11 AM, Roberto Sassu wrote:
> > Hi Casey
> >
> > while developing the fix for overlayfs, I tried first to address the
> > issue of a NFS filesystem failing to mount.
> >
> > The NFS server does not like the packets sent by the client:
> >
> > 14:52:20.827208 IP (tos 0x0, ttl 64, id 60628, offset 0, flags [DF], pr=
oto TCP (6), length 72, options (unknown 134,EOL))
> >     localhost.localdomain.omginitialrefs > _gateway.nfs: Flags [S], cks=
um 0x7618 (incorrect -> 0xa18c), seq 455337903, win 64240, options [mss 146=
0,sackOK,TS val 2178524519 ecr 0,nop,wscale 7], length 0
> > 14:52:20.827376 IP (tos 0xc0, ttl 64, id 5906, offset 0, flags [none], =
proto ICMP (1), length 112, options (unknown 134,EOL))
> >     _gateway > localhost.localdomain: ICMP parameter problem - octet 22=
, length 80
> >
> > I looked at the possible causes. SELinux works properly.
>
> SELinux was the reference LSM implementation for labeled networking.
>
> > What it seems to happen is that there is a default netlabel mapping,
> > that is used to send the packets out.
>
> Correct. SELinux only uses CIPSO options for MLS.

SELinux can use the NetLabel/CIPSO "local" configuration to send a
full SELinux labels over a loopback connection.

* https://www.paul-moore.com/blog/d/2012/06/cipso_loopback_full_labels.html

There are several differences between how SELinux and Smack implement
labeled networking, one of the larger differences is that SELinux
leaves the labeling configuration, e.g. which networks/interfaces are
labeled and how, as a separate exercise for the admin whereas the
labeling configuration is much more integrated with Smack.

I wouldn't say one approach is better than the other, they are simply
different.  The SELinux approach provides for the greatest amount of
flexibility with the understanding that more work needs to be done by
the admin. The Smack approach provides a quicker path to getting a
system up and running, but it is less flexible for challenging/mixed
network environments.

There are other issues around handling IPv6, the sockets-as-objects
debate, etc. but those shouldn't be relevant to this discussion.

--=20
paul-moore.com
