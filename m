Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E42BBE0B
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Sep 2019 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfIWVis (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 17:38:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43977 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390047AbfIWVir (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 17:38:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so10160951ljj.10
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a5iRl0pwYddtRZuyM8DbsyUr2hb638EoJcEbjk4XVU=;
        b=JcoEGS/AI2rU99SMqow9YrwJpVhAdInWmVe0K73EpxT4IX0dSd4iV6gEYJNry3t1NZ
         czy0P2z6QFvutymUbR9Kl/JfZ7V+MTGu8fD757Q0hU9hsZCA1KKVL4ex53vmZh/jPMib
         pBCmfcv12WS9ovtx+DEcpFDjd8BQTAsbCG3Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a5iRl0pwYddtRZuyM8DbsyUr2hb638EoJcEbjk4XVU=;
        b=izIhUJmmnlwJ7g3X+joOS/Z3ew3Dn0V0oqSYoJyLxpiU/SYBnfDqoR+/fOGCgmZjw3
         bv5zlcA2g7LNLFra1zulHtXoTnJRUyS1E+RtNXE7UWI8T3eiVIbytxuflJh9IfQNIW/T
         LLG5KehFqCW+Q+JrJtJJFA08fw7JJZ2GOwaOk3LDWnZx9Cxd1xE7Qj19GUC6nYVuV9Tn
         6cbgXz56YqcwAhFd9BnjH72TZOSbnlqQTNlCs0xC5floittZqt+5f9hbNPWusWe1UVKt
         VV70lrCGu/ED85fUvbn00ohLP8UnHqg5UF2SKAPZoVTik9Urk/nVu7cNA0cbsIqYJZHU
         cYkQ==
X-Gm-Message-State: APjAAAVOcghTr6FPve1ycLdOT3uMgh5f4VyJNQ13h08Rd9yF5eDVPFVo
        Fe+sFVINCeQJpPNNCci1iCzNZQMZhm8=
X-Google-Smtp-Source: APXvYqzHAe3JDcL3OLvkLfE1oqz02KlyHamQHPPAIp6WJlvgy41BH4LzPICBOW5xONC+66ide2ZGsw==
X-Received: by 2002:a2e:9014:: with SMTP id h20mr807789ljg.154.1569274725116;
        Mon, 23 Sep 2019 14:38:45 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d25sm2475939lfj.15.2019.09.23.14.38.44
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:38:44 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x80so11327086lff.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 14:38:44 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr945017lfh.29.1569274723803;
 Mon, 23 Sep 2019 14:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com> <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
In-Reply-To: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 14:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNi_y5SaXGS3hsxsFcU8P89O9ayJZ6yEYkvCC115J40A@mail.gmail.com>
Message-ID: <CAHk-=wgNi_y5SaXGS3hsxsFcU8P89O9ayJZ6yEYkvCC115J40A@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4 - retry
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 23, 2019 at 1:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > Thank for the instruction. I think this is correct.
>
> Looks fine, pulled.

Oh, btw, can you get more signatures on your pgp key? I actually care
more about having a key than having a key with lots of signatures (*),
but signatures and a chain of trust would be good too.

                   Linus

(*) To me, keys are more of a "yeah, I'm the same person that usually
sends these pull requests" than some kind of hard identity.
