Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6882EC5AB
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Nov 2019 16:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfKAPcj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 1 Nov 2019 11:32:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:19571 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfKAPcj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Nov 2019 11:32:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 08:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="375595027"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2019 08:32:38 -0700
Date:   Fri, 1 Nov 2019 08:32:38 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH v23 12/24] x86/sgx: Linux Enclave Driver
Message-ID: <20191101153238.GA2657@linux.intel.com>
References: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
 <20191028210324.12475-13-jarkko.sakkinen@linux.intel.com>
 <173a196e-fa6b-23b8-c818-dfca6cdadcc6@tycho.nsa.gov>
 <20191031211721.GD10507@linux.intel.com>
 <f91d788c-b372-8e2f-7ffb-995f501b5d6b@tycho.nsa.gov>
 <4bf866ae-adc8-7902-3714-b62e548d8584@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bf866ae-adc8-7902-3714-b62e548d8584@tycho.nsa.gov>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 01, 2019 at 09:28:17AM -0400, Stephen Smalley wrote:
> On 11/1/19 9:16 AM, Stephen Smalley wrote:
> >So, IIUC, that means that merging the driver will create a regression with
> >respect to LSM control over executable mappings that will only be
> >rectified at some future point in time if/when someone submits LSM hooks
> >or calls to existing hooks to restore such control.� That doesn't seem
> >like a good idea.� Why can't you include at least that basic level of
> >control now?� It is one thing to defer finer grained control or
> >SGX-specific access controls to the future - that I can understand.� But
> >introducing a regression in the existing controls is not really ok.
> 
> Unless you are arguing that the existing checks on mmap/mprotect of
> /dev/sgx/enclave are a coarse-grained approximation (effectively requiring
> WX to the file or execmem for any user of SGX).

Yes, that's the argument as running any enclave will require RWX access to
/dev/sgx/enclave.  EXECMEM won't trigger for SGX users as /dev/sgx/enclave
must be MAP_SHARED and it's a non-private file (not backed by anonymous
inode, in case I got the file terminology wrong).
