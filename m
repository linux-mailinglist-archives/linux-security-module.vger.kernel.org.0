Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6319C6C9
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Apr 2020 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgDBQLw (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Apr 2020 12:11:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35079 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389704AbgDBQLv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Apr 2020 12:11:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id d15so1429020lfn.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2020 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yt6zWERiKTCjDwTG56J7PYbCEtxdXxHidONUlaX/0Js=;
        b=cRMdri6VXL1PrIKwuy81gkl35L7PPDq29lpPSc9oxeCIc5SGIiqZg8pZqrkDDLnVb9
         ATIfA6ph4AX+mgQJ2g4xFtlTed8dXG9kFXpWDDmRmc9iZRJ/VvaCXIYwKdNcvGxYya9T
         JrvodRpKIVTZYh5OZgKCQvDiX1x+OBqYoVfSEje9Sjp+wrWHzZu7VuCxoB8n27O7DS7K
         m2VuRbXpPfA/c2K3BAp3HojSyhNMlssuF//ntu3Mv5fMltgcizzbIz2Hwvm4Rl5RrTh7
         db1ESdeqzHZCuVNlj451tRQJnKHTM+fat+l1dFjPYun9ATeoy3nvp7eWR1J38Wv435Ab
         BUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yt6zWERiKTCjDwTG56J7PYbCEtxdXxHidONUlaX/0Js=;
        b=opeXjg8ueRVl+5PRFKZSVyQ/mZ93K4I8D4cnLhr3ywNL17YgZPQVFRattsh8SODI7i
         UQTzzfqqpc6F3tcFxGged5Q3W59L64beslUCCuHVwEQf/OGjqSXkEj7vWRT+dEqYfK7e
         ncLKLdxS1gt2L9TkTgcJRAhLBzs2ZQB9kaW3xzNujczeC6qJUgB49qLWWhUeXkYpWnSA
         1WoCXTegSbv/2E5IqLylpRmGjFQK9ufh4vULQEmUE02H2obM3wUil60wFgxRtrcRcJrQ
         +r8KrYRmNjPvOQvPwwsD6PXp+TrWmh8g0BrfASXbJ4poPbjC4RJMlZ5DL/UMZw/sxYvK
         7LHQ==
X-Gm-Message-State: AGi0PubUvfSXiffPBE9YuvT/gd7FOX1BeZE6il3WKt6vJSLCVqO0mG2s
        Vt7N6KHXxWdsEcvjGXrKEkopm5tystD+f6p1n8UERg==
X-Google-Smtp-Source: APiQypIY+3gHVfOON959mT3BWUZJaXvVOSvN8K0EQOmiQuny69JdN42ugLz+DORki8l/0FvOcEvx2X4tgIn4sOhB9vA=
X-Received: by 2002:a19:700a:: with SMTP id h10mr2752575lfc.184.1585843907063;
 Thu, 02 Apr 2020 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200327172331.418878-9-gladkov.alexey@gmail.com> <20200330111235.154182-1-gladkov.alexey@gmail.com>
In-Reply-To: <20200330111235.154182-1-gladkov.alexey@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 18:11:20 +0200
Message-ID: <CAG48ez2L__TODzwQW0MjYim6rh=WjkU__xvAoi2CtBCkNP2=Fg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] proc: use human-readable values for hidehid
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 30, 2020 at 1:13 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> The hidepid parameter values are becoming more and more and it becomes
> difficult to remember what each new magic number means.

nit: subject line says "hidehid"
