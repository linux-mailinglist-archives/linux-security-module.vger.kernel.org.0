Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E877A4257A0
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Oct 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbhJGQT5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 7 Oct 2021 12:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242654AbhJGQT4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Oct 2021 12:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blEAPOI+nF0owA6gNBYFWO1A41DzHlnw6VWPwMJ/+zM=;
        b=LLyjASjQynccLDiarNREi2sQAC9DThB4k1qYJ5skg1i4+5ygvRuqHc2jDG/er8iJlzTDA3
        pffKrZiKJ/JIoJHJNiCqbZsCJSAranyl6PISiiRnWuuH9Ld64la1aTmyxlX/8g7/qP3yHz
        HZAMyXk7EzPRtkv3ECsehGTguqp0G2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-hK64i6oHOFa5gTfDVIINNA-1; Thu, 07 Oct 2021 12:17:58 -0400
X-MC-Unique: hK64i6oHOFa5gTfDVIINNA-1
Received: by mail-wr1-f71.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso5116534wra.13
        for <linux-security-module@vger.kernel.org>; Thu, 07 Oct 2021 09:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blEAPOI+nF0owA6gNBYFWO1A41DzHlnw6VWPwMJ/+zM=;
        b=jBUX+f7karsuqpPQn6ZxSm2mZRMuT5d4lvSZ1vrWcLkyMqxCvCwSQGjJcDALc9Q/TO
         IkgbbNbwphF8ea/fB4SBPNIWv5CYcKLwiVwRRKvRzKrzOCL/n1EOQgze3q31K2uNH3q2
         +il690XIZsw4XH9Zyy8uoQ/YlSKAes/KEfEsUb46ywPDzC4G+YyvcvYD/Y3w/FoIbE9l
         nMbXFp/2yT+i8y07lx/yVesEmw6A6hD5UAoNGUkYSL4hXrIomIKGxi/xce8kZHWbvYId
         yzAI5JCU9GAwPEd9kbEZy4EvhZOuRI+3QJdim92pIDUOmoZmuyvpEg6d9dAXWipqAG6R
         2vPQ==
X-Gm-Message-State: AOAM533y0MyLim6SSFP+bPAiemCU59JmHw9phn12ExGcNd89vDblcWu6
        +tu1ECDb5sEvbLur7xsvvERJOJnf69LDSC/Pa/NivLhmRM08Y/z38fZZ6TYsHERbc4x/rc/YhkE
        mh2C6fl0cPSepBEU6LEMrdtYec+ropNR3cdAV
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr6853090wrr.278.1633623477628;
        Thu, 07 Oct 2021 09:17:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrADigG00ZrKN1jM1AZoSZzR3uxS9vfFO2wr7+DM1JoV/qmvfoFSceMTUWkIHap1R4hsOMQg==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr6853057wrr.278.1633623477478;
        Thu, 07 Oct 2021 09:17:57 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id k17sm9320224wmj.0.2021.10.07.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:17:56 -0700 (PDT)
Date:   Thu, 7 Oct 2021 17:17:54 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] virt: Add sev_secret module to expose
 confidential computing secrets
Message-ID: <YV8dsl+qgbIH6z8F@work-vm>
References: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
 <20211007061838.1381129-5-dovmurik@linux.ibm.com>
 <7e2a4595-3f9c-6d65-34e3-af7c1d6da196@intel.com>
MIME-Version: 1.0
In-Reply-To: <7e2a4595-3f9c-6d65-34e3-af7c1d6da196@intel.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

* Dave Hansen (dave.hansen@intel.com) wrote:
> On 10/6/21 11:18 PM, Dov Murik wrote:
> > +static int sev_secret_map_area(void)
> > +{
> > +	struct sev_secret *s = sev_secret_get();
> > +	struct linux_efi_coco_secret_area *secret_area;
> > +	u32 secret_area_size;
> > +
> > +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
> > +		pr_err("Secret area address is not available\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
> > +	if (secret_area == NULL) {
> > +		pr_err("Could not map secret area header\n");
> > +		return -ENOMEM;
> > +	}
> 
> There doesn't seem to be anything truly SEV-specific in here at all.
> Isn't this more accurately called "efi_secret" or something?  What's to
> prevent Intel or an ARM vendor from implementing this?

I don't think anything; although the last discussion I remember on list
with Intel was that Intel preferred some interface with an ioctl to read
the secrets and stuff.  I'm not quite sure if the attestation/secret
delivery order makes sense with TDX, but if it does, then if you could
persuade someone to standardise on this it would be great.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

