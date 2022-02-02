Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB84A6D36
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Feb 2022 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiBBIrl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 2 Feb 2022 03:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234631AbiBBIrl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Feb 2022 03:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FgpMsQQCeVrG6sl2UYp1/oUbqnLQ5oqDwItlUehJG3k=;
        b=ILM/CZ2L330qWJZr2/XJOBzIcELVg1etDtM7/aLu9QTvueh4JAdlWgizzZo+MtRYMubrrI
        klZ0ANaCRVosXrHCTiwloE/BAkxO29zKet7BuXvfNVRDcS/CUyqzPvm6vghcFmit9nDlm/
        HeLSGEfwtufqQi6l6VHAnXj8diwQeZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-pS9IErz6OjOB7wZPlsgLhA-1; Wed, 02 Feb 2022 03:47:38 -0500
X-MC-Unique: pS9IErz6OjOB7wZPlsgLhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B40028144E5;
        Wed,  2 Feb 2022 08:47:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 603CC6AB98;
        Wed,  2 Feb 2022 08:47:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8BE3B1800397; Wed,  2 Feb 2022 09:47:23 +0100 (CET)
Date:   Wed, 2 Feb 2022 09:47:23 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] efi: Load efi_secret module if EFI secret area is
 populated
Message-ID: <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-5-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201124413.1093099-5-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 01, 2022 at 12:44:12PM +0000, Dov Murik wrote:
> If the efi_secret module is built, register a late_initcall in the EFI
> driver which checks whether the EFI secret area is available and
> populated, and then requests to load the efi_secret module.

> +	area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
> +	if (!area) {
> +		pr_err("Failed to map confidential computing secret area descriptor\n");
> +		return -ENOMEM;
> +	}
> +	if (!area->base_pa || area->size < sizeof(*header_guid))
> +		goto unmap_desc;
> +
> +	header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
> +	if (!header_guid) {
> +		pr_err("Failed to map secret area\n");
> +		ret = -ENOMEM;
> +		goto unmap_desc;
> +	}
> +	if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
> +		goto unmap_encrypted;

Why these sanity checks are here and not in the efi_secret module?

take care,
  Gerd

