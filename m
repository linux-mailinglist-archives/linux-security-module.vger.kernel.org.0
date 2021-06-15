Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A283A8A25
	for <lists+linux-security-module@lfdr.de>; Tue, 15 Jun 2021 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOUbW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 15 Jun 2021 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUbW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jun 2021 16:31:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57416C061574
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jun 2021 13:29:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so11923291edt.13
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jun 2021 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tUb3d+vrU01SWNkHnqFTp6elP7WYKyt6weZt4gpH4c=;
        b=C/5aCfxMDXSWhUT85X6FPMeKiIG3eCf+CiG388aSOsCzVxxv5aUtvXkMKfZpqeLgpN
         fgcM5N8j89oL+w3ZpjZPwEWjWHi2z2VaseFPqcMwyqdgN3nV5MMxGwOT/FglPkhBsV5i
         TivylFGYXHo2LuYghMO2RtojnU5N/Gcao841b15cz6djORQYc7QFzSvGHQeBGyWJflFx
         ZJWeO6LTWwS1IYQLQ4uCTk9UvjjH/Cv67l2kXMMw8LOOzOCRRnqX4lFWIiri/IsmgIyJ
         Wcpd0wwUjs7tvN54hzMk0Z8fb6GloOjscB0TqT4YYsQ9w/MG6AZSH5Z3jTni91p1Ht0f
         Ri5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tUb3d+vrU01SWNkHnqFTp6elP7WYKyt6weZt4gpH4c=;
        b=D8NSzMTCdgt1B/hEIb5b1AcJ9S6KdzFWUZCQq7eoI3pQ4SPEwzDa51BmGuGnb/ATWN
         B93v/kEtmU6i5sMKVUm8r8+iUt/IHUb+lfZaAxP4JvT1ef3qrf+0iKFOliRE80w6+hUL
         vUFcr55fBaNm+nqakgRT1w1XZ7eNIW5vMnxfMNcUdV4J6zolMnLUvtWj5f2T39IQL9Vn
         7AuTbMhE3pqUIj1Prb48SDZSyRJxleIk7Ky2YlNho+Hpl2LIvvWpdPjiDtJsesIHQ1Jl
         ewW1gdGVdMDWWxAORnnLJxMs7b7gfNg5ssT5x3Gcg6hrgekt4mGFXHvpQhLzU+XJbsv5
         j5sQ==
X-Gm-Message-State: AOAM5307Y4RAmd0YGRBIflnvXSBFGUI0+H0HAMFfHWqT0by9XPvbDC39
        xcTPvPw8yhy/UPaQPLM8gL3OSXg2zKBHcFvsQFBp
X-Google-Smtp-Source: ABdhPJyIIf4T2qpxVYty/GeKWpL9QElM+VR5KcvlIvOv6Q3SbIJCtwCMaN1Q56/SUMI/5U1TH0kNi4wFZuV4iL2X08M=
X-Received: by 2002:a05:6402:1771:: with SMTP id da17mr1679082edb.31.1623788955775;
 Tue, 15 Jun 2021 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210615021444.2306687-1-liushixin2@huawei.com>
In-Reply-To: <20210615021444.2306687-1-liushixin2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Jun 2021 16:29:04 -0400
Message-ID: <CAHC9VhRGsDZE5JVctD8DuX6nghh1nLK6qUNsO=S5HNcddEibVQ@mail.gmail.com>
Subject: Re: [PATCH -next v3] netlabel: Fix memory leak in netlbl_mgmt_add_common
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 14, 2021 at 9:43 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Hulk Robot reported memory leak in netlbl_mgmt_add_common.
> The problem is non-freed map in case of netlbl_domhsh_add() failed.
>
> BUG: memory leak
> unreferenced object 0xffff888100ab7080 (size 96):
>   comm "syz-executor537", pid 360, jiffies 4294862456 (age 22.678s)
>   hex dump (first 32 bytes):
>     05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     fe 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01  ................
>   backtrace:
>     [<0000000008b40026>] netlbl_mgmt_add_common.isra.0+0xb2a/0x1b40
>     [<000000003be10950>] netlbl_mgmt_add+0x271/0x3c0
>     [<00000000c70487ed>] genl_family_rcv_msg_doit.isra.0+0x20e/0x320
>     [<000000001f2ff614>] genl_rcv_msg+0x2bf/0x4f0
>     [<0000000089045792>] netlink_rcv_skb+0x134/0x3d0
>     [<0000000020e96fdd>] genl_rcv+0x24/0x40
>     [<0000000042810c66>] netlink_unicast+0x4a0/0x6a0
>     [<000000002e1659f0>] netlink_sendmsg+0x789/0xc70
>     [<000000006e43415f>] sock_sendmsg+0x139/0x170
>     [<00000000680a73d7>] ____sys_sendmsg+0x658/0x7d0
>     [<0000000065cbb8af>] ___sys_sendmsg+0xf8/0x170
>     [<0000000019932b6c>] __sys_sendmsg+0xd3/0x190
>     [<00000000643ac172>] do_syscall_64+0x37/0x90
>     [<000000009b79d6dc>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Fixes: 63c416887437 ("netlabel: Add network address selectors to the NetLabel/LSM domain mapping")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> v1->v2: According to Dongliang's and Paul's advices, simplify the code.
> v2->v3: Fix the style error.
>
>  net/netlabel/netlabel_mgmt.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Thanks for the updated patch, it looks good to me.  I see it's already
been merged, but for posterity's sake ...

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
