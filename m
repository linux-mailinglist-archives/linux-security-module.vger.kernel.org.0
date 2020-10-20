Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723562838B9
	for <lists+linux-security-module@lfdr.de>; Mon,  5 Oct 2020 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJEPCB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 5 Oct 2020 11:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgJEPCA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Oct 2020 11:02:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A88E20674;
        Mon,  5 Oct 2020 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601910119;
        bh=GJ4hTec77m9RLslevp2HIebn5PH+a6OapBKX4FOsyIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmjIBB2zLyhQzQcNsuXbAQY0dMShAC/tljHHxIWVfPMW7HXJvd2ZSiBgRQye04TaD
         cCnATs4km/BGaixfLPWqbqQ2VNQzBzh3L9mx7UNhdBc0Cg5jzCDvwtLj0OfSTe8nvx
         IU400SomF8as4SOA5jE935pKkWUDMXVpaEBfrBR8=
Date:   Mon, 5 Oct 2020 17:02:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
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
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com,
        mikko.ylinen@intel.com
Subject: Re: [PATCH v39 11/24] x86/sgx: Add SGX enclave driver
Message-ID: <20201005150244.GA2288878@kroah.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <20201003045059.665934-12-jarkko.sakkinen@linux.intel.com>
 <20201003143925.GB800720@kroah.com>
 <20201005084554.GA3403@infradead.org>
 <20201005114250.GB181338@linux.intel.com>
 <20201005115030.GA682263@kroah.com>
 <20201005142345.GA6232@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005142345.GA6232@linux.intel.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 05, 2020 at 05:23:45PM +0300, Jarkko Sakkinen wrote:
> [*] One thing I've been wondering for a long time is that, why new code
> should have the copyright platters in the first place? I get it for
> pre-Git era but now there is a cryptographic log of authority.

Go talk to your corporate lawyers about this, it is one of the most
common cargo-cult patterns around :)

good luck!

greg k-h
