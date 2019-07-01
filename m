Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318AD2A2A6
	for <lists+linux-security-module@lfdr.de>; Sat, 25 May 2019 05:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEYDzK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 May 2019 23:55:10 -0400
Received: from namei.org ([65.99.196.166]:34392 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfEYDzK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 23:55:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4P3t1LB032269;
        Sat, 25 May 2019 03:55:01 GMT
Date:   Sat, 25 May 2019 13:55:01 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: Stacking patches for 5.3
In-Reply-To: <e42136b0-d656-1aa9-c848-d6a8aaa48c92@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1905251354220.32154@namei.org>
References: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com> <CAHC9VhRY8UOS9G_CgBPe=tVYgLmL7KHC_=RRtHyemHrx0_RqjA@mail.gmail.com> <e42136b0-d656-1aa9-c848-d6a8aaa48c92@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 24 May 2019, Casey Schaufler wrote:

> On 5/24/2019 12:37 PM, Paul Moore wrote:
> > On Fri, May 24, 2019 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> I have a set of 59 patches for the nest round of LSM stacking.
> >> They are all really small. Kees has expressed a preference for
> >> small patches. I think that the collapsed set of about 10 would
> >> make more sense. Which would the community as a whole prefer?
> >> The patches are not much different from what has been presented
> >> already.
> > Is there an option for "not posted on the Friday before a holiday weekend"? ;)
> 
> I'm waiting for James' next-general to base it on, so you needn't worry.

I won't be merging with Linus' tree unless there's a specific reason to, 
so go ahead with the current branch.

-- 
James Morris
<jmorris@namei.org>

