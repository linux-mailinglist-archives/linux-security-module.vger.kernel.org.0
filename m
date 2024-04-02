Return-Path: <linux-security-module+bounces-2481-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99188948BF
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Apr 2024 03:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4B283155
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Apr 2024 01:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729213FF6;
	Tue,  2 Apr 2024 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G4lN+Yma"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA060E567
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021210; cv=none; b=sKtc4pvMuVjzjyTmIeZgohcIuxAOxmYVc/6yiqsM2cNVmC3taMGS1paXOdNOfWq5H9I69Yxc9LA/6imSAohA8tDdyBTF84MZq0cX77vz9PIu59JpqB7OaTfovPazn+mNp3jiAUjwdar7BgWWI1dgyJdEfrQ5qugLliGgF62BaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021210; c=relaxed/simple;
	bh=WqrYHc1OrW927dxpv9fTrIBfKRqR2NBvDdcY6XIS0bs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=eIAeD+mGQ4Zwpowl1CTZKQc8QeD+3VeJfYrs4wp35txchmVhQQ/mck7iknw4AH+X6i8EOLmoK/6yINGQPWZ5LwsClhPrfzCtZtr6tJGTA3ghQSeGzZ+YAim4NU/eFRgCzdDsdfakqg+hNdGzeXAPfYhw3GLivUfChyUNfSrfbZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G4lN+Yma; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-432b72c706cso35467171cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Apr 2024 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712021206; x=1712626006; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRws9YXLN8yb7zuQUc8CIutzWgp4avkTPI09HZCU6cI=;
        b=G4lN+Yma1v3mXG/SF+E4Q4Vmtq9IXlAYYEGNzQXsfUcjzmflAs+JTdgx6LMlAIFL9g
         HDlwt0Akkidq+vZKEYCuIM8jG6PdXrvmlZSZvYvCuuoFw+UXnJWjIQVzVoTaPmseSUjB
         drYQtYihg223VfBX5smeEnjs9qy+vAJ0lPjCvzSMy/HoNWd/TZEAO8q6QRngJdOnp4EN
         9xaNBt90oS9blyJa/pJykeOXUxR6rsO8BLXsKDz6q/rxfL+/lA7UkmJHT3RL6kelYr/t
         eRDPrIDjF8MoOn/FpM4kB5PBwj/pbnZQyNAOl+U0vdT69ZGIZF0SqDAiL/yIpoyYbrEx
         8StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712021206; x=1712626006;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRws9YXLN8yb7zuQUc8CIutzWgp4avkTPI09HZCU6cI=;
        b=Q8uxhsjXzc43FSZ4a/FNYIKqv6x9HlsWrJafDbb30z92HvHuqsuK4gAt5wSgnMpRYd
         cU6iqK/KlwPgQPEBn/IyB+RkHRRIEIp6k29VkS29IsjNAAIBIpmBC36xrDWhW2mHZRpt
         bPPb6CWu0YQZlB2C4rvE7Xxzc6n/UN0xJaEYOGOyRQyAFiM9zstR0fNecqfitNsax4Rx
         pE4aNwQD0a5MIIPDIz0kdlxhnapGYqZl3FZ7HXLqr1/Iltm1IeFRJfstWejdiIvmPPRN
         DyB0um4dr2zKZIvliIQqJCHayXiqqprd49QKEe9IdVwcidh3Du/XpHtm8U/spXvS3QSy
         UauA==
X-Forwarded-Encrypted: i=1; AJvYcCXnSU1eNCKgUDf8x/SlkWRXg7r9BpAvVmhHy1W4BKsqRIUC03bKYeSbqfQYMq1ESKeYs9NYkC9qPCYIMI5rh3U2l8Wzf26rvH3gu93gERvvUABXkrbW
X-Gm-Message-State: AOJu0YxOUw+BNUxx/bpCjSUICsUVOSVsoxztqNaA2KaY6+GyePnovJqQ
	Qoiw2/tiK9EyYfNuylzF7anbGN7aPL1CB9eovP60q5MmfdyoPn5X655++NznHA==
X-Google-Smtp-Source: AGHT+IFZ7SasfMMYh5vB3j/xGXqf/TCs4Bcif8z6dD6zV7+EZAG39P9HJEPaE4K4Urz2UW0TPzSDug==
X-Received: by 2002:a05:622a:4b11:b0:432:de8a:3a8 with SMTP id et17-20020a05622a4b1100b00432de8a03a8mr9661426qtb.18.1712021206548;
        Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fw4-20020a05622a4a8400b00432bcd630c8sm4405470qtb.93.2024.04.01.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:26:45 -0400
Message-ID: <7bc35832c837a23773424bdc2255808b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v16 15/20] security: add security_inode_setintegrity() hook
References: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>

On Mar 28, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch introduces a new hook to save inode's integrity
> data. For example, for fsverity enabled files, LSMs can use this hook to
> save the verified fsverity builtin signature into the inode's security
> blob, and LSMs can make access decisions based on the data inside
> the signature, like the signer certificate.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> --
> v1-v14:
>   + Not present
> 
> v15:
>   + Introduced
> 
> v16:
>   + Switch to call_int_hook()
> 
> ---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index b391a7f13053..6f746dfdb28b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -1020,6 +1023,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
>  	return 0;
>  }
>  
> +static inline int security_inode_setintegrity(struct inode *inode,
> +					      enum lsm_integrity_type, type,

Another bonus comma ...

> +					      const void *value, size_t size)
> +{
> +	return 0;
> +}
> +

--
paul-moore.com

