Return-Path: <linux-security-module+bounces-3253-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827D8C7AFA
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2024 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C3C1C2097F
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AD1553BC;
	Thu, 16 May 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdOjwGHg"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219B154BF0;
	Thu, 16 May 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879907; cv=none; b=MxwFXH55IcuK8aAOoa50RstgesX/iF+XAafC1JpCIsxK14XH/G/skffKOpdPmuvy7K8z3q2n3BarqWLmuqpPyeZoxJYtNOgj1LiDDvkkrSQceYhHz4m0EF+8SaehB/MqZe/I6E9vX3M13/qDfxw9ld1hui9q5ywfn6GA2kuq2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879907; c=relaxed/simple;
	bh=fIK++qma76v6f8TknO156tpt5GQaZPJ+s9y4ZW/mavQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JHqSgg0Q04rNRGqc6qGrRlNCPJDCTGKkpbJ/iJepGdhLGGP7TR/M17/l/BgB1F6jUu/KF46eBg8msTVkLk3dMgByzUcGqpSmYneRXsL8xyI4jjtuk4KBARYB4abLqphpREBh1ATbULAKezWpoWWGoAR/6MCB7kL+KaTlJgXRB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdOjwGHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217FFC113CC;
	Thu, 16 May 2024 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715879907;
	bh=fIK++qma76v6f8TknO156tpt5GQaZPJ+s9y4ZW/mavQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rdOjwGHgCqG3/ineB6Oty5GlbvyY3FGa5MaGsr7QsgqE7RwBRax43tYFSxhyNkM3O
	 xvCgoQE+c6eQxKm0Hd9H5SonC7lgFIyeYvMz6yqH//2dY22/kFLzzPn5EO9rVJ9PCK
	 8GDyfegnO0bLk/lqUFzxWTVkpyEiM5zk2y5Ouyx/QrZB0vNGnl3ijiK/eF7sok+iab
	 Sh5LzcBRbGZO2hEvBkihpNXL5CTUrcYLgmNdAS7sSmVWgq3neuVPg/XIp0u5tamkFb
	 AqUvhzBKZpVOrQ3AptQ72EYJ/3M0R/ULEBexGzuF5+PsL8crJ9BaPCPV9P8mw5bjdx
	 loHHl3sp4DRUw==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 20:18:22 +0300
Message-Id: <D1B8NSWK7C8W.2793LJVZT01LD@kernel.org>
Cc: <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "James Morris" <jmorris@namei.org>, "David
 Howells" <dhowells@redhat.com>, <containers@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>, "Jonathan Calmels"
 <jcalmels@3xx0.net>, "Serge Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <CAHC9VhQ=nNPLRHF8RAMxArT1CESei+qYsnGse6--ixPhACAWTA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=nNPLRHF8RAMxArT1CESei+qYsnGse6--ixPhACAWTA@mail.gmail.com>

On Thu May 16, 2024 at 7:23 PM EEST, Paul Moore wrote:
> On Thu, May 16, 2024 at 5:21=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.n=
et> wrote:
> >
> > It's that time of the year again where we debate security settings for =
user
> > namespaces ;)
> >
> > I=E2=80=99ve been experimenting with different approaches to address th=
e gripe
> > around user namespaces being used as attack vectors.
> > After invaluable feedback from Serge and Christian offline, this is wha=
t I
> > came up with.
>
> As Serge is the capabilities maintainer it would be good to hear his
> thoughts on-list about this proposal.

Also it would make sense to make this just a bit more digestible to a
wider group of maintainers, i.e. a better introduction to the topic
instead of huge list of references (no bandwidth to read them all).

This is exactly kind of patch set that makes you ignore it unless
you are pro-active exactly in this domain.

I think this could bring more actually useful feedback.

BR, Jarkko

