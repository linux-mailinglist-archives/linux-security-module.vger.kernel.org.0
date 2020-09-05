Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2928825E7DF
	for <lists+linux-security-module@lfdr.de>; Sat,  5 Sep 2020 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgIENZ1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 5 Sep 2020 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgIENZ0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Sep 2020 09:25:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590C8C061245
        for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2020 06:25:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so12132469ejb.4
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2020 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ie9e005vGpeYxWm0WXYp4ZFqRLXamHsEroBYvkvSe6o=;
        b=zuIDeADXkz8tJwtl0SbURyUkAA3XlVMuaNLSYiCxAAekyiiFXzExEiylis3mEXv6k5
         KgGSiONjkQlHp0C6s6LXAGTvDc/BX9dW9Nz9MMIoiLqpnwXw/5AXeSAiLinq7hp4DzYo
         s4dc6EGykUo1seb4WZCaU4gaKsTqXBOsnbEqGbskRUgLPrXwJtThKs51fO9ae/Lk3A5h
         PCImRLUjdxlJhIbNv4HWa8zrAUdDtiorojeVrMttvZS5g6nPfS4muEiCzQLvYFgQoGj9
         vA+cmLHGkwK5lf3eiUEGR69eXTiVJWOfS5PKkx0flxSIZ6FYhupU6IdHFojFxLBleHa1
         ygOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ie9e005vGpeYxWm0WXYp4ZFqRLXamHsEroBYvkvSe6o=;
        b=aRQEHvoyBnqFGOd0Utf3OIyeegYdbjMi03sWxNH3ayTWaTdEq+ACcfuVg3Zit3wDLW
         IuwMB5UXAgccht7V9ZM8FRBe3rFfFNWrVUtkrZxgCBpkxvdmiSmiO6GC+sSBybILlnq4
         y6Uim7U0DMHbSgmPlujhOgwi1O0u8oKl7CQOS+RIDTsroVpTwUDd39fubUi5VLuvV2Fb
         EBTAQaAAAA8LJvU5fQLQsxfA7dZM+yADhTB4qnYkKPlf8dPSyckRYogukgb1KIyD5WrC
         2DGxAXMOIWBac/269O/U2L7D1DuiHmQU3jt5cpWqecuTV6li6dr4K+xin0UEmJrTZqit
         CgFA==
X-Gm-Message-State: AOAM530rT0KbUgnjoHN6tExwtyVo4J1wBshb7/cpxlpIrE92elOC67MZ
        NbdOodAdXmIzJo8UtJaJzyEttBEp0x0/vVx/nQet
X-Google-Smtp-Source: ABdhPJwCaOgYK/F9wk68UkyQKW1/SozAMRuWXaWQi2G9kZivtfrjsCtXnEpBDCt41ghL1Cqjg24uuP1iTYI81sdPCzQ=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr12119953ejm.488.1599312324669;
 Sat, 05 Sep 2020 06:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
In-Reply-To: <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 09:25:13 -0400
Message-ID: <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/4/2020 2:53 PM, Paul Moore wrote:
> > On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/4/2020 1:08 PM, Paul Moore wrote:

...

> > I understand the concerns you mention, they are all valid as far as
> > I'm concerned, but I think we are going to get burned by this code as
> > it currently stands.
>
> Yes, I can see that. We're getting burned by the non-extensibility
> of secids. It will take someone smarter than me to figure out how to
> fit N secids into 32bits without danger of either failure or memory
> allocation.

Sooo what are the next steps here?  It sounds like there is some
agreement that the currently proposed unix_skb_params approach is a
problem, but it also sounds like you just want to merge it anyway?

I was sorta hoping for something a bit better.

-- 
paul moore
www.paul-moore.com
