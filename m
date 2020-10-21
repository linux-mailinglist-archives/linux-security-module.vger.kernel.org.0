Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E929481A
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Oct 2020 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440466AbgJUGZd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Oct 2020 02:25:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbgJUGZd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Oct 2020 02:25:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DJNIVscyqxMKJYlByh6xwl1TJLuqFNXcwS2T00v+Fk=;
        b=mQnN+PraAQxTWkc028/rmMdj4i7gA4GHq4+e1vlpoIOvFi/IwR8Q7ko/PNUVxgiNV0hFr7
        FzAXXvwcsTTLH5uVUxkx2GLYNy9cD/RgkmRW4kMDK6BP7kAp2uu4yTGgRyq3D1+RBZCgKd
        CrunrBNhrn4jNvDr21TyoIj51lpDyd0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 748B2AC12;
        Wed, 21 Oct 2020 06:25:31 +0000 (UTC)
Date:   Wed, 21 Oct 2020 08:25:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Alexander Potapenko <glider@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
Message-ID: <20201021062530.GB23790@dhcp22.suse.cz>
References: <20201019182853.7467-1-gpiccoli@canonical.com>
 <20201020082022.GL27114@dhcp22.suse.cz>
 <9cecd9d9-e25c-4495-50e2-8f7cb7497429@canonical.com>
 <5650dc95-4ae2-05d3-c71a-3828d35bd49b@redhat.com>
 <CAHD1Q_wQrnSEGOvbCi0uhHZ5bRf=inzPdOhGKJ9PkVms5GSWRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHD1Q_wQrnSEGOvbCi0uhHZ5bRf=inzPdOhGKJ9PkVms5GSWRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue 20-10-20 17:19:42, Guilherme Piccoli wrote:
> When I first wrote that, the design was a bit different, the flag was
> called __GFP_HTLB_PAGE or something like that. The design was to
> signal/mark the composing pages of hugetlb as exactly this: they are
> pages composing a huge page of hugetlb "type". Then, I skipped the
> "init_on_alloc" thing for such pages.

As pointed out in the other email. This is not about hugetlb although
this might be visible more than other because they just add a tiny bit
to an overall overhead. Each page cache read, CoW and many many other
!__GFP_ZERO users are in the same position when they double initialize.
A dedicated __GFP_HTLB_PAGE is really focusing on a wrong side of the
problem. We do have __GFP_ZERO for a good reason and that is to optimize
the initialization. init_on_alloc goes effectively against this approach
with a "potentially broken code" philosophy in mind and that is good as
a hardening measure indeed. But that comes with an increased overhead
and/or shifted layer when the overhead happens. Sure there is some room
to optimize the code here and there but the primary idea of the
hardening is to make the initialization dead trivial and clear that
nothing can sneak out.

-- 
Michal Hocko
SUSE Labs
