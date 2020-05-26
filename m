Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53ED1D2530
	for <lists+linux-security-module@lfdr.de>; Thu, 14 May 2020 04:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgENCoA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 May 2020 22:44:00 -0400
Received: from namei.org ([65.99.196.166]:58798 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgENCoA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 22:44:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04E2hjXO030913;
        Thu, 14 May 2020 02:43:45 GMT
Date:   Thu, 14 May 2020 12:43:45 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jeremy Cline <jcline@redhat.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Frank Ch . Eigler" <fche@redhat.com>
Subject: Re: [PATCH] lockdown: Allow unprivileged users to see lockdown
 status
In-Reply-To: <20200511134230.GA2311339@dev.jcline.org>
Message-ID: <alpine.LRH.2.21.2005141242200.30052@namei.org>
References: <20200220151738.1492852-1-jcline@redhat.com> <alpine.LRH.2.21.2002220351010.18183@namei.org> <20200511134230.GA2311339@dev.jcline.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 11 May 2020, Jeremy Cline wrote:

> On Sat, Feb 22, 2020 at 03:51:24AM +1100, James Morris wrote:
> > On Thu, 20 Feb 2020, Jeremy Cline wrote:
> > 
> > > A number of userspace tools, such as systemtap, need a way to see the
> > > current lockdown state so they can gracefully deal with the kernel being
> > > locked down. The state is already exposed in
> > > /sys/kernel/security/lockdown, but is only readable by root. Adjust the
> > > permissions so unprivileged users can read the state.
> > > 
> > > Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> > > Cc: Frank Ch. Eigler <fche@redhat.com>
> > > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > 
> > Looks fine to me, any objection from Matthew or others?
> > 
> 
> Can we take resounding silence as no objections?

Please resend and I'll apply it to my tree.

> 
> - Jeremy
> 
> > > ---
> > >  security/lockdown/lockdown.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> > > index 5a952617a0eb..87cbdc64d272 100644
> > > --- a/security/lockdown/lockdown.c
> > > +++ b/security/lockdown/lockdown.c
> > > @@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
> > >  {
> > >  	struct dentry *dentry;
> > >  
> > > -	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
> > > +	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
> > >  					&lockdown_ops);
> > >  	return PTR_ERR_OR_ZERO(dentry);
> > >  }
> > > 
> > 
> > -- 
> > James Morris
> > <jmorris@namei.org>
> > 
> 

-- 
James Morris
<jmorris@namei.org>

