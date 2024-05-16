Return-Path: <linux-security-module+bounces-3263-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CB8C7D8D
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2024 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B89D282DA0
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864F157488;
	Thu, 16 May 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH/2JEns"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74342147C72;
	Thu, 16 May 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889632; cv=none; b=hIyQi+lMmNuXrlsMeCbgNCI3jjbFMP2Pvi/8HyYMzhRURFlJZqzM2YTAQ/pI+YQ3w5c7T1CK2FwawV4YUgNRj/Dn4qFTXnFkI6yrOuBM4+rm9+DWMvs5VWcLpJcPn/MUrOKXMx8pYMsxdr4enoStqsvu59kju91CTWACbainGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889632; c=relaxed/simple;
	bh=oIo0+8UooOueZ1JprNItUa0mTgu6yRRFRPC/LxHzJLc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nbUWc+n/aQwaDVjXvu6F3qxOAl6dOQlz9+KQHNgCPe10kCorXIDVINUrtM73uSbKCpZGW/noh8yf8nODifBFfhJy3c4U/pUasjdxXcxtQfddWnqk0eJWAiHYCUE9xePXYBVVSW7FC7ynefQFBjAybKgCzs3+alNWU4AECBioHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH/2JEns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A118C32786;
	Thu, 16 May 2024 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715889631;
	bh=oIo0+8UooOueZ1JprNItUa0mTgu6yRRFRPC/LxHzJLc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IH/2JEnsmDlYis68tcQXP1jSBA3ibITkeUFmxniYgQGaAs8DNqOT3EwnUgSJb54CN
	 V/7atgZBY8hdRJNdhMccnbCD6Y2By6cug68ykSbUtakB88OoXt83+xmsWJQwmDIwV3
	 IMXfl9FqhLGH6Q3knt2DUpZy57l9tgtg6mb27STOgCXdyXNG2KqIYjS9QF/FnZYzni
	 ovbTzu5ZAgbTjdXtGfvC2f6aZbXlt7DUW4zMhSE3TWaH1ZT6+RQ8wEy8wERHyplnPu
	 MTib+i7N8RLjx3SYSlUB+xa50dKhMGTXW1GVh7koRG6VUfZsG0PEpI9fzyqHpXtd25
	 wmqhq7DJUp77A==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 23:00:25 +0300
Message-Id: <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
Cc: <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Jonathan Calmels" <jcalmels@3xx0.net>,
 <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
In-Reply-To: <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>

On Thu May 16, 2024 at 10:31 PM EEST, Jarkko Sakkinen wrote:
> On Thu May 16, 2024 at 10:29 PM EEST, Jarkko Sakkinen wrote:
> > On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
> > > I suggest that adding a capability set for user namespaces is a bad i=
dea:
> > > 	- It is in no way obvious what problem it solves
> > > 	- It is not obvious how it solves any problem
> > > 	- The capability mechanism has not been popular, and relying on a
> > > 	  community (e.g. container developers) to embrace it based on this
> > > 	  enhancement is a recipe for failure
> > > 	- Capabilities are already more complicated than modern developers
> > > 	  want to deal with. Adding another, special purpose set, is going
> > > 	  to make them even more difficult to use.
> >
> > What Inh, Prm, Eff, Bnd and Amb is not dead obvious to you? ;-)
> > One UNs cannot hurt...
> >
> > I'm not following containers that much but didn't seccomp profiles
> > supposed to be the silver bullet?
>
> Also, I think Kata Containers style way of doing containers is pretty
> solid. I've heard that some video streaming service at least in recent
> past did launch VM per stream so it's not like VM's cannot be made to
> scale I guess.

Sorry for multiple responses but this actually nails the key question:
who will use this? Even if this would work out somehow, is there someone
who will actually use this, and not few other more robust solutions
available? I mean it is worth of time to maintain it, if there is no
potential users for a feature.

In addition to "show me the code", there is always also "show me the payloa=
d".

BR, Jarkko

