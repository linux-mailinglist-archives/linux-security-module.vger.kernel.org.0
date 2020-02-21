Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF94167DDA
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Feb 2020 14:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBUNBs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Feb 2020 08:01:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:58276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgBUNBs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 08:01:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 05:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; 
   d="scan'208";a="409130241"
Received: from mklimasz-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.87.58])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2020 05:01:36 -0800
Date:   Fri, 21 Feb 2020 15:01:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>
Subject: Re: [PATCH v26 10/22] x86/sgx: Linux Enclave Driver
Message-ID: <20200221130135.GC3112@linux.intel.com>
References: <20200220221607.GB26618@linux.intel.com>
 <6AE5891F-FC0D-4062-A6CA-01C78C2D5A1A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AE5891F-FC0D-4062-A6CA-01C78C2D5A1A@amacapital.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 20, 2020 at 04:32:22PM -0800, Andy Lutomirski wrote:
> > On Feb 20, 2020, at 2:16 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > ﻿On Thu, Feb 20, 2020 at 10:48:42AM -0800, Sean Christopherson wrote:
> >> My biggest concern for allowing PROT_EXEC if RIE is that it would result
> >> in #PF(SGX) (#GP on Skylake) due to an EPCM violation if the enclave
> >> actually tried to execute from such a page.  This isn't a problem for the
> >> kernel as the fault will be reported cleanly through the vDSO (or get
> >> delivered as a SIGSEGV if the enclave isn't entered through the vDSO), but
> >> it's a bit weird for userspace as userspace will see the #PF(SGX) and
> >> likely assume the EPC was lost, e.g. silently restart the enclave instead
> >> of logging an error that the enclave is broken.
> > 
> > I think right way to fix the current implementation is to -EACCES mmap()
> > (and mprotect) when !!(current->personality & READ_IMPLIES_EXEC).
> > 
> > This way supporting RIE can be reconsidered later on without any
> > potential ABI bottlenecks.
> > 
> 
> Sounds good to me.  I see no credible reason why anyone would use RIE and SGX.

Great, thanks Andy.

/Jarkko
