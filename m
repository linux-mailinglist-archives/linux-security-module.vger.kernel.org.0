Return-Path: <linux-security-module+bounces-1999-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94746877962
	for <lists+linux-security-module@lfdr.de>; Mon, 11 Mar 2024 02:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A3428152B
	for <lists+linux-security-module@lfdr.de>; Mon, 11 Mar 2024 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05974622;
	Mon, 11 Mar 2024 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bfBxIIZ7"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646A7EC
	for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2024 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710118998; cv=none; b=Zqv/V//S0VD/xpBsawSK/Ez9ybdMEjZM87dYpeFYDjFIlVuWhw1KL1ljIDquemq2U1Yns+QR3ZKl/dl7b8FlwFT7CzGG4MtCVk1ZnigOnE8x9hr6YGjuOdJUJjQs8d/dgnMxdOHnAw5V9nu6ru94dgekLJrWGLNJGtbwIT8MvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710118998; c=relaxed/simple;
	bh=bTkYO6hpD+ws1aCivbIeq/S/RfBZgTdP0CbxFKJAUg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcY7hMYxJTpUAy2y9SzZm7r671CrcpMHm2Q8teJtr/xQosQU9y8IzmBJySL1WGMXPq/XGMamPq+VX1UKB0U10FgQgVCtLhxM1mec9GfXRHOo7cVCNyg/+yz81115UFz1OwFpLUzYDnBmD+PcVEz8rWJd0gDF/lN1qFyqdCgbqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bfBxIIZ7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd59b95677so17488155ad.1
        for <linux-security-module@vger.kernel.org>; Sun, 10 Mar 2024 18:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710118997; x=1710723797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tb2TjIjGy7NO9Sxv5dfmBqswYG9vWza5A0iKXG81thU=;
        b=bfBxIIZ7MvlZ3izZbMEcHmyPkXD8WUE696hx8vQBkQQhtv5uxQjZRsTANeGzePS3DD
         QZQnXj77uAFenaoVxHGIbrs75rPbqQYRWiVfVfAB7luZ6MiGqhpvsTNsxAHNPeTWg2Oy
         +EokU+NrlTniimyFx/OFoTd9cD0RrgSNO2foNbQ5vBEnxXwWDsk3/NwZ6dFg0ul6cKLj
         lnmEzyG9agLaF0um1jWFBN4cw+QfAsch7DuYrCJF/Y40utPPlRkITHrOsZ+mOxCdUVS4
         wQMNANlDdsrb4741b5IuHjtW5qhjU76wbQ695/HmdgjAvsdGm2LNbfwF22OMQgfe2p6V
         05mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710118997; x=1710723797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb2TjIjGy7NO9Sxv5dfmBqswYG9vWza5A0iKXG81thU=;
        b=mg8S4cICK9BMivahusbXUc9vvNQOGe6/31CywE6H8MWV4MYokuFQnidXEbpbSvi5Bz
         XRq3H/dFNEmBjjZ6dmlOBlJeFrmFjsUq71nNoCdaUEBsOWi6edvBSpk28qvWu42f78jt
         2OlvK+pmiyk+BS+8X50+gjxiklNQ4uQXNUezExfEsNE3tPJB+LLU5S/qlwi6lA0mlPWE
         s+QfTS/g02QUY5E56VCwwtLh8pBS8cGX4+7DmSEv+iWQvCJAI9Xa9GK8b+NnEYxFrR7m
         3Zi/82UZ68tGRyP5XmyuNLGJ7mAqmI4KzxWzEMoMKiQnm0IwSBOdhDyubWo2ccP3jaeA
         P53Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3e0k8rxzFPBLCjwZm37uivIGtXPiydUJuoXTKHoLglKwhzfkX6a4rOQ8H81g9a+nzkA4uLLNcKoJjfyRMVNHwuj54d/WsGSkuHtmYQPIKkLpcAEjj
X-Gm-Message-State: AOJu0Yx1CCM9frZ1c3ZSNwa0B+fsOSLMB31iNAAQOpJMvbNy6Ae7zTn6
	X02trx1FO2Ji4WMMprpoSi3yDfLzMRcpZ47kuFZX1Hp2xGD+tek3N6FRjFLtcIc=
X-Google-Smtp-Source: AGHT+IHVMeGaLNgIl7cGC9cLhsHQQ9Vb1MhzR7xJX9IC8luYpveLWgo56KwgaJD1/3iikbO5Rs1wWQ==
X-Received: by 2002:a17:902:b782:b0:1dc:b063:34ac with SMTP id e2-20020a170902b78200b001dcb06334acmr4224505pls.21.1710118996512;
        Sun, 10 Mar 2024 18:03:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id ks13-20020a170903084d00b001dcfc88ccf6sm3314847plb.263.2024.03.10.18.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 18:03:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjU4P-000Esf-1n;
	Mon, 11 Mar 2024 12:03:13 +1100
Date: Mon, 11 Mar 2024 12:03:13 +1100
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
Message-ID: <Ze5YUUUQqaZsPjql@dread.disaster.area>
References: <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <ZervrVoHfZzAYZy4@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZervrVoHfZzAYZy4@google.com>

On Fri, Mar 08, 2024 at 12:03:01PM +0100, Günther Noack wrote:
> On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> > >> On Thu, Mar 7, 2024 at 7:57 AM Günther Noack <gnoack@google.com> wrote:
> > >> I need some more convincing as to why we need to introduce these new
> > >> hooks, or even the vfs_masked_device_ioctl() classifier as originally
> > >> proposed at the top of this thread.  I believe I understand why
> > >> Landlock wants this, but I worry that we all might have different
> > >> definitions of a "safe" ioctl list, and encoding a definition into the
> > >> LSM hooks seems like a bad idea to me.
> > >
> > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > "safe" clearly means something different here.
> > 
> > That was my problem with the first version as well, but I think
> > drawing the line between "implemented in fs/ioctl.c" and
> > "implemented in a random device driver fops->unlock_ioctl()"
> > seems like a more helpful definition.
> 
> Yes, sorry for the confusion - that is exactly what I meant to say with "safe".:
> 
> Those are the IOCTL commands implemented in fs/ioctl.c which do not go through
> f_ops->unlocked_ioctl (or the compat equivalent).

Which means all the ioctls we wrequire for to manage filesystems are
going to be considered "unsafe" and barred, yes?

That means you'll break basic commands like 'xfs_info' that tell you
the configuration of the filesystem. It will prevent things like
online growing and shrinking, online defrag, fstrim, online
scrubbing and repair, etc will not worki anymore. It will break
backup utilities like xfsdump, and break -all- the device management
of btrfs and bcachefs filesystems.

Further, all the setup and management of -VFS functionality- like
fsverity and fscrypt is actually done at the filesystem level (i.e
through ->unlocked_ioctl, no do_vfs_ioctl()) so those are all going
to get broken as well despite them being "vfs features".

Hence from a filesystem perspective, this is a fundamentally
unworkable definition of "safe".

> We want to give people a way with Landlock so that they can restrict the use of
> device-driver implemented IOCTLs, but where they can keep using the bulk of
> more harmless IOCTLs in fs/ioctl.c.

Hah! There's plenty of "harm" that can be done through those ioctls.
It's the entry point for things like filesystem freeze/thaw, FIEMAP
(returns physical data location information), file cloning,
deduplication and per-inode feature manipulation. Lots of this stuff
is under CAP_SYS_ADMIN because they aren't safe for to be exposed to
general users...

So, yeah, I don't think this definition of "safe" is actually useful
in any way. It's arbitrary, and will require both widespread
whitelisting of ioctls to maintain a useful working system and
widespread blacklisting to create a secure system....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

