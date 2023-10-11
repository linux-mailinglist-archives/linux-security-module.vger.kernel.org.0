Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45D7C4980
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Oct 2023 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjJKF53 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Oct 2023 01:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKF52 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Oct 2023 01:57:28 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654298
        for <linux-security-module@vger.kernel.org>; Tue, 10 Oct 2023 22:57:26 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b6043d0bbeso407648241.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Oct 2023 22:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697003845; x=1697608645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rpI7RMp4KwAd+fbis23QPkCG7JmUkdUenupCcGtFmrk=;
        b=ndSZ8oZk789qSeZqXXNRYV/bDpUXTHfGWNb/ZPU19hgUtuXb1wrVQrsK67XlAlUF/6
         6C25PevA51cFO28ll35RROt8tv6oYymJQpKsBTPwHjao27+P7BIU52ANT0s2JQt42Mv8
         dQxJZ/zM4WuBL2FeV6gCbTIfNEBf+55WkmqspBCzlUqc8vUj3HTiUaqPLeJzy1RHCqa/
         ANKKvex6usXgR8MzLlL+hLHXJnwogBJ/Sy+7cJsCKESCyOYNa2zn2a678C8jwvIbg+Ms
         tJyHuGt8bXY/++eAUb/2OUGfnkGbI314PIFpLCc5JojoV4eBuGw7z6zEBabshNp5pkVx
         XCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003845; x=1697608645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpI7RMp4KwAd+fbis23QPkCG7JmUkdUenupCcGtFmrk=;
        b=e/qaVbKzwqSS6uzxRVZyM6rg7tdzXp41YFCCu4D2IUdPQjkbHoPyfGpHug3SzxW+Ij
         iKkkqA3qqL49UwbXYOwKqq3zQ1uEQUaY6D+GRtNIFRqxhXWXhKWP66ijEi2/VnXioR/f
         60tDhICFkeL4RHVsTg+MveG5Od2p2mrOw6iuX50UJkTi3tbOZ9MdVFDFf5Dw14jIuVI6
         7LzJ8w4Gwfv4eE2FEYp5MX3PO5aPrnbPBjw0NBxwP8bRJ8Esfd3R4qQktSHrEQ3HL3R+
         GL3jNmAeeXf9mvbSLNWTTjPHwxe3zsqbB8hlQtPLCo74PxPq68t4ktVqEMI5W1WndCKV
         KKvg==
X-Gm-Message-State: AOJu0YyJwI+HX3sbLE6tlPmc6V19C8B+8/puaCSdQy1rc+z6ctQk8nxg
        00Ei2cYjQ3D4pwNxrBZnQvWHrlLAwpasnVgHeUlhOg==
X-Google-Smtp-Source: AGHT+IFhpaktORPpqlglbJLvqlvNhAWcwf5rY4eKbTFwOyBGvCqNgxhW1SFSwKbGlW143MY7iKOCGY2zxetWSUvbm9M=
X-Received: by 2002:a67:ed83:0:b0:452:7c1b:d57c with SMTP id
 d3-20020a67ed83000000b004527c1bd57cmr12788130vsp.28.1697003845032; Tue, 10
 Oct 2023 22:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231010231616.3122392-1-jarkko@kernel.org>
In-Reply-To: <20231010231616.3122392-1-jarkko@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 11:27:13 +0530
Message-ID: <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Do bind neither static calls nor trusted_key_exit() before a successful
> init, in order to maintain a consistent state. In addition, depart the
> init_trusted() in the case of a real error (i.e. getting back something
> else than -ENODEV).
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
> Cc: stable@vger.kernel.org # v5.13+
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 85fb5c22529a..fee1ab2c734d 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -358,17 +358,17 @@ static int __init init_trusted(void)
>                 if (!get_random)
>                         get_random = kernel_get_random;
>
> -               static_call_update(trusted_key_seal,
> -                                  trusted_key_sources[i].ops->seal);
> -               static_call_update(trusted_key_unseal,
> -                                  trusted_key_sources[i].ops->unseal);
> -               static_call_update(trusted_key_get_random,
> -                                  get_random);
> -               trusted_key_exit = trusted_key_sources[i].ops->exit;
> -               migratable = trusted_key_sources[i].ops->migratable;
> -
>                 ret = trusted_key_sources[i].ops->init();
> -               if (!ret)
> +               if (!ret) {
> +                       static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> +                       static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> +                       static_call_update(trusted_key_get_random, get_random);
> +
> +                       trusted_key_exit = trusted_key_sources[i].ops->exit;
> +                       migratable = trusted_key_sources[i].ops->migratable;
> +               }
> +
> +               if (!ret || ret != -ENODEV)

As mentioned in the other thread, we should allow other trust sources
to be initialized if the primary one fails.

-Sumit

>                         break;
>         }
>
> --
> 2.39.2
>
