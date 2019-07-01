Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4021421CBC
	for <lists+linux-security-module@lfdr.de>; Fri, 17 May 2019 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEQRnF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 May 2019 13:43:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41125 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbfEQRnE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 13:43:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so4009307pfq.8
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1MUUr8jHi4nWwWTQmbf4zT7ImlITOzRRt/eE8Yg+dlo=;
        b=BVBxteTJfnnrWyI4aUT5rRv1PGo8Y6m41oQyOQLQ9wBx/DmrNo0J1mMUNowheLYiJT
         gKvk0uAVsiCTt8tVYuQ/pPtHQRdoElbWppBomwzttM4Js8uMnrX6vMxuzBVdPGlkzr1Y
         GWgaqh0R1jib28O3eRsR7C1RlVrLz24MYG6PHBQeMy/xQd+hNChzOEonkPhE32Vf59wb
         7UvLuxW3yeufL91nnzFXK7bPLzbuJoICh6lMFWftYxpVMVdrREc5ELLOGPhhU6Rkfnmb
         N6e0/7k/HQexEZEcncU6dBmw4ONKENMHpsbRqYdQPxnFGL1UkVVe23OrBSEk4arvt6iX
         OJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1MUUr8jHi4nWwWTQmbf4zT7ImlITOzRRt/eE8Yg+dlo=;
        b=gVXb4gcdLWYB0uj7qhx0GtetQdxTNEEuHH5/W2ZNP/7Pd8sQCVacumbQjikpl9qWzf
         Tb2H76yXxoQnMpiJ3LPl7TUw68IFwFHcmpqsQN0t2BBFZGtGBOuuZgR+4j/77com+QXP
         KfWfiuP8DZO44MWTz7wrT02TJj+W3L0P2ZuBS+W7+9qTmInoEKVtgp4i0fHlvFKExtbV
         mY3uNaSNFkhnyWFKoKvJbRVD4951vCpCrot3vpnX/R7Y/mBPb9QwoSZTbZk6OX4ro2Ck
         OEyXIM3D0vTIFLlV+nsQU+aNW2I9ZQVP8Z00tFxVNqWL5Uk0TUIIWd8S9xGKfWuUUuNO
         Bl6w==
X-Gm-Message-State: APjAAAXPfeVKiZ9qzUbYTI18WX638h9esobrZpylGbnxYoEVPGo0PIfu
        JjkZA5uIXe69teJDR7W06ssqeg==
X-Google-Smtp-Source: APXvYqz1/VPPlQLATdNzJclNH72+/NYUbTxi66IC1Gfqe9SWbtuv4tuZ7KKRyXz7msEB9xK+aIxb4g==
X-Received: by 2002:aa7:93c6:: with SMTP id y6mr8796393pff.0.1558114983336;
        Fri, 17 May 2019 10:43:03 -0700 (PDT)
Received: from ?IPv6:2600:1010:b00c:b1d8:2521:afcd:cb07:a739? ([2600:1010:b00c:b1d8:2521:afcd:cb07:a739])
        by smtp.gmail.com with ESMTPSA id 10sm12185936pft.100.2019.05.17.10.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 10:43:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: SGX vs LSM (Re: [PATCH v20 00/28] Intel SGX1 support)
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190517172953.GC15006@linux.intel.com>
Date:   Fri, 17 May 2019 10:43:01 -0700
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dr. Greg" <greg@enjellic.com>,
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
        David Rientjes <rientjes@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFE03E0C-694A-4289-B416-29CDC2644F94@amacapital.net>
References: <CALCETrX_Q6qwNRNF0TL2tgfm1j6DKLX7NVHHmWbMFtk3WnHDKw@mail.gmail.com> <alpine.LRH.2.21.1905160844130.29250@namei.org> <CALCETrX2ovRx3Rre+1_xC-q6CiybyLjQ-gmB4FZF_qCZ-Qd+4A@mail.gmail.com> <960B34DE67B9E140824F1DCDEC400C0F654E38CD@ORSMSX116.amr.corp.intel.com> <CALCETrUfmyQ7ivNzQic0FyPXe1fmAnoK093jnz0i8DRn2LvdSA@mail.gmail.com> <960B34DE67B9E140824F1DCDEC400C0F654E3FB9@ORSMSX116.amr.corp.intel.com> <6a97c099-2f42-672e-a258-95bc09152363@tycho.nsa.gov> <20190517150948.GA15632@linux.intel.com> <ca807220-47e2-5ec2-982c-4fb4a72439c6@tycho.nsa.gov> <80013cca-f1c2-f4d5-7558-8f4e752ada76@tycho.nsa.gov> <20190517172953.GC15006@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On May 17, 2019, at 10:29 AM, Sean Christopherson <sean.j.christopherson@i=
ntel.com> wrote:
>=20
>> On Fri, May 17, 2019 at 12:37:40PM -0400, Stephen Smalley wrote:
>>> On 5/17/19 12:20 PM, Stephen Smalley wrote:
>>>> On 5/17/19 11:09 AM, Sean Christopherson wrote:
>>>> I think we may want to change the SGX API to alloc an anon inode for ea=
ch
>>>> enclave instead of hanging every enclave off of the /dev/sgx/enclave
>>>> inode.
>>>> Because /dev/sgx/enclave is NOT private, SELinux's file_map_prot_check(=
)
>>>> will only require FILE__WRITE and FILE__EXECUTE to mprotect() enclave
>>>> VMAs
>>>> to RWX.  Backing each enclave with an anon inode will make SELinux trea=
t
>>>> EPC memory like anonymous mappings, which is what we want (I think), e.=
g.
>>>> making *any* EPC page executable will require PROCESS__EXECMEM (SGX is
>>>> 64-bit only at this point, so SELinux will always have default_noexec).=

>>>=20
>>> I don't think we want to require EXECMEM (or equivalently both FILE__WRI=
TE
>>> and FILE__EXECUTE to /dev/sgx/enclave) for making any EPC page executabl=
e,
>>> only if the page is also writable or previously modified.  The intent is=

>>> to prevent arbitrary code execution without EXECMEM (or
>>> FILE__WRITE|FILE__EXECUTE), while still allowing enclaves to be created
>>> without EXECMEM as long as the EPC page mapping is only ever mapped RX a=
nd
>>> its initial contents came from an unmodified file mapping that was
>>> PROT_EXEC (and hence already checked via FILE__EXECUTE).
>=20
> The idea is that by providing an SGX ioctl() to propagate VMA permissions
> from a source VMA, EXECMEM wouldn't be required to make an EPC page
> executable.  E.g. userspace establishes an enclave in non-EPC memory from
> an unmodified file (with FILE__EXECUTE perms), and the uses the SGX ioctl(=
)
> to copy the contents and permissions into EPC memory.
>=20
>> Also, just to be clear, there is nothing inherently better about checking=

>> EXECMEM instead of checking both FILE__WRITE and FILE__EXECUTE to the
>> /dev/sgx/enclave inode, so I wouldn't switch to using anon inodes for tha=
t
>> reason.  Using anon inodes also unfortunately disables SELinux inode-base=
d
>> checking since we no longer have any useful inode information, so you'd l=
ose
>> out on SELinux ioctl whitelisting on those enclave inodes if that matters=
.
>=20
> The problem is that all enclaves are associated with a single inode, i.e.
> /dev/sgx/enclave.  /dev/sgx/enclave is a char device whose purpose is to
> provide ioctls() and to allow mmap()'ing EPC memory.  In no way is it
> associated with the content that actually gets loaded into EPC memory.
>=20
> The actual file that contains the enclave's contents (assuming the enclave=

> came from a file) is a separate regular file that the SGX subsystem never
> sees.
>=20
> AIUI, having FILE__WRITE and FILE__EXECUTE on /dev/sgx/enclave would allow=

> *any* enclave/process to map EPC as RWX.  Moving to anon inodes and thus
> PROCESS__EXECMEM achieves per-process granularity.

How does anon_inode make any difference?  Anon_inode is not the same thing a=
s anon_vma.=
