Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3589CBBBF7
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Sep 2019 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfIWTCL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 15:02:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33249 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfIWTCL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 15:02:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so14842238ljd.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfMT6FFABs8+WVOQ4a5gNHPABOSr1e233skwsQrCiw8=;
        b=IpzY4nqJc66P16YRm5ZfJwieV6oydkv4tIN11aSpzafuJZq6yNKAstSXQChu2guroN
         J2IQDMziYaomuguf6h05Q9XzLki4nCDmgldzB9zsmDlMzx8nZoSIAweGHXXeWyeukUhJ
         DFCCvN44yT+LeYV5J6NQE7cdJtFiUpgev6CS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfMT6FFABs8+WVOQ4a5gNHPABOSr1e233skwsQrCiw8=;
        b=Xsrx3+6Aymb83I64PMNITEDtm+7VIj4WorzJWQsUXn2NQG1w1fT3m2t57MvuZoSf5M
         jUKa/OVfHbD4B4bP2kbeePjsTwYqxM8AOKFnQ/IezMQhQ3yZ2U+XVnjmNdbXBJ8HmHVq
         4VTpmEs6pJZcTlYzaRvhx5Axd4S1XJBSFBgoqkRm4/1t/QAmaLcre6gkt+WQNfC/JVDU
         kOy3zksGOU2UAOI/WKd+04nLI1uSfFE9L+qF8IWpBsi+TbwK2tPVPv9AzB42kFIQ/c12
         FuacUkjzxhL3PDR0XyW2LLHDFgjKHrddG0jyMFeS61zAMY+Ia7ixn41tRxvRZyhUtril
         316A==
X-Gm-Message-State: APjAAAWyiUv2nxylv7+2Ci1oOGERUWh6slWRRvCXfIWxSnwWDM99297j
        MpHO4gUF/MywPq9apkS4dvq0ep7JQ24=
X-Google-Smtp-Source: APXvYqwm4cuBGB94lMxhzxH/kigto22qisdrxYQ1+6jm8k1S7QFNXX7jsTQnP0qMsNcD7h7LXnkUiQ==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr522061ljk.92.1569265328592;
        Mon, 23 Sep 2019 12:02:08 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 6sm2395260lfa.24.2019.09.23.12.02.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:02:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x80so10998573lff.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 12:02:05 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr624411lfh.29.1569265324930;
 Mon, 23 Sep 2019 12:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
In-Reply-To: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 12:01:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
Message-ID: <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 18, 2019 at 10:41 AM Micah Morton <mortonm@chromium.org> wrote:
>
> Fix for SafeSetID bug that was introduced in 5.3

So this seems to be a good fix, but the bug itself came from the fact that

    rcu_swap_protected(..)

is so hard to read, and I don't see *why* it's so pointlessly hard to read.

Yes, we have some macros that change their arguments, but they have a
_reason_ to do so (ie they return two different values) and they tend
to be very special in other ways too.

But rcu_swap_protected() has no reason for it's odd semantics.

Looking at that 'handle_policy_update()' function, it's entirely
reasonable to think "pol cannot possibly be NULL". When I looked at
the fix patch, that was my initial reaction too, and it's probably the
reason Jann's commit 03638e62f55f ("LSM: SafeSetID: rewrite userspace
API to atomic updates") had that bug to begin with.

I don't see the original discussion at all, it's not on
Linux-Security-Module for some reason, so I can't tell when/if the
NULL pointer test got deleted.

Anyway, this bug would likely had been avoided if rcu_swap_protected()
just returned the old pointer instead of changing the argument.

There are only a handful or users of that macro, maybe this could be fixed?

Adding some of the RCU parties to the participants..

Also, the commit message for this fix was a mess, I feel. It says
"SafeSetID: Stop releasing uninitialized ruleset", but the ruleset it
releases is perfectly initialized. It just might be NULL because it
doesn't _exist_.

           Linus
