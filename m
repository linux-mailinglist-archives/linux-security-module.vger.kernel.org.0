Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA62197E
	for <lists+linux-security-module@lfdr.de>; Fri, 17 May 2019 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfEQOEr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 May 2019 10:04:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728535AbfEQOEr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 10:04:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91A89AC38;
        Fri, 17 May 2019 14:04:46 +0000 (UTC)
Date:   Fri, 17 May 2019 16:04:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <20190517140446.GA8846@dhcp22.suse.cz>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143537.10435-2-glider@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue 14-05-19 16:35:34, Alexander Potapenko wrote:
> The new options are needed to prevent possible information leaks and
> make control-flow bugs that depend on uninitialized values more
> deterministic.
> 
> init_on_alloc=1 makes the kernel initialize newly allocated pages and heap
> objects with zeroes. Initialization is done at allocation time at the
> places where checks for __GFP_ZERO are performed.
> 
> init_on_free=1 makes the kernel initialize freed pages and heap objects
> with zeroes upon their deletion. This helps to ensure sensitive data
> doesn't leak via use-after-free accesses.

Why do we need both? The later is more robust because even free memory
cannot be sniffed and the overhead might be shifted from the allocation
context (e.g. to RCU) but why cannot we stick to a single model?
-- 
Michal Hocko
SUSE Labs
