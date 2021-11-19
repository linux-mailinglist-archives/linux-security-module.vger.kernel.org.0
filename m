Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9645793E
	for <lists+linux-security-module@lfdr.de>; Sat, 20 Nov 2021 00:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhKSXDq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 19 Nov 2021 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhKSXDp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Nov 2021 18:03:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F9C061574
        for <linux-security-module@vger.kernel.org>; Fri, 19 Nov 2021 15:00:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so48765333edu.4
        for <linux-security-module@vger.kernel.org>; Fri, 19 Nov 2021 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=It4uFIPm/TcoK+jPH5YkeMMq3zsyxm4gO2u58vGukR0=;
        b=3pJoQe2hjfrg/7hSbzLxsod9OrFWCoaug9P7fvkrEFg0rv9ffCcPK1UzNYydItGFTZ
         8Gsmt/c334dnG4toozreaXjNphhZPsZYp2nlHPw3e/IL09S/41opYVanB2nzNO6/romw
         i1rKm54xMk9+J65ZcFGOcZQ1SLjAb01WfAXpC5IjfPdVnhpO70u2p2JsMNKHDcQdADrz
         aY47nKih2yF8knoiTAME51sXes1K6AV8Z51vQZXQFjkOEDpmKlNrruLgqJUvnP5ZmTFO
         EX6tdfLRUPCJosqeGFNBGk62gvwF20K+oZOxePAEXnDwZsit9k4eDkfGa6isnfm5eM4B
         QSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It4uFIPm/TcoK+jPH5YkeMMq3zsyxm4gO2u58vGukR0=;
        b=1N5TYzotvnfvDd/qLeTkLyjWQokZZN7LRxJ2wS3ea1yQ9ikpdUT2KTHbfbzuixVt3y
         GQyy91J4W/dd69nCj74Ha92Iyjl5/1uGsPW8OYANw21JPiGDyy/o1JJ4wOE+T4ken6eX
         Ur1eQ3bPIbWqoi4JeYAfR1ekIndFC1REy/2P3WA/DlCDyuSv7reD8xU0vMkpxVqlsx6J
         IYyjA+6ASBAZYAi78K2GRmMSGMFdAgA/yYDQHzqM2yLYnjdZAj97OuvfhmW/hQeEjqWw
         YYvtfYnYUx3A516EuQi5pxuUlSc1Ou9WcPuL0HWV5AY5xGgeYFVlO2pRzsY7kfuCMKqN
         Bg0g==
X-Gm-Message-State: AOAM530ExoaJkqiXt12io5ru7skmda2YoVvWLuhuaGaB5nF4hpP8iYKm
        1KgmGv7MIGdrrm/umJzi8aTrJePhTnGhRdIjK4HDFegeCA==
X-Google-Smtp-Source: ABdhPJwj8srWh1Z1Q4zO93E9LesvzJGVPu0HuTT8W9Stihxm6dQnTTI+EpjPhsnLo9c1VlkWaxAuFRFcd+EwUhAciqo=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr12593174ejc.24.1637362841746;
 Fri, 19 Nov 2021 15:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20211112180720.2858135-1-tkjos@google.com>
In-Reply-To: <20211112180720.2858135-1-tkjos@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Nov 2021 18:00:31 -0500
Message-ID: <CAHC9VhQaHzrjdnr_DvZdPfWGiehC17yJVAJdVJMn8tOC1_Y+gA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix test regression due to sender_euid change
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 12, 2021 at 1:07 PM Todd Kjos <tkjos@google.com> wrote:
>
> This is a partial revert of commit
> 29bc22ac5e5b ("binder: use euid from cred instead of using task").
> Setting sender_euid using proc->cred caused some Android system test
> regressions that need further investigation. It is a partial
> reversion because subsequent patches rely on proc->cred.
>
> Cc: stable@vger.kernel.org # 4.4+
> Fixes: 29bc22ac5e5b ("binder: use euid from cred instead of using task")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Change-Id: I9b1769a3510fed250bb21859ef8beebabe034c66
> ---
> - the issue was introduced in 5.16-rc1, so please apply to 5.16
> - this should apply cleanly to all stable branches back to 4.4
>   that contain "binder: use euid from cred instead of using task"
>
>
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks okay to me.  I assume this is going in via GregKH's tree?

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 49fb74196d02..cffbe57a8e08 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2710,7 +2710,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 t->from = thread;
>         else
>                 t->from = NULL;
> -       t->sender_euid = proc->cred->euid;
> +       t->sender_euid = task_euid(proc->tsk);
>         t->to_proc = target_proc;
>         t->to_thread = target_thread;
>         t->code = tr->code;
> --
> 2.34.0.rc1.387.gb447b232ab-goog

-- 
paul moore
www.paul-moore.com
