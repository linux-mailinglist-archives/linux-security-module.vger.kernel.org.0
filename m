Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F8040DDB9
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Sep 2021 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhIPPRO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Sep 2021 11:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239101AbhIPPRN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Sep 2021 11:17:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D21260296;
        Thu, 16 Sep 2021 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805352;
        bh=iOcCI1FHoB0yx/LZeXXa3I2QwmbANkTrrP6vNXsEUw4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hxw7DtFO8S32GjJYJC0FktMBCncrxCACfS1q3EoiosYBTPIvVQ690Fg7xYbP0VvQ8
         VWUqLGv5juTWxi+/FuLFoHxaLXtqpm8ZJtrVvZil5OVmMoEQDDNe5Oluw6Oa/OKrHU
         Or3HdOnQ41AbTQWipSCnD//Sh74OchHguokf1/063NZn0u4G9q6ihaZrNNYwKS/Epj
         iyZtkl6TTj7jWNaG1uLykwTEj950NFR9x3/WFso3Cp0eBOdB5/O/4N4l1gSFEtQclU
         jne8WE3thfzVdZ2gZj1mjfxb/y2u8ipVlEPkKyitLSL2Z93ywFPOMNGjJxjZVipHRG
         oTJT/egmzLzgQ==
Message-ID: <f6e2e17cc6c8a3056cc066a7baa4d943eeb47c84.camel@kernel.org>
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 16 Sep 2021 18:15:50 +0300
In-Reply-To: <A02EE1DA-12BE-4998-ACE6-2D74FF380297@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
         <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
         <A02EE1DA-12BE-4998-ACE6-2D74FF380297@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2021-09-15 at 15:28 -0600, Eric Snowberg wrote:
> > On Sep 15, 2021, at 11:57 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> >=20
> > On Tue, 2021-09-14 at 17:14 -0400, Eric Snowberg wrote:
> > > Back in 2013 Linus requested a feature to allow end-users to have the=
=20
> > > ability "to add their own keys and sign modules they trust". This was
> > > his *second* order outlined here [1]. There have been many attempts=
=20
> > > over the years to solve this problem, all have been rejected.  Many=
=20
> > > of the failed attempts loaded all preboot firmware keys into the kern=
el,
> > > including the Secure Boot keys. Many distributions carry one of these=
=20
> > > rejected attempts [2], [3], [4]. This series tries to solve this prob=
lem=20
> > > with a solution that takes into account all the problems brought up i=
n=20
> > > the previous attempts.
> > >=20
> > > On UEFI based systems, this series introduces a new Linux kernel keyr=
ing=20
> > > containing the Machine Owner Keys (MOK) called machine. It also defin=
es
> > > a new MOK variable in shim. This variable allows the end-user to deci=
de=20
> > > if they want to load MOK keys into the machine keyring. Mimi has sugg=
ested=20
> > > that only CA keys contained within the MOK be loaded into the machine=
=20
> > > keyring. All other certs will load into the platform keyring instead.
> > >=20
> > > By default, nothing changes; MOK keys are not loaded into the machine
> > > keyring.  They are only loaded after the end-user makes the decision=
=20
> > > themselves.  The end-user would set this through mokutil using a new=
=20
> > > --trust-mok option [5]. This would work similar to how the kernel use=
s=20
> > > MOK variables to enable/disable signature validation as well as use/i=
gnore=20
> > > the db. Any kernel operation that uses either the builtin or secondar=
y=20
> > > trusted keys as a trust source shall also reference the new machine=
=20
> > > keyring as a trust source.
> > >=20
> > > Secure Boot keys will never be loaded into the machine keyring.  They
> > > will always be loaded into the platform keyring.  If an end-user want=
ed=20
> > > to load one, they would need to enroll it into the MOK.
> > >=20
> > > Steps required by the end user:
> > >=20
> > > Sign kernel module with user created key:
> > > $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
> > >   machine_signing_key.priv machine_signing_key.x509 my_module.ko
> > >=20
> > > Import the key into the MOK
> > > $ mokutil --import machine_signing_key.x509
> > >=20
> > > Setup the kernel to load MOK keys into the .machine keyring
> > > $ mokutil --trust-mok
> > >=20
> > > Then reboot, the MokManager will load and ask if you want to trust th=
e
> > > MOK key and enroll the MOK into the MOKList.  Afterwards the signed k=
ernel
> > > module will load.
> > >=20
> > > I have included links to both the mokutil [5] and shim [6] changes I
> > > have made to support this new functionality.
> >=20
> > How hard it is to self-compile shim and boot it with QEMU (I
> > do not know even the GIT location of Shim)?
>=20
> It is not hard, that is the setup I use for my testing.  Upstream shim=
=20
> is located here [1].  Or you can use my repo which contains the necessary
> changes [2].
>=20
> [1] https://github.com/rhboot/shim
> [2] https://github.com/esnowberg/shim/tree/mokvars-v2
>=20

So, my 2nd Q would be: which order these should be upstreamed?

Linux patch set cannot depend on "yet to be upstreamed" things.

Code changes look good enough to me.

/Jarkko
