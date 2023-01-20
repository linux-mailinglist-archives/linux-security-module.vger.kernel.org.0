Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4807675E30
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Jan 2023 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjATTkb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Jan 2023 14:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATTkb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Jan 2023 14:40:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156D59B78
        for <linux-security-module@vger.kernel.org>; Fri, 20 Jan 2023 11:40:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 78so4924140pgb.8
        for <linux-security-module@vger.kernel.org>; Fri, 20 Jan 2023 11:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9rk3wSJYDen1bQJK/Grwb+UARFZene4MCi4bul4wfg=;
        b=f+VkXPJiJfVg0gQc9Cz9ulWT1cagCuiuGo1S+jk/Xfohis/QpnrhUdaGf6+c1MyxKl
         mCYITt4BnIvA3ZdjWxdcNcoE2EPVB1kuDFpJ3BuXqDfwuOL2B6yNYSpZCcnMNEPMxye1
         BIldwuX6jV9JrJ0sYli//u69QbwD97ATMeRyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9rk3wSJYDen1bQJK/Grwb+UARFZene4MCi4bul4wfg=;
        b=tI5AdtIhcLsjNY35molqw5Rc9EnzshkWIir1LhzJueNngxLFK9xP0jdJObdfYP/K6w
         3IM4OSxFNB8T7kMGbrMqM5Dzl/lD+P+P4BeOBHthXLgEkGLZgWmiUGHRuHj/DJsr6Dvc
         Pvw74upa/OqID1do0pQBJNhMLRxVsCsEFgmQ/0JrKrxJ9HbhJeSNP/Yy15u0p9SkRJRB
         P8f3gFB82XQzCd4GA7t0qJliCqYI5L6vU/PifasAQb8YzbDTimpfN68EsIL8LG9/mTV6
         3M9Gb0DkG+qrz5V5ByYHDoc/pobdC5YaYDcd91oAyu7GFJFUBWMVrsJJBJPE6gFcujuZ
         BoZw==
X-Gm-Message-State: AFqh2kpC7sH6/KCOakSGRBPNxyIo2szlAJ1SOTeTRM8uf5km5Dy9XhS5
        5fVGIIzYIf1tf7sga6ktdx3hfg==
X-Google-Smtp-Source: AMrXdXtda4qIv4lo54po2/BkemEYycrwcg+xo4uHR7ZvkSKzQ86OezBkepBV+lz/d44ZLesVsPjpyw==
X-Received: by 2002:a62:38d8:0:b0:582:ca4d:f6a7 with SMTP id f207-20020a6238d8000000b00582ca4df6a7mr40638208pfa.4.1674243629982;
        Fri, 20 Jan 2023 11:40:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b0055f209690c0sm25528964pfb.50.2023.01.20.11.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:40:29 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:40:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org
Subject: Re: [PATCH bpf-next 2/4] security: Generate a header with the count
 of enabled LSMs
Message-ID: <202301201137.93A66D1C76@keescook>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <20230119231033.1307221-3-kpsingh@kernel.org>
 <5e99e2d6-30a8-ea94-d911-de272a2a0a69@schaufler-ca.com>
 <CACYkzJ5LwLD_yo=b5MMvpDUBGJ_puzr2TLYEK-DR3NRDRwgSLw@mail.gmail.com>
 <9bf988ba-3f16-a402-2110-107cebfa7025@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf988ba-3f16-a402-2110-107cebfa7025@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 20, 2023 at 10:35:02AM -0800, Kui-Feng Lee wrote:
> The following idea should work with the use case here.
> 
> #define COUNT_8(x, y...) 8
> #define COUNT_7(x, y...) 7
> #define COUNT_6(x, y...) 6
> #define COUNT_5(x, y...) 5
> #define COUNT_4(x, y...) 4
> #define COUNT_3(x, y...) 3
> #define COUNT_2(x, y...) 2
> #define COUNT_1(x, y...) 1
> #define COUNT_0(x, y...) 0
> #define COUNT1_8(x, y...) COUNT ## x ## _9(y)
> #define COUNT1_7(x, y...) COUNT ## x ## _8(y)
> #define COUNT1_6(x, y...) COUNT ## x ## _7(y)
> #define COUNT1_5(x, y...) COUNT ## x ## _6(y)
> #define COUNT1_4(x, y...) COUNT ## x ## _5(y)
> #define COUNT1_3(x, y...) COUNT ## x ## _4(y)
> #define COUNT1_2(x, y...) COUNT ## x ## _3(y)
> #define COUNT1_1(x, y...) COUNT ## x ## _2(y)
> #define COUNT1_0(x, y...) COUNT ## x ## _1(y)
> #define COUNT(x, y...) COUNT ## x ## _0(y)
> 
> #define COUNT_EXPAND(x...) COUNT(x)
> 
> 
> #if IS_ENABLED(CONFIG_SECURITY_SELINUX)
> #define SELINUX_ENABLE 1,
> #else
> #define SELINUX_ENABLE
> #endif
> #if IS_ENABLED(CONFIG_SECURITY_XXXX)
> #define XXX_ENABLE 1,
> #else
> #define XXX_ENABLE
> #endif
> ....
> 
> #define MAX_LSM_COUNT COUNT_EXPAND(SELINUX_ENABLE XXX_ENABLE ......)

Oh, I love it! :) Yup, that should do it nicely.

-- 
Kees Cook
