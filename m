Return-Path: <linux-security-module+bounces-4938-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B19586F8
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2024 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251AF1C20C4A
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2024 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE24F18DF60;
	Tue, 20 Aug 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gW+JM9t"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A315C12F
	for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157090; cv=none; b=fFegUCs7qS2AH6vU2G0y7k5uFCw5xbPQSsTS1O3sJOqkWko4hOlNuQz7exWRL6WbRk0mbzZd6qff4/zZNVkRGCT3QI2tRn5nE7CikRFP6r/cbFkVSmZLIDRXalVjRGh3e74bZxZBQ0UDRSo2G6tpaiT4Pv5wOqgtqt2aqO0XfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157090; c=relaxed/simple;
	bh=0wYHPD3eK5OFdLui6sg4rayslo5o6cYdWBZeEqz+90Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qIVmlHYjZjlsAbwhiFf7qJ9/ZaKVaXK2rwyGDK7AO0angUHr7imx6yPajj0PsJDxhre0TQFpP8ARK2y+x0y9vg59DRa22X2tYmNiz6PwcsdCIdmGbFAgy8fvw7/UzR4/UaRxDXeYVXqTUhknlOEcZOdRtWrdtL3BvTEf6wq1EZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gW+JM9t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1173581259so7821089276.2
        for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724157088; x=1724761888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ChAFoVLSIZIE0px+eXGi0Bpydn/wgwcjDvJ/RjifIk=;
        b=2gW+JM9tVMa7rdLVvcpAy6bck5GxOT3rooHXcVqpPxvuThXI6XgVQmNZTAyQy4csew
         JMeeSi3JLd4bqhIZ7/G6XorvkIwxvviekVCMpqcMQ9wNdYIy8pUMMhoTPa5zR2ghLyk3
         Nzky/k9auQ/Nkoq5TKawdagHei8WJkxHYhXQkmix16d+enYpafSubyIEkzft8EaNZj/X
         DvanecfwrxL/kiemRw0qkULtx4XI+8/uhvfMGBLjGb+bAHSMzYr6JPETQrl8z1Qj1flR
         CnqQbJ/vDEsrfsR960m7hxsEWtuW4BenKpORmD16nLM5APyTDS8NgH2cVyA06aHUDAHI
         fGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724157088; x=1724761888;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ChAFoVLSIZIE0px+eXGi0Bpydn/wgwcjDvJ/RjifIk=;
        b=Lu/cdTzvpBvQr2XD7YA2pAwH0437bjDoE1JwVJIhWMAnSuRiLIc6ArOOE/bpMDsFSt
         Jg+vKWw3p3DfwPGFV+V04ES6fnLFqujxZ9CptEfVynWuesQxDZcFQoux4iQsxvdg+T21
         o81GW4NaTtQtVzFJf8jaoCa/BVD/3E2n+joQR5AzqlRUrw9ZqaywyhEo6u/fBC3msmFc
         G7JF4U6E3JwZ44h/Xt3FeufTbrHoiO/JWlUcY84iRt1eadfxFNzEYZ6SpYqB2QXtPyX/
         10CmrO9ysFG92AKhFqCndifilFKSO0SfpOjcltsqloyBXFZyYbmjDBJZR6HhgrJVmAe2
         0Leg==
X-Forwarded-Encrypted: i=1; AJvYcCX2nlfe2NXLowJ22TiwSDaPCjuAxAD6mJV57Jvc35lRtsbRNdKUFuPyAXhGEXJFy9v+iK3MX035JtmKZSV5NBXOLvqE0nC76Es3KALPPNq14B4xqjvl
X-Gm-Message-State: AOJu0Yy+sDVFi8AyxbwRupqFLwfSWb4vHlrEalAN6d0qNPkn+1cuw6dh
	p0GSfb0HHtBN0Pf93+CIWwsdOUI3apzw2GXPwVT6+1+TT9dmn90iHMarTwuAvz7XwCNv0a3Wec9
	DUw==
X-Google-Smtp-Source: AGHT+IEX6Y51CXFLV/a1HNQJzXlkPrUbOoWG5wsgOFT6HvWtkK7RdBHKDw5YqsqVpu8jQ1gzLMu38Dcxlgw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:208:b0:e11:6e94:3204 with SMTP id
 3f1490d57ef6-e1180fa07d1mr22797276.12.1724157088101; Tue, 20 Aug 2024
 05:31:28 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:31:26 +0200
In-Reply-To: <20240814030151.2380280-5-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814030151.2380280-1-ivanov.mikhail1@huawei-partners.com> <20240814030151.2380280-5-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZsSMe1Ce4OiysGRu@google.com>
Subject: Re: [RFC PATCH v2 4/9] selftests/landlock: Test listening restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:01:46AM +0800, Mikhail Ivanov wrote:
> Add a test for listening restriction. It's similar to protocol.bind and
> protocol.connect tests.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  tools/testing/selftests/landlock/net_test.c | 44 +++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index 8126f5c0160f..b6fe9bde205f 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -689,6 +689,50 @@ TEST_F(protocol, connect)
>  				    restricted, restricted);
>  }
> =20
> +TEST_F(protocol, listen)
> +{
> +	if (variant->sandbox =3D=3D TCP_SANDBOX) {
> +		const struct landlock_ruleset_attr ruleset_attr =3D {
> +			.handled_access_net =3D ACCESS_ALL,
> +		};
> +		const struct landlock_net_port_attr tcp_not_restricted_p0 =3D {
> +			.allowed_access =3D ACCESS_ALL,
> +			.port =3D self->srv0.port,
> +		};
> +		const struct landlock_net_port_attr tcp_denied_listen_p1 =3D {
> +			.allowed_access =3D ACCESS_ALL &
> +					  ~LANDLOCK_ACCESS_NET_LISTEN_TCP,
> +			.port =3D self->srv1.port,
> +		};
> +		int ruleset_fd;
> +
> +		ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
> +						     sizeof(ruleset_attr), 0);

Nit: The declaration and the assignment of ruleset_fd can be merged into on=
e
line and made const.  (Not a big deal, but it was done a bit more consisten=
tly
in the rest of the code, I think.)

> +		ASSERT_LE(0, ruleset_fd);
> +
> +		/* Allows all actions for the first port. */
> +		ASSERT_EQ(0,
> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +					    &tcp_not_restricted_p0, 0));
> +
> +		/* Allows all actions despite listen. */
> +		ASSERT_EQ(0,
> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +					    &tcp_denied_listen_p1, 0));
> +
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}

This entire "if (variant->sandbox =3D=3D TCP_SANDBOX)" conditional does the=
 exact
same thing as the one from patch 5/9.  Should that (or parts of it) get
extracted into a suitable helper?

> +	bool restricted =3D is_restricted(&variant->prot, variant->sandbox);
> +
> +	test_restricted_net_fixture(_metadata, &self->srv0, false, false,
> +				    false);
> +	test_restricted_net_fixture(_metadata, &self->srv1, false, false,
> +				    restricted);
> +	test_restricted_net_fixture(_metadata, &self->srv2, restricted,
> +				    restricted, restricted);

If we start having logic and conditionals in the test implementation (in th=
is
case, in test_restricted_test_fixture()), this might be a sign that that te=
st
implementation should maybe be split apart?  Once the test is as complicate=
d as
the code under test, it does not simplify our confidence in the code much a=
ny
more?

(It is often considered bad practice to put conditionals in tests, e.g. in
https://testing.googleblog.com/2014/07/testing-on-toilet-dont-put-logic-in.=
html)

Do you think we have a way to simplify that?


Readability remark: I am not that strongly invested in this idea, but in th=
e
call to test_restricted_net_fixture(), it is difficult to understand "false=
,
false, false", without jumping around in the file.  Should we try to make t=
his
more explicit?

I wonder whether we should just pass a struct, so that everything at least =
has a
name?

  test_restricted_net_fixture((struct expected_net_enforcement){
    .deny_bind =3D false,
    .deny_connect =3D false,
    .deny_listen =3D false,
  });

Then it would be clearer which boolean is which,
and you could use the fact that unspecified struct fields are zero-initiali=
zed?

(Alternatively, you could also spell out error codes here, instead of boole=
ans.)

> +}
> +
>  TEST_F(protocol, bind_unspec)
>  {
>  	const struct landlock_ruleset_attr ruleset_attr =3D {
> --=20
> 2.34.1
>=20

=E2=80=94G=C3=BCnther

