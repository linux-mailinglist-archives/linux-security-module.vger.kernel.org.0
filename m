Return-Path: <linux-security-module+bounces-8863-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BCA6AAB0
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Mar 2025 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3782A189BBC6
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Mar 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0A22A4FE;
	Thu, 20 Mar 2025 16:01:03 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE522A4D1
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486463; cv=none; b=TS5m3fydEei5mE4z/KaL4SradUgzAleX76vfSnXsi85Ij0FwHyk1I4d20CFfCD0wC9fwN6jbJn0tvsuzP5/kK3Bg+kYj+c3B8TrU5EqGl746BHsMhSRqQJQf/is4GwNjL9X7IsOTzX6ex0w7CDNeQtz9XZoFqt16QHyzCNQKABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486463; c=relaxed/simple;
	bh=1fZq+9+qN2dWTF6h8mSKQAqErBdbQnc7JZJTp9ov+pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKyTgr40dQZErtJb9bcqo3kRsm2MwC5Suui22v9UFCKOTZ8IWiSPBgIZMeegehkvMfGTgiMfFRn/YbFCrc6qcsNmTZvxs03ZJ8n1EHJUQY5D4g7Celd6G4XIEkmcraH/Hn7dr5/SKTpVgJbyhTPpq3y9d4Dx7bKbKrVDJG+fmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52KG0P6K013712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 12:00:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 974C42E010B; Thu, 20 Mar 2025 12:00:25 -0400 (EDT)
Date: Thu, 20 Mar 2025 12:00:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
        gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mic@digikod.net,
        Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250320160025.GE1079074@mit.edu>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <20250318221128.GA1040959@mit.edu>
 <Z9sCcbZ7sdBgbX77@itl-email>
 <20250319212517.GB1079074@mit.edu>
 <Z9u1L_2o71uEiU4g@itl-email>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9u1L_2o71uEiU4g@itl-email>

On Thu, Mar 20, 2025 at 02:26:41AM -0400, Demi Marie Obenour wrote:
> The L4 family of microkernels, and especially seL4, show that
> microkernels do not need to be slow.

With all due respect to folks who have wrked on L4 and its derivatives,
L4 is a research prototype.  The gap between a research prototype and
something that can actually be used in wide variety of use cases, from
smart watches, to mainframes, is... large.

If some company is willing to fund such work, I'd be very interested
to see what they can come up with.  I will note that Google has tried
dabbling in this space with Fuchsia, and getting to something that can
actually be shipped in a product has been a very long road.  To their
credit, they have managed to do this for a version of Nest Hub, but
most people would say that it is very far from being suitable for
Android or Chrome OS, and supprting data center workloads was
explicitly a non-goal by the Fuschia team.

See [1] for more details.  In 2018, it was reported that Google had
over 100 engineers working on Fuchsia starting in 2016, with the hopes
that it would be ready "in 5 years".  Per [2], apparently in 2024
Fuschia "is not dead", but work has slowed and there aren't as many
people working on it.  (Disclosure: I work at Google but all of my
recent knowledge about Fuchsia comes from news reports; the last time
I talked to anyone on the Fuchsia team was well before COVID.)

[1] https://www.bloomberg.com/news/articles/2018-07-19/google-team-is-said-to-plot-android-successor-draw-skepticism
[2] https://www.reddit.com/r/Fuchsia/comments/1g7x2vs/what_happened_to_fuchsia/

> I do agree that making a microkernel-based OS fast is hard, but on
> the other hand, running an entire Linux VM just to host a single
> application isn't exactly an efficient use of resources either.

Well, if you want to try to make a business case to VP's with
estimates of how many engineers this would require, probably in a
sustained effort taking at least 5 to 10 years, I cordially invite you
to make the attempt.  :-)

Given how cheap hardware has been geting, running multiple VM's on an
Android phone or a ChromeOS laptop might not actally be that
expensive, relative to the cost of the required number of software
engineers for some of the alternatives we've discussed on this thread.
There are ways that you can share the read-only text pages for the
kernel, etc., to optimize the overhead of the VM, for exaple.

It is also much easier to collavorate with SOC designers to create
hardware optimizations for a VM abstraction, as compared to creating
hardwae optmizations for a software-level OS abstraction such as a
container or microkernel task.  So I don't think it's a safe
assumption that VM overheads will always be unacceptable relative to
the alternatives.

Cheers,

					- Ted


