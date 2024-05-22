Return-Path: <linux-security-module+bounces-3359-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676388CB63A
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240F3282AA9
	for <lists+linux-security-module@lfdr.de>; Tue, 21 May 2024 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAA14A0BD;
	Tue, 21 May 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNYTRCOy"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EA14A096;
	Tue, 21 May 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332403; cv=none; b=Qc82HpKyMgWLR3CdxNKi6B3uAuqy+n08G/iavWxRAwizMjuqp3n8bATCIfa5Zw6rOQ1rOniOTTG3coNuieLwgfhKeKJegwZFGoM4KFjJeymsSynJl9IZypABv/Cv4VlxZlAPLnDZa9UpsK3w/EdWH0WSMRrkCJkJCsw9qBiVj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332403; c=relaxed/simple;
	bh=iJA/F33R/LtZ4Uq9GOkWjVAyXoIG43uY1j5/qRey5p8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Th2043Z4su3YFnOjaDbORBHbkUK0D3M26mujJRR8eAvLrvV+XBqBMhjmdb+qn2iUXhJ8jPB4BPjCdsv2h6C+m2mJfUbUayzt0fX/Rqa6jXbU4ldcK+ifSp3jx0miM5PHU0fcXhmvKQCr5oUlIx1dZXNe4osX+YqfonS7aMz0tRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNYTRCOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DC9C2BD11;
	Tue, 21 May 2024 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716332402;
	bh=iJA/F33R/LtZ4Uq9GOkWjVAyXoIG43uY1j5/qRey5p8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=qNYTRCOyd10U8Dr2Tzw965mydVoF/OGlzzJ5W/HyNMqxVBkWDVFKqoZ7fksXI+LQB
	 mFEDpwCOG0p3F/8x+twrJZl5NPzq4k26K1y+SXj2Pozxb7kfirdV1PbuoPP/PK30QK
	 H68apjdPEGtqD1XzySMrxVzvx5KXtFRQeDlxzaoUJjc4LNwXArvNuU3ggro0D+JPZi
	 ySWzSgReIviOIq05uCA8Y0a1/COtseXeLrdAXZ7vCC05BdNmtZkmwQ/Ajep9Q8jib9
	 M3C7OAcBXd+VZ6O5+LWtvlSfB7tSIQgcYD5VHDy1BOa1F6SEZUJzVESvVagccF1v+g
	 LPYCZ+LEW55GA==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 01:59:56 +0300
Message-Id: <D1FP21Y7J8QO.7JCTW22LRSXF@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "David Howells"
 <dhowells@redhat.com>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "David S. Miller" <davem@davemloft.net>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM
 driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org>
 <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-5-jarkko@kernel.org>
 <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
 <336755.1716327854@warthog.procyon.org.uk>
 <239a52eb5ed3a6c891382b63d08fe7b264850d38.camel@HansenPartnership.com>
 <D1FOQSFNZ794.23R2JV1SD8X8W@kernel.org>
In-Reply-To: <D1FOQSFNZ794.23R2JV1SD8X8W@kernel.org>

On Wed May 22, 2024 at 1:45 AM EEST, Jarkko Sakkinen wrote:
> On Wed May 22, 2024 at 12:59 AM EEST, James Bottomley wrote:
> > On Tue, 2024-05-21 at 22:44 +0100, David Howells wrote:
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >=20
> > > > On Tue May 21, 2024 at 9:18 PM EEST, James Bottomley wrote:
> > > > ...
> > > > You don't save a single byte of memory with any constant that
> > > > dictates the size requirements for multiple modules in two disjoint
> > > > subsystems.
> > >=20
> > > I think James is just suggesting you replace your limit argument with
> > > a constant not that you always allocate that amount of memory.
> >
> > Exactly.  All we use it for is the -E2BIG check to ensure user space
> > isn't allowed to run away with loads of kernel memory.
>
> Not true.
>
> It did return -EINVAL. This patch changes it to -E2BIG.
>
> >
> > > What the limit should be, OTOH, is up for discussion, but PAGE_SIZE
> > > seems not unreasonable.
> >
> > A page is fine currently (MAX_BLOB_SIZE is 512).  However, it may be
> > too small for some of the complex policies when they're introduced.=20
> > I'm not bothered about what it currently is, I just want it to be able
> > to be increased easily when the time comes.
>
> MAX_BLOB_SIZE would be used to cap key blob, not the policy.
>
> And you are ignoring it yourself too in the driver.

Obviously policy is part of the key blob i.e. expected value for that.

... but that does not reduce space requirements to rsa asymmetric keys.
It increases them but I think at this point 8192 is good starting point.
And it cap can be scaled later.

Being a parameter also allows to have even kernel-command line or sysfs
parameter and stuff like that. It is robust not a bad choice.

BR, Jarkko

