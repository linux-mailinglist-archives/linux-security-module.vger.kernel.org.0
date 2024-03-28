Return-Path: <linux-security-module+bounces-2334-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33488DA10
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 10:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F61F296BA
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5A125C9;
	Wed, 27 Mar 2024 09:17:20 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA411FBB
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531040; cv=none; b=NnmxZJrD1RBbpAENBrWgdcSCZqrKm+DfKP7oSDBJmr3Aq9GOes7SBUX7u4QwRTb41H0iEWmAJF1apNZmW8/PC7GR29YsMXh3VWHMuPH0U+UqJcDuPTBNd27bERurKCsnDNwCKXpE3qwHl0SKg6nLa2OXFxg4zC4fIWavflZuftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531040; c=relaxed/simple;
	bh=jUo9+dCsk59c7eopI9XHfHmDktNaIlDvWxp371jYpnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH3zpt/rhMXXW6m9fww/890YUDiCqr1DgZj5AH88rAwxfF1m9qpge+rtelwY9gIdiuQ6/tz2dcni/Vu2EA4VY2ANNs2PRLcMv1RazQukPR5ZqA2+MTtvV+JSYdiMye2lrNLDTnSEOY6PXEEsKGbbwwwq092/Ap61pFVWTSTia74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42R9GkC4032510;
	Wed, 27 Mar 2024 04:16:46 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42R9Gi63032509;
	Wed, 27 Mar 2024 04:16:44 -0500
Date: Wed, 27 Mar 2024 04:16:44 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
Message-ID: <20240327091644.GA32347@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com> <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 27 Mar 2024 04:16:46 -0500 (CDT)

On Tue, Mar 26, 2024 at 03:12:37PM -0400, Paul Moore wrote:

Good morning to everyone.

> On Tue, Mar 26, 2024 at 6:31???AM Dr. Greg <greg@enjellic.com> wrote:
> > On Mon, Mar 25, 2024 at 05:08:54PM -0400, Paul Moore wrote:
> > > On Sun, Mar 24, 2024 at 6:33???PM Greg Wettstein <greg@enjellic.com> wrote:
> > > >
> > > > The integration of the Integrity Measurement Architecture (IMA)
> > > > into the LSM infrastructure introduced a conditional check that
> > > > denies access to the security_inode_init_security() event handler
> > > > if the LSM extended attribute 'blob' size is 0.
> > > >
> > > > This changes the previous behavior of this event handler and
> > > > results in variable behavior of LSM's depending on the LSM boot
> > > > configuration.
> > > >
> > > > Modify the function so that it removes the need for a non-zero
> > > > extended attribute blob size and bypasses the memory allocation
> > > > and freeing that is not needed if the LSM infrastructure is not
> > > > using extended attributes.
> > > >
> > > > Use a break statement to exit the loop that is iterating over the
> > > > defined handlers for this event if a halting error condition is
> > > > generated by one of the invoked LSM handlers.  The checks for how
> > > > to handle cleanup are executed at the end of the loop regardless
> > > > of how the loop terminates.
> > > >
> > > > A two exit label strategy is implemented.  One of the exit
> > > > labels is a target for the no attribute case while the second is
> > > > the target for the case where memory allocated for processing of
> > > > extended attributes needs to be freed.
> > > >
> > > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > > ---
> > > >  security/security.c | 24 ++++++++++++------------
> > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> ...
> 
> > > Looking at this quickly, why does something like the following not work?
> > >
> > > [Warning: copy-n-paste patch, likely whitespace damaged]
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index 7e118858b545..007ce438e636 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1712,10 +1712,7 @@ int security_inode_init_security(struct inode *inode, str
> > > uct inode *dir,
> > >        if (unlikely(IS_PRIVATE(inode)))
> > >                return 0;
> > >
> > > -       if (!blob_sizes.lbs_xattr_count)
> > > -               return 0;
> > > -
> > > -       if (initxattrs) {
> > > +       if (initxattrs && blob_sizes.lbs_xattr_count) {
> > >                /* Allocate +1 as terminator. */
> > >                new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
> > >                                     sizeof(*new_xattrs), GFP_NOFS);
> >
> > We ran with something similar to the above for several days of TSEMv3
> > testing.
> >
> > For the patch that we submitted upstream, we elected to take a 'belt
> > and suspenders' approach that isolated the 'no attributes' execution
> > flow from the flow followed if extended attributes are present.
> >
> > The approach used doesn't make any difference to us as long as we get
> > the functionality of the hook restored.

> I'd prefer the simpler approach.  I'd likely also prefer we park
> this patch until it is needed upstream, or am I misunderstanding
> things and upstream is currently broken without a fix like this?

As of the 6.8 release, a security handler that previously functioned
in a consistent manner now functions inconsistently depending on the
LSM stacking configuration that is in effect.

Perhaps more problematically, when the handler does not function
correctly, there is no indication of that fact passed upward to the
LSM invoking the handler.  This would cause the LSM to conclude that a
security relevant action was conducted when it did not actually occur.

I believe we would all universally conclude that having security
critical infrastructure function in a consistent and reliable manner
is of benefit, so we should return the previous behavior of the
handler, particularly since it can be done with a one line fix if that
is your preference.

If you would be so kind, please put a 'Reported-by:' tag on whatever
you commit upstream.

> > If you go with the simpler approach, it may be worthwhile to at least
> > simplify the handling of the call to the initxattr() function after
> > the evm_inode_init_security() call.
> 
> Starting with v6.9-rc1 there is no longer an explicit call to
> evm_inode_init_security() as it is incorporated into the normal LSM
> hook processing, e.g. `hp->hook.inode_init_security(...)`.  I'm also
> not sure we need to worry about the initxattrs() call near the bottom
> of security_inode_init_security() since in the no
> @blob.lbs_xattr_count case the @xattr_count variable will also be zero
> so the initxattrs() call will be skipped.
> 
> Or were you talking about something else?

We were discussing something else but it isn't as important as getting
the security handler fixed, so lets just proceed with that and we can
call it a day.

> paul-moore.com

Have a good day.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
		  https://github.com/Quixote-Project

