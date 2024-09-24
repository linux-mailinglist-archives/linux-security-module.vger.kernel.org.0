Return-Path: <linux-security-module+bounces-5667-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294C984A43
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2024 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB75286D0E
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2024 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1C2E419;
	Tue, 24 Sep 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueP4CBcu"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20F1AC420;
	Tue, 24 Sep 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198811; cv=none; b=RpdHMnakY3u+9BBBYfJI0eevc1lsNRG7KZbwQ6uZ+bSr3mx96Ok7RQhz6hMDsANm/d6UK5UVt5YmV9ANWcgV/tTe6CAPyQMaAvlhih6Hadc3VMSBVDI5C4NBrKSPQ8a/I46bOj9UZ9xUdCQCZN2hAARZjtrn4Tvh1IIKlxv02OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198811; c=relaxed/simple;
	bh=+yY1CdRo2TEwaS80YnA60m5pp4jDQ/2WW7wzIW475Lg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rRE0KqtTdLtIl1OQiWh5nzLtweeGGP/RLgODjdcFTxdF2PJVbT8A3BFton1lpKT1SHLTdmEf0tTwR+8QCSNuQw5FBMR3wh0ooW5opZKb2ZPMHxF1E24Puqa0lnmC8kkgHf6rrPEf7CVnNp8rzXdO83TUQkXwLI1JIJAI+PuChDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueP4CBcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08529C4CEC4;
	Tue, 24 Sep 2024 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727198811;
	bh=+yY1CdRo2TEwaS80YnA60m5pp4jDQ/2WW7wzIW475Lg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ueP4CBcukDNiFusTex4bZfcENb6oMRb7Q8YyPJu3pGhiXlvxZCjWtTxrIZgvZ/U/Q
	 RwCJwSDNEbZzAi0+2cehoQJAe+yafaLy/tKsVMtTEDWDTmEhrIxj72u3hSabEBw6gC
	 oM8NpaPUjESg1oXuvC16zbXlK0z7hmtuRCZxzqFljeE+MruWJSQ5wWngc5ArKgxiQg
	 JPrAUl0VD7PVY6E5Wx+EWsh8Yq3yLMET4g4l2gSRxwP173taQMGKBq+1wei+v5UA57
	 aDHCwsP6H1E5PIy+edfBuY52WF/uILiqx9owNZo/SAPNzB8QGHLRkfUZVJQgsoAu9Z
	 m1erzLhRNGz2Q==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 20:26:47 +0300
Message-Id: <D4EOVMA9YR3W.1X1ARMW6APFPP@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
 <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>
 <D4ENNN25NKBE.87NXHTTEWZY@kernel.org>
 <19a242eeabaa72dcc159c9c24fb412e3f68f8e7e.camel@HansenPartnership.com>
 <D4ENT15WZFRI.HA0FFVBWVISI@kernel.org>
In-Reply-To: <D4ENT15WZFRI.HA0FFVBWVISI@kernel.org>

On Tue Sep 24, 2024 at 7:36 PM EEST, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 7:33 PM EEST, James Bottomley wrote:
> > On Tue, 2024-09-24 at 19:29 +0300, Jarkko Sakkinen wrote:
> > > On Tue Sep 24, 2024 at 4:48 PM EEST, James Bottomley wrote:
> > [...]
> > > > Patch 3 is completely unnecessary: the null key is only used to
> > > > salt the session and is not required to be resident while the
> > > > session is used (so can be flushed after session creation)
> > > > therefore keeping it around serves no purpose once the session is
> > > > created and simply clutters up the TPM volatile handle slots. (I
> > > > don't know of a case where we use all the slots in a kernel
> > > > operation, but since we don't need it lets not find out when we get
> > > > one).=C2=A0 So I advise dropping patch 3.
> > >=20
> > > Let's go this through just to check I'm understanding.
> > >=20
> > > Holding null key had radical effect on boot time: it cut it down by
> > > 5 secons down to 15 seconds:
> > >=20
> > > https://lore.kernel.org/linux-integrity/CALSz7m1WG7fZ9UuO0URgCZEDG7r_=
wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com/
> > >=20
> > > Then in subsequent version I implemented lazy auth session and boot
> > > time went down to 9.7 seconds.
> > >=20
> > > So is the point you're trying to make that since auth session is=20
> > > already held as long as we can and they flushed in synchronous
> > > point too, I can just as well drop patch 3?
> >
> > Yes, because the null key is only used in session generation which is
> > now lazy, it adds or subtracts nothing from the timings.  When you're
> > forced to flush the session, the null key goes too, so you again have
> > to restore it from the context.  When you can keep the session you
> > don't need the null key because you're not regenerating it.
>
> Yeah, OK, then we're in sync with this. It's evolutionary cruft.
>
> Just had to check that the logic matches how I projected your earlier
> comment because these are sensitive changes.

I'm definitely going keeep 1/5 and 2/5 as they are still bug fixes.

So they will appear in v6 unchanged and perf fixes (which are not
functional fixes) should not be built on top of broken code.

BR, Jarkko

