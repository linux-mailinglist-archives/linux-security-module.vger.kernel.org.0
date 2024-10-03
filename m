Return-Path: <linux-security-module+bounces-5844-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC498F0E9
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Oct 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196C71C20D85
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Oct 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3619CC1E;
	Thu,  3 Oct 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AnXCVhWQ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CA199936
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963997; cv=none; b=mhSp++JkCLzDQbA1tdVzzRramdWknFiSp2/tTEXNz2Ol5lvN/MvH4JIcNeLUMavE2J/Gun0HQ4x6g22Gn4ohMRIitT4wZLlRbsLafdpnNv6EZh8HPIjkZNfRp0nAuMWMeUYfgWJLQ5B5OtAYVw0QJN8gyQTnUz9HWurMpD4sqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963997; c=relaxed/simple;
	bh=/GY97la4i2PwIWy0iIsbya23bsPGem6iIVV4si/yakE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ7WMT2mtXHe1FoRk1KphdiFUej9zn9DHwiFzAqWAVeNz7AGupPRGvSPwcqyJIfZRujACl6KL1ykzd4gWKgUz77ncWhtpFCufppJKjDVKRDXSN3rTq705E8Hk3hYek2N08s/ubmte+VwHU04ZFMJedt6TIMOl4vdItdM52w0Okg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AnXCVhWQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b8be13cb1so10037505ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 03 Oct 2024 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727963994; x=1728568794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmRpFtIEUnAPcCvGtolN/zuYY1/DXFySJU38BvrsdOA=;
        b=AnXCVhWQViPu07BTXNW+aCpCFQWc5qVtAdvebzu1n4jSZIKrFSjf0tDODz76CX50Bs
         wTmhfakk1tjxJ30cclmXhG903qWnPndlJ+bVe5w+cSGx3DmiUPrCEjNdIrKR8gVDkUYz
         ItPKvXkstKaZpCOefZ7IVwHI0NljP+U1M6KN3Z4qxzcgy0zJd1tnZUrQ6gfkzt9k7ayU
         z/HBPlza0GMZH+KqLuDIbdTdtj9eKTGe1Tje1JDKtgEIHzanwBczMKEyj/pftvBVvvfY
         sybe3J+BmJftlZN4ooHLVCT/cr84aJDx3nfFG5C4yQXuIOtX9f7qrFLpMzsym2n+sHJr
         xhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963994; x=1728568794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmRpFtIEUnAPcCvGtolN/zuYY1/DXFySJU38BvrsdOA=;
        b=QfXOnZgZG3evZlxIHZHzj6sQKTV0XO9eiRHrnABIOdicHtqEIVQaeTH4a5suiDKZpu
         qXeTkFSXXn86V5789TAy40fMrxBLYmZtlBVjA6NMAP3lI4XNlYTPL6Uw+9Qdf4D7lWrF
         YbqVWdDrtSoK7zN8FJDBh0tgNnlmbOxk8W09tmxWDha2PYc0iBIN7sWITohPr44D5noH
         re2QrY1Gt4KRz8Yq3m9OYmgAfM8ZRMI5bc+tQW3KY5R2q8OrsemUhCD8xfrC90O9JbdZ
         nj6yj96KdbI0GgUgy54B5eopqTn2RYTV0tPdixWWe21xy7Fl9e28/kgY1GShPIeOz+7F
         D8VA==
X-Forwarded-Encrypted: i=1; AJvYcCVpKzjXJ9oAAUAVQVK3/pTooDWn/y28qnibAgqYxYQ5Km1yR/v6emXQrVcvQ94dfkPK4gqrSee8ICn4c84w3Z8wEfskS0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgoDnexNtf4Ok6HPX2xDNG+DWgwxFfPIGCbQLuskRGFRTrDVw
	+sGPfhkF/x+aM2aupHQqpYNfPvdtPOZoe6lRYYz4NX025ABH8ZNQnB0DvH3+C0E=
X-Google-Smtp-Source: AGHT+IG8lHaZybqgl6le6NzHHM4A1D/zJK9kM3E8fOqfXDDRiBLohY8zPhDvnGuyUfyPs9j8ungW0Q==
X-Received: by 2002:a17:902:d50d:b0:20b:9c7d:fe0c with SMTP id d9443c01a7336-20bc59c38fbmr106591155ad.7.1727963994363;
        Thu, 03 Oct 2024 06:59:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef70712esm9210965ad.265.2024.10.03.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:59:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swMMx-00DPdE-1F;
	Thu, 03 Oct 2024 23:59:51 +1000
Date: Thu, 3 Oct 2024 23:59:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <Zv6jV40xKIJYuePA@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003125650.jtkqezmtnzfoysb2@quack3>

On Thu, Oct 03, 2024 at 02:56:50PM +0200, Jan Kara wrote:
> On Thu 03-10-24 05:39:23, Christoph Hellwig wrote:
> > @@ -789,11 +789,23 @@ static bool dispose_list(struct list_head *head)
> >   */
> >  static int evict_inode_fn(struct inode *inode, void *data)
> >  {
> > +	struct super_block *sb = inode->i_sb;
> >  	struct list_head *dispose = data;
> > +	bool post_unmount = !(sb->s_flags & SB_ACTIVE);
> >  
> >  	spin_lock(&inode->i_lock);
> > -	if (atomic_read(&inode->i_count) ||
> > -	    (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
> > +	if (atomic_read(&inode->i_count)) {
> > +		spin_unlock(&inode->i_lock);
> > +
> > +		/* for each watch, send FS_UNMOUNT and then remove it */
> > +		if (post_unmount && fsnotify_sb_info(sb)) {
> > +			fsnotify_inode(inode, FS_UNMOUNT);
> > +			fsnotify_inode_delete(inode);
> > +		}
> 
> This will not work because you are in unsafe iterator holding
> sb->s_inode_list_lock. To be able to call into fsnotify, you need to do the
> iget / iput dance and releasing of s_inode_list_lock which does not work
> when a filesystem has its own inodes iterator AFAICT... That's why I've
> called it a layering violation.

The whole point of the iget/iput dance is to stabilise the
s_inodes list iteration whilst it is unlocked - the actual fsnotify
calls don't need an inode reference to work correctly.

IOWs, we don't need to run the fsnotify stuff right here - we can
defer that like we do with the dispose list for all the inodes we
mark as I_FREEING here.

So if we pass a structure:

struct evict_inode_args {
	struct list_head	dispose;
	struct list_head	fsnotify;
};

If we use __iget() instead of requiring an inode state flag to keep
the inode off the LRU for the fsnotify cleanup, then the code
fragment above becomes:

	if (atomic_read(&inode->i_count)) {
		if (post_unmount && fsnotify_sb_info(sb)) {
			__iget(inode);
			inode_lru_list_del(inode);
			spin_unlock(&inode->i_lock);
			list_add(&inode->i_lru, &args->fsnotify);
		}
		return INO_ITER_DONE;
	}

And then once we return to evict_inodes(), we do this:

	while (!list_empty(args->fsnotify)) {
		struct inode *inode

		inode = list_first_entry(head, struct inode, i_lru);
                list_del_init(&inode->i_lru);

		fsnotify_inode(inode, FS_UNMOUNT);
		fsnotify_inode_delete(inode);
		iput(inode);
		cond_resched();
	}

And so now all the fsnotify cleanup is done outside the traversal in
one large batch from evict_inodes().

As for the landlock code, I think it needs to have it's own internal
tracking mechanism and not search the sb inode list for inodes that
it holds references to. LSM cleanup should be run before before we
get to tearing down the inode cache, not after....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

