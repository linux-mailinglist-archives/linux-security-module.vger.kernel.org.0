Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433E7218B4
	for <lists+linux-security-module@lfdr.de>; Fri, 17 May 2019 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfEQM7U (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 May 2019 08:59:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:36736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728374AbfEQM7U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 08:59:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5168EAB92;
        Fri, 17 May 2019 12:59:18 +0000 (UTC)
Date:   Fri, 17 May 2019 14:59:16 +0200
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
        Mark Rutland <mark.rutland@arm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/4] gfp: mm: introduce __GFP_NO_AUTOINIT
Message-ID: <20190517125916.GF1825@dhcp22.suse.cz>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143537.10435-4-glider@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[It would be great to keep people involved in the previous version in the
CC list]

On Tue 14-05-19 16:35:36, Alexander Potapenko wrote:
> When passed to an allocator (either pagealloc or SL[AOU]B),
> __GFP_NO_AUTOINIT tells it to not initialize the requested memory if the
> init_on_alloc boot option is enabled. This can be useful in the cases
> newly allocated memory is going to be initialized by the caller right
> away.
> 
> __GFP_NO_AUTOINIT doesn't affect init_on_free behavior, except for SLOB,
> where init_on_free implies init_on_alloc.
> 
> __GFP_NO_AUTOINIT basically defeats the hardening against information
> leaks provided by init_on_alloc, so one should use it with caution.
> 
> This patch also adds __GFP_NO_AUTOINIT to alloc_pages() calls in SL[AOU]B.
> Doing so is safe, because the heap allocators initialize the pages they
> receive before passing memory to the callers.

I still do not like the idea of a new gfp flag as explained in the
previous email. People will simply use it incorectly or arbitrarily.
We have that juicy experience from the past.

Freeing a memory is an opt-in feature and the slab allocator can already
tell many (with constructor or GFP_ZERO) do not need it.

So can we go without this gfp thing and see whether somebody actually
finds a performance problem with the feature enabled and think about
what can we do about it rather than add this maint. nightmare from the
very beginning?
-- 
Michal Hocko
SUSE Labs
