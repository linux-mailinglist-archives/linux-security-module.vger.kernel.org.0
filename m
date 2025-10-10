Return-Path: <linux-security-module+bounces-12391-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21532BCE2FE
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Oct 2025 20:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F8A19A6EAE
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Oct 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760D2F3C1E;
	Fri, 10 Oct 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4oMEfve"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD22F25FD
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119610; cv=none; b=Or4YhqCIUndncl+iPjoP2YKxF2C8Q45zQBZcnQV9YlTh1wngreov1+T/E22QV2KGh/EqH3pM5vq5TnE3OAfXcSvJo+82pkTR2kejwHEsiqeM7ONOn6Amq4KGUajMSpcG3lQQtD3KC6sfj8bFoudm61x3FqPmNCqmKernwBvdgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119610; c=relaxed/simple;
	bh=g6rAGjV2Nc5xVFKhlt4vH4nfZspBAllGy6FhsdVHNPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G268uy2KlVa6v6gHf9jjQK1euBGmJIGoeQFH7rhusWL9w4lOW1g03+HNmZi2eqIl/t+8QHmVvxPEC0bd0a5mjRIrhPNG7Rr1LVUBFVxitxWBFzntGuqnv3b68TlsWg0sWohL7ODBdmDJUY7neZUDVYtaPOkqLbNuNdC4Zdcd+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4oMEfve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0912C19422
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760119609;
	bh=g6rAGjV2Nc5xVFKhlt4vH4nfZspBAllGy6FhsdVHNPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f4oMEfve8o3X+V0a7MLiNB2N3+PG5WSRWXMVtUelwyksQh6FJUGzdC5V6lMU3xcrx
	 Q2xh7YoOBEiR9XIEPeU6tUv385RYABTKVzZNYeXPSUjdJjOZsphsu563OaFfXRuwVi
	 QP3Ci/I+++HevavFJIBUQgBlXpU+4LzItwl7Pd3TzIkf4lQzmWC8lVTT/01m5avjzv
	 0WNZrJkeMMbyGPDSouqjaxqoa46gfJmOD9LpsROlZbnxWamu7z+iItYXLdC3SmrJfc
	 1fpw5nlllO6QrPuNoeDUk6ko3Dkxcs7kqWd+isj2jHCSBrMHyZI6dvey2VXWQXhaka
	 4wDIVXZeGfSmQ==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79390b83c7dso20675276d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 11:06:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzpd16nj0RHpuUv35AKTOOWOSMrBOAJejZcsNWIlyYBnEX7KHlP
	zkYAhNfG73y9MbhPAs8B0czf0CpLsCDtxOw4lv7iyPXP3txqycocJrttDxW8OYHiUAazQeZ7Aoq
	ZNZKY4sWmv31lkn3psvO41iqK88vnmxg=
X-Google-Smtp-Source: AGHT+IHRUJUAeJ5Je+YkDxQC/r6OXXbCSgJvVm1kGkEkaJIEhWHQvapqgQY+O5ZOx/oTWMHOfXFhHohJ7guwKL4YvOI=
X-Received: by 2002:a05:6214:19cc:b0:795:67ac:ca5d with SMTP id
 6a1803df08f44-87b2109283cmr190852096d6.30.1760119607787; Fri, 10 Oct 2025
 11:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com> <20251010132610.12001-2-maxime.belair@canonical.com>
In-Reply-To: <20251010132610.12001-2-maxime.belair@canonical.com>
From: Song Liu <song@kernel.org>
Date: Fri, 10 Oct 2025 11:06:36 -0700
X-Gmail-Original-Message-ID: <CAHzjS_uBq8xGCSmHC_kBWi0j8DCdwsy4XtfkH2iH6NygCcChNw@mail.gmail.com>
X-Gm-Features: AS18NWD0sroF_9UF1VNMCiu_x8h4vyhFWvp2MLYPnP6wYTvtieiio2L0R61pPKg
Message-ID: <CAHzjS_uBq8xGCSmHC_kBWi0j8DCdwsy4XtfkH2iH6NygCcChNw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] Wire up lsm_config_self_policy and
 lsm_config_system_policy syscalls
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net, 
	kees@kernel.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, 
	rdunlap@infradead.org, linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:27=E2=80=AFAM Maxime B=C3=A9lair
<maxime.belair@canonical.com> wrote:
[...]
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -118,3 +118,15 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids,=
 u32 __user *, size,
>
>         return lsm_active_cnt;
>  }
> +
> +SYSCALL_DEFINE6(lsm_config_self_policy, u32, lsm_id, u32, op, void __use=
r *,
> +               buf, u32 __user, size, u32, common_flags, u32, flags)
> +{
> +       return 0;
> +}
> +
> +SYSCALL_DEFINE6(lsm_config_system_policy, u32, lsm_id, u32, op, void __u=
ser *,
> +               buf, u32 __user, size, u32, common_flags, u32, flags)
> +{
> +       return 0;
> +}

These two APIs look the same. Why not just keep one API and use
one bit in the flag to differentiate "self" vs. "system"?

Thanks,
Song

