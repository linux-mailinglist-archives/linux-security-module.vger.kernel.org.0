Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9766273305
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Sep 2020 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgIUTl7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Sep 2020 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIUTl7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Sep 2020 15:41:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13EAC061755;
        Mon, 21 Sep 2020 12:41:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e30076607a950172f225.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:7660:7a95:172:f225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 516A61EC0328;
        Mon, 21 Sep 2020 21:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600717317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qZrZqcOEfZo0QkO4uYT/3s/bwQqS6adWbtHRcxOuhrk=;
        b=Z9OdnBDQsLfZKg6Qyw831XTqrlpD9GWb7mGg6TwaZ3Q/O3lxcPmh/gV/io1S8y/DFcb8tj
        b7IoB+8w4yXdLI2vOvqc7cSIp8Bl8MuKMQexzLeKjKCqLNZwd9IJvXlzBfGHzEDoKWx9e2
        wrmdQCekWZFDFeXMV5kCFa7XHqka2NI=
Date:   Mon, 21 Sep 2020 21:41:56 +0200
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
Message-ID: <20200921194156.GM5901@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-16-jarkko.sakkinen@linux.intel.com>
 <20200921180728.GJ5901@zn.tnic>
 <20200921192706.GD53597@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921192706.GD53597@linux.intel.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 21, 2020 at 10:27:06PM +0300, Jarkko Sakkinen wrote:
> 'sgx_dev_enclave' is successfully register whenever that happens. Am I
> missing something here?

No, I was missing the fact that you have *two* misc devices and you're
deregistering the first one in the error path of the second.

Forget what I said. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
