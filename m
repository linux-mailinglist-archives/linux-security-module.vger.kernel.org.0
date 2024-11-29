Return-Path: <linux-security-module+bounces-6618-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07ED9CFC5A
	for <lists+linux-security-module@lfdr.de>; Sat, 16 Nov 2024 03:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785D11F21EFF
	for <lists+linux-security-module@lfdr.de>; Sat, 16 Nov 2024 02:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C728FF;
	Sat, 16 Nov 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XYW0RUac"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF27FD
	for <linux-security-module@vger.kernel.org>; Sat, 16 Nov 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731723451; cv=none; b=uBy9HEaO336dk6UfWlPA0I5GOeEb14FqiTGVyjjVRe5H/StsT2D8nTcXp9Ph99O1ziXk0jz096sp/4/yzNbg+tKqO+IpDmy47vsahWKCtLKZmYXPVSRvEbAIZuYnE4K0sFUmDu8DxLPqCqa6M52G2kVnx8Gv5nYoZdxN6kZGbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731723451; c=relaxed/simple;
	bh=+c6beKWj1aeqhifYdMEG8OHhg7Uq60sIxDklmRJzK/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7+bAJzPKNyf9N8lByn3dgg+bIUQRNKTesMAb8f/zSABxhW6SVZoQs9jJrKtF2S5mp2oIj4rFAr7HA/88Zpjr2hFsVBTDLzvP6PW9AQi4tlIvqjxziQOk3Tm8kCVmVYKZZnkIYEE4CKmMq7Pezgmbogo3EkNBZn4VQZR3SX6UCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XYW0RUac; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.84] (unknown [50.39.104.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 92B183F212;
	Sat, 16 Nov 2024 02:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731723439;
	bh=EGK9adPM08cjdpYI7NurjuuEW6wvjpjqG8cOpOssAMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=XYW0RUacC3bPkae1EurDirJGE44um6NSPVUfUPdM1lW6Z1UBP5GFPaAjqlqvfTc/y
	 9sb+K8k0Kaj0ZVlUjjvzNMz6R4Oqa7n9eue3jyY1j68wLVzl5KHDgnxGMXJKmvfxVR
	 mBNEUHb/wbmIW0CN1tyM1j1/SSA4k3+PxurIHKJx8TuKyEWXKsCJ7C+VemZQQ67EhD
	 bz077rQxobA2m7cU7ux6wBdZImjNboWhATXamfpWKZdkYCYbgF8EZgyujN0Z98wMMJ
	 mfqNbUKfyJtEMe05Mg1fUPrxyVxInRQF57i2JbhGIpc57cykFyoHYp7t5//E5IMaWm
	 DKcs4FrEfjPMQ==
Message-ID: <7cc38d2d-5e4f-4b03-a1a8-e0b89f4005b8@canonical.com>
Date: Fri, 15 Nov 2024 18:17:11 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Add empty statement between label and
 declaration in profile_transition(()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ryan Lee <ryan.lee@canonical.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
 patches@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20241111-apparmor-fix-label-declaration-warning-v1-1-adb64ab6482b@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20241111-apparmor-fix-label-declaration-warning-v1-1-adb64ab6482b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 06:49, Nathan Chancellor wrote:
> Clang 18 and newer warns (or errors with CONFIG_WERROR=y):
> 
>    security/apparmor/domain.c:695:3: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>      695 |                 struct aa_profile *new_profile = NULL;
>          |                 ^
> 
> With Clang 17 and older, this is just an unconditional hard error:
> 
>    security/apparmor/domain.c:695:3: error: expected expression
>      695 |                 struct aa_profile *new_profile = NULL;
>          |                 ^
>    security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
>      697 |                 new_profile = aa_new_learning_profile(profile, false, name,
>          |                 ^
>    security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
>      699 |                 if (!new_profile) {
>          |                      ^
>    security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'
>      704 |                         new = &new_profile->label;
>          |                                ^
> 
> Add a semicolon directly after the label to create an empty statement,
> which keeps the original intent of the code while clearing up the
> warning/error on all clang versions.
> 
> Fixes: ee650b3820f3 ("apparmor: properly handle cx/px lookup failure for complain")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411101808.AI8YG6cs-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

thanks for the patch, but I went with an alternate version, that I did last Sunday
(sorry I guess I forgot to push the tree). Since I hadn't pushed the tree I did
consider replacing my patch with it but in the end decided to not go with
the C99 variable declaration, moving the var to the top of the outer block (what
my Sunday patch did).

The reason being that while I don't think the style guideline forbid them, I end
up getting patches for them anyways, as some compiler flag sets will warn about
them.




> ---
>   security/apparmor/domain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 602d7a1bb44823a9b81e34d270b03c5f3aff3a34..eb0f222aa29442686b0a6751001c879f5b366c59 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -691,7 +691,7 @@ static struct aa_label *profile_transition(const struct cred *subj_cred,
>   			error = -EACCES;
>   		}
>   	} else if (COMPLAIN_MODE(profile)) {
> -create_learning_profile:
> +create_learning_profile:;
>   		/* no exec permission - learning mode */
>   		struct aa_profile *new_profile = NULL;
>   
> 
> ---
> base-commit: 8c4f7960ae8a7a03a43f814e4af471b8e6ea3391
> change-id: 20241111-apparmor-fix-label-declaration-warning-fcd24ce2d447
> 
> Best regards,


