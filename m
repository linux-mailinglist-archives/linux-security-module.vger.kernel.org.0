Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E786C10EC9B
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Dec 2019 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLBPsr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Dec 2019 10:48:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:8957 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfLBPsq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 10:48:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 07:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="208167745"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.122.128.109])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2019 07:48:44 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        "Suresh Siddha" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH v24 12/24] x86/sgx: Linux Enclave Driver
Reply-To: haitao.huang@linux.intel.com
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
 <20191129231326.18076-13-jarkko.sakkinen@linux.intel.com>
Date:   Mon, 02 Dec 2019 09:48:43 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.0b6gvhtiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20191129231326.18076-13-jarkko.sakkinen@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 29 Nov 2019 17:13:14 -0600, Jarkko Sakkinen  
<jarkko.sakkinen@linux.intel.com> wrote:


> +
> +	for (c = 0 ; c < addp.length; c += PAGE_SIZE) {
> +		if (signal_pending(current)) {
> +			ret = -ERESTARTSYS;
> +			break;
> +		}

This IOC is not idempotent as pages EADDed at this point can not be  
re-EADDed again. So we can't return ERESTARTSYS

Haitao
