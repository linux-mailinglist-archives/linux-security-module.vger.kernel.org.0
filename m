Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D7AAD73
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Sep 2019 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfIEUzl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Sep 2019 16:55:41 -0400
Received: from namei.org ([65.99.196.166]:42760 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfIEUzl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Sep 2019 16:55:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x85KtRe6002717;
        Thu, 5 Sep 2019 20:55:27 GMT
Date:   Fri, 6 Sep 2019 06:55:27 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for
 the SELinux blob
In-Reply-To: <b5705661-089a-cb9c-53b5-21b855937638@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1909060644570.1710@namei.org>
References: <20190904143248.7003-1-sds@tycho.nsa.gov> <CAHC9VhTdv2C2MbNb7p-cPAW8ZeY+tmcz1c77qXmvowSxrWbw4g@mail.gmail.com> <b5705661-089a-cb9c-53b5-21b855937638@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 5 Sep 2019, Stephen Smalley wrote:

> For the next and any future rounds of stacking support, I'm hoping we can be a
> bit more rigorous in our code review and testing requirements.

After the 5th iteration of the patchset and with everything having at 
least one trusted reviewer, I did ask the list if there were any 
objections and stated I would otherwise merge to v4.21:

http://kernsec.org/pipermail/linux-security-module-archive/2018-December/010209.html

Regardless, from now I'll also require signoffs from all of the major LSMs 
on these kinds of changes.

I'd have to say I also have concerns about the direction of LSM stacking 
and what its final goal is.  It seems to makes sense to be able to stack 
Apparmor inside SELinux or Smack, so that folk can use AA system 
containers on an SELinux or Smack host.

We've not seen other proposed use-cases for full stacking materialize in a 
sustained and viable manner.

Are there really any beyond AA inside a labeling LSM?  Because if not I 
think this is a reasonable goal state for LSM stacking until we concretely 
know otherwise.


-- 
James Morris
<jmorris@namei.org>

