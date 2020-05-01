Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5AC1C1A74
	for <lists+linux-security-module@lfdr.de>; Fri,  1 May 2020 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgEAQRr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 1 May 2020 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQRr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 May 2020 12:17:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C6C08E859
        for <linux-security-module@vger.kernel.org>; Fri,  1 May 2020 09:17:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr25so7843162ejb.10
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2020 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23jPYeIHxkO0ujsGD7eYlRbwJShWG3r7UKIREhK5bgw=;
        b=m5o6DjW23uDqvbH6ScTDm+6wn+eSq6aJHkCW7h0E7PQK2TC3+9C/vXX2qmTMXOjDJV
         5m7dDloIaOCSsVWgmy7ijk65TLdTjrJ35UszXTvgQ+9FAhewqXUSAX95ukIByWJVG8Lc
         aJ7FU+3rG+rlYO/LV/MbE4r+CuM0NZfQfnEoIVfNHKM5uWW6T0vZY8K1Xh0pMqnuCdoB
         3NteUzx8k6UL8h+e6dKHslAXt3Zm5yYdLt8ZZFPmzTn15hRPVkNYH3tm/IV4ZnwkNiyz
         FKeNDhmMd7lLEeaZhxMAmD4CqLTsnybNjFKZKZBtJF0qDkGghOeiehwGobytDRRCd4i7
         HHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23jPYeIHxkO0ujsGD7eYlRbwJShWG3r7UKIREhK5bgw=;
        b=CtSnXSZdhvwUEMgl9lZ3TWI9hx9MbEflUWV1RTl9RS+A7f2xviTh1MSyBgisgVkt6/
         YBCnJgFcnnAs47xyqAE5GtqblzM0T3GcStUVVaCz/bJV5vrSjmsU7407/c0OyHs7zClc
         lIEGcLbrFZx9DoNNr7w+qWPki83Ql4jvUhHsSGMlh72n/wW4ZUMq9Yw5bZnZI+0dg9yB
         +S1fMkYfm0luTflXT5+huDKkV2IBr0OIVhg3grGiMd7qshCX63eLFhW7eLuN04znx4A7
         koV6mbBJg8KPH9R9+ztsoWkgYKoB9P1jL8kPFMifGhgR1D77NkCAmAQ22F+KOqAm4Ktj
         z9XQ==
X-Gm-Message-State: AGi0Pub0BcRI0GnGSRTO6UQtNo0Q0YLGw5mBZAMUrKIqXdqhoSkv1q5Y
        QDg6ev9ID0Zjz+Nr8Ol90XyoMVDnUbeOv/oqtIyt
X-Google-Smtp-Source: APiQypIXB+av6flcFldEWw+bS/wH+cxQMW/luqrFwIHVh8pa/MRqCUmiUnrrXtxszp5IfdTN8uKbEAzFnfW/lbRVEho=
X-Received: by 2002:a17:906:29c4:: with SMTP id y4mr3965185eje.95.1588349865367;
 Fri, 01 May 2020 09:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
 <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
In-Reply-To: <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 12:17:33 -0400
Message-ID: <CAHC9VhSBGaJc-dQZyyUECwrysoQ8a4w2ww4PgPyXVH5EEVOjCw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.7 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 30, 2020 at 7:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 30, 2020 at 2:24 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Two more SELinux patches to fix problems in the v5.7-rcX releases.
> > Wei Yongjun's patch fixes a return code in an error path, and my patch
> > fixes a problem where we were not correctly applying access controls
> > to all of the netlink messages in the netlink_send LSM hook.
>
> Side note: could we plan on (not for 5.7, but future) moving the "for
> each message" part of that patch into the generic security layer (ie
> security_netlink_send()), so that if/when other security subsystems
> start doing that netlink thing, they won't have to duplicate that
> code?
>
> Obviously the "for each message" thing should only be done if there is
> any security  hook at all..
>
> Right now selinux is the only one that does this, so there's no
> duplication of effort, but it seems a mistake to do this at the
> low-level security level.
>
> Or is there some fundamental reason why a security hook would want to
> look at a single skb rather than the individual messages?

Off the top of my head I can't think of why a LSM would want to look
only at the skb instead of the individual netlink messages.  I suppose
if that ever becomes an issue we could always pass the skb to the hook
along with the nlmsghdr, and the LSM would just need to deal with
being called multiple times for the same skb.  Another option might be
to give the LSM the option of registering one of two hooks for the
netlink_send hook; one type of hook would behave the same as the hook
does now, the other type would be called once for each message in the
skb.  Although this second option seems like a lot of extra complexity
for a questionable advantage, especially since only SELinux is using
the hook at the moment and we can easily change the hook without
breaking things.

It's also worth mentioning that we've always tried to keep the hook
layer (the stuff in security/security.c) relatively thin, but that's a
battle we've been slowly losing over time.  Moving the skb/nlmsghdr
processing into security_netlink_send() seems reasonable given some of
the other hooks.

Regardless, I'll work on something for an upcoming merge window, stay tuned.

-- 
paul moore
www.paul-moore.com
