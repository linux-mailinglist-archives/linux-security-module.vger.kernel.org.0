Return-Path: <linux-security-module+bounces-1197-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B818F842F4D
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Jan 2024 23:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6464E1F24E71
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Jan 2024 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A77D3F7;
	Tue, 30 Jan 2024 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JgpVZbOe"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9897D3F1
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652117; cv=none; b=j3by9/JXS7CKB28nBGGSAv6+V+KbnLfxNVRstFeiNYWBIRPhPtvk/wxvPkYZTqWTcpis5Jc8eMef/WVZfpbHcNF+5HzUVU33cAFQiSeYOziZHNxlLz+TgnvwWVt+wc4xwYRGDx4Qv6/UsASFpu1GRlfmYPlNjl0nt04UZi9TpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652117; c=relaxed/simple;
	bh=8uMO6B02+AD8sLC6USewf0MBwVf4V+mjoV2SSnFkBoE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=qciN3GQpDN9yqZh/vi0qIi/MEucg4Tk+xjhGJUSQq52Z279RTkD4mlnNiKZZdgr/5lhkYZ5dFTxuuyr5Tlu97XtnJkwqOQ9/LfbC9afwZT6PUzFMyMF0MmcyNhnD0b3wscUJvrHPCiLlSO2FSNUEni1q83rxknVP+BXJO/7IXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JgpVZbOe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a8a399a9fso41457721cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706652114; x=1707256914; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hCYW9bndHQiq0uckPtexP3iYl/xNpPGK8u4hV2m/bZw=;
        b=JgpVZbOeFT9krPazHRitYBlqXRSw1YQ1RC5UR4A8c1Ek4wBl6evOh+aiN1xJWTq35+
         Q4w8/HiKN8l8VuYjFQ8siXnxIf5Ls8+YN1KYI8Ad0IGacb5uTtAIz39EFJT3/uDHVyoC
         mvUD+CkxkkO4UvqD7Aj0FnDGksmPFLCEG/+DFL/3U7tH9JPdMllz5cr5cDadX89aYImo
         nezt7mMPix4/inh7241kG8B8E+LL5q1YH1l4wiobmFTwc7SFycnWQmbQBSryP05H3JG2
         lf8VoyG9XVLDM8C7J27H5kWdjt4RDHDORCCJ2YJkxzNMtoaFoE8YFATpSmDBSlAHY2pX
         PcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652114; x=1707256914;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCYW9bndHQiq0uckPtexP3iYl/xNpPGK8u4hV2m/bZw=;
        b=MKlYVBpWWY0JIdn157wFtBFWEHhOopWs66prdUVVOXnkzbIW5674KjAsSbR1xeruLA
         q2Faq4iu+i5zq0F8ljd0ldnCsg2U6oy2DJNidmuizeAXLL79gYVKYHayZovjjTudMydX
         89J62r4FGKKc+wV5r9BPJOxMounddKvv7J3d7K1ORuigX8zdrMWWzxrcEe5N6+61Oy8o
         G0lZtiCB/trAUMxdncEbC8MLy7h1zZvRs79sugQEr+aYQ3eoubsSU4nyJco9VV8Tkx99
         DTMZ/jdgAjjr8hN759wUlkF2hJaFlL1vSHIB++nv15sBidDrmIyAYmaRi68DxCq2Wuqf
         sd3w==
X-Gm-Message-State: AOJu0YzdsG3ErXRd4EkVDPeXmH+ZzObIaOZnjgVzsVp94d+gvYjPWNPf
	ncXp5eKU5zFJi178KAf+H4RwkIzFSf64DjHIqsRaU8HPQQYJw+QOYYxT4T3KTg==
X-Google-Smtp-Source: AGHT+IHd1lk/WE/eWdeb3yQdZyCSf1Lum/tTB1mzxUgDj05NzwEhXkIspBc+yXDwCYnwnMyiu0/DyQ==
X-Received: by 2002:ad4:4d50:0:b0:68c:40d2:2031 with SMTP id m16-20020ad44d50000000b0068c40d22031mr6214112qvm.19.1706652114522;
        Tue, 30 Jan 2024 14:01:54 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w15-20020a0cc24f000000b0068c55087a1asm1834068qvh.74.2024.01.30.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:01:54 -0800 (PST)
Date: Tue, 30 Jan 2024 17:01:53 -0500
Message-ID: <4af3b3fce8fed039ffa0526549db95fa@paul-moore.com>
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
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] lsm: fix default return value of the socket_getpeersec_*  hooks
References: <20240126184531.1167999-1-omosnace@redhat.com>
In-Reply-To: <20240126184531.1167999-1-omosnace@redhat.com>

On Jan 26, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> For these hooks the true "neutral" value is -EOPNOTSUPP, which is
> currently what is returned when no LSM provides this hook and what LSMs
> return when there is no security context set on the socket. Correct the
> value in <linux/lsm_hooks.h> and adjust the dispatch functions in
> security/security.c to avoid issues when the BPF LSM is enabled.
> 
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  security/security.c           | 31 +++++++++++++++++++++++++++----
>  2 files changed, 29 insertions(+), 6 deletions(-)

I was originally going to merge this via lsm/dev, but thinking about
this some more today, and considering the other inode_getsecctx() fix,
I think this patch should be marked for stable too.

I'm going to merge this into lsm/stable-6.8 and assuming all the tests
come back clean (which they should), I'll send this up to Linus
tomorrow with the inode_getsecctx() fix.

Thanks all!

--
paul-moore.com

