Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BD5E7162
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Sep 2022 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiIWB2V (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 22 Sep 2022 21:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIWB2U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Sep 2022 21:28:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B601176DE
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 18:28:18 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t62so14608482oie.10
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 18:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s/6p8wN+VGvSrnwRHCNxYJbAlNC9MCYqHdn8E1KltBc=;
        b=MiEmXExP/Uly7GSmB4QzuSnXDeHlqxx2OYMWx1W1iLm6vljxXfeG/Z1YepMPzxT3Vr
         pjf3zh1pkkU+//zUrJhF4e4JGkNqdyppztz4T8wJ/uCNDG9n1+wm2AxbOTmrrnSjbib3
         iMJkLUI1e210eZUYsproVon8WIbSm9FDnQrMocQmAf+cwSoPvcJxl/EQW1gPOTO1a1v0
         uKM3uV4+5qY4zCW/+rO28NdwsOmv63e8AuEiKOD5G1dvIwDKIFKt7sQe31/J+fhjZf9J
         3P9O5j8Qmjl6gy2o2ER9gscgaXthVC4wjW5i2vSOkefhL6zf7xf6j0QhCmz9O5sjsKwf
         W2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s/6p8wN+VGvSrnwRHCNxYJbAlNC9MCYqHdn8E1KltBc=;
        b=hbjFfZi4vXs85lvNZpmTrOdbQLqWJPsh5CBD2sg8JrcWe2m9Ug/z/Q0C4DFbdII5sz
         ou/Ui89UYHECxzlFu24+ooDRgzuEpW1ijEl4f1OUHcFyu/ZUin83kGPjQ5as2KIOBi3P
         qftQ+gEPOibgAUkfJJSCeTSszu1bOeT8DN//ng5CYNBQntaqxW12IgH7Ci+oqQQ8k5l8
         0ky7qCP/riCUggDPNFBhgGKnG2sWBhMlFVAheVY7YwYMYG7ysbnBoaJ0LIZUYqnV4MZd
         nqiqMXveqRsoYMP5VqqmXgRbjmsqbGSX47Su1FQtK7HBi1mcueZoRYhF5/y2R0Mbl6lD
         QRkA==
X-Gm-Message-State: ACrzQf2J3IIAirw79Maj121+ShsyGvrjYkDsPFKMoXnM6+lXKNtZuKbJ
        SuiQ6ndDZyuLMCZkQEWVqyl4uieFoXo7CqQ0Bsoencczgw==
X-Google-Smtp-Source: AMsMyM7Yf+KZZuONXI++p3mR8psQkZBWvo4g+9yZJfNGgyny4tIddm5WbnhMos4FwWrI0S/BZoFi1lqAinau9cVB2O0=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr7833965oiv.51.1663896497881; Thu, 22
 Sep 2022 18:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220922193817.106041-1-nathanl@linux.ibm.com> <20220922193817.106041-3-nathanl@linux.ibm.com>
In-Reply-To: <20220922193817.106041-3-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 21:28:07 -0400
Message-ID: <CAHC9VhTWMFbCxQFAEJZzS3Kd5cSFigmvHac5y5ypVU7TqRqpTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/rtas: block error injection when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 22, 2022 at 3:38 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> The error injection facility on pseries VMs allows corruption of
> arbitrary guest memory, potentially enabling a sufficiently privileged
> user to disable lockdown or perform other modifications of the running
> kernel via the rtas syscall.
>
> Block the PAPR error injection facility from being opened or called
> when locked down.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c | 25 ++++++++++++++++++++++++-
>  include/linux/security.h   |  1 +
>  security/security.c        |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1ca8dbacd3cc..b5d5138ae66a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -123,6 +123,7 @@ enum lockdown_reason {
>         LOCKDOWN_BPF_WRITE_USER,
>         LOCKDOWN_DBG_WRITE_KERNEL,
>         LOCKDOWN_DEVICE_TREE,
> +       LOCKDOWN_RTAS_ERROR_INJECTION,

With the understanding that I've never heard of RTAS until now, are
there any other RTAS events that would require a lockdown reason?  As
a follow up, is it important to distinguish between different RTAS
lockdown reasons?

I'm trying to determine if we can just call it LOCKDOWN_RTAS.

>         LOCKDOWN_INTEGRITY_MAX,
>         LOCKDOWN_KCORE,
>         LOCKDOWN_KPROBES,
> diff --git a/security/security.c b/security/security.c
> index 2863fc31eec6..6518b239ada2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -61,6 +61,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
>         [LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
>         [LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
> +       [LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",

See above.

>         [LOCKDOWN_INTEGRITY_MAX] = "integrity",
>         [LOCKDOWN_KCORE] = "/proc/kcore access",
>         [LOCKDOWN_KPROBES] = "use of kprobes",
> --
> 2.37.3

-- 
paul-moore.com
