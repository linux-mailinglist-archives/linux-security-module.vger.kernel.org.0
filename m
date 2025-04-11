Return-Path: <linux-security-module+bounces-9313-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E02A851FD
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Apr 2025 05:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DD319E7CC7
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Apr 2025 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21E1E5711;
	Fri, 11 Apr 2025 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a7GqLb5B"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF35EEB5
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341853; cv=none; b=roCDzdoQMPgiZ0NO6ec74Kb22oI3xCdoekNX2d1JlcOhR2Wjdx3h9poEFcNC/31uOJ3K2XMwTeKTbHSbj1+Zrb58TC9RFgjxe6C02vBNxzb18wP6q6mNY2Dw+oSp9WhqzAM7qzsev5WeWDu3zBMr+F8y7JB3yjSwpXldZNWkVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341853; c=relaxed/simple;
	bh=ujs7jd1AcHTfjODGw4xMtcroralW80H1IoAIGv0b7W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehuzluMbDsxk57176UZRpTGCY63XLX1Bhud2rgs9SwQNnEW5qWkp2EFXVrww/7zrcA/fn5c5/R5/gP8BJ0x6MaeOHa9uR9zhcmuBJaEv+dy3zJ86P1WZjjLy1an3mvYDDOzRtuuPyXXQ4Mq1ngyFVoCZ1/9eUl2blnMESXBvFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a7GqLb5B; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ff37565154so14746137b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744341851; x=1744946651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qN9mJppk9m3CDDb4tP7CpLpRZYM8/nU0T5H+EiAwgc=;
        b=a7GqLb5Ba45B9r8uXU8jmbi8ce/vfMfcLQlLED0gnFcd0jMWIp/7vcVeoffIr41IJj
         Gm3pH4Kr4P4ge2/1mXdvmjsRWb0J8fC1K1FrTAA/N7IBATGrjfBOsXbCpZ8f1lMALHzd
         oEAK8kPLE6Oq+Mzwq8agucbDNY7M6qWl8O2VIuZ2Sg6gAdoXYYpKoEVS0lebQm/gpF0L
         HGbqKz3awmZRq1c7sINae8TIj04d+dtrr1i2CopaBmezg3PjxYYeqlcOhFIZ+fQijTvV
         B7ysSJxX4yPB/3WwHmHRv6Fs28s74sQPPzazixaH+O3JiMzvOvk4CJ3tjg4f9HK7ipmQ
         1Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744341851; x=1744946651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qN9mJppk9m3CDDb4tP7CpLpRZYM8/nU0T5H+EiAwgc=;
        b=fd7kze6CiPmx0W4kqLS0/ccvP6IRkNsql4SnlyDf77u4FwC/FbgPMFfkjzVsxU5tCe
         3ZXZsS6htXOprw/mv7QLHDrYzRgZbERryDjadXQavlwRZsgn2rCse8KV0zD2K5gUlaBt
         D1Y4oOlAYVxI+48FX6Auz8cjXrzBo6NApaT+gBM6GNfut+fmyGlEFcM0HPhx/gh0aQIk
         UNpV3YtKgd2heGyrq2UHhUxbSIBGO3SQTDJlKxHIc+FJgnkVWPBRWOxcCCT8PkvY7udT
         +d5GqCIi4jXKxTfbLjgpRiPrMNsULS9NdSpzgVvQHXH9VH8OUByq1+hKcuhwx+FzkHRz
         cQLg==
X-Gm-Message-State: AOJu0YxwnlkSoWVXdino/mXSCkDXOsGLu3JzgS6t8qFFWj4yf9RsYdoy
	uFVT5UgUBpn7AcnkDr4DTdLH60lPRC+Vezocmn/z8JhOnH1iNsjSTJ96eCNnQgAy6or7JkHh7GN
	JXHNHGIATMnl7iEx9W5DXVE7QZvRh50BPzhju
X-Gm-Gg: ASbGncuuyz5qMSq3zAFokUxNKkMiOArkjz8Xe/vicYHEBKtjPliZWt669Ed/AdHg3Bq
	K1AFgEO/Ji29jcFqROb84+tHBjNtrq9smfsVYKNdnTtoRUxJMiyyW6KKZ8JuUDzCaBeY22vrZ3R
	Vcw62MCqmekVmTpVZmh3aZtA==
X-Google-Smtp-Source: AGHT+IE4fYUezw6IfzfviQ/ZZijnML8EU+to+wNGjCX+ZjeYAlCZVKFnQkajk0HElbRaL1B4IkdGQyNePl3S2Li/G9c=
X-Received: by 2002:a05:690c:64c1:b0:6fb:5498:70fa with SMTP id
 00721157ae682-70559a011abmr23137967b3.18.1744341851125; Thu, 10 Apr 2025
 20:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-57-paul@paul-moore.com>
 <CAEjxPJ6ZUXoMzKPE6iwQpvG-_SruVr+kxU-a+nQXU=ToVr8wgA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6ZUXoMzKPE6iwQpvG-_SruVr+kxU-a+nQXU=ToVr8wgA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 23:24:00 -0400
X-Gm-Features: ATxdqUESEq9J-FHTX-je-b_2DfSVgzpAAFA4amiAciURoYmV2TsC7C4ox5Tyv-A
Message-ID: <CAHC9VhTDrVMW8LLbNwQ=ApcpQmdoFWk5RLMEyMBJygQLFJNE2w@mail.gmail.com>
Subject: Re: [RFC PATCH 26/29] selinux: move initcalls to the LSM framework
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 12:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Apr 9, 2025 at 2:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > SELinux currently has a number of initcalls so we've created a new
> > function, selinux_initcall(), which wraps all of these initcalls so
> > that we have a single initcall function that can be registered with the
> > LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
>
> > diff --git a/security/selinux/include/audit.h b/security/selinux/includ=
e/audit.h
> > index d5b0425055e4..5989f8dd1e86 100644
> > --- a/security/selinux/include/audit.h
> > +++ b/security/selinux/include/audit.h
> > @@ -15,6 +15,11 @@
> >  #include <linux/audit.h>
> >  #include <linux/types.h>
> >
> > +/**
> > + * XXX
> > + */
>
> Assuming this will be fixed before merge.

Yep, I noticed that very shortly after posting and added the comment block.

> > +int selinux_audit_rule_avc_callback(u32 event);
> > +
> >  /**
> >   * selinux_audit_rule_init - alloc/init an selinux audit rule structur=
e.
> >   * @field: the field this rule refers to
> > diff --git a/security/selinux/include/initcalls.h b/security/selinux/in=
clude/initcalls.h
> > new file mode 100644
> > index 000000000000..6674cf489473
> > --- /dev/null
> > +++ b/security/selinux/include/initcalls.h
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * SELinux initcalls
> > + */
> > +
> > +#ifndef _SELINUX_INITCALLS_H
> > +#define _SELINUX_INITCALLS_H
> > +
> > +int init_sel_fs(void);
> > +int sel_netport_init(void);
> > +int sel_netnode_init(void);
> > +int sel_netif_init(void);
> > +int sel_netlink_init(void);
> > +int sel_ib_pkey_init(void);
> > +int selinux_nf_ip_init(void);
>
> The last two only exist if certain Kconfig options are set.

Good catch, thanks.  The use of the netfilter initcall is already
conditional on CONFIG_NETFILTER in selinux_initcall(), but I forgot
the InfiniBand inticall.

Unless I'm mistaken, it should be harmless to have the function
declaration regardless of if it is defined anywhere.

> > diff --git a/security/selinux/initcalls.c b/security/selinux/initcalls.=
c
> > new file mode 100644
> > index 000000000000..81f01f8ad215
> > --- /dev/null
> > +++ b/security/selinux/initcalls.c
> > @@ -0,0 +1,50 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * SELinux initcalls
> > + */
> > +
> > +#include <linux/init.h>
> > +
> > +#include "initcalls.h"
> > +
> > +/**
> > + * selinux_initcall - Perform the SELinux initcalls
> > + *
> > + * Used as a device initcall in the SELinux LSM definition.
> > + */
> > +int __init selinux_initcall(void)
> > +{
> > +       int rc =3D 0, rc_tmp =3D 0;
> > +
> > +       rc_tmp =3D init_sel_fs();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D sel_netport_init();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D sel_netnode_init();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D sel_netif_init();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D sel_netlink_init();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D sel_ib_pkey_init();
>
> This one depends on CONFIG_SECURITY_INFINIBAND.

Fixed, thanks.

> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +#if defined(CONFIG_NETFILTER)
> > +       rc_tmp =3D selinux_nf_ip_init();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +#endif
> > +
> > +       return rc;
> > +}

--=20
paul-moore.com

