Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5956CD0
	for <lists+linux-security-module@lfdr.de>; Wed, 26 Jun 2019 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfFZOtr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 26 Jun 2019 10:49:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728240AbfFZOtq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 10:49:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CFCFAC2E;
        Wed, 26 Jun 2019 14:49:45 +0000 (UTC)
Date:   Wed, 26 Jun 2019 16:49:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
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
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <20190626144943.GY17798@dhcp22.suse.cz>
References: <20190626121943.131390-1-glider@google.com>
 <20190626121943.131390-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626121943.131390-2-glider@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed 26-06-19 14:19:42, Alexander Potapenko wrote:
[...]
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 8c94c89a6f7e..fe5d33060415 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
[...]
> @@ -428,6 +428,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>  	}
>  
>  	offset = vaddr - page->vaddr;
> +	if (want_init_on_free())
> +		memset(vaddr, 0, pool->size);

any reason why this is not in DMAPOOL_DEBUG else branch? Why would you
want to both zero on free and poison on free?

>  #ifdef	DMAPOOL_DEBUG
>  	if ((dma - page->dma) != offset) {
>  		spin_unlock_irqrestore(&pool->lock, flags);

[...]

> @@ -1142,6 +1200,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	}
>  	arch_free_page(page, order);
>  	kernel_poison_pages(page, 1 << order, 0);
> +	if (want_init_on_free())
> +		kernel_init_free_pages(page, 1 << order);

same here. If you don't want to make this exclusive then you have to
zero before poisoning otherwise you are going to blow up on the poison
check, right?

>  	if (debug_pagealloc_enabled())
>  		kernel_map_pages(page, 1 << order, 0);
>  
-- 
Michal Hocko
SUSE Labs
