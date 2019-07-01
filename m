Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185EC5C25C
	for <lists+linux-security-module@lfdr.de>; Mon,  1 Jul 2019 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfGARyA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Jul 2019 13:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfGARx7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Jul 2019 13:53:59 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910FB21855
        for <linux-security-module@vger.kernel.org>; Mon,  1 Jul 2019 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562003638;
        bh=ch7eOSgWD0jMKDrhWGJYm6JgKNYyQgaHBKN7b7GZLWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R2E8ihjYKf8Or/Kf1Ubv0uk+qmlr6i9AG5Ovy7mKcv0wlnakcALGDrAizdSlac8GR
         dbPOSiEbkepWs/wzw8vsg0rMym9oXEn0LaSTvnxQMAXP7RxsW4xeaIchxEpbGwxnUb
         C7T55nYiOLHpztz4vQCtvCrpAKS2yil00NPS+lYs=
Received: by mail-wm1-f51.google.com with SMTP id g135so383176wme.4
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jul 2019 10:53:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXxkHAVF/jG81H2L7xAdubR88vJHHcnGsYR0pPc7lAhdIPpncvl
        shJSA1a5AX6e1F2KXbJ9O/kDeX0+gQjmGEZ3uJ2K9w==
X-Google-Smtp-Source: APXvYqwXNA1G7G0DBHKKIQjryo6GeIlnfjN637NQ3mc547Q5zLsZcGNFiEx/XiuKDVDS7V3cG9qpYra5xmkYWqZYgfI=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr341083wmi.0.1562003637068;
 Mon, 01 Jul 2019 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190619222401.14942-1-sean.j.christopherson@intel.com>
 <20190619222401.14942-11-sean.j.christopherson@intel.com> <960B34DE67B9E140824F1DCDEC400C0F6551877E@ORSMSX116.amr.corp.intel.com>
 <b36d6fd0-3135-e48d-ed84-d69853bd79f1@tycho.nsa.gov> <CALCETrWPzSaFUWi4q4Vq_0RrtNMFZAKkwKkya=p6cfB50x2tMQ@mail.gmail.com>
 <960B34DE67B9E140824F1DCDEC400C0F6551D558@ORSMSX116.amr.corp.intel.com>
In-Reply-To: <960B34DE67B9E140824F1DCDEC400C0F6551D558@ORSMSX116.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jul 2019 10:53:45 -0700
X-Gmail-Original-Message-ID: <CALCETrXjq9JNjXZo3Va83Ca7fiAJx7ZM9VRWYebzpyH6ug0cKg@mail.gmail.com>
Message-ID: <CALCETrXjq9JNjXZo3Va83Ca7fiAJx7ZM9VRWYebzpyH6ug0cKg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 10/12] security/selinux: Add enclave_load() implementation
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 1, 2019 at 10:46 AM Xing, Cedric <cedric.xing@intel.com> wrote:
>
> > From: Andy Lutomirski [mailto:luto@kernel.org]
> > Sent: Saturday, June 29, 2019 4:42 PM
> >
> > On Tue, Jun 25, 2019 at 2:09 PM Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > >
> > > On 6/21/19 5:22 PM, Xing, Cedric wrote:
> > > >> From: Christopherson, Sean J
> > > >> Sent: Wednesday, June 19, 2019 3:24 PM
> > > >>
> > > >> Intended use of each permission:
> > > >>
> > > >>    - SGX_EXECDIRTY: dynamically load code within the enclave itsel=
f
> > > >>    - SGX_EXECUNMR: load unmeasured code into the enclave, e.g.
> > > >> Graphene
> > > >
> > > > Why does it matter whether a code page is measured or not?
> > >
> > > It won't be incorporated into an attestation?
> > >
> >
> > Also, if there is, in parallel, a policy that limits the set of enclave
> > SIGSTRUCTs that are accepted, requiring all code be measured makes it
> > harder to subvert by writing incompetent or maliciously incompetent
> > enclaves.
>
> As analyzed in my reply to one of Stephen's comments, no executable page =
shall be "enclave only" as enclaves have access to host's memory, so if an =
executable page in regular memory is considered posting a threat to the pro=
cess, it should be considered posting the same threat inside an enclave as =
well.

Huh?  The SDM (37.3 in whateve version I'm reading) says "Code fetches
from inside an enclave to a linear address outside that enclave result
in a #GP(0) exception."  Enclaves execute enclave code only.

In any event, I believe we're discussing taking readable memory from
outside the enclave and copying it to an executable code inside the
enclave.

>
> That said, every executable enclave page should have an executable source=
 page (doesn=E2=80=99t have to executable, as long as mprotect(X) would suc=
ceed on it, as shown in my patch)

Does Sean's series require this?  I think that, if we can get away
with it, it's a lot nicer to *not* require user code to map the source
pages PROT_EXEC.  Some policy may check that it's VM_MAYEXEC or check
some other attribute of the VMA, but actually requiring PROT_EXEC
seems like we're weakening existing hardening measures to enforce a
policy, which is a mistake.
