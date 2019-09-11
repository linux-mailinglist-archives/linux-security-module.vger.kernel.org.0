Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9699AF82C
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Sep 2019 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfIKImx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Sep 2019 04:42:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:56754 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfIKImx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Sep 2019 04:42:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 01:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="189611282"
Received: from dgonsal1-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.48])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2019 01:42:50 -0700
Date:   Wed, 11 Sep 2019 09:42:49 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 00/12] add integrity and security to TPM2 transactions
Message-ID: <20190911084249.GA7436@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
 <20190910162132.GA11338@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910162132.GA11338@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 10, 2019 at 05:21:32PM +0100, Jarkko Sakkinen wrote:
> On Mon, Sep 09, 2019 at 01:16:48PM +0100, James Bottomley wrote:
> > Link to previous cover letter:
> > 
> > https://lore.kernel.org/linux-integrity/1540193596.3202.7.camel@HansenPartnership.com/
> > 
> > This is marked v6 instead of v5 because I did a v5 after feedback on v4
> > but didn't get around to posting it and then had to rework the whole of
> > the kernel space handling while I was on holiday.  I also added the
> > documentation of how the whole thing works and the rationale for doing
> > it in tpm-security.rst (patch 11).  The main reason for doing this now
> > is so we have something to discuss at Plumbers.
> > 
> > The new patch set implements the various splits requested, but the main
> > changes are that the kernel space is gone and is replaced by a context
> > save and restore of the generated null seed.  This is easier to handle
> > than a full kernel space given the new threading for TPM spaces, but
> > conceptually it is still very like a space.  I've also made whether
> > integrity and encryption is turned on a Kconfig option.
> > 
> > James
> 
> So... is there a changelog for the revisions?

This also desperately needs a cover letter with the full rationale and
not just a link to an aged cover letter. I have bigger problems with the
form than the function ATM.

TPM's threat model does not cover hardware attacks. It is hardware
designed to give some protection against software attacks. If I were
sending these patches I would start to look for an angle from that
perspective.

/Jarkko
