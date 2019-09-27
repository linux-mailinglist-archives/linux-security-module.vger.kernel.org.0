Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF7C0AD3
	for <lists+linux-security-module@lfdr.de>; Fri, 27 Sep 2019 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfI0SKi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 27 Sep 2019 14:10:38 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33447 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0SKi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Sep 2019 14:10:38 -0400
Received: by mail-io1-f49.google.com with SMTP id z19so18757692ior.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2019 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYk9mRIq/jh9VV5noRENjJQsBnI4Smg5QE7TL9jRjao=;
        b=Mp3UDsZOTz8bsKP10tTFd6YfBAMN8ENDSpF6d8hkAB4m0QJGlsP6hQAuwAC4KqqO/A
         +G2OHxdppJ2FsJ92wdtJqi40gnR1ZVo4z0O9vgxlvkssW6XlSQdkW8se/QQK8bKobCx0
         MZzzIyIHv/1BYixVnxckE+DmM4+t/1eQdjJZ2pGL24yIz86Q2AOMg7Fc7Mds25n+fWel
         pVNqBYTP5IHK5FoQ0QiBcev3eBc7B1ZMM8XfAg0uJ4xBmgSzQkvI/gkcC8NSzznsul2Y
         kcpbIs7xzjp8p644iEeOKZ0AkynXv8zofY2JDTMYh4yvPWXdN9Kid5z8c/jMGsx6UWul
         s+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYk9mRIq/jh9VV5noRENjJQsBnI4Smg5QE7TL9jRjao=;
        b=pZf/Efli1gK6Tq/ZJRrwi5nsv+QeIq+J41kpUQ+F2lnzTg5tcd96Xol3Dus1y6lSwF
         svHtaCt/m8go74MkkO7t9T4gGmTaccupIiPFP/2Do78/KolXzZax5WzirR0KuD2QviD0
         S7+9Ha8EzorvpPE9gM5ij8ZdNhgwd7IWnfpPSUxShcrqHy0GKqXZJP9QWyW91pk9ZZFv
         FyhsQSzOtSU03tzzGE310B0qavIHsIxBK/DVhRbM7CxhylUvqDuvxRl0DHXfU7gkfX1L
         S3d5oPRBPRf6jllpn534F7DWMfUU1QyXkEQtblOBzOMfAvBMqy9CbigT/wPhbFBSMmuB
         2+xg==
X-Gm-Message-State: APjAAAW2nDYzuKZMoKuysKxwV3ZDjdWQcJBxfcWUetL9Cod0GJAIJUUT
        2KmZwtrQdfo41+m2Gh5L2gqvxDZb79OBtM1XmLNpJw==
X-Google-Smtp-Source: APXvYqzYtIW8RWj3bdieK8wgYSUW8tStp9tdO2aVLkSp/Y2NjItqiRAPv6GUjiQP7REWRp4BXNbGPS/VLlsVe37Kc1E=
X-Received: by 2002:a6b:720a:: with SMTP id n10mr9320899ioc.64.1569607837423;
 Fri, 27 Sep 2019 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1909101402230.20291@namei.org> <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
In-Reply-To: <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 27 Sep 2019 11:10:26 -0700
Message-ID: <CACdnJuvi=MgSxatpKOrENzU-By0T3_dxGV6Gb2qEQuhb+B1B8A@mail.gmail.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
To:     Jiri Kosina <jikos@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 25, 2019 at 7:54 AM Jiri Kosina <jikos@kernel.org> wrote:
> Seems like this didn't happen (yet) ... are there any plans to either drop
> it for good, or merge it?

rc1 isn't out yet, so I'm just waiting to see what happens.
