Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0935297C1D
	for <lists+linux-security-module@lfdr.de>; Sat, 24 Oct 2020 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759725AbgJXLeY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 24 Oct 2020 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759684AbgJXLeY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Oct 2020 07:34:24 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FFCC0613CE;
        Sat, 24 Oct 2020 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fZ8bj6A3iDt5ahbAYnewSKmCG4NGnBSbfCNkigTIWGo=; b=Uwf6/V6TPWMW6u1n4LU6NM9mCQ
        2Vpb9FvM/Xr8S3prSaFOUExp6Zf1wce/Pcr8SJ/0A8oijJVAZxLkb+WtmXyAehy8Ju8/VuCjc+1rh
        C2xc1/JkqgEj5JG9PGJGn1AsxG2rzxsBMmD5J13rDXLFrgn5InxRqpsz4MbG9ak+TGgdvhFAafRJN
        6mAmkPk746usYyRdEfR+Fxyq5avD2ToUqlJUUmgiwCdwzg+2kMxWSXdyCjG0eo8ClsOk7HLNovbKb
        q1iAbUc5l2rUCBSJmAkYlrKxDDT443GinqZ8HF5204B9mrqVFt13L9iAw6plxJy8vie2x1Kktem19
        APfXLqdA==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kernel.org@kernel.org>)
        id 1kWHoC-0006JU-3z; Sat, 24 Oct 2020 14:34:04 +0300
Date:   Sat, 24 Oct 2020 14:34:03 +0300
From:   Jarkko Sakkinen <kernel.org@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        haitao.huang@intel.com, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v39 15/24] x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION
Message-ID: <20201024113403.GA29427@kernel.org>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <20201003045059.665934-16-jarkko.sakkinen@linux.intel.com>
 <7bb4ff7b-0778-ad70-1fe0-6e1db284d45a@intel.com>
 <20201023101736.GG168477@linux.intel.com>
 <f2ff64e6-8fe1-55ee-ae7c-f19d7907d60e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ff64e6-8fe1-55ee-ae7c-f19d7907d60e@intel.com>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: kernel.org@kernel.org
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 23, 2020 at 07:19:05AM -0700, Dave Hansen wrote:
> On 10/23/20 3:17 AM, Jarkko Sakkinen wrote:
> > On Tue, Oct 20, 2020 at 02:19:26PM -0700, Dave Hansen wrote:
> >> On 10/2/20 9:50 PM, Jarkko Sakkinen wrote:
> >>> + * Failure to explicitly request access to a restricted attribute will cause
> >>> + * sgx_ioc_enclave_init() to fail.  Currently, the only restricted attribute
> >>> + * is access to the PROVISION_KEY.
> >> Could we also justify why access is restricted, please?  Maybe:
> >>
> >> 	Access is restricted because PROVISION_KEY is burned uniquely
> >> 	into each each processor, making it a perfect unique identifier
> >> 	with privacy and fingerprinting implications.
> >>
> >> Are there any other reasons for doing it this way?
> > AFAIK, if I interperet the SDM correctl, PROVISION_KEY and
> > PROVISION_SEALING_KEY also have random salt added, i.e. they change
> > every boot cycle.
> > 
> > There is "RAND = yes" on those keys in Table 40-64 of Intel SDM volume
> > 3D :-)
> 
> Does that mean there are no privacy implications from access to the
> provisioning keys?  If that's true, why do we need a separate permission
> framework for creating provisioning enclaves?

As I've understood it, the key material for those keys is not even
required in the current SGX architecture, it was used in the legacy EPID
scheme, but the attribute itself is useful.

Let's assume that we have some sort of quoting enclave Q, which guards a
public key pair, which signs quotes of other enclaves. Let's assume we
have an attestation server A, which will enable some capabilities [*],
if it receives a quote signed with that public key pair.

1. E gets the report key with EGETKEY.
2. E constructs REPORTDATA (37.16) and TARGETINFO (37.17) structures.
   The former describes the enclaves contents and attributes and latter
   the target, i.e. Q in this artitificial example.
3. E calls EREPORT to generate a structure called REPORT MAC'd with the
   *targets* report key. It knows, which key to usue from REPORTDATA.
4. The runtime will then pass this to Q.
5. Q will check if ATTRIBUTE.PROVISION_KEY is set. If it is, Q will
   know that the enclave is allowed to get attested. Then it will
   sign the report with the guarded public key pair and send it to
   the attestation server.

The example is artificial, e.g. there could be something more complex,
but the idea is essentially this.

[*] With TPM and measured boot this could be to open network for a data
    center node. Quote is just the term used for a signed measurement in
    remote attestation schemes generally.

/Jarkko
