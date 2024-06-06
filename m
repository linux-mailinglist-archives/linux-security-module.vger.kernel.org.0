Return-Path: <linux-security-module+bounces-3700-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 694958FE7DD
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Jun 2024 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB37DB2692F
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Jun 2024 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB519642B;
	Thu,  6 Jun 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Um+VMPOe"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E67195FDA
	for <linux-security-module@vger.kernel.org>; Thu,  6 Jun 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680772; cv=none; b=jlW+dtEGzvKdhjTz5rCOcnnHjn/Bg2anwVfy0ldsBwDPC9rJmSlh59BH4KZLE7XHt8FnLzXDufRi6S3WleA/NwYkRiTzvHDJM05bznE0XM2jxOaoaT9DEMXG/B0l0Ryf7K1g27LJreic5fxSruTwfY6vUWcDtl24T0tNq9ZBNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680772; c=relaxed/simple;
	bh=IDd80NJllmVNE5Ugij2KDqZxJmhqpjO61qrSf5W0BaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rdZoufXJpfsjibd1RSg5JkEvTSkWd7urxOxvf03BETFqcmfbVNDkXAkje4FvV1wSGS+XqNlZUVE0b+21E2HLes3mi8LKZfSGZ9guXUJZVscHspghX6xvZ1q9/fc1X6bqRwQSz2UzdQ11JaCOkBvTCrZpCyRwbVioHuWTk9U2+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Um+VMPOe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a1e9807c0so9557487b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2024 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717680769; x=1718285569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwer1veUx7PsK487W5BK7a/yC4KwJGbvM/dbZUeKEGk=;
        b=Um+VMPOelgE91NQTIcwtDsFl1fMRR4gyD3/6kEJ1GUqM4k8rjsk4y1aFKCQ6CkhyvR
         TAD5DpqthHhKs9GY9M2GLC9mEGEUZdHkwaDWXyO+vaAwldm+ANZrrUayZFlNSmVxkQmh
         47bLSM34UO6aUdIXpJFEWTmEPvEEgGO5buvS9p0jj+Q2Y9HkdlDNK/fK9825l5pDG8XJ
         UGYFwG8rkd5MO/8dqOAekvI1KLP+ob4T42gnMhIb8wQlB4LAv7Qkp80//Z2pJpd7knSK
         0BqcuVHVqjWz8gDabSmA+85S86P6POd0yVBLqxR6JBaDYNEdorMlIs6uDOrvS0pmOcx/
         Uspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680769; x=1718285569;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwer1veUx7PsK487W5BK7a/yC4KwJGbvM/dbZUeKEGk=;
        b=BAofyWcxwBJLAew4PLuwziNVnzv2R6st7/uFKROLDF/P/iQG5WqomsE5GAT7bVNysp
         GGMElsG9VPeAAhsWvKusQJ1TLZQKAkuPDX/MaUPl39ElaA7KCyHLZJYOuL/6BOJiDpz1
         9eJwNlB67aXKGkN5ftpHOueSzVQlu31pfEnEwGmlNpQSEP8Fura6V4kKNUws0jhMbiba
         x+JOCLEeVkbVf0oDeDNGi7EqSWmRqCUAuBbc64EnB9xPfVxk0rbqQ7sAs/5SycVG939I
         +oHzjTj5r9TdDP8KoD+yl9tvx/jrZQ1N4ykFIf9ASZvCjI9J8GBGOgRu5n5AgLFiZzaP
         /Msg==
X-Forwarded-Encrypted: i=1; AJvYcCWVH+cchvNSkUTxgwPIMejLj2lt0bWSmi3AAx6xBavcKIOzIB76ILPSSBdRtnwDbT4iJDfGyTYMQchklBfOa0DhtSOCqvGGvxK5Nm6US8+Rgng8VK6x
X-Gm-Message-State: AOJu0YxwBrA2AyNGO+HApQtH6BuUktzWXpGNZ0zozpP9dnbzgR7lBpuG
	rG2ALzJgqaIumv1CNWQl/WvOWOS2g3M/PQqU6/Bw0IH7o1wACrPj1CGOYjFy0UR4oEfh/k5xrl3
	oqQ==
X-Google-Smtp-Source: AGHT+IGXRTEgOUOhXSgq13YcDOb7vuxUfefDzGxsxfvtYOpptgQDUXVxAqFfYaBTqhH+wzHBzMFc3mTy5nE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6c13:b0:61b:32dc:881d with SMTP id
 00721157ae682-62cc70bb641mr7851657b3.3.1717680769456; Thu, 06 Jun 2024
 06:32:49 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:32:47 +0200
In-Reply-To: <ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com>
 <20240604.c18387da7a0e@gnoack.org> <ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com>
Message-ID: <ZmG6f1XCrdWE-O7y@google.com>
Subject: Re: [RFC PATCH v2 00/12] Socket type control for Landlock
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>, mic@digikod.net, willemdebruijn.kernel@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Mikhail!

On Thu, Jun 06, 2024 at 02:44:23PM +0300, Mikhail Ivanov wrote:
> 6/4/2024 11:22 PM, G=C3=BCnther Noack wrote:
> > On Fri, May 24, 2024 at 05:30:03PM +0800, Mikhail Ivanov wrote:
> > > Hello! This is v2 RFC patch dedicated to socket protocols restriction=
.
> > >=20
> > > It is based on the landlock's mic-next branch on top of v6.9 kernel
> > > version.
> >=20
> > Hello Mikhail!
> >=20
> > I patched in your patchset and tried to use the feature with a small
> > demo tool, but I ran into what I think is a bug -- do you happen to
> > know what this might be?
> >=20
> > I used 6.10-rc1 as a base and patched your patches on top.
> >=20
> > The code is a small tool called "nonet", which does the following:
> >=20
> >    - Disable socket creation with a Landlock ruleset with the following
> >      attributes:
> >      struct landlock_ruleset_attr attr =3D {
> >        .handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> >      };
> >=20
> >    - open("/dev/null", O_WRONLY)
> >=20
> > Expected result:
> >=20
> >    - open() should work
> >=20
> > Observed result:
> >=20
> >    - open() fails with EACCES.
> >=20
> > I traced this with perf, and found that the open() gets rejected from
> > Landlock's hook_file_open, whereas hook_socket_create does not get
> > invoked.  This is surprising to me -- Enabling a policy for socket
> > creation should not influence the outcome of opening files!
> >=20
> > Tracing commands:
> >=20
> >    sudo perf probe hook_socket_create '$params'
> >    sudo perf probe 'hook_file_open%return $retval'
> >    sudo perf record -e 'probe:*' -g -- ./nonet
> >    sudo perf report
> > You can find the tool in my landlock-examples repo in the nonet_bug bra=
nch:
> > https://github.com/gnoack/landlock-examples/blob/nonet_bug/nonet.c
> >=20
> > Landlock is enabled like this:
> > https://github.com/gnoack/landlock-examples/blob/nonet_bug/sandbox_sock=
et.c
> >=20
> > Do you have a hunch what might be going on?
>=20
> Hello G=C3=BCnther!
> Big thanks for this research!
>=20
> I figured out that I define LANDLOCK_SHIFT_ACCESS_SOCKET macro in
> really strange way (see landlock/limits.h):
>=20
>   #define LANDLOCK_SHIFT_ACCESS_SOCKET	LANDLOCK_NUM_ACCESS_SOCKET
>=20
> With this definition, socket access mask overlaps the fs access
> mask in ruleset->access_masks[layer_level]. That's why
> landlock_get_fs_access_mask() returns non-zero mask in hook_file_open().
>=20
> So, the macro must be defined in this way:
>=20
>   #define LANDLOCK_SHIFT_ACCESS_SOCKET	(LANDLOCK_NUM_ACCESS_NET +
>                                          LANDLOCK_NUM_ACCESS_FS)
>=20
> With this fix, open() doesn't fail in your example.
>=20
> I'm really sorry that I somehow made such a stupid typo. I will try my
> best to make sure this doesn't happen again.

Thanks for figuring it out so quickly.  With that change, I'm getting some
compilation errors (some bit shifts are becoming too wide for the underlyin=
g
types), but I'm sure you can address that easily for the next version of th=
e
patch set.

IMHO this shows that our reliance on bit manipulation is probably getting i=
n the
way of code clarity. :-/ I hope we can simplify these internal structures a=
t
some point.  Once we have a better way to check for performance changes [1]=
, we
can try to change this and measure whether these comprehensibility/performa=
nce
tradeoff is really worth it.

[1] https://github.com/landlock-lsm/linux/issues/24

The other takeaway in my mind is, we should probably have some tests for th=
at,
to check that the enablement of one kind of policy does not affect the
operations that belong to other kinds of policies.  Like this, for instance=
 (I
was about to send this test to help debugging):

TEST_F(mini, restricting_socket_does_not_affect_fs_actions)
{
	const struct landlock_ruleset_attr ruleset_attr =3D {
		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
	};
	int ruleset_fd, fd;

	ruleset_fd =3D landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr)=
, 0);
	ASSERT_LE(0, ruleset_fd);

	enforce_ruleset(_metadata, ruleset_fd);
	ASSERT_EQ(0, close(ruleset_fd));

	/*
	 * Accessing /dev/null for writing should be permitted,
	 * because we did not add any file system restrictions.
	 */
	fd =3D open("/dev/null", O_WRONLY);
	EXPECT_LE(0, fd);

	ASSERT_EQ(0, close(fd));
}

Since these kinds of tests are a bit at the intersection between the
fs/net/socket tests, maybe they could go into a separate test file?  The ne=
xt
time we add a new kind of Landlock restriction, it would come more naturall=
y to
add the matching test there and spot such issues earlier.  Would you volunt=
eer
to add such a test as part of your patch set? :)

Thanks,
G=C3=BCnther

