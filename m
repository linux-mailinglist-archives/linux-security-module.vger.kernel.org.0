Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628C411766D
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Dec 2019 20:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIT5b (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Dec 2019 14:57:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:49527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIT5b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Dec 2019 14:57:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 11:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="264346146"
Received: from nshalmon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.8.146])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2019 11:57:21 -0800
Date:   Mon, 9 Dec 2019 21:57:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH v23 12/24] x86/sgx: Linux Enclave Driver
Message-ID: <20191209195719.GH19243@linux.intel.com>
References: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
 <20191028210324.12475-13-jarkko.sakkinen@linux.intel.com>
 <20191128182450.GA3493127@kroah.com>
 <20191206203807.GA9971@linux.intel.com>
 <20191207080939.GA193518@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207080939.GA193518@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Dec 07, 2019 at 09:09:39AM +0100, Greg KH wrote:
> On Fri, Dec 06, 2019 at 10:38:07PM +0200, Jarkko Sakkinen wrote:
> > > Why a whole cdev?
> > > 
> > > Why not use a misc device?  YOu only have 2 devices right?  Why not 2
> > > misc devices then?  That saves the use of a whole major number and makes
> > > your code a _LOT_ simpler.
> > 
> > The downside would be that if we ever want to add sysfs attributes, that
> > could not be done synchronously with the device creation.
> 
> That is what the groups member of struct misc_device is for.

OK, cool, then there is no problem changing to misc.

I haven't seen misc drivers (not that I've looked through every single
of them so I suppose there are such) to use it and somehow have been
blind to seeing it that it si there.

Thanks again for the feedback. I'll fix this for the next patch set
version.

/Jarkko
