Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71887300C5C
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Jan 2021 20:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbhAVTUN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 22 Jan 2021 14:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbhAVTDB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Jan 2021 14:03:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8581C061788
        for <linux-security-module@vger.kernel.org>; Fri, 22 Jan 2021 11:02:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c6so7794172ede.0
        for <linux-security-module@vger.kernel.org>; Fri, 22 Jan 2021 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qPqGO6M1vE9fTgLsRl9bBFWNchSGQjZBiwtyORRYmOw=;
        b=o58fKMZc0SW8ioL1vMvt2Z7+b0CWkZQOxJRGU8u50uBf8nPbYrVYUhNF2P3euFPH00
         D8qpuqGUMuC+T5W4OJVi6GCYHAhBpg8w2q20dQaZSbz4KMquOAnFY91xxezIUWF0foJE
         Mb5d4I1CUyFumjcUe8Du5EhpLaqvAPKuEHhv84V9tysxpLLsW5C+fKTboj8M6+rn+8ix
         s34HadJxWvdc3mgB+jol0DG9OFlYkgX3FJULGNMuxDsUSP7AXlXj8inDG2t97kSlzOtO
         delXHVrTW1I4DMakYYIprXzjv0cklUsl6p2xIwTM15gpltaLTA1qHNbVCE1w+Sx8xtBm
         mS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qPqGO6M1vE9fTgLsRl9bBFWNchSGQjZBiwtyORRYmOw=;
        b=Gyr9nmYjc7TGgDKTex/EwzPcb3WlkiNLEKxUPGdYFAfchjww8VtZJOPoqTw470D0mn
         lqctPwUOnWyw99foRhdRPOb/7HQTA3rzJkeW30gNzrkmoydSvUvtYxODH69VBj8rao7y
         QldOW4tin2S6uQkbfZ8ScC03C6zze3ullxbujoD7/ox2QsS2gTmEHXJQlqbjJjZ/HiNv
         UxeTfDUKrECdEO0Q+5TIMF11D+y0lOfH/2aiOqx5tuvx2tQxerPwGea5q4f1y19ZR3J1
         oExdRY0NQQmHs1jGRI4D6nZy2dj4S87kk1hqMc6SiMb6rbGUUiVgXOhl6fvAqDyjlY9o
         Oeww==
X-Gm-Message-State: AOAM532zgSFRRFbFgN65fsJCP9J9Zoaduln5DJvRW2EteEHoVMTNcf6+
        Gpk8roi4WCs3JD1qCupoY7fxI4xWhb/57EnoBF6J
X-Google-Smtp-Source: ABdhPJx1YTmDwNPYfPyKObR51spE6ojhAa+xAEqR1QPnxEJCdxSNRMw77YHFEBJ+gVjTLkqinG2WKLYlySwUWvIXmsg=
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr4361901edx.12.1611342133436;
 Fri, 22 Jan 2021 11:02:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CKqVX6L7HGqiRGqxxTgyhrLAGbCSMvcv4NrBR_3C-Q93w@mail.gmail.com>
 <CAHC9VhSCmhkcRgWtGQNhSr8SQueHWtw3qW9SEtNnEgC=AyzVZg@mail.gmail.com> <3b5a02e0-1361-6fe5-9a2e-2a9113e99d2b@schaufler-ca.com>
In-Reply-To: <3b5a02e0-1361-6fe5-9a2e-2a9113e99d2b@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 14:02:02 -0500
Message-ID: <CAHC9VhQk3ZJ8yKoy3nVEABPMCG7Q_F4SJBvTvFqUEBGSkjmjPA@mail.gmail.com>
Subject: Re: VSOCK & getpeercon()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        selinux@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 22, 2021 at 12:13 PM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
> On 1/22/2021 8:27 AM, Paul Moore wrote:
> > On Sat, Jan 16, 2021 at 7:48 AM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> >> Hi,
> >>
> >> getpeercon() isn't implemented for VSOCK. Note, I am not very familiar
> >> with SELinux, but I was porting some applications that uses AF_UNIX to
> >> AF_VSOCK and reached that point.
> >>
> >> I found some previous discussions about VSOCK & LSM from 2013, but the
> >> reasons it was abandoned don't seem so clear or valid to me:
> >> https://lore.kernel.org/selinux/1803195.0cVPJuGAEx@sifl/
> > Hi, my apologies for the slow reply.
> >
> > The SELinux/LSM VSOCK support wasn't abandoned due to any significant
> > roadblocks, it was simply a matter of time - I seemed to be the only
> > one who was interested in working on it, and I couldn't find enough
> > time to work on it ;)
> >
> > If you are interested in spending some time on adding proper
> > LSM/SELinux VSOCK support my gut feeling is that it would still be a
> > good thing.  However, I would suggest spending some time investigating
> > the current state of things, while you may get lucky, I believe it is
> > safer to assume that anything from 2013 is horribly out of date.
>
> That's a pretty safe statement. You really have four options at
> this point:
>
> - netfilter to set the secmark
> - CIPSO/CALIPSO if the protocol supports or can support options
> - examining the peer process as is done with AF_UNIX
> - eBPF *I think* but you never really know with something that new

I don't believe CIPSO, CALIPSO, labeled IPsec and other IP-based
labeling protocols aren't really options here since VSOCK doesn't rely
on IP.  I vaguely recall thinking it was much more analogous to
UNIX/LOCAL sockets, but it has been ~seven years since I thought about
this last.

The use of secmark could be interesting assuming there are useful
labeling points for VSOCK and netfilter (secmark'ing a packet doesn't
rely on IP so it should be okay from that perspective).

Of course eBPF support would be interesting, but that is like saying
SELinux, Smack, and AppArmor support would be interesting.  I think
the important part is making sure the important objects include the
necessary opaque security blobs (we are probably okay there already),
and making sure we have the LSM hooks in the right places in the code
(also, we *may* be okay there).  Once those things are done, it's a
matter of adding the necessary support to each LSM.

> There may be something else out there that hasn't gobsmacked me
> in the stacking work, so that I wouldn't know about it.
>
> BTW: Please include the (CCed) Linux Security Module list
> <linux-security-module@vger.kernel.org> in discussions like this.

--=20
paul moore
www.paul-moore.com
