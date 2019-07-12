Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63DF663AE
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Jul 2019 04:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfGLCK6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 11 Jul 2019 22:10:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:11943 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfGLCK6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Jul 2019 22:10:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 19:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="317861797"
Received: from vpjampan-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.50.91])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2019 19:10:56 -0700
Date:   Fri, 12 Jul 2019 05:10:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-sgx@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Some LSM and SGX remarks before parting of for two weeks
Message-ID: <20190712021055.22qijpsahsy3gpmp@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Before going to a two week vacation (sending v21 today), I'll make some
remarks on SGX and LSM's:

1. Currently all patch sets proposing LSM changes are missing a problem
   statement and describe a solution to an undescribed problem.
2. When speaking of SELinux I haven't seen any draft's on how would
   define a policy module with the new constructs. Does not have to
   be a full policy modules but more like snippets demosntrating that
   "this would work".
3. All the SELinux discussion is centered on type based policies.
   Potentially one could isolate enclaves with some UBAC or RBAC
   based model. That could be good first step and might not even
   require LSM changes. Type based models could be introduced
   post upstreaming. No deep analysis on this, but at least this
   option should ruled out at minimum before striving into type
   based security model.

I guess the problem statement is more or less that since with DAC you
would have to allow to use mmap() and mprotect() to change anything
to X, even to the point that you can do WX, one needs a MAC to
somehow fix this.

Was not that hard, was it? Should be refined though with some context
why SGX requires this to not so SGX-oriented audience.

Even with just DAC this could be potentially sorted out with UBAC or
RBAC based solution e.g. have an SGID for enclave "builders" and the
device itself.

Repeating myself but type based security can be always added
aftewards.

/Jarkko
