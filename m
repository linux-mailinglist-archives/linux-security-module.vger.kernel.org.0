Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183732B2BF
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Mar 2021 04:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbhCCCzl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 2 Mar 2021 21:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhCCAOZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Mar 2021 19:14:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94255C06178B
        for <linux-security-module@vger.kernel.org>; Tue,  2 Mar 2021 16:13:35 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hs11so38776477ejc.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Mar 2021 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dm4OZHUwldy8T/Eg62HwAPhGG9sTbN3pRz7euTlh8Xg=;
        b=idsUmG0LIP09zX7WRWPg65tC02nS35rxQSinYjxTNFOP3OFFCd3wG0O5J1s/AFMvTf
         xZfYE9nyYjaWn9xuYKrhuau8oIzUz+t4PwWiCh9g6hLRJwzYxGjJD4R8pDPf14TDvl65
         A6eaOukS5dk41ALi3SV0+KwAjYF1k0IGq4g8NPKAiOSgY+LVtsVVZhaQEWCl/FhHhQDX
         Hdl8UFuy2UqUcLsyTiB4vP2BSYkilSc+WX26S8W3ouQnTfo3Ipy4e3CibG1ZiIt5hrIc
         fNbxuPCHKzPOx886diHh3RRE4DKelaaemONDngSSLJtcKXgJ/9KlvdOxWIrEYAbOKtWM
         8xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm4OZHUwldy8T/Eg62HwAPhGG9sTbN3pRz7euTlh8Xg=;
        b=OSGOMEoifm1StPqelGUFxjyxVLqiera7Ph9W/+NnTCDXNMuvqX6S6QEAOoI4WtTIeE
         RAbB12tJrAfMY8JlrbtDkIapzNEvtGf0I8ClVskvxYziu+tOdy5PngZXqjUa8Rf5EeeZ
         cqGM85VccUtu0PdBxMLvHRCMvZAl8bekGoGqSGbXrW80etbVLBQT4VquCSb9ErzQYvv0
         N9cr3twpcV958gRDZKH4G98zTI2+RZqPCzqAT2i8HCCOcAwPRJ+QZ65TKnjtfkahv1j+
         aLv0NbYdFkSnlkncEtNZtrN9dcVo3566cTR2H5FqpymYT1ROHMRBHb1feeMMb/iY6jYj
         ySRg==
X-Gm-Message-State: AOAM533A93lFtR7eQAreytiF2Tdxn2hJbI3w8Dpq8mN/3Wwm7BTsmLDS
        RxLuOfi2KCL/hrXhekG59/cMmqcyBSekiudRcl3f
X-Google-Smtp-Source: ABdhPJwoo90TZ45+GiPaXd4NJ2owiENOf090X38l/SOu8BNqL4A9a6rpKuuMBRaVk99+xqjhEClWf992ASiAIRB+Lg4=
X-Received: by 2002:a17:906:e116:: with SMTP id gj22mr22774244ejb.398.1614730414067;
 Tue, 02 Mar 2021 16:13:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006305c005bc8ba7f0@google.com> <CACT4Y+YFtUHzWcU3VBvxsdq-V_4hN_ZDs4riZiHPt4f0cy8ryA@mail.gmail.com>
 <CAHC9VhTxrGgBDW_439HeSP=_F9Jt2_cYrrQ7DtAXtKG4evGb9g@mail.gmail.com> <CACT4Y+YEu3f059=nGu9KxTi4sg6-POtziQ+0jx-KN2adjGJHRg@mail.gmail.com>
In-Reply-To: <CACT4Y+YEu3f059=nGu9KxTi4sg6-POtziQ+0jx-KN2adjGJHRg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Mar 2021 19:13:23 -0500
Message-ID: <CAHC9VhR7TrrOUNweM=mN=tZ5-zUwBaVhF_mODc3qCEawdUavJQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cipso_v4_genopt
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, dsahern@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 2, 2021 at 2:15 PM Dmitry Vyukov <dvyukov@google.com> wrote:

...

> Not sure if it's the root cause or not, but I am looking at this
> reference drop in cipso_v4_doi_remove:
> https://elixir.bootlin.com/linux/v5.12-rc1/source/net/ipv4/cipso_ipv4.c#L522
> The thing is that it does not remove from the list if reference is not
> 0, right? So what if I send 1000 of netlink remove messages? Will it
> drain refcount to 0?
> I did not read all involved code, but the typical pattern is to drop
> refcount and always remove from the list. Then the last use will
> delete the object.
> Does it make any sense?

Looking at it quickly, the logic above seems sane.  I wrote this code
a *long* time ago, so let me get my head back into it and make sure
that still holds.

-- 
paul moore
www.paul-moore.com
