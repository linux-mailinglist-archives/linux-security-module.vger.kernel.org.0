Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC1D42E348
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Oct 2021 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhJNVgG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Oct 2021 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJNVgG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Oct 2021 17:36:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED0C061570
        for <linux-security-module@vger.kernel.org>; Thu, 14 Oct 2021 14:34:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y12so30815440eda.4
        for <linux-security-module@vger.kernel.org>; Thu, 14 Oct 2021 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoPu0jnNDwspHFj/KwTjXTK5IovBXrFnYnRM3qY9AfI=;
        b=a6KNglUwuPfv6oIfTS0ZYiZ4KlAFHaiXh7LKObdDfk5CWQzJWVBf4zQfr+h2DcJC+q
         /6GC8MY8aeLSG9gRqlIj5iz++B4UI0/XaeMbc1vyyC9cmgmj1Ga6sYbPgi13jZB/PdGw
         EjaDJ6X3eS1fm/ZL1GEQ8kxsLVPysO+XqTkMqqpFK6X+OPSHu9t9dspGa0ODwtJrnwYa
         2JCH5e8jK6dlNwBA2rh7BCfstK7WIld8g4LPRuxYNWh6XAQpRoLFqbqi+PtyK5d/X2pq
         MYKYgIXToadW9qIHhG8Z1QRBqXaqWeEHOjtwPhK/AqNf065c7fPuruiSGzVXxkmlA/rG
         NEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoPu0jnNDwspHFj/KwTjXTK5IovBXrFnYnRM3qY9AfI=;
        b=rFnPo9ZdLomXogXQBNGZVBqTO7IvHpsR8A6QGR9am1zgDylBpYClLBjlO3h11824x2
         BKB73kQesABWcFoH/apVXm26Orcm320cxITic7TI5cSbSeLIf5KE0jDhxtBf8e5MNDdk
         6nLfS1widbZ0Q6CRfPWSbJiKpbQP46KojtEsoG1gjXzsNeFA/4mWAclZJz232yL2uxxk
         U3YGUtuB3ULt8zkHlg9qxqyIMrSBf+y1sqFkPGKfv32rCgDl9uh+/mghp5/Lln9LnVmu
         qhIhW9Fy2JhBHeefBi2lk2h2NENchIFPUzNELYKaNc08aPGOGTWH+8qdUk63anbdqR8I
         dUsg==
X-Gm-Message-State: AOAM5323+u55B3y7Lr2dGKayoioYvNKPK7Yr41T567ycVB78opSxB1nS
        RicbrX9GwPJZUwARKbwproqMj39kZqKuycnE4gHl
X-Google-Smtp-Source: ABdhPJwdxSsmYhKsafUPIKuDs91ExUIKE/+rIIpYnPbV6xJvCFR8GllgoKtB9zmq6jGKXojYL90idam79iMgX4lDJwQ=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr12249192edb.370.1634247239018;
 Thu, 14 Oct 2021 14:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com>
In-Reply-To: <20211012165614.2873369-1-tkjos@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Oct 2021 17:33:48 -0400
Message-ID: <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] binder: use cred instead of task for security context
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 12, 2021 at 12:56 PM Todd Kjos <tkjos@google.com> wrote:
>
> This series fixes the possible use of an incorrect security context
> when checking selinux permissions, getting a security ID, or lookup
> up the euid.
>
> The previous behavior was to save the group_leader 'struct task_struct'
> in binder_open() and using that to obtain security IDs or euids.
>
> This has been shown to be unreliable, so this series instead saves the
> 'struct cred' of the task that called binder_open(). This cred is used
> for these lookups instead of the task.

Hi Todd,

I just merged all three patches into selinux/next, thanks for your
help patience on this patchset.  Ultimately I merged these patches
into selinux/next as opposed to selinux/stable-5.15 because I felt
that a couple of weeks in -next before going to Linus would be a good
thing.  I'm also not certain how widespread binder is outside of
Android so I figured the practical difference between next and
stable-5.15 is likely very small.  Regardless, all of your Fixes and
stable tags remain in the patches so as soon as they go up to Linus
during the next merge window the stable folks will be notified.

-- 
paul moore
www.paul-moore.com
