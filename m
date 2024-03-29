Return-Path: <linux-security-module+bounces-2436-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC78923CF
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Mar 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33E2B20F73
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Mar 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1312D1E0;
	Fri, 29 Mar 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XMtqpnJl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363685629
	for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739175; cv=none; b=OdY6ue7G8oiA0Vuwh6f5xBtb7UARLukClFWHoTtIe58hkQsloGKKEz9bV5LwJedRDdQVgNZKYdpZFDCgODpZ8nwqwmXlCvu5rGnt/YXVmko3Mevs9mDFhxLIkJ6GbGVa4dVfCutvvQFgCnoz12Ns7YH22QhrGJnryImsG8t+frQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739175; c=relaxed/simple;
	bh=J1DnffiH7q17Ljk4EoJuar60KYgEYIZ86jt5q9jFPTs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=IBU9EOJRse8Yccg58K83jDNtsaTg2k0i2JfSXBLpXm914NZssN/NrfnSgYLjSVmZwGQaQ/GnFk3xUKYmn5IF10STxKsCWn9Rjr0wI99Cnc4sdfqZ//qU2Xeol1qWLqbfpmcQlVu4uI3ZuEPvQpucIbDoQuFrAvnkhr0AlQgiDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XMtqpnJl; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3ca3c3bbaso1304092b6e.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711739173; x=1712343973; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ngxCoYcD8CKtcpra4a5XtcaeUNLXz+q15qFr+qZs8O0=;
        b=XMtqpnJlbdM0j+X3obvgo072sm1YNcTIsbgSVToZhIOhXnlDF/qvD9WqnY+fTe/RIA
         NyyXaoK2kmfPZ2pnxHS0VgDqfTAbfG+lO6VbJzHHBbgPkTRAlsR8TTt1AntK/7v8WKzg
         dijuzz/oXEKbKBM3FbH8el9QHIxYPUkEkKTbQc9MPPIirJKIEKo8Dq1Z/bqtpdetpzz4
         FDeO560jDoaulV4l9OjVo2/EFTNhtN/vhnaeKSRE9jDUJMJaQkxT3CT8Ll7lI+BI+yEi
         yYahCAGFqUFtRrkERAuj2sdpbv56kEU7OV0iRQhqeNgswHXk+UapTtKWp9+2Mp6ElTeI
         5MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739173; x=1712343973;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngxCoYcD8CKtcpra4a5XtcaeUNLXz+q15qFr+qZs8O0=;
        b=FhY1nVsuYAhLFvX+gpbFldR4kYlBp3qc+eILFfZPo6/p/bh5pPjPoJObS/g9zhublw
         3v8A67oFWl/Iu9uyt4Bi1Xe87BjD37goHdbx0GFaO4aq9w2Avre4ie9YaWPEh65GGwlM
         i26Qtw35g3Uz56ho2RWoFREZ8aNlR3hzwS2ps/6yZnTgEHFi1zwuuxjizHVe1k3yKDN/
         onaVYWfIWgitasUJh4vpqeqw1cUvEgJKJHMp3GlJkKWxxT/miyE3DfbBKI32Moo3D/aZ
         ymquJRtnHy0s2ojh6yuC4BrRmsL8hGKQHl1Y/Tx+L0vcRQctz7AdCmLbAXtscPi0SUSF
         pSiA==
X-Forwarded-Encrypted: i=1; AJvYcCWH2M3NHRDUvHbnuFD/5fdHmtD62ztL7DTt425bhOJI6JJx7n5xqc7HIWwxjeM8cVjzXuxXjpSz21RUmpz1DTJEQd0XHDcE0wo1txMhDhnUsd1uyZRw
X-Gm-Message-State: AOJu0YyNCv1MRSkCKmd8AmufBOLvIHpRsYQNpygoUvHGvHlUsyvcgGgh
	QPeZW7AXvCPhsC3BrgYds42f2Kq+15oNkMJ4wVTI5/XotK/DvsphFEoxJuf1Og==
X-Google-Smtp-Source: AGHT+IG+UKRYPfBfwkIx2mRuJVrKfyVM3kzyBoi4KCb9PZ1DSrfPB2oveVG4Zp7kWZLQY+SYaX983Q==
X-Received: by 2002:a05:6808:1156:b0:3c3:c2b1:173d with SMTP id u22-20020a056808115600b003c3c2b1173dmr2965700oiu.58.1711739172886;
        Fri, 29 Mar 2024 12:06:12 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6-20020ad45ba6000000b00696857c49afsm1880416qvq.67.2024.03.29.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:06:12 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:06:12 -0400
Message-ID: <5ef810071fbdc40451e2b2ea1920da09@paul-moore.com>
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
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com, christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org, Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 1/2] security: Handle dentries without inode in  security_path_post_mknod()
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>

On Mar 29, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Commit 08abce60d63fi ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call to
> ima_post_path_mknod().
> 
> For symmetry with security_path_mknod(), security_path_post_mknod() is
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.
> 
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
> 
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.
> 
> Add an extra check to first verify if there is an inode attached to the
> dentry, before checking if the inode is private. Also add the same check to
> the current users of the path_post_mknod hook, ima_post_path_mknod() and
> evm_post_path_mknod().
> 
> Finally, use the proper helper, d_backing_inode(), to retrieve the inode
> from the dentry in ima_post_path_mknod().
> 
> Cc: stable@vger.kernel.org # 6.8.x
> Reported-by: Steve French <smfrench@gmail.com>
> Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Fixes: 08abce60d63fi ("security: Introduce path_post_mknod hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/evm/evm_main.c | 6 ++++--
>  security/integrity/ima/ima_main.c | 5 +++--
>  security/security.c               | 4 +++-
>  3 files changed, 10 insertions(+), 5 deletions(-)

In addition to the stable marking that Mimi already pointed out, I've
got one small comment below, but otherwise this looks fine to me.
Also, just to confirm, you're going to send patch 1/2 up to Linus during
the v6.9-rc1 phase and hold patch 2/2 for the next merge window, right?

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..455f0749e1b0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1801,7 +1801,9 @@ EXPORT_SYMBOL(security_path_mknod);
>   */
>  void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>  {
> -	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +	/* Not all dentries have an inode attached after mknod. */
> +	if (d_backing_inode(dentry) &&
> +	    unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;

I don't know how much impact this would have on the compiled code, but
you could save yourself a call into d_backing_inode() by saving it to
a local variable:

  struct inode *inode = d_backing_inode(dentry);
  if (inode && unlikely(IS_PRIVATE(inode)))
    return;

>  	call_void_hook(path_post_mknod, idmap, dentry);
>  }
> -- 
> 2.34.1

--
paul-moore.com

