Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953A01FBC3D
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jun 2020 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgFPQ7p (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Jun 2020 12:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbgFPQ7n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 12:59:43 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4945E214DB
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592326782;
        bh=8d3TrxrA8Yg5Ytejwq8g7SbccMfxeMH87bM2/PPxd3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0z2UNkU/quQA4kn04Vf3GVxiG8SHeVXqZx4B3gJ0yB3m2GqsQRphvW8smEv0n/nJQ
         0/q6d8dz8BX3EHKGJQoCAF1xc+hXW5k3Qmf12mVju9jXNmKN0C0J3XHKvWE3h9oyny
         FY8ilYY6KGMe/1s6s9GDVWIGo78rwBB/+/9bY0W8=
Received: by mail-wm1-f41.google.com with SMTP id d128so3859747wmc.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 09:59:42 -0700 (PDT)
X-Gm-Message-State: AOAM531A84TKcYTtSMj06ybL0S090IrXd9Chv+ldzq0Tvw0hj6AR+bId
        66OR2IzoloWflRBNdsmqf1nmTIncoP7Fbn3wcGPj8g==
X-Google-Smtp-Source: ABdhPJylrWQKE69MJcAA+tI8FFT9AzaNafaydA0oEjUGWHIJPejchXkcE2A0e1t1EJQPakBymQe8jze29E+inYYItzM=
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr4204037wmf.21.1592326780898;
 Tue, 16 Jun 2020 09:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org> <20200616074934.1600036-7-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-7-keescook@chromium.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Jun 2020 09:59:29 -0700
X-Gmail-Original-Message-ID: <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
Message-ID: <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] x86: Provide API for local kernel TLB flushing
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> The seccomp constant action bitmap filter evaluation routine depends
> on being able to quickly clear the PTE "accessed" bit for a temporary
> allocation. Provide access to the existing CPU-local kernel memory TLB
> flushing routines.

Can you write a better justification?  Also, unless I'm just
incompetent this morning, I can't find anyone calling this in the
series.
