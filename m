Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9987E8EC4E
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Aug 2019 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfHONDw (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 15 Aug 2019 09:03:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40316 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbfHONDt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Aug 2019 09:03:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so2150926ljb.7
        for <linux-security-module@vger.kernel.org>; Thu, 15 Aug 2019 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dWebL9fI0U8v/Hpo+dz8Sut2HpNVnveufAiPqP0BQw=;
        b=FmOkGWme0a9zngByt8Xx69NGtzkfYQoKULWmL12BZ2cCel3xo9BWxubi9OjatpqIqa
         aCblyK/wBtn4LHnnByVR4FkegV/JwUl6aY5bnqtdVQLwtSTU6w0E8FXGwiwGtBwQfhyQ
         1JVGMgzHRIlY4UXyQriDsZFP2cdhFeyc1HbJRyOzuWxjQomyJM1V+qrCyl3BNnkYTAVu
         ok0fgZ5VuX3x7AI+Ve0xGQg2kqeYy1kg7OVkRp2VOwzeNu5BTeXusBlqXVAPhVZ4k83W
         anplh+2FtjGKTwwlufYZFFPtJPPN0vuHErIzzrGWR6BJCeQMLPrC6u+PFzzjAuH26anN
         2vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dWebL9fI0U8v/Hpo+dz8Sut2HpNVnveufAiPqP0BQw=;
        b=j/M4bC24wCpF2LSY0AWla4xUvm8fYBsTD8riZTMBA7f1/WWsHfLn/Ytk0orn4LALFl
         Q+LUmv8+vwOnUNABm6s2wAyJ6qR2FjSglVwNTe6W9q2oN5PnqfdAzRqo3JErRIELut60
         MlGaDqIAbQx3vZnEp9CgYQsspvvh4ziYK1KOFUWJ87ChOjBeoGyXNJHcW7n1wey8B4+C
         ccGJr9vYaoYuZkJO3/b5bhaTFP6S5Q687a2wJhCRqDqGDY/FyaA6Ll6QHN4gMgaGrp1Q
         HqmTcJBJ4SEq2/JjDlJ6VA42JknABeWWEfQ8U/g2eZCt/ky76VVT9AyLTufwF+4ZWbm4
         QH8Q==
X-Gm-Message-State: APjAAAWd8q169PrMgv9qaVmEK+81VI1K+Su1DAMaog7Fp7cQjEQzsBID
        wYzqHAm1X3j6dhy/omsedh1I8YCjW5bS4aT7HOc6+A==
X-Google-Smtp-Source: APXvYqz1/QQoHBf2h86ZFsG2s6PVvHb8R6MnNm7oO5lIAJpXQ5PL7Zmvi79AuEfoFIn8Z79YsusZkO8EhOrspBcsfmU=
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr2522077ljm.238.1565874226938;
 Thu, 15 Aug 2019 06:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org> <1565789078.10490.10.camel@kernel.org>
In-Reply-To: <1565789078.10490.10.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 15 Aug 2019 18:33:35 +0530
Message-ID: <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
To:     Mimi Zohar <zohar@kernel.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Mimi,

On Wed, 14 Aug 2019 at 18:54, Mimi Zohar <zohar@kernel.org> wrote:
>
> Hi Sumit,
>
> On Tue, 2019-08-13 at 13:22 +0530, Sumit Garg wrote:
> > This patch-set is an outcome of discussion here [1]. It has evolved very
> > much since v1 to create, consolidate and generalize trusted keys
> > subsystem.
> >
> > This framework has been tested with trusted keys support provided via TEE
> > but I wasn't able to test it with a TPM device as I don't possess one. It
> > would be really helpful if others could test this patch-set using a TPM
> > device.
>
> With the "CONFIG_HEADER_TEST" and "CONFIG_KERNEL_HEADER_TEST" config
> options enabled, which is required for linux-next, it fails to build.
>

TBH, I wasn't aware about this test feature for headers. It looks like
the header which fails this test is "include/keys/trusted_tpm.h" which
is basically a rename of "include/keys/trusted.h" plus changes in this
patch-set.

And "include/keys/trusted.h" header is already put under blacklist
here: "include/Kbuild +68" as it fails to build. So its that rename
due to which build failure is observed now.

It seems to be an easy fix for this build failure via following changes:

diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 7b593447920b..ca1bec0ef65d 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -2,6 +2,9 @@
 #ifndef __TRUSTED_TPM_H
 #define __TRUSTED_TPM_H

+#include <keys/trusted-type.h>
+#include <linux/tpm_command.h>
+
 /* implementation specific TPM constants */
 #define MAX_BUF_SIZE                   1024
 #define TPM_GETRANDOM_SIZE             14

So I will include above changes in this patch-set and also remove
"include/keys/trusted.h" header from the blacklist.

-Sumit

> Mimi
