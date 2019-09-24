Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6111BBF6E
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2019 02:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbfIXApJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 20:45:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33182 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391527AbfIXApJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 20:45:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so73499ljd.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 17:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/64PPB5d/u2+0Z5QEyaFUQb1FXYalWwnZUF4/RRNz2Y=;
        b=Jek3G9kVUtkQOqQMOKqOrV9gVq5lSipvNe1iluOEV7QCIIEX8CSTzqF5gfy5LKWl2J
         kqpKIiiZkZaEJHYhdRCKUm9aQzXs6yqjFUmlSpKajn5B07EYRrME+BaMwsXVcHP0tQlt
         o5pN+77AupV1rOKlfhXo2xpkgOn6wGfpwSHPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/64PPB5d/u2+0Z5QEyaFUQb1FXYalWwnZUF4/RRNz2Y=;
        b=XEWxGYVhUcaPx4L5UuYmzTA7qNTvCA7QFIw+gsmO9DQlS9PZAPbq0q6XdBmQ7K+ITu
         hyzcD820ONB9bjLWSvwTxivLuVDfCy3e3yPQHEtuGTZ9/cha/Mo35O1DHILwpemmyvAU
         rW2yum+g2scrG46zjsnqLMqHOF1HVsd8SKsr7f1/H8KLKv+iq479YZC8vkcZFwEK0Btc
         VEcLI3C0t1NeHE6b8jWb0XfYV/Utez7D1VlWtAizb3mC7TE1kvliI7n5rRm/VtB5X30F
         a8pkZ7tqZQlTWi73+264Dr6AiNbjvJn/R8kldm9Paw0wVe7C7/HD3yAeIVbLseQcv9cZ
         vduQ==
X-Gm-Message-State: APjAAAVXFcXb21yCStYAnZqYZP2PDb1cBtMz2MWVYG02rGpSgQc7ChdU
        kIRm1ORAMH/eUhKUbHSXZdJJpQQQuOA=
X-Google-Smtp-Source: APXvYqwjTQq2tnvlDI50Y0gZfKQdIyJzj0B0VTkenTbU6SabJs+OfR4Qu0gFyMb8Q9BXD9fmMBaC9g==
X-Received: by 2002:a2e:9d4a:: with SMTP id y10mr14559ljj.181.1569285906931;
        Mon, 23 Sep 2019 17:45:06 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m8sm52394lfa.67.2019.09.23.17.45.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:45:06 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id e17so33533ljf.13
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 17:45:05 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr37660ljj.72.1569285905710;
 Mon, 23 Sep 2019 17:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com> <20190923233038.GE7828@paulmck-ThinkPad-P72>
In-Reply-To: <20190923233038.GE7828@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 17:44:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFhZfpdoMrVDprBMvuuKPH7jFKY=sjN0dWj6Kz9eAtsg@mail.gmail.com>
Message-ID: <CAHk-=wjFhZfpdoMrVDprBMvuuKPH7jFKY=sjN0dWj6Kz9eAtsg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 4:30 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> I pushed some (untested) commits out to the dev branch of -rcu, the
> overall effect of which is shown in the patch below.  The series
> adds a new rcu_replace() to avoid confusion with swap(), replaces
> uses of rcu_swap_protected() with rcu_replace(), and finally removes
> rcu_swap_protected().
>
> Is this what you had in mind?
>
> Unless you tell me otherwise, I will assume that this change is important
> but not violently urgent.  (As in not for the current merge window.)

Ack, looks good to me,

               Linus
