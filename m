Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB45F1C807E
	for <lists+linux-security-module@lfdr.de>; Thu,  7 May 2020 05:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgEGDXz (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 6 May 2020 23:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbgEGDXz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 23:23:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CB2C061A0F
        for <linux-security-module@vger.kernel.org>; Wed,  6 May 2020 20:23:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so4705696wmb.4
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2020 20:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RehF+Lbhxhq9Xkk6jXt+Qi/neDNvTZtWlb2wbCcSKzA=;
        b=K29LCtIKca1QjHY0zPBU8xm4rC87fAGCD6BO0YUo076sZCHp3LjbON9Hp2k0GOJh6k
         ZDaBZFjmu/b/S7MslFnnrzQWa+ppaJwibVFPuz9N5r3wxTegsbcOGDVZKAZD8ugtrfyX
         AW3m3DuT6+RUsvW5EOj1cq5Fstytdl60a5I8VJTP7KK4fC83gD9PKISqCIRM1v/R9DAh
         nSf1/VwF5s92TiZik4qmPMKt3QICdZXZQnzFmZbbr2wT3Adxm03VPZ1xVyJmWbBZZqHQ
         88aaqLrIGxQDN87XoZHnxD1Kt6cJVfCXrWmC6nx1NCEHDLUNYnHlxQVw/mNAvu0BQspE
         K88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RehF+Lbhxhq9Xkk6jXt+Qi/neDNvTZtWlb2wbCcSKzA=;
        b=tPrtJRnE0m3OtTkd9sKI+Qiucw2IdEMqlanSmi3hPCtUTFC6Jaf5sQy0UBhojJzbHo
         SF50SlWdmdvTgs+Yu+30+s+StGUxTUZ4OPaL1hGhsShHwAQRLQ73Fvf/Ox5PdSddk1PX
         ualk+g0C6Whpvz4H8wUf6eOU3IQrRVR/3mab/X9V6Hcz1xwt+bUHYywXmV9A6BrQg4zN
         LD95dDQOOH71Udt5XaLOw+6Du0QxIRkDOM3m/lwcY9EpEd693Fv8Ekkw0dWA/Burbv5M
         dEpSxWdzW8fhlPEA3fsgWSPDTYNQ7c/RGQWW/vKm9gKU3D0xCaSndAU7ejRaWmp9R82J
         HlRw==
X-Gm-Message-State: AGi0Pubhq9PHY217bcf5i4BSUO1ZuGS9XgOwwL5qtsllAQhCpKgaReV/
        HXVCtdqr2xArtUM8g3cdYION5CzGf6id0MhILsk/WA==
X-Google-Smtp-Source: APiQypLno73+x6KDIby1g/1u0fbS1oEjqXGSDYff5mIyXJ8ZpzFfEMRqRtBRgWTSdwTIKl7dwuXNGRs2uPVP9nxNz8I=
X-Received: by 2002:a05:600c:4096:: with SMTP id k22mr7165753wmh.99.1588821832834;
 Wed, 06 May 2020 20:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102728.8168-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102728.8168-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:23:41 +0800
Message-ID: <CABVgOSme6_CsXDjH4dBaUqeMQxLeK_TcgJRWX8aqosEAKgHrZg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] security: apparmor: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        =linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> This makes it easier to enable all KUnit fragments.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.

Again, as with the other patches, might be worth revising this
description when changing the config name.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>

Thanks again for the patchset, it's working well for me.

-- David

> ---
>  security/apparmor/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index 0fe336860773..c4648426ea5d 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
>           the kernel message buffer.
>
>  config SECURITY_APPARMOR_KUNIT_TEST
> -       bool "Build KUnit tests for policy_unpack.c"
> +       bool "Build KUnit tests for policy_unpack.c" if !KUNIT_RUN_ALL
>         depends on KUNIT=y && SECURITY_APPARMOR
> +       default KUNIT_RUN_ALL
>         help
>           This builds the AppArmor KUnit tests.
>
> --
> 2.20.1
>
