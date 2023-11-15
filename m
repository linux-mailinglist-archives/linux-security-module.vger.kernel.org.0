Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773EA7E1263
	for <lists+linux-security-module@lfdr.de>; Sun,  5 Nov 2023 07:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjKEGeA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 5 Nov 2023 01:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEGeA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Nov 2023 01:34:00 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2CFB;
        Sat,  4 Nov 2023 23:33:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66fa16092c0so23614736d6.0;
        Sat, 04 Nov 2023 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699166036; x=1699770836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPT5K74xSEFe9IlCGm6whRvfQDP+YpuOQMYi/ccTjRA=;
        b=CO+HsjvaEoqoHBpJeKup91+egMHEXBiF64DZ0XVozHhqzFXz7FSCXcQBzlUf3N4jWp
         sCq3i5DnKdQ29mOhUu4Cll9X0NrqaQ332Xw1+3A3/j+FHQwb5llbJT6r32kjrxCOMhHb
         bvFcTg7w7jlgLVEgW3sGiNhsZ10KmfRLZ7p13xmB5sC2P2zL3cWpsd6HeyZxzTz5Wp8p
         UksE5UkAxudsPHQ9WPd0wlRfVVl8ozd0kuc2TuNfuyzBFgGv5o3rXvudU9TVrCaqhVy7
         MJYh7+mdhIhqVhszQqdYU3xTjP9BoNl4vVSZFyJ3Gvx2vTlq3C5fFbL0FWX88yGz/IuT
         q4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699166036; x=1699770836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPT5K74xSEFe9IlCGm6whRvfQDP+YpuOQMYi/ccTjRA=;
        b=UOsGdMq6SLBtv2QW50nbslrTGm+5jTz2KnoFmrkMLehOXj8zuKpqcBJuczEQSvleHP
         JkzUGec80ii85pO6RMEsMw4BA8ev9A1ltfpiVlokrqgJPWrlelK50EHLS/Uqjf3ciO/2
         S/FNoxPKhQKX7qK3Jtlvvlt3NfIczCyf48JPrYztGHW1q1ufW9+auZsBBSHd0UWVKx/E
         LQrR7yaDzSzr2Rdc0SMDK5zffZQcfbC7UvhSyLKdZGXnMQ5ciTofPxYTgDxBowVpFx2C
         srJBkzTWP5BaXhRSprCCSOpxYe2CiSy6soFa9tFOd2RBVkXI4DYtb5fljiUkC1YyP28j
         r+kw==
X-Gm-Message-State: AOJu0Yz9Sy4+cNhgY1UE5JIgN4BSygTk5Y3EGrKnDqCU/Dlu3jdI/eB0
        QthqJI7f5Hgw+pNjwVdGqMQHPCrQFEX8zQY5jmU=
X-Google-Smtp-Source: AGHT+IF3Uw+7+Bkn6NgMAc7FueWVXrqzfZgqJmcAE2t5D8XONiN/V4uJDAcW/xEs9/tgrAW0M9hTZH7l1p1OIFFmHQM=
X-Received: by 2002:ad4:5b83:0:b0:66d:1f11:8b7c with SMTP id
 3-20020ad45b83000000b0066d1f118b7cmr32449097qvp.52.1699166036504; Sat, 04 Nov
 2023 23:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231103190523.6353-1-andrii@kernel.org> <20231103190523.6353-2-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-2-andrii@kernel.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 5 Nov 2023 14:33:20 +0800
Message-ID: <CALOAHbD5xmQO-Acsqd0iQqjj66-CxSQVEnURNqP9zuRCc0SnYg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 01/17] bpf: align CAP_NET_ADMIN checks with
 bpf_capable() approach
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 4, 2023 at 3:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Within BPF syscall handling code CAP_NET_ADMIN checks stand out a bit
> compared to CAP_BPF and CAP_PERFMON checks. For the latter, CAP_BPF or
> CAP_PERFMON are checked first, but if they are not set, CAP_SYS_ADMIN
> takes over and grants whatever part of BPF syscall is required.
>
> Similar kind of checks that involve CAP_NET_ADMIN are not so consistent.
> One out of four uses does follow CAP_BPF/CAP_PERFMON model: during
> BPF_PROG_LOAD, if the type of BPF program is "network-related" either
> CAP_NET_ADMIN or CAP_SYS_ADMIN is required to proceed.
>
> But in three other cases CAP_NET_ADMIN is required even if CAP_SYS_ADMIN
> is set:
>   - when creating DEVMAP/XDKMAP/CPU_MAP maps;
>   - when attaching CGROUP_SKB programs;
>   - when handling BPF_PROG_QUERY command.
>
> This patch is changing the latter three cases to follow BPF_PROG_LOAD
> model, that is allowing to proceed under either CAP_NET_ADMIN or
> CAP_SYS_ADMIN.
>
> This also makes it cleaner in subsequent BPF token patches to switch
> wholesomely to a generic bpf_token_capable(int cap) check, that always
> falls back to CAP_SYS_ADMIN if requested capability is missing.
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/syscall.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ed286b8a0f0..ad4d8e433ccc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1096,6 +1096,11 @@ static int map_check_btf(struct bpf_map *map, cons=
t struct btf *btf,
>         return ret;
>  }
>
> +static bool bpf_net_capable(void)
> +{
> +       return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
> +}
> +
>  #define BPF_MAP_CREATE_LAST_FIELD map_extra
>  /* called via syscall */
>  static int map_create(union bpf_attr *attr)
> @@ -1199,7 +1204,7 @@ static int map_create(union bpf_attr *attr)
>         case BPF_MAP_TYPE_DEVMAP:
>         case BPF_MAP_TYPE_DEVMAP_HASH:
>         case BPF_MAP_TYPE_XSKMAP:
> -               if (!capable(CAP_NET_ADMIN))
> +               if (!bpf_net_capable())
>                         return -EPERM;
>                 break;
>         default:
> @@ -2599,7 +2604,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>             !bpf_capable())
>                 return -EPERM;
>
> -       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !c=
apable(CAP_SYS_ADMIN))
> +       if (is_net_admin_prog_type(type) && !bpf_net_capable())
>                 return -EPERM;
>         if (is_perfmon_prog_type(type) && !perfmon_capable())
>                 return -EPERM;
> @@ -3751,7 +3756,7 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
>         case BPF_PROG_TYPE_SK_LOOKUP:
>                 return attach_type =3D=3D prog->expected_attach_type ? 0 =
: -EINVAL;
>         case BPF_PROG_TYPE_CGROUP_SKB:
> -               if (!capable(CAP_NET_ADMIN))
> +               if (!bpf_net_capable())
>                         /* cg-skb progs can be loaded by unpriv user.
>                          * check permissions at attach time.
>                          */
> @@ -3954,7 +3959,7 @@ static int bpf_prog_detach(const union bpf_attr *at=
tr)
>  static int bpf_prog_query(const union bpf_attr *attr,
>                           union bpf_attr __user *uattr)
>  {
> -       if (!capable(CAP_NET_ADMIN))
> +       if (!bpf_net_capable())
>                 return -EPERM;
>         if (CHECK_ATTR(BPF_PROG_QUERY))
>                 return -EINVAL;
> --
> 2.34.1
>
>


--=20
Regards
Yafang
