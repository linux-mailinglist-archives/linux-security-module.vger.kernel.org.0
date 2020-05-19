Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE841DA428
	for <lists+linux-security-module@lfdr.de>; Tue, 19 May 2020 23:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgESVzy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 19 May 2020 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESVzx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 17:55:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD0C08C5C1
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 14:55:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so420268plz.13
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXHGDEKcsJjKOPTlCgs9XONcU2hu7j0lHWKKVgvqbX8=;
        b=kKzJ3E2y7F20KDgtPNfkIGsoFlOgPW0ZUtSNswoJwWn46hmaeGVtf97mTyZ9XKQFBN
         jNtLbgbwLyzJSnncL0pXFn/jO/oqtPjWPpy3eWv8nx2ozpOQGJp7QCSPtKldOFQ7cXbb
         yu4LTh1HLTFgYuHY8cmmLJXIQV/x9qPousf3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXHGDEKcsJjKOPTlCgs9XONcU2hu7j0lHWKKVgvqbX8=;
        b=e5xbHh/FeoeTtYiHvI4kKBZ6pNYj+8KiHK1qh0XS1KxVlTluUHTPZ0saKz5myEqXhB
         9HS/0np5+Qp2CCrMAkUK3vFyW8MyiVomYFUvAl2cJWmk/QC41Qlqa17G6su2Iu29DC2w
         LI2R23T4qEC0k62TdRXwn6zSk3LhpX1oK9LAuxBF6nzci02tYN+s/niyPqmg0IAL0Fcz
         K/fIME72mq9rjETzmMfL+as1sZqGtS3+KeevXUbzfwZ5UxqRIAipWmdQhmkMPuIx0N+v
         g7plDpE5LQDbs2r37VIXANAzexhw2sOJUY9Fx1ktjt5krkfZYlW51LIGaYz93RgwUOi1
         kX3Q==
X-Gm-Message-State: AOAM531gKPSW+vdp6C90cpSwlwdhKTxBGWZovjyQGEowqzoO2yX3J71i
        NNj62eYD8UQQq7Ldp95FBYNcSA==
X-Google-Smtp-Source: ABdhPJx+rEHTNe20I/vdcru/cq9D/lqLHOWgUntNkLbp/wnGkN1jiGXaUPlHlTzei7lMcdSYfDwJAA==
X-Received: by 2002:a17:902:be08:: with SMTP id r8mr1506428pls.260.1589925351640;
        Tue, 19 May 2020 14:55:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c63sm386943pfc.2.2020.05.19.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:55:50 -0700 (PDT)
Date:   Tue, 19 May 2020 14:55:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
Message-ID: <202005191442.515A0ED@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 18, 2020 at 07:29:00PM -0500, Eric W. Biederman wrote:
>  arch/alpha/kernel/binfmt_loader.c  | 11 +----
>  fs/binfmt_elf.c                    |  4 +-
>  fs/binfmt_elf_fdpic.c              |  4 +-
>  fs/binfmt_em86.c                   | 13 +----
>  fs/binfmt_misc.c                   | 69 ++++-----------------------
>  fs/binfmt_script.c                 | 82 ++++++++++++++------------------
>  fs/exec.c                          | 97 ++++++++++++++++++++++++++------------
>  include/linux/binfmts.h            | 36 ++++++--------
>  include/linux/lsm_hook_defs.h      |  3 +-
>  include/linux/lsm_hooks.h          | 52 +++++++++++---------
>  include/linux/security.h           | 14 ++++--
>  kernel/cred.c                      |  3 ++
>  security/apparmor/domain.c         |  7 +--
>  security/apparmor/include/domain.h |  2 +-
>  security/apparmor/lsm.c            |  2 +-
>  security/commoncap.c               |  9 ++--
>  security/security.c                |  9 +++-
>  security/selinux/hooks.c           |  8 ++--
>  security/smack/smack_lsm.c         |  9 ++--
>  security/tomoyo/tomoyo.c           | 12 ++---
>  20 files changed, 202 insertions(+), 244 deletions(-)

Oh, BTW, heads up on this (trivially but annoyingly) conflicting with
the copy_strings_kernel/copy_string/kernel change:

https://ozlabs.org/~akpm/mmotm/broken-out/exec-simplify-the-copy_strings_kernel-calling-convention.patch

Is it worth pulling that and these into your tree?

https://ozlabs.org/~akpm/mmotm/broken-out/exec-open-code-copy_string_kernel.patch

https://ozlabs.org/~akpm/mmotm/broken-out/umh-fix-refcount-underflow-in-fork_usermode_blob.patch


-- 
Kees Cook
