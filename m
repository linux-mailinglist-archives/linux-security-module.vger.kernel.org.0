Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4327D83B4
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Oct 2019 00:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbfJOWcb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 15 Oct 2019 18:32:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39884 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbfJOWcb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Oct 2019 18:32:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id 195so2793059lfj.6
        for <linux-security-module@vger.kernel.org>; Tue, 15 Oct 2019 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=SIEI+eyzsLvgKQSWy68fNU4waAO3JnvS6nzHr5/fZu5+F3lS+ninFSB5dUKCVryHZ+
         kl8H8QJRcmYfRoBpcYQdlcvyFYmbnE5AhMRuYRji7sgqsBgEDlqfBvGU7GUQWJu2UMf7
         6W/csLC8ZHTI+HN72RKiuRYhkxOOMexsvDhzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=rOGnPIStDkYCUi5//B/q3p7t3Vb6PgSCU1fCuz1dyh30SFPht7yMeHEpg0gip5Aopu
         6DYmZlCVte0eIQ2NSRDE+8jOvnbJYVZvEsjxbhOWIFYsq3KEylhSq6/GeeNnPV9k2Z0o
         QYDrAn9wkrqNDxdEuUh/9DVv/3Tx1mhxpJ/zHz07/CUI06C0SkBQ4oN6dECY025DNVBC
         pk9EdWK3FD1d3yA/qApAKLNSG3Gzf+A5wCGac7fzk7CuL4AblvfdsJOGM1SXxfXG/uyq
         acmypRblcDPB/1wTe3zdFL8fmJRas05gqdG1sKUJkwXicHg0RsE6/peOD4ZbHaJBpuoE
         qXNw==
X-Gm-Message-State: APjAAAUHI0Ckh2Z1MZPrbrv9gCoHJ4M9Vo0xeTndU9OSp73Z4QJdlLJf
        m5V1Ui+HojZ+BkDsHVaxxRjR2Y5GB+k=
X-Google-Smtp-Source: APXvYqz4ApYzARecC6WdkBDNEm0GoDpHqMYaiJQJ+k9WZBOY40209XJar/bIm/8cgtSWk4Vbna9iSw==
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr22973324lfn.182.1571178746539;
        Tue, 15 Oct 2019 15:32:26 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h12sm5199874ljg.24.2019.10.15.15.32.24
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:32:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w6so15758582lfl.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4230778lfe.106.1571178744104;
 Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:32:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Aside from the two small comments, the pipe side looked reasonable,
but I stopped looking when the patches moved on to the notificaiton
part, and maybe I missed something in the earlier ones too.

Which does bring me to the meat of this email: can we please keep the
pipe cleanups and prepwork (and benchmarking) as a separate patch
series? I'd like that to be done separately from the notification
code, since it's re-organization and cleanup - while the eventual goal
is to be able to add messages to the pipe atomically, I think the
series makes sense (and should make sense) on its own.

          Linus
