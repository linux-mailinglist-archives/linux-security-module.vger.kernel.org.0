Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278A1FA3C2
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jun 2020 00:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFOWxg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jun 2020 18:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOWxg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 18:53:36 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63AC061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 15:53:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49m67Z3kJ8z9sR4;
        Tue, 16 Jun 2020 08:53:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592261612;
        bh=Y7AAwy+sqoUOnMWIJuV7ZYorLyMVeUpgxcCnFN5tmqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QW71uDdZvZYhDWgbWubmUYSJAF8W6W6QQ4T6wVzSe4rG0AferRjEBMtKbxWkgkDth
         ETptPAXIT+hbm4r47QJhjt9ztNT0eXSy0wzDcPP02fyDxTkbg7Jo/t1j7dc/0g+0zL
         /7o6/zjeTbvTl4RMz/GAvBgd4Vft817cChZdPL130MgDyUaz3WJCOZzEX7pICM0mn5
         2yDWaxdOzpb0osLKNs4RoVdMdtltfb9yYJUO0iuKrltWul3fu+pgVCmBdq1hmbXhMm
         SCNLY0JyICmOfDu5gTbvysbbQN4bb/wepNAaC95Lo3fc149Loe0o0IsKwtG+DXc0GE
         gXQgu7aGps+rg==
Date:   Tue, 16 Jun 2020 08:53:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Subject: Re: Add SafeSetID LSM tree to linux-next
Message-ID: <20200616085329.5f22f954@canb.auug.org.au>
In-Reply-To: <CAJ-EccP7W5h1dZ4PfmiiE0r7ngxoSrD+tq3o_P03XM55DK806A@mail.gmail.com>
References: <CAJ-EccP7W5h1dZ4PfmiiE0r7ngxoSrD+tq3o_P03XM55DK806A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UL1K3U_/sqg+tv1nMsupIIX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/UL1K3U_/sqg+tv1nMsupIIX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Micah,

On Mon, 15 Jun 2020 13:26:33 -0700 Micah Morton <mortonm@chromium.org> wrot=
e:
>
> Could you add my safesetid-next branch from my tree to linux-next? It
> can be found here:
> https://github.com/micah-morton/linux.git#safesetid-next
>=20
> Let me know if there is anything else I need to do.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/UL1K3U_/sqg+tv1nMsupIIX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7n++kACgkQAVBC80lX
0GwXIwgAnbJYhiq7MEERt4WgMuY7sXu3iEBZuHSA2Zbi3JQpjJBuOJFWb3JTZp8h
mkiWvL3ShYhC2R+4SPxI07HDq5EmiyxB48bp9AjdaMYXeUafkAwnSps1K02ZbYCp
6lrlw9t1PAAHHvvnSHTi2b38TchU7jDJSjBQo2X4fe+S+K12ISd6Q9e4st/M5j8f
NxHSysPs1pbucmNsYbjA84o58fRTjI9zfbPZPK6WvpMjiWvxkUVnpKRSpIQ0Wbm3
jxAEB2xJuqzRRGooKt/YbGDUYaCSXL+dcOOM2n10YKUgzIIIEOfdNnLUqr6ZIBfJ
6JAQ4FydqLg5B96a0pslRoplgbeYVg==
=iKDU
-----END PGP SIGNATURE-----

--Sig_/UL1K3U_/sqg+tv1nMsupIIX--
