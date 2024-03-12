Return-Path: <linux-security-module+bounces-2062-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42428879DE0
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Mar 2024 22:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C485B21B59
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Mar 2024 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0A143748;
	Tue, 12 Mar 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqJpc9zF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE4143732
	for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280210; cv=none; b=urwJWcW52r0/qS6ol8G4IRX1xfFQgvBrqUZ9QQBoXpdN7+XYUfxVo4WAMfiFGvnpJTzqTRRBwU2M/qgQYu2R3XYI0XNU209O1S3A9Hs+y5lvlzph47UzPwBsScjBrrloImvxSEaDIXkqdiU+gfo4clEhEh936KaErWl8fNLaeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280210; c=relaxed/simple;
	bh=vJfspYsyjS+Pt3OTxCc7ltdpQiZqK6WN+FOhc/2FgR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4pxWHJH/WfiaNzu9ShJZN2ymQ+CyV6M7z2usBvUknp3NCv7vto0ntKomVAIMUvUoGhG9RjbnolGt6hKQfaRv5FvgopIwFcV1OC1BNpHPXS+Ktv0UpUYRuExcFyy4bPQitB8hoGnTSSYzovWsolshQhLGCLDoFCJuqgTfJCClQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bqJpc9zF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc13fb0133so32163435ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280208; x=1710885008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1kofq3l1D4wfUc3iN/PliRzej6qzqJGQvPFFs2Og7ZM=;
        b=bqJpc9zF1jCff5Y90Njqe0wZO4jK0E9vHA1QzPLzX8PWVmQlaux7NJesfDO5bBqFeo
         rsXolYWh2mTyXYk9lq3D6JzrjZLCoCOGsgkD+yVUbpmrOoa+KEj4hVcjee2amXikwHXs
         6CGhWazGGi7HmJOJ3zjjEwOU0drGPUEWPiuT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280208; x=1710885008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kofq3l1D4wfUc3iN/PliRzej6qzqJGQvPFFs2Og7ZM=;
        b=BkK9z7SOC4XjJMD89VQek+jSF6mTUgwI36hxt/kmOp+X9N7ZOg5ihrj9Nxm4NcCeze
         I6i6IVC5bTKEv/3nFY/HRdJ2zfVoOmiRXytON3W5h+zLMjShXdzgqcVVTAkigzu+Bbwu
         xvzLGsnB696sw/1NVkj+6mxPcP+uJrBk8KSdzLOYl7DoaLOT2fyBt08aOONjbvvWqxnV
         44wv48J4Xw4Dp3E1dXWkDDU0uK+BtyyNvpzqfxqPiaUFpF3O0aAJz4Xi4oPhkKvcMKpu
         Fn8DCIMz/c7EZoWl4a3u90gz+Pv05pTcmV+Y4NUsMnHywQi4Giou0waCqABvlxQ5YJaz
         2aIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLiUkCmbeulTaXqtXR3hEVedyYY2wt8yeowubL/Hwk52MLHL/5Of7eqY1LURWZWjMLRNAggjyhFrC5NXCXRoRjtCBeqYTiVsfyOlaF/XQzvuj2cjSS
X-Gm-Message-State: AOJu0YxJHcQZzeNfb2Dr9FvpapRcxVdgos+1oTFTxup2v5mRXzW2fdHD
	yCOd2ApecIltIV87UjoRShIXhIkptWFKdqyKcIlI5ak45eN6TyPJP5nldpypEg==
X-Google-Smtp-Source: AGHT+IHf2HAkV0cjtM5Q0q9lq5Ii/du0fhnsZJDBL0QZxPbto3rM5vX2njIlUI2lStGMlLeYJJNVUw==
X-Received: by 2002:a17:902:d2c8:b0:1dd:66d1:a62b with SMTP id n8-20020a170902d2c800b001dd66d1a62bmr12234362plc.5.1710280208586;
        Tue, 12 Mar 2024 14:50:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b001dbcfa0f1acsm1946048pla.83.2024.03.12.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:50:07 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:50:07 -0700
From: Kees Cook <keescook@chromium.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org, jmorris@namei.org,
	serge@hallyn.com, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	mic@digikod.net
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Message-ID: <202403121449.17AB66665@keescook>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org>
 <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
 <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
 <20240312182820.GA5122@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312182820.GA5122@altlinux.org>

On Tue, Mar 12, 2024 at 08:28:20PM +0200, Dmitry V. Levin wrote:
> On Tue, Mar 12, 2024 at 10:44:38AM -0700, Casey Schaufler wrote:
> > On 3/12/2024 10:06 AM, Paul Moore wrote:
> > > On Tue, Mar 12, 2024 at 11:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> On 3/12/2024 6:25 AM, Paul Moore wrote:
> > >>> On Tue, Mar 12, 2024 at 6:16 AM Dmitry V. Levin <ldv@strace.io> wrote:
> > >>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> > >>>> [...]
> > >>>>> --- a/security/lsm_syscalls.c
> > >>>>> +++ b/security/lsm_syscalls.c
> > >>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> > >>>>>  {
> > >>>>>       return security_getselfattr(attr, ctx, size, flags);
> > >>>>>  }
> > >>>>> +
> > >>>>> +/**
> > >>>>> + * sys_lsm_list_modules - Return a list of the active security modules
> > >>>>> + * @ids: the LSM module ids
> > >>>>> + * @size: pointer to size of @ids, updated on return
> > >>>>> + * @flags: reserved for future use, must be zero
> > >>>>> + *
> > >>>>> + * Returns a list of the active LSM ids. On success this function
> > >>>>> + * returns the number of @ids array elements. This value may be zero
> > >>>>> + * if there are no LSMs active. If @size is insufficient to contain
> > >>>>> + * the return data -E2BIG is returned and @size is set to the minimum
> > >>>>> + * required size. In all other cases a negative value indicating the
> > >>>>> + * error is returned.
> > >>>>> + */
> > >>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
> > >>>>> +             u32, flags)
> > >>>> I'm sorry but the size of userspace size_t is different from the kernel one
> > >>>> on 32-bit compat architectures.
> > >>> D'oh, yes, thanks for pointing that out.  It would have been nice to
> > >>> have caught that before v6.8 was released, but I guess it's better
> > >>> than later.
> > >>>
> > >>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ..)
> > >>>> now.  Other two added lsm syscalls also have this issue.
> > >>> Considering that Linux v6.8, and by extension these syscalls, are only
> > >>> a few days old, I think I'd rather see us just modify the syscalls and
> > >>> avoid the compat baggage.  I'm going to be shocked if anyone has
> > >>> shifted to using the new syscalls yet, and even if they have (!!),
> > >>> moving from a "size_t" type to a "u64" should be mostly transparent
> > >>> for the majority of native 64-bit systems.  Those running the absolute
> > >>> latest kernels on 32-bit systems with custom or bleeding edge
> > >>> userspace *may* see a slight hiccup, but I think that user count is in
> > >>> the single digits, if not zero.
> > >>>
> > >>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> > >>> compat shim if we can.
> > >>>
> > >>> Casey, do you have time to put together a patch for this (you should
> > >>> fix the call chains below the syscalls too)?  If not, please let me
> > >>> know and I'll get a patch out ASAP.
> > >> Grumble. Yes, I'll get right on it.
> > > Great, thanks Casey.
> > 
> > Look like lsm_get_self_attr() needs the same change. lsm_set_self_attr()
> > doesn't, need it, but I'm tempted to change it as well for consistency.
> > Thoughts?
> 
> As lsm_get_self_attr() has the same issue, it needs the same treatment.
> 
> lsm_set_self_attr() could be left unchanged.  In fact, changing the type
> of syscall arguments from size_t to an explicit 64-bit type would be
> problematic because 32-bit syscalls cannot have 64-bit arguments.

Using u32 should be totally fine for both. Nearly ever kernel internal
limits sizes to INT_MAX anyway. :)

-- 
Kees Cook

