Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B066FCAFC
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Nov 2019 17:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfKNQoh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Nov 2019 11:44:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:60815 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfKNQoh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Nov 2019 11:44:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 08:44:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="203114131"
Received: from pkamlakx-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.10.73])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 08:44:32 -0800
Date:   Thu, 14 Nov 2019 18:44:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jsnitsel@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191114164426.GC9528@linux.intel.com>
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114164151.GB9528@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
> > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
> > This move handles error conditions better that may arise if anything
> > before fails in tpm_tis_probe_irq_single.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> What about just changing the condition?

Also cannot take this since it is not a bug (no fixes tag).

/Jarkko
