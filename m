Return-Path: <linux-security-module+bounces-2772-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC088AB10B
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Apr 2024 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24481F24768
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Apr 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472112F378;
	Fri, 19 Apr 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7DbZJmg"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62712F376
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538203; cv=none; b=OPUldpFfqtHPx/IDf9JaqRMzYMfLs8RO5dhc6aV27q63i40i8+k2qSgfB37FhE83PVnH/kwD+Gbuz3M63OTp1k8b6zZiB+KaZZJ2D+tE6gWvJ/wkcaisV1dr4ywqH+vb6uULcjiMHs0K4tJ33NmQaLlpJlmZuzxZFKV70ijvcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538203; c=relaxed/simple;
	bh=I6EPAm2xm2kzZeOJpt+Oi8HGH0alo1KhTYBnKt9ikZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZT9vPGUOqLSLZ00hZOgYywAFptVR/is5AvbPfxpy5YXsXsU9c3+Qwyuu8IYqFofGPsV8twn3tqbys2tb+YLESEeC9oNv9mFSoEPpzzFrFzveReIWvzX5E2rsYzwVoCxwQ4zu9QzCzkYF+nGD5x8mbEtfgaufLNMRt0IvOHf9TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7DbZJmg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-617bd0cf61fso43774117b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713538201; x=1714143001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VHIBkqb8woaG3ld/bc1X6RgbFYc9DEdyv044t35jrM=;
        b=N7DbZJmguXGvgiUZzwSPHJOzGGWBGGXiql8Gq3dcTbpGg8m51dHYqE+x/AiO+YKpx6
         VyDRtLeiR7D0UGRvbx3FJwmMKslTHex3Q0x6VvLVoqQmm99qKj9Y1/Vr2ckJXO3y6IQV
         2306mWwwm6wBidgZoitI0Tp3VDB7QqPSg6mD301Gs6AJUuZ6btYskpIWeQg+YIEWc/vp
         pS2TYz1mB7TSqIAShzg0QAjJFXYTBcjML9P6clXSWNBVc0gpIWAHD+TzYD1tG4dCrtDz
         3Fn1lyiS/6BnFzpXU4vTjRAZBFwifXqnSqZXdbNOs9moF1z7fkc7dvRaS1dFNJYc1GWG
         dGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538201; x=1714143001;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VHIBkqb8woaG3ld/bc1X6RgbFYc9DEdyv044t35jrM=;
        b=my7YoOZKi8j9TlvlJp13ni9D6W86fLJrdaOqBnbn5FsBO2v+6H1kfmAIP3zaQi3P2i
         7GDRCJJo+vjlDZ7aiq2meeqca4manspwbP/heAfsHHO9VVq6sE8NBKAXGuASqCi6DAdH
         mPXuupHdt37rp1KQzTGN2sLU9SxXOUaMpPuhsZ1XXaqtYUl14IQkUxS3SLYwHFuql6ns
         +D+5G/5ezLM5hl5l/vP1JUPHe8UzFga40EIlkJrDia0Soxfl43k/ImoHJhtbvLwg6Z0q
         m6xggIsmAAzmTbCzdNympgQAIuSyQ+UswT3YdEHrbjHauA9iuco4Tp9Cn5l/q9JrqeFr
         KhlQ==
X-Gm-Message-State: AOJu0YwE/xbPdl1uQohn2g1dz2kTWk1phr6FYFx2O9ng5bqmVOSdi0VE
	ZO0Va9UOVU88PWUMasT/ignwr5YarskXAYg2gFiyXnvmWhJQGeg3IbTJG221e5MgnnE/8j6yf0Z
	/dg==
X-Google-Smtp-Source: AGHT+IF6awNiBQP8kFq9Mj3mq9oCz487eMAzONJjENkdGCDZF6zTUFwQz/hn6DifchohbB3P8QMKYzAu1d0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:f06:b0:618:8ec2:ccb0 with SMTP id
 dc6-20020a05690c0f0600b006188ec2ccb0mr563196ywb.7.1713538201416; Fri, 19 Apr
 2024 07:50:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:49:58 +0200
In-Reply-To: <20240418.dezuw1Ohg0ca@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-9-gnoack@google.com>
 <20240412.soo4theeseeY@digikod.net> <ZiEQXXXJnSiHrK1R@google.com> <20240418.dezuw1Ohg0ca@digikod.net>
Message-ID: <ZiKElubaXYAsYq4q@google.com>
Subject: Re: [PATCH v14 08/12] selftests/landlock: Exhaustive test for the
 IOCTL allow-list
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:44:43PM -0700, Micka=C3=ABl Sala=C3=BCn wrote:
> On Thu, Apr 18, 2024 at 02:21:49PM +0200, G=C3=BCnther Noack wrote:
> > I spotted an additional problem with FICLONERANGE -- when we pass a
> > zero-initialized buffer to that IOCTL, it'll interpret some of these ze=
ros
> > to refer to file descriptor 0 (stdin)... and what that means is not
> > controlled by the test - the error code can change depending on what th=
at
> > FD is.  (I don't want to start filling in all these structs individuall=
y.)
>=20
> I'm OK with your approach as long as the tests are deterministic,
> whatever FD 0 is (or not), and as long at they don't have an impact on
> FD 0.  To make it more generic and to avoid side effects, I think we
> should (always) close FD 0 in ioctl_error() (and explain the reason).

Done, good idea.

=E2=80=94G=C3=BCnther

