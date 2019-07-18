Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F176D637
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Jul 2019 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGRVG0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Jul 2019 17:06:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38592 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfGRVG0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 17:06:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so4606589pgu.5
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WbqvTZRMPilPykZWVhvoxtFXrd6vEGyWRNvRQY3FrVY=;
        b=YuBqieemLplECQ2tH/pG6L6tc/rTnFTMpeDaWShqOatuUcH5vJ2dep6eL85zPo12Lw
         W7LL9PkDztBYUbpE0iQ/gP/4zCjPSZdlLmH4agGAULNqgKcm2KPBa/uM8sRzf99+Liua
         8sO38Nj37oxRNdCe2374hm8nBKB7uopUcuQvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbqvTZRMPilPykZWVhvoxtFXrd6vEGyWRNvRQY3FrVY=;
        b=fs8hbGKv9QqKGhZLvO8IVQfAkiNopU7IbeuSvlXnRE/ChB5UfkqRUI1y+tSA3qwZIG
         3RNXZhWKEXR/PoZ4eUwO1ML1B1DjcJIvwZtGvAgUjzTJNvS8c3wwgY0NxplrdpyLRgm9
         x92UXYBpiAK7NQPWlBh6kbvygoeBj1inUpMd9ATnY1vk15m+LGY9bV4jvSO1Z5JLsxg6
         RtiRxK9+fioxX3KaOzYcQR/NVAeY2jRXlM0l2mEteXcuzp7sB4WQbQ6YVkbNJMfTpXw5
         j/Nol7V5MeMPTyXyF5Wx9ksmSKan0NhwzoO/HgBM4hQ0owCaq7EcxWga75hO/PBikzwV
         fgcg==
X-Gm-Message-State: APjAAAXMRFfIlWaU5r16zkgniIuVxs6eWk0t7R0BI8ruKngTdhZfCwAq
        iz4gZmz0Yb6Jrim4zc5RrMRKeQ==
X-Google-Smtp-Source: APXvYqyq9AjPD5SPt+olfQCatSnGeaWAoPrrNc6BbxQUjdvCPcK5Oi5IYuPhiLIocpqczA0WTnqOjA==
X-Received: by 2002:a17:90a:2641:: with SMTP id l59mr50383336pje.55.1563483985639;
        Thu, 18 Jul 2019 14:06:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 23sm31483030pfn.176.2019.07.18.14.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 14:06:24 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:06:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH V36 20/29] x86/mmiotrace: Lock down the testmmiotrace
 module
Message-ID: <201907181406.0E364D490@keescook>
References: <20190718194415.108476-1-matthewgarrett@google.com>
 <20190718194415.108476-21-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718194415.108476-21-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 18, 2019 at 12:44:06PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> The testmmiotrace module shouldn't be permitted when the kernel is locked
> down as it can be used to arbitrarily read and write MMIO space. This is
> a runtime check rather than buildtime in order to allow configurations
> where the same kernel may be run in both locked down or permissive modes
> depending on local policy.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Howells <dhowells@redhat.com

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: "H. Peter Anvin" <hpa@zytor.com>
> cc: x86@kernel.org
> ---
>  arch/x86/mm/testmmiotrace.c  | 5 +++++
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
> index 0881e1ff1e58..a8bd952e136d 100644
> --- a/arch/x86/mm/testmmiotrace.c
> +++ b/arch/x86/mm/testmmiotrace.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/mmiotrace.h>
> +#include <linux/security.h>
>  
>  static unsigned long mmio_address;
>  module_param_hw(mmio_address, ulong, iomem, 0);
> @@ -115,6 +116,10 @@ static void do_test_bulk_ioremapping(void)
>  static int __init init(void)
>  {
>  	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
> +	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
> +
> +	if (ret)
> +		return ret;
>  
>  	if (mmio_address == 0) {
>  		pr_err("you have to use the module argument mmio_address.\n");
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 43fa3486522b..3f7b6a4cd65a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -114,6 +114,7 @@ enum lockdown_reason {
>  	LOCKDOWN_PCMCIA_CIS,
>  	LOCKDOWN_TIOCSSERIAL,
>  	LOCKDOWN_MODULE_PARAMETERS,
> +	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 5177938cfa0d..37b7d7e50474 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>  	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>  	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
> +	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.510.g264f2c817a-goog
> 

-- 
Kees Cook
