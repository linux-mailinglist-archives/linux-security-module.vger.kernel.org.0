Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE888B1E3
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Aug 2019 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfHMH7d (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 13 Aug 2019 03:59:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34425 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfHMH7c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 03:59:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id x18so4236986ljh.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppVR4stowlIJ6/4pZZBiqz7XFOa7GBtQMtynjohKpDM=;
        b=gMNzHJkjPlTKg8J3P1ItvpHxlkyUzWeShHE+QJSJ32VauPTGnzGKsD+QuZrHHI76pj
         RQaLjgiFHttMYl1YL5egx0p1M2IIOgyXxDeB1ftBhbKgE91RpNxJqdP+/QCc15BfoOhL
         Z1+PP778xl2OwXclKn24vrxEMqdB2zsz1S9Mo+1+LLBC3XvBF1qfh81VIeKQdgw15Wfs
         3UPAiB+GQfna3uzgBhqY2DIQZ1U1Dd6wdEjtIkq7MQrftD+JJ76fJF/zUJB30qtgXZ8g
         gkbmkqgpWNNJ+9OWrPYhYkczySrcOktUtmOi5kVY6tzWBM01UKaeDCvccNuWK35inzMd
         u0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppVR4stowlIJ6/4pZZBiqz7XFOa7GBtQMtynjohKpDM=;
        b=FTHZCixgnajXjy1u2hgirV4KoGal52AbXD/1O23F1HjVjXJR3i7o4S/sPjdTEb6nb+
         Pgqsct8tVIF3VOxkFU+I/8D7+xAqRG8i81sJGg1RvTDF5gL+nhiLVUU1aCknvqnE7ZWb
         e8Wtl/ZcyeuBHrPaP03aE/8hNqNX6c3GPZESS+C5rDOWDkBhC39fKRAaXKcUnbv9qf0R
         Q9+XkG/NFAzXdZwUt8DaaAEHQDjOvzCYvk5WYO7bcSFuVeRZntazefaZjwT6cuXoUFfh
         czo0FwcbCYMZssTMEjdduiUxwMl+6oZyWwDOudsQcUqSbsuGiwoyguetv0/8ZaQ/++MI
         a8Jg==
X-Gm-Message-State: APjAAAUyJUFWXSy9hRg5c2ZPutjXz/1XN5Ev7lFDApMW7Oa8tKPeRowc
        +NmJ7l0Ld2q5BLVo+Wwm4s2p9C1wXjCzQcsjAqrQqA==
X-Google-Smtp-Source: APXvYqy9Xa1Q8vdR2OCkDVG7ShxG5L9IQXmi6qKK2LlN8HtiapeB1JlrnTXdtXIphrZmMJ+SZciCiafKR0IU/QMDd44=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr19876829lji.115.1565683170315;
 Tue, 13 Aug 2019 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
 <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com> <20190808151500.ypfcqowklalu76uq@linux.intel.com>
In-Reply-To: <20190808151500.ypfcqowklalu76uq@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Aug 2019 13:29:19 +0530
Message-ID: <CAFA6WYNqBH9aAM-uke6jFTCeLB2GG7UYyrYEPHgyVy8p_q+Pww@mail.gmail.com>
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 8 Aug 2019 at 20:46, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Aug 08, 2019 at 06:51:38PM +0530, Sumit Garg wrote:
> > It seems to be a functional change which I think requires proper unit
> > testing. I am afraid that I don't posses a TPM device to test this and
> > also very less conversant with tpm_buf code.
> >
> > So what I have done here is to rename existing TPM 1.x trusted keys
> > code to use tpm1_buf.
> >
> > And I would be happy to integrate a tested patch if anyone familiar
> > could work on this.
>
> I can test it on TPM 1.2.
>

I have posted v4 with changes as you requested. I hope they work well
with a real TPM 1.x or TPM 2.0 device.

-Sumit

> /Jarkko
