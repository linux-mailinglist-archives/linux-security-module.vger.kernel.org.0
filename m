Return-Path: <linux-security-module+bounces-750-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FE820216
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Dec 2023 22:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536DF1F22EEF
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Dec 2023 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764214A85;
	Fri, 29 Dec 2023 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b8vum6J4"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7918AE9
	for <linux-security-module@vger.kernel.org>; Fri, 29 Dec 2023 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dc14c9d364so1161301a34.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 Dec 2023 13:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703886754; x=1704491554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzJRlSWVm6Ky1MzryFL9uOXf+lgoElLZqlk80UflOcs=;
        b=b8vum6J4kNFQupnw2EKocDxfoPLKzXbVzak4Jiom/JyomvH/s7gNKoooizMotzCBY4
         FNHHBv7Z2ivkrFf+Dn6JHLa7QUTu2gC9cKvpAYnjb47eqIxrSPwYwMZbphWvyDGAvhqA
         pBLH4QsRlByNzFJP51ufYsg6sSZdhKkoRyzEpGZNZfbaOXjEvDsITMzl4Xd8nZ3oqq1I
         iItof5wLU75eN4hisGMBlOd+LEr8h1O8zSylsfRFz3rqVdpzes1IY613DK+21NR4fi3P
         kmDMGp3creFegDlKpq33ost9Kb0PFpdjdvrgczmoHBloDbilhJfnSxH2k01e4gRqzwrg
         N1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703886754; x=1704491554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzJRlSWVm6Ky1MzryFL9uOXf+lgoElLZqlk80UflOcs=;
        b=Ssa7AIdZhyy54AG9UTlZ5HwKglHGjp2hcWZ6xxd7XcOWvJfDitz+MYeIyXEMmhlMcp
         ScUvLx1YP8IHD8KNMbHoGs/4PgS7NHrhqwFq6jhlG8xgfjnfgbn5Fyft7vTpkH32Y9CS
         lju3fSAPjNZSN3P/6hLpGzT7S6zvmhpQub8p7eC6omcYBceblJlzBVKQzDj20TGDh4TJ
         0vFEoaQo3X/FP0jar1MRrbXWGk4wjOs+/bnG+Cwd1qKcrZPNqsHOCvaYPWwcYiQK5buf
         /KviTtmeXXLHkKzRzWDSG5qy5xVwSSsDJu54laZvyGoUqL08rHEWfTaTyjoAsqpzbqgC
         YrlQ==
X-Gm-Message-State: AOJu0YwykJMSf32sEr7lE+hKrL/Sbz1n+/F3uvEh3Ef4qF/ADAYCx2FT
	zYjP0xBv1a+FfhJJcNrWc6SuBxIL1AQ5Q/JfcKN6SVJMARgo
X-Google-Smtp-Source: AGHT+IFlPoiKzTIgMuaxqhSzJ7FAnpA1brpYNe7Nmv00kxPTis9P6sOIPgLtoqVlmFNPCZ27gOqIQt26Nnk0LUfm3Xs=
X-Received: by 2002:a05:6808:22a4:b0:3b9:e654:9010 with SMTP id
 bo36-20020a05680822a400b003b9e6549010mr10870570oib.34.1703886753764; Fri, 29
 Dec 2023 13:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229171922.106190-1-mic@digikod.net>
In-Reply-To: <20231229171922.106190-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Dec 2023 16:52:23 -0500
Message-ID: <CAHC9VhTrrJN9MRZD5XWXJiygq+jVN-xiRc-wkZP3tYB-2D+Frg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Fix error priority for bind with AF_UNSPEC on
 AF_INET6 socket
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 12:19=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> The IPv6 network stack first checks the sockaddr length (-EINVAL error)
> before checking the family (-EAFNOSUPPORT error).
>
> This was discovered thanks to commit a549d055a22e ("selftests/landlock:
> Add network tests").
>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@co=
llabora.com
> Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to sel=
inux_socket_bind()")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> Changes since v1:
> https://lore.kernel.org/r/20231228113917.62089-1-mic@digikod.net
> * Use the "family" variable (suggested by Paul).
> ---
>  security/selinux/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index feda711c6b7b..748baa98f623 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4667,6 +4667,9 @@ static int selinux_socket_bind(struct socket *sock,=
 struct sockaddr *address, in
>                                 return -EINVAL;
>                         addr4 =3D (struct sockaddr_in *)address;
>                         if (family_sa =3D=3D AF_UNSPEC) {
> +                               if (family =3D=3D AF_INET6 &&
> +                                   addrlen < SIN6_LEN_RFC2133)
> +                                       return -EINVAL;

If we want to try and match the non-LSM PF_INET6 socket handling as
much as possible, after the length check (above) we should fail any
non AF_INET6 addresses on an INET6 sock, see __inet6_bind().

My guess is we want something like this:

  if (family =3D=3D AF_INET6) {
    /* length check from inet6_bind_sk() */
    if (addrlen < SIN6_LEN_RFC2133)
      return -EINVAL;
    /* !AF_INET6 check from __inet6_bind() */
    goto err_af;
  }

>                                 /* see __inet_bind(), we only want to all=
ow
>                                  * AF_UNSPEC if the address is INADDR_ANY
>                                  */
> --
> 2.43.0

--=20
paul-moore.com

