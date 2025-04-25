Return-Path: <linux-security-module+bounces-9516-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B280A9CAEE
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Apr 2025 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E92177FE1
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Apr 2025 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F040252909;
	Fri, 25 Apr 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgYijzXD"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D1243946
	for <linux-security-module@vger.kernel.org>; Fri, 25 Apr 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589503; cv=none; b=FldLQPuca09TE7XrzL0iAbaQsZL8GiCmSU6JjgKYTOrnAWHFYfC22CvZs05XFvAQAaVeFufGu71fVOuQsMrnhfY3YGaTmkgu7eWjlduPqD2elQ00uHZIHmOJfC3v1qrQ5jxriv/04K11vzQCvBGJDVLgORf5Scn+l1zdks9EwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589503; c=relaxed/simple;
	bh=mSfgxgNnQicQTVD+wO7Krim+CD6u6749EhxujOqNJmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CvMVONCqOEBSwkcil2CeNRAavJHyQ7uma/u2i93235mp0glFahumYL1tJaju71dFghtVelfgLP2nBLim/PjU8NUS62d1+Ogg8szIAkQKLAFHs6Zvi3FpzED2cmBbbiCX3yBt65icZy5dH8UgPlDktmK7KuveLZq5/ewmLT2ZLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgYijzXD; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e6d978792dso2282116a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 25 Apr 2025 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745589498; x=1746194298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21RGhzH0LfpN512qvg67nRg0lK0sOUpcSP9q0JHAmSg=;
        b=fgYijzXDqgAyJlCLm3Kdsv/6BmS4zgtRNgaSnkz/HM1aSXO/bl8rmW7ZK6zYzzJzkv
         HoWyJpRCo6e6K0LgOq7sj3z5RhzXC+LMmL3wlkpVez7G77oaS8u4GhrGkw13xWQT3onK
         XkzAvJHlaNEnZu9Kul4p0NrvLdEDVDG7r6azO+rCK01dTr1vw2u2BoQt1SaTHOWNTFD5
         ilnIiEYGUAR3s9ZF8XaSQuITUsHfNIk9h0cDd9OlWl8k4x1xB3K1ZI/NOLkrliDt5XXj
         pfQ2dMlYPUf0Wo27N/MHPTyAbqMSe77kDCte4hSoJhKWQRYmhcYHliXjdOidgiZUFwsl
         2TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745589498; x=1746194298;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21RGhzH0LfpN512qvg67nRg0lK0sOUpcSP9q0JHAmSg=;
        b=QUpgcpi6HvMXgHW/XjyBfjylo9wgdDvJMRvZdiowJSY8pmnDqpfh3TGKlifhfuq41e
         8tmW6lWvdBS1PK8P2UfxDah7tHtjtfZVeYZneKuko4nuKapaANb5XdXPH07jrY5XDiVl
         ZOFWQMIHcI/DQqvPznF9fgx/Z3IwNnaezYpm27p3woFIBInA/wlkmUww+gbUqQswA3lU
         uzWBZameGlRN6Y6H2qSzHEAqqiEbHpVfnHSatMNX9w1mreHO1Dzuc1rZu7mvv+EaBvWF
         YGBIzEPjsBkHIPan0mPoODKBGcMJIxhYtGI1nQxsoWhchnz03rpbhvutqiw5D6fNycxr
         ejmg==
X-Forwarded-Encrypted: i=1; AJvYcCVNdl0j2EjGHR5yUq9fLpqYx/ThZpraKjvlv3U/idYqARYLLr30Gxh9hjFtNdf7HJ/HKSKJ4yVcfVlxjuUCo4UVQiaYwvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFMgQdk/CjCYS33DwjtWH2gi1vjizIM3UHjDcMVZBuQtRY+7d
	pXaWMGjH6Q+rpYiPX72Lo8bW80KC8LoKuRAOEpFQDjL3AnmvfHFajNvDZMtJHtk5lN088GeT182
	tsQ==
X-Google-Smtp-Source: AGHT+IHFz8WbeqQVuA31odMvokIETWZDuZA7pvJUgZRzKO0ZzQ3QebkodQz4aYfMU6l5Xjjzse+J94W3gKo=
X-Received: from edwj7.prod.google.com ([2002:a05:6402:11c7:b0:5f6:f2cf:49a7])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5009:b0:5f4:370d:96c4
 with SMTP id 4fb4d7f45d1cf-5f721aaed59mr2136414a12.0.1745589498720; Fri, 25
 Apr 2025 06:58:18 -0700 (PDT)
Date: Fri, 25 Apr 2025 13:58:16 +0000
In-Reply-To: <20250422.iesaivaj8Aeb@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20250422.iesaivaj8Aeb@digikod.net>
Message-ID: <aAuU-LmjENslCF2P@google.com>
Subject: Re: [RFC PATCH v3 00/19] Support socket access-control
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, willemdebruijn.kernel@gmail.com, 
	gnoack3000@gmail.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Mikhail!

I would also be interested in seeing this patch set land. :)
Do you think you would be able to pick this up again?


To refresh my memory, I also had a look at V3 again; One of the last big
questions here was the userspace API in struct landlock_socket_attr.

To briefly recap that discussion, what we settled on at the end [1] was tha=
t we
can use special wildcard values for some of the members of that struct, so =
that
it looks like this:

struct landlock_socket_attr {
  __u64 allowed_access;
  int family;   /* same as domain in socket(2)    (required, never a wildca=
rd) */
  int type;     /* same as type in socket(2),     or the wildcard value (i6=
4)-1 */
  int protocol; /* same as protocol in socket(2), or the wildcard value (i6=
4)-1 */
};

(In other words, we have discarded the ideas of "handled_socket_layers" and
using bitmasks to specify different values for the socket(2) arguments.)

So, when an attempt is made to call socket(family, type, protocol), Landloc=
k has
to check for the presence of the following keys in the RB-tree:

 1. (family, type, protocol)
 2. (family, type, *)
 3. (family, *,    *)
 4. (family, *,    protocol)

but is an acceptable compromise to make ([1]).

Small remark: The four lookups sound bad, but I suspect that in many cases,=
 only
variant 1 (and maybe 2) will be used at all.  If you create four separate s=
truct
rb_root for these four cases, then if the more obscure variants are unused,=
 the
lookups for these will be almost for free.  (An empty rb_root contains only=
 a
single NULL-pointer.)


I hope this is a reasonable summary of the discussion at [1] and helps to
unblock the progress here?  Mikhail, are there any other open points which =
are
blocking you on this patch set?

-G=C3=BCnther


[1] https://lore.kernel.org/all/20250124.sei0Aur6aegu@digikod.net/


On Tue, Apr 22, 2025 at 07:19:02PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Hi Mikhail.  Could you please send a new version taking into account the
> reviews?
>=20
> This series should support audit by logging socket creation denials and
> extending audit_log_lsm_data().  You can get inspiration from the format
> used by audit_net_cb() but without the number to text translation, that
> can be handled by auditd if needed.  New tests should check these new
> audit logs.
>=20
>=20
> On Wed, Sep 04, 2024 at 06:48:05PM +0800, Mikhail Ivanov wrote:
> > Hello! This is v3 RFC patch dedicated to socket protocols restriction.
> >=20
> > It is based on the landlock's mic-next branch on top of v6.11-rc1 kerne=
l
> > version.
> >=20
> > Objective
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Extend Landlock with a mechanism to restrict any set of protocols in
> > a sandboxed process.
> >=20
> > Closes: https://github.com/landlock-lsm/linux/issues/6
> >=20
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Landlock implements the `LANDLOCK_RULE_NET_PORT` rule type, which provi=
des
> > fine-grained control of actions for a specific protocol. Any action or
> > protocol that is not supported by this rule can not be controlled. As a
> > result, protocols for which fine-grained control is not supported can b=
e
> > used in a sandboxed system and lead to vulnerabilities or unexpected
> > behavior.
> >=20
> > Controlling the protocols used will allow to use only those that are
> > necessary for the system and/or which have fine-grained Landlock contro=
l
> > through others types of rules (e.g. TCP bind/connect control with
> > `LANDLOCK_RULE_NET_PORT`, UNIX bind control with
> > `LANDLOCK_RULE_PATH_BENEATH`).
> >=20
> > Consider following examples:
> > * Server may want to use only TCP sockets for which there is fine-grain=
ed
> >   control of bind(2) and connect(2) actions [1].
> > * System that does not need a network or that may want to disable netwo=
rk
> >   for security reasons (e.g. [2]) can achieve this by restricting the u=
se
> >   of all possible protocols.
> >=20
> > [1] https://lore.kernel.org/all/ZJvy2SViorgc+cZI@google.com/
> > [2] https://cr.yp.to/unix/disablenetwork.html
> >=20
> > Implementation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This patchset adds control over the protocols used by implementing a
> > restriction of socket creation. This is possible thanks to the new type
> > of rule - `LANDLOCK_RULE_SOCKET`, that allows to restrict actions on
> > sockets, and a new access right - `LANDLOCK_ACCESS_SOCKET_CREATE`, that
> > corresponds to creating user space sockets. The key in this rule is a p=
air
> > of address family and socket type (Cf. socket(2)).
> >=20
> > The right to create a socket is checked in the LSM hook, which is calle=
d
> > in the __sock_create method. The following user space operations are
> > subject to this check: socket(2), socketpair(2), io_uring(7).
> >=20
> > In the case of connection-based socket types,
> > `LANDLOCK_ACCESS_SOCKET_CREATE` does not restrict the actions that resu=
lt
> > in creation of sockets used for messaging between already existing
> > endpoints (e.g. accept(2), setsockopt(2) with option
> > `SCTP_SOCKOPT_PEELOFF`).
> >=20
> > Current limitations
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > `SCTP_SOCKOPT_PEELOFF` should not be restricted (see test
> > socket_creation.sctp_peeloff).
> >=20
> > SCTP socket can be connected to a multiple endpoints (one-to-many
> > relation). Calling setsockopt(2) on such socket with option
> > `SCTP_SOCKOPT_PEELOFF` detaches one of existing connections to a separa=
te
> > UDP socket. This detach is currently restrictable.
> >=20
> > Code coverage
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Code coverage(gcov) report with the launch of all the landlock selftest=
s:
> > * security/landlock:
> > lines......: 93.5% (794 of 849 lines)
> > functions..: 95.5% (106 of 111 functions)
> >=20
> > * security/landlock/socket.c:
> > lines......: 100.0% (33 of 33 lines)
> > functions..: 100.0% (4 of 4 functions)
> >=20
> > General changes v2->v3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > * Implementation
> >   * Accepts (AF_INET, SOCK_PACKET) as an alias for (AF_PACKET, SOCK_PAC=
KET).
> >   * Adds check to not restrict kernel sockets.
> >   * Fixes UB in pack_socket_key().
> >   * Refactors documentation.
> > * Tests
> >   * Extends variants of `protocol` fixture with every protocol that can=
 be
> >     used to create user space sockets.
> >   * Adds 5 new tests:
> >     * 3 tests to check socketpair(2), accept(2) and sctp_peeloff
> >       restriction.
> >     * 1 test to check restriction of kernel sockets.
> >     * 1 test to check AF_PACKET aliases.
> > * Documentation
> >   * Updates Documentation/userspace-api/landlock.rst.
> > * Commits
> >   * Rebases on mic-next.
> >   * Refactors commits.
> >=20
> > Previous versions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v2: https://lore.kernel.org/all/20240524093015.2402952-1-ivanov.mikhail=
1@huawei-partners.com/
> > v1: https://lore.kernel.org/all/20240408093927.1759381-1-ivanov.mikhail=
1@huawei-partners.com/
> >=20
> > Mikhail Ivanov (19):
> >   landlock: Support socket access-control
> >   landlock: Add hook on socket creation
> >   selftests/landlock: Test basic socket restriction
> >   selftests/landlock: Test adding a rule with each supported access
> >   selftests/landlock: Test adding a rule for each unknown access
> >   selftests/landlock: Test adding a rule for unhandled access
> >   selftests/landlock: Test adding a rule for empty access
> >   selftests/landlock: Test overlapped restriction
> >   selftests/landlock: Test creating a ruleset with unknown access
> >   selftests/landlock: Test adding a rule with family and type outside
> >     the range
> >   selftests/landlock: Test unsupported protocol restriction
> >   selftests/landlock: Test that kernel space sockets are not restricted
> >   selftests/landlock: Test packet protocol alias
> >   selftests/landlock: Test socketpair(2) restriction
> >   selftests/landlock: Test SCTP peeloff restriction
> >   selftests/landlock: Test that accept(2) is not restricted
> >   samples/landlock: Replace atoi() with strtoull() in
> >     populate_ruleset_net()
> >   samples/landlock: Support socket protocol restrictions
> >   landlock: Document socket rule type support
> >=20
> >  Documentation/userspace-api/landlock.rst      |   46 +-
> >  include/uapi/linux/landlock.h                 |   61 +-
> >  samples/landlock/sandboxer.c                  |  135 ++-
> >  security/landlock/Makefile                    |    2 +-
> >  security/landlock/limits.h                    |    4 +
> >  security/landlock/ruleset.c                   |   33 +-
> >  security/landlock/ruleset.h                   |   45 +-
> >  security/landlock/setup.c                     |    2 +
> >  security/landlock/socket.c                    |  137 +++
> >  security/landlock/socket.h                    |   19 +
> >  security/landlock/syscalls.c                  |   66 +-
> >  tools/testing/selftests/landlock/base_test.c  |    2 +-
> >  tools/testing/selftests/landlock/common.h     |   13 +
> >  tools/testing/selftests/landlock/config       |   47 +
> >  tools/testing/selftests/landlock/net_test.c   |   11 -
> >  .../testing/selftests/landlock/socket_test.c  | 1013 +++++++++++++++++
> >  16 files changed, 1593 insertions(+), 43 deletions(-)
> >  create mode 100644 security/landlock/socket.c
> >  create mode 100644 security/landlock/socket.h
> >  create mode 100644 tools/testing/selftests/landlock/socket_test.c
> >=20
> >=20
> > base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> > --=20
> > 2.34.1
> >=20
> >=20

