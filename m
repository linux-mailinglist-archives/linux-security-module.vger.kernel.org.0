Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A05767CE
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Jul 2022 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGOTwC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 15 Jul 2022 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiGOTwB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jul 2022 15:52:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA2767170
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 12:52:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r14so8161935wrg.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=;
        b=js49Vuv+dqdpAQkHI9F+F/qf8Kw2nyiSwKlBIFQQHL7uM7G/SRteANKwRC0D5rutBM
         lRuJ2gi7kPkZDetRJeDugTcS3gtBv1nmqHP8R5VNWwq6v4T1aR3AERqkKtE3B2/cSn2w
         fvkDOT3RSZSEbMjkvSci+PeP6MNGVYzG8f2i65yt77cl/vOjOuR09OrR4tgP2Is8XhXo
         RQSpjQwTlQ/k/CvARRkb9P3CyCFKFRkgFlfuha9660OVH5gAbAniaXjf60OMuXxfq+5g
         jaTWgugHEjZyQFwbx7VEijdfxPo5hzyShYea+6a1HL5g2vXfKHW5bpNf6AR9vvKooiR6
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=;
        b=j/O6uODXbxCnknn7LYIVSVEjsCXZfQ87lGC+0H8vCTjj4/D6cbBaXS1wqDGGSESC/S
         sydSbWyTbZD34yCKKd2IKd+S/gAP2vu6DAvvLXFJCOvfSV4HoA/0p5EH0H+pT1e2fq8N
         bmsAOrPc4Y5ZO+4ykWxGYb0brnv+bP5G4MLUdaCz/DpvVLMVHeSi1/sGFLza3yO+DFSG
         tEGYnu8eG4kPQ/1V8VimG3SB/v7bG0+JWg3zr/KA/fr2/3LdX6X6ilYsog4bGVJ5p4d6
         0NFU1VMfEE26C32v3OREy7B8uvnqW6Tah0bc1bHVy/eIAry1AwHFD1SHldJF5Q9MxPx1
         IYTQ==
X-Gm-Message-State: AJIora/0gb1FeP5/nN0n20/ljywg1+cPLBADKgSsOXwaO8ID1sjQOd+o
        ZGul4UPnwcvIAHhKKjtE8RXTRrxqt/aUI+IZoc30
X-Google-Smtp-Source: AGRyM1tKdyxJ6v9iK9VYvhls34IXjSi0vTfVMFlwee16Wy9Y/gwgKOIz8VCFowTfs82eiFn6mMPxqXEzbs16sJVwfo8=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr13851074wrp.161.1657914719053; Fri, 15
 Jul 2022 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220714000536.2250531-1-mcgrof@kernel.org> <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org> <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <YtG5zRPFV967/y0v@bombadil.infradead.org>
In-Reply-To: <YtG5zRPFV967/y0v@bombadil.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Jul 2022 15:51:48 -0400
Message-ID: <CAHC9VhS_dy_qeY=7KnSqs0ZT9dzAbSEyq5WMNKvZTD5=oreGew@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file op
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     casey@schaufler-ca.com, axboe@kernel.dk, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 15, 2022 at 3:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Fri, Jul 15, 2022 at 02:46:16PM -0400, Paul Moore wrote:
> > It looks like I owe you an apology, Luis.  While my frustration over
> > io_uring remains, along with my disappointment that the io_uring
> > developers continue to avoid discussing access controls with the LSM
> > community, you are not the author of the IORING_OP_URING_CMD.   You
> > are simply trying to do the right thing by adding the necessary LSM
> > controls and in my confusion I likely caused you a bit of frustration;
> > I'm sorry for that.
>
> No frustration caused, I get it.

Thanks for your understanding, I appreciate it as well as your help in
this area.

> > Well, we're at -rc6 right now which means IORING_OP_URING_CMD is
> > happening and it's unlikely the LSM folks are going to be able to
> > influence the design/implementation much at this point so we have to
> > do the best we can.  Given the existing constraints, I think your
> > patch is reasonable (although please do shift the hook call site down
> > a bit as discussed above), we just need to develop the LSM
> > implementations to go along with it.
> >
> > Luis, can you respin and resend the patch with the requested changes?
>
> Sure thing.
>
> > I also think we should mark the patches with a 'Fixes:' line that
> > points at the IORING_OP_URING_CMD commit, ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd").
>
> I'll do that.

Great, thanks again for the help.

-- 
paul-moore.com
