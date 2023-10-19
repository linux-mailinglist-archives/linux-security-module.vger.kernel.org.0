Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC27D0229
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Oct 2023 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbjJSS5w (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 19 Oct 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbjJSS5v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Oct 2023 14:57:51 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E65CF
        for <linux-security-module@vger.kernel.org>; Thu, 19 Oct 2023 11:57:49 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7db1f864bso99554827b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Oct 2023 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697741868; x=1698346668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQpW3IYG7FT0shNWIbuInaAuHh5ShVkggzRfQfKa5Lw=;
        b=Ib+t9fDvwj37j1e6uWkN/Fn3wkQlizQCiViEnpyGUuwcnpJUTjkwG+oQ5LP7eqK2aX
         VQnvAEV0riCdXAFLqm9FnGdUdRFKEC+TqHhVigLL3YEyt+RjLW+MN9NSBZhbzZCYEUEB
         jGYRo3OhUBDq2xAjiJb9ObXypgjbSXn4a2njZbDQGdmOWWvuZtvFuMzacfnyOnseSW2A
         qJ6dSOCuCKp19HitGctb/sUZALdvHoUvfgSISv6/iWXK08hvvNisfjNvUWNaxKHW7WoX
         QIajwKtYXyKpMgQd4/VxRodcuKNR0TVxVMCgCxtCbcVHIaAsCB0tKEFOG4rC3EgyaAD5
         +GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741868; x=1698346668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQpW3IYG7FT0shNWIbuInaAuHh5ShVkggzRfQfKa5Lw=;
        b=CQnkWHUoVfHdU+CMHql4K8OSuHsIwvOlKl3FwuAiyLfrv6Vj1wyXHb4UvV/+DIOj+y
         KFYRrAnDC7IoOcoF+bTtB838zPnQ/ym+oESzfWIcCR9417sqRMF/0S9QJgvTJb/u4fJB
         aJXffbIQFsjUHvEyY7Jrdo/6wnldMSA2Ni9a3oOPt+DV5+5BPBK0zR04zvqkd+mAlRLo
         2b6h1nAxvsLAAE8xnkHSeyqz6tXwjPBOPUdBS0Wri5ARB6cV+GjY2gXo2KFAQkOW7Dkq
         iDOV8wMSVRvKmEBUs/L20o9AuFk+I3Rhng3RdHnn1blEMbOL6Y17S6KpraDuyQ+kLMXx
         0BlQ==
X-Gm-Message-State: AOJu0YxvI67HZEjnY9lTzSQC85Im3QoyD9HQsnCZ//iCNzorvESZSxEv
        +hQgllIVDN7m2PGd9z7C0SXwjUKtyX0p7RyfXdKYeIGZuCNr74A=
X-Google-Smtp-Source: AGHT+IFiuwFXJ1SAYYZzEK9grKXm+LlB4rNCML3NszsRc2iDlYP9o/HVoaM5pCZjhb4ZpGCkH+zUmHdBWthtMgJyzRk=
X-Received: by 2002:a25:c70b:0:b0:d9a:ce05:37b with SMTP id
 w11-20020a25c70b000000b00d9ace05037bmr3406872ybe.56.1697741868370; Thu, 19
 Oct 2023 11:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231018122006.24899-1-cuiyunhui@bytedance.com>
In-Reply-To: <20231018122006.24899-1-cuiyunhui@bytedance.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 19 Oct 2023 14:57:37 -0400
Message-ID: <CAHC9VhT0WtK_QnO14SGHL3ZQ+v1D57jX4OEfEqXcsWo=PtbcoA@mail.gmail.com>
Subject: Re: [PATCH] capabilities: add a option PR_SET_CAPS for sys_prctl
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     serge@hallyn.com, jmorris@namei.org, peterz@infradead.org,
        chris.hyser@oracle.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 18, 2023 at 8:20=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> By infecting the container process, the already running container is
> cloned, which means that each process of the container forks
> independently. But the process in the container lacks some permissions
> that cannot be completed.
>
> For a container that is already running, we cannot modify the
> configuration and restart it to complete the permission elevation.
> Since capset() can only complete the setting of a subset of the
> capabilities of the process, it cannot meet the requirements for
> raising permissions. So an option is added to prctl() to complete it.

I'm having a difficult time understanding the description above, would
it be possible for you to explain the problem differently?

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 82cb4210ba50..9a8dae2be801 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -246,6 +246,7 @@ struct prctl_mm_map {
>  # define PR_SCHED_CORE_SHARE_FROM      3 /* pull core_sched cookie to pi=
d */
>  # define PR_SCHED_CORE_MAX             4
>
> +#define PR_SET_CAPS                    63
>  /* Clone and personalize thread */
>  #define PR_PERSONALIZED_CLONE          1000
>  /* Isolation eventfd & epollfd during fork */
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 1444f3954d75..968edd8b3564 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -266,11 +270,17 @@ SYSCALL_DEFINE2(capset, cap_user_header_t, header, =
const cap_user_data_t, data)
>         if (!new)
>                 return -ENOMEM;
>
> -       ret =3D security_capset(new, current_cred(),
> -                             &effective, &inheritable, &permitted);
> -       if (ret < 0)
> -               goto error;
> -
> +       if (!prctl) {
> +               ret =3D security_capset(new, current_cred(),
> +                               &effective, &inheritable, &permitted);
> +               if (ret < 0)
> +                       goto error;
> +       } else {
> +               ret =3D __capset(new, current_cred(),
> +                                &effective, &inheritable, &permitted);
> +               if (ret < 0)
> +                       goto error;
> +       }

It isn't clear to me why we would want to avoid the security_capset()
hook in the prctl case; the change to the task's capabilities is the
same, yes?  If the goal of prctl(PR_SET_CAPS, ...) is to bypass the
security_capset() controls, you're going to need to do a much better
job of explaining why this is necessary.

>         audit_log_capset(new, current_cred());
>
>         return commit_creds(new);

--=20
paul-moore.com
