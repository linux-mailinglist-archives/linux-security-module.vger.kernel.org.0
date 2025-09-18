Return-Path: <linux-security-module+bounces-11703-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1284EB40C8D
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Sep 2025 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E13A8A70
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Sep 2025 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB08340D97;
	Tue,  2 Sep 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OHk0Jj4H"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309F320A31
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835581; cv=none; b=a8pU3DYGRghVuqWaueZPyxceHx6USEb32Lf8SVaN31jV6VSsqAyBhElXQ6IX9DgYrL+AelK9P5xZJFMYh0X6Nh4uwULIdiXf4iaE3Ob5pg17ag4nP6p5N8hxUTJMCGMXFtVsvUUwHkNIEG8ZjSrmsiuekuRqch/F3vNaQ5wVFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835581; c=relaxed/simple;
	bh=JEOupSin7pKtPN3pihuGrO9WryLFaHbNLWHULw2oJt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC8PXLbroTGqVCgpSK6EbY0Tl0fgs+8w0vuiAfjrd9omuVQwOOsDYkwFfdY6JQsTTwrQ4L1io1adSpwmIxxaHCihklKYaYVTSS3Co1MPlXKz9xYG0s0SLTCs06CJW6ZVbxAo93EMFX5FDlBh/9YSEsiGIOmltuVZ0MQWerCmnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OHk0Jj4H; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F0873F679
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756835578;
	bh=kfAtA0V7pdZn4XM2+1ZyJYSF7zYI6cGbncjMpse8tG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OHk0Jj4HTMYtZs8mzQexV4jHvuXxEMnavgh2Rs1MAYQE9zF4cVoUr5Ks5wvFa8oiX
	 7WLhYxAUlyMiHMTG591rBKJ3zGdc7I924h7HTOC56HC/NibQ5r37BF5QEFEMW9ZSme
	 YTmjEHZXY509NpGiJBxW4BXEPSNxoXCQ2rAlivuC0lcXKJKuQlQeFqiZZ7SCdWTxpG
	 7WuhfZXMteiLP7O4FzPhz/e39uKByKtiSo8Lr5TRCD4SN/OJCGuQg+UeLFS+79cHm5
	 CQ4XwMeJI+J99cKNwFRgS8wKB4ZjEuSOnYCXS9ubvV0nMJ1vfTXaBUiXWkA5O1k8PS
	 J/EZMExQ4x5FQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b4aa90c20so7650515ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Sep 2025 10:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835576; x=1757440376;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfAtA0V7pdZn4XM2+1ZyJYSF7zYI6cGbncjMpse8tG4=;
        b=AMJLGYoObGabdqAJiqc0pf0KwHZsLhDKovli/IKEUNztdqsyzp0dbU9sARi3bvnMKe
         Hqm9K5qM1MnvwmQjO8BTQEkFPMl4TL0Z3NNgXegqdQJTn5gLJudOPEioC+Rigd0zdQWK
         hXdj7BQhrJeXWK8izBshoqyYVeamvygeF1ssRy1NDk8KNwte55y6f8um8scvnC1NDIRW
         m0pQnJwLt2RuAH6KipqKupL7PLXZq7RDPeFpOyETPp+ec6bgshFt+Yibic2s1V+O0A2a
         hHjj1ZNlnvmJRS7IThEvup7JqolNiGYTJwMxGoNpLvkLZILjBO3+OKj2GYto3NL1Du8Z
         XMAA==
X-Forwarded-Encrypted: i=1; AJvYcCWI644TV4k2qXJtbWUEWfXfuAAEiM/rFMmEl/OLnqUdIZlrZEzyxcP/PKZy5h0ycXmy1TSu9r5DJH2PJK7f0pioFlkWvZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvF78btBdoIf92WZC9MFhejRaDYWpADzAq1W9Rk9RWwl4eGDSc
	kuFdNovU/W+7BiDUTV/CVzxCQjNCkBcMdxPhlCkDOlwfCRfPBzh2fUfvdd1LU1J9g/b3AIuYasd
	q5ic08hrDOXJ5cv0pwxgyNbA9v3bgVTUIptF11QMFRTNVY2Be9x+T642tS6jDiNDOG6adwQkpjt
	ZPRErlI8dTPfp5MgNWLw==
X-Gm-Gg: ASbGncsroaY9OMpChmSDDZAHddfIYDNeTSCcpdJP891aSf+esRn4BftJmvSDYgc8Vrn
	zVvs5uFMcwMGjGk5ocx4U1mI82aah79+0/PCQxWErOE0DbLArt06szRKvWr99834LUaTPPnkB3M
	BuOqX6FGg990FSC1auTBGVmlKN6dxPMGVsm6RI/03sBmYQFyI8O76K5Lj0+nsN4Ojs3rK68Nu/g
	Pg3ob2timqpPWHpbAb/iGIfDuK/GtWmA3m3Z0ePitCKJIJmDcacKQQt5DKpJaeLTRl5bY/tS1/P
	7xM/8mxmBBpk5Qt/Tq45S++3dSL+sdwUkeMbFDUp2hZ+3RM5E8pJ8A==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr179956965ad.18.1756835576544;
        Tue, 02 Sep 2025 10:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaGktaLb6RznTiVgBA0DK5/XFfETIc/FFrAST2RBlUIOVcDtBDWqoTklWzRRQZ4IN5On5ZvA==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr179956755ad.18.1756835576156;
        Tue, 02 Sep 2025 10:52:56 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249067de9f1sm136566315ad.151.2025.09.02.10.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:52:55 -0700 (PDT)
Message-ID: <6b35b7bf-5043-40bc-867d-2ef349cd6a75@canonical.com>
Date: Tue, 2 Sep 2025 10:52:54 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/34] ipe: move initcalls to the LSM framework
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
 <20250814225159.275901-61-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-61-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Tested-by: Fan Wu <wufan@kernel.org>
> Acked-by: Fan Wu <wufan@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/ipe/fs.c  | 4 +---
>   security/ipe/ipe.c | 1 +
>   security/ipe/ipe.h | 2 ++
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 0bb9468b8026..076c111c85c8 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
>    * Return: %0 on success. If an error occurs, the function will return
>    * the -errno.
>    */
> -static int __init ipe_init_securityfs(void)
> +int __init ipe_init_securityfs(void)
>   {
>   	int rc = 0;
>   	struct ipe_policy *ap;
> @@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
>   	securityfs_remove(root);
>   	return rc;
>   }
> -
> -fs_initcall(ipe_init_securityfs);
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 2426441181dc..71644748ed56 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
>   	.id = &ipe_lsmid,
>   	.init = ipe_init,
>   	.blobs = &ipe_blobs,
> +	.initcall_fs = ipe_init_securityfs,
>   };
> diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
> index fb37513812dd..25cfdb8f0c20 100644
> --- a/security/ipe/ipe.h
> +++ b/security/ipe/ipe.h
> @@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
>   struct ipe_inode *ipe_inode(const struct inode *inode);
>   #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>   
> +int ipe_init_securityfs(void);
> +
>   #endif /* _IPE_H */


