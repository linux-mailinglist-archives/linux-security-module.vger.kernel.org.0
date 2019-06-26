Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0932C574D8
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFZXSo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 26 Jun 2019 19:18:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46739 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfFZXSn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 19:18:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so193295pfy.13
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2019 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Auv1gZ2zwVP+D3ZI4Wlif+2Ta9NstTGaeKCi/c1Uj+8=;
        b=WJRD5u49Urd+c7NkvYim0Dw+EA/BnZ1lfX6yvdKm1byizz3TZcYC+vFMqo+DYQ0lT3
         A2b8k8ZFzaK7X81qmcLTkgvrD+3JCuUQuQ4t4c2xn1L0Do8YfxL1s/da7qa3Qa+6TEmV
         4HbHkF8hzsNjmuOOrOkWbeoWJrIZP/wbeFjhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Auv1gZ2zwVP+D3ZI4Wlif+2Ta9NstTGaeKCi/c1Uj+8=;
        b=tvzxoDNNEqupQn9GUxo8k+jcOX8DWBYu7wQdCK2MGvA4X6ZM6+kVKGoN5ZogP7ItK1
         Qi3/8VS/WRXFKTyvJemzj7H1jC54ci52UGEAy9g4GcfFXE4VtF4vgTrtgj9v31nmLHr4
         ExFp9LN1IFqZwajcsxgIcnOvyIKVXm19GwSrtfff0dFAgBhk+b+OsxwFdAtIm44Kkso/
         zURCtmnXEbTGV6woXYahMTEsf2aDSs4rqm9depQrP7wg6JplIQB+Cmmd/nQjIslaULgv
         19azGFjxP1pRDSRuTL85D0wjveuByzPqtCDIcLUANrra3rC7I9gFUgnFGT3ggRUj7Jwq
         gWhA==
X-Gm-Message-State: APjAAAVHINlAMzucwKUjwpU5hNdSVjwoL5yCsEDpr6vEp2egL2b+KJWM
        6EClET7Hwbv66ez6BXst1jpLtg==
X-Google-Smtp-Source: APXvYqzT1ef5AOSa74HAYStW1iBw/jnz2cYBUANujd5vuUQINNj/huUuNFUkyL32re/9iX8Gv6MFkw==
X-Received: by 2002:a63:60cc:: with SMTP id u195mr486755pgb.13.1561591123268;
        Wed, 26 Jun 2019 16:18:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18sm335358pfr.75.2019.06.26.16.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:18:42 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:18:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 23/23] AppArmor: Remove the exclusive flag
Message-ID: <201906261618.21261BAEC@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-24-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-24-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 12:22:34PM -0700, Casey Schaufler wrote:
> With the inclusion of the "display" process attribute
> mechanism AppArmor no longer needs to be treated as an
> "exclusive" security module. Remove the flag that indicates
> it is exclusive. Remove the stub getpeersec_dgram AppArmor
> hook as it has no effect in the single LSM case and
> interferes in the multiple LSM case.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/apparmor/lsm.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 6d2eefc9b7c1..fb5798683ae1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1079,22 +1079,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
>  	return error;
>  }
>  
> -/**
> - * apparmor_socket_getpeersec_dgram - get security label of packet
> - * @sock: the peer socket
> - * @skb: packet data
> - * @secid: pointer to where to put the secid of the packet
> - *
> - * Sets the netlabel socket state on sk from parent
> - */
> -static int apparmor_socket_getpeersec_dgram(struct socket *sock,
> -					    struct sk_buff *skb, u32 *secid)
> -
> -{
> -	/* TODO: requires secid support */
> -	return -ENOPROTOOPT;
> -}
> -
>  /**
>   * apparmor_sock_graft - Initialize newly created socket
>   * @sk: child sock
> @@ -1195,8 +1179,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  #endif
>  	LSM_HOOK_INIT(socket_getpeersec_stream,
>  		      apparmor_socket_getpeersec_stream),
> -	LSM_HOOK_INIT(socket_getpeersec_dgram,
> -		      apparmor_socket_getpeersec_dgram),
>  	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
>  #ifdef CONFIG_NETWORK_SECMARK
>  	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
> @@ -1707,7 +1689,7 @@ static int __init apparmor_init(void)
>  
>  DEFINE_LSM(apparmor) = {
>  	.name = "apparmor",
> -	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
> +	.flags = LSM_FLAG_LEGACY_MAJOR,
>  	.enabled = &apparmor_enabled,
>  	.blobs = &apparmor_blob_sizes,
>  	.init = apparmor_init,
> -- 
> 2.20.1
> 

-- 
Kees Cook
