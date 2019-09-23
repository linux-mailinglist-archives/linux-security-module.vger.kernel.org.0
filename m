Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4FBBC22
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Sep 2019 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbfIWTRm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 15:17:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37500 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfIWTRm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 15:17:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so14878332lje.4
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrRLQn3RzqvLOL/i6mhPpJ10+RmKd1euOe+YMl2OYp0=;
        b=f1ffZU2sPanOCuHiBceitjTlbhQE9vji8lZ1iD711xp+ldw6uJgEuKLN8+GC7Byalb
         nwAAiPg7+uP3R5SZCV+80m9S4HOJl9DPeuyxvFQv5NWy9NXmONOgY1hB9hDLeuHfYCdW
         +1/jkugNzglnZ4KwGRBl0e6c1DD4gcxsNkFuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrRLQn3RzqvLOL/i6mhPpJ10+RmKd1euOe+YMl2OYp0=;
        b=lEPw7NKC4NNlBJemYep7/3q/1hjkMP5D/QlOWs43pglofd0G2oZ13TIjPCSF/0HAUG
         fAvU5hu4RVCxt8H+v6MS9L/cPgAC5Ajlrx+WzU0HNVrgxWmFYczMgoAYjRk8bZuSgWG0
         or0a+rhLrfuR+vzMnPasvYIRsE5F2WxqcqrPdvJQC9lFNjwZWPR2x0mdlRl1oimPg3VL
         H4uJMGD3mDoAhNLMeuVoiGu3xagB1fFO3FWsC8HgM1UTGJZ6ZzkKnB2vrcWaZ65imxkE
         hlTJJJ83p4pUmXa2N0L9klRFVdPVDyGO5jLbzAH9unQ7NkZi5Ueed6ORndS285l5Nop2
         ksbw==
X-Gm-Message-State: APjAAAVG+hfPb/4/rA0n1ODVv/xAhi+t3DellT09jsy1Juo0woCtgyf9
        V634dJWUuO0B8ik/62FxWYCcv99o+4A=
X-Google-Smtp-Source: APXvYqyNC6HZXpJERT3JaXvw15RKisz1HBVH8uq5at8nkfH53iOFWiRxqK78esGq9hTLNITqW6yAmg==
X-Received: by 2002:a2e:a17b:: with SMTP id u27mr548759ljl.65.1569266259914;
        Mon, 23 Sep 2019 12:17:39 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 202sm2509327ljf.75.2019.09.23.12.17.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:17:39 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c195so11002045lfg.9
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 12:17:38 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr684575lfp.134.1569266258665;
 Mon, 23 Sep 2019 12:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
In-Reply-To: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 12:17:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNEGetrwyShSLP_5nCA2+YTR9kdNFw7aLua9jaR-YvJg@mail.gmail.com>
Message-ID: <CAHk-=whNEGetrwyShSLP_5nCA2+YTR9kdNFw7aLua9jaR-YvJg@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 10:24 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> This is my first direct pull request. I think I have followed process
> correctly, but if not I will attend to my error as required.

The contents look fine.

However, it's from an open hosting site - github. Which is fine, I
take pull requests from github all the time.  But I require that they
be sent using a signed tag, so that I can verify that yes, it's really
from you.

And no, I don't do pgp email, even t hough I see that there's a
signature on your email itself.

git uses pgp too, but unlike pgp email signatures, the git support for
pgp signing is useful and user-friendly and just _works_, rather than
the complete and useless disaster that is pgp email [1].

So please make it a signed tag with "git tag -s" and ask me to pull
that tag instead.

                        Linus

[1] https://www.vice.com/en_us/article/vvbw9a/even-the-inventor-of-pgp-doesnt-use-pgp
