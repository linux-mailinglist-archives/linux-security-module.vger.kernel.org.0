Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699969247C
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Feb 2023 18:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjBJRcy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 Feb 2023 12:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjBJRcw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Feb 2023 12:32:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F678D4F
        for <linux-security-module@vger.kernel.org>; Fri, 10 Feb 2023 09:32:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n3so4174986pgr.9
        for <linux-security-module@vger.kernel.org>; Fri, 10 Feb 2023 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1676050370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGMTFKoCBVoIuyA3qlOD8xOm7koGj1xemOk912C4V+A=;
        b=Vn7d2rD7KGb7soIfLuYz1nXiJpWVaDMVEjgXteyCUSzsxr9Ncgw5UXzFLSbVKN4S/A
         0cNjJaodxEQj/fEADyE0WZIGlfJzE3cvA6yuJWvmOcY8Qn0ZRFbwDDaHDLXQOmXjKGKc
         +6YnLJWmQb25ktasgn3xtGPPz8uMe2oJdmnz0VyDW+gRGgo9/ZpuRjeshqHyQhrqC9BJ
         coRxqszDAsqrCbcMcC9a5OSEMQXOoHhTWVUeu6/bqCxv30bjtf20ysQVu/JwpLN9Oirv
         XqIFUU9DzANMzAhpTEARzChmzDzUQDJ7HPGzBvtmHrwHJ2Wj+5jzViU7/t0T8CXtQG3O
         UubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676050370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGMTFKoCBVoIuyA3qlOD8xOm7koGj1xemOk912C4V+A=;
        b=z3RnO4My1J70797HS+rPCXqmiADK+N8cEBePwE5581FAd28JqN/UuW5/6oXL/TG7BP
         8Lzbq3zhQMxPoGLZQqN58uNTNEodP4VAbMKpQvDvEzHayuBZv0g+y06o+zptvliMb/6r
         Aa34QNgX4nrUYKMJbzl80GMzEivzGKyVWyD8N8j8LvG58qDyWoaMyywALdNkyY2dQxBM
         uSRD3dofoLuVEoNSQ36dqOyEgW0xTX9j6Kw/fmxN+6G+0AxRnnN22tdTRYrUDJToi2Vi
         penYXCbqRO64e6hyRds/BgGf9Yrc2XGSQiSxyIfwbYJyrvK46gsgBmTS6MSkkiBNr9ZI
         qyew==
X-Gm-Message-State: AO0yUKVY2Jl1gMmY5igpJeb/3iZTyuHYfeIIrB8wafLOTsUMvDvIcnYF
        hdC/sN+wxowbrjac+ZHD4NnaI699WpThrzR6zNzU
X-Google-Smtp-Source: AK7set+OFwR+/j/4Th5qsCUEm60XL68IDyvuTHzlxIKdhE8fa2HwbFZ2wXzS/HuuMttpavQk/9qh74WXRb4WZw948c8=
X-Received: by 2002:a62:5f02:0:b0:5a8:5247:2589 with SMTP id
 t2-20020a625f02000000b005a852472589mr1477860pfb.7.1676050369837; Fri, 10 Feb
 2023 09:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
 <20221227142740.2807136-3-roberto.sassu@huaweicloud.com> <Y64XB0yi24yjeBDw@sol.localdomain>
 <d2a54ddec403cad12c003132542070bf781d5e26.camel@huaweicloud.com>
 <857eedc5ad18eddae7686dca63cf8c613a051be4.camel@huaweicloud.com>
 <Y+VBMQEwPTPGBIpP@gmail.com> <CAHC9VhTYeqCB8roaNvWUYJeKPwT35ixJ8MMXBe0v0+a9o8CXWw@mail.gmail.com>
 <Y+XAbz6YmazGNFQr@kernel.org>
In-Reply-To: <Y+XAbz6YmazGNFQr@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Feb 2023 12:32:38 -0500
Message-ID: <CAHC9VhQ8e96LbCSBMXoQwETJBmWvazjzSDE2X4cr3ezhaC_5uA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 9, 2023 at 10:56 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Thu, Feb 09, 2023 at 05:46:32PM -0500, Paul Moore wrote:
> > On Thu, Feb 9, 2023 at 1:53 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Thu, Feb 09, 2023 at 11:49:19AM +0100, Roberto Sassu wrote:
> > > > On Fri, 2023-01-27 at 09:27 +0100, Roberto Sassu wrote:
> > > > > On Thu, 2022-12-29 at 14:39 -0800, Eric Biggers wrote:
> > > > > > On Tue, Dec 27, 2022 at 03:27:40PM +0100, Roberto Sassu wrote:
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > >
> > > > > > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > > > > > mapping") checks that both the signature and the digest reside in the
> > > > > > > linear mapping area.
> > > > > > >
> > > > > > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > > > > > stack support") made it possible to move the stack in the vmalloc area,
> > > > > > > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > > > > > > adjacent pages.
> > > > > > >
> > > > > > > Always make a copy of the signature and digest in the same buffer used to
> > > > > > > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > > > > > > to conditionally doing the copy if necessary, to keep the code simple. The
> > > > > > > buffer allocated with kmalloc() is in the linear mapping area.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org # 4.9.x
> > > > > > > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > > > > > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > > > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > ---
> > > > > > >  crypto/asymmetric_keys/public_key.c | 38 ++++++++++++++++-------------
> > > > > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > > >
> > > > > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > > > >
> > > > > Hi David
> > > > >
> > > > > could you please take this patch in your repo, if it is ok?
> > > >
> > > > Kindly ask your support here. Has this patch been queued somewhere?
> > > > Wasn't able to find it, also it is not in linux-next.
> > > >
> > >
> > > The maintainer of asymmetric_keys (David Howells) is ignoring this patch, so
> > > you'll need to find someone else to apply it.  Herbert Xu, the maintainer of the
> > > crypto subsystem, might be willing to apply it.  Or maybe Jarkko Sakkinen, who
> > > is a co-maintainer of the keyrings subsystem (but not asymmetric_keys, for some
> > > reason; should that change?).
> >
> > It is problematic that David isn't replying to this.  I have no idea
> > if it will work, but I just reached out to him to see if I can draw
> > his attention back to this ...
>
> See my response to Eric.

Thanks Jarkko.

-- 
paul-moore.com
