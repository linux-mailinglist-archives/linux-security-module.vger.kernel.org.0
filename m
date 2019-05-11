Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A051A81E
	for <lists+linux-security-module@lfdr.de>; Sat, 11 May 2019 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEKOid (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 11 May 2019 10:38:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38354 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfEKOid (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 May 2019 10:38:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id 14so7424520ljj.5
        for <linux-security-module@vger.kernel.org>; Sat, 11 May 2019 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0nMY1dAXe3rU/EGGiXuIeNRBZ78Ma5ZAZuK2pC9YCI=;
        b=Eqgqu+RP5jF0lLzL+ebZS0xFoE2Nw9GZPEdGt2vF8FOu8+DBqY/apNwweFNq7lRwvf
         PrqvCmmZt+gXoClxsOuAkAVajcbrkacCcZDgJKHIaa8X0Jz/0A9OT+s0I74g4AJSdudt
         MY9SB7sftM339abzQfP8fe0j2sMPejVzDLY9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0nMY1dAXe3rU/EGGiXuIeNRBZ78Ma5ZAZuK2pC9YCI=;
        b=r1oxhpYnmeOs7ftu12rsZXWJlptkOptQmc5UzfshJ6QQwiBGrvY1klArOwKkD3iIVe
         1rvX3kzeg6kOMdSQQvONiuiWXKTFgzo23JarOgd+XP7LMG1z2ZtApniguhUTyMI3eCRF
         HI2VOrfO8iLxC3pjd0ZmIjM30g/JePX61KZ4J1rqPOCDbKiqZ8mR4bCxNRtwrojzae+u
         6cN/IeyBGSwukIUqwnqF7SA3qsOjqhS64zdJWy/KSbaiyCUnc3EzXiNejtgRYOoLV7jf
         83Yl/3nBdD+0x3aqtWjdKZvwD2eWLISpGVOUBwZQwI1uDdg/f5osi99YJ83DeJM3k7sW
         I8wg==
X-Gm-Message-State: APjAAAUCa2f7XtIiRFiimVeJBQpu5qOcGuND3S0ZMSZHqYmcjrOhUHu7
        8MBPVrCBNfSfEAPaYr/cJXPYh0RPKpU=
X-Google-Smtp-Source: APXvYqwa/uKR9gluULV6tcj8sOaLzvrIvbxGMVUfzLy6SWi4BYgdLRPj2QQQSfbc6gXiBQXaIAXjuw==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr8746972ljg.145.1557585510980;
        Sat, 11 May 2019 07:38:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o70sm2354665lff.53.2019.05.11.07.38.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 07:38:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h21so5664215ljk.13
        for <linux-security-module@vger.kernel.org>; Sat, 11 May 2019 07:38:29 -0700 (PDT)
X-Received: by 2002:a2e:a294:: with SMTP id k20mr4024290lja.118.1557585509228;
 Sat, 11 May 2019 07:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905110801350.9392@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905110801350.9392@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 10:38:13 -0400
X-Gmail-Original-Message-ID: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
Message-ID: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
>
> These patches include fixes to enable fuzz testing, and a fix for
> calculating whether a filesystem is user-modifiable.

So now these have been very recently rebased (on top of a random
merge-window "tree of the day" version) instead of having multiple
merges.

That makes the history cleaner, but has its own issues.

We really need to find a different model for the security layer patches.

                   Linus
