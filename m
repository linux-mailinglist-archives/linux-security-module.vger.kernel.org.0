Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94958CE1ED
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Oct 2019 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGMkl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Oct 2019 08:40:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45511 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfJGMkl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Oct 2019 08:40:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so11455103oib.12
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2019 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4omqkgEsOa3d7dDrSHEj0fGIcb4u6Z71IZA7jxrxpXA=;
        b=dDiR8orVa3DeLfGPRt48FE0G85MRTPusWnInVoCHTm00UIfVXwiV/+Te1Locr2IaNc
         MzWbl8tv0imbIGqQtxu0ALEcZC1N9Or2EThj5AmzPSVpmoDMVs1i8SsmJ9wVcwlzZkYN
         qBxVgOHEYzZGQe/JFirWQ3b6bW9Kri0w3T2G2dSxfyxekUK0in8Zjncbv0YSi1etbce0
         JUNEKfAP/FqN5fdqbNVuyaE9cVFfymuJwKGB1Puf/w4zhnazPVVK+ecB9rVjdHkGy5Kq
         ofuDjgblAoF8uO+Q0NR67UqHDMKQh/+YhcweREO6rBJatoR9tulV3qfPcv/ObTO73w60
         Slmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4omqkgEsOa3d7dDrSHEj0fGIcb4u6Z71IZA7jxrxpXA=;
        b=nXOUq/RFElOLtwOdyaoq3lj+9/0JbZFdmreFfkCqDU4/Chx5oq7xj0YdFwwykg9NWx
         qRAhGePC0KqMYxx8CQtnIHutXeoW3d+SaUnf70E9jMXU1xEgejIaCJHIX7dAokPEtHS1
         JBJshWzGfLQInUoDGZBtuMlL9WIg/o/3zAc8Jo6Wjw2g8h/SNii/WCVrkHvndi2/8rpK
         DykBJ59QLBpJoeDPRXRC1l/mZu/QAKmm90n+P9z8h3veY/79Trgsg9wEmnBReVQnm1Js
         WFdKAQ6zz8rkEYs4Cs+pr2iBbza00K2ACxCZvt/97zxjvvmxCeESBYFUlDG5WaTHyY59
         1mWQ==
X-Gm-Message-State: APjAAAXA211D0pX+sBgPdCK++sGSWkdcDXGhB0bvrqIw7qz+ZNzM9SCh
        58yjcLjMolRlSaxk3IMwt+h8molNWfUo+Xw9rmUcwg==
X-Google-Smtp-Source: APXvYqwhR+z+UIZ4jgopakgOCjtQfQIV/2FB/mG9OzRVEd9xbqmcvQS251+v4BMhDWqCxWTMsQGJ/FkT4gtdl54+U4k=
X-Received: by 2002:aca:ed52:: with SMTP id l79mr17312662oih.47.1570452039482;
 Mon, 07 Oct 2019 05:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com> <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
 <CAJHCu1+35GhGJY8jDMPEU8meYhJTVgvzY5sJgVCuLrxCoGgHEg@mail.gmail.com> <CAJHCu1JobL7aj51=4gvaoXPfWH8aNdYXgcBDq90wV4_jN2iUfw@mail.gmail.com>
In-Reply-To: <CAJHCu1JobL7aj51=4gvaoXPfWH8aNdYXgcBDq90wV4_jN2iUfw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Oct 2019 14:40:13 +0200
Message-ID: <CAG48ez3v4dpCGBUc16FQDbGEAXtnDDvTq2GQpVax0rLgHEM3_g@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Oct 6, 2019 at 6:49 PM Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:
> > Jann Horn <jannh@google.com> wrote:
> > > On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
> > > <s.mesoraca16@gmail.com> wrote:
> > > > Creation of a generic Discrete Finite Automata implementation
> > > > for string matching. The transition tables have to be produced
> > > > in user-space.
> > > > This allows us to possibly support advanced string matching
> > > > patterns like regular expressions, but they need to be supported
> > > > by user-space tools.
> > >
> > > AppArmor already has a DFA implementation that takes a DFA machine
> > > from userspace and runs it against file paths; see e.g.
> > > aa_dfa_match(). Did you look into whether you could move their DFA to
> > > some place like lib/ and reuse it instead of adding yet another
> > > generic rule interface to the kernel?
> >
> > Yes, using AppArmor DFA cloud be a possibility.
> > Though, I didn't know how AppArmor's maintainers feel about this.
> > I thought that was easier to just implement my own.
> > Anyway I understand that re-using that code would be the optimal solution.
> > I'm adding in CC AppArmor's maintainers, let's see what they think about this.
>
> I don't want this to prevent SARA from being up-streamed.
> Do you think that having another DFA here could be acceptable anyway?
> Would it be better if I just drop the DFA an go back to simple string
> matching to speed up things?

While I think that it would be nicer not to have yet another
implementation of the same thing, I don't feel strongly about it.
