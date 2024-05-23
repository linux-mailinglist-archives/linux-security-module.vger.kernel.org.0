Return-Path: <linux-security-module+bounces-3480-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02B8CD776
	for <lists+linux-security-module@lfdr.de>; Thu, 23 May 2024 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22101C20BB2
	for <lists+linux-security-module@lfdr.de>; Thu, 23 May 2024 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF6125A9;
	Thu, 23 May 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iSKnXErv";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iSKnXErv"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906C11720;
	Thu, 23 May 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479000; cv=none; b=t3jB0nAlPQxUDYTRg0YJPuin6FF0tKSkI1nluh09TkiIxFraFM4So7POTRXmqOqSL74X8Ohc9qW84Fld+1+yPuWWt3ap6dh21GomDqhXIJ1O+UmcwimVADFOXLwETxj6+TTtbJeLc+HLrKB7FcUO67kjbVBIIH05PxCcmuwyIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479000; c=relaxed/simple;
	bh=WSNYyE8Fxb5iFaOqD8GTHKymSamrFzj8sFSRLXQiKjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6N8lHxggkWMH29XzI9DI5pV/ZtKCZS9f88tBAHCpq058OvDvPgKDINsLZaDnuZmqOS8mEwHABlCud5UazZCxFXlAieJvHowrpQXXHc0obQVWgrry7b0OAbgaIiWBHO04Ro0qAuvI3YbBPHhvqO2lNXonaVyZ2DfKeGtS7FNaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iSKnXErv; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iSKnXErv; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716478996;
	bh=WSNYyE8Fxb5iFaOqD8GTHKymSamrFzj8sFSRLXQiKjU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=iSKnXErvH5YXNmYLY3QiDaAUBY3OP6TFWsK+5UyH0WczdyAmQ+M2vegTDl9gqPpvY
	 411Mf+85JquxkiwJg4Zd1idKa9+zrWAlCUfyrNJbB/0EtCZyFXoOv3NGMtzmMDA9yN
	 tg/E1YUxJVtSxGLQWPbH4Zu7wL/8u0Di5oRdflug=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 617E61285DF4;
	Thu, 23 May 2024 11:43:16 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id mNziTRyiKTV2; Thu, 23 May 2024 11:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716478996;
	bh=WSNYyE8Fxb5iFaOqD8GTHKymSamrFzj8sFSRLXQiKjU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=iSKnXErvH5YXNmYLY3QiDaAUBY3OP6TFWsK+5UyH0WczdyAmQ+M2vegTDl9gqPpvY
	 411Mf+85JquxkiwJg4Zd1idKa9+zrWAlCUfyrNJbB/0EtCZyFXoOv3NGMtzmMDA9yN
	 tg/E1YUxJVtSxGLQWPbH4Zu7wL/8u0Di5oRdflug=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C9F1512819F5;
	Thu, 23 May 2024 11:43:14 -0400 (EDT)
Message-ID: <4d33654876b91a954e581727b6eb2c5e94128cb1.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Eric
 Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Andrew Morton
 <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Date: Thu, 23 May 2024 11:43:13 -0400
In-Reply-To: <D1H4WNKWCB5K.2HJG7RMX7L33V@kernel.org>
References: <20240523131931.22350-1-jarkko@kernel.org>
	 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
	 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
	 <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
	 <D1H4WNKWCB5K.2HJG7RMX7L33V@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-23 at 18:37 +0300, Jarkko Sakkinen wrote:
> On Thu May 23, 2024 at 6:30 PM EEST, James Bottomley wrote:
> > On Thu, 2024-05-23 at 16:54 +0300, Jarkko Sakkinen wrote:
> > > On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> > > > On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > > > > There's no reason to encode OID_TPMSealedData at run-time, as
> > > > > it never changes.
> > > > > 
> > > > > Replace it with the encoded version, which has exactly the
> > > > > same size:
> > > > > 
> > > > >         67 81 05 0A 01 05
> > > > > 
> > > > > Include OBJECT IDENTIFIER (0x06) tag and length as the
> > > > > epilogue so that the OID can be simply copied to the blob.
> > > > 
> > > > This is true, but if we're going to do this, we should expand
> > > > the OID registry functions (in lib/oid_registry.c) to do
> > > > something like encode_OID.  The registry already contains the
> > > > hex above minus the two prefixes (which are easy to add).
> > > 
> > > Yes, I do agree with this idea, and I named variable the I named
> > > it to make it obvious that generation is possible.
> > > 
> > > It would be best to have a single source, which could be just
> > > a CSV file with entries like:
> > > 
> > > <Name>,<OID number>
> > > 
> > > And then in scripts/ there should be a script that takes this
> > > source and generates oid_registry.gen.{h,c}. The existing
> > > oid_registry.h should really just include oid_registry.gen.h
> > > then to make this transparent change.
> > > 
> > > And then in the series where OID's are encoded per-subsystem
> > > patch that takes pre-encoded OID into use.
> > > 
> > > Happy to review such patch set if it is pushed forward.
> > 
> > Heh, OK, since I'm the one who thinks it's quite easy, I'll give it
> > a go.
> 
> I guess if it cleaned up multiple sites in kernel then it could
> be considered useful. I'd guess that there is at least a few
> locations that also encode OID.

This should be the only one currently.  The ASN.1 encoding was added to
the kernel to support the trusted keys pipe use case.  However, if you
want the kernel to construct and pipe out asymmetric keys, that would
be the second use case.

James


