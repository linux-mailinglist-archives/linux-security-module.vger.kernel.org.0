Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9AE9E8D5
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Aug 2019 15:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfH0NOE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 27 Aug 2019 09:14:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:16462 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0NOE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Aug 2019 09:14:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 06:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="180223331"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.169])
  by fmsmga008.fm.intel.com with ESMTP; 27 Aug 2019 06:14:01 -0700
Date:   Tue, 27 Aug 2019 16:14:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] tpm_tis: Fix interrupt probing
Message-ID: <20190827131400.qchcwa2act24c47b@linux.intel.com>
References: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 20, 2019 at 08:25:17AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> The interrupt probing of the TPM TIS was broken since we are trying to
> run it without an active locality and without the TPM_CHIP_FLAG_IRQ set.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Need these:

Cc: linux-stable@vger.kernel.org
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")

Thank you. I'll apply this to my tree.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
