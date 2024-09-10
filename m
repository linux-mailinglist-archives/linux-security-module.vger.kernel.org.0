Return-Path: <linux-security-module+bounces-5414-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2744C972FB3
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2024 11:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A58D1C23F00
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2024 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978213AD09;
	Tue, 10 Sep 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkhmPsTl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34F185B72
	for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962032; cv=none; b=sd4d/TUvd6bFb8yUBu56Zkgawj5iy0z5YFh42fIeVYWj6tgNej0QR1HW8xFShETTd6AE86o/vCt1muL++EZRT8h8BXTiN3dsEREixXsxHDwg7vExspQrU0bsm+84QGQWEFNEXwrSV7eOOn24llERblBOrxVCmzV7UD0AUsLSewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962032; c=relaxed/simple;
	bh=P2QgNQVbnWqUf9E81eBquhK8ELfIYoPeyv7XxDqNpwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZQnPThFh6LyDrnTrWMELVTF7owO/g3lBihSbDV1K/deYz/s8F+GA7HDfa2gwj0cA6mv50L9CC3TzmBDsV5dwHMvFiQoWQFqQ5Q6Ipm27e5UceT7j2cDnDiUr3lnD/X5jpOeKI0rILlrhKFj2jcWtUW9ktw1wAZpigyXjPzW6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkhmPsTl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4daca4a4bso124835357b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2024 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725962029; x=1726566829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htdu7gDJb2RXBiSiRNLgmzPRTEXOF0XUOmdJwojMinU=;
        b=rkhmPsTlPqPell2ceM7Dhm2wExii/M+j4fkYaIMwlM0MbkZ8PnpPE9rk6/3o7O07d6
         FzpqFsFQDYHC80PCgGzN1Rh19jhrq0cD+Dfl0ypCdp+p6CDgtlJlgFVf9DTWccDIDCUT
         SrdgdqdIBZRQPeil/UulhB6JW11l24Bm+8lT3jLdvTtOS8YG+09CZc8EK+o6G9Nc0brP
         aNTp1JGyLArN4nvVuT6XRw16b8ppO3ezgEYd9UYhdm00QEDIxXvnY3hjbRHgwmWy3uR0
         34Bqv6aRxWtE6xdNdH45CmdGbKb8WC7cgs28Fo2OoTkDoIQz2rfv1dD5cTvO0DjynVgD
         J9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962029; x=1726566829;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=htdu7gDJb2RXBiSiRNLgmzPRTEXOF0XUOmdJwojMinU=;
        b=RDe6G/gliQkJpcw+2FIjSLMwCMTgvS0ex6evG8LKUqzYRm04ql7xat0p8V7UlKHPhi
         dpra6FpmmWABgRisxKUMIb1n5ym+zcsJPm4FGWGLusBqHITOfs0sht/UDwKUpARd3w8E
         +OsDN0mguuJaMgd74UsR/xdQTEw6o46bUruIL+ZVPexmve99hvU9cyzQ41PhVBILHeE6
         HOK6mWWp/77Xk08w3hPdLEgYRHjral4NnlK8czzNF21gROmg4nAaOjHd07iBaZZyikOs
         Zx2yPCkf47cC4ew2+PSin51OoasVmXz1m1iQR2hna0W+K1L1srnQzqiCAc2O7aohOSHn
         7+/A==
X-Forwarded-Encrypted: i=1; AJvYcCVp0NYLrdnAPa36EXOcrWFa6g4exmNaVIBk+aDqE3Z54vvMxyvBHBwiYfUa5Kr1X3cQ+jjLs1Ul0nA7K0yy88hgsRQ/WBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4xVFMcz1WuxCzZbUD1uwcYHX1Ar60r6JQ2mSxzV5JyGmy0+t
	+0SzH+/eqOBqlFGuvkYnoDgA7WU+2v8UHzNUvO28hHxN8mhXODjJgkVsyENJ/1vi4UARwHAt5HT
	aLQ==
X-Google-Smtp-Source: AGHT+IEj4kZV9r2+zjVhtoRcCn29CGlTh0LzKssnI32SUN244Iy+MkVQwaT4ckAV6lByV2bDmvtFVDeWTdE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:4481:b0:6d3:e7e6:8460 with SMTP id
 00721157ae682-6db9532edadmr1416287b3.1.1725962029627; Tue, 10 Sep 2024
 02:53:49 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:53:47 +0200
In-Reply-To: <20240904104824.1844082-6-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-6-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZuAXK7eoXxPNl9J-@google.com>
Subject: Re: [RFC PATCH v3 05/19] selftests/landlock: Test adding a rule for
 each unknown access
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:10PM +0800, Mikhail Ivanov wrote:
> Add test that validates behaviour of Landlock after rule with
> unknown access is added.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Replaces EXPECT_EQ with ASSERT_EQ for close().
> * Refactors commit title.
>=20
> Changes since v1:
> * Refactors commit messsage.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index cb23efd3ccc9..811bdaa95a7a 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -325,4 +325,30 @@ TEST_F(protocol, socket_access_rights)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F(protocol, rule_with_unknown_access)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D ACCESS_ALL,
> +	};
> +	struct landlock_socket_attr protocol =3D {
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	for (access =3D 1ULL << 63; access !=3D ACCESS_LAST; access >>=3D 1) {
> +		protocol.allowed_access =3D access;
> +		EXPECT_EQ(-1,
> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					    &protocol, 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

