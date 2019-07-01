Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC024E45
	for <lists+linux-security-module@lfdr.de>; Tue, 21 May 2019 13:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEULpL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 21 May 2019 07:45:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:48281 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfEULpL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 May 2019 07:45:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 04:45:10 -0700
X-ExtLoop1: 1
Received: from mfaerber-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.78])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2019 04:45:06 -0700
Date:   Tue, 21 May 2019 14:45:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
Message-ID: <20190521114505.GC13279@linux.intel.com>
References: <20190520205501.177637-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 20, 2019 at 01:54:57PM -0700, Matthew Garrett wrote:
> Identical to previous version except without the KSAN workaround - Ard
> has a better solution for that.

I'll check in detail through tomorrow but probably will get merged
now that we have Ard's ack's (thanks Ard for all the trouble!) :-)

/Jarkko
