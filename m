Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1A1581A4
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Feb 2020 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBJRqu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 10 Feb 2020 12:46:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39038 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgBJRqs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Feb 2020 12:46:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so8220196ljg.6
        for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2020 09:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMABvWd/7c4TphsJ+M/Bzt18EBtYsvxejNNk0qYwcjM=;
        b=AJWGb7viPUuSlXbBtks15QbiGc0V+5N1kFBw6HmGv/BocUHZwmHNnivHvSwIiPeEQm
         1fliH10RGyoPY6yV4O5rwY5izrulFkNof0M2GsGbSrfCirug6Mx7f0jNvrzCMioGftQD
         acWtx/PsAUjj64YLYfwg5kSuWK5If6M0QpBoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMABvWd/7c4TphsJ+M/Bzt18EBtYsvxejNNk0qYwcjM=;
        b=dLU94MTz8ZCkIdrb+36f64wrdiPA4m9ZM3hBP1f0QlAnOOAB2Z5qfMwYfCpPiNnG7f
         +bqzJogtdN1r+BBhn8due2QDYJGcXo+niii6+8UJ9PHT4On3yTQaMLnQ8zTKbQNXCkpX
         fTOOuPYFRQwSG94673bIxZvDCX+CeK+w4q1HGK+LNi78R7kHH7kXIp5KjLqn8QABms1I
         nEPCHTFKRQy9uf94iQeILZ7m8fAj0KC9h10wavXntDsmEXKzAMRSnnz2+QHoDFrUwkLC
         5KFZ6DezQa4kpos5FaLjmms5X7OCdYmFrwYnV+/rhgoOMQAnTWpyYwwTpBxssirNvHGM
         MX4g==
X-Gm-Message-State: APjAAAXlx+af+KNY5F06tmwpVlNkL8JtOupKHPhvPg/3sb2d/uqx5Rfg
        NWDgAIyhXNilGTfrEuUtsqMsy39Nfuw=
X-Google-Smtp-Source: APXvYqwz+PuicCoMRpbEcK9RhtZEXg+Qb56jox8xvgy/uZVlttcM+t+MTlW98tcJzWONdcvN9iNgUg==
X-Received: by 2002:a2e:9110:: with SMTP id m16mr1579762ljg.140.1581356804897;
        Mon, 10 Feb 2020 09:46:44 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n206sm485436lfd.50.2020.02.10.09.46.42
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:46:43 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id x14so8176477ljd.13
        for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2020 09:46:42 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1591348lja.204.1581356802297;
 Mon, 10 Feb 2020 09:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-8-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-8-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Feb 2020 09:46:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Message-ID: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.
>
> The RCU lock is used because the number of reads at the task exit time
> is much larger than the number of procfs mounts.

Ok, this looks better to me than the previous version.

But that may be the "pee-in-the-snow" effect, and I _really_ want
others to take a good look at the whole series.

The right people seem to be cc'd, but this is pretty core, and /proc
has a tendency to cause interesting issues because of how it's
involved in a lot of areas indirectly.

Al, Oleg, Andy, Eric?

             Linus
