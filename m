Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998426AF8E
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jul 2019 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfGPTGc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Jul 2019 15:06:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37848 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfGPTGb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 15:06:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so14521620lfh.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LG1qgJpNmSz1iQ9LvaU/8VdF6DJ/KTavEjwp2ttw70g=;
        b=MwJ2nfHlclEgRkyb3cO8wydTVc4MkHxq5lpaq+vveKIfNftcJMYxbpp1YoaN5DdVVy
         Iv7VpTl9fhuMRXW8GqMFmHLv8j+EEvX22qy3iQXAwEJFEsq6eRXCiH6+xf5mxjLOd/sA
         uSM3b50XkOSu5HmVh63QGVthYBPE2OL0vrEog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LG1qgJpNmSz1iQ9LvaU/8VdF6DJ/KTavEjwp2ttw70g=;
        b=CU8OHtSZBlr3nfxjN2cXa0frMynKRMH+QD1DCQfQ9bU/2Fj6TLlZIZRQogev8Xrw1X
         XkNyaFb8oTD0llAEaeS82xfzUqNbQfoztT7Fa0GBMaQCDNDvCKSE9OPZzMWUaV1WKUiw
         F3bceLMMK+YgfDLb3tuOj/tlpOcfjIcndAGxDX0Y34GrH+vBjuMpmlrWtvm38lMxQnnl
         uBbOOSz2DTmZcTMI/XAU5w6OiR/pbMZRlCU3AJuAhVKj4g4IMdIPFwPCMHb82wbZ3eYj
         GfrJWMfHVIQku5r210ZV59/o9zqz9ksuyLIaZzHrsSm6dHOFpV2veVFJDRyAtmhhjzZ7
         2J6g==
X-Gm-Message-State: APjAAAU2pqBAYbd5RMm6dXb/N9bjODbUKQkaCuvgnC6DkVQpFxJaXiAa
        0KDadNtOVJOz0XWBDL+/znUThtbBa7s=
X-Google-Smtp-Source: APXvYqxkV9JuxoGDHskt41QPsllig39kOky1ON98gHNgnH5h5qCtYOfxVuNxbyRdGZ3e3aCTH+LRRg==
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr15406350lfp.116.1563303989578;
        Tue, 16 Jul 2019 12:06:29 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x18sm2990043lfe.42.2019.07.16.12.06.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 12:06:28 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h28so14519449lfj.5
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 12:06:28 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr15576134lfm.170.1563303988234;
 Tue, 16 Jul 2019 12:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
In-Reply-To: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Jul 2019 12:06:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY1J-LFvTa8ihiPNRSv1dwxPk9ycPCEhdcjsk7c=tGAw@mail.gmail.com>
Message-ID: <CAHk-=whY1J-LFvTa8ihiPNRSv1dwxPk9ycPCEhdcjsk7c=tGAw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.3
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 15, 2019 at 9:05 AM Micah Morton <mortonm@chromium.org> wrote:
>
> I'm maintaining the new SafeSetID LSM and was told to set up my own
> tree for sending pull requests rather than sending my changes through
> James Morris and the security subsystem tree.

Yes. It would be good if you also added yourself to the MAINTAINERS
file. Right now there's no entry for security/safesetid at all.

> This is my first time doing one of these pull requests so hopefully I
> didn't screw something up.

So a couple of notes:

 - *please* don't rebase your work in the day before

   Was this in linux-next? was this tested at all? Hard to tell, since
it was rebased recently, so for all I know it's all completely new

 - don't use a random kernel-of-the-day as the base for development

   This is related to the rebasing issue, but is true even if you
don't rebase. There is no way that it was a good idea to pick my
random - possibly completely broken - kernel from Sunday afternoon in
the middle of a merge window as a base for development.

   If you start development, or if you have to rebase (for some *good*
reason) you need to do so on a good stable base, not on the quick-sand
that is "random kernel of the day during the busiest merge activity".

 - Please use the "git pull-request" format and then add any extra
notes you feel are necessary

   Yes, your pull request is *almost* git pull-request, but you seem
to have actively removed whitespace making it almost illegible. It's
really hard to pick out the line that has the actual git repository
address, because it's basically hidden inside one big blob of text.

I've pulled this as-is since it's the first time, but I expect better next time.

There are various resources on some cleanliness issues, and people
fairly recently tried to combine it under

   Documentation/maintainer/rebasing-and-merging.rst

which covers at least the basics on why not to rebase etc.

And if you *do* end up rebasing, consider the end result "untested",
so then it should have been done before the merge window even started,
and the rebased branch should have been in linux-next. And not sent to
me the very next day.

                   Linus
