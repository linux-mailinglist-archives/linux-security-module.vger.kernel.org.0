Return-Path: <linux-security-module+bounces-9233-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A8A831C7
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Apr 2025 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212727A5FA8
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Apr 2025 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0512116FB;
	Wed,  9 Apr 2025 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wn+nA0JZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08781E7C20
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229985; cv=none; b=CH9UFNTrj/5NoYqAPj0XNbm6D6nJt430aZ5VT7vgbCG1h7Sxy33Ef88sGVQMPoSsQ4JiDB7Eu2IlgC0cDg+GS/mqutvQjj9kAt+d51QoaQLrJYyEZhZ+jocCiBSNA9OXzgfXNF8FUNwqfNYVP0DLlhxPHMrsWCjr0Ds1cXpCz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229985; c=relaxed/simple;
	bh=vFYL2A2m4BVqGIUPwG+SJe8Wi/rBo/+xMXvF158DHXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVBLrl0hXqXuzh+jIaZKlRX1BXWcoXJ1FS2hn1O7VuhYUO92y1aF3sXRbJW27AhkYrmbayY4h1jztBdPL9+NQnKFSyOYMgiNVVvhUtzhxjY2qWLdwsqq2ZWaQ1IcDsfjT3EyL+dP6NrnbvetxkQtRvmRtbUDHh0k7slFAnGTnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wn+nA0JZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6dea30465aso61174276.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744229982; x=1744834782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsHh17W+bDIV1e4xVUO/JwjeRPH7cOalB9Js2vjnhrU=;
        b=Wn+nA0JZQAGWXBbLIKOsOUEp6QNQFXHFfl8D9NHSUQH82ABaXlAr50iV+7HSk/LZ5q
         qx83eELju83YbCI2XWoyLlB3SZVZaRWjw7YEbQZvdLPyWG9MCMlD6X6v+VCg+pKiPCte
         kUtBSXZZ2Qo+odi9Y5zgSmAy3ErlpXgwOmQ9U3Q5ixc9brwQnG+lulMQO98V0WBFWMsJ
         +fGiXrx641WxrozoR1GTYX+VQbUBJPGqYtgyHbMIDVOcR/PIYFLtUkmWwz/UvLzO1AA7
         WV+ouudBXgaa3eo00UmsD2TVEcyoT8t+QffxgHPg06ODRAFr2u/5dz69btPw7PUcr7gY
         Q3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744229982; x=1744834782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsHh17W+bDIV1e4xVUO/JwjeRPH7cOalB9Js2vjnhrU=;
        b=m17gWeHW+AzQrudgxLmWucrUi7Niw7ZGWc1mwFBq1+50VzElA7uzjxV4EI1N/UDWAe
         s0Z8IvQYHR8cLCTY1nRbYe3MxYxM3Kj7fC0roxiv2D//KmLoZzZ01RBv2r09BR6d1JwC
         PTjjvjLOylhtmiwh5zfa4+MqPNTXgWSXCUwq16ss+WuDPxRUN6+vD4wOyvUnZe1e0gJr
         FXTQcGYVUjdjFzz0Yvb62zwc8j4PuNnnsrURKLnnNyJO7V6ze2VEEYt//q6kZq3bhCsQ
         hi0ASkXNLjFKdXkwD9PdkaUJfDyi2c8LncGn4AHXNWk6/XcIFE5thdnPeUNv8TPqsIdx
         0fIg==
X-Forwarded-Encrypted: i=1; AJvYcCWx9jqAKRJE5nbp5xhAnKnRL6eaR5+heXrbkbEmEQVawRDV4bClA6bfnnUoyj80Q58zyIm0l4pmXRmEdK63qPCkFi6lC4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJTL8TGzdOxEl/ijjwsx8yalb6d6A1IiRk0lJ50Rst0PIt3SE
	6mLvcDkQrsSyXfLYX02/UFdnX1wH2oNpcjao4TjkuFaB2KFYCwcveTqsNzGkSylXRQkn8SP+zff
	RBJbKE1zfTSMKIFXXoy06gCUXUJfosOqpVc6y
X-Gm-Gg: ASbGncsnTopiAcI0vtPAmKVLLAM6i6WON9d5afFNmbIQ/YwuAoCp+dUKBW62Hi9UDoD
	etwOcjKMYe5AW7AwULBLxNwkKTSdk7VeCj5dSrVcgpO/V7SQYrVh0SEyihtOuFIiDvqfYjZIOFu
	u35LJ/WRD4vUA8UJZaJuA2aQ==
X-Google-Smtp-Source: AGHT+IEGCJR9IA5jDMT2Of/TaTFQ6Kl+jhMbbHqtWzPYG+QuFj2lKMDW1yD44Tl3NdNB6jTiuM59Ql0Ux2XWfYO9+PU=
X-Received: by 2002:a05:6902:1b90:b0:e6d:f3ca:3e15 with SMTP id
 3f1490d57ef6-e703e0ecf38mr658467276.3.1744229981817; Wed, 09 Apr 2025
 13:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408112402.181574-1-shivankg@amd.com> <20250408112402.181574-4-shivankg@amd.com>
In-Reply-To: <20250408112402.181574-4-shivankg@amd.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Apr 2025 16:19:31 -0400
X-Gm-Features: ATxdqUEUOdbJE1FR-JWrcEMUFKxoL7rqK5e8WWf2cXUgc2Yd72xDgueuEkSahFw
Message-ID: <CAHC9VhRFBOC=cZB+Dm00cshwBSBaK6amv+=XFLPF0Bub0gHN+Q@mail.gmail.com>
Subject: Re: [PATCH RFC v7 3/8] security: Export security_inode_init_security_anon
 for KVM guest_memfd
To: Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	ackerleytng@google.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:25=E2=80=AFAM Shivank Garg <shivankg@amd.com> wrot=
e:
>
> KVM guest_memfd is implementing its own inodes to store metadata for
> backing memory using a custom filesystem. This requires the ability to
> initialize anonymous inode using security_inode_init_security_anon().
>
> As guest_memfd currently resides in the KVM module, we need to export thi=
s
> symbol for use outside the core kernel. In the future, guest_memfd might =
be
> moved to core-mm, at which point the symbols no longer would have to be
> exported. When/if that happens is still unclear.

Can you help me understand the timing just a bit more ... do you
expect the move to the core MM code to happen during the lifetime of
this patchset, or is it just some hand-wavy "future date"?  No worries
either way, just trying to understand things a bit better.

> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  security/security.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..097283bb06a5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1877,6 +1877,7 @@ int security_inode_init_security_anon(struct inode =
*inode,
>         return call_int_hook(inode_init_security_anon, inode, name,
>                              context_inode);
>  }
> +EXPORT_SYMBOL(security_inode_init_security_anon);
>
>  #ifdef CONFIG_SECURITY_PATH
>  /**
> --
> 2.34.1

--=20
paul-moore.com

