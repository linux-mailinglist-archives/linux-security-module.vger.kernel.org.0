Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D867791B4
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Jul 2019 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfG2RFD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Jul 2019 13:05:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39996 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2RFD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jul 2019 13:05:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so27699764pla.7
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2019 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0irySBTgZ2yXply6I5PieqBgSXD7raAHIcMDZbw1ww=;
        b=D/nyhGGp2VsM/R1Jy4byBjUW8TE4IegAMll6MajAH0+fCIRfGYjnA5+lU1uwmYaPNX
         t4siWjjT2O2X5ADbTG+PvQnP8QmsWLzXboXgHKWISDb25bw5vTWsn6JLXq0LDEqCxWuC
         HETkeA0vT1OsCaoPwxxnxjwbqbQS2szyagBOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0irySBTgZ2yXply6I5PieqBgSXD7raAHIcMDZbw1ww=;
        b=WLD5C4QOzP6flncP+2NIlqL7+xRt96ePoiiVIO6KFVdZK4kfuKxFoCEAMsFhwAcSYn
         VbZSju8rhUPe+JrdYjYp0o/2BKcn1gBBH4/8Wrg1/uKfU4AK905eiSwd+e3wVqRyEWDQ
         7UChqkJ9zrY+LMtjwTo3pGCPcbsWwtsJDRgND7a8+H9ZxSoRFvwxhMNRGbSomV03xZM1
         qLmcnyMX5VSGSnB3ku5nGHCQhQghWNO5rfAhy+uH38kvKmvnjRHPHwxixr/1HJfbrfjc
         6vEsQvwjeGGHks6ZsUFfb17OTIrhJhnx6cOsnhAk5a5ymK4ijOSrLBOBYmXubcoN2R9l
         nilw==
X-Gm-Message-State: APjAAAX3/uBVMly6EFwacWz1PF2sQUUFqaJzHymfDdn7bqYdLaunqJGX
        PkWDI2Ovbb81a2WUpd5/1PP+HmWiMCU=
X-Google-Smtp-Source: APXvYqzw1XIGfrYY7jFB2VlflwHsCIpi2Ip1JX5s7R0uRj4XNLOAYDdolj1hRbxVDVp/z1glEvOWEw==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr110535231pld.174.1564419902756;
        Mon, 29 Jul 2019 10:05:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i74sm121948392pje.16.2019.07.29.10.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 10:05:01 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:05:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 14/27] LSM: Specify which LSM to display
Message-ID: <201907290959.747536016E@keescook>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-15-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726233923.2570-15-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 26, 2019 at 04:39:10PM -0700, Casey Schaufler wrote:
> When a program is executed in a way that changes its privilege
> the display is reset to the initial state to prevent unprivileged
> programs from tricking it into setting an unexpected display.
> [...]
> diff --git a/security/security.c b/security/security.c
> index 8927508b2142..4dd4ebeda18d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -835,7 +857,18 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  
>  int security_bprm_set_creds(struct linux_binprm *bprm)
>  {
> -	return call_int_hook(bprm_set_creds, 0, bprm);
> +	int *disp = current->security;
> +	int rc;
> +
> +	rc = call_int_hook(bprm_set_creds, 0, bprm);
> +
> +	/*
> +	 * Reset the "display" LSM if privilege has been elevated.
> +	 */
> +	if (bprm->cap_elevated && disp)
> +		*disp = LSMBLOB_INVALID;
> +
> +	return rc;
>  }

I think this is the wrong place to check this. This is called in
prepare_binprm(), which is very early in the execve() process. By my
reading this will change the forked process's display first before the
exec happens (which may potentially fail) -- this needs to be changing
the final state once exec is under way (past the "point of no return" in
flush_old_exec()).

Also, the consolidation of privilege information happens into
bprm->secureexec in setup_new_exec(), so I think you want to test
secureexec not just cap_elevated.

So the test/clear should likely happen in finalize_exec() since it's a
runtime state, not a memory layout-changing state (which would need to
happen earlier).

-- 
Kees Cook
