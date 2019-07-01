Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D857938151
	for <lists+linux-security-module@lfdr.de>; Fri,  7 Jun 2019 00:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfFFWxp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Jun 2019 18:53:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44410 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFWxp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jun 2019 18:53:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so14897pll.11
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2019 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9tPuqXSnLLqDLK9V1P0M5vhpLVYOBP8IPwaJBuXaxE=;
        b=S1f8aQJ6Rh0k4EEU00w4NdE3m5Uhc2QKSDfNJjfAJwS6NdpH4PuH+zQ9CsJBCE2ZBV
         mTFCVBykaMIO93rk4Jc+hFnoQZU5qYoy7oQf11iMgj94DLgZAcsd1lWVCDzlg3xb8d0W
         jbmdE+hTRSfFVNrKMtp4vUG2jbYEqobgH25Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9tPuqXSnLLqDLK9V1P0M5vhpLVYOBP8IPwaJBuXaxE=;
        b=ffY9D2dwFWKBASjQyQRrS5PzWhdRC6OHEUPe6g0UZujazgWNuQlbdz4Y7iQIHo/aRs
         jQjmZsrcTGOdOCFK1e3f1EQXykPVHqhlM8uDxRanPgmHnMaiUPHYtbwAqyRrLrVF7Z5q
         iOjMv6u8dUCQtHZzlGqRl16zH5hSFd04ecxIBeRGrakbLYsflXkd9rERgPwoctFSNTsC
         Tin1rhXLBtfRqiMKD0aefeqlPPhcqyNnFO2O3xULPZCdxHJohFdbZuULYjDFL7ICHidb
         K0kHHVX7lQ8QGJAd1Astpc0QlaX5q13v8WuW3SUfek2SZ+IXc/1Y2Dzz5xFTif2IogNp
         9k/Q==
X-Gm-Message-State: APjAAAVhmgjde2loYhJOO/BVNu/eSiD+2/z8IVmUyEF6V/WyB52umXUV
        cJXuXpkg9Caz1t9kfWpp5QTi9g==
X-Google-Smtp-Source: APXvYqwl49yrDs6w/vlkudCMHeZXfti4PypjiqEguhgK96oOW05IDR+W3joYb29gLc4fMFwb9bKg2Q==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr52416459plc.2.1559861624700;
        Thu, 06 Jun 2019 15:53:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm202339pff.31.2019.06.06.15.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 15:53:43 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:53:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Message-ID: <201906061553.A3BF62257@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
 <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
 <201906061138.BFE4CFEE@keescook>
 <dbafd99d-aab7-c497-fbe9-fe467b0c237a@schaufler-ca.com>
 <201906061351.B12D10D5D@keescook>
 <5010ae20-ce00-be1e-0c2b-7568282b6b39@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5010ae20-ce00-be1e-0c2b-7568282b6b39@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 06, 2019 at 02:06:44PM -0700, Casey Schaufler wrote:
> I'd rather describe what's in it than how it's used.

Yeah, good point. :)

-- 
Kees Cook
