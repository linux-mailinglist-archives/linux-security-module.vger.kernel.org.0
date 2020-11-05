Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617162A8574
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Nov 2020 18:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKER55 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Nov 2020 12:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKER55 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Nov 2020 12:57:57 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B334520739;
        Thu,  5 Nov 2020 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604599076;
        bh=gdDo+sqJVja87qPkIpas68x1aYr8jJBmS3cjdIDyP9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=At6stxp7vNzfZh/URn0v04q7j3x42qli01PBi0EkC1HOQVH4TwpK1rPAldQqBKCBW
         AW50KLQJJYS7ZKoGP9jqMq1U8oXT0aS1UGp5qDVlNbqWi5rj0j18ELqReySo6cIoH8
         ePIxujPjwFKKhSNX8B1IsTXniaud2eityWtO+Ndw=
Date:   Thu, 5 Nov 2020 19:57:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com,
        mikko.ylinen@intel.com
Subject: Re: [PATCH v40 11/24] x86/sgx: Add SGX misc driver interface
Message-ID: <20201105175745.GA15463@kernel.org>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
 <20201104145430.300542-12-jarkko.sakkinen@linux.intel.com>
 <20201105011043.GA700495@kernel.org>
 <20201105011615.GA701257@kernel.org>
 <20201105160559.GD25636@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105160559.GD25636@zn.tnic>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 05, 2020 at 05:05:59PM +0100, Borislav Petkov wrote:
> On Thu, Nov 05, 2020 at 03:16:15AM +0200, Jarkko Sakkinen wrote:
> > Further, I'd declare this as an inline function given how trivial it
> > turn into.
> > 
> ...
> 
> So are you sending a new version of only this patch as a reply to this
> subthread?

Just remarked those, so that I will not forget either, e.g. even in the
case the patch was pulled as it is, I would eventually refine these
parts.

I'll rather send a full patch set if required.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
