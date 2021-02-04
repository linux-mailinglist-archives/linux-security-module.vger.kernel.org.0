Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5457730A851
	for <lists+linux-security-module@lfdr.de>; Mon,  1 Feb 2021 14:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhBANJA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Feb 2021 08:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhBANI7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Feb 2021 08:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612184853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5Rwaf81e9ocy2MYWY0wjpx5EyFdy6040KY/DyZOVp8=;
        b=TupKMzQvRHzyFqzMFPnnNr2WrrczA60zrcF6SE1Kc0JdGgPbONDeR0dPQcqXqBwrtxwak7
        jMzUG8z2OtqvtlQvljOmpTU1L5o7djGb844rRLaGW+EKAwqtcTG3h/B99yEkS6per0R2pf
        RM4+tJQhnXgcbiaQeREhHT79crpZahM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-pfmfFTAqO3euUrWsdsfwvQ-1; Mon, 01 Feb 2021 08:07:31 -0500
X-MC-Unique: pfmfFTAqO3euUrWsdsfwvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B9D9CC02;
        Mon,  1 Feb 2021 13:07:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99176E141;
        Mon,  1 Feb 2021 13:07:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210128191705.3568820-1-mic@digikod.net>
References: <20210128191705.3568820-1-mic@digikod.net>
To:     =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl=3D20Sala=3DC3=3DBCn=3F?=
         =?us-ascii?Q?=3D?= <mic@digikod.net>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl?=
         =?us-ascii?Q?=3D20Sala=3DC3=3DBCn=3F=3D?= 
        <mic@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Enable root to update the blacklist keyring
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Feb 2021 13:07:24 +0000
Message-ID: <4160652.1612184844@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Hi Micka=C3=ABl,

Do you have a public branch somewhere I can pull from?

David

