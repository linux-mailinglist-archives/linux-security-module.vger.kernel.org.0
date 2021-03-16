Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C833D53B
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Mar 2021 14:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhCPNxm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Mar 2021 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbhCPNxe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Mar 2021 09:53:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC9C061756
        for <linux-security-module@vger.kernel.org>; Tue, 16 Mar 2021 06:53:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so72289279ejb.5
        for <linux-security-module@vger.kernel.org>; Tue, 16 Mar 2021 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsGWHsTvYwMR82bTvfNdLbbIbfKOfHw4CYRAXVbE8Fw=;
        b=Gm5DDSaKkpIPhLLuie0RMdn+O4VA7RAjjsKEhMso61GFPo0Itmhg+IS0DALd88dbst
         /iO9jH0yiab7aUEmjNoWBuOONp0Vx0HnMtpeJWXMzhUVT09KQdJH6OBAuW+23AXvm/IY
         RxXJK0v+4TulkZ10oSSPrexAeW3Fu/OIpHzn7HykWYiL10f1RowuTwAAQxr4rJlEWCmF
         KXX/qyQU4n0EbQcRyL2wrIf3ImtQPga33WyQvxm9u8dMRSWgx0h376ceM+eyJkVLw6us
         2YKqp8iu0Rx9QTzmZtWkIoiwJG0ezB2eRhzyM+s21Ugq41Ns4p+U6GRqbArNXNgG8VAu
         UWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsGWHsTvYwMR82bTvfNdLbbIbfKOfHw4CYRAXVbE8Fw=;
        b=a31lj4JC5QVUQ/PbG5yCxoeH1+KZ9n/MxqW9Uw5zhMQko4erfSxhXq6hR1TNAouB0Q
         0LvliafFXIblV/iTuChy5/jjOdJHHqVHhJwY1YnZz9wf2bvq97Nue+UqcUE4+QKkz0Pr
         xVJg+Ae3bIi49HXI1iT3DwMuFIVCdDsvHqjPVvjlYqNt6YUq7QDaHCKuko/Voo6lFjYd
         GlA2iFtdplkkg2pr6KaquiLtiN9S/GcFn9D55j+TH+FvnQfurijk2gq3s2NlWtgpXP0Z
         BC7hqyZw71EvzO7iphi/Gt4s1YCkRZsAdORY1pbVlBMjXyepvuWibURj+/p2I36jij32
         UjDA==
X-Gm-Message-State: AOAM532UtQ7JWgurfyYqSn/Cbl1YyfEXcNq0ATt9N5ATA1AiTm0ViySF
        n7KBsdQzcfWvLbR07ihMh3cwiCsYc0ZfKGFcRsWr
X-Google-Smtp-Source: ABdhPJycpYUdq1CIWkYyGRMDcTGwm0DwqutnqizGHmg/ogGbNt8mki9NMZ9iFXdWVg1jGNwu2OKCRH2GwBwDVM/kYMM=
X-Received: by 2002:a17:906:edca:: with SMTP id sb10mr13156854ejb.398.1615902812834;
 Tue, 16 Mar 2021 06:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210224215628.192519-1-omosnace@redhat.com>
In-Reply-To: <20210224215628.192519-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Mar 2021 09:53:21 -0400
Message-ID: <CAHC9VhQHrmKHxYuTBOy-JHTXHjGTU9UX-AWk3jbiaNfSkZ+N1A@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix unconditional security_locked_down() call
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 24, 2021 at 4:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Currently, the lockdown state is queried unconditionally, even though
> its result is used only if the PERF_SAMPLE_REGS_INTR bit is set in
> attr.sample_type. While that doesn't matter in case of the Lockdown LSM,
> it causes trouble with the SELinux's lockdown hook implementation.
>
> SELinux implements the locked_down hook with a check whether the current
> task's type has the corresponding "lockdown" class permission
> ("integrity" or "confidentiality") allowed in the policy. This means
> that calling the hook when the access control decision would be ignored
> generates a bogus permission check and audit record.
>
> Fix this by checking sample_type first and only calling the hook when
> its result would be honored.
>
> Fixes: b0c8fdc7fdb7 ("lockdown: Lock down perf when in confidentiality mode")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/events/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Perf/core folks, do you want to pull this in via your tree?  If I
don't hear anything in the next day I'll pull this in via the
selinux/next tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 129dee540a8b..0f857307e9bd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11796,12 +11796,12 @@ SYSCALL_DEFINE5(perf_event_open,
>                         return err;
>         }
>
> -       err = security_locked_down(LOCKDOWN_PERF);
> -       if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
> -               /* REGS_INTR can leak data, lockdown must prevent this */
> -               return err;
> -
> -       err = 0;
> +       /* REGS_INTR can leak data, lockdown must prevent this */
> +       if (attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +               err = security_locked_down(LOCKDOWN_PERF);
> +               if (err)
> +                       return err;
> +       }
>
>         /*
>          * In cgroup mode, the pid argument is used to pass the fd
> --
> 2.29.2

-- 
paul moore
www.paul-moore.com
