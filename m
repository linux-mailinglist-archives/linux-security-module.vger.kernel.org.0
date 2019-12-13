Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061DC11E4F7
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2019 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLMNzH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Dec 2019 08:55:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727335AbfLMNzG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Dec 2019 08:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576245304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+xWombR095irip2x0MT6TZ8bh3N1lUlFa/NcsHY808=;
        b=H/1j7z1zrI0DZVazy07cUm3Knu9FUDbVx3shkuC99aqI7P4EtIZ/KJmPVUSaO+tzDtW5Gd
        23MmwA7x4Utd5FzaMbuvaZYh5jj6Vcq4TT1ubN37LKHYNOgeh6VOeSZfEYkhl+vFoI+don
        xEqDNmOo2rlbu71q39HmquqgFKrOmfs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-44a6gZvXMm-TVGa52fC98g-1; Fri, 13 Dec 2019 08:55:03 -0500
Received: by mail-oi1-f197.google.com with SMTP id q204so1304978oic.12
        for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2019 05:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbtNdQTzXNH7djNrFSPyc6Qz7lDmmURxMItAvS2HkFA=;
        b=i2CGsIghRWTOHDlExXs/G63MdWd7X6vGp1A8/tcNZSpoLuC4MU81J26dyQFIuMjQSX
         BToI8+JgtPxl3KbOIf93ZntwRMIg3Vr9Arz63so1f++3IRATckWS5wyT7k4FRvPsHhi1
         mBR0El5McbnKPkGdiqw4W5VOyRiHBrYAgl7TzkZTeHuyVKMjc5r0BD3aIMQJeEzIciPm
         //liC9ZVhYcrz3kBlLGosyvnZizICs07nl9MOqxzLSBr7VidyJh8IxUMBqxwUgoid/xA
         biBoOMLWVpMl2FGjQx2bud0P4EL7sjujWoxMqK4ya+AvHgxlIGP9byYxPUz34KZpGny7
         uD3g==
X-Gm-Message-State: APjAAAXt5QmxmlMLf5sOgXCb5Ocdfs1iCk11rlXGSrtI+Ij6xyHepVPu
        5IMHUrfaMf4dw0YDTy6iZwvVM/4KOh9tMv2ogv4IKNTgnePuv5ESZyMmKerCgyCsLZdL0ABjIlQ
        ltpVJR2Iq/H82uePMstfyZK2y26tJvL3RiIpYgkupNjG6gjMmejKp
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr15593140otn.22.1576245302312;
        Fri, 13 Dec 2019 05:55:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyt64zlQTx3HdzyXefId4FhEFI/cjJZ2tqgs0MS2QjiTfLJvPOj7VVeECwFkFVbBbBRbhhXqs4RRcU+14kKE0o=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr15593116otn.22.1576245302040;
 Fri, 13 Dec 2019 05:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov> <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov> <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
In-Reply-To: <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 13 Dec 2019 14:54:50 +0100
Message-ID: <CAFqZXNsWPZ3mVUjDrgeoU0PadcuzHtQx48ncr4ez2NtK=qtK2Q@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-MC-Unique: 44a6gZvXMm-TVGa52fC98g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 12, 2019 at 7:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 12, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote=
:
> > On 12/12/19 1:09 PM, Paul Moore wrote:
> > > On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> =
wrote:
> > >> On 12/12/19 12:54 PM, Paul Moore wrote:
> > >>> ...
> > >>> Just so I'm understanding this thread correctly, the above change
> > >>> (adding enabled checks to each SELinux hook implementation) is only
> > >>> until Fedora can figure out a way to deprecate and remove the runti=
me
> > >>> disable?
> > >>
> > >> That's my understanding.  In the interim, Android kernels should alr=
eady
> > >> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> > >> choose to disable it as long as they don't care about supporting SEL=
inux
> > >> runtime disable.
> > >
> > > Okay, I just wanted to make sure I wasn't missing something.
> > > Honestly, I'd rather Fedora just go ahead and do whatever it is they
> > > need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds lik=
e
> > > they have a plan and are working on it), I'm not overly excited about
> > > temporarily cluttering up the code with additional "enabled" checks
> > > when the status quo works, even if it is less than ideal.
> >
> > The status quo is producing kernel crashes, courtesy of LSM stacking
> > changes...
>
> How prevalent are these crashes?

I don't think they are prevalent, we only received one report for RHEL
and it came in ~ 6 months after 8.0 was released, which was the first
release that had the stacking patch. I wasn't able to reproduce it
without adding delays between the hook removals. However, the report
may have some specific configuration where it happens more often due
to just the "right" timing of some events...

>
> This also only happens when disabling SELinux at runtime, yes?
> Something we've advised against for some time now and are working to
> eliminate?  Let's just get rid of the runtime disable *soon*, and if
> we need a stop-gap fix let's just go with the hook reordering since
> that seems to minimize the impact, if not resolve it.
>
> I'm not going to comment on the stacking changes.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

