Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8C77FFB7
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Aug 2023 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355255AbjHQVVj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 17 Aug 2023 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349926AbjHQVVV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 17:21:21 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 14:21:20 PDT
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75AC1
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 14:21:20 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id WcDhqbnzeEoVsWkPFqAQhz; Thu, 17 Aug 2023 21:19:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WkPEqk876or5tWkPFqwlKV; Thu, 17 Aug 2023 21:19:49 +0000
X-Authority-Analysis: v=2.4 cv=Vqcwvs6n c=1 sm=1 tr=0 ts=64de8ef5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=xVhDTqbCAAAA:8 a=K6HrmWtEAAAA:8
 a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=YpZVJ9pEJ9zOGENEAE8A:9
 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22 a=yV38gEssg_2GhkhKF82i:22
 a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GdZkbs6d8xnOCEm6lQLRaAIvJNDQE/YytzCwGkCxNlI=; b=J3zzUh7hQsrwgewGUBVp5s9B7O
        2WuKMk0PipxJ37aPvnI0QpZLkgYPEToEEcBgvnmuz4MU64YYmKrJv4xz/m20hg1H6tBWyG6CBp0Be
        ozRvkQ26ggT+Y98ox1avR9r7Qlf9z5Sk03Hw31O3uSFefJ7NTLub18S/3Dj6tqfyfTzLKtdxee5Oq
        z3V877OCMHPJXzMT33PnHURYbWVal9KBMLxqR8zM15Gp7NcqEU34UeHtcmOxAy003nBCZeG2KnKtB
        mWH1mr5vcPZ3PM6ZHhDYgkra0740zlHg0mDgpgZSdGgR8QChXGOwbG4/Q8hXXICvlfl2CEZX1noic
        7BCVOu9w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:45576 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWkPD-001iQy-2Z;
        Thu, 17 Aug 2023 16:19:47 -0500
Message-ID: <9d3a054d-ce3d-a971-2635-7fc65f36bfd5@embeddedor.com>
Date:   Thu, 17 Aug 2023 15:20:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] integrity: Annotate struct ima_rule_opt_list with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230817210327.never.598-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817210327.never.598-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWkPD-001iQy-2Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:45576
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 40
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHAuRXKjK/nP/30PmZcv6VoXu+cEsALh63vqZpDwFYIQfKfkkeSK1i9p+xjLTl/Y5CHZLsJ2S8JjcYTFZqXT1vFcRj0z80VY/s/+oQfXQkADq6eWltFV
 6lnMwbac7OUkPzA7jowG/eP2gDp6wbpwyoE/hwvfqFlOimc8xCLg6s5Y+REtGnTeNyBJ9+o+n2wO1CXd6jY53Jw7TrjlcyU0ewie/BqtqlfHOwvpHxTOqfrU
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 8/17/23 15:03, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ima_rule_opt_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   security/integrity/ima/ima_policy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 69452b79686b..f69062617754 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -68,7 +68,7 @@ enum policy_rule_list { IMA_DEFAULT_POLICY = 1, IMA_CUSTOM_POLICY };
>   
>   struct ima_rule_opt_list {
>   	size_t count;
> -	char *items[];
> +	char *items[] __counted_by(count);
>   };
>   
>   /*
> @@ -342,6 +342,7 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>   		kfree(src_copy);
>   		return ERR_PTR(-ENOMEM);
>   	}
> +	opt_list->count = count;
>   
>   	/*
>   	 * strsep() has already replaced all instances of '|' with '\0',
> @@ -357,7 +358,6 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>   		opt_list->items[i] = cur;
>   		cur = strchr(cur, '\0') + 1;
>   	}
> -	opt_list->count = count;
>   
>   	return opt_list;
>   }
