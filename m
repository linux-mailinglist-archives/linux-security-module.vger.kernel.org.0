Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3D282DD2
	for <lists+linux-security-module@lfdr.de>; Sun,  4 Oct 2020 23:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgJDVvB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 4 Oct 2020 17:51:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:55645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgJDVvB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 4 Oct 2020 17:51:01 -0400
IronPort-SDR: yYmNnjanNMJ8VYMV09pgvnBs/dBGqVZOO9nclRaSAIAA//DoRZNcq/m+36nfRdFvQv4pruC8Pi
 05LqduBaqUBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="160691149"
X-IronPort-AV: E=Sophos;i="5.77,336,1596524400"; 
   d="scan'208";a="160691149"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 14:51:00 -0700
IronPort-SDR: EEMfRrmKF5apVUkzCSKc2F4boDvYXgM2WIiX3IKlfihwdPDwme+T1WTU0NW+ThUPsdSvhOMb38
 AgF15xRfEFfQ==
X-IronPort-AV: E=Sophos;i="5.77,336,1596524400"; 
   d="scan'208";a="521929167"
Received: from avahldie-mobl.amr.corp.intel.com (HELO localhost) ([10.249.32.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 14:50:51 -0700
Date:   Mon, 5 Oct 2020 00:50:49 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
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
Message-ID: <20201004215049.GA43926@linux.intel.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <20201003045059.665934-12-jarkko.sakkinen@linux.intel.com>
 <20201003195440.GD20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003195440.GD20115@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Oct 03, 2020 at 08:54:40PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 03, 2020 at 07:50:46AM +0300, Jarkko Sakkinen wrote:
> > +	XA_STATE(xas, &encl->page_array, idx_start);
> > +
> > +	/*
> > +	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
> > +	 * conflict with the enclave page permissions.
> > +	 */
> > +	if (current->personality & READ_IMPLIES_EXEC)
> > +		return -EACCES;
> > +
> > +	xas_for_each(&xas, page, idx_end)
> > +		if (!page || (~page->vm_max_prot_bits & vm_prot_bits))
> > +			return -EACCES;
> 
> You're iterating the array without holding any lock that the XArray knows
> about.  If you're OK with another thread adding/removing pages behind your
> back, or there's a higher level lock (the mmap_sem?) protecting the XArray
> from being modified while you walk it, then hold the rcu_read_lock()
> while walking the array.  Otherwise you can prevent modification by
> calling xas_lock(&xas) and xas_unlock()..

I backtracked this. The locks have been there from v21-v35. This is a
refactoring mistake in radix_tree to xarray migration happened in v36.
It's by no means intentional.

What is shoukd take is encl->lock.

The loop was pre-v36 like:

	idx_start = PFN_DOWN(start);
	idx_end = PFN_DOWN(end - 1);

	for (idx = idx_start; idx <= idx_end; ++idx) {
		mutex_lock(&encl->lock);
		page = radix_tree_lookup(&encl->page_tree, idx);
		mutex_unlock(&encl->lock);

		if (!page || (~page->vm_max_prot_bits & vm_prot_bits))
			return -EACCES;
	}

Looking at xarray.h and filemap.c, I'm thinking something along the
lines of:

	for (idx = idx_start; idx <= idx_end; ++idx) {
		mutex_lock(&encl->lock);
		page = xas_find(&xas, idx + 1);
		mutex_unlock(&encl->lock);

		if (!page || (~page->vm_max_prot_bits & vm_prot_bits))
			return -EACCES;
	}

Does this look about right?

/Jarkko
