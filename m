Return-Path: <linux-security-module+bounces-350-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3615807D68
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 01:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B319281AB2
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B4ED7
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="X/AC4GTb"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F019A0
	for <linux-security-module@vger.kernel.org>; Wed,  6 Dec 2023 15:04:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c66418decaso202495a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 Dec 2023 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701903899; x=1702508699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HI6nSYbxQkTs8xlGNUbdTpMvMqVQhr8L/otXNNzVlQ4=;
        b=X/AC4GTbE3uhVxgQIQxC1dZXACc/OGrorhCehU5kixCH34it2DuWkcVgoDdknM25Z+
         VsE4BQEyDiPND6y6ZDxxTvlG4uwvnY20AkE7yvfyRejcIyhmcH64gllXifMdAhxSBckC
         bqA+sDP0qzq2wBC+ucwwcQj6DrNfjzGLRJQAZfu5fEfgiaL3xieEul6oAmsg4c0WHF+W
         FsxKhxYWtpfdT0v+jEcYmVjggvHHl08G0YD8h60idaFELR7qG4yDNBCMh4Sztf2COXrZ
         4TFFn9dDy+4/ypxzScwYlG1sg08pCgaQAZhZ7n+BuljuE0ZR/INQMs2guKUic0A2prDz
         A3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903899; x=1702508699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI6nSYbxQkTs8xlGNUbdTpMvMqVQhr8L/otXNNzVlQ4=;
        b=s0WlFCkYAIttAYcTisx6Oa581WSm4vAj9h9jVGPiwYuMfk3fZthfOJlHxngYeGX4c9
         jXGbGJjQXyoJY6dqM5db4x2pCQp0ENrJ3f3Soc142mWBig9oSSj6DXRmfJ2YSbf7A9QO
         fK8Z0IFOUFEnjHrqLKQFfyvTS8MVog3ikd8NK/mDKENPFug42FcXAbHbc0UQqOTbaMNH
         /ZT9cxNaK4Am5l+mkViwn8k2hYcnJpliTOOEPYPH8iCHZmC8Cy3DsX3R02BkC09ekWUM
         3k+E0e1hBvJbY3I0BrSn4b3ONljyHS2munk/ugGSHA9UagDza+8zwPcXyZTtrocHxeCv
         b9Hg==
X-Gm-Message-State: AOJu0Yyf6KexBxXJpGtTEHyx8grC2prGDU15DpgrX8BEbTh+T2wIl7PF
	QwagI7Ts69A8IzajZM14k6hDmQ==
X-Google-Smtp-Source: AGHT+IGtV8O0jKV+PArM/vMQoTwS1VwmuVzmwzYgDqA70uTeS8V1FVVZ04FDi0IUF605HhQUM9Ny9w==
X-Received: by 2002:a17:90a:dc13:b0:286:6cc0:b910 with SMTP id i19-20020a17090adc1300b002866cc0b910mr1289456pjv.71.1701903898922;
        Wed, 06 Dec 2023 15:04:58 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001d0ca40157bsm326478plb.260.2023.12.06.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:04:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rB0wp-004p7R-2v;
	Thu, 07 Dec 2023 10:04:55 +1100
Date: Thu, 7 Dec 2023 10:04:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] selinux: use dlist for isec inode list
Message-ID: <ZXD+F5N/3PPSGTya@dread.disaster.area>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-6-david@fromorbit.com>
 <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>

On Wed, Dec 06, 2023 at 04:52:42PM -0500, Paul Moore wrote:
> On Wed, Dec 6, 2023 at 1:07 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Because it's a horrible point of lock contention under heavily
> > concurrent directory traversals...
> >
> >   - 12.14% d_instantiate
> >      - 12.06% security_d_instantiate
> >         - 12.13% selinux_d_instantiate
> >            - 12.16% inode_doinit_with_dentry
> >               - 15.45% _raw_spin_lock
> >                  - do_raw_spin_lock
> >                       14.68% __pv_queued_spin_lock_slowpath
> >
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  include/linux/dlock-list.h        |  9 ++++
> >  security/selinux/hooks.c          | 72 +++++++++++++++----------------
> >  security/selinux/include/objsec.h |  6 +--
> >  3 files changed, 47 insertions(+), 40 deletions(-)
> 
> In the cover letter you talk about testing, but I didn't see any
> mention of testing with SELinux enabled.  Given the lock contention
> stats in the description above I'm going to assume you did test this
> and pass along my ACK, but if you haven't tested the changes below
> please do before sending this anywhere important.

AFAIA, I've been testing with selinux enabled - I'm trying to run
these tests in an environment as close to typical production systems
as possible and that means selinux needs to be enabled.

As such, all the fstests and perf testing has been done with selinux
in permissive mode using "-o context=system_u:object_r:root_t:s0" as
the default context for the mount.

I see this sort of thing in the profiles:

- 87.13% path_lookupat
   - 86.46% walk_component
      - 84.20% lookup_slow
	 - 84.05% __lookup_slow
	    - 80.81% xfs_vn_lookup
	       - 77.84% xfs_lookup
....
	       - 2.91% d_splice_alias
		  - 1.52% security_d_instantiate
		     - 1.50% selinux_d_instantiate
			- 1.47% inode_doinit_with_dentry
			   - 0.83% inode_doinit_use_xattr
				0.52% __vfs_getxattr

Which tells me that selinux is definitely doing -something- on every
inode being instantiated, so I'm pretty sure the security and
selinux paths are getting exercised...

> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com

