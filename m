Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB6166A32
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Feb 2020 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBTWKy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 20 Feb 2020 17:10:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:51689 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgBTWKy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 17:10:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 14:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="269758715"
Received: from evieschw-mobl.ger.corp.intel.com (HELO localhost) ([10.251.86.197])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2020 14:10:45 -0800
Date:   Fri, 21 Feb 2020 00:10:38 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>
Subject: Re: [PATCH v26 10/22] x86/sgx: Linux Enclave Driver
Message-ID: <20200220221038.GA26618@linux.intel.com>
References: <20200209212609.7928-1-jarkko.sakkinen@linux.intel.com>
 <20200209212609.7928-11-jarkko.sakkinen@linux.intel.com>
 <15074c16-4832-456d-dd12-af8548e46d6d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15074c16-4832-456d-dd12-af8548e46d6d@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 18, 2020 at 07:26:31PM -0800, Jordan Hand wrote:
> 	if (!page || (~page->vm_max_prot_bits & vm_prot_bits))
> 		return -EACCESS
> 
> This means that for any process where READ_IMPLIES_EXECUTE is set and
> page where (vma->vm_flags & VM_MAYEXEC) == true, mmap/mprotect calls to
> that request PROT_READ on a page that was not added with PROT_EXEC will
> fail.

Right. You would end up requesting RX from a R region.

And you are suggesting that we tweak it along the lines of to make RIE
processes work:

unsigned long max_prot_bits = page->vm_max_prot_bits;

if (!!(current->personality & READ_IMPLIES_EXEC) &&
    vma->vm_flags & VM_MAY_EXEC)
    max_prot_bits |= VM_EXEC;

/* ... */

if (!page || (~max_prot_bits & vm_prot_bits))
	return -EACCESS

?

/Jarkko
