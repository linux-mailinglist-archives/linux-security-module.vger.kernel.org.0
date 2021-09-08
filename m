Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29AA403DE7
	for <lists+linux-security-module@lfdr.de>; Wed,  8 Sep 2021 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhIHQuR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 8 Sep 2021 12:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhIHQuR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Sep 2021 12:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7698961157;
        Wed,  8 Sep 2021 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631119748;
        bh=lH6wYfYGyCOV7WASMN2PUU0RpYoxXXggzVThQnqSLBM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZSyS5J/HoGY9jBv1hFQfJdlOreJxolc5wArmVPhXQUhVcwPagKG54DkZc1kcSR2aP
         zZkIl8I7FmPOJ4oeBJJraZkl84mlDOx0pvMAkZDEOQMN2t3kYTGAgLbUXRTgOXiqhX
         hFCQlpTNNe3dw5OOAoIMK44+UjHJ18a2GgbcR2ePrHIKnmI7LLhSDOErqEHEfC+FSt
         Hwb802vT59b74SAT77Mme0rvp1J1uLnQp5ttxIPoWl8zFuelz1BZeUPFtvVvnALB0a
         io3X5aHBo3gzfkrZVINO7k6t/NmY96AvEimB9ImMtl1HoRq3qZLrdLDRUZKpncAW3q
         x1U6MNW7AQC5w==
Message-ID: <b44726f2d71960d53b4860ccab71f02186295da9.camel@kernel.org>
Subject: Re: [PATCH v5 00/12] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Wed, 08 Sep 2021 19:49:06 +0300
In-Reply-To: <7f9fb65a4ee20c337646a1fc887cd24365c2c59e.camel@kernel.org>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <7f9fb65a4ee20c337646a1fc887cd24365c2c59e.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2021-09-08 at 19:03 +0300, Jarkko Sakkinen wrote:
> On Tue, 2021-09-07 at 12:00 -0400, Eric Snowberg wrote:
> > Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> > what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secur=
e
> > Boot DB and MOK keys to validate the next step in the boot chain.  The
> > MOK facility can be used to import user generated keys.  These keys can
> > be used to sign an end-user development kernel build.  When Linux boots=
,
> > pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in the
> > Linux .platform keyring. =20
> >=20
> > Currently, pre-boot keys are not trusted within the Linux trust boundar=
y
> > [1]. These platform keys can only be used for kexec. If an end-user
>=20
> What exactly is "trust boundary"? And what do you mean when you say that
> Linux "trusts" something? AFAIK, software does not have feelings. Please,
> just speak about exact things.
>=20
> That's the whole point of the cover letter. It's better to not have cover
> letter at all, than a confusing cover letter that reads like a white pape=
r.
> Code changes at least tell the exact story, and not speak about feelings.
>=20
> > wants to use their own key within the Linux trust boundary, they must
> > either compile it into the kernel themselves or use the insert-sys-cert
> > script. Both options present a problem. Many end-users do not want to
> > compile their own kernels. With the insert-sys-cert option, there are
> > missing upstream changes [2].  Also, with the insert-sys-cert option,
> > the end-user must re-sign their kernel again with their own key, and
> > then insert that key into the MOK db. Another problem with
> > insert-sys-cert is that only a single key can be inserted into a
> > compressed kernel.
>=20
> I use a pre-compiled kernel in my desktop: https://liquorix.net/. When
> a new version comes up it requires a sbsign one-liner to sign it for
> secure boot. I'm wondering what is the problem I'm facing because I do
> not see it.
>=20
> If there are something missing changes that you use as a rationale for
> this large patch set, you should at least broadly explain what we are
> missing. How I conclude this paragraph is that, since there is only an
> xref, they are not really "that important" changes, which are missing.
>=20
> > Having the ability to insert a key into the Linux trust boundary opens
> > up various possibilities.  The end-user can use a pre-built kernel and
> > sign their own kernel modules.  It also opens up the ability for an
>=20
> Which both can be done by end-user as of today, or I'm misreading this.
>=20
> > end-user to more easily use digital signature based IMA-appraisal.  To
> > get a key into the ima keyring, it must be signed by a key within the
> > Linux trust boundary.
>=20
> What is IMA appraisal? I just don't know it because I don't use IMA.
> Again, this trust boundary is really something I do not. Looking at
> code changes, you could just speak about exact assets in the kernel.
>=20
> > Downstream Linux distros try to have a single signed kernel for each
> > architecture.  Each end-user may use this kernel in entirely different
> > ways.  Some downstream kernels have chosen to always trust platform key=
s
> > within the Linux trust boundary for kernel module signing.  These
> > kernels have no way of using digital signature base IMA appraisal.
> >=20
> > This series introduces a new Linux kernel keyring containing the Machin=
e
> > Owner Keys (MOK) called .machine. It also adds a new MOK variable to sh=
im.
> > This variable allows the end-user to decide if they want to trust keys
> > enrolled in the MOK within the Linux trust boundary.  By default,
> > nothing changes; MOK keys are not trusted within the Linux kernel.  The=
y
> > are only trusted after the end-user makes the decision themselves.  The
> > end-user would set this through mokutil using a new --trust-mok option
> > [3]. This would work similar to how the kernel uses MOK variables to
> > enable/disable signature validation as well as use/ignore the db.
>=20
> OK, changes are described here (again speaking about trusting tho). The
> motivation part is missing. The text before this is more like confusion
> part. When you describe motivation to do something you should really be i=
n
> grass roots, e.g. "when you have this feature in the kernel, look, I can
> do now this". It's not that hard. E.g. with an usage example it is quite
> quick accomplish this.

The code changes overally make sense but this motivotional part is the
problem. E.g. if you do a pull request, it is completely *unusable* in
that context. In that case I would have to write something that should
have been the cover letter. It's 12 patches, so it is perfectly sensible
to ask a better one.

/Jarkko


