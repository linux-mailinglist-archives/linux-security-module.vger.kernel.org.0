Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A71684F
	for <lists+linux-security-module@lfdr.de>; Tue,  7 May 2019 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEGQpa (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 May 2019 12:45:30 -0400
Received: from namei.org ([65.99.196.166]:37914 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfEGQpa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 12:45:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x47GjNLH013728;
        Tue, 7 May 2019 16:45:24 GMT
Date:   Wed, 8 May 2019 02:45:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tomoyo: Don't emit WARNING: string while fuzzing
 testing.
In-Reply-To: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1905080244530.13589@namei.org>
References: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 7 May 2019, Tetsuo Handa wrote:

> Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
> testing.") enabled the learning mode, and syzbot started crashing by
> encountering this warning message. Disable this warning if built for
> fuzzing testing; otherwise syzbot can't start fuzzing testing.

syzbot crashed? Sounds like a bug in syzbot which should be fixed rather 
than this approach.


> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  security/tomoyo/util.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
> index 0517cbd..52752e1 100644
> --- a/security/tomoyo/util.c
> +++ b/security/tomoyo/util.c
> @@ -1076,8 +1076,10 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
>  		domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
>  		/* r->granted = false; */
>  		tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
> +#ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
>  		pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
>  			domain->domainname->name);
> +#endif
>  	}
>  	return false;
>  }
> 

-- 
James Morris
<jmorris@namei.org>

