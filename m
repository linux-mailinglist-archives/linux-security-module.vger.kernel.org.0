Return-Path: <linux-security-module+bounces-5962-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C57993B39
	for <lists+linux-security-module@lfdr.de>; Tue,  8 Oct 2024 01:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A83282CE5
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Oct 2024 23:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C018C908;
	Mon,  7 Oct 2024 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XTy8651F"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9017279E
	for <linux-security-module@vger.kernel.org>; Mon,  7 Oct 2024 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343991; cv=none; b=rsyV13K9VPkji0zMnRXylm6PZxm2Oz3iTfBzQyg10VpicOpWFr/tTySsU561rwGul+vee/zggaIAj1sjkBcRBvHHQb2+KrnIFCYnWtq41FYuOTJX2ma27e1bh9KuIAhagm2wrN0Eo+ooUc8ZzrM7+053TOi3cSS4aqOfwqmtXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343991; c=relaxed/simple;
	bh=uZyOq72YTuuw3ffWakWHM8yND6MYlGx+hjER/kBDCcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dES+LSr5N2PgEA4/BbAm5UvcNi1aQuQdgs5nmWErWMVTE+yWe1cNUAKsXL7SpGNDc0E5Wji4UdTTCX2LBIC9zAvdIvEdLqfLsqCShMLVkp9J41JLUGpcLQrAPRFX8oJbgxciwJC8GNuCuD2Q8a1anFet/uW57G67gbPDaIr3LxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XTy8651F; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71def8abc2fso2417184b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728343989; x=1728948789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Wf3UHlw4Drz/5keRrhtCUzSnlNTS+DtisJfx69hkA=;
        b=XTy8651FY+DgytSnxAITIM9uO3IbnFcC1ycxw+oz0aTA9u+Tf6JV5lqaFZVfIo1req
         U4+65Oj6yL+Mm0vWxWUVNqeiHWTREPpsy83RL2/b4arWeOG9pMjw27o6nPZiL0/j0r3G
         IJiTWAuGcUzGkSpm4yq3nG9SjTOQPQxtaSfKv5XsRK/jafdHMt8XRy4L/DqvwqrfYLQr
         rJ9wGZgI/2viMJTZskCYKYPefsa41++5Y6rbE4p0OMU3x5+bhF7xqhUhm/BcLMZmA+5Y
         Pro36WKKxwE6Yh6BijC9KAPSRLdlBgFpQjPKg9Ee76lOHgwgfmrswCjoKYFQPKfdGmJY
         hNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728343989; x=1728948789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7Wf3UHlw4Drz/5keRrhtCUzSnlNTS+DtisJfx69hkA=;
        b=o8QXK8+jk4SGYAQdNvNk17vBc6haflENp+cRCPwA8NnEMBVogHUz1IdSKMtQr3OJAW
         9IZGLGMfouo4S3f0WP2mxz4fgKj8vsiJYyd2JkcD2wQ0d8K1GrT6dHwTIYzbCXl0y7ja
         rUl0YYJJOPjuYfPlYTjzDSclqtOPPxcK07HfXVRwa36f7YS4OpswRVNuYYoenHSE+aXi
         Awj7JdXRMhBFNfeWY7RJUQqga43leOx63eH/vrH0+EokKFXxV0nMakVqB9LOy2GJESi0
         xsCaMZproKrKL72H2YNeHDstXVNo4BpQbLV5d8+s33ZWxPqKYRqenGmXXn04N1gTiN8+
         FHGA==
X-Forwarded-Encrypted: i=1; AJvYcCVMREjlRtuJyK1Jjk4Y0h2IiClOg2jhMmkanPpze8GVSDj1Gvl8bFJI8YtrqhdfnLzWLCzBGjHyBWmL/6cm3xq21D8Stb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyU+UooL9CYOFTKK1HCiG6M9EhYGqg217zOKVi64aBfUMBNFYM
	qpyw/GNf87V1oX0Pp/l4rxl2C3m9N9A00piBr9p5cykIJJRgVn1UKU1z1Gwb3uU=
X-Google-Smtp-Source: AGHT+IER5PqcwR//jDK3BmBwj4wfmKu+7fqXcUXxdnmaJPpWSfnE/Q0vsZk4Z4zAT+RYENnsbJgH4Q==
X-Received: by 2002:a05:6a00:190b:b0:71e:108e:9c12 with SMTP id d2e1a72fcca58-71e108e9d83mr1986607b3a.7.1728343989144;
        Mon, 07 Oct 2024 16:33:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66475sm5143959b3a.149.2024.10.07.16.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:33:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sxxDu-00FM8g-0W;
	Tue, 08 Oct 2024 10:33:06 +1100
Date: Tue, 8 Oct 2024 10:33:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <ZwRvshM65rxXTwxd@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>

On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> >
> > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > I'd wait with that convertion until this series lands.
> 
> Honza, I looked at this a bit more, particularly with an eye of "what
> happens if we just end up making the inode lifetimes subject to the
> dentry lifetimes" as suggested by Dave elsewhere.

....

> which makes the fsnotify_inode_delete() happen when the inode is
> removed from the dentry.

There may be other inode references being held that make
the inode live longer than the dentry cache. When should the
fsnotify marks be removed from the inode in that case? Do they need
to remain until, e.g, writeback completes?

> Then at umount time, the dentry shrinking will deal with all live
> dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> just the root dentry inodes?

I don't think even that is necessary, because
shrink_dcache_for_umount() drops the sb->s_root dentry after
trimming the dentry tree. Hence the dcache drop would cleanup all
inode references, roots included.

> Wouldn't that make things much cleaner, and remove at least *one* odd
> use of the nasty s_inodes list?

Yes, it would, but someone who knows exactly when the fsnotify
marks can be removed needs to chime in here...

> I have this feeling that maybe we can just remove the other users too
> using similar models. I think the LSM layer use (in landlock) is bogus
> for exactly the same reason - there's really no reason to keep things
> around for a random cached inode without a dentry.

Perhaps, but I'm not sure what the landlock code is actually trying
to do. It seems to be trying to avoid races between syscalls
releasing inode references and unmount calling security_sb_delete()
to clean up inode references that it has leaked. This implies that
it's not a) tracking inodes itself, and b) not cleaning up internal
state early enough in unmount.

Hence, to me, the lifecycle and reference counting of inode related
objects in landlock doesn't seem quite right, and the use of the
security_sb_delete() callout appears to be papering over an internal
lifecycle issue.

I'd love to get rid of it altogether.

> And I wonder if the quota code (which uses the s_inodes list to enable
> quotas on already mounted filesystems) could for all the same reasons
> just walk the dentry tree instead (and remove_dquot_ref similarly
> could just remove it at dentry_unlink_inode() time)?

I don't think that will work because we have to be able to modify
quota in evict() processing. This is especially true for unlinked
inodes being evicted from cache, but also the dquots need to stay
attached until writeback completes.

Hence I don't think we can remove the quota refs from the inode
before we call iput_final(), and so I think quotaoff (at least)
still needs to iterate inodes...

> It really feels like most (all?) of the s_inode list users are
> basically historical, and shouldn't use that list at all. And there
> aren't _that_ many of them. I think Dave was right in just saying that
> this list should go away entirely (or was it somebody else who made
> that comment?)

Yeah, I said that it should go away entirely.

My view of this whole s_inodes list is that subsystems that are
taking references to inodes *must* track or manage the references to
the inodes themselves.

The canonical example is the VFS itself: evict_inodes() doesn't need
to iterate s_inodes at all. It can walk the inode LRU to purge all
the unreferenced cached inodes from memory. iput_final() guarantees
that all unreferenced inodes are either put on the LRU or torn down
immediately.

Hence I think that it is a poor architectural decision to require
superblock teardown to clean up inode references random subsystems
have *leaked* to prevent UAFs.  It forces the sb to track all
inodes whether the VFS actually needs to track them or not.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

