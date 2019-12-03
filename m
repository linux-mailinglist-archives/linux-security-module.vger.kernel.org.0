Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2662711063C
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Dec 2019 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfLCVBF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 3 Dec 2019 16:01:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35973 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfLCVBD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Dec 2019 16:01:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id f16so4223116lfm.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2019 13:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fOp9UL4TDz8TWECkS211lvgboatmsuv5LY7KX3P2MA=;
        b=U9Aw4Sja22I77j4kIkUeO/Y/Fc/rkVz4BTTYRODU07ywsNwbcE9NG0Oz/GR+YSZ6d/
         CrLJC0O/jLYELjppHP5FpQqKRpohUO68kt9lFS9rvKSMDX/pAIRnoWt1RFYFROzgC150
         Jt1vRW7c8HWyjI9qZaX/xYYNvg7HDW/2yHUhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fOp9UL4TDz8TWECkS211lvgboatmsuv5LY7KX3P2MA=;
        b=oNXDvGQE8ck2zFvxzzVQYlpJbZqh/EcFLQiXdH8KQwBDdulr7v0HoS7/h/iBrFcrvo
         JX3njDU4pevFdGb12jcs8vyv0Pxg1onDXpkXDAiF0OfX77fN0cLxFF4Z96cm6m8vvYAI
         AK+PT2eUoxAZJFBvZ65qtaHfvBfY3KMMlSErs++Uts2Lx3xvF4B9mbycat8BtntWTBrM
         qymt2SfqA6EJ8TmQmai9ai4IIzgPnDuhAt1QRrKKD1v8h2Ha7715k4xIe8VMq/YWYHHX
         pf9N0yXxcuvKiu9ey6eoaYRddw9q01lUQqHzeLKzrfMP/js3w6lvBGPUWXPCafcEBtFN
         kHUQ==
X-Gm-Message-State: APjAAAXvMIYDIdWiFTt+RY9c8jNbsQ7IINlfYeyl38TjuoRtyyD+uIyg
        bIGrjthf6JQ4rLqJ+nNKSXGJP+0P4bc=
X-Google-Smtp-Source: APXvYqzPYVdV31HhgZJEROpwSolQhFZppS87cOvuMiab+cDegyL+Ap0dhqISc/xDzPQatpQ3hvTWqA==
X-Received: by 2002:ac2:44a2:: with SMTP id c2mr3998217lfm.105.1575406860750;
        Tue, 03 Dec 2019 13:01:00 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s7sm1892854lji.20.2019.12.03.13.00.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 13:00:59 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 21so5485985ljr.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2019 13:00:59 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr3872416ljj.1.1575406859343;
 Tue, 03 Dec 2019 13:00:59 -0800 (PST)
MIME-Version: 1.0
References: <ab8e6cbb-c46d-41bd-0a0d-43530ee37386@canonical.com>
In-Reply-To: <ab8e6cbb-c46d-41bd-0a0d-43530ee37386@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Dec 2019 13:00:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2_QKxUqYyBCGPC39OBkg971FY=jYo2tXHuR+JotgP9A@mail.gmail.com>
Message-ID: <CAHk-=wi2_QKxUqYyBCGPC39OBkg971FY=jYo2tXHuR+JotgP9A@mail.gmail.com>
Subject: Re: [GIT PULL] apparmor updates for 5.5
To:     John Johansen <john.johansen@canonical.com>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 3, 2019 at 12:33 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> + Bug fixes
>    - fix sparse warning for type-casting of current->real_cred

That fix is wrong.

Yes, it removes the warning.

It's still wrong.

The proper way to remove the warning is to use the proper accessor to
read the current real_cred.  And that will point out that the cred
needs to be 'const'.

IOW, it should do

        const struct cred *cred = current_real_cred();

instead.

I have done the pull without doing that change, but this is a REALLY
IMPORTANT issue! Don't just "fix warnings". The warnings had a reason,
you need to _think_ about them.

This is doubly true in code that claims to be about "security".
Seriously. apparmor can't just be a "let's do random things and hope
for the best".

                 Linus
