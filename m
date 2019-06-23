Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD14F94B
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFWAFb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 20:05:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40617 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfFWAFb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 20:05:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so5113124pgj.7
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYs3mm0s/xwXUGMs+rQmFBeqA9dl2+moMKBPlLJXjCs=;
        b=P2xRTaZEatViMGnZFrsPjXXIGcXrS98FshMXalHklW4xwdU5PUC1ergvUUukU0xbPW
         3DNVBwZiUJJq393aQA5ThqaecsTM3bV14AVfSNVq8yix9QRrC+yCuux3WoDxgYtsddGb
         4vxr1YxTGxKH9qOsKGQgO/W6WJiK+K+2kyTyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYs3mm0s/xwXUGMs+rQmFBeqA9dl2+moMKBPlLJXjCs=;
        b=RMD4HrFGl/nyryUGaqvqDkTb9dkhNAtskotVsX6LkU+TMHsu13TpUZDVL0h0/D3GYH
         QlrM3voBHqo9+gAaTPshJwRbJjzUrVJrcohUe9GHmXACV1d/w18JrZRFQb8T6G6bO6hd
         Uuj4xC7vb1c6V8QRVijCLSHmi4pebMcbj0ws6UYU7Wxjfp0sDl/s7yuLp3m2jVt4XGK9
         kJwO9Ooef38Yw3V6lllig9U3cacuo5zSiWacA+09n3m1qHkWUB3b2PlmznvIJeZtobkg
         UKjUn7UB5f2EkrdmwV9ZvK3bC10qwjMW1WrSUi1gomEBXT86305tcppJVnPT6Vb/gHUT
         Xc2A==
X-Gm-Message-State: APjAAAXO0AkbLqdiikZPPZon6ohuauhjCxE+Jd38OqqGZA6iktrxO6BW
        V7bmKhcEkKLEZKGWceixDQfcew==
X-Google-Smtp-Source: APXvYqwTzb7UPIdqiwZZr9DWMS1W7r9Ps5z+c4ivq8swrmR+EhrmoTCxJbeChNv1z3xjtZj9uNoaTQ==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr15916386pjw.17.1561248330850;
        Sat, 22 Jun 2019 17:05:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y22sm6912804pfm.70.2019.06.22.17.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:05:30 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:05:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V34 21/29] Lock down /proc/kcore
Message-ID: <201906221705.258B22D1@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-22-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-22-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:50PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Disallow access to /proc/kcore when the kernel is locked down to prevent
> access to cryptographic data. This is limited to lockdown
> confidentiality mode and is still permitted in integrity mode.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  fs/proc/kcore.c              | 5 +++++
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index d29d869abec1..4e95edb1e282 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -31,6 +31,7 @@
>  #include <linux/ioport.h>
>  #include <linux/memory.h>
>  #include <linux/sched/task.h>
> +#include <linux/security.h>
>  #include <asm/sections.h>
>  #include "internal.h"
>  
> @@ -545,6 +546,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  
>  static int open_kcore(struct inode *inode, struct file *filp)
>  {
> +	int ret = security_locked_down(LOCKDOWN_KCORE);
> +
> +	if (ret)
> +		return ret;
>  	if (!capable(CAP_SYS_RAWIO))
>  		return -EPERM;

Another capable() check ordering fix needed. With that:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c649cb91e762..3875f6df2ecc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -95,6 +95,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MODULE_PARAMETERS,
>  	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_INTEGRITY_MAX,
> +	LOCKDOWN_KCORE,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cd86ed9f4d4b..4c9b324dfc55 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
>  	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> +	[LOCKDOWN_KCORE] = "/proc/kcore access",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
