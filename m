Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE88575D064
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Jul 2023 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGURNu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jul 2023 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGURNu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 13:13:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC04C2D4E
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 10:13:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d00a63fcdefso1374144276.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689959628; x=1690564428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7shZuEDiffXRYK22UXnQcffVUND6wfTW4U7DmHj+BWc=;
        b=saEUf4445sfHkPWRX975heL8zENfXcs3PgCyCgvEVdQjEpNK/pp+iAjdHt4YEb3A4E
         Wx6AMp1fx4AxdUC7quE/wuY8PzajpllFI1PSVxa0GJ6TCvZZ95BwZYWsRgoM01BQ4SqE
         g1i1UMNIUCRiN6vVjQF+QtV7pxLVFxnr+vtjGFTshuCRS/R0Np16E0/qf+bH5mnx7XFz
         ZsljdMjRbBLWTIazxQedjqyAevMpWeXTTd8MiT3v+VX/sBebfo66Po7WIiS0jw2kNrZS
         H5psY9S7R0h0zicR7miAPapKCtbYppPvDwh7bNN96b+Zux6kO9omgHgr2n7bbHvjHh23
         55GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959628; x=1690564428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7shZuEDiffXRYK22UXnQcffVUND6wfTW4U7DmHj+BWc=;
        b=UViyeXEw/zKxlyWpZs4iB6d9Vzp7dL8GxxiohboYPjskgnLZnCzfgkl/PInnjWOwoO
         qSztMC45ABzZwkAxrQrWU0WudIl25qaMIboW5KCTyP+iVHTUivD0fyioCzR5oFco2be6
         Q1C64TG8eqpyLQ+n7MClk+6jcDXevzCGlNxy9ygY3NjXpVAf0BTMD225s3L6axBNwa23
         6CwTfzeSAYogZ/Y73XnEdHPfEr7zKiY5wG925fZgb49GIg0FJueD7e3lr1bK8t6kfTpU
         OIEVP8BkDm22UPhIqOg4vmGunvdnODItBo+Oavg7b1k2ycwv1hi6jAp4i1rJek8LB21j
         RAoQ==
X-Gm-Message-State: ABy/qLZ8WxIK+VzYFnGAowp1UD7cWC+7zYUr/JX2WGWl2ODZ16CDUyb9
        BDLi3/OIpzpUUVGWs8f5VJAZMdiQSLY=
X-Google-Smtp-Source: APBJJlHTu6oxQip7Fs57WKX81frcXYslN0cZxNmgdAvx9eWDlCTFu1+cjXODNvw8IvlIlsVUOd7h6YXth7Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:a28f:0:b0:c6e:fe1a:3657 with SMTP id
 c15-20020a25a28f000000b00c6efe1a3657mr16139ybi.3.1689959627795; Fri, 21 Jul
 2023 10:13:47 -0700 (PDT)
Date:   Fri, 21 Jul 2023 10:13:46 -0700
In-Reply-To: <84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-14-seanjc@google.com>
 <84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com>
Message-ID: <ZLq8ylTsFQ1s4BAZ@google.com>
Subject: Re: [RFC PATCH v11 13/29] KVM: Add transparent hugepage support for
 dedicated guest memory
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 21, 2023, Paolo Bonzini wrote:
> On 7/19/23 01:44, Sean Christopherson wrote:
> > @@ -413,6 +454,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> >   	u64 flags = args->flags;
> >   	u64 valid_flags = 0;
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		valid_flags |= KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
> > +
> 
> I think it should be always allowed.  The outcome would just be "never have
> a hugepage" if thp is not enabled in the kernel.

I don't have a strong preference.  My thinking was that userspace would probably
rather have an explicit error, as opposed to silently running with a misconfigured
setup.
