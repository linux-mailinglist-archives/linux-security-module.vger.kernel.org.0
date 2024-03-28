Return-Path: <linux-security-module+bounces-2376-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7047890338
	for <lists+linux-security-module@lfdr.de>; Thu, 28 Mar 2024 16:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046911C27E1D
	for <lists+linux-security-module@lfdr.de>; Thu, 28 Mar 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B62281728;
	Thu, 28 Mar 2024 15:38:40 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307A39FCF
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640319; cv=none; b=B04+CuGMUkMmo4mhS4XLm/IcHGyVWokXwkcJ9oogivKVCo0VgqwdTmghFI/RGAJ9vOM+ZB5jZsLU9/3SP9w5ZhEXPyPXEgJsWQl27xHzArVByN1SjZU518OasSsFp4dwFhMbpmLD5eG8TFE6Ke1BFE+Qav/FAd6WS+2lrtwZVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640319; c=relaxed/simple;
	bh=AzP3Ff0ooJ3ARVvtc1usnb3lDhGvOL1E1DxS8juOjp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB1ITEa9rjK0JE62sx3TDPMD1HVv+OmYL2pnLMWrhW7reElIqzqIp+QO6J7d/VT6ZVwocxURE00desqjnJELHlNDu4cQsJVPMNLvNzWRfAD1gJnyXdyuFvcHRfxp/rcFcfbnShDdOTLRkmaIdOIlruGv81mcQZEtrcBGDZieRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42SFc1b5017575;
	Thu, 28 Mar 2024 10:38:01 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42SFc07q017574;
	Thu, 28 Mar 2024 10:38:00 -0500
Date: Thu, 28 Mar 2024 10:38:00 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
Message-ID: <20240328153800.GA17524@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com> <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com> <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 28 Mar 2024 10:38:01 -0500 (CDT)

On Wed, Mar 27, 2024 at 11:18:47AM -0400, Paul Moore wrote:

Good morning to everyone.

> On Wed, Mar 27, 2024 at 5:17???AM Dr. Greg <greg@enjellic.com> wrote:
> > On Tue, Mar 26, 2024 at 03:12:37PM -0400, Paul Moore wrote:
> > > On Tue, Mar 26, 2024 at 6:31???AM Dr. Greg <greg@enjellic.com> wrote:
> > > > On Mon, Mar 25, 2024 at 05:08:54PM -0400, Paul Moore wrote:
> > > > > On Sun, Mar 24, 2024 at 6:33???PM Greg Wettstein <greg@enjellic.com> wrote:
> > > > > >
> > > > > > The integration of the Integrity Measurement Architecture (IMA)
> > > > > > into the LSM infrastructure introduced a conditional check that
> > > > > > denies access to the security_inode_init_security() event handler
> > > > > > if the LSM extended attribute 'blob' size is 0.
> > > > > >
> > > > > > This changes the previous behavior of this event handler and
> > > > > > results in variable behavior of LSM's depending on the LSM boot
> > > > > > configuration.
> > > > > >
> > > > > > Modify the function so that it removes the need for a non-zero
> > > > > > extended attribute blob size and bypasses the memory allocation
> > > > > > and freeing that is not needed if the LSM infrastructure is not
> > > > > > using extended attributes.
> > > > > >
> > > > > > Use a break statement to exit the loop that is iterating over the
> > > > > > defined handlers for this event if a halting error condition is
> > > > > > generated by one of the invoked LSM handlers.  The checks for how
> > > > > > to handle cleanup are executed at the end of the loop regardless
> > > > > > of how the loop terminates.
> > > > > >
> > > > > > A two exit label strategy is implemented.  One of the exit
> > > > > > labels is a target for the no attribute case while the second is
> > > > > > the target for the case where memory allocated for processing of
> > > > > > extended attributes needs to be freed.
> > > > > >
> > > > > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > > > > ---
> > > > > >  security/security.c | 24 ++++++++++++------------
> > > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > ...
> > >
> > > > > Looking at this quickly, why does something like the following not work?
> > > > >
> > > > > [Warning: copy-n-paste patch, likely whitespace damaged]
> > > > >
> > > > > diff --git a/security/security.c b/security/security.c
> > > > > index 7e118858b545..007ce438e636 100644
> > > > > --- a/security/security.c
> > > > > +++ b/security/security.c
> > > > > @@ -1712,10 +1712,7 @@ int security_inode_init_security(struct inode *inode, str
> > > > > uct inode *dir,
> > > > >        if (unlikely(IS_PRIVATE(inode)))
> > > > >                return 0;
> > > > >
> > > > > -       if (!blob_sizes.lbs_xattr_count)
> > > > > -               return 0;
> > > > > -
> > > > > -       if (initxattrs) {
> > > > > +       if (initxattrs && blob_sizes.lbs_xattr_count) {
> > > > >                /* Allocate +1 as terminator. */
> > > > >                new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
> > > > >                                     sizeof(*new_xattrs), GFP_NOFS);
> > > >
> > > > We ran with something similar to the above for several days of TSEMv3
> > > > testing.
> > > >
> > > > For the patch that we submitted upstream, we elected to take a 'belt
> > > > and suspenders' approach that isolated the 'no attributes' execution
> > > > flow from the flow followed if extended attributes are present.
> > > >
> > > > The approach used doesn't make any difference to us as long as we get
> > > > the functionality of the hook restored.
> >
> > > I'd prefer the simpler approach.  I'd likely also prefer we park
> > > this patch until it is needed upstream, or am I misunderstanding
> > > things and upstream is currently broken without a fix like this?
> >
> > As of the 6.8 release, a security handler that previously functioned
> > in a consistent manner now functions inconsistently depending on the
> > LSM stacking configuration that is in effect.

> In Linux v6.8[1] only Smack and SELinux provide implementations for
> the security_inode_init_security() hook, and both also increment the
> associated lsm_blob_sizes::lbs_xattr_count field.  While the
> behavior of the hook may have changed, I see no indications of any
> harm with respect to the standard upstream Linux kernel.  We
> obviously want to ensure that we work to fix harmful behavior, but I
> simply don't see that here; convince me there is a problem, send me
> a patch as we've discussed, and I'll merge it.

BPF provides an implementation and would be affected.

Simply grepping for 'inode_init_security', in the security
sub-directory of the kernel source tree, will miss the dependency.

Google initialized the BPF LSM hooks by redefining the LSM_HOOK macro
before including the include/linux/lsm_hook_defs.h file.  This causes
all of the LSM event handlers to be defined as BPF LSM hooks but
doesn't explicitly disclose any of the event handlers by name.

We just checked our documentation on BPF LSM tap points for
CrowdStrike's Falcon agent, which is a couple of months old by now,
and don't see them using it, but that is only a small and dated
sample.

You probably remember, I believe you were there for an LSM update
panel, that Alexei Starovoitov commented in his keynote talk at the
European Linux Security Summit last September, that he estimated 90%
of the use of the BPF LSM is not publically disclosed.  Given that,
affecting any functionality, particularly the way this issue does,
would seem to be imprudent.

> If we are talking about future code, simply include the change with
> the associated patchset.

Given the dynamics of all this, it would seem to make sense for this
to be a straight forward fix that would get directed to stable.

> If we are talking about out-of-tree code, that's something else.

We understand Linux kernel dynamics pretty well [1], we wouldn't
advocate for changes to mainline for such initiatives.

> [1] In Linux v6.9-rc1 this grows to include EVM, but EVM also provides
> both a hook implementation and a lbs_xattr_count bump.

BPF initialization, as of 6.8 does not include an xattr request.

> > Perhaps more problematically, when the handler does not function
> > correctly, there is no indication of that fact passed upward to the
> > LSM invoking the handler.  This would cause the LSM to conclude that a
> > security relevant action was conducted when it did not actually occur.
> >
> > I believe we would all universally conclude that having security
> > critical infrastructure function in a consistent and reliable manner
> > is of benefit, so we should return the previous behavior of the
> > handler, particularly since it can be done with a one line fix if that
> > is your preference.

> You need to demonstrate the harm caused to the upstream Linux kernel,
> either a proper tagged release in Linus' tree, the current development
> code in Linus tree, or a subsystem branch/repository.

BPF would be currently affected, including its derivatives, from 6.8
forward.

> > If you would be so kind, please put a 'Reported-by:' tag on whatever
> > you commit upstream.

> As you initially submitted a patch for this, it would be preferable
> if you would send a patch ... if necessary (see above comments).  Of
> course if you are unable to do so, and we all agree that a problem
> in the upstream kernel exists, I can submit a patch with the
> appropriate credit.

The one-liner is a simple, straight forward and acceptable fix but it
would not be our preference for fixing it.  Given that, it would
probably be best to go in under alternate authorship.

> I will mention that bug fixes like this are a great way for new
> contributors to gain experience working with the upstream Linux
> kernel; I would encourage you to see this through.  As frustrating
> as this might be, debates like this are part of the process :)

[1]:

With respect to a new contributor gaining experience.  For whatever it
is worth moving forward, personally, I've been spinning patches for
the Linux kernel since December of 1991.  So I have a high degree of
familiarity with respect to the dynamics of Linux kernel development
and how they have evolved over time.

Personally I also enjoy a substantive background in forensic exchange,
so debate is not a foreign concept by any means.

Given that a one-liner restores long standing behavior and potentially
fixes what could be silent corruption of desired security
functionality, there would seem to be little basis for debate, as
entertaining as that may be... :-)

> paul-moore.com

Have a good remainder of the day.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
		  https://github.com/Quixote-Project

