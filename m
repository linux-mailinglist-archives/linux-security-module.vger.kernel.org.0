Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9017D63DDD
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Jul 2019 00:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGIWZg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 9 Jul 2019 18:25:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:47813 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGIWZf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Jul 2019 18:25:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 15:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,472,1557212400"; 
   d="scan'208";a="364289696"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2019 15:25:34 -0700
Date:   Tue, 9 Jul 2019 15:25:34 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-sgx@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org,
        Bill Roberts <william.c.roberts@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v4 00/12] security: x86/sgx: SGX vs. LSM
Message-ID: <20190709222534.GG25369@linux.intel.com>
References: <20190619222401.14942-1-sean.j.christopherson@intel.com>
 <20190705160549.tzsck5ho5kvtdhit@linux.intel.com>
 <20190708172930.GA20791@linux.intel.com>
 <20190709162203.gzyvulah5u7eksip@linux.intel.com>
 <20190709170917.GD25369@linux.intel.com>
 <512391ba-fe0d-e758-ae32-09660c1264f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512391ba-fe0d-e758-ae32-09660c1264f7@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 09, 2019 at 01:41:28PM -0700, Xing, Cedric wrote:
> On 7/9/2019 10:09 AM, Sean Christopherson wrote:
> >Translating those to SGX, with a lot of input from Stephen, I ended up
> >with the following:
> >
> >   - FILE__ENCLAVE_EXECUTE: equivalent to FILE__EXECUTE, required to gain X
> >                            on an enclave page loaded from a regular file
> >
> >   - PROCESS2__ENCLAVE_EXECDIRTY: hybrid of EXECMOD and EXECUTE+WRITE,
> >                                  required to gain W->X on an enclave page
> 
> EXECMOD basically indicates a file containing self-modifying code. Your
> ENCLAVE_EXECDIRTY is however a process permission, which is illogical.

How is it illogical?  If a PROCESS wants to EXECute a DIRTY ENCLAVE page,
then it needs PROCESS2__ENCLAVE_EXECDIRTY.

FILE__EXECMOD on /dev/sgx/enclave is a process permission masquerading as
a file permission, let's call it what it is.
