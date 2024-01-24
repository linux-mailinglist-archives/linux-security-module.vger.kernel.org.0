Return-Path: <linux-security-module+bounces-1098-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39783AAB8
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jan 2024 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932CE1F2C159
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jan 2024 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C105CA69;
	Wed, 24 Jan 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pJLnA000"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B777657
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102025; cv=none; b=Zx2oYRJDkRXZ5QKRZfRhek0aTc14p/dRtVrWvouS3IyStCwwauVBtj6juwPEV5yyQkDJm1aBWTBswx8iZXn48xnuHhEmOAnZFX+P9Z12j14I5QCeWj6Y7d7KTmKkDJveJK+1JVqhwNcVeIB25A6tdvwayXUjOgjvfLn3eJvZg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102025; c=relaxed/simple;
	bh=qhqzFPGC5WzUW9hc0+JQ5GCvzF1b+01JdIOCtqbDNnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWd2Kg92ZMlzTFk0DfRFlCvONQ/h22wAVE/DPTEe8CnEUtRAAXmeu0GbTRqMTyRxjIiFxLJbYiLSpjPjgEuywCN2GxDOEkkdyMbDB8VuqoKmUMH9PqTYoLNVFgLMYwmNDJeQBkgIBZV1bEfWYRVMZ3ENaJCjiZz9HJy+a6/iFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pJLnA000; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKkt530WvzMr0Hc;
	Wed, 24 Jan 2024 14:13:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TKkt42D4nz3f;
	Wed, 24 Jan 2024 14:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706102013;
	bh=qhqzFPGC5WzUW9hc0+JQ5GCvzF1b+01JdIOCtqbDNnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJLnA000aRCpe3+5+q1jJUTDGHYKzn/NNj08aljm1lNuYMRQjnM0LIzbOCULqX9BS
	 b1OvNM/w8UlNMipfxBDu4VCXKLxgCvKM1ye7V+mjbarRalNWVdtNahxgThs2p4MeeH
	 5v+3DRfsUVESGFsfU1q+oDsiHkSFRmlUCjZl81ck=
Date: Wed, 24 Jan 2024 14:13:28 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, amir73il@gmail.com, brauner@kernel.org, avagin@google.com, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH] selftests/landlock:Fix fs_test build issues with old libc
Message-ID: <20240124.oosahMu8chai@digikod.net>
References: <20240124022908.42100-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124022908.42100-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

Thanks, it's merged with some fixes:
https://git.kernel.org/mic/c/82852a3cc2152eb7c7b7007b6430faa979b08fad

On Wed, Jan 24, 2024 at 10:29:08AM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>

You might want to fix the extra dot in your name.

> 
> Fixes: 04f9070e99a4 ("selftests/landlock: Add tests for pseudo filesystems")
> 
> one issues comes up while building selftest/landlock on my side
> (gcc 7.3/glibc-2.28/kernel-4.19)
> 
> gcc -Wall -O2 -isystem   fs_test.c -lcap -o selftests/landlock/fs_test
> fs_test.c:4575:9: error: initializer element is not constant
>   .mnt = mnt_tmp,
>          ^~~~~~~
> 
> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by: Berlin <berlin@h3c.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18e1f86a6234..1f2584b4dfce 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -40,6 +40,7 @@ int renameat2(int olddirfd, const char *oldpath, int newdirfd,
> 
>  #define TMP_DIR "tmp"
>  #define BINARY_PATH "./true"
> +#define MNT_TMP_DATA "size=4m,mode=700"

The idea was to reuse MNT_TMP_DATA for mnt_tmp too. I fixed that in the
applied patch, see my next branch.

> 
>  /* Paths (sibling number and depth) */
>  static const char dir_s1d1[] = TMP_DIR "/s1d1";
> @@ -4572,7 +4573,10 @@ FIXTURE_VARIANT(layout3_fs)
>  /* clang-format off */
>  FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
>  	/* clang-format on */
> -	.mnt = mnt_tmp,
> +	.mnt = {
> +		.type = "tmpfs",
> +		.data = MNT_TMP_DATA,
> +	},
>  	.file_path = file1_s1d1,
>  };
> 
> --
> 2.23.0
> 
> 

