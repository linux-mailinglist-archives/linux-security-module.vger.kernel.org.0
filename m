Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779221E6B70
	for <lists+linux-security-module@lfdr.de>; Thu, 28 May 2020 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgE1Toz (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 28 May 2020 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgE1Toy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:44:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C19C08C5C6;
        Thu, 28 May 2020 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7dH7/wqGQYUhGLFyHpl4QVuiKHZ8TJfm6m4hIlJFCU=; b=tpJB5DRG71JcOlL/QbiSxI7K5w
        oTGjW2VsvhDjsXVucoZ70kvRuxv1QP/5c6OywuIyRmSMFFBr4MZ48Y+PzOo8Al+oarjiHEa1iN9wp
        ky9phVHRj3h6fWDyhOw+BQWwEC/lxUYEZzEDzSstWeIYv2ZtkACb1XIlxIIQRKdofnwXVWypGd2Vy
        pew9P2+Q6BwWzjPA9MhY6Nhh7LkdxQV5xtHiJM4VbpW/Qky0DsDu60zRwMaRRE0CnkNNtsuIGVtvP
        fEy4NDcALXKejbtJKpi+3sD8qcpypSeLDoW55RsaD21f9C48TawCNL4A7G1OCAUgsyUPPIgzLzRKU
        Rv5C03gw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeOSH-0001Tf-La; Thu, 28 May 2020 19:44:41 +0000
Date:   Thu, 28 May 2020 12:44:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: clean up kernel_{read,write} & friends v2
Message-ID: <20200528194441.GQ17206@bombadil.infradead.org>
References: <20200528054043.621510-1-hch@lst.de>
 <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <f68b7797aa73452d99508bdaf2801b3d141e7a69.camel@perches.com>
 <20200528193340.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528193340.GR23230@ZenIV.linux.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 28, 2020 at 08:33:40PM +0100, Al Viro wrote:
> On Thu, May 28, 2020 at 12:22:08PM -0700, Joe Perches wrote:
> 
> > Hard limits at 80 really don't work well, especially with
> > some of the 25+ character length identifiers used today.
> 
> IMO any such identifier is a good reason for a warning.
> 
> The litmus test is actually very simple: how unpleasant would it be
> to mention the identifiers while discussing the code over the phone?

Here's a good example of a function which should be taken out and shot:

int amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct amdgpu_devic
e *adev,
...
        switch (frev) {
        case 2:
                switch (crev) {
...
                        if (profile->ucElbVDDC_Num > 0) {
                                for (i = 0; i < profile->ucElbVDDC_Num; i++) {
                                        if (vddc_id_buf[i] == virtual_voltage_id) {
                                                for (j = 0; j < profile->ucLeakageBinNum; j++) {
                                                        if (vbios_voltage_id <= leakage_bin[j]) {
                                                                *vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];

I mean, I get it that AMD want to show off just how studly a monitor they
support, but good grief ...
