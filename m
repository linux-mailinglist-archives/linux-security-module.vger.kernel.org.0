Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7393561196E
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Oct 2022 19:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ1Rkl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 28 Oct 2022 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJ1Rkk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 13:40:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138A17FD42
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 10:40:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g62so5343272pfb.10
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pD8xAs6hz8K/GwlkkWEBIlgMqA6rS7UqF9zh8XCJrDM=;
        b=lMu/aHyftjQPfPXg/l61M6f9UM3LPnFbqCvJX2fO2zsrz46+GcTb8F3VppNulvG4p7
         MEEXMMvAc0TpHTAjwW4m2L7QG5Q0xV0573g13vEJ/mHwGKwBdkSTqBZs9LNU59gboJKH
         UzRU8jX2UQvC1cLNwRFJd80uMuregblbF1mok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD8xAs6hz8K/GwlkkWEBIlgMqA6rS7UqF9zh8XCJrDM=;
        b=Ejc8u0xMgYtijGUObSk0Ayb3JL1oV0PsG0oJ+KLm1dM0pyxMCFHQlrZc83TSiTmhz0
         f2g0RYjg0pYUKmuf1uacxov0OkRkAXQm/10YwyI9rYemb5lbIacnmqvXxRB3TA3q4jXO
         9yMAqlR6wTtX5Tk+i9k1qv/8CNCeSsgZKp2vdBd1FWo78FYL5lXDMiIMmmrtT6Xx/Odc
         DEM8S3pI4to6N/GZJ0y8tgotL/ypSCBKID6rRo10Gy9/Wmyhzks9e5JCeXzUCYBfWJUL
         dbtwzZ27irgp2ZnrlSLS130+xJFGy6a511UDV9KmmgVgFAelCmT8d/5aaZ0CXkAkRHF4
         ebcw==
X-Gm-Message-State: ACrzQf1pi5GLqqanq0VGNaPcQbw8N0xcK7Iqh4OjRQrWvpM0Ds5MpYNg
        /kq7J6+u3LFqMHMxR7gis8btaA==
X-Google-Smtp-Source: AMsMyM6DTNw3s9S/F5sJs7fsfz3/GYHCtEIHiJDX19noke49fsc96sZ1X8ywUtxMWK3oLrmdy33pug==
X-Received: by 2002:a62:b501:0:b0:557:d887:20ee with SMTP id y1-20020a62b501000000b00557d88720eemr394469pfe.8.1666978838423;
        Fri, 28 Oct 2022 10:40:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00186e2123506sm3262526plc.300.2022.10.28.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:40:37 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:40:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: LSM stacking in next for 6.1?
Message-ID: <202210280944.AF75E37DC@keescook>
References: <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <CAHC9VhQy91eezWMQ=MoLe3fQSu_Rc+ZUWW2Mm3+78Mr7vS_Z0A@mail.gmail.com>
 <a0567b10-fa83-50f4-7bf6-937e0c677e60@I-love.SAKURA.ne.jp>
 <CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com>
 <56add81d-0ea7-9d3e-0e30-e0b02e62a8d0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56add81d-0ea7-9d3e-0e30-e0b02e62a8d0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 28, 2022 at 10:58:30PM +0900, Tetsuo Handa wrote:
> Do you remember that 10 modules were proposed 
> 
>     SimpleFlow ( 2016/04/21 https://lwn.net/Articles/684825/ )
>     HardChroot ( 2016/07/29 https://lwn.net/Articles/695984/ )
>     Checmate ( 2016/08/04 https://lwn.net/Articles/696344/ )
>     LandLock ( 2016/08/25 https://lwn.net/Articles/698226/ )
>     PTAGS ( 2016/09/29 https://lwn.net/Articles/702639/ )
>     CaitSith ( 2016/10/21 https://lwn.net/Articles/704262/ )
>     SafeName ( 2016/05/03 https://lwn.net/Articles/686021/ )
>     WhiteEgret ( 2017/05/30 https://lwn.net/Articles/724192/ )
>     shebang ( 2017/06/09 https://lwn.net/Articles/725285/ )
>     S.A.R.A. ( 2017/06/13 https://lwn.net/Articles/725230/ )

There was also:

      LoadPin ( 2016/04/20 https://lore.kernel.org/lkml/1461192388-13900-1-git-send-email-keescook@chromium.org/ )
      SafeSetID ( 2018/10/31 https://lore.kernel.org/linux-security-module/20181031152846.234791-1-mortonm@chromium.org/ )
      BPF ( 2019/09/10 https://lore.kernel.org/linux-security-module/20190910115527.5235-1-kpsingh@chromium.org/ )

So, 13 LSM proposed, 4 landed: roughly 30%, which is on par[1] with regular
kernel development.

> I consider /sbin/insmod-able LSM modules as a compromise/remedy for LSM modules
> which could not get merged upstream or supported by distributors, for patching and
> rebuilding the whole kernel in order to use not-yet-upstreamed and/or not-builtin
> LSMs is already a lot of barrier for users. But requiring a permanent integer in
> order to use a LSM module is a denial of even patching and rebuilding the whole
> kernel. That's why I hate this change.

But the upstream kernel _does not support APIs for out-of-tree code_. To
that point, security_add_hooks() is _not exported_, so it is already not
possible to create a modular LSM without patching the kernel source.

> I can't understand why assigning a permanent integer identifier is mandatory.

Plenty of other APIs use numeric identifiers: syscalls, prctl, etc. This
doesn't block them from being upstreamed.

-Kees

[1] https://ieeexplore.ieee.org/abstract/document/6624016

-- 
Kees Cook
