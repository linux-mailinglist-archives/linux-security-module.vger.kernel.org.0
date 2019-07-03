Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60E45EF96
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Jul 2019 01:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGCXW2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 3 Jul 2019 19:22:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:50945 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfGCXW2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jul 2019 19:22:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 16:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="184874717"
Received: from elsaidmo-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.33.22])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2019 16:22:23 -0700
Date:   Thu, 4 Jul 2019 02:22:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Cedric Xing <cedric.xing@intel.com>
Cc:     linux-sgx@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com,
        jmorris@namei.org, luto@kernel.org, jethro@fortanix.com,
        greg@enjellic.com, sds@tycho.nsa.gov,
        sean.j.christopherson@intel.com
Subject: Re: [RFC PATCH v2 0/3] security/x86/sgx: SGX specific LSM hooks
Message-ID: <20190703232221.l66lhmxhu2kmjcip@linux.intel.com>
References: <20190619222401.14942-1-sean.j.christopherson@intel.com>
 <cover.1561588012.git.cedric.xing@intel.com>
 <20190703231650.bhnkn34ccrzdwwhz@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703231650.bhnkn34ccrzdwwhz@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> The eye should be on whether the uapi (e.g. device files, ioctl's) will
> work for LSM's in a legit way. Do we need more of these different
> flavors of experimental LSM changes or can we make some conclusions with
> the real issue we are trying to deal with?

Anyway, sending v21 soonish. Finished it on Thu but have been waiting
any internal QA feedback. If nothing pops up, I'll send it tmrw.

/Jarkko
