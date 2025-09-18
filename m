Return-Path: <linux-security-module+bounces-11702-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08700B40C80
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Sep 2025 19:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEADB4E4787
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Sep 2025 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC4F2E283E;
	Tue,  2 Sep 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rTaPzSNJ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B7283144
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835482; cv=none; b=Sqf9gqxUkTGsquXcaXJE0k/07VDnzd3C1vufIvDJxdEtr1wbUUIKxK0hIFGtvERcna2iBatcVpuyI3FzX7JPnt8V0mJtdUs0VsTApePHG63OlmPSKXvh7YMbEGq4uMLB3EbqzFHrjQLRi7rc3S0vwauqh6QfNxC+E8Ai2S2CokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835482; c=relaxed/simple;
	bh=ij3QU8NGC7NeXdaBvPYfa9JhjcDXbQ6Y+v9D62BQ/uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIqdhh8h04lV+ae+5hvoaaI2p8X9b9Kb9AWWkUiBHSxmg6jICbEMUrJuEZwjECmZ8XUMhl2giU8sV4gceb7ROdqDmsDrh28P95fQEsimBEL3fGrp3YYD4F3QqkOEllQZruqUg59wPc9neU5KOuypgMksJkW2LqzAwFswBnF/KtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rTaPzSNJ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 573FF3F52D
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756835479;
	bh=HfZznrJfB1dICVVaT+f4HXRi6Umt1xD9tUrHuERyGaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rTaPzSNJZz85SNjx2d/adCUu706QA32IlpuL2xH47gzDtsUfWBJZlNfjJXO3oqeyh
	 8pyb8gm9KY4Bobvs3hAoTJM4rIbE+s6kjpeUhJ8c8E+tCDNZt9f2yb6KJBxAD5H/iV
	 Pt4wzy1ERRd8HsgwJlsoOcKMcAXWgkL9thm4woDhbHZxRQjl7yegMPrWuBgA5PHTav
	 H74svW4nu4HJvE9ZNrlQjzAvGfnS5fdDOGHPxCwCMPkUR+6ryyWmzmCbzt4D/8ZFlX
	 2B2/ix6KO+TMEgIbK/n32wSJaq4lxw8Mc3JUXxgMxnefCW7EYx3I9x+V28osBhurSB
	 Zuaf1YWfIq4NQ==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c46fbb997so103960a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Sep 2025 10:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835476; x=1757440276;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfZznrJfB1dICVVaT+f4HXRi6Umt1xD9tUrHuERyGaU=;
        b=Jx/YJOCXJtKdvfAvoulAXKTCLd7G1nbEQufWjHHSX5Wm1txaSrRTCuoufY4fWO7OJS
         Xqd1hfWXErav024HHjCgTgmJm3eh8fOrmlDM6SG6PQ/rRxVjlQ8dyoDvF9+p4eFeuh3d
         6STxdtp7qNAR0dFs/ScKUKT72mn/X4tsD626RoTnvY3elHt0aGEil2L7XgMj96PE5cGJ
         aCr3Yz8evXt4dTNrjbzxwAKIvQvdMuG0bsaIXmszwI9kQwHLLgsxBKFY5grxKZQkWcYC
         kLhJZE8Od5CmviH7fpRRl7sJIE6bNkIdNYURUgJdv5mLdt6SNB669SfKfqnBSl/N4+5M
         Sjug==
X-Forwarded-Encrypted: i=1; AJvYcCVPna/WM9M+IuCkKHBzUiul3iGv7VQskE2Lp1hJhZEVNo6yRm7TWJplNMWMSkckrZbntCs16QqL7e6FfDrQOmJ2Safw7MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzED1JI5ZBOUlbz1bcIFiOh9HyZx8LaoTFTOG2ggZVBeUqr/jC2
	6JlEC8q/ps3rZSoo+UHtMKFpmt2AUKcqtVN9IkgbY4zJhh+rL4ykn3haymtr3iMO2XVxXc9NK7J
	+jS2f85eSu7anpz38Xa5nLhdT/+rjP5L9S+JIV9LWOynUhAsw96+FT0qHltGIxSjvOcSIATwETt
	BbgGC8jAm+XlnwJNZGHw==
X-Gm-Gg: ASbGnctSt4EkcfBpkD2ckikPeEYpZxTxg22bXcm6uj5mQdvu7UNSzpu99/iQGldhGrc
	AUYPYVfoVaKeVZto63EPzf7efrHX0nYRIJHGlpUk1ss0qCjhvGhILzf1dWKuhrwFRsCRwkp6yL5
	iX1ipkHhWRNoQR4Q1rFCBfeOnVYXpFi2jujD4z71aM9hXRS+tTC0qSjmFVpWvNwsMTsyQdhmdEg
	5DFyaPbmn/zZDczEh5vnzBG64w6hVnQiwyW+nQKNKxMjl70GeJZxOqeSQiEWCpQzQYuLLkVlntn
	yWMUJUimPw4VzAsdtkOo7HUxlAypgUOvogK/l5Wi6h1tfdV2awkqfA==
X-Received: by 2002:a17:90b:3148:b0:325:6598:30d7 with SMTP id 98e67ed59e1d1-3280d364e5dmr16357095a91.16.1756835476427;
        Tue, 02 Sep 2025 10:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3NfrNr0u5Dl1pH4RPhQ18KvyHS94K+Vbw2+IqYN4A6Mu17B0XKZuKf5zW+cDevvlZZMUBGA==
X-Received: by 2002:a17:90b:3148:b0:325:6598:30d7 with SMTP id 98e67ed59e1d1-3280d364e5dmr16357053a91.16.1756835476018;
        Tue, 02 Sep 2025 10:51:16 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd366a909sm12145798a12.52.2025.09.02.10.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:51:15 -0700 (PDT)
Message-ID: <00faa5b3-819a-40b4-99b1-5f6a3b7d9831@canonical.com>
Date: Tue, 2 Sep 2025 10:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/34] loadpin: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-60-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-60-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Acked-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/loadpin/loadpin.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index b9ddf05c5c16..273ffbd6defe 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -270,11 +270,6 @@ static int __init loadpin_init(void)
>   	return 0;
>   }
>   
> -DEFINE_LSM(loadpin) = {
> -	.id = &loadpin_lsmid,
> -	.init = loadpin_init,
> -};
> -
>   #ifdef CONFIG_SECURITY_LOADPIN_VERITY
>   
>   enum loadpin_securityfs_interface_index {
> @@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
>   	return 0;
>   }
>   
> -fs_initcall(init_loadpin_securityfs);
> -
>   #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
>   
> +DEFINE_LSM(loadpin) = {
> +	.id = &loadpin_lsmid,
> +	.init = loadpin_init,
> +#ifdef CONFIG_SECURITY_LOADPIN_VERITY
> +	.initcall_fs = init_loadpin_securityfs,
> +#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
> +};
> +
>   /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
>   module_param(enforce, int, 0);
>   MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");


