Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67A297D36
	for <lists+linux-security-module@lfdr.de>; Sat, 24 Oct 2020 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760499AbgJXPrn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 24 Oct 2020 11:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760496AbgJXPrm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Oct 2020 11:47:42 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B302465B
        for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2020 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603554461;
        bh=WmBbNWhHP6TeR2O/n2ZYBhpmL2kj6x0530LgA41pBKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=keAX3JyrVGeWCh4O0UK3bqb/02ZgWb21rzgkBm430SkpsQ2O8zl4wdJdGLIR3HEaH
         1XgNNgR+6gyngZnwg0bsYTUwUpaGInHS4aCdKwQxElrqVeSf9fT/F9+zZXIuAg8RrA
         1ozsKiWmezEyo6wt30lhB9MF8yTV9oJuVHxiNT0o=
Received: by mail-wm1-f47.google.com with SMTP id d78so5564719wmd.3
        for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2020 08:47:41 -0700 (PDT)
X-Gm-Message-State: AOAM531Snk0oEHNRxcvwAGRQ7vjlONrspdPzNczdSipbQ6lkcD/0/pCb
        vmZUDx3G2avcQoyW9HQwrNhro9BE4OjqKl/ePNGnLQ==
X-Google-Smtp-Source: ABdhPJx3gfZuk8J+485eHiKQKMeyXKMTChdcl4yaJniTwMIJ9YG/WwrAwXc3p7BhtWAh9QyxeWRFcpmCPDNx/HpgFWQ=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr7968642wmm.49.1603554460057;
 Sat, 24 Oct 2020 08:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <20201003045059.665934-16-jarkko.sakkinen@linux.intel.com>
 <7bb4ff7b-0778-ad70-1fe0-6e1db284d45a@intel.com> <20201023101736.GG168477@linux.intel.com>
 <f2ff64e6-8fe1-55ee-ae7c-f19d7907d60e@intel.com> <20201024113403.GA29427@kernel.org>
In-Reply-To: <20201024113403.GA29427@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 24 Oct 2020 08:47:28 -0700
X-Gmail-Original-Message-ID: <CALCETrWxA6AgU8zg=npS=4NaA1_Pu9UwScEnr_Gk0wF-BOmqqQ@mail.gmail.com>
Message-ID: <CALCETrWxA6AgU8zg=npS=4NaA1_Pu9UwScEnr_Gk0wF-BOmqqQ@mail.gmail.com>
Subject: Re: [PATCH v39 15/24] x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION
To:     Jarkko Sakkinen <kernel.org@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        "Xing, Cedric" <cedric.xing@intel.com>, chenalexchen@google.com,
        Conrad Parker <conradparker@google.com>, cyhanish@google.com,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Neil Horman <nhorman@redhat.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com,
        Mikko Ylinen <mikko.ylinen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Oct 24, 2020 at 4:34 AM Jarkko Sakkinen <kernel.org@kernel.org> wrote:
>
> On Fri, Oct 23, 2020 at 07:19:05AM -0700, Dave Hansen wrote:
> > On 10/23/20 3:17 AM, Jarkko Sakkinen wrote:
> > > On Tue, Oct 20, 2020 at 02:19:26PM -0700, Dave Hansen wrote:
> > >> On 10/2/20 9:50 PM, Jarkko Sakkinen wrote:
> > >>> + * Failure to explicitly request access to a restricted attribute will cause
> > >>> + * sgx_ioc_enclave_init() to fail.  Currently, the only restricted attribute
> > >>> + * is access to the PROVISION_KEY.
> > >> Could we also justify why access is restricted, please?  Maybe:
> > >>
> > >>    Access is restricted because PROVISION_KEY is burned uniquely
> > >>    into each each processor, making it a perfect unique identifier
> > >>    with privacy and fingerprinting implications.
> > >>
> > >> Are there any other reasons for doing it this way?
> > > AFAIK, if I interperet the SDM correctl, PROVISION_KEY and
> > > PROVISION_SEALING_KEY also have random salt added, i.e. they change
> > > every boot cycle.
> > >
> > > There is "RAND = yes" on those keys in Table 40-64 of Intel SDM volume
> > > 3D :-)
> >
> > Does that mean there are no privacy implications from access to the
> > provisioning keys?  If that's true, why do we need a separate permission
> > framework for creating provisioning enclaves?
>
> As I've understood it, the key material for those keys is not even
> required in the current SGX architecture, it was used in the legacy EPID
> scheme, but the attribute itself is useful.
>
> Let's assume that we have some sort of quoting enclave Q, which guards a
> public key pair, which signs quotes of other enclaves. Let's assume we
> have an attestation server A, which will enable some capabilities [*],
> if it receives a quote signed with that public key pair.
>
> 1. E gets the report key with EGETKEY.
> 2. E constructs REPORTDATA (37.16) and TARGETINFO (37.17) structures.
>    The former describes the enclaves contents and attributes and latter
>    the target, i.e. Q in this artitificial example.
> 3. E calls EREPORT to generate a structure called REPORT MAC'd with the
>    *targets* report key. It knows, which key to usue from REPORTDATA.
> 4. The runtime will then pass this to Q.
> 5. Q will check if ATTRIBUTE.PROVISION_KEY is set. If it is, Q will
>    know that the enclave is allowed to get attested. Then it will
>    sign the report with the guarded public key pair and send it to
>    the attestation server.

I think you have this a little bit off.  AIUI E won't have
ATTRIBUTE.PROVISION_KEY set -- Q will.  Q uses the provisioning key to
convince an Intel server that it's running on a genuine Intel CPU, and
the Intel server will return a signed certificate that Q can chain off
of to generate attestations for E.

Dave, I would rephrase what you're saying a bit.  The PROVISION_KEY
attribute allows enclaves to access keys that are unique to a
processor and unchangeable.  Unlike other SGX keys, these keys are not
affected by OWNER_EPOCH changes and therefore cannot be reset.

--Andy
