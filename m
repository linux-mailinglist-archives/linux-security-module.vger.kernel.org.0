Return-Path: <linux-security-module+bounces-14159-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEmuMJmvcmnIogAAu9opvQ
	(envelope-from <linux-security-module+bounces-14159-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jan 2026 00:15:37 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF46E6D2
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jan 2026 00:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946833002756
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jan 2026 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3D3A704D;
	Thu, 22 Jan 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf4bbk7D"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E830F958
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123730; cv=none; b=cszGhEeKmyAOvovkd0YJR0FBp0135DSu9o7jhr8gdmkFgVrSjKb872MC83GwGiVUzxUOn2oXYwVn6aJzC7k/4pUB3DXPahIeQ9S++FQwIZBtUCs7wj24BqY2fJQpbHRwrXPPkuxmjDcYwWb0GlKyT7ax1HQTYYi/eOs/9ZLm9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123730; c=relaxed/simple;
	bh=JC9aEFwPzpM5wsm36wMi448ig47cP2Admex05jfbUww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUQEJoYNLeCzrPx65V3Slzwd+lrlYIW4fv4Zx9BK5gkeWol9JalxBHeKpPxjWslSimw7h3m2nKgZlxBtBwwob5zNhx7Z5wTar8hFBy8SDpPl6kCKKgchDlIWLxdNgpJmY+d6s6gBrka5B+7nZaVWA/QzRYBpD4xZ3wMGfcgOhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf4bbk7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD983C2BC87
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 23:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769123728;
	bh=JC9aEFwPzpM5wsm36wMi448ig47cP2Admex05jfbUww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nf4bbk7D1oOUQ9ZvCOM9Y0q6+8nGvhv3KbYYEMgBFAhlBaKf2eUHbYnRGHRY77z7W
	 Q6YqfA7AOoiYFHFzw81EQqAKgxxvdet+Nt7OOpgDkb/eiRbhRV1CYZLWyrXTkG0Tg3
	 SZxuKNQZL1byeKJC1G5NInuJTZD0R1kRlZ7obYVierSi7FUMLKUY3daGLZU136Grwq
	 XslIjGcZ60vDhLdUlmN30lzJbpFYd4IiViJK2M7ADGDcmdal6QG87YFidueUNtvP7F
	 uH8tnfxgL9wSQEmbjA+FzFedg2ssXPVFA4HkDRI3l1Rftb2vZpEnWj0T/6LXebdXoJ
	 lhatte5Ir/8zg==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8887ac841e2so14300726d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 15:15:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVo3wu+Ti9MNKnOwVRRQwEKdX6D9lCkyOjGPyNE7M25uQRin0PpJePtmUbJji5pxFjAR9pZBYKbdqpOWIRefoQcdYc5oto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/WbhBM2+0PNzYbCnqUAdEZhEUjmMjzYHz4jFNxUZdw+xh5OM
	5uv2mIXcx8F3e0kesXzbT6ksuMms6cACGrsmPo1TvYlffXIOHIxhmZNmPeSLBEVVLkV+8oJrQLz
	J0Cp//WIcGvYaV0RrmXI/vnqfR03s4S0=
X-Received: by 2002:a05:6214:2aac:b0:894:6e5d:eb8b with SMTP id
 6a1803df08f44-8949025435emr18407736d6.62.1769123727832; Thu, 22 Jan 2026
 15:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com> <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com>
In-Reply-To: <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 22 Jan 2026 15:15:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
X-Gm-Features: AZwV_QjmA04zT3HDWHBWIrbAJDRmOtXe8k_Jq-82VoIpXuVkGa1y8ca6PSuoOwc
Message-ID: <CAPhsuW6TMNTGs9miKmQ_YFdm-NnCfLViCjQjMkWUYnuj9bB-qA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14159-lists,linux-security-module=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-security-module@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email,sessionize.com:url]
X-Rspamd-Queue-Id: 25BF46E6D2
X-Rspamd-Action: no action

Hi Paul,

On Thu, Jan 22, 2026 at 9:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
[...]
> The Linux Security Summit (LSS), held both in North America and Europe
> each year, typically has a large number of LSM developers and
> maintainers in attendance.  The CfP for LSS North America just
> recently opened (link below), and it closes on March 15th with LSS-NA
> taking place May 21st and 22nd; reworking the LSM mount APIs would
> definitely be on-topic for LSS.  While there is a modest conference
> fee to cover recordings (waived for presenters), anyone may attend LSS
> as no invitation is required.
>
> https://sessionize.com/linux-security-summit-north-america-2026
>
> The CfP for Linux Security Summit Europe will open later this year,
> you can expect a similar CfP as LSS North America.
>
> https://events.linuxfoundation.org/linux-security-summit-europe

Thanks for the suggestions! I will double check my schedule and
see whether I can make LSS. LSS Europe is right after LPC, so
there is a good chance I can make it in person.

> > AFAICT, in-tree LSMs have straightforward logics around mount
> > monitoring. As long as we get these logic translated properly, I
> > don't expect much controversy with in-tree LSMs.
>
> It seems very odd, and potentially a waste of time/energy, to discuss
> a redesign of an API without the people needed to sign-off on and
> maintain the design, but what do I know ...

Unfortunately, I often did some work that turned out to be a waste of
time and energy. Well, that's a different story.

This issue has been bothering us for quite some time. Therefore, I
don't mind spending more than necessary effort to get it fixed
sooner. Again, I don't think offline discussions can replace formal
review in the mailing list, so nothing gonna land without the
agreement in the LSM community.

Thanks,
Song

