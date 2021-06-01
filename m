Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63B4393519
	for <lists+linux-security-module@lfdr.de>; Thu, 27 May 2021 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhE0RsB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 May 2021 13:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhE0RsA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 May 2021 13:48:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 296B6610A0;
        Thu, 27 May 2021 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622137587;
        bh=5ZRnfqRtr/J0QJfUg5D/PQYEwhdZT/hAb/+xrZGlOHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfxmwW3029z6rLKsitywLDXKyPX2OAKi30JDxN16STWTO7Fxr26PZB76nT//N540K
         pRypVB7E/b6rGdqtZClQjJc8LMRnIC5xOSC0ADPOa9ShWoBd1L53v9UPYZfOaQGizi
         JCJFp0jsRUvikoaoRoM/v4tIfoJphf/G/PE/22KFIDahZV/uVG4vfYkYbYHCrp4VXw
         gj3NDBIrliYRl/rkDUKMsF55itmp2+QosiiK2VFN7RP/bPwxP3W0Ydcui6imex8A5B
         Rzi9DYUBlZ+yusdeVDv99S++VjNIi8Fl+mwOyxIbsU/oyzgzZdb2Hqo5tZhTzPLwD7
         69u+6T9vDNbtA==
Date:   Thu, 27 May 2021 10:46:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        catalin.marinas@arm.com, will@kernel.org,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, austin.kim@lge.com
Subject: Re: [PATCH] crypto: arm64/gcm - remove Wunused-const-variable
 ghash_cpu_feature
Message-ID: <YK/a8f7MhO2SlrMS@gmail.com>
References: <20210527062809.GA1251@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527062809.GA1251@raspberrypi>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 27, 2021 at 07:28:09AM +0100, Austin Kim wrote:
> 
> The variable with MODULE_DEVICE_TABLE() is registered as platform_driver.

What does this mean?  There is no platform_driver involved here at all.

> But ghash_cpu_feature is not used, so remove ghash_cpu_feature.

It is used when the file is built as a module.

> diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
> index 720cd3a58da3..c3f27d0d5329 100644
> --- a/arch/arm64/crypto/ghash-ce-glue.c
> +++ b/arch/arm64/crypto/ghash-ce-glue.c
> @@ -615,10 +615,5 @@ static void __exit ghash_ce_mod_exit(void)
>  		crypto_unregister_shash(&ghash_alg);
>  }
>  
> -static const struct cpu_feature ghash_cpu_feature[] = {
> -	{ cpu_feature(PMULL) }, { }
> -};
> -MODULE_DEVICE_TABLE(cpu, ghash_cpu_feature);
> -

Probably adding __maybe_unused to ghash_cpu_feature[] is the right thing to do.
That's what module_cpu_feature_match() does.

(Note that module_cpu_feature_match() can't be used here, as it seems the intent
is for this module to be autoloaded when PMULL is detected, but still be
loadable without it.  So, that's apparently the reason for using
MODULE_DEVICE_TABLE() directly.)

- Eric
