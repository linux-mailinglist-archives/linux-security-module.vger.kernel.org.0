Return-Path: <linux-security-module+bounces-3554-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618758D0EC5
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D30E1C209F2
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C722770E;
	Mon, 27 May 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcbWi//G"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940A17BB6
	for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843156; cv=none; b=KTXK7/ULwB9eJ1YrQEFkFdQE1DKTcLL5KYQ9QWbcbEIWRqLzXNoA4eopU2NKzKRMS1FZ75RPlqfItNbNmckypqiWh1SAX0100PLHz/3feCXFocf99ZJs8qD0HicbjBh4to2vOQXrGlFklni18eMb5QwhIRWV89wSyRhE3hRrLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843156; c=relaxed/simple;
	bh=wudtqjXegGU2LtEgfC5Ee2aj9ydGYtWtwEHcvXo/4S0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6AlBhQfpWGZM8vQZUq898+/xFZS0my25pCkA3Zj2d1a+fLRC5WSCMY+sG+NZ6Mc4eWHKYrZIx5UBLlLD8XgVnALScXQ6TVX6+Yhs8g4M3/QdQkyKSbkb4qBIwQDVKI8NIsUfNMxfIUkleEu9mCHc4n6YqX+d6iH93MEQXpGSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcbWi//G; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df796aaa57dso165116276.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716843154; x=1717447954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdSWbeuLkDTbi8rWZxWdxrTiYH7VS1P/CmuJ+z7yq7o=;
        b=VcbWi//GhbGv/psMmJLARTlU7QOQVYkrDvHl9GhF36Qs8bmMpqPbvGF6QTbQuatn/c
         Gn+BFhA5duxUdP6+EOHXzcBHowiQxDzoq4faeSiJTQRr6Ao0FNLyFqS/bpNwvCNqPsVw
         M6f/AV+L4KKuGellOYL1KZs5GHLH6nJx4sZ8Lt6JPlwvzof/J/S4NIzSEdfFaIVne3Rf
         By/Hzlknqj0L41sS0rMZik5jcuxoucULuBPpLkFZPNoaGhSpo5jLMoQtBTjPpVpu6xVg
         mxYuBVs72E4r0ePDm3NqtigcAi7L2ev1FO3vItUjlxhuFMpv4niCtT41icMVP6ZD+M5E
         whwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716843154; x=1717447954;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bdSWbeuLkDTbi8rWZxWdxrTiYH7VS1P/CmuJ+z7yq7o=;
        b=b0PPl97u9urTsL1seSgXVuN0YUp/YtxHv6vQc1JR/kYOECEejHHYtbLucjjs9T1Mo2
         N8opD76n4osrTXqhSFnc0q06odARmMcahsiXJxR62x+7s5BQoiulIq6FmGUSevQhDMKR
         7FagFlBtix6iH4zFTS2TsL1TJI4cY82fI1bJFInHn9eGAmCr65AXxZxkjqYlbvsnFcXG
         eRVnxYlTJPc6ArAY6sSV69Ev3sHEHmXQToG5d0ZtVdEumEKlC8kE2bLpRlMvjzDsx/Py
         BSnMm9G3HZzF5dDGt7GdC5SRe43OdtgtCH+KMJvz0/s+M0yC71Y/1m3HcAVA3lwFWzGw
         yy1g==
X-Forwarded-Encrypted: i=1; AJvYcCXmiNpVqa9ZqGbQEBKYdRGf0EkReF7U06lbpo7bb5zPWh8S7v3sSUVyJ4Xx/Zk1Z1aPtgZbLajUNZyanLdK7NepzQ1uvXinsXjk+BOS+35cU8qjOgy5
X-Gm-Message-State: AOJu0YyNXB14osZEYYHndPAnOWeKkYaWOPePYey60rRVFhtTAs6+c6jM
	plqOOegw3QIK18gRKw+iqIalZO4Ag9PvBRnYHw/7cNWq3AeY2vUXnY900Za4MITDkDBTkh3Y10g
	+rg==
X-Google-Smtp-Source: AGHT+IHDLacknHXmGIL0fTHZIViFSMUziqkpSLS4ou7PKscFtSM39cprVmoLrkxlA8wxM5OY6SXv9Fa4dTU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:943:0:b0:dce:5218:c89b with SMTP id
 3f1490d57ef6-df77217397cmr911644276.5.1716843154243; Mon, 27 May 2024
 13:52:34 -0700 (PDT)
Date: Mon, 27 May 2024 22:52:31 +0200
In-Reply-To: <20240524093015.2402952-5-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com> <20240524093015.2402952-5-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZlTyj_0g-E4oM22G@google.com>
Subject: Re: [RFC PATCH v2 04/12] selftests/landlock: Add protocol.socket_access_rights
 to socket tests
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

I see that this test is adapted from the network_access_rights test in
net_test.c, and some of the subsequent are similarly copied from there.  It
makes it hard to criticize the code, because being a little bit consistent =
is
probably a good thing.  Have you found any opportunities to extract
commonalities into common.h?

On Fri, May 24, 2024 at 05:30:07PM +0800, Mikhail Ivanov wrote:
> Add test that checks possibility of adding rule with every possible
> access right.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>=20
> Changes since v1:
> * Formats code with clang-format.
> * Refactors commit message.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 4c51f89ed578..eb5d62263460 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -178,4 +178,32 @@ TEST_F(protocol, create)
>  	ASSERT_EQ(EAFNOSUPPORT, test_socket(&self->unspec_srv0));
>  }
> =20
> +TEST_F(protocol, socket_access_rights)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D ACCESS_ALL,
> +	};
> +	struct landlock_socket_attr protocol =3D {
> +		.family =3D self->srv0.protocol.family,
> +		.type =3D self->srv0.protocol.type,
> +	};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	for (access =3D 1; access <=3D ACCESS_LAST; access <<=3D 1) {
> +		protocol.allowed_access =3D access;
> +		EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       &protocol, 0))
> +		{
> +			TH_LOG("Failed to add rule with access 0x%llx: %s",
> +			       access, strerror(errno));
> +		}
> +	}
> +	EXPECT_EQ(0, close(ruleset_fd));

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

P.S. We are inconsistent with our use of EXPECT/ASSERT for test teardown.  =
The
fs_test.c uses ASSERT_EQ in these places whereas net_test.c and your new te=
sts
use EXPECT_EQ.

It admittedly does not make much of a difference for close(), so should be =
OK.
Some other selftests are even ignoring the result for close().  If we want =
to
make it consistent in the Landlock tests again, we can also do it in an
independent sweep.

I filed a small cleanup task as a reminder:
https://github.com/landlock-lsm/linux/issues/31

=E2=80=94G=C3=BCnther

