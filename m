Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5D10EF12
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Dec 2019 19:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfLBSVF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Dec 2019 13:21:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:58535 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfLBSVF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 13:21:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 10:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="410523120"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga005.fm.intel.com with ESMTP; 02 Dec 2019 10:21:02 -0800
Date:   Mon, 2 Dec 2019 10:21:03 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH v24 12/24] x86/sgx: Linux Enclave Driver
Message-ID: <20191202182102.GF4063@linux.intel.com>
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
 <20191129231326.18076-13-jarkko.sakkinen@linux.intel.com>
 <op.0b6gvhtiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0b6gvhtiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 02, 2019 at 09:48:43AM -0600, Haitao Huang wrote:
> On Fri, 29 Nov 2019 17:13:14 -0600, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> 
> 
> >+
> >+	for (c = 0 ; c < addp.length; c += PAGE_SIZE) {
> >+		if (signal_pending(current)) {
> >+			ret = -ERESTARTSYS;
> >+			break;
> >+		}
> 
> This IOC is not idempotent as pages EADDed at this point can not be
> re-EADDed again. So we can't return ERESTARTSYS

Ah, and now I remember why I opted for modifying the parameters directly
instead of including a "number processed" field.  Andy pointed out the
ERESTARTSYS thing in the original multi-page add RFC[*], so presumably
updating the params and returning ERESTARTSYS is legal/acceptable.

[*] https://lkml.kernel.org/r/CALCETrUb4X9_L9RXKhmyNpfSCsbNodP=BfbfO8Fz_efq24jp8w@mail.gmail.com
