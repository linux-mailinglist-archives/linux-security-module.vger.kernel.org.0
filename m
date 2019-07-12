Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A109966607
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Jul 2019 07:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfGLFOx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 12 Jul 2019 01:14:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:53526 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGLFOx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jul 2019 01:14:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 22:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,481,1557212400"; 
   d="scan'208";a="189734191"
Received: from gonegri-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.192])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2019 22:14:50 -0700
Date:   Fri, 12 Jul 2019 08:14:49 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-sgx@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: Some LSM and SGX remarks before parting of for two weeks
Message-ID: <20190712051449.sywsnncepdasxjbi@linux.intel.com>
References: <20190712021055.22qijpsahsy3gpmp@linux.intel.com>
 <alpine.LRH.2.21.1907121303080.17953@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1907121303080.17953@namei.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 12, 2019 at 01:12:23PM +1000, James Morris wrote:
> On Fri, 12 Jul 2019, Jarkko Sakkinen wrote:
> 
> > Before going to a two week vacation (sending v21 today), I'll make some
> > remarks on SGX and LSM's:
> > 
> > 1. Currently all patch sets proposing LSM changes are missing a problem
> >    statement and describe a solution to an undescribed problem.
> > 2. When speaking of SELinux I haven't seen any draft's on how would
> >    define a policy module with the new constructs. Does not have to
> >    be a full policy modules but more like snippets demosntrating that
> >    "this would work".
> > 3. All the SELinux discussion is centered on type based policies.
> >    Potentially one could isolate enclaves with some UBAC or RBAC
> >    based model. That could be good first step and might not even
> >    require LSM changes.
> 
> Unless I misunderstand what you mean here, RBAC and UBAC in SELinux still 
> require LSM hooks, and are typically integrated with Type Enforcement.

OK, I was thinking something like with normal DAC just to have SGID
for enclaves. Just learning basic SELinux concepts. Still quite alien
world to me.

/Jarkko
