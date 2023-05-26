Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39428712A2C
	for <lists+linux-security-module@lfdr.de>; Fri, 26 May 2023 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjEZQJg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 26 May 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjEZQJg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 May 2023 12:09:36 -0400
X-Greylist: delayed 170433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 09:09:33 PDT
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3513D
        for <linux-security-module@vger.kernel.org>; Fri, 26 May 2023 09:09:33 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QSVHH60KKzMqG8D;
        Fri, 26 May 2023 18:09:31 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QSVHD3cfwzMpq8P;
        Fri, 26 May 2023 18:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685117371;
        bh=GWA0mFQb+8wMidUB9IFkGhraKuBAw7wtqDQzDAqbLj0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SHueMjFNo3rqrLqDwx3uLeE8+X5tcivE1oEPiVsupYo6ZiLJ/vTPNLG6eFJuARjXz
         EChyFftAMsPJ3se0xTmj43Dxi+ekN6Tb9V8ErOqv9uDvNm67z7yhPpfobsNkHwpj/z
         M1TjsYiSKBpBQcpWBvcaYrXlssdnU8/pqhuOht+c=
Message-ID: <4142c8dc-5385-fb1d-4f8b-2a98bb3f99af@digikod.net>
Date:   Fri, 26 May 2023 18:09:14 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [ANNOUNCE] KVM Microconference at LPC 2023
To:     Paolo Bonzini <pbonzini@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Alexander Graf <graf@amazon.com>,
        Forrest Yuan Yu <yuanyu@google.com>,
        John Andersen <john.s.andersen@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Marian Rotariu <marian.c.rotariu@gmail.com>,
        =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>,
        =?UTF-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thara Gopinath <tgopinath@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Zahra Tarkhani <ztarkhani@microsoft.com>,
        =?UTF-8?Q?=c8=98tefan_=c8=98icleru?= <ssicleru@bitdefender.com>,
        dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
References: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

See James Morris's proposal here: 
https://lore.kernel.org/all/17f62cb1-a5de-2020-2041-359b8e96b8c0@linux.microsoft.com/

On 26/05/2023 04:36, James Morris wrote:
 > [Side topic]
 >
 > Would folks be interested in a Linux Plumbers Conference MC on this
 > topic generally, across different hypervisors, VMMs, and architectures?
 >
 > If so, please let me know who the key folk would be and we can try 
writing
 > up an MC proposal.

The fine-grain memory management proposal from James Gowans looks 
interesting, especially the "side-car" virtual machines: 
https://lore.kernel.org/all/88db2d9cb42e471692ff1feb0b9ca855906a9d95.camel@amazon.com/


On 09/05/2023 11:55, Paolo Bonzini wrote:
> Hi all!
> 
> We are planning on submitting a CFP to host a KVM Microconference at
> Linux Plumbers Conference 2023. To help justify the proposal, we would
> like to gather a list of folks that would likely attend, and crowdsource
> a list of topics to include in the proposal.
> 
> For both this year and future years, the intent is that a KVM
> Microconference will complement KVM Forum, *NOT* supplant it. As you
> probably noticed, KVM Forum is going through a somewhat radical change in
> how it's organized; the conference is now free and (with some help from
> Red Hat) organized directly by the KVM and QEMU communities. Despite the
> unexpected changes and some teething pains, community response to KVM
> Forum continues to be overwhelmingly positive! KVM Forum will remain
> the venue of choice for KVM/userspace collaboration, for educational
> content covering both KVM and userspace, and to discuss new features in
> QEMU and other userspace projects.
> 
> At least on the x86 side, however, the success of KVM Forum led us
> virtualization folks to operate in relative isolation. KVM depends on
> and impacts multiple subsystems (MM, scheduler, perf) in profound ways,
> and recently we’ve seen more and more ideas/features that require
> non-trivial changes outside KVM and buy-in from stakeholders that
> (typically) do not attend KVM Forum. Linux Plumbers Conference is a
> natural place to establish such collaboration within the kernel.
> 
> Therefore, the aim of the KVM Microconference will be:
> * to provide a setting in which to discuss KVM and kernel internals
> * to increase collaboration and reduce friction with other subsystems
> * to discuss system virtualization issues that require coordination with
> other subsystems (such as VFIO, or guest support in arch/)
> 
> Below is a rough draft of the planned CFP submission.
> 
> Thanks!
> 
> Paolo Bonzini (KVM Maintainer)
> Sean Christopherson (KVM x86 Co-Maintainer)
> Marc Zyngier (KVM ARM Co-Maintainer)
> 
> 
> ===================
> KVM Microconference
> ===================
> 
> KVM (Kernel-based Virtual Machine) enables the use of hardware features
> to improve the efficiency, performance, and security of virtual machines
> created and managed by userspace.  KVM was originally developed to host
> and accelerate "full" virtual machines running a traditional kernel and
> operating system, but has long since expanded to cover a wide array of use
> cases, e.g. hosting real time workloads, sandboxing untrusted workloads,
> deprivileging third party code, reducing the trusted computed base of
> security sensitive workloads, etc.  As KVM's use cases have grown, so too
> have the requirements placed on KVM and the interactions between it and
> other kernel subsystems.
> 
> The KVM Microconference will focus on how to evolve KVM and adjacent
> subsystems in order to satisfy new and upcoming requirements: serving
> guest memory that cannot be accessed by host userspace[1], providing
> accurate, feature-rich PMU/perf virtualization in cloud VMs[2], etc.
> 
> 
> Potential Topics:
>     - Serving inaccessible/unmappable memory for KVM guests (protected VMs)
>     - Optimizing mmu_notifiers, e.g. reducing TLB flushes and spurious zapping
>     - Supporting multiple KVM modules (for non-disruptive upgrades)
>     - Improving and hardening KVM+perf interactions
>     - Implementing arch-agnostic abstractions in KVM (e.g. MMU)
>     - Defining KVM requirements for hardware vendors
>     - Utilizing "fault" injection to increase test coverage of edge cases
>     - KVM vs VFIO (e.g. memory types, a rather hot topic on the ARM side)
> 
> 
> Key Attendees:
>     - Paolo Bonzini <pbonzini@redhat.com> (KVM Maintainer)
>     - Sean Christopherson <seanjc@google.com>  (KVM x86 Co-Maintainer)
>     - Your name could be here!
> 
> [1] https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com
> [2] https://lore.kernel.org/all/CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com
> 
> 
