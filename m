Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD214F90F
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 01:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFVXxV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 19:53:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35656 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFVXxV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:53:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so5434669pfd.2
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pj2xea0nrESVhzCctZSm0ltVMYO4iJ1nFUvuPkZZ1cI=;
        b=cwfKaBCeOLaOWqp6IJxkI+95fC0wmQC5wx7do5nUz2XIOq8cRNwaNOusbZ9iGsmBG2
         Mb1+BntCt1GJVKZHrfSbcQYnT4ri/gLOelLJuOVNd/eJVXuHDdA72ALZapbzQH8U8k4Y
         SUCysr1x6XvgpthBH6ndYduHLchN7YUxCoAhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pj2xea0nrESVhzCctZSm0ltVMYO4iJ1nFUvuPkZZ1cI=;
        b=EdotTsZsdaaCvPZIanCtBtK/+M0DpyF4Pvqj0gQUgQQSV8/aeqNQ8fMGOD6Ypansd9
         I1Cw3LyeyS386OXGHlDeJGYOaGGZoy9nzAnbQyia57S7hVpn5H5xUfcAl8JjEImu5P9O
         2TzqfSKIIRAOmdV05SBeOULK0LMOXoA5t4MR6jlWMRWSlMAecODkzKO1K0dI/qEJokDQ
         H6a9IrtvGpJPVrKaneWjLEoDuGZOCVlEucbOaRaq9H8O/1Q3DC1dzPDSxvfbaXxOY8lD
         cMd+RIWy0s4mVnwD/JB0zWoK0odQXf3GLvqnIbkR9MPMic6SqaCqzl4JnjGVEZmyiOmk
         v0fQ==
X-Gm-Message-State: APjAAAX8aYbuxlWA6MJgF2CnONPdDX3zGOWJDVmUfGxkdboOn8tr5pfi
        sY0d+c+HuBKkP0/qHWLR6NtDSg==
X-Google-Smtp-Source: APXvYqy1dvhqp+N85ZUG4C15vsX9JYjrWSjT6BJeOPTBm/LfL799mnOFM3VfqlKAk44zO2lXgY2cOA==
X-Received: by 2002:a63:4e07:: with SMTP id c7mr25738042pgb.350.1561247601114;
        Sat, 22 Jun 2019 16:53:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm7377415pfo.49.2019.06.22.16.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:53:20 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:53:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 07/29] Copy secure_boot flag in boot params across
 kexec reboot
Message-ID: <201906221653.DDCB3C898@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-8-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-8-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:36PM -0700, Matthew Garrett wrote:
> From: Dave Young <dyoung@redhat.com>
> 
> Kexec reboot in case secure boot being enabled does not keep the secure
> boot mode in new kernel, so later one can load unsigned kernel via legacy
> kexec_load.  In this state, the system is missing the protections provided
> by secure boot.
> 
> Adding a patch to fix this by retain the secure_boot flag in original
> kernel.
> 
> secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
> stub.  Fixing this issue by copying secure_boot flag across kexec reboot.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: kexec@lists.infradead.org
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 22f60dd26460..4243359ac509 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -182,6 +182,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	if (efi_enabled(EFI_OLD_MEMMAP))
>  		return 0;
>  
> +	params->secure_boot = boot_params.secure_boot;
>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
>  	ei->efi_systab = current_ei->efi_systab;
>  	ei->efi_systab_hi = current_ei->efi_systab_hi;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
