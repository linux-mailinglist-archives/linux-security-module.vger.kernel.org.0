Return-Path: <linux-security-module+bounces-2652-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA78A2A3B
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Apr 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3356D1C21987
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Apr 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4B59B4B;
	Fri, 12 Apr 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NhvAawsX"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014153E14
	for <linux-security-module@vger.kernel.org>; Fri, 12 Apr 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912040; cv=none; b=iW96gce3ku0NeuZU29HKLdGPscFdD3GOdtvOSJzWxtcNPc+xcQ72nQFw3KeiSHdu36catAe6X+EVt0xP1A5XSo4O0sm215pPX9LWz8o4T3QalU1ogOTt01g5JfwtOi5RZw7U2osNlIAea1ac2qf9UtA/dFeQYSHLWGBei1pYSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912040; c=relaxed/simple;
	bh=Rm+Jhy2CPEMYHiZu4p8My94JcsMyZsaQrqOVLaEHKfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyvYqy6stsjCvXAtMLrwUnshTpnzXG3geWa55DyxndWJZSgTCy7wuFgFGfKXIYUoNdXS6HJjQFT0PNKGLnegFQAW+y9sfGn4EfGcPAZYLOEIk0oMWW7J3FdRjH5xdrcUDZJDd+Tl2Rche3sMwIgwWWKb8gNK2boAK9TPHGDe7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NhvAawsX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so7142371fa.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Apr 2024 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712912036; x=1713516836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HCv5WXEXkcM3e4s9GxwuVLanaiJtfT2xDBOPBy8Ztg=;
        b=NhvAawsXAsmL6+8taXeMueUTUfIHzdon+4e/rTZ6ouZTW+kmC81lcsWljfmwwHOZZg
         xjpPpXq+oboTBP7LL2PBd0+Q0TogBbcOdveJSXUtoh6RybXjPcOvPwGR5c69VP1dm8DB
         C6WdVZBXfO9tDFEIB6BnME05LPMCOFiPW6N0Qi8VNukFV4tC5vvnffESY5PN+mBA8BNt
         QdG4K0ZPIH+tHDk2PFsG2D3etLwI7PP6+E6qD8pyGHRANcKfJtJbf+tp4xPbAeiRRpqT
         hNgvqw24AzWDQdINb+cUAJ0vVr07db/EiyTOcNfXBvLeD+uqvArd1Oylj1bdGpCl9Gks
         /DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712912036; x=1713516836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HCv5WXEXkcM3e4s9GxwuVLanaiJtfT2xDBOPBy8Ztg=;
        b=afhSQQRvOhi4FZw3L9y7wV7yYJUQ8FA0wXfEN5t/KwEEb0otAyY4HyHO0hRuhUcVZy
         KRK9wYesNUvb10kPazy0I/iWdJVmvFid9y8bE6H1rDW8ruzdxe9eGSyi24yHO71mG1Kr
         bxkYePUsTsdFrfJ7T3jQ38eNBjytObYpux2Zc7hRbYnkU3d9mt1/1fmpS2tfdYVfjCJQ
         q04elu/0MYhN/lGUXEsBF8KLSRuxmNSMCPYGEjVyl3aZWLSYdj6bCJdZaQ7YYL/ugtbI
         5aaaXtMCIS2PyLQabuZHfUxgq0XwVUgh2kTfhpCsHNy5vUvWu/85MqE5z/QH5jd394fZ
         S04Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOHYM90UXKBRNdGwvUfKP1+vMVRlujpECkfD3sYSP3c7SPODj98bTPuuuuESmBlj1CQ8ouZwHfe5yoNfE7nuubYRRqyoDTaXoICr1QRJM50jeYaqAu
X-Gm-Message-State: AOJu0Yyk9llUz1E42AfQumaBD4tSogI9BI6544L2UcnJqiF9RmyAyg8Q
	6MFdafwI6QMyzugOrNWQih1qxqXERWvmSh/fmP8m0g1RHbBRhbfpq5kkMxAgsHk=
X-Google-Smtp-Source: AGHT+IFSyvhmvV600yckuR3RXXhnT/HiMaiPPbLP9Bpktx86rW2y3WG1OuM9vSWWo5pDGj5dTLztzA==
X-Received: by 2002:a05:651c:205c:b0:2d9:eb66:6d39 with SMTP id t28-20020a05651c205c00b002d9eb666d39mr1130573ljo.19.1712912035823;
        Fri, 12 Apr 2024 01:53:55 -0700 (PDT)
Received: from u94a ([2401:e180:8863:5c39:2e5:46b1:443c:b5c1])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm2522658pfb.40.2024.04.12.01.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:53:55 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:53:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
	bpf@ietf.org, David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v3 06/11] bpf: Fix compare error in function
 retval_range_within
Message-ID: <m3pwq4fhoh4pecl5mahz7fhjiav4atebtbr22jfk4eqqq5hiya@g3vsc2zqlcy6>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-7-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411122752.2873562-7-xukuohai@huaweicloud.com>

On Thu, Apr 11, 2024 at 08:27:47PM +0800, Xu Kuohai wrote:
> [...]
> 24: (b4) w0 = -1                      ; R0_w=0xffffffff
> ; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
> 25: (95) exit
> At program exit the register R0 has smin=4294967295 smax=4294967295 should have been in [-4095, 0]
> 
> It can be seen that instruction "w0 = -1" zero extended -1 to 64-bit
> register r0, setting both smin and smax values of r0 to 4294967295.
> This resulted in a false reject when r0 was checked with range [-4095, 0].
> 
> Given bpf_retval_range is a 32-bit range, this patch fixes it by
> changing the compare between r0 and return range from 64-bit
> operation to 32-bit operation.
> 
> Fixes: 8fa4ecd49b81 ("bpf: enforce exact retval range on subprog/callback exit")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 05c7c5f2bec0..5393d576c76f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9879,7 +9879,7 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>  
>  static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
>  {
> -	return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
> +	return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;

Logic-wise LGTM

While the status-quo is that the return value is always truncated to
32-bit, looking back there was an attempt to use 64-bit return value for
bpf_prog_run[1] (not merged due to issue on 32-bit architectures). Also
from the reading of BPF standardization ABI it would be inferred that
return value is in 64-bit range:

  BPF has 10 general purpose registers and a read-only frame pointer register,
  all of which are 64-bits wide.
  
  The BPF calling convention is defined as:
  
  * R0: return value from function calls, and exit value for BPF programs
  ...

So add relevant people into the thread for opinions.

1: https://lore.kernel.org/bpf/20221115193911.u6prvskdzr5jevni@apollo/

