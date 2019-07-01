Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAB4F938
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 01:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVX7q (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 19:59:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41028 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFVX7q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:59:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so4778717pls.8
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bgrPjW7Kb7wUUX+DYrIOPFY5PfDgfePLDwa4gYfP52s=;
        b=hdw3d9Tkc9CTEuLiBL+v1GlT08Ye3N3vWBXfp9XuasCNI4S9OWAU6zx9TF7hFJDjU0
         QIg3GIqC6FN3TzNUEOMrDsWUObccrdJCTI4md9CDw6UjxoB65gOs/KVaBYVAzTfaoGiL
         Rq5S5gjb5GDHuNNLba1IbMH7ohCl2ajLwIsy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bgrPjW7Kb7wUUX+DYrIOPFY5PfDgfePLDwa4gYfP52s=;
        b=m1+nV00JMK6Oy1yJ/yWFj6qz56PyjjZE2pshMz4/bfh/h715EO/D9lr7cUwBZqPNyu
         b0FtIX8q714OkojewtYLVTLqaZQVB9Hylgs1/gufaNIWx4Y3Qhbs2vAbzYA3akRwfRJw
         FWgWiMGOTM8csPZLVNuzO8Z2WfJoSzCHsNDD+9Fi1gSzfkWePLNQCkGKKfYznmM6m4Ty
         LHFLRuD+eULMQHpQTDfHjUc+Lekd90NG57PjO+0PSv2nQz6fKLNu3Qbhm5SAEYsLq13p
         kdv75pIRGsUadiVSN/C2ReUHanh45sc/RvoWxn6gkmfayHIDFHtDBRtqi8XcsxrpcpEx
         oHaA==
X-Gm-Message-State: APjAAAUmcJYB+5MHhXvcya2IWSnXAu37MFRscmBDBmV0zlMfQBf0AfVe
        aRfK1NNWlHXxFMmoRlc5krIFxw==
X-Google-Smtp-Source: APXvYqxLFdr+xtXxViVFj1IN/jBNDDj9LPM0uAcMBAdURV0Qzqbd67foxSaQjGo3StJksc55FRXPcw==
X-Received: by 2002:a17:902:e65:: with SMTP id 92mr133083051plw.13.1561247985604;
        Sat, 22 Jun 2019 16:59:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm6218653pjr.13.2019.06.22.16.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:59:44 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:59:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V34 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
Message-ID: <201906221659.A04260B5@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-16-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-16-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:44PM -0700, Matthew Garrett wrote:
> From: Josh Boyer <jwboyer@redhat.com>
> 
> This option allows userspace to pass the RSDP address to the kernel, which
> makes it possible for a user to modify the workings of hardware .  Reject
> the option when the kernel is locked down.
> 
> Signed-off-by: Josh Boyer <jwboyer@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: Dave Young <dyoung@redhat.com>
> cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/osl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f29e427d0d1d..60cda8a0f36b 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -40,6 +40,7 @@
>  #include <linux/list.h>
>  #include <linux/jiffies.h>
>  #include <linux/semaphore.h>
> +#include <linux/security.h>
>  
>  #include <asm/io.h>
>  #include <linux/uaccess.h>
> @@ -194,7 +195,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>  	acpi_physical_address pa;
>  
>  #ifdef CONFIG_KEXEC
> -	if (acpi_rsdp)
> +	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES))
>  		return acpi_rsdp;
>  #endif
>  	pa = acpi_arch_get_root_pointer();
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
