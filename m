Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD2222684
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Jul 2020 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPPIg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Jul 2020 11:08:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45781 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPPIg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 11:08:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id u12so5077050qth.12
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 08:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBJgfCD5/AmWoWjEm1lKJpXBMaTQmTNpQaZofnyM7L0=;
        b=jpDfOxO9OPhJtC/15sFqd0CItPicYWr4762C+AAXzISbzUhSgXFY3M8X2Sg/BeiKZI
         h8ise866StxYyQOtjKtseqyDFORWtx7ikJeUUKAZo/BTfQeoDNEtQ/ZkU90JHb/zz0lJ
         k7Kwj4cXsGoBukoSaN03AljTZUryfdV8RZzaIb0xdJW4n8URtHr0BD2osKoopx+qdfrF
         YTTesA8E3+qC+AqrTawFte03UGG/W8Fz8jrlyU9uUPxRvarxh0xGi7dxEkcRjg41ZMKY
         xRKw1VAw4Ss+nf+Fcjy85T4f1u5vZBWY3c5W6X4hHh7RFOyDscBIglHnzEtHoLeRqjYC
         ThxQ==
X-Gm-Message-State: AOAM5319s3K+euwaohZ4k+RPL2D0YhD/oemhuy9j9Q9mh49T+HVQXmPJ
        9pSGgN80jJ7m940w+RFzM9NQzCs4KKvrzN5ixcJFojc4z9w=
X-Google-Smtp-Source: ABdhPJxIgAbB51DLBaq8cw4jXl978vldnSrr+gWhlQATsmUvnBoXdG2sH7reEveA9N0Js97c/HYf6kiJ0j/QpPmg6Us=
X-Received: by 2002:ac8:3797:: with SMTP id d23mr5672877qtc.25.1594912114836;
 Thu, 16 Jul 2020 08:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200716101827.162793-1-mtk.manpages@gmail.com> <20200716101827.162793-16-mtk.manpages@gmail.com>
In-Reply-To: <20200716101827.162793-16-mtk.manpages@gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Thu, 16 Jul 2020 08:08:20 -0700
Message-ID: <CALQRfL6dAEgiUiEckUN9x_g0J+sywz+Q_zBfPqPFTBsf2zRt=A@mail.gmail.com>
Subject: Re: [PATCH 16/16] capsh.c: Spelling fixes in usage() message
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks! Applied all of them except 07_16. Instead, I've hopefully
clarified the intent of the text with some quotes.

Cheers

Andrew

https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=34e4e00b983a2c0fc5f13b403871a8fb5860bb89

On Thu, Jul 16, 2020 at 3:19 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> ---
>  progs/capsh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/progs/capsh.c b/progs/capsh.c
> index 94bf57d..7bed98e 100644
> --- a/progs/capsh.c
> +++ b/progs/capsh.c
> @@ -879,10 +879,10 @@ int main(int argc, char *argv[], char *envp[])
>                    "  --delamb=xxx   remove xxx,... capabilities from ambient\n"
>                    "  --noamb        reset (drop) all ambient capabilities\n"
>                    "  --caps=xxx     set caps as per cap_from_text()\n"
> -                  "  --inh=xxx      set xxx,.. inheritiable set\n"
> +                  "  --inh=xxx      set xxx,.. inheritable set\n"
>                    "  --secbits=<n>  write a new value for securebits\n"
>                    "  --iab=...      use cap_iab_from_text() to set iab\n"
> -                  "  --keep=<n>     set keep-capabability bit to <n>\n"
> +                  "  --keep=<n>     set keep-capability bit to <n>\n"
>                    "  --uid=<n>      set uid to <n> (hint: id <username>)\n"
>                    "  --cap-uid=<n>  libcap cap_setuid() to change uid\n"
>                    "  --is-uid=<n>   exit 1 if uid != <n>\n"
> --
> 2.26.2
>
