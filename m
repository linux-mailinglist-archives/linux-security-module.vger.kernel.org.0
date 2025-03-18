Return-Path: <linux-security-module+bounces-8799-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB251A66936
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Mar 2025 06:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2432E17B3F2
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Mar 2025 05:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571419E997;
	Tue, 18 Mar 2025 05:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Uj8iXueZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44D186A
	for <linux-security-module@vger.kernel.org>; Tue, 18 Mar 2025 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275315; cv=none; b=eQJ8xhKYPOVlXFWaSGCx6RgfJx/cYFMHwkRZ8sYQ8LCxSHIjfqAzXQ+KtHsLXgSYB21d20Sako3Y7SYB1aCmeduQn/RUVItW2QuovhmUml2y6C+kuWws9F/W3MJ9AkfbYvobmm8tb5zl5qTD2bJ5+u+nkYsTTknYWm2hdJnrGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275315; c=relaxed/simple;
	bh=YN74lWkAVJcHHQX+lbzeAu15kH1mfFj4ZG4wF4o6TYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElaMTIP7fJuhffjmQx9g80oEPNebCZxhgn3KeNccCyiIJKO4+8i+FeQdgZJ0BnAqhSqjz5f4tGx+zzpGIvtN/osLmm2eF+PFzDBkr/oVTgbq+WpTflSLshfRq5Z/jVIv4VIAmzm0enOMlTzrK3XnevB1axlsAQpAgSWN3U9H5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Uj8iXueZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223a7065ff8so63504005ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 17 Mar 2025 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742275312; x=1742880112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ircpdILo0/q0Q4IKHZSFzXAJrxEqYiPNSQbp/z2naU0=;
        b=Uj8iXueZtK4JrUtREVIbggXtbvCj6rdULS29F9knTgudDaE96uzNsgiJYvN67tG6xW
         XGsY7KeRKCe/opX0LWJhsnHAIX9wq9Fhr1nKvoUAZDzzyt64Dj3iAr6tJwdwxYoaxwxk
         jagZEK2TYRKNEZzzWVhw2ffcbIdo3sJgVWTDjrby0xKDJ4rG0cyu6Q+nOayLVboDlhkF
         uCZAoCfCdWPqjZaSE6f7IqsA7+4YpwXtKmzOJz6/ekGtRZQ6ZdjSm/cShNWjExoikHtX
         hwc/1BpGJXxMRRN0x1jJwQ8FjdCAMewRcsiDnCI6umT1aECrCLdk5DD24915wjaUYqnh
         1kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742275312; x=1742880112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ircpdILo0/q0Q4IKHZSFzXAJrxEqYiPNSQbp/z2naU0=;
        b=nk0iqODJIHyPi8lozGcaxqfKD6ZUp3sbzAWfctx0SKpLW+uVthCedlqfLq3FWRQcPN
         BK6EilPvHOg9wg8jmMdJY5e/yv40MTPQ1SZhmTN/llQEuQmb8r7NLM8JkFJVH22qGuyW
         8Hb6FeeVEJIL2cSljvbIWtjaT7tXZguKSZt/mEnQwhJziqsQKtkUsWF4olxQ4eNuDDnW
         EHe5xBAUD4kANd+dCYc4MPKqI17A+gYqgNUIVhbBuiXE093PdxxZsH1FosI/z1eUOR1+
         GUbBarsGq1VrHx7qGLKlU3myZhR5jGElftim2MbxaWe+K4u/RFSzeYLwLh6NCnJY5AGX
         Vuzw==
X-Forwarded-Encrypted: i=1; AJvYcCWKII2Sw+H3H/4jZ7QCP94fBt4zRXxfH5s+1Atf7IZPxfbIRKaD1Gc9Y3zPDqIlT3LGGXPkUhR/UfNSplNHTRXEwggCCLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyYDIAZmvzrEZBQgot2LOdr7rRfEgzzg9AOgRyHSUIdR+CRcH
	c6GKExQzfs2PgPAAkQW5PocW+qOMyNwjtRhH4kvUudFbi0BnG5j0fqthW+iX8KM=
X-Gm-Gg: ASbGncsqGuLuhs8RAXVlxNanjkcMWvopHR0pdc+j1JV8l2/Hqc/Jpubs0sfxUT6j/KA
	ATnP6mI8o0wqEVDK0vBLLew4U2BpbkDCZRyIa/JbLktUshdF8BK4eGG0s/AW28mtkBDc9PcRGGa
	X1x1TRAR59y/R8wviTmxpN6ggVeMp9qYwfxLX2z6WYBjoLyZDLEausXsrk+9KKYAHGui/5elTFU
	ESyfTsaLsvFWDyXWFTltJEtCt0HmY0MyU2n5AxzDkQ/na6ty4bP09Wq4JAhNsEwq0W+guuHyxNN
	QfNz/GVh6SGhUIhxx9vN3JhSjM25AByZtldV0xFhLTPJVLkOJ6298hjbcMz+jDDz1owRkyVZgOg
	K0uKejHwP2827bxwKg9DOYT3ud7KE9ts=
X-Google-Smtp-Source: AGHT+IFKsY0+OKjsH/X5o+P43TTK/ErFl2U+PHbTBUv+kSlprCZhyfl7cL5sE5TibLiulY1VexRGvg==
X-Received: by 2002:a17:902:e5cb:b0:224:1001:677c with SMTP id d9443c01a7336-225e0a62fcfmr184304805ad.9.1742275312452;
        Mon, 17 Mar 2025 22:21:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6865sm85258215ad.75.2025.03.17.22.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:21:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tuPOe-0000000EZzQ-3dsP;
	Tue, 18 Mar 2025 16:21:48 +1100
Date: Tue, 18 Mar 2025 16:21:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: cve@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z9kC7MKTGS_RB-2Q@dread.disaster.area>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9CYzjpQUH8Bn4AL@itl-email>

On Tue, Mar 11, 2025 at 04:10:42PM -0400, Demi Marie Obenour wrote:
> On Tue, Mar 11, 2025 at 04:57:54PM +1100, Dave Chinner wrote:
> > On Mon, Mar 10, 2025 at 10:19:57PM -0400, Demi Marie Obenour wrote:
> > > People have stuff to get done.  If you disallow unprivileged filesystem
> > > mounts, they will just use sudo (or equivalent) instead.
> > 
> > I am not advocating that we disallow mounting of untrusted devices.
> > 
> > > The problem is
> > > not that users are mounting untrusted filesystems.  The problem is that
> > > mounting untrusted filesystems is unsafe.
> > 
> > > Making untrusted filesystems safe to mount is the only solution that
> > > lets users do what they actually need to do. That means either actually
> > > fixing the filesystem code,
> > 
> > Yes, and the point I keep making is that we cannot provide that
> > guarantee from the kernel for existing filesystems. We cannot detect
> > all possible malicous tampering situations without cryptogrpahically
> > secure verification, and we can't generate full trust from nothing.
> 
> Why is it not possible to provide that guarantee?  I'm not concerned
> about infinite loops or deadlocks.  Is there a reason it is not possible
> to prevent memory corruption?

You're asking me to prove that the on-disk filesystem format parsing
implementation is 100% provably correct. Not only that, you're
wanting me to say that journal replay copying incomplete,
unverifiable structure fragments over the top of existing disk
structures is 100% provably correct.

I am the person whole architected the existing metadata validation
infrastructure that XFS uses, and so I know it's limitations in
intimate detail. It is, by far, the closest thing we have to
complete runtime metadata validation in any Linux filesystem
(except maybe bcachefs), but it is nowhere near able to detect and
prevent 100% of potential structure corruptions.

It is *far from trivial* to validate all the weird corner cases that
exist in the on-disk format that have evolved over the last 3
decades. For the first 15 years of development, almost zero thought
was given to runtime validation of the on-disk format. People even
fought against introducing it at all. And despite this, we still
have to support the on-disk functionality those old, difficult to
validate, persistent structures describe.

[ And then there's some other random memory corruption bug in the
code, and all bets are off... ]

IOWs, no filesystem developer is ever going to give you a guarantee
that a filesystem implementation is free from memory corruption bugs
unless they've designed and implemented from the ground up to be
100% safe from such issues. No such filesystem exists in the kernel,
and it will probably be years away before anything may exist to fill
that gap.

> > The typical desktop policy of "probe and automount any device that
> > is plugged in" prevents the user from examining the device to
> > determine if it contains what it is supposed to contain.  The user
> > is not given any opportunity to device if trust is warranted before
> > the kernel filesystem parser running in ring 0 is exposed to the
> > malicious image.
> > 
> > That's the fundamental policy problem we need to address: the user
> > and/or admin is not in control of their own security because
> > application developers and/or distro maintainers have decided they
> > should not have a choice.
> > 
> > In this situation, the choice of what to do *must* fall to the user,
> > but the argument for "filesystem corruption is a CVE-worthy bug" is
> > that the choice has been taken away from the user. That's what I'm
> > saying needs to change - the choice needs to be returned to the
> > user...
> 
> I am 100% in favor of not automounting filesystems without user
> interaction, but that only means that an exploit will require user
> interaction.  Users need to get things done, and if their task requires
> them to a not-fully-trusted filesystem image, then that is what they
> will do, and they will typically do it in the most obvious way possible.
> That most obvious way needs to be a safe way, and it needs to have good
> enough performance that users don't go around looking for an unsafe way.

Well, yes, that is obvious, and not a point of contention at all,
as is evidenced by the list of solutions to this problem I outlined.

> > > or running it in a sufficiently tight
> > > sandbox that vulnerabilities in it are of too low importance to matter.
> > > libguestfs+FUSE is the most obvious way to do this, but the performance
> > > might not be enough for distros to turn it on.
> > 
> > Yes, I have advocated for that to be used for desktop mounts in the
> > past. Similarly, I have also advocated for liblinux + FUSE to be
> > used so that the kernel filesystem code is used but run from a
> > userspace context where the kernel cannot be compromised.
> > 
> > I have also advocated for user removable devices to be encrypted by
> > default. The act of the user unlocking the device automatically
> > marks it as trusted because undetectable malicious tampering is
> > highly unlikely.
> 
> That is definitely a good idea.
> 
> > I have also advocated for a device registry that records removable
> > device signatures and whether the user trusted them or not so that
> > they only need to be prompted once for any given removable device
> > they use.
> > 
> > There are *many* potential user-friendly solutions to the problem,
> > but they -all- lie in the domain of userspace applications and/or
> > policies. This is *not* a problem more or better code in the kernel
> > can solve.
> 
> It is certainly possible to make a memory safe implementation of amy
> filesystem.

Spoken like a True Expert.

> If the current implementation can't prevent memory
> corruption if a malicious filesystem is mounted, that is a
> characteristic of the implementation.

Ah, now I see what you are trying to do. You're building a strawman
around memory corruption that you can use the argument "we need to
reimplement everything in Rust" to knock down.

Sorry, not playing that game.

> However, the root filesystem is not the only filesystem image that must
> be mounted.  There is also a writable data volume, and that _cannot_ be
> signed because it contains user data.  It is encrypted, but part of the
> threat model for both Android and ChromeOS is an attacker who has gained
> root or even kernel code execution and wants to retain their access
> across device reboots. They can't tamper with the kernel or root
> filesystem, and privileged userspace treats the data on the writable
> filesystem as untrusted.  However, the attacker can replace the writable
> filesystem image with anything they want,

And therein lies the attack a fielsystem implementation can't defend
against: the attacker can rewrite the unencrypted block device to
contain anything they want, and that will then pass verification on
the next boot. Perhaps that's the class of storage attack you should
seek to prevent, not try to slap bandaids over trust model
violations or insinuate the only solution is to rewrite complex
subsystems in Rust....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

