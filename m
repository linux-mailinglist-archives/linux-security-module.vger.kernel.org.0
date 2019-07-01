Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B44582FE
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 14:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0M4c (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Jun 2019 08:56:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:30719 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0M4c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 08:56:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="164326961"
Received: from unknown (HELO jsakkine-mobl1) ([10.252.36.47])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2019 05:56:30 -0700
Message-ID: <320da9183c7e9ae2c63982d5e124054a615c4b99.camel@linux.intel.com>
Subject: LSM module for SGX?
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-security-module@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     casey.schaufler@intel.com, jmorris@namei.org, luto@kernel.org,
        sean.j.christopherson@intel.com
Date:   Thu, 27 Jun 2019 15:56:29 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Looking at the SGX-LSM discussions I haven't seen even a single email
that would have any conclusions that the new hooks are the only possible
route to limit the privileges to use SGX.

An obvious alternative to consider might be to have a small-scale LSM
that you could stack. AFAIK Casey's LSM stacking patch set has not yet
landed but I also remember that with some constraints you can still do
it. Casey explained these constraints to me few years ago but I can't
recall them anymore :-)

One example of this is Yama, which limits the use of ptrace(). You can
enable it together with any of the "big" LSMs in the kernel.

A major benefit in this approach would that it is non-intrusive when it
comes to other architectures than x86. New hooks are not only
maintenance burden for those who care about SGX but also for those who
have to deal with LSMs.

/Jarkko

