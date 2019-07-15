Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67FE69EF2
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jul 2019 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfGOW3g (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jul 2019 18:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfGOW3g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 18:29:36 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAEA21743
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563229775;
        bh=1o/MhE8wLDRGugzlRBNF+fQFZHSjqcfwu7zrwe+cre8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZpDkylhailMnpdRsfDMZ9sgx/6WEvUFf2W1QdSbfg4+IbzCmjlQLl1e7CWFk0vulR
         pHQIxZkjMsk9EwsDA66rGR/qXwTfDqrYaTo/8NHMSyKlaer43RgO+s+jJGyz/yxkU3
         KpksNaWKviuwgv0NXhFqVRCJcyvaqIDpnSvfUsts=
Received: by mail-wm1-f42.google.com with SMTP id s15so16703589wmj.3
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 15:29:35 -0700 (PDT)
X-Gm-Message-State: APjAAAULGH/PDB6/QnVOETfZoIdMJ/ijq46OsitMMJKem6KxLUq2HocX
        NllyOk9HlNZjoy77v3syYcxiKl/xFVBV4cUnJ6fCcw==
X-Google-Smtp-Source: APXvYqwrGgYmx1u4B6STzlyQ0IXuhijCGw7k58WoJIe8fye9JZ3JBNz6Xc04hL1kryvhnKuWBaLSrjJHUIzF81iDO7I=
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr27926618wmf.161.1563229773990;
 Mon, 15 Jul 2019 15:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222438.2080-1-sean.j.christopherson@intel.com>
 <20190617222438.2080-5-sean.j.christopherson@intel.com> <dc3d59c2783ea81d85d4d447bd1a4a2d5fe51421.camel@linux.intel.com>
 <20190619152018.GC1203@linux.intel.com> <20190620221702.GE20474@linux.intel.com>
 <20190707190809.GE19593@linux.intel.com> <1b7369a08e98dd08a4f8bb19b16479f12bee130f.camel@linux.intel.com>
 <20190708161932.GE20433@linux.intel.com> <20190709160634.3yupyabf5svnj4ds@linux.intel.com>
 <20190710172553.GE4348@linux.intel.com>
In-Reply-To: <20190710172553.GE4348@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 15:29:23 -0700
X-Gmail-Original-Message-ID: <CALCETrXMAwHod_KZYPGWjTjg-fxOb1=02=Qj2g1o624wOPfPZQ@mail.gmail.com>
Message-ID: <CALCETrXMAwHod_KZYPGWjTjg-fxOb1=02=Qj2g1o624wOPfPZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] x86/sgx: Require userspace to define enclave
 pages' protection bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-sgx@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 10, 2019 at 10:25 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jul 09, 2019 at 07:06:34PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jul 08, 2019 at 09:19:32AM -0700, Sean Christopherson wrote:
> > > > 2. Probably some "user story" type of examples would help with the
> > > > discussion overall [1] i.e. how one would use this for
> > > > her own good.
> > >
> > > The compelling story is Andy's original concern that userspace could
> > > circumvent existing security policies by running code in an enclave.
> > >
> > > AIUI, closing the LSM loophole is the minimal requirement to get SGX
> > > upstreamed.  The extensive discussion has largely been focused on
> > > ensuring that whatever mechanism is used to close the loophole will
> > > play nice with future SGX functionality and/or LSM security policies.
> >
> > OK, might be getting here where I fall out of the wagon so:
> >
> > Doesn't Andy's example anyway require a process that has privileges to
> > make pages executable i.e. it could run arbitrary code even without an
> > enclave?
>
> Ah, no.  He did raise that concern, but it'd only be an issue if the
> enclave fd were backed by an anon inode, in which case all enclaves would
> need EXECMEM in order to gain PROT_EXEC on EPC.  Because the fd is backed
> /dev/sgx/enclave, userspace just needs FILE__EXECUTE on /dev/sgx/enclave.

I would say it differently: regardless of exactly how /dev/sgx/enclave
is wired up under the hood, we want a way that a process can be
granted permission to usefully run enclaves without being granted
permission to execute whatever bytes of code it wants.  Preferably
without requiring LSMs to maintain some form of enclave signature
whitelist.

This is pretty much the only hard requirement I see.  We really could
achieve this, in a somewhat limited form, by saying that LSMs can
approve or reject the SIGSTRUCT.  But doing it that way is a bit nasty
as we've noticed, for a few reasons.  Several of you have raised
objections to requiring SIGSTRUCT to come from a .sigstruct file.  We
also need to worry about a SIGSTRUCT that refers to an enclave that
forgot to measure its text.  And we need to worry about SGX2.

So this whole messy exercise boils down to: a bunch of security policy
authors think that EXECMEM and similar are not to be given out
lightly.  How to we allow policies like that to be compatible with
SGX?
