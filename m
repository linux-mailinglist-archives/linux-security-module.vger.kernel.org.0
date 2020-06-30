Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9086020FA00
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Jun 2020 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389903AbgF3Q7I (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 30 Jun 2020 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389893AbgF3Q7H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jun 2020 12:59:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0087C061755
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 09:59:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so16276543lji.9
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep4v7Sgk0x30ZAXgHmmvI+chKVNBUjoHn6j3LyL4OVk=;
        b=bDLuMC1J3ipv5oxg6WsuGLNLBbaQ55mOuGN9gmYd6tux50ZveMInMrUVjkMhagmtQ5
         qLh1w/kcYRGFnMfNjLBP+bjgbKz0yTX5dUcCzabJRir+X9IwGpmmbEP2RWkxzYIDhJt9
         UTsF2pc9EMEECfBDdQEKoYZ3atlchjta3NnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep4v7Sgk0x30ZAXgHmmvI+chKVNBUjoHn6j3LyL4OVk=;
        b=FXy0b/3RbZ3UGvCL+fJEZomxCKwZVa3JNCEo/WwZzHoGUr7XJxlXLw9um5svXdG7by
         RlYP+8SH9Iu2ukQDjDoU0/SuwMQNbI4OCIE8V14DpsJLfwrrvRau3//sDZPxuGlUPmgE
         2hsJLlLPMROi5YsBz11CZDz+1UqGv6XIR+S2Q9nnpsMGRfQEEF4LMabtgHRgVy+yd8u6
         sao8kF8SVTJmZYazWcgyB98NY8ploWGUrz/uXKJgTBxHxQ2fYkWyHvaHboKTvlSGF6U4
         UfRg8DFvozf9U/GPwFjM1HxqqvEEmxkn/ahijXPRlfhLUC4Z8vpy1keDf8BRFaEhBNnK
         g0DQ==
X-Gm-Message-State: AOAM533D4TOws1Wjyi8xRa3oN6WPgvNHuY4K/hs4dMD9p4qJRcfVvAeR
        sAgrheFqb7wWgGuIEtowGGbE4s8VsVc=
X-Google-Smtp-Source: ABdhPJzU/qWVJqt0+IknaMR7ktufM+/rXcibuKtMWn/ir3phZgbTDphP+ICqS0Q8OilqgJUwtRjrsQ==
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr11661580ljp.368.1593536345703;
        Tue, 30 Jun 2020 09:59:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u26sm1124868lfq.72.2020.06.30.09.59.04
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 09:59:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e4so23456383ljn.4
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 09:59:04 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr5624686lji.371.1593536343609;
 Tue, 30 Jun 2020 09:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200625095725.GA3303921@kroah.com> <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com> <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org> <87imf963s6.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87imf963s6.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 09:58:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Message-ID: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] umh: Separate the user mode driver and the user
 mode helper support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 29, 2020 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This makes it clear which code is part of the core user mode
> helper support and which code is needed to implement user mode
> drivers.
>
>  kernel/umd.c             | 146 +++++++++++++++++++++++++++++++++++++++
>  kernel/umh.c             | 139 -------------------------------------

I certainly don't object to the split, but I hate the name.

We have uml, umd and umh for user mode {linux, drivers, helper}
respectively.And honestly, I don't see the point in using an obscure
and unreadable TLA for something like this.

I really don't think it would hurt to write out even the full name
with "usermode_driver.c" or something like that, would it?

Then "umd" could be continued to be used as a prefix for the helper
functions, by all means, but if we startv renaming files, can we do it
properly?

                   Linus
