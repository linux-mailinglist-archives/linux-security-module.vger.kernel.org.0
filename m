Return-Path: <linux-security-module+bounces-6229-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181BC9A2E6A
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Oct 2024 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB523284152
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Oct 2024 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166421E0DF4;
	Thu, 17 Oct 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L/BUWMkn"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC621D097F
	for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196512; cv=none; b=J661yW6gZayreDA8YLGNGJ9HrKkJraX3PKEhAjNMgHXFwmzhhIuTEvl1uNYCke2RaQeCfDrM9XXKozKdTLEeIulBWK9LIuvZHJiI2mK34g/aCttMHmWtIVwOA3va9UoZCyJ4ptth/G0evGw2yuFU7dDPayDwcEvlQv1QTreojXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196512; c=relaxed/simple;
	bh=2Z5WKoLPYT+lT5L20jzLpq8I6hZFsPuZELk5THlcVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=da4wlxiWnj/hufAUl5n9T3lk7D66MZecBq6RU3s9jrGbEnqziihT0MSI/hlFIWqZud9074CBBcV8nlY/ZPnn5melORnUDlhKvHiFTT3auskExRBuMk/9Mbs5qIX5R5yzci1jfXCxFgeWjUTqNqv9IVyDd4kTThoNyniN8cCP/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L/BUWMkn; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28833f1c31so2139924276.1
        for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2024 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729196506; x=1729801306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkT9XPOVz4nESR8taQmQTNvM14toSm1aIM8trf17CDA=;
        b=L/BUWMknNZmilGvb7bqBhmlu4PQv2K5I4RqEgEw4syBgh037dj/0qGVVnI9Qix3FMc
         U8rxqujESY4UpZa+GOM/LpnVxAhF7yD0WrPYDm85Auq1/hNbQjuuAElmB//hcnpb8y1f
         h6mFwMFK30JTCeUV5IHpRBXf2dqukUBq+USdkl0HI0zb1mkoQzXX258TPGELRKbWYUSE
         FZ5kqqVp74xzn7fLtN61tYN1/872cdm5O4mgIEue9yBn4HxHpsI3XId+agGRqpZiX1bJ
         n0YVWlzUz4e6RxRIdzFppMALZOow3m2abWQIQsCG/hqH4TqBkimWwQLw5+qdpo8YtJMx
         c2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196506; x=1729801306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkT9XPOVz4nESR8taQmQTNvM14toSm1aIM8trf17CDA=;
        b=UH/ddpWKnEoBZTslh6llwLYJX0pkwL5vhsMgPhBKKqseivOB5iU6fjDS87YJwMA75v
         L6BrqP2y5pfsHUUzozqszz357OLT0BZ+I7gEJtkgCJNwTjt0wInDFtq/INM3wW/YCZds
         DUIQc58OcGc6mFPzUhcco8pxcpCn6NwKy89k/jpv4eWeJkWB/xs6KVmyhDs265b6Rfwb
         OASGL3yW7tnB2POI2wDRY8f2Q9h95e1jjcLSPSWOzpuDRjyY+uorB8cWZCRorINZpxCU
         fDPmBt6FAwcqYNN5Y9t3C4atldZ0dDaSOUhCln1HwVVjmRafGLWEBQyWULoor0CH4jjM
         OG8g==
X-Forwarded-Encrypted: i=1; AJvYcCWCkYFHVEfhg3PjphRnO89MMrOU5ER1d/x9xjoeiRWVPUW8Hc7TkEUtWuoQUzi7YQ3YdJ9tuJSZa5piDk/m/xvWDA1sgh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzepx/60gtN/PlfS6zt+Ju7+udVbHIVIigS4IhcKtIuKUYA6Zry
	ELKb5BJXsA6OXUWzxlJ2r1CP4VMmwTbjm7F+G1k21gRoUJFA99zx8dTCvLC2lNxCdLWoMiEfJbN
	O+OAODGiaTln3BemzAP300Hb6HpJRgdxg3BhD
X-Google-Smtp-Source: AGHT+IFQ19Riv0f6yE9SxFB8BFiwD1UmDvqOz9Z/MXc/PMUECV9xW4KWUKcr3czucY0z9CXixZ3ple6+ZcJ+8qufymY=
X-Received: by 2002:a25:9b07:0:b0:e28:c6be:4ce6 with SMTP id
 3f1490d57ef6-e2bafe21356mr353527276.28.1729196506045; Thu, 17 Oct 2024
 13:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org> <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
In-Reply-To: <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Oct 2024 16:21:34 -0400
Message-ID: <CAHC9VhR=-MMA3JoUABhwdqkraDp_vvsK2k7Nh0NA4yomtn855w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "anna@kernel.org" <anna@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Thu, 2024-10-17 at 11:15 -0400, Paul Moore wrote:
> > On Thu, Oct 17, 2024 at 10:58=E2=80=AFAM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> > > On Thu, Oct 17, 2024 at 10:54:12AM -0400, Paul Moore wrote:
> > > > Okay, good to know, but I was hoping that there we could come up wi=
th
> > > > an explicit list of filesystems that maintain their own private ino=
de
> > > > numbers outside of inode-i_ino.
> > >
> > > Anything using iget5_locked is a good start.  Add to that file system=
s
> > > implementing their own inode cache (at least xfs and bcachefs).
> >
> > Also good to know, thanks.  However, at this point the lack of a clear
> > answer is making me wonder a bit more about inode numbers in the view
> > of VFS developers; do you folks care about inode numbers?  I'm not
> > asking to start an argument, it's a genuine question so I can get a
> > better understanding about the durability and sustainability of
> > inode->i_no.  If all of you (the VFS folks) aren't concerned about
> > inode numbers, I suspect we are going to have similar issues in the
> > future and we (the LSM folks) likely need to move away from reporting
> > inode numbers as they aren't reliably maintained by the VFS layer.
> >
>
> Like Christoph said, the kernel doesn't care much about inode numbers.
>
> People care about them though, and sometimes we have things in the
> kernel that report them in some fashion (tracepoints, procfiles, audit
> events, etc.). Having those match what the userland stat() st_ino field
> tells you is ideal, and for the most part that's the way it works.
>
> The main exception is when people use 32-bit interfaces (somewhat rare
> these days), or they have a 32-bit kernel with a filesystem that has a
> 64-bit inode number space (NFS being one of those). The NFS client has
> basically hacked around this for years by tracking its own fileid field
> in its inode.

When I asked if the VFS dev cared about inode numbers this is more of
what I was wondering about.  Regardless of if the kernel itself uses
inode numbers for anything, it does appear that users do care about
inode numbers to some extent, and I wanted to know if the VFS devs
viewed the inode numbers as a first order UAPI interface/thing, or if
it was of lesser importance and not something the kernel was going to
provide much of a guarantee around.  Once again, I'm not asking this
to start a war, I'm just trying to get some perspective from the VFS
dev side of things.

> A lot of the changes can probably be automated via coccinelle. I'd
> probably start by turning all of the direct i_ino accesses into static
> inline wrapper function calls. The hard part will be parceling out that
> work into digestable chunks. If you can avoid "flag day" changes, then
> that's ideal.  You'd want a patch per subsystem so you can collect
> ACKs.
>
> The hardest part will probably be the format string changes. I'm not
> sure you can easily use coccinelle for that, so that may need to be
> done by hand or scripted with python or something.

Out of curiosity, is this on anyone's roadmap?  I've already got
enough work in security land to keep myself occupied until I'm hit by
that mythical bus, so I can't volunteer in good conscience, but I (and
many others in security land) would be grateful for a single,
consistent way to fetch inode numbers :)

--=20
paul-moore.com

