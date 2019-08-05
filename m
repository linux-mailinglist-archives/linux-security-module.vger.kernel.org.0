Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDCF8276A
	for <lists+linux-security-module@lfdr.de>; Tue,  6 Aug 2019 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfHEWMy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 5 Aug 2019 18:12:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:40026 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfHEWMy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Aug 2019 18:12:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 15:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="175707900"
Received: from unknown (HELO localhost) ([10.252.52.83])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2019 15:12:49 -0700
Date:   Tue, 6 Aug 2019 01:12:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca,
        tyhicks@canonical.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3] KEYS: trusted: allow module init if TPM is inactive
 or deactivated
Message-ID: <20190805221243.chp4x5h2ow76nmz4@linux.intel.com>
References: <20190805164427.17408-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805164427.17408-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 05, 2019 at 06:44:27PM +0200, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even if a TPM is not found, to
> avoid module dependency problems.
> 
> However, trusted module initialization can still fail if the TPM is
> inactive or deactivated. tpm_get_random() returns an error.
> 
> This patch removes the call to tpm_get_random() and instead extends the PCR
> specified by the user with zeros. The security of this alternative is
> equivalent to the previous one, as either option prevents with a PCR update
> unsealing and misuse of sealed data by a user space process.
> 
> Even if a PCR is extended with zeros, instead of random data, it is still
> computationally infeasible to find a value as input for a new PCR extend
> operation, to obtain again the PCR value that would allow unsealing.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
