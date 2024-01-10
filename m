Return-Path: <linux-security-module+bounces-824-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B78250F5
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Jan 2024 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE5D1F2293D
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Jan 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A923770;
	Fri,  5 Jan 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kQrNI5KY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728824B32
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T5z0z2MBtzMpwnM;
	Fri,  5 Jan 2024 09:38:43 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4T5z0y1y26z3d;
	Fri,  5 Jan 2024 10:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704447523;
	bh=DDe5tqsqiBbWb5qjK0hmTzVhkloPXm7e2F0d9Jw9xMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQrNI5KY1Q65uBgSH20N98QKLgikY8rtEADRN7QZZZYS3GSW1UarBj10Tu0ECGxo0
	 DD//AwIuK53SWSTSqk4N80aJNA5tzUZw9CdVxJBYavoGu9qn8/poavkN6KuXIMWHYS
	 +GYts/JI7sC2Uv3EvJjc2hTNEBIF3LMJpkTfiwBc=
Date: Fri, 5 Jan 2024 10:38:37 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 3/9] landlock: Optimize the number of calls to
 get_access_mask slightly
Message-ID: <20240105.He4eiLae7phu@digikod.net>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208155121.1943775-4-gnoack@google.com>
X-Infomaniak-Routing: alpha

I'll send these first three patches for the next merge window (next
week). You can remove them in the next series.

Thanks!

On Fri, Dec 08, 2023 at 04:51:15PM +0100, Günther Noack wrote:
> This call is now going through a function pointer,
> and it is not as obvious any more that it will be inlined.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  security/landlock/ruleset.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 789c81b26a50..e0a5fbf9201a 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -723,11 +723,12 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>  	/* Saves all handled accesses per layer. */
>  	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
>  		const unsigned long access_req = access_request;
> +		const access_mask_t access_mask =
> +			get_access_mask(domain, layer_level);
>  		unsigned long access_bit;
>  
>  		for_each_set_bit(access_bit, &access_req, num_access) {
> -			if (BIT_ULL(access_bit) &
> -			    get_access_mask(domain, layer_level)) {
> +			if (BIT_ULL(access_bit) & access_mask) {
>  				(*layer_masks)[access_bit] |=
>  					BIT_ULL(layer_level);
>  				handled_accesses |= BIT_ULL(access_bit);
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

