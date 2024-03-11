Return-Path: <linux-security-module+bounces-2029-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742C878A96
	for <lists+linux-security-module@lfdr.de>; Mon, 11 Mar 2024 23:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A19D1F22051
	for <lists+linux-security-module@lfdr.de>; Mon, 11 Mar 2024 22:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CDC4206B;
	Mon, 11 Mar 2024 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RTqI2Z48"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A75822B
	for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195154; cv=none; b=DP4W1ETpGfjiPRzRZV6S2xRj/mZqTr7c3WN9O7VGIYrWBo/UtmEPEUIS8ihLZklFRG/J0omTOyLiMxwNGDubZRAbnbOBwS0tXHBSFTiqWGm/xuTGHQrn7YS50OHTePAj2VxBLX1BdrXBxmY2Bx2NXE1EQlekQuATx6BU6pQJsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195154; c=relaxed/simple;
	bh=osu0hSiORSyIZpQ3dd416kqvq4IzeIB1wejEPaBnlik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrnzPDTkFZ3D9es+aFwhmp8JyRM2Ev8VeVxA5qfaJwBMV0tFOrtp042pJkOgdkQQcA8ZhVWXpix2vxlRNcCDNf3eHTOqgJq3L6wtakOHY2aqhGNAR5Mpe4PsGHGHGKr8LlSi46CsASmtfZvdacg3+fHeI8jpDPGNirNSOY/ieys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RTqI2Z48; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e622b46f45so2761701b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2024 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710195152; x=1710799952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQPLox6coVczJgg0u74CQV/by37pFi2dP23Pejr0Xzo=;
        b=RTqI2Z48fG/ip5+diNjwq/s+3flD3Zi1Ba+u6B9tUK0U+f4YOtQqVKNXihqAaU7YVl
         fw8qBk9pLqzudm4ajH6kL0u5vMvZfo01/pfQZDlGAtNgNzqF7ZjOQi4v4/bL3jjagXIa
         nzNr8hJmnq3HLf61AAfpVz5bnPmE53Fg26iM8FfPEY/enQ+dGUfXmSYO4jkzCE6aHebo
         zeQ0svAsR2kLl3PfLYvIduGP6lc4969a/lM4ogyClF0btiv0gNaIU9Sa45r7hM38OzR3
         1P+q62gsHyXyQv+v+WZL0uUoSn8HkjR3b68xKKeJDkXb1bhNfEzOsuyDKkINae9rwcqU
         YMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710195152; x=1710799952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQPLox6coVczJgg0u74CQV/by37pFi2dP23Pejr0Xzo=;
        b=E80popbUwFskgNK/NQgnaGW1lEXe2tH1X1SAyZoyJbnILnMC+0yug5LN+bDma1VfjQ
         rerjrIZomVvlhp0Ks2jjeZVwY67HYeTHeilwNeh29s2hKauCndgX7EYcd3NVx8WrwoZe
         K7e23joZH4/RvE/QAHK/nEUhgtbfj4cRl/nXXz0H8hFBbd906D3V7AHd8RIyzu5fjTEj
         FuOO88bb7T+K4tbhDTDiI1bC/FWiBzR5gdQ3X/SUDSQcAe0W7749/9CoWZP6+WdTphJP
         ECe2tvB3hSYpauTTz+cmX7eSLoTMKQgT0Xji+RNUtA7iECUNAt8uXXFHQ1FpFsPyQe5+
         dUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkMjzhJwAvakyRw4EGRmx+R74TTypgjvlDewmVLtlLi8bg+kfcfWIfg+aDNaUc9+zsGtNzR+7drP3am4HQBDWyuGZTJM+BDlC4DYCe7LhsxyPntMF
X-Gm-Message-State: AOJu0Yy+5BoEIKdM9fBEjSyCchZi5BfPRfNSpwkcpUf711LhZ0pvS3gp
	Z/lZ8z/Vi1V60a3yQ9zsvCacXzJNpzSTeeMM1m51eRqUbqlm72aiMGzUxFeKgaQ=
X-Google-Smtp-Source: AGHT+IHsPrYogruVW4mJKMDgJ2q1LIJp88fe4SdPPockPPpcW/D/vyRq0hbPBBvNUvbjpoP/PYjXNg==
X-Received: by 2002:a05:6a20:748c:b0:19e:ac58:7b0d with SMTP id p12-20020a056a20748c00b0019eac587b0dmr5917598pzd.5.1710195152095;
        Mon, 11 Mar 2024 15:12:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id a14-20020a62d40e000000b006e6629e6a76sm5055702pfh.137.2024.03.11.15.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:12:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjnsi-000dQB-1R;
	Tue, 12 Mar 2024 09:12:28 +1100
Date: Tue, 12 Mar 2024 09:12:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <Ze+BzMyBp1vRIDKv@dread.disaster.area>
References: <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <ZervrVoHfZzAYZy4@google.com>
 <Ze5YUUUQqaZsPjql@dread.disaster.area>
 <Ze7IbSKzvCYRl2Ox@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze7IbSKzvCYRl2Ox@google.com>

On Mon, Mar 11, 2024 at 10:01:33AM +0100, G�nther Noack wrote:
> On Mon, Mar 11, 2024 at 12:03:13PM +1100, Dave Chinner wrote:
> > On Fri, Mar 08, 2024 at 12:03:01PM +0100, G�nther Noack wrote:
> > > On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > > > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > > > "safe" clearly means something different here.
> > > > 
> > > > That was my problem with the first version as well, but I think
> > > > drawing the line between "implemented in fs/ioctl.c" and
> > > > "implemented in a random device driver fops->unlock_ioctl()"
> > > > seems like a more helpful definition.
> > > 
> > > Yes, sorry for the confusion - that is exactly what I meant to say with "safe".:
> > > 
> > > Those are the IOCTL commands implemented in fs/ioctl.c which do not go through
> > > f_ops->unlocked_ioctl (or the compat equivalent).
> > 
> > Which means all the ioctls we wrequire for to manage filesystems are
> > going to be considered "unsafe" and barred, yes?
> > 
> > That means you'll break basic commands like 'xfs_info' that tell you
> > the configuration of the filesystem. It will prevent things like
> > online growing and shrinking, online defrag, fstrim, online
> > scrubbing and repair, etc will not worki anymore. It will break
> > backup utilities like xfsdump, and break -all- the device management
> > of btrfs and bcachefs filesystems.
> > 
> > Further, all the setup and management of -VFS functionality- like
> > fsverity and fscrypt is actually done at the filesystem level (i.e
> > through ->unlocked_ioctl, no do_vfs_ioctl()) so those are all going
> > to get broken as well despite them being "vfs features".
> > 
> > Hence from a filesystem perspective, this is a fundamentally
> > unworkable definition of "safe".
> 
> As discussed further up in this thread[1], we want to only apply the IOCTL
> command filtering to block and character devices.  I think this should resolve
> your concerns about file system specific IOCTLs?  This is implemented in patch
> V10 going forward[2].

I think you misunderstand. I used filesystem ioctls as an obvious
counter argument to this "VFS-only ioctls are safe" proposal to show
that it fundamentally breaks core filesystem boot and management
interfaces. Operations to prepare filesystems for mount may require
block device ioctls to be run. i.e. block device ioctls are required
core boot and management interfaces.

Disallowing ioctls on block devices will break udev rules that set
up block devices on kernel device instantiation events. It will
break partitioning tools that need to read/modify/rescan the
partition table. This will prevent discard, block zeroing and
*secure erase* operations. It may prevent libblkid from reporting
optimal device IO parameters to filesystem utilities like mkfs. You
won't be able to mark block devices as read only.  Management of
zoned block devices will be impossible.

Then stuff like DM and MD devices (e.g. LVM, RAID, etc) simply won't
appear on the system because they can't be scanned, configured,
assembled, etc.

And so on.

The fundamental fact is that system critical block device ioctls are
implemented by generic infrastructure below the VFS layer. They have
their own generic ioctl layer - blkdev_ioctl() is equivalent of
do_vfs_ioctl() for the block layer.  But if we cut off everything
below ->unlocked_ioctl() at the VFS, then we simply can't run any
of these generic block device ioctls.

As I said: this proposal is fundamentally unworkable without
extensive white- and black-listing of individual ioctls in the
security policies. That's not really a viable situation, because
we're going to change code and hence likely silently break those
security policy lists regularly....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

