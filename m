Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA40D956D5
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2019 07:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfHTFrA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 20 Aug 2019 01:47:00 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42790 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfHTFrA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Aug 2019 01:47:00 -0400
Received: by mail-lf1-f43.google.com with SMTP id s19so3131920lfb.9
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/16MSoB080+HPdEFGeDYjIeK82W9jRb08AH0y5e7ug=;
        b=ONrMQaez/cE4lLvCHTz83wtZhsB6/S4LzrA9EZrBW2K3t2ECG+uxRDWV23qT9rLzpN
         1z3IWOd8jc1HkoLiDGbFYVOMNA6odIeqAnNGVhbYia9Hts4arGeJW6Y6NJOvCLd/3ST+
         Zx5c8d1x7LnZisVXAmLmVMQRX9O1ye60gMU638z3Yrup9N0o4Yeq8zJ14bzMFirSydY9
         HK8q5i/NI6Wdw90AuotXYccM85of5EJzPuPozi5EsiNpb6/QY52qzmvWjo2zFjRk7gg7
         xJ2sGUa8uxrHMISm2XaEQ5+EyKQWPzc7vMAjHtlVpEpEhIPS+55ytCUNUjSiQ+EuOFz2
         JaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/16MSoB080+HPdEFGeDYjIeK82W9jRb08AH0y5e7ug=;
        b=NNimb8n7O6Sjd0/mT8lNkVX48f46jFmU+H+n55FjWbEsvlFzWLB398prJjjk1NKRcT
         X99KqXxAY+cMYsrPlgNd6KFCGyTduqxonrxTTgiJvvyleh51G2bzQI+mDXnB9hF6YRu/
         3VII2vT6ggL4RoAcwSdKhDRyK+p5SHe4RRsYgwCPAafzJB/oT8mwGCxHPdnAiuItbuY3
         dp5zHSzAcH/1X4UIwabvdlLLs3/teyt84By+bKvH/riGro85LfqvIaIkJmLEkrQZ6XZV
         sCjZGXrPzBVSmGjZBGbxFMUhafUUEEFFv8JxxN+WtlR9+bTqiDEXA7iWbruiKLAmNf4s
         x+Ww==
X-Gm-Message-State: APjAAAXszZg37Kisq9MWHtdhzCeqhG0AzR/SkBA1SJe1yQHiIo496CwX
        MhUorruqi+OYsUOBQhBLJx8q4/AJRXuf51GSkjOGqw==
X-Google-Smtp-Source: APXvYqzXgsI4jHSs1KfPdhgjOlMxnhbURzhgo1Vij0mJo5HH0MGoR46f8bFCz8tBN4/AFA4sE2vR/FBxk0cIvZrvyJk=
X-Received: by 2002:ac2:5637:: with SMTP id b23mr14863080lff.186.1566280017646;
 Mon, 19 Aug 2019 22:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org> <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
In-Reply-To: <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Aug 2019 11:16:46 +0530
Message-ID: <CAFA6WYMCjKCf=aCVEXrQtZJ57V+2MCLNZKov6t37unzgpLmc0A@mail.gmail.com>
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
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

On Mon, 19 Aug 2019 at 22:24, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 13, 2019 at 01:22:59PM +0530, Sumit Garg wrote:
> > This patch-set is an outcome of discussion here [1]. It has evolved very
> > much since v1 to create, consolidate and generalize trusted keys
> > subsystem.
> >
> > This framework has been tested with trusted keys support provided via TEE
> > but I wasn't able to test it with a TPM device as I don't possess one. It
> > would be really helpful if others could test this patch-set using a TPM
> > device.
>
> I think 1/5-4/5 make up a non-RFC patch set that needs to reviewed,
> tested and merged as a separate entity.
>

Okay.

> On the other hand 5/5 cannot be merged even if I fully agreed on
> the code change as without TEE patch it does not add any value for
> Linux.
>

I agree here that 5/5 should go along with TEE patch-set. But if you
look at initial v1 patch-set, the idea was to get feedback on trusted
keys abstraction as a standalone patch along with testing using a TPM
(1.x or 2.0).

Since Mimi has tested this patch-set with TPM (1.x & 2.0), I am happy
to merge 5/5 with TEE patch-set. But it would be nice if I could get
feedback on 5/5 before I send next version of TEE patch-set.

> To straighten up thing I would suggest that the next patch set
> version would only consists of the first four patches and we meld
> them to the shape so that we can land them to the mainline. Then
> it should be way more easier to concentrate the actual problem you
> are trying to resolve.
>

Okay will send next patch-set version with first four patches only.

-Sumit

> /Jarkko
