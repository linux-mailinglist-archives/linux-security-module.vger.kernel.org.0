Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C238A4F915
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 01:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfFVXyG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 19:54:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45512 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFVXyG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:54:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so5412831pfq.12
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E0DLK9o2G9JjdDYpbAB7EERdssjBdQ3kUgIhR7SzB14=;
        b=PoZU+SAUmLJWgB2EheN3a27PmwJ+tthDLgoDrTEExRu180ZGcMB/LViOHJdFTBNylB
         X17zTQ2wQBMKx/B+rw9MQcR/r16JrEmksfW1pNlazb7/sre8xDr3wgaLmeh0jYQ6dzZv
         obJqYfCWFPrsp+QHpFF1CobqFwFBMyvi7lTwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E0DLK9o2G9JjdDYpbAB7EERdssjBdQ3kUgIhR7SzB14=;
        b=COCTBXmAbwyDNEfSVgE03mQXKkUkgx4baCaF7iVrx2o97LZCTu3P+ad2JMQlcqD4Sr
         Sq+aRAM+cIGTxs2M/0Xv/Mn7hPRfLd1A0coplr7OGXDxWtcVxLx8BjuriNh9kOrB8eWf
         q0vlumFxmxmiGj7zx3/FpcC3cYGz2aoWNNt5DBzVbbKMEhNeWAc3N28apo5wkQ2J2ros
         nqyYFMw6cbTTEMetsN5QIAcdUZ2BOQuOTzuKckcKMVcZgEIVXUcp6FJFTcuLvKGhBqIv
         2ra61rNkZnV9DHxLELhfEDZujDW3puREdkI+iwvNmAOQyASC0xfROTZQnn6j6kCOzEzr
         f5iQ==
X-Gm-Message-State: APjAAAWNLV/JemTRwDxYFldiZipNE1QuIA9iL8PxCU6pkTm/yyVlEFQV
        Ag8c1Ky+UgSbVW9IGVGspbQX5Q==
X-Google-Smtp-Source: APXvYqxlOqkg8w2OWWVJ2hLfUph8UVNaLCOyCwz48MDFBPl0G/nO0YOXmheCojMSK7htR0uHnMpJmA==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr15405856pja.106.1561247645823;
        Sat, 22 Jun 2019 16:54:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm6791434pfd.43.2019.06.22.16.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:54:05 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:54:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
Message-ID: <201906221654.3E113D1@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-10-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:38PM -0700, Matthew Garrett wrote:
> From: Jiri Bohac <jbohac@suse.cz>
> 
> When KEXEC_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down.
> 
> [Modified by David Howells to fit with modifications to the previous patch
>  and to return -EPERM if the kernel is locked down for consistency with
>  other lockdowns. Modified by Matthew Garrett to remove the IMA
>  integration, which will be replaced by integrating with the IMA
>  architecture policy patches.]
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> cc: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eec7e5bb2a08..27adb4312b03 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -237,7 +237,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			goto out;
>  		}
>  
> -		ret = 0;
> +		ret = security_locked_down(LOCKDOWN_KEXEC);
> +		if (ret)
> +			goto out;
> +
>  		break;
>  
>  		/* All other errors are fatal, including nomem, unparseable
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
