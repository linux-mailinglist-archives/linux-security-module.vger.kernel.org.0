Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0C12195
	for <lists+linux-security-module@lfdr.de>; Thu,  2 May 2019 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEBSDV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 May 2019 14:03:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36844 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfEBSDU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 May 2019 14:03:20 -0400
Received: by mail-it1-f193.google.com with SMTP id v143so4974813itc.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 May 2019 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxRYtB+CK6Ich2oLVLgzBqTdwyqbVB4RtVqM1iRZzuk=;
        b=AHmFY0vpHLiYI3WSJEyOMUm1XfkTvSqPKSXw7HXgBlZL663topOcjXDnBPRqIqlJBZ
         41mzOPiqZaRtuyFfHaL4mGPxlCLNHu4LV2R7fWyVBFrX/iHu/sT8OcmEoNEmFBIohMaB
         1zzdwFk0aOGsG8ei3M4dHdTt7jBYuJCq/uKAybSgLx0QIWRh4yXJ48BbMciuTz9jrWto
         NVeD6ozfjOaWvO3Eso+0U/ljm39krOkrfHpLrfyb4uCaEq8BXNyShmacpEduMePeZnTu
         IbXH83VvWrEFWFA12FOu80yYxNDIqLTFG4pgYFy8HKi5s7DZwfr28Z5lro8hdbiLOdVN
         nqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxRYtB+CK6Ich2oLVLgzBqTdwyqbVB4RtVqM1iRZzuk=;
        b=dZE4cAXRzhJQkNtKEbLRw8MfyaICN8+oK1Kmc9KKFZOWUw8Oc9k2fHbNLdZTIhyEMf
         GYxoD1r781azwTgbuw+VtZn8tQejROEfCknEC71yVK1wDj/+IruavTH4RmpoI0tDme7Q
         HZwkWpvnUqikugYf6u1bGRzOVMHdsP7dTQJ4RDyf/T8Cy2DaqD4qnaEdik4Qe9rNpWw+
         mXSUqEdOmpGMafuvPggQBzS48RjoTwERMxeiIwF9XMFtyi/zmUfpcI6tk+v9gX/i4wii
         VEQijcerZQRlc+DnI4l/q72vNrJlBqztIIVSUYjumkuRkmVql001fr4HT9i+Rf/X+O6H
         xUkw==
X-Gm-Message-State: APjAAAUNglDXidl2NgZMygf8mpCXL4NyIzzbepgT5SRkFTqXJqzIeSPF
        vUuwAGjiTRSTVppyNg7V8zwCnd/B6qbiT8E/Cv5NBA==
X-Google-Smtp-Source: APXvYqyqfla42J1qTMxEwr32GVdabbeeY3qkXtELGveMOE53U2Kq5Sc4qHI4ai6a8x3wPxU1FzWZVuf2XCzdmkD/TOA=
X-Received: by 2002:a24:eb04:: with SMTP id h4mr3780308itj.16.1556820199498;
 Thu, 02 May 2019 11:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <20190502083240.GJ14532@linux.intel.com>
In-Reply-To: <20190502083240.GJ14532@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 May 2019 11:03:08 -0700
Message-ID: <CACdnJuv1vwi7hgyGb-7a0dKfRhwdXTgj2baxO=qzpB_JJ1a9XQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Bartosz Szczepanek <bsz@semihalf.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 2, 2019 at 1:32 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Apr 30, 2019 at 03:07:09PM +0200, Bartosz Szczepanek wrote:
> > I may be a little late with this comment, but I've just tested these
> > patches on aarch64 platform (from the top of jjs/master) and got
> > kernel panic ("Unable to handle kernel read", full log at the end of
> > mail). I think there's problem with below call to
> > tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> > passed as (void *) and never remapped:
>
> Not late. This is not part of any PR yet. Thank you for the
> feedback!
>
> Matthew, can you send an updated version of the whole patch set
> with fixes to this issue and also reordering of the includes?

Yes, I'll resend and let's do this again for 5.3.
