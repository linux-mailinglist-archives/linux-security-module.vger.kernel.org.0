Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1F6271B
	for <lists+linux-security-module@lfdr.de>; Mon,  8 Jul 2019 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbfGHR3b (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 8 Jul 2019 13:29:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:55972 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfGHR3b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 13:29:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 10:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="316774704"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2019 10:29:30 -0700
Date:   Mon, 8 Jul 2019 10:29:30 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org,
        Bill Roberts <william.c.roberts@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v4 00/12] security: x86/sgx: SGX vs. LSM
Message-ID: <20190708172930.GA20791@linux.intel.com>
References: <20190619222401.14942-1-sean.j.christopherson@intel.com>
 <20190705160549.tzsck5ho5kvtdhit@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705160549.tzsck5ho5kvtdhit@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 05, 2019 at 07:05:49PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 19, 2019 at 03:23:49PM -0700, Sean Christopherson wrote:
> 
> I still don't get why we need this whole mess and do not simply admit
> that there are two distinct roles:
> 
> 1. Creator
> 2. User

Because SELinux has existing concepts of EXECMEM and EXECMOD.

> In the SELinux context Creator needs FILE__WRITE and FILE__EXECUTE but
> User does not. It just gets the fd from the Creator. I'm sure that all
> the SGX2 related functionality can be solved somehow in this role
> playing game.
> 
> An example would be the usual case where enclave is actually a loader
> that loads the actual piece of software that one wants to run. Things
> simply need to be designed in a way the Creator runs the loader part.
> These are non-trivial problems but oddball security model is not going
> to make them disappear - on the contrary it will make designing user
> space only more complicated.
> 
> I think this is classical example of when something overly complicated
> is invented in the kernel only to realize that it should be solved in
> the user space.
> 
> It would not be like the only use case where some kind of privileged
> daemon is used for managing some a kernel provided resource.
> 
> I think a really good conclusion from this discussion that has taken two
> months is to realize that nothing needs to be done in this area (except
> *maybe* noexec check).

Hmm, IMO we need to support at least equivalents to EXECMEM and EXECMOD.

That being said, we can do so without functional changes to the SGX uapi,
e.g. add reserved fields so that the initial uapi can be extended *if* we
decide to go with the "userspace provides maximal protections" path, and
use the EPCM permissions as the maximal protections for the initial
upstreaming.

That'd give us a minimal implemenation for initial upstreaming and would
eliminate Cedric's blocking complaint.  The "whole mess" of whitelisting,
blacklisting and SGX2 support would be deferred until post-upstreaming.
