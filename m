Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C131F1D8D17
	for <lists+linux-security-module@lfdr.de>; Tue, 19 May 2020 03:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgESB0U (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 May 2020 21:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgESB0T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 21:26:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF28BC061A0C
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2020 18:26:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so11917783ljl.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2020 18:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gs7dtmXWSFHCtE6SJeh0R5WhnxNGei8hq4y5MyR6ZaI=;
        b=g6f+fSpWv+q0J5qWk4vTM3N0tr/FDbfKxShNQ1hBeIUmG0ft9K/mDofqKrLzKT0ANb
         lccujvLSk+oHzhGNg8Ix24CcEu7WM3qPYVudg6Y7P+hECP8QDLjckalGWIXkWioVLqav
         8RZdGRZ+c6ZskkaTAd9COiMlvaDxFA8w4xaaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gs7dtmXWSFHCtE6SJeh0R5WhnxNGei8hq4y5MyR6ZaI=;
        b=kz7/TrCOs/W1cpXkHGx3HkUNBt+VsMEVad0wVJ6XbtDr4QwqDvGS5IU02ukzL31dqx
         w/i62xRJEHSLW+tEJGE0u7QvafDE/iUhcwtm+4OmLz4l7dLbpQi2UbuQb6qh9Zlj1yel
         O367NG/m0vPYcAe2fOxiTNAs7Ax27iGcPkPCRHPvzwmZvG/zAekxxSX1XSsFVGoyDO8s
         Rq1GlXmOx6Ao9O2xT8FZeovZyxve1icrCYqMDS5LssZjrA7qvBr6obO+pWzqS7tiB0bL
         qSin9Yukw3qnXH3MBwafEqQKkCm8OqmEQvNeLs0uNqQN19mKdTLCq9OquqGuNDWF/70d
         E+5w==
X-Gm-Message-State: AOAM532QSKyrOG3noy6wmcDj9uIKfHgU07y+LtM+r6kPf5nr8+4mo0Cv
        4NYmxGEtDBOXfVjoLshy7Su2EJotP+c=
X-Google-Smtp-Source: ABdhPJys26BHVsMOhPb+vkBtpl3SM2ZJUdGl13gKiuWgkLG35uBOyMm5iVQMrFRL+Z8VTHmXdM8qLQ==
X-Received: by 2002:a2e:b53b:: with SMTP id z27mr12011036ljm.114.1589851576336;
        Mon, 18 May 2020 18:26:16 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id j2sm7828193lfb.78.2020.05.18.18.26.14
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 18:26:15 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id l19so11926654lje.10
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2020 18:26:14 -0700 (PDT)
X-Received: by 2002:a2e:9641:: with SMTP id z1mr12188170ljh.201.1589851574208;
 Mon, 18 May 2020 18:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 May 2020 18:25:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBGm=et0Z3dx+g8YnF4HoHjZ_XwKTAMi-3Ss0_Z0-MMA@mail.gmail.com>
Message-ID: <CAHk-=whBGm=et0Z3dx+g8YnF4HoHjZ_XwKTAMi-3Ss0_Z0-MMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 18, 2020 at 5:32 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It is hard to follow the control flow in exec.c as the code has evolved over
> time and something that used to work one way now works another.  This set of
> changes attempts to address the worst of that, to remove unnecessary work
> and to make the code a little easier to follow.

It is indeed hard to follow, and maybe I missed something, but from
what I can tell, your series looks all sane. It certainly seems to
make things much more straightforward.

Of course, exactly _because_ it's such a messy area, maybe it
introduces something odd, but all the patches look relatively
straightforward. And you remove more lines of code than you add, which
is always nice to see.

So ack from me.

Oleg? Jann? Anybody? Do you see anything strange that I missed?

                Linus
