Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6A1ECB0B
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jun 2020 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFCIIA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 3 Jun 2020 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCIH6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jun 2020 04:07:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747FC05BD1E
        for <linux-security-module@vger.kernel.org>; Wed,  3 Jun 2020 01:07:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o9so1545757ljj.6
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2020 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qm1Fufz0OVB6tfCS+0Zsp1jGFDeHl0Qe2Wk3cNVFIjE=;
        b=em6VoVH3kTta5GgGnR4yxb0C9pC1Go/C30Wl2dHtASemgL3MKbw20qcTF6Xp/bqged
         RqOiCSv36QuACxRruwObvBTcwUk07Vmv1pRD7jpaD80GjeML6wGVdnohnXhDpk4O6+vj
         CYcJiJHrTqBZ0vrJitGDSVZcpdMJoTTeyYXQ6IKOQcGDkoR5aMwVFg1dMeW+q79MUbvm
         UM03uTMHvxOc+IDw/fvKIk3IgDSfh7K96pi/PSu+HgDag/sDDXiL0MFQeFJsr7+wOAHd
         jiR0M0thaeIfsT1hu5gedkVkCI75yMeGExpSo9+ia+XoHXJRolqp+4yzG5CkerIzUioR
         nkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qm1Fufz0OVB6tfCS+0Zsp1jGFDeHl0Qe2Wk3cNVFIjE=;
        b=m7M28VryKiCbnZWkk8nJU7nvEsUbiAzwpYgiu8UF28GC4zAGwsG+okcqifSUxiK8hE
         IC1RsMq1qPN531tXiq9MWM6wFuj8h2AWOcGbksJM38irieinVyqpz17NLNPR+XtpggC/
         JRV5jVBigcpH5hl8fEUhIepY8iUdv4yHGH/qDiNkB4D8nq596KDQkl81h7m8tOa/fKyc
         y0s6+6fOOXmNMm8XmCH8ZtpQmXWPxCw9bLF7u+alZSukGZQp2XhFTDKAO/CpgCmr1GvL
         RbEznoL/mqpJaH4mqfRLc2Mw96Al0ESuFwHQvNE+Y9od1GgMCgljtst0m/wzhxUxFC+H
         WBfg==
X-Gm-Message-State: AOAM530fRQhRyOpnvw/MwxGwJDr5fe2UDy4UWcpM2nh1fnKeaSAK2utM
        JxV7iaPiEXDgmaU6Ro/bhux5F5s3uHdH+HFgQa4F4A==
X-Google-Smtp-Source: ABdhPJxcPvpE6Kivg7poyIQDKjTdaR1zLLkk4Fmt5UIvp5/hGBWWhPNMg87+/+CuxmPgVa3FetzyOOjx5sQTccuyCM0=
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr1553238ljo.110.1591171676264;
 Wed, 03 Jun 2020 01:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org> <1591108981.4253.17.camel@linux.ibm.com>
In-Reply-To: <1591108981.4253.17.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 13:37:44 +0530
Message-ID: <CAFA6WYOoMdLJ2g3gocZBZWdu-7Nfw7LKHnzX8S8FKeC7cuNwYg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2 Jun 2020 at 20:14, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the
> > functionality to seal and unseal trusted keys using hardware unique
> > key. Also, this is an alternative in case platform doesn't possess a
> > TPM device.
>
> So here's a meta problem: in the case when the platform possesses both
> TEE and TPM  what should it do?

IMO, trust source (either a TPM or a TEE) should be unique and
carefully chosen as per platform security policy corresponding to a
particular threat model.

And moreover TEEs have been mostly used in the embedded world where
having a hardware TPM is cumbersome given constraints regarding BoM
cost and hardware resources.

>  Things like this:
>
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -25,6 +25,8 @@
> >
> >  #if defined(CONFIG_TRUSTED_TPM)
> >  static struct trusted_key_ops *trusted_key_ops =
> > &tpm_trusted_key_ops;
> > +#elif defined(CONFIG_TRUSTED_TEE)
> > +static struct trusted_key_ops *trusted_key_ops =
> > &tee_trusted_key_ops;
> >  #else
>
> Say it's either/or at a Kconfig level: so if you select both TEE and
> TPM based trusted keys at compile time, we intall the TPM ops and
> ignore the TEE ops, is that right?  Surely this should be runtime
> selectable based on what the platform has ...

This dynamic selection was already part of v4 patch-set but after
objection from Jarrko here [1], I switched to compile time mode
instead.

[1] https://lkml.org/lkml/2020/6/2/139

> perhaps it should even be
> selectable per key?
>
> Once it is runtime selectable, what should be selected in the both
> case?  Or should we allow the user to decide, if so, how?
>
> when you pipe a trusted key, I think the subtype (TEE or TPM) should be
> part of the piped information, so it loads again seamlessly.  This
> would actually be fixed by something like the ASN.1 scheme I'm trying
> to upstream, at least for TPM keys, but do TEE keys have a recognized
> ASN.1 format?
>

I guess this is something which we can refine later if there are real
platforms that have a particular security requirement to support both
TPM and a TEE.

-Sumit

> James
>
