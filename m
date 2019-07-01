Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135D01BC92
	for <lists+linux-security-module@lfdr.de>; Mon, 13 May 2019 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfEMSDr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 13 May 2019 14:03:47 -0400
Received: from namei.org ([65.99.196.166]:38884 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfEMSDq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 May 2019 14:03:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4DI3gcn003503;
        Mon, 13 May 2019 18:03:42 GMT
Date:   Tue, 14 May 2019 04:03:42 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
In-Reply-To: <CAHk-=wh33PsgxtwXdzDgx13tARBnhzkPV9294L2g6OjOBeNvfA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905140401320.14684@namei.org>
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com> <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com> <24d602d2-a1a7-7b1e-9035-a2d732cd822b@schaufler-ca.com>
 <CAHC9VhR-oqJwyvB2JhzTu2_nuZuENA=Y9f4rtfUrSGtLMnGZfw@mail.gmail.com> <CAHk-=wh33PsgxtwXdzDgx13tARBnhzkPV9294L2g6OjOBeNvfA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 12 May 2019, Linus Torvalds wrote:

> >     My guess is that you are right and
> > any *significant* changes to the LSM layer itself, e.g. security/*, is
> > best sent via James' tree.  For smaller changes to the LSM layer I
> > think it's okay if they go in via an individual LSM tree so long as
> > all the other LSMs agree-on/ack the changes; which pretty much fits
> > what we've been doing for some time now and it seems to work well
> > enough.
> 
> Yeah, I think that's the sane model. And I think it's mostly been working.

New LSMs also need to be guided in, as part of a community effort.

-- 
James Morris
<jmorris@namei.org>

