Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F65294810
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Oct 2020 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408608AbgJUGPl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Oct 2020 02:15:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408591AbgJUGPl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Oct 2020 02:15:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603260939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnNv50uuLZezOPCc/pCo9vpUPBcoeAYkVhwzzQs6a1Q=;
        b=i2QWh7wvb6Q7zuMyhwI9RL5MNOAIpuRZtB2s/DAWtqIQtTRjPfxfNok0IC+JyQPmdM/cKl
        6Fw6lPNf7MICyJqiOd30R3d3BZy5VyW9YCDhKiOnhxOG/7aG8rEkK1MMJER0XLSgHJrOVE
        XySrLlqWaVzcsGQFOIZQOX1cAEKaH8U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4EE98AC48;
        Wed, 21 Oct 2020 06:15:39 +0000 (UTC)
Date:   Wed, 21 Oct 2020 08:15:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, david@redhat.com,
        linux-mm@kvack.org, kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@gpiccoli.net,
        cascardo@canonical.com, Alexander Potapenko <glider@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
Message-ID: <20201021061538.GA23790@dhcp22.suse.cz>
References: <20201019182853.7467-1-gpiccoli@canonical.com>
 <20201020082022.GL27114@dhcp22.suse.cz>
 <9cecd9d9-e25c-4495-50e2-8f7cb7497429@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cecd9d9-e25c-4495-50e2-8f7cb7497429@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue 20-10-20 16:19:06, Guilherme G. Piccoli wrote:
> On 20/10/2020 05:20, Michal Hocko wrote:
> > 
> > Yes zeroying is quite costly and that is to be expected when the feature
> > is enabled. Hugetlb like other allocator users perform their own
> > initialization rather than go through __GFP_ZERO path. More on that
> > below.
> > 
> > Could you be more specific about why this is a problem. Hugetlb pool is
> > usualy preallocatd once during early boot. 24s for 65GB of 2MB pages
> > is non trivial amount of time but it doens't look like a major disaster
> > either. If the pool is allocated later it can take much more time due to
> > memory fragmentation.
> > 
> > I definitely do not want to downplay this but I would like to hear about
> > the real life examples of the problem.
> 
> Indeed, 24s of delay (!) is not so harmful for boot time, but...64G was
> just my simple test in a guest, the real case is much worse! It aligns
> with Mike's comment, we have complains of minute-like delays, due to a
> very big pool of hugepages being allocated.

The cost of page clearing is mostly a constant overhead so it is quite
natural to see the time scaling with the number of pages. That overhead
has to happen at some point of time. Sure it is more visible when
allocating during boot time resp. when doing pre-allocation during
runtime. The page fault path would be then faster. The overhead just
moves to a different place. So I am not sure this is really a strong
argument to hold.

[...]

> Now, you'll ask why in the heck they are using init_on_alloc then -
> right? So, the Kconfig option "CONFIG_INIT_ON_ALLOC_DEFAULT_ON" is set
> by default in Ubuntu, for hardening reasons.

This is not really that important as long as you properly explain your
users what to expect from the default configuration. The hardening
aspect of this default might be really valuable but it comes with a
price. A non trivial one. The example you have highlighted is just one
from many. The one we can actually workaround although the more I think
about it the less I am convinced this is a good idea.

Effectively _any_ !__GFP_ZERO allocation suffers from double
initialization in one form or another. In the worst case the whole
content of the page gets overwritten. Consider any page cache allocation
for read for example.  This is GFP_*USER* request that gets overwritten
by the file content. Is this visible? Not really on a single page
but consider how many pages you read from disk and you will get a
considerable overhead. Should we exempt these allocations as well to
reduce the overhead? I dot think so. This directly undermines the
objective of the hardening. AFAIU the whole point of init_on_alloc is to
prevent from previous content leaking to a new user without relying the
new user is going to do right thing and initialize everything properly.

Hugetlb is no different here. It just doesn't bother to implement what
init_on_{alloc,free} promises. If there is a bug in hugetlb fault
handler then you can still leak data from one user to another
potentially. GFP_I_WANT_TO_OPT_OUT is actually allowing to increase the
number of users who would like to reduce overhead and risk data leak.
The power of unconditional initialization is in the fact that this is
clearly trivial to check that nothing gets missed.

> So, the workaround for the
> users complaining of delays in allocating hugetlb pages currently is to
> set "init_on_alloc" to 0. It's a bit lame to ask users to disable such
> hardening thing just because we have a double initialization in hugetlb...

It is not lame. It is expressing that people do not want to pay
additional price for the hardening or they are not aware of the cost
benefit here.
 
> Your approach seems interesting, but as per Mike's response (which seems
> to have anticipated all my arguments heheh) your approach is a bit
> reversed, solving a ""non-existent"" problem (of zeroing hugetlb pages
> in fault time), whereas the big problem hereby tentatively fixed is the
> massive delay on allocation time of the hugetlb pages.

Yes, my approach is not great either because it breaks the core
assumption of init_on_alloc and that is that the initialization is done
at a well defined spot. It had to go to all callers of the hugetlb
allocator (alloc_buddy_huge_page) and fix them up. The proper thing to
do would be to do the initialization (or opt out if the page is
pre-zeroed either from the page allocator or from init_on_free) in
alloc_buddy_huge_page.

[...]

> About misuse of a GFP flag, this is a risk for every "API" on kernel,
> and we rely in the (knowingly great) kernel review process to block
> that.

Been there done that. There were and still are many examples. I have
spent non-trivial time on clean ups. My experience is that the review
process simply doesn't stop random drivers or subsystems to do what they
think is right.

> We could even have a more "terrifying" comment there around the
> flag, asking new users to CC all relevant involved people in the patch
> submission before using that...

Been there done that. There is always room to improve though.
-- 
Michal Hocko
SUSE Labs
