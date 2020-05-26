Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE51C806D
	for <lists+linux-security-module@lfdr.de>; Thu,  7 May 2020 05:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEGDRJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 6 May 2020 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgEGDRH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 23:17:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526E7C061A41
        for <linux-security-module@vger.kernel.org>; Wed,  6 May 2020 20:17:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so3200663wrp.12
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2020 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqklJJgxCrgioUG9/0U8VvVyNxzQPptp+H1kEoRUcfM=;
        b=rbtQf4Gr1SzoNJgT+TsCpnOedFkDlsI4GqX3HIApmxx6nalsQhD7JafeN3haqKF95q
         9FLfc0iLXRofGuj8xSvJr9fCGoEGljqW0AfmoM25AwFBMv01MhzQk74GjUBq8Hxt5HTu
         kF5LrtH67fdEpmW13BDlx/xM9q8ZC1pdAFNdCTsjb3r/+IQquQw3L1Mhmz5wPihbB8Oa
         RKcHl2HZ6Swg7Mv+wXEaoj0P119W8tJ06Y6nXdXSmuhhAUF7MuBwIDsA9MO0zAZToS3O
         JlWjOp3xPxrOLSgeM67Dve9aoviCMexgO0SwIEfM1UZpJ+jUSpQTzPg7wLqjsFeT0/pd
         XxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqklJJgxCrgioUG9/0U8VvVyNxzQPptp+H1kEoRUcfM=;
        b=h+hp1q1flc9VwvoxyMHdMwodRVmKfxzxAfwA11j+QFNY7+Z7wFwOtdoGrcTUWFvNot
         HpEM4PO75VfT5Bps1DcSBIi91sw/kSAqNMsCE3eXzAWkzl33GuYRgajvYvIfOvRgl3v3
         wEBxKFZ0hG2avDBmvQvnER8s+v2g55xMtoUD1M4syI1KYloBQyKW1pOoH+sk/PJSU+gD
         YRGZAE+x3ZvPmK1Igt7oVOKMuvpnqWL9zgLh6vEoCfCTxdwg2HTY4yVJD5yOwK4WNd1U
         gML/TfoFWczO0OaAMOIo7AHdDyW6gFZ19JlI50Nu2d2HegPhQWxaWO2WiNGNZW2X2OVj
         Li6Q==
X-Gm-Message-State: AGi0PuaaQiIvhiNI7ORmGbALxbTJ0yYCFgwtvIWuS4hOr/Md/cOSvxbZ
        4BlW0gI8acbkH/9xSqbj4VHuQeYKsQ+8a9fkmNtQZA==
X-Google-Smtp-Source: APiQypJ1wFSkBS5disj8Gxzhwhmj5hTspeDumfe4/uryjgVRkTODm3WVF6Mgksw5Lpz+kSadGCmEn0hnihhQMkh9SPY=
X-Received: by 2002:adf:f907:: with SMTP id b7mr12664785wrr.203.1588821425549;
 Wed, 06 May 2020 20:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102709.7964-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102709.7964-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:16:54 +0800
Message-ID: <CABVgOS=Qybfh_oMGmCONUWqZ3FRcKrwPU1pooSv1SsFumaCFjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kunit: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
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

nit: Should this be "turned off" rather than "turned of" (and
"individual tests" rather than "individual test").
It _may_ be worth re-wording it to explain the "if !KUNIT_RUN_ALL"
change in more detail: that it's explicitly hiding the prompt if
KUNIT_RUN_ALL is enabled.
It's probably not worth redoing the patch just for this, but if you've
got to re-do all these to change KUNIT_RUN_ALL to KUNIT_ALL_TESTS or
similar, maybe.

>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/Kconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 537f37bc8400..e6a60391fa6b 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -15,7 +15,8 @@ menuconfig KUNIT
>  if KUNIT
>
>  config KUNIT_DEBUGFS
> -       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> +       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enable debugfs representation for kunit.  Currently this consists
>           of /sys/kernel/debug/kunit/<test_suite>/results files for each
> @@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
>           run that occurred.
>
>  config KUNIT_TEST
> -       tristate "KUnit test for KUnit"
> +       tristate "KUnit test for KUnit" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enables the unit tests for the KUnit test framework. These tests test
>           the KUnit test framework itself; the tests are both written using
> @@ -32,7 +34,8 @@ config KUNIT_TEST
>           expected.
>
>  config KUNIT_EXAMPLE_TEST
> -       tristate "Example test for KUnit"
> +       tristate "Example test for KUnit" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enables an example unit test that illustrates some of the basic
>           features of KUnit. This test only exists to help new users understand
> --
> 2.20.1
>
