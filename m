Return-Path: <linux-security-module+bounces-8688-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E29A5B8FB
	for <lists+linux-security-module@lfdr.de>; Tue, 11 Mar 2025 07:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6B18965FD
	for <lists+linux-security-module@lfdr.de>; Tue, 11 Mar 2025 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FD1EF368;
	Tue, 11 Mar 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="B/BJbLbc"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336D22256E
	for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672680; cv=none; b=h8sk8mHCrIbH/3h4ZaDl0PlWJDVl8XwnZSGUqGiyjgmhx7WJgMhGoQKgfme/KWBJDxDX3SkbNaSeDk3qIPb4dikMc+SmUUtR3U4CRXCE5r+PiX9+kJ+sW0WTf9oSwdaVvv1KRJ/3LZTMpzvptOY9ubsmicpHjzIYDU26LK7BDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672680; c=relaxed/simple;
	bh=S+YHLgC0PFi0jJ56JKraJOSFAvaHuC6DfRzjdrQvsGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp48NNzGm/WKnl7TcYlUCSeIgbT+BY5m/vMjbP7yKbm8+9GQTkjlYJkUqsVUlSh45bWHt0XYYAUg+Ae7gkR7xV9lUEJWh1u45MjHp8Z743PsDim2C9iZACzsYjS2dZYHVeaskG5ck32wUKEsbmD5uLgjdF2TYkMV4xY5ZSjkwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=B/BJbLbc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so9817612a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741672678; x=1742277478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ3Ylp2OjaXtS6fzR0TsoJmAHcJDlyRDNWgqOmKMrZo=;
        b=B/BJbLbcW29XWsW8T2Ir3zkZSU/E5jwAr8ZWnfFZn5iY4W3rcfh3suvqoCYFpf+G/l
         rxgnyaYvTdW0CAvlfM/Y+W5In9YSR8q3jorncxq8A9Aa1EUWLjjG1LnX2M/G5iTnttvd
         G8Xm3SiRoR1SqyIwpgEmlX1RZlazd7VmKYPitP5FbVfjpt+12qOLvHmuy7UDzxe2PkKG
         rs0qTGQS20Ln70Zy/gQ3xnUUmYP2UerMYEw4wiWNYpnLjj4kY/9bf23jS0FLWTSMzJi4
         2g4lyu+BRKc7tfJhSIZRANuXAl1f/WuHGthakuQHiyhxG2zqMWGIIpAwylcZJCvv+vdN
         LNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741672678; x=1742277478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ3Ylp2OjaXtS6fzR0TsoJmAHcJDlyRDNWgqOmKMrZo=;
        b=HStHWeRhCDrQ4hDJvK3QMrEiyygTKkIWnTIJxfkZ1NbC+2rCNkpGmkMy4I0VLmRFh6
         VUVY2Vz7lE1dSC2TNyfzwJHdgdxf1cdx4FFVdBVE3mBdgE4DA4x0sCfD231+pLHL/DhG
         q8BeZQ3i/OWWl7FVvAc1ogDEaORsDW2+ODyl3VC3pLjZ0WP7hZbbhEePks9LP2euQD60
         GZ1Rdr88zOVwnUWoYWkil8Bg9N7cbGqOb53kVKT9TlG6AIr+ClTT4QcPIwtS5r3wHnzP
         KLTVQa9J5QnLFbGIqHOPhUpkRLNyzEnF5CYrlqAATL5NjV119iciQnEherW+ccxkyrro
         udqA==
X-Forwarded-Encrypted: i=1; AJvYcCVVr3qJrNmiQB2sec5YDsxHlt1fnllAswLGoiRRjctdr7/NaJ+5TAx2twbcvBU8L6od7n3cTiI5urISsYHeBzeWraBflfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2Cnbt3WjwBmRFfy+EOChRkyXGW9V3HrAD2Skq1IkvIYNqSAt
	VFPF8OC4w5prbeY+C+PzyKzOQHR54qvDEKcQYV7UuGyJxoK0Lo7FGdZpirJ80oc=
X-Gm-Gg: ASbGncuQdM+Rb9Qz/bU1FlBRNKIGaqNGtwfj87MGXe7BXNUzT45i+XceebU9zptyAdB
	lh3tPAG7dtV1ltbuAXpQ4DIVQY3udqOC8gATSAH0ltEObbN6D3S0Ao36U2BPQhARRKyv56Yr5hA
	9UdfC5e608cn40RYP7cEzWUEzuwgcWeyObOVxu7pYYQDjUIxphMZoTUrTinDRVWVZMLNcMQi3Tn
	3SmIONjm8LCkJgqp3Ve9SjDPUzl7zYVehvtSA8nd6mf/s75xssDN5HoC5NgtEhY9/jDXMO6lN37
	ZHcbSXoC2VMs8nAY8wo4Ht1KaMBwRa/fkNW9iSRrAzfdseoUGwq7BqFISpM1TITfD/u7EUlV32l
	YrRjYnQlxuZyqsI7VCmbBd4FqJTNAMwk=
X-Google-Smtp-Source: AGHT+IGPrCbxwl2OSgFwh3gJhjpQQN/SaQWtK58y8pWF0rp29q7pUWQU2Ula8asUjJl2pL9LR7SqKA==
X-Received: by 2002:a05:6a21:7a44:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-1f58fe38bacmr1664038637.3.1741672678005;
        Mon, 10 Mar 2025 22:57:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af51656af2fsm4545874a12.39.2025.03.10.22.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:57:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1trsck-0000000Bbs3-2QGD;
	Tue, 11 Mar 2025 16:57:54 +1100
Date: Tue, 11 Mar 2025 16:57:54 +1100
From: Dave Chinner <david@fromorbit.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: cve@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311021957.2887-1-demi@invisiblethingslab.com>

On Mon, Mar 10, 2025 at 10:19:57PM -0400, Demi Marie Obenour wrote:
> People have stuff to get done.  If you disallow unprivileged filesystem
> mounts, they will just use sudo (or equivalent) instead.

I am not advocating that we disallow mounting of untrusted devices.

> The problem is
> not that users are mounting untrusted filesystems.  The problem is that
> mounting untrusted filesystems is unsafe.

> Making untrusted filesystems safe to mount is the only solution that
> lets users do what they actually need to do. That means either actually
> fixing the filesystem code,

Yes, and the point I keep making is that we cannot provide that
guarantee from the kernel for existing filesystems. We cannot detect
all possible malicous tampering situations without cryptogrpahically
secure verification, and we can't generate full trust from nothing.

The typical desktop policy of "probe and automount any device that
is plugged in" prevents the user from examining the device to
determine if it contains what it is supposed to contain.  The user
is not given any opportunity to device if trust is warranted before
the kernel filesystem parser running in ring 0 is exposed to the
malicious image.

That's the fundamental policy problem we need to address: the user
and/or admin is not in control of their own security because
application developers and/or distro maintainers have decided they
should not have a choice.

In this situation, the choice of what to do *must* fall to the user,
but the argument for "filesystem corruption is a CVE-worthy bug" is
that the choice has been taken away from the user. That's what I'm
saying needs to change - the choice needs to be returned to the
user...

> or running it in a sufficiently tight
> sandbox that vulnerabilities in it are of too low importance to matter.
> libguestfs+FUSE is the most obvious way to do this, but the performance
> might not be enough for distros to turn it on.

Yes, I have advocated for that to be used for desktop mounts in the
past. Similarly, I have also advocated for liblinux + FUSE to be
used so that the kernel filesystem code is used but run from a
userspace context where the kernel cannot be compromised.

I have also advocated for user removable devices to be encrypted by
default. The act of the user unlocking the device automatically
marks it as trusted because undetectable malicious tampering is
highly unlikely.

I have also advocated for a device registry that records removable
device signatures and whether the user trusted them or not so that
they only need to be prompted once for any given removable device
they use.

There are *many* potential user-friendly solutions to the problem,
but they -all- lie in the domain of userspace applications and/or
policies. This is *not* a problem more or better code in the kernel
can solve.

Kees and Co keep telling us we should be making changes that make it
harder (or compeltely prevent) entire classes of vulnerabilities
from being exploited. Yet every time we suggest that a more secure
policy should be applied to automounting filesystems to prevent
system compromise on device hotplug, nobody seems to be willing to
put security first.

> For ext4 and F2FS, if there is a vulnerability that can be exploited by
> a malicious filesystem image, it is a verified boot bypass for Chrome OS
> and Android, respectively. Verified boot is a security boundary for
> both of them,

How does one maliciously corrupt the root filesystem on an Android
phone? How many security boundaries have to be violated before
an attacker can directly modify the physical storage underlying the
read-only system partition?

Again, if the attacker has device modification capability, why
would they bother trying to perform a complex filesystem
corruption attack during boot when they can simply modify what
runs on startup?

And is this a real attack vector that Android must defend against,
why isn't that device and filesystem image cryptographically signed
and verified at boot time to prevent such attacks? That will prevent
the entire class of malicious tampering exploits completely without
having to care about undiscovered filesystem bugs - that's a much
more robust solution from a verified boot and system security
perspective...

> so just forward syzbot reports to their respective
> security teams and let them do the jobs they are paid to do.

Security teams don't fix "syzbot bugs"; they are typically the
people that run syzbot instances. It's the developers who then
have to triage and fix the issues that are found, so that's who the
bug reports should go to (and do). And just because syzbot finds an
issue, that doesn't make it a security issue - all it is is another
bug found by another automated test suite that needs fixing.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

