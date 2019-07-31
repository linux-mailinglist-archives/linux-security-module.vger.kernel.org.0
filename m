Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB947BA38
	for <lists+linux-security-module@lfdr.de>; Wed, 31 Jul 2019 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfGaHLt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 03:11:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33147 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfGaHLt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 03:11:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so64557546ljg.0;
        Wed, 31 Jul 2019 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kqr8tEl+A/BsI/SRcfQuAdRPZm/jRaraQ1jAsd1n/gs=;
        b=XkPjlIKzJuoQMP5k1IsZh1gweTmAgYUgfi0sMTRiBPfg0kOUfGzkmc+xVQclJvr5nl
         sNmFNLUDHd/0OqC8c34zy5HLWPTpy7twxxUxBs/BOoQTYEnUVvKKtNJFCT9+3pBGHtpm
         wmj+cSHBY3A+8J6HQ++nKBN2YQZk5nG349PGsEeobfaj6kBDsgX2KYvHtDV53VBufFsP
         UGcqfUdntPuUlbk3T+JWTbGWMrD3jMsriHJbxp8JEH/0uaRzBF74ZNkW9CAb26vC13J/
         tHV+u9iDzM2uzApWhiA841UQA0+zmesrfzE4d6wIqQRVQHpwqWRNF8KBc5GekWu/QrCs
         K4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kqr8tEl+A/BsI/SRcfQuAdRPZm/jRaraQ1jAsd1n/gs=;
        b=m1T8cdfl+byFsF/AuhlI+skpmS0tUwZmxs9ZTwKItQMZSJkMWyjOyOdPnIan2jOT9V
         3EbHRvjE6OTU/AWDy43xFttsx/ZCbLEF0X7V9kudDku274zEdK5H/qyazQvB9zaaufJW
         q81MvFTg9TanjZOAarbT7iypgj1nUi7iQF/baApaLRQ1uMBVjVch23gTjtqyIRk47v2e
         /5EO6vyL+r1LyedStytm/HlptCmVHkYOMBUXFDXzs+djyS+rBAVZNDP/AM0bMwH2Ucvj
         HspsVNlaq7nYGIbF1PR2p8RL5q0916ygM1gIXRlPhYnHOQQNqKsJrZRYOVvLbxVRTxyd
         LWwg==
X-Gm-Message-State: APjAAAUYH3Tf0Wsgs69jBIUS1OEiuT69B97cD1ipwxu+Bz0BSOJLKcGA
        9Mo6D4085MnMqAHuVBdojbFJC4z4n2PkHS/EHWc=
X-Google-Smtp-Source: APXvYqywjHZBwxsXA1068nZBZHE0Ulkn//um58llA3xod4Ipo+akfow/68WBjfdpXjVY2Sc+txo6D77ywYRO9CqXl7E=
X-Received: by 2002:a2e:b1c1:: with SMTP id e1mr28147758lja.228.1564557106084;
 Wed, 31 Jul 2019 00:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 31 Jul 2019 10:11:34 +0300
Message-ID: <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, jens.wiklander@linaro.org,
        corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Interesting, I wrote something similar and posted it to the lists a while back:
https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6

Since there are no generic 'TEEs' available, I implemented the same
thing as a generic protocol translator. The shared memory binding for
instance already assumes fair amount about the TEE and how that is
physically present in the system. Besides, the help from usage of shm
is pretty limited due to the size of the keydata.


--
Janne




On Tue, Jul 30, 2019 at 3:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
>
> This series also adds some TEE features like:
>
> Patch #1, #2 enables support for registered kernel shared memory with TEE.
>
> Patch #3 enables support for private kernel login method required for
> cases like trusted keys where we don't wan't user-space to directly access
> TEE service to retrieve trusted key contents.
>
> Rest of the patches from #4 to #6 adds support for TEE based trusted keys.
>
> This patch-set has been tested with OP-TEE based pseudo TA which can be
> found here [1].
>
> Also, this patch-set is dependent on generic Trusted Keys framework
> patch-set [2].
>
> [1] https://github.com/OP-TEE/optee_os/pull/3082
> [2] https://lkml.org/lkml/2019/7/18/284
>
> Changes in v2:
> 1. Add reviewed-by tags for patch #1 and #2.
> 2. Incorporate comments from Jens for patch #3.
> 3. Switch to use generic trusted keys framework.
>
> Sumit Garg (6):
>   tee: optee: allow kernel pages to register as shm
>   tee: enable support to register kernel memory
>   tee: add private login method for kernel clients
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   doc: keys: Document usage of TEE based Trusted Keys
>   MAINTAINERS: Add entry for TEE based Trusted Keys
>
>  Documentation/security/keys/index.rst       |   1 +
>  Documentation/security/keys/tee-trusted.rst |  93 +++++++++
>  MAINTAINERS                                 |   9 +
>  drivers/tee/optee/call.c                    |   7 +
>  drivers/tee/tee_core.c                      |   6 +
>  drivers/tee/tee_shm.c                       |  16 +-
>  include/keys/trusted-type.h                 |   3 +
>  include/keys/trusted_tee.h                  |  66 +++++++
>  include/linux/tee_drv.h                     |   1 +
>  include/uapi/linux/tee.h                    |   8 +
>  security/keys/Kconfig                       |   3 +
>  security/keys/trusted-keys/Makefile         |   3 +-
>  security/keys/trusted-keys/trusted-tee.c    | 282 ++++++++++++++++++++++++++++
>  security/keys/trusted-keys/trusted.c        |   3 +
>  14 files changed, 498 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/security/keys/tee-trusted.rst
>  create mode 100644 include/keys/trusted_tee.h
>  create mode 100644 security/keys/trusted-keys/trusted-tee.c
>
> --
> 2.7.4
>
