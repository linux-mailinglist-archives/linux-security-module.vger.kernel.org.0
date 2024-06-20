Return-Path: <linux-security-module+bounces-3887-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26822910106
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Jun 2024 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2490C1C210E1
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Jun 2024 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2D43AAE;
	Thu, 20 Jun 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC93dRmx"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238A19B3E1
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877795; cv=none; b=OxIIQpEsxCNwPUny0nk30z3kCvRsa7kB1jRsP1BSAFtAB5Oa0XEuYq3+0SrNkN6TQzpJdbLsxofocSGxRW0VK3rwEL9KyYulCmGeWjuXzLVgUiZun/hLNrYwjQk9gLhL5KI95MH5QsTc6MIpAjbAQzwFiXF0uIfvtIsli3GA5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877795; c=relaxed/simple;
	bh=qoo2Q0Zqih/O71OjIZHibGDXD6Cjin7X8WUFbvQIdks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaJcFhzjW1tqXSWVqZe9lEEOmJegMM08MgqZSLCqfb1g9A9iN6QnB7Li3Wq792BrnGocCJH8GD/g65qs1P9RUiZkfEISHUK+Ed8Dm16nbH/jIwHH3rMguzwl2bnlOjqmKMMuJ0iy8Zi/XUmCE63ttwFQTGAmmI/SVGTZLpbn5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TC93dRmx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718877793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoo2Q0Zqih/O71OjIZHibGDXD6Cjin7X8WUFbvQIdks=;
	b=TC93dRmx4OWsVFAl216oWLs0V6tolBiDlR8DewzrvjdC3brr/W9Qm/HnSgatz+thZGh4tJ
	2mVLQgclg1A68fOr6mAluKy81DYvAvHECgJyIyLnBfYRjTE5mMDQlImJUI60IwcVQzTPYp
	z+FWTNcFZkxeKcZ1R6f5+47ApNZgrSU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374--pWoFGpXMgaKWAPwLl0jdA-1; Thu, 20 Jun 2024 06:03:12 -0400
X-MC-Unique: -pWoFGpXMgaKWAPwLl0jdA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7043008f4beso795012b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 03:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877791; x=1719482591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoo2Q0Zqih/O71OjIZHibGDXD6Cjin7X8WUFbvQIdks=;
        b=TT/QpR2EkHY8QH4gAS+wu3RMW5z6CY9E6EtuCjWBIcRLrhgIs/fPsZFc+TdVhZx2Ka
         NSATQdLed8pQmhy2gV2izrW/0AgfAR6axIi3iXMbVxFGD03bL2wWWWJRW7RcHxXGErUj
         2d0HbLet67HKj7lbgfSWsSjwRmuGl614Lu7WkpUajPfa0Mxu6mJJyOJs8yiAHP5E3VTw
         bo7Qw84VwhLjGL/agF71NcsItHKpvi2hAK3LPSBfDJZkrwV2/7D3vjlX0mYCj9h+cFGy
         MdEDHeT1f2lU9ODPIbR/BVz6auS7meq6qH3RdtcYRpgPNsECsw7Bl04TWz+PYAiEB1nf
         fAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXNIuTkyGK/uUSwyaStHZPskpFgZ4tP6iVgccwVYu0G9FJ+BKLuJH2o0n8gp/FHQ7pS5WRai84gEVcgT2+Xcytg3U616m4/yHjxPrwbwLCcd2xVUCrR
X-Gm-Message-State: AOJu0Yz/A7W3NxPzKifnbS1aKEgiADT/HgPGSdkRBmyol41BgKF+qj0Q
	rxHN+KC4Fl10ovVCRAyeVDGvNKZssYUJ7wXyLwlU5KuLmjWODYpSIxqCz9tnzjG8y8e4mTJ+QLT
	rkUN+veqSLAi9X5aYzeJoik2992W5TihHQwkxQ3GIeEHHDu3nDI6yQm73E8V7CPRC6LCuO4uNai
	+2GBbTis0Nrixpjzvc3gt1VSq1onyTQktkdDiNrIOxXPSkdS/NVwVsMp+n
X-Received: by 2002:a05:6a20:a128:b0:1b8:c2b0:fda2 with SMTP id adf61e73a8af0-1bcbb5d35abmr6483081637.43.1718877790911;
        Thu, 20 Jun 2024 03:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRC/XV2Fx8DNpODYsdVD20HF/u2bDPNfi/2ArFUsKbmboVuPQ5TpjVvdf+CxrBHWox1y0ZaJh1X8phqUki8Zs=
X-Received: by 2002:a05:6a20:a128:b0:1b8:c2b0:fda2 with SMTP id
 adf61e73a8af0-1bcbb5d35abmr6483047637.43.1718877790530; Thu, 20 Jun 2024
 03:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com> <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 20 Jun 2024 12:02:59 +0200
Message-ID: <CAFqZXNsQQMxS=nVWmvUbepDL5NaXk679pNUTJqe8sKjB6yLyhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> >>
> >> Hello:
> >>
> >> This series was applied to netdev/net.git (main)
> >> by David S. Miller <davem@davemloft.net>:
> >
> > Welp, that was premature based on the testing requests in the other
> > thread, but what's done is done.
> >
> > Ondrej, please accelerate the testing if possible as this patchset now
> > in the netdev tree and it would be good to know if it need a fix or
> > reverting before the next merge window.
>
> Ondrej, can you confirm that you are currently working on testing this
> patchset as requested?

Not really... I tried some more to get cloud-init to work on FreeBSD,
but still no luck... Anyway, I still don't see why I should waste my
time on testing this scenario, since you didn't provide any credible
hypothesis on why/what should break there. Convince me that there is a
valid concern and I will be much more willing to put more effort into
it. You see something there that I don't, and I'd like to see and
understand it, too. Let's turn it from *your* concern to *our* concern
(or lack of it) and then the cooperation will work better.

BTW, I was also surprised that David merged the patches quietly like
this. I don't know if he didn't see your comments or if he knowingly
dismissed them...

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


