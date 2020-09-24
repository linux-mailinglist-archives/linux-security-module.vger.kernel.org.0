Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10B277B77
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Sep 2020 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIXWFq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 24 Sep 2020 18:05:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60532 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgIXWFq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Sep 2020 18:05:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 251041C0BD9; Fri, 25 Sep 2020 00:05:42 +0200 (CEST)
Date:   Fri, 25 Sep 2020 00:05:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200924220540.GA13185@amd>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923084232.GB30279@amd>
 <34257bc9-173d-8ef9-0c97-fb6bd0f69ecb@linux.microsoft.com>
 <20200923205156.GA12034@duo.ucw.cz>
 <c5ddf0c2-962a-f93a-e666-1c6f64482d97@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <c5ddf0c2-962a-f93a-e666-1c6f64482d97@digikod.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> I believe you should simply delete confusing "introduction" and
> >>> provide details of super-secure system where your patches would be
> >>> useful, instead.
> >>
> >> This RFC talks about converting dynamic code (which cannot be authenti=
cated)
> >> to static code that can be authenticated using signature verification.=
 That
> >> is the scope of this RFC.
> >>
> >> If I have not been clear before, by dynamic code, I mean machine code =
that is
> >> dynamic in nature. Scripts are beyond the scope of this RFC.
> >>
> >> Also, malware compiled from sources is not dynamic code. That is ortho=
gonal
> >> to this RFC. If such malware has a valid signature that the kernel per=
mits its
> >> execution, we have a systemic problem.
> >>
> >> I am not saying that script authentication or compiled malware are not=
 problems.
> >> I am just saying that this RFC is not trying to solve all of the secur=
ity problems.
> >> It is trying to define one way to convert dynamic code to static code =
to address
> >> one class of problems.
> >=20
> > Well, you don't have to solve all problems at once.
> >=20
> > But solutions have to exist, and AFAIK in this case they don't. You
> > are armoring doors, but ignoring open windows.
>=20
> FYI, script execution is being addressed (for the kernel part) by this
> patch series:
> https://lore.kernel.org/lkml/20200924153228.387737-1-mic@digikod.net/

Ok.

> > Or very probably you are thinking about something different than
> > normal desktop distros (Debian 10). Because on my systems, I have
> > python, gdb and gcc...
>=20
> It doesn't make sense for a tailored security system to leave all these
> tools available to an attacker.

And it also does not make sense to use "trampoline file descriptor" on
generic system... while W^X should make sense there.

> > It would be nice to specify what other pieces need to be present for
> > this to make sense -- because it makes no sense on Debian 10.
>=20
> Not all kernel features make sense for a generic/undefined usage,
> especially specific security mechanisms (e.g. SELinux, Smack, Tomoyo,
> SafeSetID, LoadPin, IMA, IPE, secure/trusted boot, lockdown, etc.), but
> they can still be definitely useful.

Yep... so... I'd expect something like... "so you have single-purpose
system with all script interpreters removed, IMA hashing all the files
to make sure they are not modified, and W^X enabled. Attacker can
still execute code after buffer overflow by .... and trapoline file
descriptor addrsses that"... so that people running generic systems
can stop reading after first sentence.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9tGDQACgkQMOfwapXb+vJJrACguUwBUXADnMj7K1we9pMBCXao
yuMAoLYUAsqVN8r3PK8Ax9IBA9TWFYbf
=yH8g
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
