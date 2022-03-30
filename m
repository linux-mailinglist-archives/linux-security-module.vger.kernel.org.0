Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEF4EC5E0
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Mar 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346266AbiC3Nq0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Mar 2022 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346252AbiC3NqX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Mar 2022 09:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA47B75C29
        for <linux-security-module@vger.kernel.org>; Wed, 30 Mar 2022 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648647877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8QQxxoffEN8D0iWzQeDRqRj76sBJ6MkIp9Ef6hGM1Y=;
        b=EgxUDVLKYeFb8LrASP4mcDHL7H3OLJtrKmJeVpY2Vv9qrVZxcWEU1VxzkDhJjZRQ5H71e5
        OwVVURUBJypWy8+FPw6c9+pT02RaGL7BJMw8q4lfC352PSEWEExAkLptHHXhlbvwC5t93G
        9ApV0X5oiTEFJP/9JNfdrG8yCHA50cI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-NtZGEiU0PnqW3s2Gsn_boQ-1; Wed, 30 Mar 2022 09:44:31 -0400
X-MC-Unique: NtZGEiU0PnqW3s2Gsn_boQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA68B899ED9;
        Wed, 30 Mar 2022 13:44:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF7B0400E545;
        Wed, 30 Mar 2022 13:44:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YidDznCPSmFmfNwE@iki.fi>
References: <YidDznCPSmFmfNwE@iki.fi> <20210712170313.884724-1-mic@digikod.net> <20210712170313.884724-6-mic@digikod.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com,
        =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FMicka=3DEBl?=
         =?us-ascii?Q?=5FSala=3DFCn=3F=3D?= <mic@digikod.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FMicka=3DEBl?=
         =?us-ascii?Q?=5FSala=3DFCn=3F=3D?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 5/5] certs: Allow root user to append signed hashes to the blacklist keyring
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 30 Mar 2022 14:44:00 +0100
Message-ID: <2937432.1648647840@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> >  /*
> >   * Initialise the blacklist
> >   */
> >  static int __init blacklist_init(void)
> >  {
> >  	const char *const *bl;
> > +	struct key_restriction *restriction;
> >=20=20
> >  	if (register_key_type(&key_type_blacklist) < 0)
> >  		panic("Can't allocate system blacklist key type\n");
> >=20=20
> > +	restriction =3D kzalloc(sizeof(*restriction), GFP_KERNEL);
> > +	if (!restriction)
> > +		panic("Can't allocate blacklist keyring restriction\n");
>=20
>=20
> This prevents me from taking this to my pull request. In moderns standard=
s,
> no new BUG_ON(), panic() etc. should never added to the kernel.

I would argue that in this case, though, it is reasonable.  This should only
be called during kernel initialisation and, as Micka=C3=ABl points out, if =
you
can't allocate that small amount of memory, the kernel isn't going to boot
much further.

> I missed this in my review.
>=20
> This should rather be e.g.
>=20
>         restriction =3D kzalloc(sizeof(*restriction), GFP_KERNEL);
> 	if (!restriction) {
> 		pr_err("Can't allocate blacklist keyring restriction\n");
>                 return 0;
>         }

You can't just return 0.  That indicates success - but if by some miracle, =
the
kernel actually gets to a point where userspace can happen, it could mean t=
hat
we're missing the security restrictions of the blacklist.

Now, we could defer the panic to add_key_to_revocation_list(), but if you
can't set in place the required security restrictions, I think it's arguable
that the kernel either needs to panic or it needs to blacklist everything.

David

