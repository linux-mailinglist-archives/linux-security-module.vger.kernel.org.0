Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F834194A
	for <lists+linux-security-module@lfdr.de>; Wed, 12 Jun 2019 02:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406178AbfFLAJd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 11 Jun 2019 20:09:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46239 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405764AbfFLAJc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Jun 2019 20:09:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so8445010pfy.13
        for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2019 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i3PsJwwDPsMEThcXBS4rchzEL1RqZkKdH+CwL/ZYuMY=;
        b=Bl3JANCSsnwSitJTWTfdgv5r0urYyObtgFnzXllgN0+LpM9C0WkN0RoCQpiNiEKN/F
         UYqwtjiNTA+9tYZcvTjiZVrkdDEsgEyLglUTcJYGBmLyjgDbVpZBZLNrX7qFJ3nDWHcb
         W2HY2Uz+eWXZ9D6r5SgxN7XCOCq7ijmDNrOF1gdegdauLyOhfHRm+SXgztoBPvABTuc2
         lmMWdb9NLlLOyydS6e07W/28K9+971Q/KuoFv3iYPkxbz3crZCFWnjfPwhxezXd6gU6s
         7x3YaiANYeYeSZ0EBRf00a43z1GzDvBfUmdvNrUukroL2ySnVpAZRL/YghT+GzeN70FS
         PC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i3PsJwwDPsMEThcXBS4rchzEL1RqZkKdH+CwL/ZYuMY=;
        b=r7atZAT/XxLvisCKtw6sGHNCKJfaNP8V0fsgqg8vqHXhpKIurDhSS8xV/dEc5QPOrp
         L7PmXvIcl14oRnDOYKuZPy8oktSKxxpRxNdhbrnRHAcAK9lTpQOHn2zEZAUvVgyxz8BJ
         dfIr+toUpUiTi6dNShqKFKXTN4KV9++5hW0bDepWcmveQGlIY5dMp49+B+LF3YxHSzA+
         GE+jOreUgH2I04COAbCfUaNwdQ+bfRmlu2dojsYNYFQ9xM6ptzgQTdBGfKDx4fagDjrK
         1rUxZ+VSMLvHdeX4lywvn9LT+5TRd5XPYA2hu9NWJy24UbhwqjPHzIjiavDSa/LUJlvL
         JeOA==
X-Gm-Message-State: APjAAAVqbD6F/jFYgihrEp8rZPkGX2ID/FfzjToYjIaPBCy9J7FuPdZ1
        6yLghX6+7VQqwQewNLJ0p7RQNQ==
X-Google-Smtp-Source: APXvYqy5+q46U41txHcFBZpRYAZLn2uuixoWepqfy1WrfIIerCO4LhHBaAIwbEkFPrzEuxfJ7pZJKA==
X-Received: by 2002:a63:de43:: with SMTP id y3mr23364910pgi.271.1560298171849;
        Tue, 11 Jun 2019 17:09:31 -0700 (PDT)
Received: from ?IPv6:2600:1010:b062:7159:60af:2fa5:3435:5195? ([2600:1010:b062:7159:60af:2fa5:3435:5195])
        by smtp.gmail.com with ESMTPSA id 18sm14248201pfy.0.2019.06.11.17.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 17:09:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 2/5] x86/sgx: Require userspace to define enclave pages' protection bits
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <960B34DE67B9E140824F1DCDEC400C0F655010EF@ORSMSX116.amr.corp.intel.com>
Date:   Tue, 11 Jun 2019 17:09:28 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <331B31BF-9892-4FB3-9265-3E37412F80F4@amacapital.net>
References: <20190606021145.12604-1-sean.j.christopherson@intel.com> <20190606021145.12604-3-sean.j.christopherson@intel.com> <960B34DE67B9E140824F1DCDEC400C0F65500E13@ORSMSX116.amr.corp.intel.com> <CALCETrWv9FYDtiHMfnfH==jE00tt7F22t-zcnP+XjfRCQgLr7A@mail.gmail.com> <960B34DE67B9E140824F1DCDEC400C0F655010EF@ORSMSX116.amr.corp.intel.com>
To:     "Xing, Cedric" <cedric.xing@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Jun 10, 2019, at 3:28 PM, Xing, Cedric <cedric.xing@intel.com> wrote:

>> From: Andy Lutomirski [mailto:luto@kernel.org]
>> Sent: Monday, June 10, 2019 12:15 PM
>>=20
>> On Mon, Jun 10, 2019 at 11:29 AM Xing, Cedric <cedric.xing@intel.com>
>> wrote:
>>>=20
>>>> From: Christopherson, Sean J
>>>> Sent: Wednesday, June 05, 2019 7:12 PM
>>>>=20
>>>> +/**
>>>> + * sgx_map_allowed - check vma protections against the associated
>>>> enclave page
>>>> + * @encl:    an enclave
>>>> + * @start:   start address of the mapping (inclusive)
>>>> + * @end:     end address of the mapping (exclusive)
>>>> + * @prot:    protection bits of the mapping
>>>> + *
>>>> + * Verify a userspace mapping to an enclave page would not violate
>>>> +the security
>>>> + * requirements of the *kernel*.  Note, this is in no way related
>>>> +to the
>>>> + * page protections enforced by hardware via the EPCM.  The EPCM
>>>> +protections
>>>> + * can be directly extended by the enclave, i.e. cannot be relied
>>>> +upon by the
>>>> + * kernel for security guarantees of any kind.
>>>> + *
>>>> + * Return:
>>>> + *   0 on success,
>>>> + *   -EACCES if the mapping is disallowed
>>>> + */
>>>> +int sgx_map_allowed(struct sgx_encl *encl, unsigned long start,
>>>> +                 unsigned long end, unsigned long prot) {
>>>> +     struct sgx_encl_page *page;
>>>> +     unsigned long addr;
>>>> +
>>>> +     prot &=3D (VM_READ | VM_WRITE | VM_EXEC);
>>>> +     if (!prot || !encl)
>>>> +             return 0;
>>>> +
>>>> +     mutex_lock(&encl->lock);
>>>> +
>>>> +     for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
>>>> +             page =3D radix_tree_lookup(&encl->page_tree, addr >>
>>>> PAGE_SHIFT);
>>>> +
>>>> +             /*
>>>> +              * Do not allow R|W|X to a non-existent page, or
>> protections
>>>> +              * beyond those of the existing enclave page.
>>>> +              */
>>>> +             if (!page || (prot & ~page->prot))
>>>> +                     return -EACCES;
>>>=20
>>> In SGX2, pages will be "mapped" before being populated.
>>>=20
>>> Here's a brief summary for those who don't have enough background on
>> how new EPC pages could be added to a running enclave in SGX2:
>>>  - There are 2 new instructions - EACCEPT and EAUG.
>>>  - EAUG is used by SGX module to add (augment) a new page to an
>> existing enclave. The newly added page is *inaccessible* until the
>> enclave *accepts* it.
>>>  - EACCEPT is the instruction for an enclave to accept a new page.
>>>=20
>>> And the s/w flow for an enclave to request new EPC pages is expected
>> to be something like the following:
>>>  - The enclave issues EACCEPT at the linear address that it would
>> like a new page.
>>>  - EACCEPT results in #PF, as there's no page at the linear address
>> above.
>>>  - SGX module is notified about the #PF, in form of its vma->vm_ops-
>>> fault() being called by kernel.
>>>  - SGX module EAUGs a new EPC page at the fault address, and resumes
>> the enclave.
>>>  - EACCEPT is reattempted, and succeeds at this time.
>>=20
>> This seems like an odd workflow.  Shouldn't the #PF return back to
>> untrusted userspace so that the untrusted user code can make its own
>> decision as to whether it wants to EAUG a page there as opposed to, say,
>> killing the enclave or waiting to keep resource usage under control?
>=20
> This may seem odd to some at the first glance. But if you can think of how=
 static heap (pre-allocated by EADD before EINIT) works, the load parses the=
 "metadata" coming with the enclave to decide the address/size of the heap, E=
ADDs it, and calls it done. In the case of "dynamic" heap (allocated dynamic=
ally by EAUG after EINIT), the same thing applies - the loader determines th=
e range of the heap, tells the SGX module about it, and calls it done. Every=
thing else is the between the enclave and the SGX module.
>=20
> In practice, untrusted code usually doesn't know much about enclaves, just=
 like it doesn't know much about the shared objects loaded into its address s=
pace either. Without the necessary knowledge, untrusted code usually just do=
es what it is told (via o-calls, or return value from e-calls), without judg=
ing that's right or wrong.=20
>=20
> When it comes to #PF like what I described, of course a signal could be se=
nt to the untrusted code but what would it do then? Usually it'd just come b=
ack asking for a page at the fault address. So we figured it'd be more effic=
ient to just have the kernel EAUG at #PF.=20
>=20
> Please don't get me wrong though, as I'm not dictating what the s/w flow s=
hall be. It's just going to be a choice offered to user mode. And that choic=
e was planned to be offered via mprotect() - i.e. a writable vma causes kern=
el to EAUG while a non-writable vma will result in a signal (then the user m=
ode could decide whether to EAUG). The key point is flexibility - as we want=
 to allow all reasonable s/w flows instead of dictating one over others. We h=
ad similar discussions on vDSO API before. And I think you accepted my appro=
ach because of its flexibility. Am I right?

As long as user code can turn this off, I have no real objection. But it mig=
ht make sense to have it be more explicit =E2=80=94 have an ioctl set up a r=
ange as =E2=80=9CEAUG-on-demand=E2=80=9D.

But this is all currently irrelevant. We can argue about it when the patches=
 show up. :)=
