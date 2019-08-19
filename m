Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38B394B3B
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Aug 2019 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSRGl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 19 Aug 2019 13:06:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:60682 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSRGl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 13:06:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 10:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="353304570"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2019 10:06:35 -0700
Date:   Mon, 19 Aug 2019 20:06:35 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [RFC/RFT v4 3/5] KEYS: trusted: create trusted keys subsystem
Message-ID: <20190819170635.jlxxi6ogbm4s6gcx@linux.intel.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-4-git-send-email-sumit.garg@linaro.org>
 <20190819170458.m7adhkji64kta32d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819170458.m7adhkji64kta32d@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 19, 2019 at 08:04:58PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 13, 2019 at 01:23:02PM +0530, Sumit Garg wrote:
> > Move existing code to trusted keys subsystem. Also, rename files with
> > "tpm" as suffix which provides the underlying implementation.
> > 
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  crypto/asymmetric_keys/asym_tpm.c                       | 2 +-
> >  include/keys/{trusted.h => trusted_tpm.h}               | 4 ++--
> >  security/keys/Makefile                                  | 2 +-
> >  security/keys/trusted-keys/Makefile                     | 7 +++++++
> >  security/keys/{trusted.c => trusted-keys/trusted-tpm.c} | 2 +-
> >  5 files changed, 12 insertions(+), 5 deletions(-)
> >  rename include/keys/{trusted.h => trusted_tpm.h} (98%)
> >  create mode 100644 security/keys/trusted-keys/Makefile
> >  rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (99%)
> 
> Would prefer trusted_tpm.c.

Actually, trusted_tpm1.c.

/Jarkko
