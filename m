Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2846D2B
	for <lists+linux-security-module@lfdr.de>; Sat, 15 Jun 2019 02:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFOAY2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 14 Jun 2019 20:24:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36973 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAY2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Jun 2019 20:24:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id d11so2853524lfb.4
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2019 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aK7lUvYVYd4MHzc03gl18he+PgV3Hkk9KuzGz+vIyo4=;
        b=e5ZS2eb2pZskGk1t2DAfftIR2H6ohKVnchU3giQkQVAHGxWxwBW20eLh5ZsUiCGGME
         6sw8frLd89Po3z4XAfZ9MbD/TJit973JCdkHd51Y1T1Uq4vgc81VpJT6f+zyKtfC0mDs
         rLEOUzr6pgcKa2PubqoFxZV/FYtmA1r3D0rKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aK7lUvYVYd4MHzc03gl18he+PgV3Hkk9KuzGz+vIyo4=;
        b=jzHF71pcoImgKIG/TjGKA2mJVJryYtwuYTZhTXZt2Xlkg4a2No7T+bKor1h7URsR+9
         vLAUTUX0EoWHtnS6rn7yZoSBq4Xj+f5ADzyTvnuyQrJa7OLESFmD0i5vH0Wy6cPA2a34
         lWOpOzXRrC6MQ5eApG3sDE7YSNvLZTP5fDnsmMsLpT5gX/P6YmFKclGDkfMjEVZUcJgi
         v+4VU5iFwPmRV2DLgXwXskoTEkR2vA1vqELcbPf1Q2tTZizRVA2vGYFUcvLkBJ3x3zcH
         SZSsIeb4uFAIOFgwRF4d0Ktq4MdS27xo/vqPMyz5QguOs1L3t6Wd0VAXqZn31NVgPOpL
         xGrA==
X-Gm-Message-State: APjAAAVKW9VCbWQkXIf3cRCAsCXDp3oyAun9O2e3tRPxkBGdU8MYsWLg
        8lVz96yCBPi7u9CuBgo7+RqlJ7j8+PM=
X-Google-Smtp-Source: APXvYqyy5smu3tMEKbxtV5tpF6dps7viKatFh4WtST7gyS7ZBol6AbHz9Nt6eJHNQXWIYnJhII53xg==
X-Received: by 2002:a19:7f17:: with SMTP id a23mr6101113lfd.49.1560558266441;
        Fri, 14 Jun 2019 17:24:26 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id v17sm943697ljg.36.2019.06.14.17.24.25
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 17:24:25 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j29so2827473lfk.10
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2019 17:24:25 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr45739644lfm.170.1560558265318;
 Fri, 14 Jun 2019 17:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <155930001303.17253.2447519598157285098.stgit@warthog.procyon.org.uk>
 <17467.1559300202@warthog.procyon.org.uk> <alpine.LRH.2.21.1906040842110.13657@namei.org>
 <6cfd5113-8473-f962-dee7-e490e6f76f9c@schaufler-ca.com> <cb3749a6-e45b-3e07-27f9-841adf6f4640@schaufler-ca.com>
In-Reply-To: <cb3749a6-e45b-3e07-27f9-841adf6f4640@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 14:24:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj8VCxjwyd_BDgRtDigik5UdizCZP7PU4wUtj4vHsEWNw@mail.gmail.com>
Message-ID: <CAHk-=wj8VCxjwyd_BDgRtDigik5UdizCZP7PU4wUtj4vHsEWNw@mail.gmail.com>
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option and add
 missing prefixes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        stable <stable@vger.kernel.org>, Jose Bollo <jose.bollo@iot.bzh>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 14, 2019 at 1:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Al, are you going to take this, or should I find another way
> to get it in for 5.2?

I guess I can take it directly.

I was assuming it would come through either Al (which is how I got the
commit it fixes) or Casey (as smack maintainer), so I ignored the
patch.

                 Linus
