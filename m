Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A098C487CE3
	for <lists+linux-security-module@lfdr.de>; Fri,  7 Jan 2022 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiAGTQU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 7 Jan 2022 14:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiAGTQT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jan 2022 14:16:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF44C061574
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jan 2022 11:16:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j11so19010393lfg.3
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jan 2022 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UBa8TIub3c8pRJx3V/U7Z+AnL0F11KM1pHQYfYCQSfE=;
        b=KrbM0oijNYC/s0QrkLzFOE4pJ7VfLV2sz3ZRQE4BmZLvBBiYqz8BLiPARQR6ypW7cC
         6LkELtaavqygIW+B1d4TlVGnWfoy+RFpt6Q7FXgF2C8XuPkXqXIiOV5HAKHDDnx6tzfu
         LXVkI3V/mrFHfRuJsnvzyDwJDWoFFvquCfvRd3kiBzhxY6vqs6soJkppLxjW0ZbWegZh
         GexGcqkRdPZ8ERdcu6VbK6E+kKAeg5oLNZZ6MW+y1Bz5caWPGLLUzGiXrhQa96tn6IBu
         EAQDTyr4xELOqYbB/Dud+Car+0NPN2JyCHWjfYncMgHPplFRCdrSSpOpg1JRJhA/QN40
         RXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UBa8TIub3c8pRJx3V/U7Z+AnL0F11KM1pHQYfYCQSfE=;
        b=BGbselbfEb0z6sa37/bkMCl2ixzI8HEPyP1qzIaTHAWgsZMXQAj7mKiJcbgeoc6LCJ
         i+gOluSDq6S901JooY6b920jsXRf7JHCVNqBop8qi3R6czKBVQmXWjlPIOG22q2xVNuD
         t1lX3wSh7vmmgX0xku65zZviFib1yIYPXbMv3AXSqg7l67/raT7+IbZ3RRA775MrWQ0P
         NfkvKeaIKlZ14/m9eM+hg3yR4NxiLJQoylyOfMsnXDrMb/zAA5B1vxPYeJ4U3g/RtrJa
         MZZ5ej/5ivPcJdrrGez6dJAu2XkI1UBpFVa3L2rHL5A9f9CBcNAN4Z6MUVWfBJFsEmCV
         Zlzg==
X-Gm-Message-State: AOAM532zImSJwqsVVihVZAyiN9W2acWsS+Y5ANBq5Web4zGky21uSp5v
        qQ3Nqfho379JLOzbUG3z9nOZmy5eIbCQrEFwQGxj0g==
X-Google-Smtp-Source: ABdhPJwc9hFf6RV7zJN6Wxk7n3MNRt1wyKE1/d66jX9gd/5RqFCaxpNL4bWnd1Ly12Sdc+RlpTZsyMeHdFr707d9p7U=
X-Received: by 2002:a05:6512:2828:: with SMTP id cf40mr56909749lfb.644.1641582977032;
 Fri, 07 Jan 2022 11:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic> <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic> <YdWEXRt7Ixm6/+Dq@work-vm> <YdXq9t75aYLJfb69@zn.tnic>
 <YdX6aAwy0txT9Dk7@work-vm> <YdgrDRCJOOg4k1Za@zn.tnic>
In-Reply-To: <YdgrDRCJOOg4k1Za@zn.tnic>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 7 Jan 2022 12:16:05 -0700
Message-ID: <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
To:     Borislav Petkov <bp@suse.de>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 7, 2022 at 4:59 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Wed, Jan 05, 2022 at 08:07:04PM +0000, Dr. David Alan Gilbert wrote:
> > I thought I saw something in their patch series where they also had a
> > secret that got passed down from EFI?
>
> Probably. I've seen so many TDX patchsets so that I'm completely
> confused what is what.
>
> > As I remember they had it with an ioctl and something; but it felt to
> > me if it would be great if it was shared.
>
> I guess we could try to share
>
> https://lore.kernel.org/r/20211210154332.11526-28-brijesh.singh@amd.com
>
> for SNP and TDX.
>
> > I'd love to hear from those other cloud vendors; I've not been able to
> > find any detail on how their SEV(-ES) systems actually work.
>
> Same here.
>
> > However, this aims to be just a comms mechanism to pass that secret;
> > so it's pretty low down in the stack and is there for them to use -
> > hopefully it's general enough.
>
> Exactly!
>
> > (An interesting question is what exactly gets passed in this key and
> > what it means).
> >
> > All the contentious stuff I've seen seems to be further up the stack - =
like
> > who does the attestation and where they get the secrets and how they
> > know what a valid measurement looks like.
>
> It would be much much better if all the parties involved would sit down
> and decide on a common scheme so that implementation can be shared but
> getting everybody to agree is likely hard...

I saw a request for other cloud provider input here. A little
background for our SEV VMs in GCE we rely on our vTPM for attestation,
we do this because of SEV security properties quoting from AMD being
to protect guests from a benign but vulnerable hypervisor. So a
benign/compliant hypervisor's vTPM wouldn't lie to the guest. So we
added a few bits in the PCRs to allow users to see their SEV status in
vTPM quotes.

It would be very interesting to offer an attestation solution that
doesn't rely on our virtual TPM. But after reading through this cover
letter and the linked OVMF patches I am confused what's the high level
flow you are working towards? Are you loading in some OVMF using
LAUNCH_UPDATE_DATA, getting the measurement with LAUNCH_MEASURE, then
sending that to the customer who can then craft a "secret" (maybe say
SSH key) for injection with LAUNCH_SECRET? Thats sounds good but there
are a lot details left unattested there, how do you know you will boot
from the image loaded with the PSP into a known state? Do you have
some documentation I could read through to try and understand a little
more and apologies if I missed it.

>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG N=C3=
=BCrnberg
>
