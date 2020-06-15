Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2A1F9EF8
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jun 2020 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgFOSDn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jun 2020 14:03:43 -0400
Received: from namei.org ([65.99.196.166]:38236 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFOSDn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 14:03:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 05FI3XCm010205;
        Mon, 15 Jun 2020 18:03:33 GMT
Date:   Tue, 16 Jun 2020 04:03:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
In-Reply-To: <CAJ-EccO+4s8Dd=wj75ckfp4ZLhppt7uCgg2chf4SvTOxzqbgPw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006160403190.9951@namei.org>
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com> <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com> <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com> <alpine.LRH.2.21.2006151517230.9003@namei.org>
 <CAJ-EccO+4s8Dd=wj75ckfp4ZLhppt7uCgg2chf4SvTOxzqbgPw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 15 Jun 2020, Micah Morton wrote:

> On Sun, Jun 14, 2020 at 10:21 PM James Morris <jmorris@namei.org> wrote:
> >
> > On Sun, 14 Jun 2020, Micah Morton wrote:
> >
> > > This patch was sent to the security mailing list and there were no objections.
> >
> > Standard practice for new or modified LSM hooks is that they are reviewed
> > and acked by maintainers of major LSMs (SELinux, AppArmor, and Smack, at
> > least).
> >
> > "No objections" should be considered "not reviewed".
> >
> > Can you add your tree to linux-next?
> > https://www.kernel.org/doc/man-pages/linux-next.html
> 
> Sure, I can do that. I should just send an email to Stephen Rothwell
> asking him to include the -next branch from my tree?

Yep, thanks.

> 
> >
> > --
> > James Morris
> > <jmorris@namei.org>
> >
> 

-- 
James Morris
<jmorris@namei.org>

