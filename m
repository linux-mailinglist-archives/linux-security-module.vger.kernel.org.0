Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716C54F932
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 01:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFVX7U (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 19:59:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40772 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFVX7U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:59:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so5425331pfp.7
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Am+xsKrCSgqUDTnEarlPfGUv+iV9mXgrux7mgCCSlTE=;
        b=F8I13xTrwM4qgJZ1AlQrosD+/dfL+k4I2BJY5EwJJA+V0o/F4JxRpPGagXK9/2IVqc
         tVdO/fP0tNnP1OTDV6AAHYpD3L4hjjSex1yKEnFJU9WGvBCye6SuBL31SaMoMmV8zOR5
         K/fDvVu8JN62Z0d68189BG2IJWum90YlEuK10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Am+xsKrCSgqUDTnEarlPfGUv+iV9mXgrux7mgCCSlTE=;
        b=DgUSh8Zl0CeH7JIBhh79cjJhDB4Wnso1LIYj+1GXNLzSH5visvlSFSNKFE3NMvrGfU
         NVktrNM9xPRUgQCYoz7f1ZlVkwj4F+4/3KwC0PKui95Q9uk7rJMQE1qUcD5XW8JMiQP3
         uSOhjIxOd4Ebg/UdPngJ7I0adONJblQwrlJwCdlM93oJM3VeHS/sCTZTJPl0Jz+59QuV
         mm6vqfC84m+geunI9c28LLSnjsinrFyi09H6yoqrjhXCBitzRamsUFarqIxLGmSr2Vls
         pfadkHnpMR5JJtreBBgBhuJZhec42GmqxvjqFZiqtdghlSrlye+WXKl/6+lr8Sc03+CQ
         xXRA==
X-Gm-Message-State: APjAAAWaNjpKPi8A2QTmPzFP0jJv/ZsM+GWRNmQTfMWZEBjMXzyChaFN
        74GsSBUHwrswFvk7lF0QG4VtiA==
X-Google-Smtp-Source: APXvYqzRty+ShHpjNBV2fMnyvurZIkHD4W+vGwEmlsY4ebQoVc0BGnR0v4wv1ckSQ6Mscefn44QkYQ==
X-Received: by 2002:a63:c10d:: with SMTP id w13mr25197902pgf.28.1561247960107;
        Sat, 22 Jun 2019 16:59:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm7343653pfn.3.2019.06.22.16.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:59:19 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:59:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V34 14/29] ACPI: Limit access to custom_method when the
 kernel is locked down
Message-ID: <201906221659.B618D83@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-15-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-15-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:43PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> custom_method effectively allows arbitrary access to system memory, making
> it possible for an attacker to circumvent restrictions on module loading.
> Disable it if the kernel is locked down.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/custom_method.c | 6 ++++++
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index aa972dc5cb7e..6e56f9f43492 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -8,6 +8,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/debugfs.h>
>  #include <linux/acpi.h>
> +#include <linux/security.h>
>  
>  #include "internal.h"
>  
> @@ -28,6 +29,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>  
>  	struct acpi_table_header table;
>  	acpi_status status;
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
> +	if (ret)
> +		return ret;
>  
>  	if (!(*ppos)) {
>  		/* parse the table header to get the table length */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 30bc6f058926..cc2b5ee4cadd 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -89,6 +89,7 @@ enum lockdown_reason {
>  	LOCKDOWN_PCI_ACCESS,
>  	LOCKDOWN_IOPORT,
>  	LOCKDOWN_MSR,
> +	LOCKDOWN_ACPI_TABLES,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 297a065e6261..1725224f0024 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
>  	[LOCKDOWN_IOPORT] = "raw io port access",
>  	[LOCKDOWN_MSR] = "raw MSR access",
> +	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
