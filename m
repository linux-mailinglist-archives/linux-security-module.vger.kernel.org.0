Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB311D4E8
	for <lists+linux-security-module@lfdr.de>; Thu, 12 Dec 2019 19:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfLLSJP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 12 Dec 2019 13:09:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36588 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfLLSJP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Dec 2019 13:09:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so3317371ljg.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2019 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zcr4gUWUusfrBPLoX/9dzbPOLRPvYN7L3eMRvyRnjYU=;
        b=VTT+HWVlQ71MsjrP5EiBmionYX159aJSsr/f40V0hAR07aewWHOrxigHM+jL8WNk9D
         BE8ZkkOWkhws7SAlkzRgwSu1Gbn/Y/qyzFQGK06ab5WyAOEbKO+u3eqtxc8khE8hU8AS
         eieaVmoFwreFa8FvOctz3QflasY4dp82z0sl6JEMhFgciBFna2xUJh1ZlO4SDtl3U3E0
         kTkUAtvJlfW+V97F7SXzibfUksCEO7tD3eMkj2gTRg1wVckmmRM0vSCmJ5qCJUgiqQLo
         ooP0pTY95bvs8P3/Zd5GUXq2HJ+zjZlr1jekcPC0fnn3pshK9eAHnpsp1Qsw+M/mpcG8
         yZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcr4gUWUusfrBPLoX/9dzbPOLRPvYN7L3eMRvyRnjYU=;
        b=WnpT97nbSKQfAsRISTIY+dFj6JcwGFSdQQwE3R7yx2xPSk4Ekg8Nth8lBubkD5vi29
         IS4tlLC3WqNRGDQo9cLvjV2ImZgdYcYRSeJEAYfzYVvcCENPDUhphxiOgU9A45lflAHe
         T7Ka5WjEFBBiWxl6Ya8RXwFRGTbchAIsIz+O8joZsBScqIRiKaC7PCEtowHSWwMHMqxc
         XXY73ClfkqYN0hqdDzABTocuVeNVbdtwxPgd98EVMR3i8mWMggd5mS9FKzlTOPBqoREe
         igK7VcHJjxo3pmG3fN5SfGvFyKJYhK8lGgyL4x2uZK6uUd5SDZ8DvxjK+imf5kRp2PNW
         24xg==
X-Gm-Message-State: APjAAAWssohPKLXctx3tHkIfkycJQTvUsEWjgFKIv5CpH8uO1kSm4qBa
        oerEe69Mfben3jTbMw9BwsUdqfJx8k0Jn7r5Z1OZ
X-Google-Smtp-Source: APXvYqwAEIHNp7W9/GzxgJL8OxV0cc6wtWzP33/lMvX8QZn1WqJYZJhBzxMKpu1GP8WOfEGbOzw+We4vhwp6Gb9539s=
X-Received: by 2002:a2e:b045:: with SMTP id d5mr6909841ljl.184.1576174152285;
 Thu, 12 Dec 2019 10:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
In-Reply-To: <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Dec 2019 13:09:00 -0500
Message-ID: <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/12/19 12:54 PM, Paul Moore wrote:
> > On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> >>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> >>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> >>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> >>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> >
> > ...
> >
> >>>> selinux_state.initialized reflects whether a policy has
> >>>> been loaded.  With a few exceptions in certain hook functions, it is
> >>>> only checked by the security server service functions
> >>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> >>>> there is a lot of SELinux processing that would still occur in that
> >>>> situation unless we added if (!selinux_state.initialized) return 0;
> >>>> checks to all the hook functions, which would create the same exposure
> >>>> and would further break the SELinux-enabled case (we need to perform
> >>>> some SELinux processing pre-policy-load to allocate blobs and track what
> >>>> tasks and objects require delayed security initialization when policy
> >>>> load finally occurs).
> >>>
> >>> I think what Casey was suggesting is to add another flag that would
> >>> switch from "no policy loaded, but we expect it to be loaded
> >>> eventually" to "no policy loaded and we don't expect/allow it to be
> >>> loaded any more", which is essentially equivalent to checking
> >>> selinux_enabled in each hook, which you had already brought up.
> >>
> >> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> >> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> >> might be the best option until it can be removed altogether; avoids
> >> impacting the LSM framework or any other security module, preserves the
> >> existing functionality, fairly low overhead on the SELinux-disabled case.
> >
> > Just so I'm understanding this thread correctly, the above change
> > (adding enabled checks to each SELinux hook implementation) is only
> > until Fedora can figure out a way to deprecate and remove the runtime
> > disable?
>
> That's my understanding.  In the interim, Android kernels should already
> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> choose to disable it as long as they don't care about supporting SELinux
> runtime disable.

Okay, I just wanted to make sure I wasn't missing something.
Honestly, I'd rather Fedora just go ahead and do whatever it is they
need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
they have a plan and are working on it), I'm not overly excited about
temporarily cluttering up the code with additional "enabled" checks
when the status quo works, even if it is less than ideal.

-- 
paul moore
www.paul-moore.com
