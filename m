Return-Path: <linux-security-module+bounces-1378-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57084D8E8
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Feb 2024 04:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25D41C231FE
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Feb 2024 03:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD183C6B9;
	Thu,  8 Feb 2024 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z7vS4RTV"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4302E847
	for <linux-security-module@vger.kernel.org>; Thu,  8 Feb 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362341; cv=none; b=CzsHkDxp/7z5hHv6QcjArZiM3AmN6rZEIWPyWy5fwduOrbfjDG+MVGetZJa+AJPMW/+OQ3yfGxYoCfPSnpz8528fV9QCYayEVB8KatIW7pwHWK8DWItAWhyHsPRyjxNtRS5MSApE8wXPWlQIv+4J5IzMP1YdFn+X+V/v7Fek4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362341; c=relaxed/simple;
	bh=KnkOJYA+ZF6Kmru0kx63nfEJhN73el2zwXpVdx/vkaI=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=OmbDx5V8oBsNQ+gAsh0uHwNyDP9EB+w34JTOmdORpjIFbmwqJZ9cMUNMDfuuhELpWjt4IA5H2UauDYItUwZwSc16HMipwWIukbVLScOc7f+p8Tb8JH7trXVRiKQMRDm1etfTVxXgyAhZtJcZ14rCm4pW/ORr2zdknU7+RYiHsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z7vS4RTV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42a8a3973c5so9758441cf.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 19:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362333; x=1707967133; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oNNChvp7enOHaGv67iirqEATQRVn6s2IBOKWY479Ikc=;
        b=Z7vS4RTV1ce08w4cwCVtDzIGU4FeXT5p1y9uI9jS5wZOA7e0z/TMjreynydFroSFk6
         e6SHQYCi010WedMqCS0roWlNds6qKlrItkkTrdRQQtk7UEqtu8KrRl0HP5NTdSNxV+Mc
         zT+Q41UO2jAKxo3nH+/Dy0tYOqQrxe6BGvjs3DEviw/M8Y4Rypuz7qmL5yjPDNPMjwG+
         BFgQe5oz/vyRONgUqKIMoVcZlryiW+zdE9LUboCxf1c/jRDKFXVT3RkbW3th4WffJpRE
         wRd/DuroXE7cZflZbQUPsgO+b01l21V4Tfl+cg7NUai43FYqKguI7EKuhK3tQ1xOv6iT
         VfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362333; x=1707967133;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNNChvp7enOHaGv67iirqEATQRVn6s2IBOKWY479Ikc=;
        b=OwppMdPHb00rQUgFefgAZlt3mCVpW5v4xipc7B2XEskvVxc789nXilSOYjcWFqxbjQ
         17CZKasT6By6NfkruAlbpDhBY0x5oGiOpoP66ucA6+06K2A0ZUmOV7NlktcrTyKE5prj
         48A6ZnfSiP2DCEzgb8laWfCH93H3CRCMbJqS981vviOhZvQ0o+lzQupZH5I25lIOBq+w
         GyjafTwWuzPkxr7NlZF3/YG47G1BZa7mux2Z7A242wBS+LclT6L6m8T1xuxhvLZfDfp9
         XVqLoh/R5Pcnoloj6lVMR2YrXdQ6XGYn/nIfOaMCBk3MxNTCeGx6c7lIwEm6jE15gg6m
         +Z9A==
X-Forwarded-Encrypted: i=1; AJvYcCXDe9IKBIAeT8mdOvUlQMeUpN/W3dch2SzjqUvi9k9OehwEIokTRVGIWsgQfFZo27RVzBukUfNGk69B6fj5146jQx2VVBSE0zbYXKbZBd22P1Zcs1l9
X-Gm-Message-State: AOJu0YwyUfCq1mPqgGDWNym/9nL4Iej3EYA2i5mDNJyNhA/k2nhkQIMX
	NY8mZ1Wa1pSFYZBhn18s9l5aLi1H7G4MIc4cGQiE39EP1DL/4Gnp3BCbUhBINQ==
X-Google-Smtp-Source: AGHT+IHKo6eVNG3Lrb+TDrtEaIoKPGMvwW5MO9vd3s2dXKXoBInyKIDGRzELkkkehv63exQOcsZctw==
X-Received: by 2002:ac8:598f:0:b0:42c:3a06:8b86 with SMTP id e15-20020ac8598f000000b0042c3a068b86mr7365879qte.28.1707362333523;
        Wed, 07 Feb 2024 19:18:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+MlBOyTBXqYsiBUBCbCTQYgv9WrzN1WRMZFtdN7DaHfzyvziQLgUKZwi5r49UoaIul3keNp3G6d5WVnePnjnZq54XB877kwKSpQg2RtUZs4elW9Da/UBkitCLGyILr8adts/F0Ms67geTKWcnl8VyalaKstNF/xnV9zpTWCCmJAGzHH6UUuIrejbZAi+oZY5kGJxIxQF2msrb5rmhWBboiM4ABTNVYVLGx5tw5Jh6OKb3mJJRUmOGwWEoGZSd93GYk5hFv6deuwPUUt1bCwK4cBTLsGd4VPkfln4aX2R/YC4dLHw2PJBkfCI3lt/JriG5PtDTx1xwEpt34uNXDIM43pzdBP1IWlrs5CotTEqgfx9BHYCXJv5JaTjV5zI5Sjy5b3hxUXKdlqEJknjJ3usF6g3C4d91FxU5RSY8d4mZVZv+V3RXK4IOr2LQqmzOrktf+UTnsMjVaLt+9ZC3TK5XFVsXyfYFQfueCGxxkrGUqMeLxXFICO1y1et26DJRgepQOlG+7m8OcxHOuYWd4wAln/OA6k+hMEb0IB4iQbCvZy+YfC2eF8bmGeGSLDUZvlfSg8d6VnwmfXy0WjQTeJKuXR7mWs32UoIBFAhGK+VYiXZ4SKluiK327/qSzo2NkH+tChnJj20FTG5QqgSAs9RBwsEeUmJuFwle0hRLadYXvcjXGfUBwMrwxsv/v3DvWULzRmte7ly/R6a8VTZlFhSiZyQMUi40bkZ7LEIBh6PwjaTZJGkTDmb9dg4VLqVFIhWqescVHhQnEu+9qk3F6lMubdHcQ1RbCpQQDq7e71QomHLmKUssrSTGooO6irxrT+XcAhe5+mtrU/XJR7l3wkT24MCfSJTuGqN800PqsahxbuT/HQW3NnYrwpMMjdckerq5ypm/rsizhlcIC6h5sII6Zs8YqfoDZaJVrppd5+TDUpZm4ejzjCwyIk0+JdV9h8bDaa
 Rl1yci/c5GEho=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f8-20020a05622a104800b0042c46268a33sm606763qte.12.2024.02.07.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:53 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:52 -0500
Message-ID: <9c2caad915fc512b6d37173008a2e189@paul-moore.com>
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
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 21/25] ima: Move IMA-Appraisal to LSM infrastructure
References: <20240115181809.885385-22-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-22-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> A few additional IMA hooks are needed to reset the cached appraisal
> status, causing the file's integrity to be re-evaluated on next access.
> Register these IMA-appraisal only functions separately from the rest of IMA
> functions, as appraisal is a separate feature not necessarily enabled in
> the kernel configuration.
> 
> Reuse the same approach as for other IMA functions, move hardcoded calls
> from various places in the kernel to the LSM infrastructure. Declare the
> functions as static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm().
> 
> Also move the inline function ima_inode_remove_acl() from the public ima.h
> header to ima_appraise.c.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                             |  2 -
>  include/linux/ima.h                   | 55 ---------------------------
>  security/integrity/ima/ima.h          |  5 +++
>  security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
>  security/integrity/ima/ima_main.c     |  1 +
>  security/security.c                   | 13 -------
>  6 files changed, 35 insertions(+), 79 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

