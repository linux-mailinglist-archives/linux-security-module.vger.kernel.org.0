Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75512942EE
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Oct 2020 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbgJTTTS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 20 Oct 2020 15:19:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57531 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391170AbgJTTTR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Oct 2020 15:19:17 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kUxAA-0002mX-JF
        for linux-security-module@vger.kernel.org; Tue, 20 Oct 2020 19:19:14 +0000
Received: by mail-qk1-f198.google.com with SMTP id j185so2762463qkf.7
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 12:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FqqSeg/bCyOeyqz7A1Q415iiRjBhbX8psNpMHRp7K2w=;
        b=gOhMknICne3sQYZP6KDuWN1OOW+1ULAMky2/Y4W/47BkCq7kMfmBHgs3iDwvAShTT/
         4os+y/H8gZwmG5BIL1LW5ngruf33OsGmiYwKBP+WT1O5AU84PFLbSQjaTdmkeGW6FX46
         EYlhgqNdAuYY7GAACEizIZQ1jqHCPBE//t9H8bnQfIcxOFEMVoltLXvIHrJH4++zYjPv
         rI1evU1YICcfElgV15MEogEdQcdxU3RhHibHMXTMYZKCuJOAI2wYZiJDGmq1IhkLHSqz
         1dPMhpw2upxFjgFGEIgGbHFrBIwsMLQ8fj7RD1YE5tSaOSJRa9BLX36/fGym8UZcc9b+
         puEA==
X-Gm-Message-State: AOAM5322qc6V3UBUoySu6z1kfy9sMZt1e7MJf7sBazduOn9JXv9xNlGf
        9JuaP6HVm+Tj5G9NnEPC2dZcix6rpgEDcLaT+YUKX7Ecq1fanvPr2MOtfWNZXv70vpiBqfyLC2+
        jhi+ds5X8wDTUx0uNDYxc9Vve/GpRxSLoIATWhu6rNHC3f5A4BVY5Kw==
X-Received: by 2002:a37:61d0:: with SMTP id v199mr4153532qkb.208.1603221553210;
        Tue, 20 Oct 2020 12:19:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOPi++qpAgYzAyEfboIs+zkD7OqvlS2/RI3sqk+6wCVsDU2YbxaWqVk9uyIVt/PCEHEd2MoA==
X-Received: by 2002:a37:61d0:: with SMTP id v199mr4153507qkb.208.1603221552675;
        Tue, 20 Oct 2020 12:19:12 -0700 (PDT)
Received: from [192.168.1.75] (200-160-93-101.static-user.ajato.com.br. [200.160.93.101])
        by smtp.gmail.com with ESMTPSA id h125sm1298325qkc.36.2020.10.20.12.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 12:19:11 -0700 (PDT)
Subject: Re: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
To:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, david@redhat.com
Cc:     linux-mm@kvack.org, kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@gpiccoli.net,
        cascardo@canonical.com, Alexander Potapenko <glider@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>, gpiccoli@canonical.com
References: <20201019182853.7467-1-gpiccoli@canonical.com>
 <20201020082022.GL27114@dhcp22.suse.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <9cecd9d9-e25c-4495-50e2-8f7cb7497429@canonical.com>
Date:   Tue, 20 Oct 2020 16:19:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020082022.GL27114@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Michal, thanks a lot for your thorough response. I'll address the
comments inline, below. Thanks also David and Mike - in fact, I almost
don't need to respond here after Mike, he was right to the point I'm
going to discuss heh...


On 20/10/2020 05:20, Michal Hocko wrote:
> 
> Yes zeroying is quite costly and that is to be expected when the feature
> is enabled. Hugetlb like other allocator users perform their own
> initialization rather than go through __GFP_ZERO path. More on that
> below.
> 
> Could you be more specific about why this is a problem. Hugetlb pool is
> usualy preallocatd once during early boot. 24s for 65GB of 2MB pages
> is non trivial amount of time but it doens't look like a major disaster
> either. If the pool is allocated later it can take much more time due to
> memory fragmentation.
> 
> I definitely do not want to downplay this but I would like to hear about
> the real life examples of the problem.

Indeed, 24s of delay (!) is not so harmful for boot time, but...64G was
just my simple test in a guest, the real case is much worse! It aligns
with Mike's comment, we have complains of minute-like delays, due to a
very big pool of hugepages being allocated.

Users have their own methodology for allocating pages, some would prefer
do that "later" for a variety of reasons, so early boot time allocations
are not always used, that shouldn't be the only focus of the discussion
here.
In the specific report I had, the user complains about more than 3
minutes to allocate ~542G of 2M hugetlb pages.

Now, you'll ask why in the heck they are using init_on_alloc then -
right? So, the Kconfig option "CONFIG_INIT_ON_ALLOC_DEFAULT_ON" is set
by default in Ubuntu, for hardening reasons. So, the workaround for the
users complaining of delays in allocating hugetlb pages currently is to
set "init_on_alloc" to 0. It's a bit lame to ask users to disable such
hardening thing just because we have a double initialization in hugetlb...


> 
> 
> This has been discussed already (http://lkml.kernel.org/r/20190514143537.10435-4-glider@google.com.
> Previously it has been brought up in SLUB context AFAIR. Your numbers
> are quite clear here but do we really need a gfp flag with all the
> problems we tend to grow in with them?
> 
> One potential way around this specifically for hugetlb would be to use
> __GFP_ZERO when allocating from the allocator and marking the fact in
> the struct page while it is sitting in the pool. Page fault handler
> could then skip the zeroying phase. Not an act of beauty TBH but it
> fits into the existing model of the full control over initialization.
> Btw. it would allow to implement init_on_free semantic as well. I
> haven't implemented the actual two main methods
> hugetlb_test_clear_pre_init_page and hugetlb_mark_pre_init_page because
> I am not entirely sure about the current state of hugetlb struct page in
> the pool. But there should be a lot of room in there (or in tail pages).
> Mike will certainly know much better. But the skeleton of the patch
> would look like something like this (not even compile tested).
> [code...]

Thanks a lot for pointing the previous discussion for me! I should have
done my homework properly and read all versions of the patchset...my
bad! I'm glad to see this problem was discussed and considered early in
the patch submission, I guess it only missed more real-world numbers.

Your approach seems interesting, but as per Mike's response (which seems
to have anticipated all my arguments heheh) your approach is a bit
reversed, solving a ""non-existent"" problem (of zeroing hugetlb pages
in fault time), whereas the big problem hereby tentatively fixed is the
massive delay on allocation time of the hugetlb pages.

I understand that your suggestion has no burden of introducing more GFP
flags, and I agree that those are potentially dangerous if misused (and
I totally agree with David that __GFP_NOINIT_ON_ALLOC is heinous, I'd
rather go with the originally proposed __GFP_NO_AUTOINIT), but...
wouldn't it be letting the code just drive a design decision? Like "oh,
adding a flag is so bad..better just let this bug/perf issue to stay".

I agree with the arguments here, don't get me wrong - specially since
I'm far from being any kind of mm expert, I trust your judgement that
GFP flags are the utmost villains, but at the same time I'd rather not
change something (like the hugetlb zeroing code) that is not really
fixing the hereby discussed issue. I'm open to other suggestions, of
course, but the GFP flag seems the least hacky way for fixing that, and
ultimately, the flags are meant for this, right? Control page behavior
stuff.

About misuse of a GFP flag, this is a risk for every "API" on kernel,
and we rely in the (knowingly great) kernel review process to block
that. We could even have a more "terrifying" comment there around the
flag, asking new users to CC all relevant involved people in the patch
submission before using that...

Anyway, thanks a bunch for the good points raised here Michal, David and
Mike, and appreciate your patience with somebody trying to mess your GFP
flags. Let me know your thoughts!

Cheers,


Guilherme
