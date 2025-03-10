Return-Path: <linux-security-module+bounces-8683-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D0A5AEBC
	for <lists+linux-security-module@lfdr.de>; Tue, 11 Mar 2025 00:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BC97A25C5
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Mar 2025 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB77221F10;
	Mon, 10 Mar 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FvdBAA5N"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C51DE3D2
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650167; cv=none; b=qgfkst+I+NLOMPDVDF0gKtMTTZiEshQcnb+tqHIdVRn0gd5Wrx7EwVN4OF+rfGiuDPoYzIYzT8ANGU2+z0+DDExUQFdbFYg4G5uAu6+YJNUS8eNvhhIKjN8/vr26FhmP8p97Zxpljs+laAvZf4W6+UX57Q4nja5mZVlKdzl8XQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650167; c=relaxed/simple;
	bh=JxuXhLpw/80PTBGVg/ckucoINOjXMwDODaIi6cAO9A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKBT8a9FFkPQ4rrWmAj/AqaL2gANiEwQ/uWw+NoKMOCES36rdnswgv06+RR5E8JOlqwwjXLeTr0bcafwSBiCRRzsGoy1+37S7yzoErvQy/Yc3WKZf4b/+4mjaSwXSQhD419o3OX4/o5c6prsKPZEoW9+B8Rm8y3AWkdBcaC1K2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FvdBAA5N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2232aead377so23248575ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741650165; x=1742254965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ab8d9IYp+L/Y7BybUEqkqbfBF3I8gaslBc0ZaUbIpYc=;
        b=FvdBAA5NJuZxHNgBsyVmNtdgX4/Aj/wxoZU7fjfJ7qxPXnLJ6Bh3iYdArkLhXUwfGs
         H7uHe9C04ilnCHPKzRPF+bhMsMjuWpRBsYHW8ZEvlRG8kYIAG2DRUlA8DKivtnQlUvNT
         Azx10ThnYGCJ8mKlKalGH0qswK+iGOD0eMATZ7CRIaF/GRgVt0pyDTPNbs6L+305VlCn
         XkhSYYLy1RgRVMd17OSPZSklJLj4bDbMNAcKyJhvOOAVMz5dzr6oepxyKv3B0bsXq5Wb
         nzMLxdnIdwYOyTYikiPJaU/a5Nhn6t4Xath5txtrQt8T2vC+fcm22vlNz0z1PtskhutP
         OTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650165; x=1742254965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab8d9IYp+L/Y7BybUEqkqbfBF3I8gaslBc0ZaUbIpYc=;
        b=sA8WK/dQ1kfb0yikDIQ2BRIxU7qFFgOUgI/T6A70zjcK1t0hU097dZuD6Goa2jNtxy
         nSldTuGLmESrnLPIkVkmzBd5ASL4xuY0GPeGzrAGHrsmOR1xqSIbwmNu8B3Y5QMsjqYb
         MTx5oEf9bKPLnNkOsbmoPXPPiKWnDhew5WyuGMlFRX9HH/vg2iJifJyka0k54z2sLFyu
         mG1GJilzdf2SVEpKlbLv30chlO2uUIb/ffUy1NDjLMmWm43P2zfWMys4hizdHH6jOT/o
         g4oy2IXoiJYttWIiQdtP+w2SfNzHkjpJnoZUljIPPTm/QrlHKgKNSzhweErwJU5T3CJq
         /mog==
X-Forwarded-Encrypted: i=1; AJvYcCUU3bHzcgTGzLLsU3uCOPyU/UFn7E5+RoRo8uLpWofV3g/ZFN03gdcdUwt4dFMLTwfksi0CPlvh3cU+oDR++5V45WyToA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCkcxQjOcJpt/VMqXewmvAs/2k84txUwf2sbJBGKUlIOJncFl
	tgjbXMoE9ueOw1Ocn1V52uAYyargv8AeYI1vNrZJQ0uoSlif8NCzMVxYDKADfTE=
X-Gm-Gg: ASbGncu8HP2kl5F7Tk9xdH2kBrRIqO9SbCYEKgLkYoWikCBetSB9wxmACWBLA+PHiUD
	3vaRgwBO84A9KXodsCTUo/y/vfyQ07RMqcxUVKuXXOlUVlmnn3aktzzQulRYQgB5RrVB6oVPnm1
	jSeIchlBrN7od9TYR60i/v3G+3s3l3Y32iLXyLlNFRrOEwnLe/wPk0svu6q7EmvgwNy5kUOv/O4
	LizjYv/dZIDYdCKamZBrxn6VOrUrRKHN6Jf8O5MEOTdGmWqijnaNwF/isZEllLBmdPBIVh60rvp
	cRXrVU1CNB/OgF43ab8+clB9uOE7WjRxbVeDM0zVycG4wb1j4Dysq78kVBoyf8GNU6BYi9nR0er
	cG4z4exW96VDgJfBe+Hr6
X-Google-Smtp-Source: AGHT+IFCbwV2RdF4GgghwFF8KjVEm6A3kyIa03pE5ShRGOJCv6PPUl+0sK6W7IyV2pwWHicIvH4jtg==
X-Received: by 2002:a17:902:ce89:b0:21f:164d:93fe with SMTP id d9443c01a7336-22428c0d524mr240131555ad.53.1741650164955;
        Mon, 10 Mar 2025 16:42:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8642sm84307995ad.72.2025.03.10.16.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 16:42:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1trmld-0000000BUzA-12Pp;
	Tue, 11 Mar 2025 10:42:41 +1100
Date: Tue, 11 Mar 2025 10:42:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, cve@kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: CVE-2025-21830: landlock: Handle weird files
Message-ID: <Z8948cR5aka4Cc5g@dread.disaster.area>
References: <2025030611-CVE-2025-21830-da64@gregkh>
 <20250310.ooshu9Cha2oo@digikod.net>
 <2025031034-savanna-debit-eb8e@gregkh>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025031034-savanna-debit-eb8e@gregkh>

[cc linux-fsdevel]

On Mon, Mar 10, 2025 at 03:36:04PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 10, 2025 at 01:00:50PM +0100, Micka�l Sala�n wrote:
> > Hi Greg,
> > 
> > FYI, I don't think this patch fixes a security issue.  If attackers can
> > corrupt a filesystem, then they should already be able to harm the whole
> > system.
> > 
> > The commit description might be a bit confusing, but from an access
> > control point of view, the filesystem on which we spotted this issue
> > (bcachefs) does not allow to open weird files (but they are still
> > visible, hence this patch) and I guess it would be the same for other
> > filesystems, right?  I'm not sure how a weird file could be used by user
> > space.  See
> > https://lore.kernel.org/all/Zpc46HEacI%2Fwd7Rg@dread.disaster.area/
> > 
> > The goal of this fix was mainly to not warn about a bcachefs issue (and
> > avoid related syzkaller report for Landlock), and to harden Landlock in
> > case other filesystems have this kind of bug.
> 
> It was issue a CVE because the reviewers thought that it was a way to
> circumvent the landlock permission checks, based on the changelog text
> (note, creating a "corrupted filesystem" is quite easy to get many Linux
> systems to auto-mount it, so those types of issues do get assigned
> CVEs.)

That's an argument straight from the security theatre.

> If you all do not think this meets the definition of a vulnerability as
> defined by CVE.org as:
> 	An instance of one or more weaknesses in a Product that can be
> 	exploited, causing a negative impact to confidentiality, integrity, or
> 	availability; a set of conditions or behaviors that allows the
> 	violation of an explicit or implicit security policy.

Yes, so shall we follow this reasoning based on untrusted user
auto-mounts of untrusted devices to it's logical conclusion?

If an untrusted user is in control of the filesystem image, then
they don't need to corrupt the filesystem image to subvert the
system. They can just change the permissions on files, change ACLs,
change security xattrs (selinux, landlock, smack, etc),
replace the contents of file data (e.g. trojan executables), etc.

The filesystem will not flag *any* of these shenanigans as they
don't involve actually corrupting the filesystem structure. IOWs,
the kernel filesystem code can function perfectly and bug free, yet
the system can be silently compromised through the hole punched in
the *implicitly trusted security information under user control* in
the fs image.

This is a "trusted device contains trusted security information"
model deficiency, not a filesystem implementation issue. The CVE
worthy issue here is that the security model is violated by the
untrusted automounts, not by how the filesystem reacts to the
security model violation that has already occurred.

Further, the kernel (and therefore the filesystem implemenation)
cannot prevent untrusted user device auto-mounts, so this must be
considered a system level vulnerability that requires userspace
policy and implementation changes to mitigate.

We've tried for years to get userspace to adopt a more
security-aware model for untrusted devices, but have made pretty
much no progress. Filesystem developers have ended up with their
userspace filesystem packages shipping udisks rules to turn off
automounting of those filesystem types for application that use
udisks for this stuff. That catches -some- of the automounting
behaviour, but not all of it. And we can't do anything else without
changes to the wider userspace/distro policies around user
automounting of untrusted devices.

IOWs, to prevent these "corrupted filesystem causes issues" from
being considered security issues, we need userspace to stop
violating the kernel trust model for persistent security information
storage.

Greg, you have the ability to issue a CVE that will require
downstream distros to fix userspace-based vulnerabilities if they
want various certifications. You have the power to force downstream
distros to -change their security model policies- for the wider
good.

We could knock out this whole class of vulnerability in one CVE:
issue a CVE considering the auto-mounting of untrusted filesystem
images as a *critical system vulnerability*. This can only be solved
by changing the distro policies and implementations that allow this
dangerous behaviour to persist.

We've suggested many relatively user friendly ways this can be
handled in the past (e.g. device fingerprinting via libblkid (which
it kinda already does) and prompting the user to allow/deny devices
with an unknown fingerprint). The simplest policy fix is to simply
disallow auto-mount of removable devices by default across the
entire distro.

If distros want to close that kernel CVE then they have to, at
minimum, turn off device auto-mount by default across the entire
distro.

At worst, this makes the reason you give for filesystem corruption
issues being considered CVE worthy go away completely.

At best, we get full distro level integration of efficient,
persistent untrusted device handling at the desktop interfaces.
That would be a win for -everyone-, not just the distro people who
have to handle kernel CVEs....

If we want filesystem corruption CVEs to be any other than security
theatre, then use we should be using the kernel CVE powers for the
reason they were obtained in the first place. i.e. to force
downstream distros to address issues they would otherwise ignore to
help make our linux systems more reliable and secure.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

