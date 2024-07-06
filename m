Return-Path: <linux-security-module+bounces-4110-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECB1929451
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2024 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5741C215AC
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477CA93D;
	Sat,  6 Jul 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nZqQzXz6"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B871B52
	for <linux-security-module@vger.kernel.org>; Sat,  6 Jul 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278164; cv=none; b=B+U35ZBkBTjI56ii/g7dzS89jQREKcEyOp4q+boRUfJLCHJqez9jCGLqEtaVNW9dVOty5r/VFgsZypDQWdUQyenFBYB1Dnj+sGvQRt1K5kar/VcKgJljwLYiyV5zO1bUuQ8teqL/nP/zO+N1PfeMRO/W93gwC/te8ZAutObRjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278164; c=relaxed/simple;
	bh=JRAKfcNAHQUde9h3yWMHT6AuYZ+lQ3GrpuP+r4Let/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6UBf3hmNHyWEFMvA+lScreZIrZpcvYnb+YFcDmGGQARVPXFMvRkNfnSUakaaa9TGsk+Vyd4GDCZv9Z+PYBJQFlGBCg9v3/Q6Csn+5KM5TfYRWuuHPP4bnSVODeO5GJ3pRsS99jE49p2Z7uOgEmLJx6XZpqtcH8XD0vGyraZ6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nZqQzXz6; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WGYPl116GzPVn;
	Sat,  6 Jul 2024 16:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720277819;
	bh=JYqPlEHCURGDmGDnXirgQkSo+v4UbE8cDc1PtWenhPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZqQzXz6Sdiu2HqKbkTRFhKQ+G4+nho/IuoMDV2od3dOpgE01KJa8RHRGbeFQ4UF5
	 1UVHdOOYdNUJW0N04FGd7c+oH0seVNi5ErR0GM0NARy8O9hBOlXx9FR6QeLTA/6Q4I
	 4NDRT4xJ0OKYffb0APxKw+rOUMWlUnGqCI+gydV8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WGYPh4xsDzw8B;
	Sat,  6 Jul 2024 16:56:56 +0200 (CEST)
Date: Sat, 6 Jul 2024 16:56:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240706.SieHeiMie8fa@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <202407041711.B7CD16B2@keescook>
 <20240705.IeTheequ7Ooj@digikod.net>
 <202407051425.32AF9D2@keescook>
 <D2HYFLLXVYLS.ORASE7L62L3N@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D2HYFLLXVYLS.ORASE7L62L3N@kernel.org>
X-Infomaniak-Routing: alpha

On Sat, Jul 06, 2024 at 01:22:06AM +0300, Jarkko Sakkinen wrote:
> On Sat Jul 6, 2024 at 12:44 AM EEST, Kees Cook wrote:
> > > As explained in the UAPI comments, all parent processes need to be
> > > trusted.  This meeans that their code is trusted, their seccomp filters
> > > are trusted, and that they are patched, if needed, to check file
> > > executability.
> >
> > But we have launchers that apply arbitrary seccomp policy, e.g. minijail
> > on Chrome OS, or even systemd on regular distros. In theory, this should
> > be handled via other ACLs.
> 
> Or a regular web browser? AFAIK seccomp filtering was the tool to make
> secure browser tabs in the first place.

Yes, and that't OK.  Web browsers embedded their own seccomp filters and
they are then as trusted as the browser code.

