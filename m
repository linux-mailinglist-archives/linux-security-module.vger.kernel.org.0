Return-Path: <linux-security-module+bounces-5131-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D496033A
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Aug 2024 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE151F2376E
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Aug 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE7156F30;
	Tue, 27 Aug 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L9XqK4WF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A717BEC1
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744116; cv=none; b=QY0YacKQHWHmfkCi6G9wiiKB/sWMI2hzgtbd+mw/RInok+DMS1leioIQN2MkEFHgec43XoXTmmsa+EgBTBPLx2fvVPkOGzBFj4so1CyyOW29bzztZuEfpzE/ATJZhBASE57xCX5Q8oWJargz356FdUXlwShXKjasnrOLwHNXrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744116; c=relaxed/simple;
	bh=duo0P38BP7tkr3HFeJC2cMdAdFIVhnfMrODEYFx/TWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlPVevaKGUvbovay5Q7dTZnPVORIwEKmzGfo4Rq+W/lmVhud7qTsaiIU8BipW96RSHPpiF9XFL3UTD3d5AXgAgsqR7MeCjxdVL0YeP2TuDmewusE0RRiZgkel35hMS+R5sfJK/WYSNUFRzaZL9DcLlntJDxKp0JZXdLetLzz2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L9XqK4WF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so5467783a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724744113; x=1725348913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCalSenT4u/MD5WlKs1thsXqDcN0KXoCRYEnOG92GYQ=;
        b=L9XqK4WFk/mNan8zJS2KRIkf1DTajYoghw3HawEsQ9aw4Znql6bn/9mLFZZBY0SDD/
         vcSk2V3KPcAxIbaGkIVPiBCZFFKyRSDs+WB22EJtUGE+zS6bUgaOg4WGa6LtqMk+48v5
         pX3luT6vqlKbkh5YfMFpJfqGqEeQ4TRDmzdXWS2Rnyht54/eOPv3+Qiq1duYBAhIrPo2
         kIz3grJjVwJbwf/PYEZw1acM40NPFpO48YDGZWhVC+9OrENIFBiUuD6MZF+s0M9em+y6
         1BVqUwvIa87sya0HH7WVWryYaR/gJgfwFIBme7LIZW68SW4V/8ZbmQQQhuDQ9MewzUcx
         n0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744113; x=1725348913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCalSenT4u/MD5WlKs1thsXqDcN0KXoCRYEnOG92GYQ=;
        b=Jssnm5Atc0qswrHNHhuGxu7sPB7tsfTce389HWwZUzPs/3ktN0YeJJWFyw/U4ICqWH
         QFShAIHM3OIE+ulQeWvwK1wndJ4UzswJ/cAJ+lhZp2tpRWV7yRy9Gx1jD1eJjotVLqVt
         wBo0We2ChRHbtJHoophq9sag51z+EUmBzpHQac6GExjkHebCrbW5wZjpCo2bix4gySb2
         1e5EoTM+FUFbKZCmGwrpauNiWN/QfkXFzf4jhllINo8ysA1aZcBJXvUa52g6B7MEaWry
         5BSKuBVALU5x92e6yVb5ETbpWzmHiszGDjw3/AhyBiQpWtPGkZCdjnKYASQMGfmf/qIM
         hHXg==
X-Forwarded-Encrypted: i=1; AJvYcCUoS2D67bE4Yc6vwZvEn5klBpPrJoyVJthA5ojz8k1HctVEnd+688G6kyFvrZ1GGtISXBlLkyONcGwXwBIZ/7iyvVuGxzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywuV3sc/sSTPl33mArhE6tcUtogKH+hoMV+5LhJAS0HDzlznjE
	MQAsQug3jvG6LSirnCEC4D5o4hzWDwdk14l7UZhZLYlCOrwHG6emhe6+fnehSdQ=
X-Google-Smtp-Source: AGHT+IFy+Emn6v+C/Q4MQkjVPHkA7ImY3QFkLrA5Qcu6aFtW3nn7+I7nf1MQSkQY5Mz9qUsXKwmv5A==
X-Received: by 2002:a05:6402:40d6:b0:5bf:7dc:bbae with SMTP id 4fb4d7f45d1cf-5c0ba29756fmr1619934a12.6.1724744112729;
        Tue, 27 Aug 2024 00:35:12 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c5b39sm676803a12.20.2024.08.27.00.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 00:35:12 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:35:11 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zs2Br_GnUPtLLIBd@tiehlicka>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
 <ZszlQEqdDl4vt43M@tiehlicka>
 <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
 <Zs1rvLlk0mXklHyf@tiehlicka>
 <ru3d2bfrnyap7t3ya5kke3fqyrnj2hgbl4z2negbqkqj7z4mr2@gqrstl4lpl5h>
 <Zs15H6sT-QhvcZqa@tiehlicka>
 <y7vve7rbvpf7fq5puzszn5fwogm63dum4n47o36u5z5rn4fxxi@wspvw6mhwndq>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y7vve7rbvpf7fq5puzszn5fwogm63dum4n47o36u5z5rn4fxxi@wspvw6mhwndq>

On Tue 27-08-24 03:05:29, Kent Overstreet wrote:
> On Tue, Aug 27, 2024 at 08:58:39AM GMT, Michal Hocko wrote:
> > On Tue 27-08-24 02:40:16, Kent Overstreet wrote:
> > > On Tue, Aug 27, 2024 at 08:01:32AM GMT, Michal Hocko wrote:
> > > > You are not really answering the main concern I have brought up though.
> > > > I.e. GFP_NOFAIL being fundamentally incompatible with NORECLAIM semantic
> > > > because the page allocator doesn't and will not support this allocation
> > > > mode.  Scoped noreclaim semantic makes such a use much less visible
> > > > because it can be deep in the scoped context there more error prone to
> > > > introduce thus making the code harder to maintain. 
> > > 
> > > You're too attached to GFP_NOFAIL.
> > 
> > Unfortunatelly GFP_NOFAIL is there and we need to support it. We cannot
> > just close eyes and pretend it doesn't exist and hope for the best.
> 
> You need to notice when you're trying to do something immpossible.

Agreed! And GFP_NOFAIL for allocations <= order 1 in the page allocator or 
kvmalloc(GFP_NOFAIL) for reasonable sizes is a supported setup. And it
should work as documented and shouldn't create any surprises. Like
returning unexpected failure because you have been called from withing a
NORECLAIM scope which you as an author of the code are not even aware of
because that has happened somewhere detached from your code and you
happen to be in a callchain.

> > > GFP_NOFAIL is something we very rarely use, and it's not something we
> > > want to use. Furthermore, GFP_NOFAIL allocations can fail regardless of
> > > this patch - e.g. if it's more than 2 pages, it's not going to be
> > > GFP_NOFAIL.
> > 
> > We can reasonably assume we do not have any of those users in the tree
> > though. We know that because we have a warning to tell us about that.
> > We still have legit GFP_NOFAIL users and we can safely assume we will
> > have some in the future though. And they have no way to handle the
> > failure. If they did they wouldn't have used GFP_NOFAIL in the first
> > place. So they do not check for NULL and they would either blow up or
> > worse fail in subtle and harder to detect way.
> 
> No, because not all GFP_NOFAIL allocations are statically sized.

This is a runtime check warning.
rmqueue:
        WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

> And the problem of the dynamic context overriding GFP_NOFAIL is more
> general - if you use GFP_NOFAIL from nonblocking context (interrupt
> context or preemption disabled) - the allocation has to fail, or
> something even worse will happen.

If you use __GFP_NOFAIL | GFP_KERNEL from an atomic context then you are
screwed the same way as if you used GFP_KERNEL alone - sleeping while
atomic or worse. The allocator doesn't even try to deal with this and
protect the caller by not sleeping and returning NULL.

More fundamentally, GFP_NOFAIL from non-blocking context is an incorrect
an unsupported use of the flag. This is the crux of the whole
discussion. GFP_NOWAIT | __GFP_NOFAIL or GFP_ATOMIC | __GFP_NOFAIL is
just a bug. We can git grep for those, and surprisingly found one instance
which already has a patch waiting to be merged.

We cannot enforce that at a compile time and that sucks but such is a
life. But we can grep for this at least. Now consider a scoped
(implicit) NOWAIT context which makes even seeemingly correct GFP_NOFAIL
use a bug.
-- 
Michal Hocko
SUSE Labs

