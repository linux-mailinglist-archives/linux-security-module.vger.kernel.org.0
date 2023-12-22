Return-Path: <linux-security-module+bounces-705-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B4581D04A
	for <lists+linux-security-module@lfdr.de>; Sat, 23 Dec 2023 00:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABF5B23A2E
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Dec 2023 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B830F84;
	Fri, 22 Dec 2023 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UZoXtwIP"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C72E853
	for <linux-security-module@vger.kernel.org>; Fri, 22 Dec 2023 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f8d9fe99fso10267616d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 22 Dec 2023 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703286037; x=1703890837; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Nv8uNR8r1UabDDakzpv0NQNOYjWk2eK87n1dr2BSJU=;
        b=UZoXtwIPPBN4jxnGNdjqq10h9URLS9Oc+z4/A104jqlVQPYwSuuuYdzrvgbDH08yrj
         TzBNaoopap0iS/EuXA9vyztlGpenH2lPP3OqHvd2HhBdjEzYtrNpnT44edJqrRIhJDAc
         qbmIuCYQeG/Heg5bGcFfgBD5OpgtzKTmvHATrrt8XS9d5SEoBol4RpgNzG5TmmK0n3Rt
         wd9p+kDXsyfQ1jPBrQMlhugAfbZ0wM/879lfpUufODrto+Wo9cOiZPXcvJsama6mSq+q
         WM1zH0+7did29T5a0o5zGVslzOV1PoLXziS3Eub5LXX/z5na/MS0GoxnX8hawY1nn1OC
         vy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703286037; x=1703890837;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nv8uNR8r1UabDDakzpv0NQNOYjWk2eK87n1dr2BSJU=;
        b=YyEB1m6Dgld1KRykegNzsFNKezvgATYXcyBHeY9/5OZUPrdk5OqMo1G7ab613zRYEx
         d5eqhks8FXOMhiZB0neiSwNdQXVH71btylFLQrrV5Dz1oSenzSJzH9tpwYPaaDa7Oa0m
         WIzKlsiKKFA5FXi/d/k1S/Huwnn+L9WeD79tUp8Mtx3+rGKsuNurzdezxTp4gHKxdjD+
         HN0Zu0oMl6qZRRe5pVY2xj135aNNlfEgm0CXVxYmDuYbN6zkNEON3XRC8701ZRkrJ+bT
         2j67vorgWc1NrsMIAWwP15epp7Jm00pQ6b62N8y79F+pzaZSJiWmNw4D2ZIfdyVFYlkU
         Kwpw==
X-Gm-Message-State: AOJu0YwqDH6ITrO/ov5o+mJ5ZK19Epb8aFAP+LhC0CUiXzK/5GRgVtD1
	q9RCpbTqCxBlqlNvJ19aShUFePV7jcsd
X-Google-Smtp-Source: AGHT+IHivcNUvBnzEx1PO0wcH1I3uu81Ge/gxr8GBgGSKKGUOuY0mpc9lGmKUUYqeh3Coi61ReIVhw==
X-Received: by 2002:a05:6214:490:b0:67f:6b04:4262 with SMTP id pt16-20020a056214049000b0067f6b044262mr2917715qvb.20.1703286037382;
        Fri, 22 Dec 2023 15:00:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ff10-20020a05622a4d8a00b00421c31faf05sm2239485qtb.1.2023.12.22.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:00:36 -0800 (PST)
Date: Fri, 22 Dec 2023 18:00:36 -0500
Message-ID: <a977371e5b88391866ea55f200db8ac0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Mark Brown <broonie@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] lsm: Add a __counted_by() annotation to lsm_ctx.ctx
References: <20231222-lsm-fix-counted-by-v2-1-f1237a095bdc@kernel.org>
In-Reply-To: <20231222-lsm-fix-counted-by-v2-1-f1237a095bdc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

On Dec 22, 2023 Mark Brown <broonie@kernel.org> wrote:
> 
> The ctx in struct lsm_ctx is an array of size ctx_len, tell the compiler
> about this using __counted_by() where supported to improve the ability to
> detect overflow issues.
> 
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Add explicit stddef.h inclusion in case __counted_by() definition
>   isn't otherwise pulled in.
> - Link to v1: https://lore.kernel.org/r/20231221-lsm-fix-counted-by-v1-1-12cc27597cdf@kernel.org
> ---
>  include/uapi/linux/lsm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to lsm/dev, thanks!

--
paul-moore.com

