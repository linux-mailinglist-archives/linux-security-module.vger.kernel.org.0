Return-Path: <linux-security-module+bounces-8553-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59165A542D3
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Mar 2025 07:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8118816BBA9
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Mar 2025 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2A19D090;
	Thu,  6 Mar 2025 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkXkKx12"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CB19C554
	for <linux-security-module@vger.kernel.org>; Thu,  6 Mar 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242934; cv=none; b=CaVAjd3LZeuCmSnS8OcANyiDVNBinkhhPXpskJL2yg3+Cf7Oi1kCCQhWunRIcU2B7Wj0UhvLq8sSqxLAWZbrwBWNw/BV91ZYZ9e2u3bTuE3oCPoMm+VbSfBIWV3MspNm3HOAY9enNPRFyXT9b3GZzlt2mRVZ1+dUDLBmowiJDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242934; c=relaxed/simple;
	bh=OgVi8LZ/avO7r/TihguE885iMoKtcusZUL+VQwbS8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hGHY/YE46NebRmjC4F084cob+VwGVvO0FkUakupD1Qi/GYvh38xGSwmba2uXvp72QXQ3tw5aA90rUtAbMIj2zddv/JnF5NuqC0mTxLuNHAjYGRDUVMr9N2Z9Yt/DQuQYhzuCNSyj4awduiONqbctFT9tGP0MGwyZxd7tMTmXIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkXkKx12; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc38bb6baso1214995e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Mar 2025 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741242931; x=1741847731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=NkXkKx121iIVwRfnvL2NV5bLufVR3G63SPc2p4TvkVzVlrqSAO8fwb7sdoMK0GT32C
         ilASo1O5JK5ny5ODedT2PQkBlTEz9WDqL3Uw3WLQIupKoBZxhobysE7kPRTQY1s9kqa0
         rk9rvPMv44zRlZlAtGDG7EGQo/5pLiwA8PvxRhYa/g0txZI2zYLfYnN7xk2WsQQZvLOT
         Vy0eQ+j+Ktk57PekxQCGydsr068OdVmEtWspEdI+gb60MMdV+jfL1SZEn8lDPMasLGpH
         keu9Rve6CedfwPt/S7sg02dFwD7XQyy23x+MZIoajVllLg+CMTeADiVW/3vHx85yVG83
         LgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741242931; x=1741847731;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=DVP4V1qXrso1QYsm6msaCFzs3FtY/sXXDnc/tmTJlyji+JjwowQPpa5q348sb8USwn
         kgAoEa9hDnMXHY/HR1cGJDt2KvmpfGNrDJfVig5otLF+8wzxWEu85wFVJFcI8kptdtGx
         nyDYAoyR674VBFnWyH05jgEzC1RPOZfRfKFnCT1yVYxhbbjTJ870rGfeozF6cXBwymBV
         MjbLJ2nE5x3PKTtKGMIsZ2C4+IXDrMT04xYdV76A2LEdacZ2+yaj0NepSiO+W4P2QphT
         joRqsfEu/t5jdqLBsU45gPDuXgaLxr7c5pFNnqsh6/qiNEGblIlkXuR8T2pKaan1YtWn
         m+RA==
X-Forwarded-Encrypted: i=1; AJvYcCWxoluW/nOXcQBLr921pZnfMKOf+tfkKRIQMxiIJ62jRatfBIIyY+cp2L/cIBVlCLQbHT0ypOqA21Y/fGt47HOjK9dgQGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iMYGvYN1Tlkv6F3Zs1EE9dkRnXQBXj0Rr1KgIaswL7irW3Vv
	g06Ofuo5nk5WuKuCOKghpj8p8O4Nf1MM5Bq55vWjAum3x+vWNzhabCbENV2/4bM=
X-Gm-Gg: ASbGncvA8mLAHgn6OP3x5jlfTV0rR6hAa2IKk9Sy9DkT5nxwFh3PNJXbQG2DWFiQmkz
	iGPEthocPk33fJD9df6zjf2EtiCsK1cKP8yzwcrS2MBJBkh/cKsy0NEkbYXInsVuAJyNlaHFuC0
	viFXYRLgFuD/z0Tc4/IxR88/mTL2ymj4DrWUxpH48mw3lWiWP3EzgXrbqBIDimuDyoMFJCIUyrb
	l6Ei3JNH5AzDVyeulJd7WAWf0rfxt5AhRfOwaHLv/4n2X7VBimmFGghOldoQQ7HWOsyR04VkMt2
	QvPDx/Tqmmr1Fwi/k+S0HTxIfnATbqiZoA/hedIbVVye952U+Q==
X-Google-Smtp-Source: AGHT+IEldEFBJ6GcJ/9AsmwidDi0MW22pFoTiX1DY3pYgmQW8PLpDd7QMPBO5UsdG2P8Z7W4b9nJlQ==
X-Received: by 2002:a05:600c:1551:b0:43b:cb0c:3556 with SMTP id 5b1f17b1804b1-43bd2af49cemr38379685e9.28.1741242930569;
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c314asm9415525e9.10.2025.03.05.22.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, steven chen <chenste@linux.microsoft.com>,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <7bde870f-07eb-48a6-8b8d-edac57640775@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-3-chenste@linux.microsoft.com>

Hi steven,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-copy-only-complete-measurement-records-across-kexec/20250305-031719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250304190351.96975-3-chenste%40linux.microsoft.com
patch subject: [PATCH v9 2/7] kexec: define functions to map and unmap segments
config: x86_64-randconfig-161-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061449.gbVGafZc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503061449.gbVGafZc-lkp@intel.com/

smatch warnings:
kernel/kexec_core.c:896 kimage_map_segment() error: uninitialized symbol 'dest_page_addr'.

vim +/dest_page_addr +896 kernel/kexec_core.c

bf06eab7ae0f04 steven chen 2025-03-04  870  void *kimage_map_segment(struct kimage *image,
bf06eab7ae0f04 steven chen 2025-03-04  871  			 unsigned long addr, unsigned long size)
bf06eab7ae0f04 steven chen 2025-03-04  872  {
bf06eab7ae0f04 steven chen 2025-03-04  873  	unsigned long eaddr = addr + size;
bf06eab7ae0f04 steven chen 2025-03-04  874  	unsigned long src_page_addr, dest_page_addr;
bf06eab7ae0f04 steven chen 2025-03-04  875  	unsigned int npages;
bf06eab7ae0f04 steven chen 2025-03-04  876  	struct page **src_pages;
bf06eab7ae0f04 steven chen 2025-03-04  877  	int i;
bf06eab7ae0f04 steven chen 2025-03-04  878  	kimage_entry_t *ptr, entry;
bf06eab7ae0f04 steven chen 2025-03-04  879  	void *vaddr = NULL;
bf06eab7ae0f04 steven chen 2025-03-04  880  
bf06eab7ae0f04 steven chen 2025-03-04  881  	/*
bf06eab7ae0f04 steven chen 2025-03-04  882  	 * Collect the source pages and map them in a contiguous VA range.
bf06eab7ae0f04 steven chen 2025-03-04  883  	 */
bf06eab7ae0f04 steven chen 2025-03-04  884  	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
bf06eab7ae0f04 steven chen 2025-03-04  885  	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  886  	if (!src_pages) {
bf06eab7ae0f04 steven chen 2025-03-04  887  		pr_err("Could not allocate ima pages array.\n");
bf06eab7ae0f04 steven chen 2025-03-04  888  		return NULL;
bf06eab7ae0f04 steven chen 2025-03-04  889  	}
bf06eab7ae0f04 steven chen 2025-03-04  890  
bf06eab7ae0f04 steven chen 2025-03-04  891  	i = 0;
bf06eab7ae0f04 steven chen 2025-03-04  892  	for_each_kimage_entry(image, ptr, entry) {
bf06eab7ae0f04 steven chen 2025-03-04  893  		if (entry & IND_DESTINATION) {
bf06eab7ae0f04 steven chen 2025-03-04  894  			dest_page_addr = entry & PAGE_MASK;

Is the first entry always IND_DESTINATION?

bf06eab7ae0f04 steven chen 2025-03-04  895  		} else if (entry & IND_SOURCE) {
bf06eab7ae0f04 steven chen 2025-03-04 @896  			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
                                                                    ^^^^^^^^^^^^^^
otherwise this is uninitialized

bf06eab7ae0f04 steven chen 2025-03-04  897  				src_page_addr = entry & PAGE_MASK;
bf06eab7ae0f04 steven chen 2025-03-04  898  				src_pages[i++] =
bf06eab7ae0f04 steven chen 2025-03-04  899  					virt_to_page(__va(src_page_addr));
bf06eab7ae0f04 steven chen 2025-03-04  900  				if (i == npages)
bf06eab7ae0f04 steven chen 2025-03-04  901  					break;
bf06eab7ae0f04 steven chen 2025-03-04  902  				dest_page_addr += PAGE_SIZE;
bf06eab7ae0f04 steven chen 2025-03-04  903  			}
bf06eab7ae0f04 steven chen 2025-03-04  904  		}
bf06eab7ae0f04 steven chen 2025-03-04  905  	}
bf06eab7ae0f04 steven chen 2025-03-04  906  
bf06eab7ae0f04 steven chen 2025-03-04  907  	/* Sanity check. */
bf06eab7ae0f04 steven chen 2025-03-04  908  	WARN_ON(i < npages);
bf06eab7ae0f04 steven chen 2025-03-04  909  
bf06eab7ae0f04 steven chen 2025-03-04  910  	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  911  	kfree(src_pages);
bf06eab7ae0f04 steven chen 2025-03-04  912  
bf06eab7ae0f04 steven chen 2025-03-04  913  	if (!vaddr)
bf06eab7ae0f04 steven chen 2025-03-04  914  		pr_err("Could not map ima buffer.\n");
bf06eab7ae0f04 steven chen 2025-03-04  915  
bf06eab7ae0f04 steven chen 2025-03-04  916  	return vaddr;
bf06eab7ae0f04 steven chen 2025-03-04  917  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


