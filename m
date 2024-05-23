Return-Path: <linux-security-module+bounces-3469-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE38CD4E8
	for <lists+linux-security-module@lfdr.de>; Thu, 23 May 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86264286086
	for <lists+linux-security-module@lfdr.de>; Thu, 23 May 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B314A4FC;
	Thu, 23 May 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh72Jjjj"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212313C80E
	for <linux-security-module@vger.kernel.org>; Thu, 23 May 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471552; cv=none; b=WEQGtQZB7JT1MJx1+7ELkx6o9hakqRx4p0s/vLqYw6ZPoLe6Smj5DsQFeu3iDLHmt3ReiP3IbiKpPWM/SAKS9BHvQBDwLS+hNsXRhzKXEG5V3jEyuLW0HbrrTXaOyJF5xG38vlCFyb4DE6EJkP2yDjZSAHy0w99GJ3VlTX8tptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471552; c=relaxed/simple;
	bh=f7qsf6uHpQj1b7EvGifYNKn62b0z3n3sNaoF30buF0Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GJujDV6p2eAl5Z5FvDVyS3AXiRXyd2gfjmCANiZTONhiy0turWFis1dKdtN1ZSuUmxutv6UBP1TznFJyNvGwopQs/i0JpX/LlOkF5IuXab5pEGHhTj21Ki0800gyARL78ce9u0Q9WgwDyT/C7Gscl25MGn3kMYPsLSrqm7IT7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eh72Jjjj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716471549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujjJR49aI7BZarO+naEDlUutu9JDS8SgDMMORQQ2PcM=;
	b=Eh72JjjjAZQ1PWkxWrDWM/dNB0anANc1HQdxNN4INnWgo3e2a5lS6nzyZc2SnXATIp39o3
	XGYZN/DwtQmGFSo4kBo1As+6I2nxz7NhD6djWZoH6YtfHyZqsHtJINHbrbg0NegH1NGB2V
	NlO6QgiH5p8rbl5pJDdPEeu6Jn6GHbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-Cw0F39TlPQyVN010Jn0Oww-1; Thu, 23 May 2024 09:39:06 -0400
X-MC-Unique: Cw0F39TlPQyVN010Jn0Oww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A962812296;
	Thu, 23 May 2024 13:39:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 487A87414;
	Thu, 23 May 2024 13:39:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240523132341.32092-1-jarkko@kernel.org>
References: <20240523132341.32092-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, linux-integrity@vger.kernel.org,
    keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
    Eric Biggers <ebiggers@kernel.org>,
    James Bottomley <James.Bottomley@hansenpartnership.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Andrew Morton <akpm@linux-foundation.org>,
    Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
    James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-crypto@vger.kernel.org (open list:CRYPTO
                         API),
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [PATCH v2] KEYS: trusted: Use ASN.1 encoded OID
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <576060.1716471541.1@warthog.procyon.org.uk>
Date: Thu, 23 May 2024 14:39:01 +0100
Message-ID: <576061.1716471541@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> There's no reason to encode OID_TPMSealedData at run-time, as it never
> changes.
> 
> Replace it with the encoded version, which has exactly the same size:
> 
> 	67 81 05 0A 01 05
> 
> Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
> the OID can be simply copied to the blob.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: David Howells <dhowells@redhat.com>


