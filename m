Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56A8D4861
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2019 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfJKTYp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Oct 2019 15:24:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44108 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfJKTYo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Oct 2019 15:24:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so7787603lfc.11
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk+GYmDk3Umblq0gC3zhCmwGbz+fKRKvXXa9PqPr9oI=;
        b=RKelw3XTZWr2fMIszm4fiPSJKM6JXno/egHsKyWt4ulwFQMu6s8kxaUjF9a1NatARA
         65uN4laUlTdl8ZdvrQailFcDmEk9gIgZTIaz5xoo01WNPvC19FeRMUmzCV3ux4iR0luW
         Hfue3vcmZOaTSmgI2TQ+rRt/J+LpNSEzf8wgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk+GYmDk3Umblq0gC3zhCmwGbz+fKRKvXXa9PqPr9oI=;
        b=JDtCNhcugPDGHVdzuxGLbFGsOebAsa1DsXZxMyUuduScsoLvZ5iaildUJpBF3ylDU8
         p7JDyFV8rH1tPt0SjadD/ggkGnbsUyJzKq8H8VIeRYXu1NmFI4WV0EFxnR3uLQZhlxlK
         MNTkvZh6AsVadJsk1HvqCO6gIo34HVbVY9Cv5b+agpJ2N5upLBEumrJ5vFkuIRk4wZ4n
         z8Dwr4cGU6y41wESxhByGH7wArVe9DsXMhf+5UGUfAjNsJPOmO65RIhLPQ6+56Q8Pl0j
         2zEpjmO+Pk3BPu3IUfUjR8DvEvH+1+6/E2C/c7eNc8Z5Uf5I/kQEenbiG+WBD3cub3kO
         sk+g==
X-Gm-Message-State: APjAAAWhDDHWQW67x8vv12wqk7bg7NWj1qk7CgnpT8NOoPocVsWmZKpe
        MIzCC0qCuhNH6CIogS09Kd/ssAntT8c=
X-Google-Smtp-Source: APXvYqwCGRwvxw4R2b6ad+xlZZHhgPzZs3NTgNfH98pS76/g0qaBmi58sCJXIkpCmjG/SJF+55+bxA==
X-Received: by 2002:a19:f707:: with SMTP id z7mr9220434lfe.162.1570821882158;
        Fri, 11 Oct 2019 12:24:42 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w16sm2078662lji.42.2019.10.11.12.24.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 12:24:40 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m7so10918053lji.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 12:24:40 -0700 (PDT)
X-Received: by 2002:a2e:8310:: with SMTP id a16mr4366223ljh.48.1570821879742;
 Fri, 11 Oct 2019 12:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011143610.21bcd9c0@gandalf.local.home>
In-Reply-To: <20191011143610.21bcd9c0@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 12:24:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_JH5-hC3yk8X3Ja8XMTuW68-ozuqZdMw7fcHpcpHuUw@mail.gmail.com>
Message-ID: <CAHk-=wh_JH5-hC3yk8X3Ja8XMTuW68-ozuqZdMw7fcHpcpHuUw@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 11, 2019 at 11:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 11 Oct 2019 11:20:30 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Willing to do that instead?
>
> Honestly, what you described was my preferred solution ;-)
>
> I just didn't want to upset the lockdown crowd if a new tracefs file
> was opened without doing this.

Well, since they introduced a bug in your code that killed your
machine with the patch _they_ did, I don't think they get to complain
when you fix it the way you (and me) want to...

Fair is fair.

             Linus
