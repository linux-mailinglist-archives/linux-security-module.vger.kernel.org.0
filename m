Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B387D3D6C17
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jul 2021 04:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhG0CLK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Jul 2021 22:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhG0CLB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Jul 2021 22:11:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC3C061760
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jul 2021 19:51:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id oz16so11185060ejc.7
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jul 2021 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WHrVtr5sg23UAa6EThmaj5rgrsjHnF8yQxTJ5xwbHI=;
        b=1cPbkOXwbNJeJR9K0+joPmNyrC3HTGx/eKKvaNhylYjcsx3W8LTcJ0DJR8smMKrYnP
         595qtG0YmWyW3dtndWc8cw4fZ52/UJeGx/fUsZqGkOCE8OH1EcwhwJwNTCkeHhX8uwgq
         /i3IQsK1VI8RBUmh/Ml5Ul32CiJMXSwZh4zQG7MJ53h4eLo0v1KJ42zhG1W0aqEGacpR
         H/F0LufrNfRDLNazmGzmv5hJm+6drPPowFukCEjzyi0cMXFA9CB+32WKrbhnpQV/0oDm
         2d8ud02E2YA1hmKi3xZwA5q+JoJ0QFm6Y4WwEeoqyQTTgq5txzzZa0LEhGWr9sIw8YgF
         hymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WHrVtr5sg23UAa6EThmaj5rgrsjHnF8yQxTJ5xwbHI=;
        b=C6hEALt+GUYu8m0xE20Nr5wWRvHEaIDCcAqleFlO0I3ZY0h4y678Sf2W4AD1eyZXx7
         WKPG2oXiWV/5rz0wWB0GDxyEIamZNyESiQsSb1EYWpQP/I61kXJSeqF4OUzROC5M41UK
         MJUWBFUiu2Jg0muZJxcNkY7WoloBlUHeTu0gfMA9M883C7nEHxHx/2Eh/cykqk29BFv7
         b9fxIP/WAmzkl/mzu/IQ/N5qOy925xpSKxYgDii+F3kaiV4jR0ocsGdc7f+3If52b4pG
         15UtljZUyL/hZANP4ndn9APWH8k9UvIwSBf3bCUSs3xMui9n4NrWahJFAfGvvZvDoTcv
         Zzyw==
X-Gm-Message-State: AOAM531tTOO2MBUwDcRru+0mjLI1mk14S9QMhQ/X3Q1PU8jTDH8S/+6t
        c86iBsSaab2TGziQOv/oqHl7r1uhPUQvwxuds3vS
X-Google-Smtp-Source: ABdhPJwHPD0Z80FVpbY6mNL4iUjH016kgam/1kNydDeJjksoFXbWq5MWYiKX1ebs3b6hp7/EgLCS7m1sr0X5yDuVv4k=
X-Received: by 2002:a17:907:3345:: with SMTP id yr5mr9671067ejb.542.1627354287120;
 Mon, 26 Jul 2021 19:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626879395.git.pabeni@redhat.com> <1252ad17-3460-5e6a-8f0d-05d91a1a7b96@schaufler-ca.com>
 <e6200ddd38510216f9f32051ce1acff21fc9c6d0.camel@redhat.com>
 <2e9e57f0-98f9-b64d-fd82-aecef84835c5@schaufler-ca.com> <d3fe6ae85b8fad9090288c553f8d248603758506.camel@redhat.com>
 <CAHC9VhT0uuBdmmT1HhMjjQswiJxWuy3cZdRQZ4Zzf-H8n5arLQ@mail.gmail.com>
 <20210724185141.GJ9904@breakpoint.cc> <CAHC9VhSsNWSus4xr7erxQs_4GyfJYb7_6a8juisWue6Xc4fVkQ@mail.gmail.com>
 <20210725162528.GK9904@breakpoint.cc> <75982e4e-f6b1-ade2-311f-1532254e2764@schaufler-ca.com>
 <20210725225200.GL9904@breakpoint.cc> <d0186e8f-41f8-7d4d-5c2c-706bfe3c30cc@schaufler-ca.com>
In-Reply-To: <d0186e8f-41f8-7d4d-5c2c-706bfe3c30cc@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jul 2021 22:51:16 -0400
Message-ID: <CAHC9VhSTputyDZMrdU0SmO0gg=P3uskT6ejJkfOwn6bFgaFB3A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] sk_buff: optimize layout for GRO
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 26, 2021 at 11:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/25/2021 3:52 PM, Florian Westphal wrote:
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> RedHat and android use SELinux and will want this. Ubuntu doesn't
> >> yet, but netfilter in in the AppArmor task list. Tizen definitely
> >> uses it with Smack. The notion that security modules are only used
> >> in fringe cases is antiquated.
> > I was not talking about LSM in general, I was referring to the
> > extended info that Paul mentioned.
> >
> > If thats indeed going to be used on every distro then skb extensions
> > are not suitable for this, it would result in extr akmalloc for every
> > skb.
>
> I am explicitly talking about the use of secmarks. All my
> references are uses of secmarks.

I'm talking about a void* which would contain LSM specific data; as I
said earlier, think of inodes.  This LSM specific data would include
the existing secmark data as well as network peer security information
which would finally (!!!) allow us to handle forwarded traffic and
enable a number of other fixes and performance improvements.

(The details are a bit beyond this discussion but it basically
revolves around us not having to investigate the import the packet
headers every time we want to determine the network peer security
attributes, we could store the resolved LSM information in the
sk_buff.security blob.)

-- 
paul moore
www.paul-moore.com
