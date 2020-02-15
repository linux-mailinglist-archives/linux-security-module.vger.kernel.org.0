Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF7F15FD59
	for <lists+linux-security-module@lfdr.de>; Sat, 15 Feb 2020 08:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgBOHcp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 15 Feb 2020 02:32:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:64567 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgBOHcp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 15 Feb 2020 02:32:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 23:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,443,1574150400"; 
   d="scan'208";a="227856904"
Received: from kfinglet-mobl.ger.corp.intel.com (HELO localhost) ([10.252.22.140])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 23:32:33 -0800
Date:   Sat, 15 Feb 2020 09:32:34 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
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
Message-ID: <20200215073234.GD9958@linux.intel.com>
References: <20200209212609.7928-1-jarkko.sakkinen@linux.intel.com>
 <20200209212609.7928-11-jarkko.sakkinen@linux.intel.com>
 <d17c50a7-6900-731b-43a2-d6e49b8eb44d@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17c50a7-6900-731b-43a2-d6e49b8eb44d@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 13, 2020 at 02:59:52PM +0100, Jethro Beekman wrote:
> Besides only partially measuring a page, there are some other fringe
> cases that are technically possible, although I haven't seen any
> toolchains that do that. These include not interleaving EADD and
> EEXTEND, not using logical ordering for the EEXTENDs, and call EEXTEND
> multiple times on the same chunk. Maximum interoperability would
> require supporting any EADD/EEXTEND sequence.

The reason why EEXTEND deals with chunks is nothing to do with the
granularity but just to amortize the algorithm. I did ask about this
and this is the answer that I got.

I think it is perfectly sane for Linux to define ABI here in at this
level.

> Tested-by: Jethro Beekman <jethro@fortanix.com>

Thanks you.

> Sorry for being super late with this, I know you asked me for feedback
> about this specific point in October. However, I did previously
> mention several times that being able to measure individual 256-byte
> chunks is necessary.

NP.

/Jarkko
