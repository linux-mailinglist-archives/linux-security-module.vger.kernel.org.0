Return-Path: <linux-security-module+bounces-3546-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939F8D0632
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FEE2991F8
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4115E5D6;
	Mon, 27 May 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0LfVciY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1215E5CC
	for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823648; cv=none; b=Z0GRA7CaZVDcxJ0yHvQ/jIH5P73/rocSp9JVN0Y/MYvAxZxUBVm3dLpRjJxJE91G0eLBDEQdXKuaFGjEStEcPY3ybcIdB+V+hOhUKPkFBxxQcSebcFQkTQNPW/7+1uAgWMyoUrAfbAIGGqbxSz6y8vsIHcJdmkpsfJUM3FLpS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823648; c=relaxed/simple;
	bh=EH+uzBvIrlF2QnIH5v9HOVinZLSRxlGtcJDv3fu4nA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KjmB3vuu9m3YmJQIT565/qNoq1T6wXHxQPdmPGXreTTGyu29B5HiKxFUY5yipHWY0/PndAbCJgOUAASwqaxNXZ90uX1L1j/6UKOOQUNKBPdRbE2bDp2jbzFu4+8OkYPGBd/GeFCEmHh2GbDRJ7TM+a4/fpoGl6OmOo/6sfDuk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0LfVciY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df771dcec5cso4790332276.2
        for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716823644; x=1717428444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgReQBAL8ooUhubet2sIcyqcKqExZySvMhVpx5G+EiE=;
        b=V0LfVciYxHZFrEmclkYq9PhEhnZ4xyDE2XD/iexbUJJUp8v6j4XLYd7qN1bP8m0ghz
         QjlLyUtkClO2c28We2kIZTSvynOH76DRZSG0miQDRQZzXAnEir6+E+Q1Ba6fady7IXdB
         GGva0vxRjv1srHsD6h9gk/Np5VrT9nH4iSGU+swaQHWiKFCxJnzsSxu9834lAcJtLWrA
         Lh5idHjTdSYPIFizf2IqjNANKIDSRu11uI7nFgLV26R+6OEzB/SWD1Qwz7TYQ/wB1sEN
         0cBdwPFgEFnp43zPkhn+ItzS7o4Fw4fYW0cFrLbFPNzCDa6aIqe6gzhkqH4+Xs30HwON
         Fv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716823644; x=1717428444;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgReQBAL8ooUhubet2sIcyqcKqExZySvMhVpx5G+EiE=;
        b=gvS/r9UgxO0zCaxAyIsyjOXkADdTd2l0un7sxn1LRYIMXKsApEuIMnqgLKr/017J6A
         I6YrmynW5JLWnibhjVvUy6PxZiHz+zGm64loC6WtmgNEHI2O95nAl4H+J1g/7CQV12ir
         D+Q+Fs/LunW1RYoOz7uzIOl5bONvwMbZb8Bmai/VjkxajlPjhQzQkPzzPYaQ5dfEoqgY
         TeUBSoSlQ13WF7LOK8RrbHWOmUm/HG8njsmEdADfuFhfU7hAsJatD9Hk8zUWsZqSYUx1
         PX8ZB3ua/79Yi0Kv/KOTaYKBssqem6CqDyxJ8UKEZV91IkO3R+mwnldoP9q+RDZE3lqF
         gm6A==
X-Forwarded-Encrypted: i=1; AJvYcCX3weco5AG7eOrTZP3Ce6ePj/Ty1e/j/vEzcacnJ9I4M/zw1q9qnTSDLr7oKaKrQpIarSTS3OrYVSaPmCFIMG2nDf7d7YE7FdvMGfgR0iktH4XmAhV/
X-Gm-Message-State: AOJu0YzcNu+BGohpoetxmGI7YIzoxmVM65EnfmJqzxgqn+giOxYsg75d
	xv8ps/rBvJAMgVlqfb2xg/3mL3C3KrBZv+OrThk7iwINl4Vn5suHhgeU47Dzj7ytY8MlAUL5l2y
	1hw==
X-Google-Smtp-Source: AGHT+IEcMK/eb/1S9GxInlxz3v6B37pxwZZVCeVpsfVMsox8htgY0igmkWFUPucJUSd/a6wou/SqCeNEezw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1805:b0:df7:68c5:98d5 with SMTP id
 3f1490d57ef6-df77218599dmr2681802276.5.1716823644525; Mon, 27 May 2024
 08:27:24 -0700 (PDT)
Date: Mon, 27 May 2024 17:27:22 +0200
In-Reply-To: <20240524093015.2402952-4-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com> <20240524093015.2402952-4-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZlSmAhLV00iry6we@google.com>
Subject: Re: [RFC PATCH v2 03/12] selftests/landlock: Add protocol.create to
 socket tests
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:30:06PM +0800, Mikhail Ivanov wrote:
> Initiate socket_test.c selftests. Add protocol fixture for tests
> with changeable family-type values. Only most common variants of
> protocols (like ipv4-tcp,ipv6-udp, unix) were added.
> Add simple socket access right checking test.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>=20
> Changes since v1:
> * Replaces test_socket_create() and socket_variant() helpers
>   with test_socket().
> * Renames domain to family in protocol fixture.
> * Remove AF_UNSPEC fixture entry and add unspec_srv0 fixture field to
>   check AF_UNSPEC socket creation case.
> * Formats code with clang-format.
> * Refactors commit message.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/socket_test.c
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> new file mode 100644
> index 000000000000..4c51f89ed578
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock tests - Socket
> + *
> + * Copyright =C2=A9 2024 Huawei Tech. Co., Ltd.
> + * Copyright =C2=A9 2024 Microsoft Corporation

It looked to me like these patches came from Huawei?
Was this left by accident?


> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <linux/landlock.h>
> +#include <sched.h>
> +#include <string.h>
> +#include <sys/prctl.h>
> +#include <sys/socket.h>
> +
> +#include "common.h"
> +
> +/* clang-format off */
> +
> +#define ACCESS_LAST LANDLOCK_ACCESS_SOCKET_CREATE
> +
> +#define ACCESS_ALL ( \
> +	LANDLOCK_ACCESS_SOCKET_CREATE)
> +
> +/* clang-format on */

It does not look like clang-format would really mess up this format in a ba=
d
way.  Maybe we can remove the "clang-format off" section here and just writ=
e the
"#define"s on one line?

ACCESS_ALL is unused in this commit.
Should it be introduced in a subsequent commit instead?


> +static int test_socket(const struct service_fixture *const srv)
> +{
> +	int fd;
> +
> +	fd =3D socket(srv->protocol.family, srv->protocol.type | SOCK_CLOEXEC, =
0);
> +	if (fd < 0)
> +		return errno;
> +	/*
> +	 * Mixing error codes from close(2) and socket(2) should not lead to an=
y
> +	 * (access type) confusion for this test.
> +	 */
> +	if (close(fd) !=3D 0)
> +		return errno;
> +	return 0;
> +}

I personally find that it helps me remember if these test helpers have the =
same
signature as the syscall that they are exercising.  (But I don't feel very
strongly about it.  Just a suggestion.)


> [...]
>
> +TEST_F(protocol, create)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	const struct landlock_socket_attr create_socket_attr =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family =3D self->srv0.protocol.family,
> +		.type =3D self->srv0.protocol.type,
> +	};
> +
> +	int ruleset_fd;
> +
> +	/* Allowed create */
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &create_socket_attr, 0));
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	ASSERT_EQ(0, test_socket(&self->srv0));
> +	ASSERT_EQ(EAFNOSUPPORT, test_socket(&self->unspec_srv0));
> +
> +	/* Denied create */
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	ASSERT_EQ(EACCES, test_socket(&self->srv0));
> +	ASSERT_EQ(EAFNOSUPPORT, test_socket(&self->unspec_srv0));

Should we exhaustively try out the other combinations (other than selv->srv=
0)
here?  I assume socket() should always fail for these?

(If you are alredy doing this in another commit that I have not looked at y=
et,
please ignore this comment.)

=E2=80=94G=C3=BCnther

