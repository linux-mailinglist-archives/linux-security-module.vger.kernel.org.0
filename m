Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DA1ACCE
	for <lists+linux-security-module@lfdr.de>; Sun, 12 May 2019 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfELPde (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 12 May 2019 11:33:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32908 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPde (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 May 2019 11:33:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id x132so7268116lfd.0
        for <linux-security-module@vger.kernel.org>; Sun, 12 May 2019 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r+ZomokzdXWblU1eNUZVwuwrP8R96EBwqrRjwYeKr4=;
        b=c3yr7vG4M7K5xO6VFHElKBbxnn1f8y+/R859KR3R4Q+eCCRf6i7FQqjUJtXERqfS8L
         pZeqSaQQEtfvETWFk7y3oV10tk7gRfI+ntCJWymwSEeYX31EkK3waAQgqhz7Qmr3hIfZ
         Gf4R79gUSgSa8xWSkRlzEi6uQZsEHqFkGy4hl6o/btTquMqgVKrwAxiC5OMkOMpXat+i
         xtRqbuHzfK9Ltsi9Sl5U1VhnmyAwspJ7DStrK5ccV2gMudTyhVMSSKebpheGWu/I6Uyp
         IhnuMDvXTgsx+oukCOK7Q0d3j2+wWtbhjbqKJPnkobfHFxk16vI3IK5sQTaPGXBd5Hkt
         s9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r+ZomokzdXWblU1eNUZVwuwrP8R96EBwqrRjwYeKr4=;
        b=JDNjr8bS7r2zQt31E1yrmaonUx/bh3FpWMKfNgvunAwyhQuY7pdHejMwLEraBXzGPV
         rXemMJdqShPXtDAOENfBYZoN2TwL49deqKQSH7LkVj59pQB+IVw1RYVXsLkpLa1U3qZj
         YUvLg9LJgh0mnbcVKHHOVCkjQKi2aJk88eIcrRviRfq+oGcFiJxb5ywBm1tKfTDeUBFf
         gtV4JUn4XqZiI852mDEHy/ECzq6SwVo7YnNr6m0blx+WallXoL+AZRASzmndLnB117Nt
         42j9m9W4a884AtDTeeNnDhOD5mB07ZeSry6Z4omy05Rw6X3e8oaT1pUOPhbOc77w1M8X
         8KfQ==
X-Gm-Message-State: APjAAAVZB0kKBs9N7wOPyI2OMutbGBMCuh2xe0vYy3JuHMyuQHcA6NK2
        /5IEAYJbmd7ksazUL7WwDmkg91Wk9nZn9JBu86F9
X-Google-Smtp-Source: APXvYqwssmfk79g0gXuyu6vL/pB+unVYXZl+YtSB3qWpfoKMUt9P1fd71z0mIORksqna2eKacd+sGg7pqj14k4Ji6Uw=
X-Received: by 2002:a19:c394:: with SMTP id t142mr6613263lff.102.1557675211836;
 Sun, 12 May 2019 08:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
 <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com> <24d602d2-a1a7-7b1e-9035-a2d732cd822b@schaufler-ca.com>
In-Reply-To: <24d602d2-a1a7-7b1e-9035-a2d732cd822b@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 May 2019 11:33:20 -0400
Message-ID: <CAHC9VhR-oqJwyvB2JhzTu2_nuZuENA=Y9f4rtfUrSGtLMnGZfw@mail.gmail.com>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 11, 2019 at 6:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/11/2019 11:13 AM, Paul Moore wrote:
> > On Sat, May 11, 2019 at 10:38 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
> >>> These patches include fixes to enable fuzz testing, and a fix for
> >>> calculating whether a filesystem is user-modifiable.
> >> So now these have been very recently rebased (on top of a random
> >> merge-window "tree of the day" version) instead of having multiple
> >> merges.
> >>
> >> That makes the history cleaner, but has its own issues.
> >>
> >> We really need to find a different model for the security layer patches.
> >
> > If it helps, the process I use for the SELinux and audit trees is
> > documented below.  While it's far from perfect (I still don't like
> > basing the -next trees on -rcX releases) it has seemed to work
> > reasonably well for some time now.
> >
> > * https://github.com/SELinuxProject/selinux-kernel/blob/master/README.md
>
> On the whole this looks fine to me. I am less comfortable than Paul
> is regarding changes that happen elsewhere, so I would be more likely
> to base in the rc-1 than Paul. More developers test with SELinux than
> Smack. I am in the process of putting an appropriate GPG environment
> together for 5.3.

I share your concern about external changes outside the subsystem
breaking things; this doesn't happen all that often with the audit
tree, but it seems to happen every couple of releases with the SELinux
tree.  This is one of the reasons why I test linux/master +
selinux/next + audit/next every few days, if not more often (see link
below).  I've found this regular testing to be extremely helpful, and
if anyone is interested I'd be happy to help you get something similar
going.

* http://www.paul-moore.com/blog/d/2019/04/kernel_secnext_repo.html

FWIW, the reason I don't like basing against -rc1 (or any -rcX tag for
that matter) is that the -rcX releases tend to be buggier than the
"proper" releases.  However, in practice I find myself basing the
selinux/next and audit/next branches against -rc1 almost every release
now; the rate of change outside the subsystem trees is simply too
high.

> The LSM infrastructure work I've been doing should still go through
> James, as it has global implications.

As far as I'm concerned, whatever makes it easier for Linus to consume
the changes is the preferred path.  My guess is that you are right and
any *significant* changes to the LSM layer itself, e.g. security/*, is
best sent via James' tree.  For smaller changes to the LSM layer I
think it's okay if they go in via an individual LSM tree so long as
all the other LSMs agree-on/ack the changes; which pretty much fits
what we've been doing for some time now and it seems to work well
enough.

-- 
paul moore
www.paul-moore.com
