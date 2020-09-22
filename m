Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC93A273D4E
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Sep 2020 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIVIaL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 22 Sep 2020 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgIVIaJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Sep 2020 04:30:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1858C0613CF
        for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2020 01:30:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bfb00524dde00a85e5113.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:524d:de00:a85e:5113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AD3A1EC047F;
        Tue, 22 Sep 2020 10:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600763406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lMW7/Eoiw3PZgWXD71YS/srgG6ZE6LeQcSBpIjlo3Vs=;
        b=N9/4gG+Xj6Ldxt8o5+3U+6c7nM31yz6TD2zi2egYhr9JWY7tvcfvM6554E43S7AKbldOQd
        P817UQxMyQXPrlTUi7pL6BLemF6Ue74g3/2r2gqp3LLCkCklet+UnHcZ2bCi4Ap9eYOhiE
        giE/+Z9RXlGoscZTh5/f9uLM2zWJVpQ=
Date:   Tue, 22 Sep 2020 10:30:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com
Subject: Re: [PATCH v38 15/24] x86/sgx: Enable provisioning for remote
 attestation
Message-ID: <20200922083005.GD22660@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-16-jarkko.sakkinen@linux.intel.com>
 <20200921180728.GJ5901@zn.tnic>
 <20200921192706.GD53597@linux.intel.com>
 <20200921194156.GM5901@zn.tnic>
 <20200921212638.GB59547@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921212638.GB59547@linux.intel.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 22, 2020 at 12:26:38AM +0300, Jarkko Sakkinen wrote:
> BTW, probably would make sense to rewrite the short summary as:
> 
> "x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION"
> 
> for the sake of consistency with the three precursoring patches.

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
