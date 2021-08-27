Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAAB3FA01E
	for <lists+linux-security-module@lfdr.de>; Fri, 27 Aug 2021 21:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhH0Tu1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 27 Aug 2021 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhH0Tu1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Aug 2021 15:50:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EF2C0613D9
        for <linux-security-module@vger.kernel.org>; Fri, 27 Aug 2021 12:49:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h9so16189333ejs.4
        for <linux-security-module@vger.kernel.org>; Fri, 27 Aug 2021 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MarwsWWGC0vgeYe2TT0Bknreciph81Y5zQko1bbo3dg=;
        b=VDp9L1aSEtB6Ja57TrDn9eWLnenyIwAPGW7I3DZLgoSo3HZ0yIzE269UHR381x5vj1
         ysj2a3K4xBRAtql47MJkvyqD3biO5iHkTxq7LUxf8A7YxN2DAdkNqD3E0FwgSb+YvXNs
         ge+kQcRBgUBgUxfo9Q/xTcK9QPgqQYaRBeGPxqZ83AwOcZXP0AOoTClsQ1FEe1Yl1ctC
         VLfSCOhfKOcbp/nG0AlQCx7+XHBM0dihc955Q6L1ITt6cPmsqG6jKyITvbaDxCYaXjNm
         QqLm8lse9PxFEpOgXgN88LgyE3rCEyQCUhUCK6eKot8KK/v9AKpN5zjuwgExd7flJ/iJ
         nMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MarwsWWGC0vgeYe2TT0Bknreciph81Y5zQko1bbo3dg=;
        b=abEWYxuNHw187UesWAhlgTnSP+h8V5Y8ad5AJiJFayxJxtZJmqyzHS6MTxqb/83kjX
         5q1nlIj1Qc9iyRlEaktf4wJ2WHaC0TViVc2btehgszUSOnJpGiNNTCay0HYefBkNk+50
         fFNtzyx1CpmX1APAgJUrPZYtWzjf59mAys7NJeoNp2FdOt5EMexM3VKyZ+kQyZ7uAhWA
         BUt5En0yiYOAWsOmgloW6jBdK2aQcSwNgv/NVReBEIW4isQKuxbrQ0G/NwrA90NxhHww
         ns/jOT8P/FmKn8KweqPFZwj4M1ajpZQpnB//DEnTD+d6tDs8LImsjPqk5wfnlTJFnu2b
         CkZg==
X-Gm-Message-State: AOAM531sUfJC9umvb/ARUJt+AoNpwAcXfES10YkWMXabSukCnmHpNRYI
        BWugawZsw4651KWFKj0siHkk0fxyyfQ1slIVPCIh
X-Google-Smtp-Source: ABdhPJx8Cuhrg3SXaR2CWgIvHRns6qh4/y+RRqlTaCS2oPMgn9tWv4WqNnZLocutZJdvMikV0ssmc2A4ucAVfrKNtmY=
X-Received: by 2002:a17:907:2a85:: with SMTP id fl5mr510228ejc.91.1630093774900;
 Fri, 27 Aug 2021 12:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <162871480969.63873.9434591871437326374.stgit@olly>
 <20210824205724.GB490529@madcap2.tricolour.ca> <20210826011639.GE490529@madcap2.tricolour.ca>
 <CAHC9VhSADQsudmD52hP8GQWWR4+=sJ7mvNkh9xDXuahS+iERVA@mail.gmail.com>
 <20210826163230.GF490529@madcap2.tricolour.ca> <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
 <20210827133559.GG490529@madcap2.tricolour.ca>
In-Reply-To: <20210827133559.GG490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Aug 2021 15:49:24 -0400
Message-ID: <CAHC9VhRqSO6+MVX+LYBWHqwzd3QYgbSz3Gd8E756J0QNEmmHdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 27, 2021 at 9:36 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-08-26 15:14, Paul Moore wrote:
> > On Thu, Aug 26, 2021 at 12:32 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > I'm getting:
> > >         # ./iouring.2
> > >         Kernel thread io_uring-sq is not running.
> > >         Unable to setup io_uring: Permission denied
> > >
> > >         # ./iouring.3s
> > >         >>> server started, pid = 2082
> > >         >>> memfd created, fd = 3
> > >         io_uring_queue_init: Permission denied
> > >
> > > I have CONFIG_IO_URING=y set, what else is needed?
> >
> > I'm not sure how you tried to run those tests, but try running as root
> > and with SELinux in permissive mode.
>
> Ok, they ran, including iouring.4.  iouring.2 claimed twice: "Kernel
> thread io_uring-sq is not running." and I didn't get any URING records
> with ausearch.  I don't know if any of this is expected.

Now that I've written iouring.4, I would skip the others; while
helpful at the time, they are pretty crap.

I have no idea what kernel you are running, but I'm going to assume
you've applied the v2 patches (if not, you obviously need to do that
<g>).  Beyond that you may need to set a filter for the
io_uring_enter() syscall to force the issue; theoretically your audit
userspace patches should allow a uring op specifically to be filtered
but I haven't had a chance to try that yet so either the kernel or
userspace portion could be broken.

At this point if you are running into problems you'll probably need to
spend some time debugging them, as I think you're the only person who
has tested your audit userspace patches at this point (and the only
one who has access to your latest bits).

-- 
paul moore
www.paul-moore.com
