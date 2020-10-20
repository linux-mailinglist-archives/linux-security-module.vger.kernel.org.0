Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C64286841
	for <lists+linux-security-module@lfdr.de>; Wed,  7 Oct 2020 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgJGT0L (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Oct 2020 15:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgJGT0L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Oct 2020 15:26:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA492076C;
        Wed,  7 Oct 2020 19:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602098770;
        bh=ARBy9A0ue5dqKp5InVcHb1ElW6qKfvo+jYevu8+wq/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hhvb+RWQ6CdkbJ5w0RajeI+9jps9z2eLNp+IAp5cf1HZtUwQU3SltMtME1qVb3cls
         2mTPXr1+dGxa3833DrxJmXcqY6UtvMTxRygGp1olweQPVQBiMfN26qaJpn96SFe78k
         sWPAONQenDab5v9q+zGC5kVoxOA5GPnXxwkoIYQ8=
Date:   Wed, 7 Oct 2020 21:26:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com,
        mikko.ylinen@intel.com
Subject: Re: [PATCH v39 11/24] x86/sgx: Add SGX enclave driver
Message-ID: <20201007192655.GA104072@kroah.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <20201003045059.665934-12-jarkko.sakkinen@linux.intel.com>
 <20201003143925.GB800720@kroah.com>
 <20201004143246.GA3561@linux.intel.com>
 <20201005094246.GB151835@kroah.com>
 <20201005124221.GA191854@linux.intel.com>
 <op.0r4p1bn7wjvjmi@mqcpg7oapc828.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0r4p1bn7wjvjmi@mqcpg7oapc828.gar.corp.intel.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 07, 2020 at 01:09:01PM -0500, Haitao Huang wrote:
> > > > There is a patch that adds "sgx/provision".
> > > 
> > > What number in this series?
> > 
> > It's 15/24.
> > 
> 
> Don't know if this is critical. I'd prefer to keep them as is. Directory
> seems natural to me and makes sense to add more under the same dir in case
> there are more to come.

Why is this so special that you need a subdirectory for a single driver
with a mere 2 device nodes?  Do any other misc drivers have a new
subdirectory in /dev/ for them?

thanks,

greg k-h
