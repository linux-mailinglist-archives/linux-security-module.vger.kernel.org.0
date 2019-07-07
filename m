Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C84E612AB
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2019 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfGFSdP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Jul 2019 14:33:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35879 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfGFSdP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 14:33:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so12137418oti.3
        for <linux-security-module@vger.kernel.org>; Sat, 06 Jul 2019 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8R4z3fd/pNkVMb+89dxA4ui8k10ocj37Bt7whLaC1Q=;
        b=rMLJmYNuSevuKWuCiVdI43bNmxi2G3pHLMt7d6UgYRzPT5IXjgo/GT6keDasRoZK4g
         /OBhvjWjUYS2v0qo9lkIJjfjkWE4kQLRuB6HOjB54kxbMOj7Ibd3pgQiMMTDL/I/5iCg
         2BeOM0HRHns6OEvAIi7NDoj2y/dlF3VxnijP9I+3HzHbLr7M1LTr+5Cg10Syh3dz5oTS
         pBae4r8DF086crOJ38wMkDHMpLDL60ovH7rl6Se08aUjhSzMzcn0vQpNsNrr1cgMoU/P
         YlfFMVxPhwry/SRvgTR1K80hTe9zWiuHkC34F1tIefAjUxRB4y7wu0+32btM3e8V9hGs
         3xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8R4z3fd/pNkVMb+89dxA4ui8k10ocj37Bt7whLaC1Q=;
        b=FZcwoDUn2IQHUyW/fcMhxdp1Is6FbsChfTzmSuIr3zXj1hljzgcj1WPa+QkjGApJ5t
         Gzt86ssvulUfFSBlu69CXe6wfm6TFPL7XIj6u8sikqF35b4iO5IzyHPTOj6I+/R5Ypvm
         HAWpX0h/VhHifkC30igIlExLSnitlk9Gw66423x5TVuR1EfBj0RZplHws9rfMvbiAicr
         gyBPYSLcC3uzKdf2s4fxfjtb66H3dHdv0MB6utxGoV8IBXsvF5iCNEaqeXjTFVXPXnqc
         3h+SY4lh/HHnTj3dJzkfD5FQhuGYyAyuI599N4nuvEEfHsAWfhyA2XFuLJ1HumcBmDON
         bnMA==
X-Gm-Message-State: APjAAAWkrb9ac5xWPDfjnboUgtkyhFnFvbpEjz/SwV2veiNAZJY45fDM
        vVktVXzIaR/kwR0BxnGzcOvRhcNDp1IEoZOMSp9bhA==
X-Google-Smtp-Source: APXvYqyBcck06VlUCnJhTINmdA4ZJqB4oH2g6lhQMqchyhM/oF3KhFa6xeVxaox70u4OowtbK7dZn6ufESL4f0s1zvE=
X-Received: by 2002:a9d:774a:: with SMTP id t10mr7301075otl.228.1562437994877;
 Sat, 06 Jul 2019 11:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com>
In-Reply-To: <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 6 Jul 2019 20:32:48 +0200
Message-ID: <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Creation of a generic Discrete Finite Automata implementation
> for string matching. The transition tables have to be produced
> in user-space.
> This allows us to possibly support advanced string matching
> patterns like regular expressions, but they need to be supported
> by user-space tools.

AppArmor already has a DFA implementation that takes a DFA machine
from userspace and runs it against file paths; see e.g.
aa_dfa_match(). Did you look into whether you could move their DFA to
some place like lib/ and reuse it instead of adding yet another
generic rule interface to the kernel?

[...]
> +++ b/security/sara/dfa.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * S.A.R.A. Linux Security Module
> + *
> + * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.

Throughout the series, you are adding files that both add an SPDX
identifier and have a description of the license in the comment block
at the top. The SPDX identifier already identifies the license.
