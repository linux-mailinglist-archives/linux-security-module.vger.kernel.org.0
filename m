Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE177D680
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2019 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfHAHkw (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 1 Aug 2019 03:40:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45772 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbfHAHkw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Aug 2019 03:40:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so68289218lje.12
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2019 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2DnLeysC51Jmq+BwRcdvsefRXSYiI2YJl6s9A/zlto=;
        b=qrMT7PcgSqQaPkhDNxMbADKheyhBnSC+xpb7kKF54VBYkSMPossLqpaZCuNtF0lDMK
         qXMEZEB3PZU5mAOOK9m7rgG41ScrZQmYocuw/IlarqJeVGqi35sAmjysYfxFyzDpdwrE
         q0o1/fC76kq7sPI1X42ApVVwfrkAaLdqAWBgpE4pkfS5OjtTTBWyOF0eCL4MZjZx1E5O
         hL8RRxrqjhZmDoasT8A3YGGN8527eUUnk+H3CroOjZQa0hqO8N1YZkTAY116z0aFZIV/
         b8i6FslmwUzzoFlRmDqExDGN92AQOqj3haKzc3fHcFHkDuqot0ElZe4/3d+LWlRDtHx3
         44jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2DnLeysC51Jmq+BwRcdvsefRXSYiI2YJl6s9A/zlto=;
        b=AFmNuMVx57yiqj7kvrpoxbgveV109Gfallacve5/QThggSXpVKnhfM5722t55W9uSS
         vvhydiLMsLGLQCw7Trfo2YQHi7adcUBB6+gWL6CL1vTAo4uTFawoUA1vmPFbbwDHw8WW
         0kIBB1fIcxbKTi757tiz55/DrPpEdbiKB+hQXru7rNJUkYLNSAiQAwqSHvZITnz68VVn
         3g6aJG65g8Iy/PF+buCVqDAfB9CkEsnI8wv2ID0iQfYz6nzn7xYPxX1ljCF7yk98wd5X
         +pFSZgvVTOyTd8uDSKJEI4t5eJu6SI6KS0RbOjsTfnaxQ61Jk2q3dn1pLYiZf+kQxBck
         3EcA==
X-Gm-Message-State: APjAAAVar+EbPuv3a9R4BNcyc5638+OhY/nHfbPNatMTbo379R0Ivz2M
        c4B1+LzZSCdx+D1oLjewYs1/9XYFsp7a3ghEIUGJow==
X-Google-Smtp-Source: APXvYqzq0IJ9GtmcxYuyJWtDtzNwkmT4P2unALVLFpkxdrititI5GvPVtJgr09S2tzYu63OXgUbjTzql4hcILCNGdOk=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr63101245lji.115.1564645250122;
 Thu, 01 Aug 2019 00:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com> <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
In-Reply-To: <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Aug 2019 13:10:38 +0530
Message-ID: <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 1 Aug 2019 at 11:51, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 4:58 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > To clarify a bit further - my thought was to support any type of trust
> > > source.
> >
> > That could be very well accomplished via Trusted Keys abstraction
> > framework [1]. A trust source just need to implement following APIs:
> >
> > struct trusted_key_ops ts_trusted_key_ops = {
> >        .migratable = 0, /* non-migratable */
> >        .init = init_ts_trusted,
> >        .seal = ts_key_seal,
> >        .unseal = ts_key_unseal,
> >        .get_random = ts_get_random,
> >        .cleanup = cleanup_ts_trusted,
> > };
>
> Which is basically the same as implementing a new keytype in the
> kernel; abstraction is not raised in any considerable manner this way?
>

It doesn't create a new keytype. There is only single keytype:
"trusted" which could be implemented via one of the trust source
available in the system like TPM, TEE etc.

> I chose the userspace plugin due to this, you can use userspace aids
> to provide any type of service. Use the crypto library you desire to
> do the magic you want.

Here TEE isn't similar to a user-space crypto library. In our case TEE
is based on ARM TrustZone which only allows TEE communications to be
initiated from privileged mode. So why would you like to route
communications via user-mode (which is less secure) when we have
standardised TEE interface available in kernel?

>
>
> > > With the
> > > user mode helper in between anyone can easily add their own thing in
> > > there.
> >
> > Isn't actual purpose to have trusted keys is to protect user-space
> > from access to kernel keys in plain format? Doesn't user mode helper
> > defeat that purpose in one way or another?
>
> Not really. CPU is in the user mode while running the code, but the
> code or the secure keydata being is not available to the 'normal'
> userspace. It's like microkernel service/driver this way. The usermode
> driver is part of the kernel image and it runs on top of a invisible
> rootfs.
>

Can you elaborate here with an example regarding how this user-mode
helper will securely communicate with a hardware based trust source
with other user-space processes denied access to that trust source?

-Sumit

>
> --
> Janne
