Return-Path: <linux-security-module+bounces-5103-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA1F95FA9D
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611A31C22214
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C286219A281;
	Mon, 26 Aug 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IR0tKYw2"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADC1991B5
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704069; cv=none; b=IMbxhTSnbq/TdQ67dE80Y9m/OsacuP2Ux3rOlLhGFfUUS9BHqGqb0t45aX/0vfVtOTTIcXvYdbwctN2L+0RRs+AZSc62kbdx/qazRDqLSzrVVqOhD5yhw2tFNqyQP0fPf1CkwsqcoFfQeBpZ8lXDi4Z39LGuGQ4nNy9jMQM/ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704069; c=relaxed/simple;
	bh=WoIl9vJoCKhnDqcEn9U1B+lYdGeiatazUZRQ6wCjnFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9G4QVZVLjdsHarMOKFGsuTr9IjBRwdcbE3Jf58hszxpMASFuxs+FW8FRYdnxPpofK/Lm1vWd4ngMdx3o/bxiecZnUAQ+ElLB9Q+wuw5mzbJlHVGcNowAJ9qXozoKUAEkGQAtR93j0vGWf+s1FyOaKa3E4iJrj+3y0BOdEIH6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IR0tKYw2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so9288615a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724704066; x=1725308866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm4/rM2Nbm4BxU6M6mgAwrLUVy2sx5HXqvLkcYe+2qw=;
        b=IR0tKYw25HlpCK7bBDMOHLuFV5RpDwy1WcAQZyvh5hnfR5eoQMTO/b7UHImugo1ZUt
         BiMjnYzlmbAsGPxE1wmTBxqAMfq/0vD44QMp1pAGO6/4BglcAsbkh/L++Oq34mIhgH3I
         VnlhPGpjb7n6ZCUgZ6AyVtKKP/OD+i7LaX+Sj/hLFQcDvSwJakz9DvzpCalqeiz/iE2b
         NxhYJcHQBcmHGT044+f2pRxIO3n2fyro7WZqba8uQYo/CMxPjdCsyX/ldbML0JXzk8fY
         FJj8QtYVvceC4n9aQ0Z1qqiT8DAnpoYi/yCj1JBra65AP/uSCf+odAD+ElcdB1NbZHGY
         AvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724704066; x=1725308866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm4/rM2Nbm4BxU6M6mgAwrLUVy2sx5HXqvLkcYe+2qw=;
        b=r8yrJfkmrtjysxiLjmehQnvFuVJDcfJbwYDnn76W5Sxzef26MxEE0fidUi+SvXqiOR
         e5lVsUH2nlwbQ6fTEnWOcbSMZb1rqCu3PjBkwbVnE2cou6xVJmJr8vUkxe4YqpYK3ftE
         wS6DyUkoWxUMD7TOditiMDyRAJQUxArV0jqj3W0OlyYAg7iLGaIW/diOX+Rx07hbZY6w
         prJsD8gBfUHMPWejmn99bQXN8RFcGi4mPK8hzPiR3c0oAL54V4AvK4x1ieWEYgRHID8B
         aaMnvc+gLPlndxtqsJVSJ6WbOWYymvkhCRfiJGUtZyHgCskVv7EVPIDul4ESGGKdFT/L
         AKlg==
X-Forwarded-Encrypted: i=1; AJvYcCVdg5HKPVODdxn4zOhzBVNXTNYqNiN0nLPZa5rRwTbOZZ0jRhRx9xGW+QkjaixL3yKvK1A2UxSysqqtcpCFjm26Dokc26M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6qQ/Gxgx6Z/pG50M2Wh2Yhuls1m7GkEa332Fd9s2ziUNB5fP
	/TeBz8btW1nR4hZW4G35kkmVG9Wlsj2xR7+d/XufT2/VLJr9fCfoe4D39xfqJbs=
X-Google-Smtp-Source: AGHT+IH2ZvTxn8FRBuIAeUAVyqlVMPlbsz0a4GJhJVustV8Wa4viBPRARgLwUA5BIC4e5Ivl5ZHx7w==
X-Received: by 2002:a17:907:944f:b0:a86:96da:afb with SMTP id a640c23a62f3a-a86e2932824mr83954766b.10.1724704065932;
        Mon, 26 Aug 2024 13:27:45 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548624asm17353866b.42.2024.08.26.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:27:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 22:27:44 +0200
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
Message-ID: <ZszlQEqdDl4vt43M@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>

On Mon 26-08-24 16:00:56, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 09:58:08PM GMT, Michal Hocko wrote:
> > On Mon 26-08-24 15:39:47, Kent Overstreet wrote:
> > > On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > > 
> > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > > dangerous to use if the caller doesn't control the full call chain with
> > > > this flag set. E.g. if any of the function down the chain needed
> > > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > > cause unexpected failure.
> > > > 
> > > > While this is not the case in this particular case using the scoped gfp
> > > > semantic is not really needed bacause we can easily pus the allocation
> > > > context down the chain without too much clutter.
> > > 
> > > yeah, eesh, nack.
> > 
> > Sure, you can NAK this but then deal with the lack of the PF flag by
> > other means. We have made it clear that PF_MEMALLOC_NORECLAIM is not we
> > are going to support at the MM level. 
> > 
> > I have done your homework and shown that it is really easy
> > to use gfp flags directly. The net result is passing gfp flag down to
> > two functions. Sure part of it is ugglier by having several different
> > callbacks implementing it but still manageable. Without too much churn.
> > 
> > So do whatever you like in the bcache code but do not rely on something
> > that is unsupported by the MM layer which you have sneaked in without an
> > agreement.
> 
> Michal, you're being damned hostile, while posting code you haven't even
> tried to compile. Seriously, dude?
> 
> How about sticking to the technical issues at hand instead of saying
> "this is mm, so my way or the highway?". We're all kernel developers
> here, this is not what we do.

Kent, we do respect review feedback. You are clearly fine ignoring it
when you feels like it (eab0af905bfc ("mm: introduce
PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") is a clear example of it).

I have already made my arguments (repeatedly) why implicit nowait
allocation context is tricky and problematic. Your response is that you
simply "do no buy it" which is a highly technical argument.

-- 
Michal Hocko
SUSE Labs

