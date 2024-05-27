Return-Path: <linux-security-module+bounces-3555-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC58D0F3A
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 23:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37F71F2105C
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85FF16DEB0;
	Mon, 27 May 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWWZVwqT"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240916D9CF
	for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844159; cv=none; b=qqerJGTkO/wEY9e885T+604kBHA1uJp7fKXOzDWLTyF7iaqsLi0K9UKV1lY+WcdIBbSGOsd7FQYDZxTIwUcZUmlAldEaAwGVgXbC2XCLKGx5u1j/HYzbodZrdndf/8/+Dk4E6CA2PeH9tCOgokgS4vC/7rQlmJ//ZxwdXS8h5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844159; c=relaxed/simple;
	bh=B2sdpk0KWi/B5qJynwoFYyupEtL+8nOcnizJswXywzs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AsE06HlLFWlJrKv+WYYX3A0KWgd0WRpWwf/jBdJd+BMWqknsTba5skphxstRlIttoOwPQiuPvsjNJzzrCnDPYBJLCCOoNv1aqkyb38uIjE8nSkrFtD/V0SMcMNMxiiHV5DmYFdC7osrRzdJfEXEaLV/1WRoo9F46Zbc7uwXx/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWWZVwqT; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5785e7b92cbso52686a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716844156; x=1717448956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsuU1jT5jbBYuKJGyR0vYRn2b/uI6FX1lK3w7EnaKgg=;
        b=CWWZVwqTBJQb9Vsq3OW4nWiG/al5IYhwM7vQapoV7peG5anYuPv8UCsBDhullzA/A8
         rMr71KZyenM0bJznbKZz2WgYp6GNhvfLEp9Fw3zpwc6ggDQ4eBpCrRKxr8lUS50roH7x
         xmYGKaAfv2oFf6wNPzp0Jo+LfhbD5ptuRpzQypyaUbmd7J5RhRsOdcffESVj2dn4J2sA
         HpWfVBg7Xd0vKDPX8310p5gAsOupTk2LGpTxTPGnC94QHSnOtD5zZOMbs472iN4Koqhf
         UAEQi2B57vpP5rv4x+RaNWx10Ce7QHDAPiwhPdXu0wJ4NnEnn23u+tkupFAC2rHg55Qm
         OJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844156; x=1717448956;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsuU1jT5jbBYuKJGyR0vYRn2b/uI6FX1lK3w7EnaKgg=;
        b=J8/gFB9nRcwIE58FhP0+dVzjUKrk2WVV944ehi0ShoXLdWNRZxJPsB4GSAaGc046lU
         3AWe7pdqnkPwYBcDaHDXF6hv0fJAjnc1rQSvtD/bEW8XU9T/wnA7jwRSGA/ipOJfABwp
         rY1nVoihy2Kp2MYCbbUmg5bcnShp4HyTiqv4YoaVPvaVC3wIm/zcEMFiBXDLGq56hTzq
         rnyienFenmTgBy/cf1UfL09ZXlLhn6Ve1/nwYWeyp8vy22YK09YcxVio7JZJrNpU75ma
         MwZBWAZ2aMZVh//zqt+zzsuVhcN4YlI8RDgZ0yBsU2UxIkb9H/Kkgiq47XNCsuOs6hDo
         qCZw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZBuA03bit56CEg64re6EumH78XejBufwHZyMey2vtdI9nsXNptXbPp5bIZa9HU6emUGqf1O9bjFhezWM2420mfojS6GGuOQY011y5aMiFn/4RXE3
X-Gm-Message-State: AOJu0YxRtR+C+RA7Zg69WlnDkVxYqusGDqX3L9X+GIx9GzU/jHB+pZA2
	BEcGb2Xu45vjtBuPEz2bYD3sNzqMP3yYJKD2oxlSUEAXPo7Jl9XKO9OSo02o8Ig1SxikeoQgG6s
	EtQ==
X-Google-Smtp-Source: AGHT+IHIN3d5YINuHAotEC4UxRkqcfccx/A2KpD7+JS/UKBjxJVjWI3KslNY0Cmuac66sqraieanwYleU6g=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:478c:b0:a55:8f2a:9508 with SMTP id
 a640c23a62f3a-a626512671cmr1059666b.10.1716844155608; Mon, 27 May 2024
 14:09:15 -0700 (PDT)
Date: Mon, 27 May 2024 23:09:13 +0200
In-Reply-To: <20240524093015.2402952-9-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com> <20240524093015.2402952-9-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZlT2edk0lBcMPcjp@google.com>
Subject: Re: [RFC PATCH v2 08/12] selftests/landlock: Add tcp_layers.ruleset_overlap
 to socket tests
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:30:11PM +0800, Mikhail Ivanov wrote:
> * Add tcp_layers fixture for tests that check multiple layer
>   configuration scenarios.
>=20
> * Add test that validates multiple layer behavior with overlapped
>   restrictions.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>=20
> Changes since v1:
> * Replaces test_socket_create() with test_socket().
> * Formats code with clang-format.
> * Refactors commit message.
> * Minor fixes.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 751596c381fe..52edc1a8ac21 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -299,4 +299,113 @@ TEST_F(protocol, inval)
>  				       &protocol, 0));
>  }
> =20
> +FIXTURE(tcp_layers)
> +{
> +	struct service_fixture srv0;
> +};
> +
> +FIXTURE_VARIANT(tcp_layers)
> +{
> +	const size_t num_layers;
> +};
> +
> +FIXTURE_SETUP(tcp_layers)
> +{
> +	const struct protocol_variant prot =3D {
> +		.family =3D AF_INET,
> +		.type =3D SOCK_STREAM,
> +	};
> +
> +	disable_caps(_metadata);
> +	self->srv0.protocol =3D prot;
> +	setup_namespace(_metadata);
> +};
> +
> +FIXTURE_TEARDOWN(tcp_layers)
> +{
> +}
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tcp_layers, no_sandbox_with_ipv4) {
> +	/* clang-format on */
> +	.num_layers =3D 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tcp_layers, one_sandbox_with_ipv4) {
> +	/* clang-format on */
> +	.num_layers =3D 1,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tcp_layers, two_sandboxes_with_ipv4) {
> +	/* clang-format on */
> +	.num_layers =3D 2,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tcp_layers, three_sandboxes_with_ipv4) {
> +	/* clang-format on */
> +	.num_layers =3D 3,
> +};
> +
> +TEST_F(tcp_layers, ruleset_overlap)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	const struct landlock_socket_attr tcp_create =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family =3D self->srv0.protocol.family,
> +		.type =3D self->srv0.protocol.type,
> +	};
> +
> +	if (variant->num_layers >=3D 1) {
> +		int ruleset_fd;
> +
> +		ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
> +						     sizeof(ruleset_attr), 0);
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		/* Allows create. */
> +		ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       &tcp_create, 0));
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	if (variant->num_layers >=3D 2) {
> +		int ruleset_fd;
> +
> +		/* Creates another ruleset layer with denied create. */
> +		ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
> +						     sizeof(ruleset_attr), 0);
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	if (variant->num_layers >=3D 3) {
> +		int ruleset_fd;
> +
> +		/* Creates another ruleset layer. */
> +		ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
> +						     sizeof(ruleset_attr), 0);
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		/* Try to allow create second time. */
> +		ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       &tcp_create, 0));
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	if (variant->num_layers < 2) {
> +		ASSERT_EQ(0, test_socket(&self->srv0));
> +	} else {
> +		ASSERT_EQ(EACCES, test_socket(&self->srv0));
> +	}
> +}

Wouldn't this be simpler if you did multiple checks in one test, in a seque=
nce?

  * Expect that socket() works
  * Enforce ruleset 1 with a rule
  * Expect that socket() works
  * Enforce ruleset 2 without a rule
  * Expect that socket() fails
  * Enforce ruleset 3
  * Expect that socket() still fails

Then it would test the same and you would not need the fixture.
If you extracted these if bodies above into helper functions,
I think it would also read reasonably well.

=E2=80=94G=C3=BCnther

