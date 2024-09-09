Return-Path: <linux-security-module+bounces-5406-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7A972213
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Sep 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B346B230BF
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Sep 2024 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30783179202;
	Mon,  9 Sep 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HbiHCzBi"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5C14B06C
	for <linux-security-module@vger.kernel.org>; Mon,  9 Sep 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907814; cv=none; b=E0se1d1P/pdyrGkfxmciWZ99kAuzOr0VuQxWg66C7qXlTrZFws+scj8Zt0x0enXRUOPtduL3dgZS6/fuOWNGYiwbbu/ACFcHdhApyk506Gz2XMfXk4o97rg2jAFroODjxwH2rZbxmvAuaafn6RzgENIIBy8F0xvQ7WYXSsWJE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907814; c=relaxed/simple;
	bh=iX6x+X+C2KmnTglmajitY2d8V7n/jwEPwVA+GAC6eiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6RBPnz6VmKZjvB09ZpFrekTm22PMadU/e0DuTHNPAzK29jJOkWphURNhLjmmd4fRbMPmg0iJCsULaXL6CxdDTs5OuWXVZpBL5cfSw6pG6rWqp+qTS/wzYWTKf0lyIza+TwVC4QWAoZFTd05mMZSchTqpYjlSvd3c0Lxzj5t6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HbiHCzBi; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X2bMc50Nvzqk1;
	Mon,  9 Sep 2024 20:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1725907436;
	bh=oxG77P3NVtf5xxUT9J4SD9IVKFdgoO+cgYyab1/OTdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbiHCzBik6ccWXsmUvJQLIqOCgka7Ec894qPRxXTXCbv1YFhdhXr12RHBDKF+f6Nx
	 qjo2Nl+av5qGDdDVB0Td1Z5NEODrgaFXQ9TP8xDb0lz0870wJJMMElvhHUrhTCjVbk
	 XFz3brhGV6mpYyowybeg0Qn7/DYLIeQ0hWHoAY/o=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4X2bMb0H3gzvVV;
	Mon,  9 Sep 2024 20:43:54 +0200 (CEST)
Date: Mon, 9 Sep 2024 20:43:48 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
Message-ID: <20240909.fea6omu9Ohof@digikod.net>
References: <20240821095609.365176-1-mic@digikod.net>
 <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
 <20240908.jeim4Aif3Fee@digikod.net>
 <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
 <CAHC9VhTck26ogxtTK-Z_gxhhdfYR4MgHystKdWttjsXcydyB9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTck26ogxtTK-Z_gxhhdfYR4MgHystKdWttjsXcydyB9A@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Sep 09, 2024 at 12:44:16PM -0400, Paul Moore wrote:
> On Mon, Sep 9, 2024 at 12:03 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Sun, Sep 8, 2024 at 2:11 PM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > On Wed, Aug 21, 2024 at 12:32:17PM -0400, Paul Moore wrote:
> > > > On Wed, Aug 21, 2024 at 5:56 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > >
> > > > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> > > > > for the related file descriptor.  Before this change, the
> > > > > file_set_fowner LSM hook was always called, ignoring the VFS logic which
> > > > > may not actually change the process that handles SIGIO (e.g. TUN, TTY,
> > > > > dnotify), nor update the related UID/EUID.
> > > > >
> > > > > Moreover, because security_file_set_fowner() was called without lock
> > > > > (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a race
> > > > > condition and inconsistent LSM states (e.g. SELinux's fown_sid) compared
> > > > > to struct fown_struct's UID/EUID.
> > > > >
> > > > > This change makes sure the LSM states are always in sync with the VFS
> > > > > state by moving the security_file_set_fowner() call close to the
> > > > > UID/EUID updates and using the same f_owner.lock .
> > > > >
> > > > > Rename f_modown() to __f_setown() to simplify code.
> > > > >
> > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > Cc: James Morris <jmorris@namei.org>
> > > > > Cc: Jann Horn <jannh@google.com>
> > > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > > ---
> > > > >
> > > > > Changes since v2:
> > > > > https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> > > > > - Only keep the LSM hook move.
> > > > >
> > > > > Changes since v1:
> > > > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > > > - Add back the file_set_fowner hook (but without user) as
> > > > >   requested by Paul, but move it for consistency.
> > > > > ---
> > > > >  fs/fcntl.c | 14 ++++----------
> > > > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > > >
> > > > This looks reasonable to me, and fixes a potential problem with
> > > > existing LSMs.  Unless I hear any strong objections I'll plan to merge
> > > > this, and patch 2/2, into the LSM tree tomorrow.
> > >
> > > I didn't see these patches in -next, did I miss something?
> > > Landlock will use this hook really soon and it would make it much easier
> > > if these patches where upstream before.
> >
> > Ah!  My apologies, I'll do that right now and send another update once
> > it's done.  FWIW, I'm going to tag 1/2 for stable, but since we are at
> > -rc7 presently I'll just plan to send it during the next merge window.
> 
> Merged into lsm/dev, thanks for the nudge :)

Thanks!

