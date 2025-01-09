Return-Path: <linux-security-module+bounces-7550-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A7A07C53
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Jan 2025 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D167A0556
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Jan 2025 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075A21D5A7;
	Thu,  9 Jan 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="LAye2daJ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507082206B0
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jan 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437541; cv=none; b=Ml/qRrnb2Y/vXAii8UMG05l8MMfB9Pd40PMaYGSoibE7rPjhpEljZSZztNCU4hyTlVAkcd0OZfWVjl3oUj8YUU/6tF+qXVlbKjfwB6saqTormYoyMpipPRS+38ENPGw01vLQ5HtzjoKaLyaUnLLpgzaxfrMlA2dQ7NAArN+/yZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437541; c=relaxed/simple;
	bh=2brKe+BKxputZorOKd+f+yIxImiCIbAyHwtB6oU0kzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sktw6fVch4gguzXDUkoKMdi3kRFYfQ3yHDkb8DCrs5WzfFeAswHuRY3O02fzk+ngXbib6GebMfv8qHLQhM+M3zZtXJGSyI6OIk4JU8AWi3CIfg85tqR2PETTTC4RZWLI2N+3+E3lFppoly+NnVt9p1tT9c+AjKzB71lrcH3JCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=LAye2daJ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7231e2ac9e4so80753a34.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1736437536; x=1737042336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgTp2x21PamB5G5tjbV3jPSQRWSgTUkiJmrzV93coW4=;
        b=LAye2daJq5PwQO2M4vRRKi+w4NVjhkO8A1Wp9+fmpAvIYQpxbbPm2/sSwE6ZLxhooW
         maYs50vYWHQFpOrOTOU+2y3kOH55RHtnfTl5ES/LRP4wpLUEktnImIIxrVau3NpkQ5Sx
         0H4cY0tm0abQxDpDy4NZDgUQYo4DkVO0zHE4y36LKCe0OwmC0uGzpqOtVtIEoqJnk0PQ
         +KF9lKAQGvRkGRMamUgcdSDIky+rblo4w996rzf2CTyadN6ruP9ME+3dklYWXs/EN0r9
         pCSV3eAmn9ZHv74vRR+RCW+u0QbvFD/8Db1aotCdSLy0Cy6PjBLBt7n/ndYrUjPk5TBF
         rmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437536; x=1737042336;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgTp2x21PamB5G5tjbV3jPSQRWSgTUkiJmrzV93coW4=;
        b=PDSp9LNedun3vmz5USjkqpLNXdN4FiHE7jdgxXLqmY52NYNkfICjKhSkHUkXowsh5v
         yGKCNhbawj/IbUVFGB8l4Y0jkxjjLEOpRsEeawf7APu7zevQe2ETUCr4/2uPoFPCIXj5
         QWJSjAgPDWdGMuKsv49edODwUkx+ARm8gFtBT2WUiGdS872yH2zR9KkfjSdIwTagby0a
         BQuDarDmQGxgba98coqzyOZDxpcGrqWXNQn70AlneyDRSGXnKdqQCTChRAgXiJE5Vcax
         XzKhrEsVS/l+0rhDUPg7hNeZnJJrO5JIIPXY+engv6uV8l4384znm6t84SI5KchWtaZ3
         sXGA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/LowoX2kUN1G9GsgCDIFymBak+8td848PHyWGeD2ebFqjC68dnjEzpWAlxAdhHpfJVsa+3LMEw1RrCGeVtSiwTn7JJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2gWOinxHJyp31m2FPA+QoN7NRE+GueZNZF/DfOZKRE2rn11t
	SEummKXMvk0HCSMFrPHETkwoOopkE8iknG6fOyj97vSyaHSlwPGwz9VU6l3rvnM=
X-Gm-Gg: ASbGnctA62ZTDcGwc4wTOtkfWhq3Yx5SpyzGypAbYNMdGgl4JjKZlfU6KfbhoTmyxX4
	Paqhhk/QxKNTJAAIfdkPtroxwtWBtX+4c5senBbxrTwwpMIPJTjralCOjVgkOq1EX/DvDSn5Waj
	1T9B2HDWBgqDuemdo+Pdy0DyVyrghsPqjAPkASs0OsJP/Wntpt3QMkAvyiR7Ntl+l50H0vymJ1K
	fqkWd0L0MHudbOAIN7O8uy5flwU849pO36x5WZ8P6G80cdL2FXevd5epst+
X-Google-Smtp-Source: AGHT+IHELUnxP9ZvL+e2Ztemz39I9ORoPYZLTVwEa+XG73J5uz7w7yM0cuXu9KZqTaUsGk+1/+jmGA==
X-Received: by 2002:a05:6830:6610:b0:716:a95d:9ef with SMTP id 46e09a7af769-721e2e000d6mr4949630a34.2.1736437534534;
        Thu, 09 Jan 2025 07:45:34 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:9076:47eb:1e0a:16fb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882625f0esm386258eaf.9.2025.01.09.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:45:34 -0800 (PST)
Date: Thu, 9 Jan 2025 09:45:27 -0600
From: Corey Minyard <corey@minyard.net>
To: Joel Granados <joel.granados@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] treewide: const qualify ctl_tables where applicable
Message-ID: <Z3_vF3I453flXoZv@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>

On Thu, Jan 09, 2025 at 02:16:39PM +0100, Joel Granados wrote:
> Add the const qualifier to all the ctl_tables in the tree except the
> ones in ./net dir. The "net" sysctl code is special as it modifies the
> arrays before passing it on to the registration function.
> 
...
> diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
> index 941d2dcc8c9d..de84f59468a9 100644
> --- a/drivers/char/ipmi/ipmi_poweroff.c
> +++ b/drivers/char/ipmi/ipmi_poweroff.c
> @@ -650,7 +650,7 @@ static struct ipmi_smi_watcher smi_watcher = {
>  #ifdef CONFIG_PROC_FS
>  #include <linux/sysctl.h>
>  
> -static struct ctl_table ipmi_table[] = {
> +static const struct ctl_table ipmi_table[] = {
>  	{ .procname	= "poweroff_powercycle",
>  	  .data		= &poweroff_powercycle,
>  	  .maxlen	= sizeof(poweroff_powercycle),

For the IPMI portion:

Acked-by: Corey Minyard <cminyard@mvista.com>


