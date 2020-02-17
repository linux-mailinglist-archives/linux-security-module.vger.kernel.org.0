Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018791616FA
	for <lists+linux-security-module@lfdr.de>; Mon, 17 Feb 2020 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgBQQHL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 17 Feb 2020 11:07:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgBQQHL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Feb 2020 11:07:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so20400329wrt.2
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2020 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoTcUJNOmTnmW8MfOyrWNWTU1kRF1g/1PHuBsSd2zGU=;
        b=jPOTaie7a/J+VW3BHpEwtEOQxHijWh3afiLM0FSQBJAYrLpZ+q3/7D8eiVQHH3lL+I
         dY0KdVxvoY1+mEM16tRqYmH2yXp/jzD96LIghIigYjWkvB4vjkbILzkx3UxtUihY5ppb
         M6oLapTFYLZajr4L1k1lpqXBkDRZRJ83T4W1sEnY6LznanFh8HLxTZfbh6uq5Il+4Iwe
         xOKFTB/5AU2hl8UtpNahaeEiguYCjBI4WfZl5gH/dlOiGnECzC5aaD53gEZ9sKnpTBMB
         DFm7ZbmUWle7h90Raxci+kCkaLFaFWBnzCAr531+rVH5wbSOZlK+AN4yzZOsdcOXwWD4
         9/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoTcUJNOmTnmW8MfOyrWNWTU1kRF1g/1PHuBsSd2zGU=;
        b=WIqT+NR6W83rPnUVDffBHgDC1CeqaAUkxB4T4Bn31ffoZfcFl4dbxb7lQdOqUBLlCt
         A9gwz9ed3b0LS5x/DLmUvIcCjLr51R21BKDyiyI2TgWsLZHrZ+1qOk8FXOUNuP55UVXV
         Sxwjsta3wBriRmUE0R3uiht/xteby1lJKFXcPCKCJw6xX2Uwh7Afy13TThh5KMxd321i
         L4+qhqQU5CmDoUg+E41YkhODSQzBjuAYLlma0AYOveWtSyIJY/LxfSLvM04yK9DQfHS7
         RI1wbU/CpmNdR2trKIT0ZvJjJZKI0tyvize+81X4eIYHhVFZFgytJeZwGwt04qQvEZ7e
         N84A==
X-Gm-Message-State: APjAAAXq+k+B7EaH0UWudC/nN2Z2w3y4fF+p8zHyf11PuLGYEbXM1xeM
        q8Ch65MGWbfnhPd8LnKcHCQY/kqiVo6z7BepnnlMLQ==
X-Google-Smtp-Source: APXvYqy1lU43nGfuVi+0t+0kIeBYa5bi0B7zpnZvihj6Xe5Dqp1ME7CD5EYKpkeLjydjSZNkML5nEZwKDBgWy6COt9o=
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr22659366wrw.262.1581955628501;
 Mon, 17 Feb 2020 08:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20200217154549.20895-1-tiwai@suse.de>
In-Reply-To: <20200217154549.20895-1-tiwai@suse.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Feb 2020 17:06:57 +0100
Message-ID: <CAKv+Gu_9AqVnhwUUOGyL1HMUYgemp6SD2O5CJjy2vKpeuP4eOA@mail.gmail.com>
Subject: Re: [PATCH] efi: Suppress spurious "Couldn't get size" error
To:     Takashi Iwai <tiwai@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, Joey Lee <jlee@suse.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 17 Feb 2020 at 16:45, Takashi Iwai <tiwai@suse.de> wrote:
>
> The current efi code emits the error message like
>    Couldn't get size: 0x800000000000000e
> on various Dell and other machines.  Although the whole problem is the
> buggy firmware, showing this as an error level is rather annoying, as
> the error message appears over the boot splash.  Basically this is the
> result of missing entry and we have no explicit way to fix it for such
> a firmware problem, the error message may be suppressed.
>
> This patch changes the error print condition and suppresses the error
> message if status is EFI_NOT_FOUND.  It's a partial patch from the
> more comprehensive one Joey Lee submitted in the past.
>
> Link: https://lore.kernel.org/linux-efi/20190322103350.27764-2-jlee@suse.com/
> Cc: Joey Lee <jlee@suse.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Hello Takashi,

Javier sent a more comprehensive fix for this today. The problem is
not buggy firmware, but buggy kernel :-)
(the code assumes that all systems boot via shim, and that certain EFI
variables are therefore guaranteed to exist, which is not the case)

https://lore.kernel.org/linux-efi/CAKv+Gu-a5Bo9i=K55pa3jEXRq-u5JYVGp1jFEE=UY5B=6eUkRQ@mail.gmail.com

-- 
Ard.


> ---
>  security/integrity/platform_certs/load_uefi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 111898aad56e..8501ea62cb3e 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -44,7 +44,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>
>         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
>         if (status != EFI_BUFFER_TOO_SMALL) {
> -               pr_err("Couldn't get size: 0x%lx\n", status);
> +               if (status != EFI_NOT_FOUND)
> +                       pr_err("Couldn't get size: 0x%lx\n", status);
>                 return NULL;
>         }
>
> --
> 2.16.4
>
