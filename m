Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0938103C
	for <lists+linux-security-module@lfdr.de>; Fri, 14 May 2021 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhENTFH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 14 May 2021 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhENTFG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 May 2021 15:05:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C1C061574
        for <linux-security-module@vger.kernel.org>; Fri, 14 May 2021 12:03:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c13so413376pfv.4
        for <linux-security-module@vger.kernel.org>; Fri, 14 May 2021 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWunAqK+FZyoTV2vjU3HeNB9kZQfJxaL+p7FRXpB3v8=;
        b=JBsuXKPLey+XhgBL4O0cJdva2yDe7zLMx/jjM8bSnpRVxLrwz2JcMgo+bObx71S2GS
         cheyla6heHxUN0y0Nfx+LRGrcoXwQ9l5JKZKt37SyBvhyfrW02F62BJPBxUWghGz/REM
         psf5IE5vtuOIlUlEI6YoCQGUvYecvNq4icPpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWunAqK+FZyoTV2vjU3HeNB9kZQfJxaL+p7FRXpB3v8=;
        b=DHlPNFvTJNiZZr9WVGOe4L9BuAVZsC9tFRo/iAe+8Ai7ek7pUuzKjmiCTuKxT17jVB
         igLOenAefLQxZx/ZsvIUx7GQuxhg6JRzugIV4iI7Z8YQZcBlvzp1muKRZ2HyhRLaW7aq
         iaaikknoQowHRic/DjTB/tiFyFFwK6RivvLG7KyZbKJGXzcLxhGODW9x6Ko8lknzlW7m
         lDQiGhzhsk9lkYIsO8JmNEW99T+CLL8JWJO/AU8MDG1enr82l1BbnZl/t66k1bJTghxU
         OmnC2pbt0mmd6UQCS1JCmSE4TtrhTsaZb6mOPtX0My7VMsHg8Dihy5Sa3/l4hOgLhfYs
         Vreg==
X-Gm-Message-State: AOAM530fW/r/LTX0w9XedHLuZEs5ZSbZ3chfBTUNaUpa3lTN2pixUBJ3
        0Z9uVii8KrOgW4mwnykezTtB7A==
X-Google-Smtp-Source: ABdhPJy/2ssb8xICyRpzUdXDJOa7C5xielVPk0SjlrBIAD2a+w+docVTMCOrVjaCXs6HLij/mumypA==
X-Received: by 2002:a65:6549:: with SMTP id a9mr24482406pgw.213.1621019032283;
        Fri, 14 May 2021 12:03:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c201sm4624403pfc.38.2021.05.14.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:03:51 -0700 (PDT)
Date:   Fri, 14 May 2021 12:03:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v26 07/25] LSM: Use lsmblob in security_secctx_to_secid
Message-ID: <202105141203.60B0435@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-8-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 01:07:49PM -0700, Casey Schaufler wrote:
> Change the security_secctx_to_secid interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its callers to do the same.
> 
> The security module hook is unchanged, still passing back a secid.
> The infrastructure passes the correct entry from the lsmblob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

This looks like sane refactoring into the new blob type.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
