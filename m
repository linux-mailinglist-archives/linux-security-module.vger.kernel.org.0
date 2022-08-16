Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0759650B
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Aug 2022 23:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiHPV7y (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Aug 2022 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiHPV7x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 17:59:53 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E038E982
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 14:59:52 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10ec41637b3so13186709fac.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sdCVoX1d2nR5s+ye1eeCQD5gWGPAwlYI2xaf/18em+k=;
        b=hO6UvexnEI7QgAflmltkaXxQku6tDO8f7iYmWs5Dn6I601Qw3q82+bprknapQpcazH
         BnnRq+eMgWmmIDMEQChFFjpSm8eN5FBPJdISLgmNjlscw4HizxtCfxs3DShXaVtCbp0r
         gT24JV/Aio+W/hi7BWiA9DRE+5ZEByvOIjj9CBiUDwae+1FkGuBTxGsV9tqGEeFM4nRe
         s3s9w5ECI85qBQmsnDQKAnkilG6LoDZt+PsDIaTi5IWmSmcchrYQKJOgxiJUBJEhYcVP
         r5I94OeiX8sfElXlCPAx3kY+FV1rTgzpTB2k2RxpeMznKiQ0t6EAbkgmT0gdEDhNLdtD
         q1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sdCVoX1d2nR5s+ye1eeCQD5gWGPAwlYI2xaf/18em+k=;
        b=W0Ck+P5S0stLBbmP8yp2XY0bD/GnZZ+ImmREzpP1abmY2seuzDRiwvGuwejEr5ge0Z
         aa5UvkjD57y2ArHWIYVRKT72WXEJOGZi8hoGtsb1X1j1KMVtSUItDwD+DAgGR+DfVfN2
         JauSPZYwQHcXE3IYYqpH60sxf8RZ2AjvRrks4gVwwBxqhHWsXH26BHcMdZ7BXOazzjWa
         OJRsPli403t8tQKqgPRYYH5MgwkQwFJAgEuCl5UlQSlwqFnqd7kpT4tunBkY936+eXEQ
         kb4yZ78T28VtddJTzluKbgVjKK5hVg9UEgEF0rVIGCfQznHe//VMnA/yzqNkaDfR2NKi
         zjag==
X-Gm-Message-State: ACgBeo0PoplQJxGMAtjwyOhga/gnRqwwx4i39Cl0j0DWe5+Eueg+eScu
        mF9gtpWUrXgq5eDn1HmVohMDaen7b+aTjwk20UcKjkPmNjE8
X-Google-Smtp-Source: AA6agR5VUmSWGEOtIJf0tK03lmL0MPi7VLCU9Pr8Zq6gAZ1YxXrlalyEf6N1T0Mj/LkfV2Qvf+yubk0HbU6bJceR6YQ=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr278597oao.41.1660687191979; Tue, 16 Aug
 2022 14:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
In-Reply-To: <20220725124123.12975-1-flaniel@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Aug 2022 17:59:41 -0400
Message-ID: <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
<flaniel@linux.microsoft.com> wrote:
> Hi.
>
> First, I hope you are fine and the same for your relatives.

Hi Francis :)

> A solution to this problem could be to add a way for the userspace to ask the
> kernel about the capabilities it offers.
> So, in this series, I added a new file to securityfs:
> /sys/kernel/security/capabilities.
> The goal of this file is to be used by "container world" software to know kernel
> capabilities at run time instead of compile time.

...

> The kernel already exposes the last capability number under:
> /proc/sys/kernel/cap_last_cap

I'm not clear on why this patchset is needed, why can't the
application simply read from "cap_last_cap" to determine what
capabilities the kernel supports?

-- 
paul-moore.com
