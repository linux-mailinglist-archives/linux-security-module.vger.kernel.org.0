Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA642ABA7
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Oct 2021 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhJLSOT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 12 Oct 2021 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhJLSOT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 14:14:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6BFC061746
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 11:12:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so2796370edt.7
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28fl1nTBgmIQBFZ9f2d7lRM9Q7pbKbE882y/uhziIGg=;
        b=2WY15VLyjFjF3rY3UPMRXoOYaTDQ4nt+Skk3R1cqeUz52l091yzGDuC/VysGOQtFle
         uObxgKbVFnPzp0r9814n/p3juPHRYKTG4FaZq+AD8fhqthC9MpnK1VUUDQ1e8Yynk5QG
         HEMEEfSi9skWVprEXW/VFl4mwp0Ovnto7TUe/usZSZH4qDuNHbRGiOKIBAjO2MX9omM6
         dQas0yagpMN7z9z6NbvE9/UJqfIJ4NF4Fwml0/FZOSitv4HLcnW4iNsdng9aaQHUyj6S
         sktqK5AKLG45Qwx3kLBEcN/+2EpMpwIKiqP9NbcoQkgGbZHw+gJ0BKyiJEUJKfmNC47m
         VE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28fl1nTBgmIQBFZ9f2d7lRM9Q7pbKbE882y/uhziIGg=;
        b=ThXBrB5kO5Mluq5pL1mN0DUnmbbMyBFFaFqRX5ZdIJEP4fw+myw34rjFTfcnjS4J+j
         79VMhVL1Sk6P9iHSmgJGZvJ52WL3PGR5E0BVAIvG4YpbYvcHONuQo8Jff6DFXFjECohp
         uRBLZQu9e2aDGKqEBH5+Y9+qQlw0EGE8Q9LvWLEx2/vDGEutdPKfpwcPNJ+5OjGphuIU
         oNpTtFDj7HmJSs6mFCfFABYK+iNf9FsnezIIfPVf7LqH1CVkqeiBCdFkj47izzYguCPE
         ExuIhv9rZJFaFZvxqGIGYH3B0ln5r16j1MsajKKj6zWiOqqyHsg2z1o84HLVjPLRjF6o
         cmqA==
X-Gm-Message-State: AOAM533rSUEJXeHt6luxqQBlqHim21l0h/em3cPgZIXv5VmzjKj3X6s2
        NisrBJzGd8DHnUty0MHpyxiENgKvbDOlHNSNjrWVhu3nhg==
X-Google-Smtp-Source: ABdhPJy+pOh0Np8HVEkYOsZpNYYFFOiLhuFaSuutRuadLVS9grROMqGni6Wx2+PNpFwdUJHuA3zSMSfPxFUiOHjFwI4=
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr1721511edd.101.1634062330710;
 Tue, 12 Oct 2021 11:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211011133704.1704369-1-brauner@kernel.org> <06b6f249-06e6-f472-c74c-bb3ff6f4b4ee@digikod.net>
 <20211012103830.s7kzijrn25ucjasr@wittgenstein>
In-Reply-To: <20211012103830.s7kzijrn25ucjasr@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 14:11:59 -0400
Message-ID: <CAHC9VhSd32Q_tCctwYB0y4EXGCV8_9QajkNkkc96EwjdFsVkJw@mail.gmail.com>
Subject: Re: [PATCH] security/landlock: use square brackets around "landlock-ruleset"
To:     Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 12, 2021 at 6:38 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Oct 11, 2021 at 04:38:55PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On 11/10/2021 15:37, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > >
> > > Make the name of the anon inode fd "[landlock-ruleset]" instead of
> > > "landlock-ruleset". This is minor but most anon inode fds already
> > > carry square brackets around their name:
> > >
> > >     [eventfd]
> > >     [eventpoll]
> > >     [fanotify]
> > >     [fscontext]
> > >     [io_uring]
> > >     [pidfd]
> > >     [signalfd]
> > >     [timerfd]
> > >     [userfaultfd]
> > >
> > > For the sake of consistency lets do the same for the landlock-ruleset=
 anon
> > > inode fd that comes with landlock. We did the same in
> > > 1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontext" [=
ver #2]")
> > > for the new mount api.
> >
> > Before creating "landlock-ruleset" FD, I looked at other anonymous FD
> > and saw this kind of inconsistency. I don't get why we need to add extr=
a
> > characters to names, those brackets seem useless. If it should be part
>
> Past inconsistency shouldn't justify future inconsistency. If you have a
> strong opinion about this for landlock I'm not going to push for it.
> Exchanging more than 2-3 email about something like this seems too much.

[NOTE: adding the SELinux list as well as Chris (SELinux refrence
policy maintainer) and Petr (Fedora/RHEL SELinux)]

Chris and Petr, do either of you currently have any policy that
references the "landlock-ruleset" anonymous inode?  In other words,
would adding the brackets around the name cause you any problems?

--
paul moore
www.paul-moore.com
