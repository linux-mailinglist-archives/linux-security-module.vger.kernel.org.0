Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C426522F746
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Jul 2020 20:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgG0SGH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Jul 2020 14:06:07 -0400
Received: from namei.org ([65.99.196.166]:55630 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbgG0SGH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 14:06:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06RI5sx8020079;
        Mon, 27 Jul 2020 18:05:54 GMT
Date:   Tue, 28 Jul 2020 04:05:54 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Colin King <colin.king@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrity: remove redundant initialization of variable
 ret
In-Reply-To: <20200701134634.549399-1-colin.king@canonical.com>
Message-ID: <alpine.LRH.2.21.2007280405340.18670@namei.org>
References: <20200701134634.549399-1-colin.king@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 1 Jul 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/integrity/digsig_asymmetric.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index 4e0d6778277e..cfa4127d0518 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -79,7 +79,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>  	struct public_key_signature pks;
>  	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
>  	struct key *key;
> -	int ret = -ENOMEM;
> +	int ret;

Assuming Mimi will grab this.


Acked-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>

