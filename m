Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312691C8077
	for <lists+linux-security-module@lfdr.de>; Thu,  7 May 2020 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEGDWU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 6 May 2020 23:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgEGDWT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 23:22:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E0C0610D5
        for <linux-security-module@vger.kernel.org>; Wed,  6 May 2020 20:22:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so6373013wme.1
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2020 20:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kk0ta8CJJvK0axV2H19B2ID8CRr84BT0Md+eQfI6e4I=;
        b=lZEvqhDsVUxY8Nmk6q2BTqJ/Mt6WMu3RQjTMotZz/9xzTGG3LPuhtCYs6hOSnbgZI0
         RVgpQo7Y4gTJK9Bztt3RTbbdz8565pTtzOUGubDfeXBrkqEsXX7b6VeZwFr5BF3XEDbE
         JhV28t+iZyxO34zVhZPu0T8ZVYntytXi0ws4ozQXB+PfMU3gLvU4bPHzfd8GYvkVZonW
         ShlB1q0h7Cpuj8JjCh9Do1LotWLqUgcLNHFc2gxKNBfK/8IuPIVYwndjwc29ApwMZ3hw
         IjwrTXACc7i4gaol3bPpPkO2ezHZ0x5eqXoeGIwZ7CFwZQjTcEwYIllGeQbjqIRGHzxl
         HelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kk0ta8CJJvK0axV2H19B2ID8CRr84BT0Md+eQfI6e4I=;
        b=SFtmcxMNLxLnEZcP9ZkgIcQdm2uHOKtBm4fP/LSoR5VKdEHMq6i6/9Hi4oK23zl74l
         YGdmGVFlHKORcQzZymg1CRx7BhNzYCrJQ8fTIKk0RljK1SYGVeL+MD8jgxHysx+lnqYJ
         HyMPUxCghapza5UvsdPnPZriEC6caNsca9ojkmeZ0VOG5BsCmrH1Nl3gp5BGto/AooHB
         s4OCxXFx+Pkea1rhfU7/HCSiws2bdeZTDoKEwumu6Xsoo6g5718gjoB1LTDbhq9l8kxB
         BZY06fKbKcWX78xjSN9yojBiPIziV/hiqKJ08bBaPXmwG/Fod1+qlhHOPiSgXDmdRfzA
         fIew==
X-Gm-Message-State: AGi0PubhhvofB1q5zy5ja5sdJd5bw/cOjX4Sn1Xc0YP0b8efn9slju/J
        eSwXLg8Krxk/TO3eN8hhmVpF2HmqiIpRRlWO/3j51g==
X-Google-Smtp-Source: APiQypJ6aSj9BKwlVBZ0o9gg8R+aiyiIYoBAFgLJpU/RXRGlmuWTFs+zjhfrm/JzN3rUGsKBSDtJSh5OA5wP1QTyWAg=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr7610574wme.138.1588821737544;
 Wed, 06 May 2020 20:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102723.8120-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102723.8120-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:22:06 +0800
Message-ID: <CABVgOS==HEaYybfRTy4a9-hxGbLa_upE3WycVZ5PueOOvUOQuQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] fs: ext4: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

As with the others, "test"->"tests", and "of"->"off".

>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>

> ---
>  fs/ext4/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index 2a592e38cdfe..76785143259d 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -103,9 +103,10 @@ config EXT4_DEBUG
>                 echo 1 > /sys/module/ext4/parameters/mballoc_debug
>
>  config EXT4_KUNIT_TESTS
> -       tristate "KUnit tests for ext4"
> +       tristate "KUnit tests for ext4" if !KUNIT_RUN_ALL
>         select EXT4_FS
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the ext4 KUnit tests.
>
> --
> 2.20.1
>
