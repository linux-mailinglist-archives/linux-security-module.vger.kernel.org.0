Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2EB5526
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Sep 2019 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfIQSPN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 17 Sep 2019 14:15:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:47596 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfIQSPN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Sep 2019 14:15:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 11:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="187535266"
Received: from vcazacux-wtg.ger.corp.intel.com (HELO localhost) ([10.252.38.72])
  by fmsmga007.fm.intel.com with ESMTP; 17 Sep 2019 11:15:08 -0700
Date:   Tue, 17 Sep 2019 21:15:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [Patch v6 4/4] KEYS: trusted: Move TPM2 trusted keys code
Message-ID: <20190917181507.GB8472@linux.intel.com>
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
 <1568630064-14887-5-git-send-email-sumit.garg@linaro.org>
 <20190917181415.GA8472@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917181415.GA8472@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 17, 2019 at 09:14:15PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 16, 2019 at 04:04:24PM +0530, Sumit Garg wrote:
> > Move TPM2 trusted keys code to trusted keys subsystem. The reason
> > being it's better to consolidate all the trusted keys code to a single
> > location so that it can be maintained sanely.
> > 
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> This commit has couple of issues that I only noticed when looking into
> bug reported by Mimi.
> 
> Right now tpm_send() is the exported function that is used by other
> subsystems. tpm_transmit_cmd() is an internal function. This commit adds
> two unrelated code paths to send TPM commands, which is unacceptable.
> 
> You should make tpm2 functionality to use tpm_send() instead and remove
> tpm_seal_trusted() and tpm_unseal_trusted() completely in this commit.

The consequence is that the result needs unfortunately re-review. Sorry
about that, just took this time to notice this glitch.

/Jarkko
