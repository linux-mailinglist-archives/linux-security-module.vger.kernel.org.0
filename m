Return-Path: <linux-security-module+bounces-6486-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D371C9BF3D0
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Nov 2024 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B981F22423
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Nov 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21B1DFE13;
	Wed,  6 Nov 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv8908II"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5F18FDDB
	for <linux-security-module@vger.kernel.org>; Wed,  6 Nov 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912430; cv=none; b=j4eUs1gdIpVrNaJC5GSyOo1NnfTOU+rjYUmIn8W9eY71eH1RMkw/aySBtF/UCpJ7ZknpATOe04Jz49BGEu4RemsJct/R+AvOWtOxLfWSQAs+ENKnsJWsmOBsHoVJovFnAijUCDX1tK/bEePm6o1IjibO197WKxK62a3GwTZOnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912430; c=relaxed/simple;
	bh=M0P7cs84jjZ9MZPgSMNMZ4jFY7gU+GyjBVnr9jmkpNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQvPfTBj27pwztZT4UWyqYGEYimaxv3pudlKrClFhKrunOowU8XXZU8vjwOQm52iuAMj/9ueYreUkQz/R7yNj9GIba9FziprO3Ln7A/QHWJ+CX/DE8uT0FT8eGPlkZCeu4RdZapv9+pYBK/lb6giv+4o+tvyLR1lm82/yOxG5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv8908II; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so5048786f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 06 Nov 2024 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912427; x=1731517227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLNouObUorCzJ6AkcXYcYQkgJBmZc32SGAGNMMbQIqo=;
        b=Fv8908IIWKbmy2IzdZhM+rXLzKQDIh35Pyg+zUqFd1hp+8/KaQM0B/BbcvgEx0X9tb
         LMrDs+HRM1Amudb7fo19JACipRDY0poa96ro0fZyNNgZUl8EzI8IO8b3oHkfH/4JLOFu
         svnavBQ6kbRqydpZycJyzmaNY0FTehqW0ZUIfHb5MVGkTGag5O6p2Kq4/EGJgY0D1WjH
         q19PSr9Sv6vPwr2QUsk6ew8yRPoKCaa8kRUTiwkHO2pmklPG9wL44uQcohz55pfjh6ep
         GZpsJekj1kOGIIbrpALXxQiDqgd+oWVqh7WdHYTfdM+sj9PzZfWx7J5d0pMXpw1Y/Yku
         tmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912427; x=1731517227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLNouObUorCzJ6AkcXYcYQkgJBmZc32SGAGNMMbQIqo=;
        b=Bd8fT38zoMNJagyYDeyS60S1CS7EqKRn1biCFlfmMv7DL1HcyP9BFqU4CaGe6R2Hl0
         8rfI9urg6upuDoGFtc7GFhJVXE+1bXdrGFYkoYuhbphA4ddeGXsqr0o3IM30cEbKLREE
         xl++cYMaDfDIVI8n+xrqlfDmoZJXiybtaJU+Gb6UTV9EZ0Julpr87uJXhqq/Ef/CGaV+
         3QyYdaY3zoH41yjL6raqLTd0v0aowjA6nBAkcdE4UPdBXTgCRC3axYFXzzfrnQgUmriT
         HZNtDl0/gTQI6Kwo/372WrzaL5ykCwOk6xckxdxldXl2j5NHk78cIK1BSuZ2xGvC7hbu
         8B2w==
X-Forwarded-Encrypted: i=1; AJvYcCWg8WJhV+arP/lEMlcDlCanh64yFTBcsEVp9AhgwKiwB0j9SoxJoc3EtFxGCaTKXk0kKR6v8ejQzdOWmvPi+C7FkBabPQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7bLPQqxHYQ1mHSsKelUv7JGNuwDZWLCuxLpwkipzFnGftqPx
	Efx7H2ClLrvlYFs9f1DdX1l2VU/E/3mML5TvUF9G9jLX0xVZyKsUa3cA1jDisiTKPKUx7w8y9Md
	ll2gV3arJxde4qPKU9MTENco6fVln/ajsrsM+
X-Google-Smtp-Source: AGHT+IHrnx1TLzKwmMZlGwZeX1FBkou/Z8ONAtZQvMq43XEgpy8Y8EBDJpgktHzfFZkFyumWTNC5i3EASlSIUyX9odk=
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id
 ffacd0b85a97d-381be776c81mr20504534f8f.15.1730912426398; Wed, 06 Nov 2024
 09:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
 <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
In-Reply-To: <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 18:00:14 +0100
Message-ID: <CANn89iJj2sQX3rZvmbL0zQjX7K-OFwyautgAXqxNvk2M17++bw@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:54=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Wed, Nov 6, 2024 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> > >
> > > SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
> > > (via the selinux_xfrm_refcount variable) as an input in deciding if p=
eer
> > > labeling should be used.
> > >
> > > However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
> > > after socket lock is released") and 68822bdf76f1 ("net: generalize sk=
b
> > > freeing deferral to per-cpu lists"), freeing of a sk_buff object, whi=
ch
> > > may hold a reference to an xfrm_state object, can be deferred for
> > > processing on another CPU core, so even after xfrm_state is deleted f=
rom
> > > the configuration by userspace, the refcount isn't decremented until =
the
> > > deferred freeing of relevant sk_buffs happens. On a system with many
> > > cores this can take a very long time (even minutes or more if the sys=
tem
> > > is not very active), leading to peer labeling being enabled for much
> > > longer than expected.
> > >
> > > Fix this by moving the selinux_xfrm_refcount decrementing to just aft=
er
> > > the actual deletion of the xfrm objects rather than waiting for the
> > > freeing to happen. For xfrm_policy it currently doesn't seem to be
> > > necessary, but let's do the same there for consistency and
> > > future-proofing.
> > >
> > > We hit this issue on a specific aarch64 256-core system, where the
> > > sequence of unix_socket/test and inet_socket/tcp/test from
> > > selinux-testsuite [1] would quite reliably trigger this scenario, and=
 a
> > > subsequent sctp/test run would then stumble because the policy for th=
at
> > > test misses some rules that would make it work under peer labeling
> > > enabled (namely it was getting the netif::egress permission denied in
> > > some of the test cases).
> > >
> > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > >
> > > Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is rel=
eased")
> > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu=
 lists")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> >
> > Can we explain why TCP packets sitting in TCP receive queues would
> > need to keep xfrm_state around ?
> >
> > With thousands of TCP sockets. I would imagine that a similar issue
> > would be hit,
> > regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
> > is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
> > to per-cpu lists")
> >
> > We remove the dst from these incoming packets (see skb_dst_drop() in
> > tcp_data_queue() and tcp_add_backlog()),
> > I do not see how XFRM state could be kept ?
>
> The problem is not with the xfrm_state reference via dst_entry, but
> the one in skb_ext (skb->extensions) -> sec_path
> (skb_ext_get_ptr(skb->extensions, SKB_EXT_SEC_PATH)) -> the xvec
> array. But you have a point that I should say that in the commit
> message...
>

So some secpath_reset() calls should be added in various protocol handlers
before packets are possibly queued for hours in a socket queue  ?

I see one in l2tp_eth_dev_recv().

> And I think you're right that even without those commits a delay in
> processing the RCU free callbacks could cause a similar issue, it just
> wouldn't be as easy to trigger. That made me look deeper into history
> which commit actually added the decrement on free and it turns out it
> was done intentionally as a bugfix - see commit e4e8536f65b5
> ("selinux: fix the labeled xfrm/IPsec reference count handling").
> Before that commit the logic was similar to what my patch is doing, so
> I could be re-introducing another bug here :-/ The commit message is
> not very helpful there - Paul, do you happen to remember what the
> issue was that prompted it? I guess there can be some alloc's that
> won't have a matching delete in the right circumstances? Or something
> involving the selinux_xfrm_policy_clone() case?
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>

