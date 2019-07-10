Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9664D6E
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Jul 2019 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfGJUTg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Jul 2019 16:19:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:56654 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfGJUTg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Jul 2019 16:19:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 13:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="249577377"
Received: from mwsinger-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.34.170])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2019 13:19:30 -0700
Date:   Wed, 10 Jul 2019 23:19:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
Message-ID: <20190710201930.ly7ykediuy35cjze@linux.intel.com>
References: <20190619222401.14942-1-sean.j.christopherson@intel.com>
 <20190705160549.tzsck5ho5kvtdhit@linux.intel.com>
 <20190708172930.GA20791@linux.intel.com>
 <20190709162203.gzyvulah5u7eksip@linux.intel.com>
 <20190709170917.GD25369@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709170917.GD25369@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 09, 2019 at 10:09:17AM -0700, Sean Christopherson wrote:
> On Tue, Jul 09, 2019 at 07:22:03PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jul 08, 2019 at 10:29:30AM -0700, Sean Christopherson wrote:
> > > On Fri, Jul 05, 2019 at 07:05:49PM +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Jun 19, 2019 at 03:23:49PM -0700, Sean Christopherson wrote:
> > > > 
> > > > I still don't get why we need this whole mess and do not simply admit
> > > > that there are two distinct roles:
> > > > 
> > > > 1. Creator
> > > > 2. User
> > > 
> > > Because SELinux has existing concepts of EXECMEM and EXECMOD.
> > 
> > What is the official documentation for those? I've only found some
> > explanations from discussions and some RHEL sysadmin guides.
> 
> No clue.  My knowledge was gleaned from the code and from Stephen's
> feedback.

OK, thanks for elaboration. Got nailed some details I was missing :-)

Anyway, to accompany your code changes I'm eager to document this not
least because it is a good peer test that this all make sense (you
cannot "unit test" a security model so that is the next best thing).

Still, we need a documentation reference to reflect the narrative
for these changes, seriously. It cannot be that SELinux is widely
deployed and it completely lacks documentation for its basic
objects, can it?

/Jarkko
