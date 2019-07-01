Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82504D554
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Jun 2019 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfFTRf7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 20 Jun 2019 13:35:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33711 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfFTRf7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Jun 2019 13:35:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so1339968pgk.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2019 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y//CKAUCmu4Z+CNgNicaVzKkv82IaCbCxrJa7F0wZn4=;
        b=NUMqYmFwkS8LkBdwNC20JWMzkawUchAYdEs+GIDQku+8JYDBs4GvrjFoeC5g9ptLB5
         6iDEHv//HyfEmC5eWmq/MRx0SWCEZ5mvOkbHQvhTphicSrniBya/z8l+GY/YvzCKxgYy
         4uSTgSW5ItQ0Slt9KpB8W7gwtPv0WmGfiEtOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y//CKAUCmu4Z+CNgNicaVzKkv82IaCbCxrJa7F0wZn4=;
        b=SfFndbNJlEGuM2lB9wESUpvzU2gU8g8nz6VSFQaIasl+IaUvfUY9Z/Morho2J3jaQl
         kjYZ2pGNDvDN8Hls3A6k3FbSuFiB8Hoj5Z0yyesU7Vzixcq6vdrdXWI1k0MojuUeHfrc
         Sx4Gj++zP1zqRjfWUoWhfsGjR1YYdmt+3fregJjTL0uwNljbLdzB0m6M1xgi4MZK6Pdo
         14aISUkM+Zo3Sv5goLQ4EY2133kbfnuC8uFSxw9ufvlQWF7xqCvHuWzHzYrDZpcAEh8S
         PUyJHWmN7NQzE7A0Qd9MIDbZX0OTpeW384XUt5TwB2V5/f/QkxWwkk092GJam7QekR6d
         nURA==
X-Gm-Message-State: APjAAAWe3/1e0g5gRDkp28ZoykmKRHqj+MYph+QoxBy1jk6Hh6LoYLdu
        p74j7DPTvFpevPDMQYQzKZ5uRQ==
X-Google-Smtp-Source: APXvYqxiL8EXgij8EVUiiz93r2xVAl4pTaySQemAPFQP6yna6EQozFcR2qsIBQ9qPplMpsgaKHVBCg==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr54261815pff.69.1561052158492;
        Thu, 20 Jun 2019 10:35:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 128sm89983pfd.66.2019.06.20.10.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:35:57 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:35:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with
 KASAN_STACK
Message-ID: <201906201034.9E44D8A2A8@keescook>
References: <20190618094731.3677294-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618094731.3677294-1-arnd@arndb.de>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> leads to much larger kernel stack usage, as seen from the warnings
> about functions that now exceed the 2048 byte limit:

Is the preference that this go into v5.2 (there's not much time left),
or should this be v5.3? (You didn't mark it as Cc: stable?)

> one. I picked the dependency in GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, as
> this option is designed to make uninitialized stack usage less harmful
> when enabled on its own, but it also prevents KASAN from detecting those
> cases in which it was in fact needed.

Right -- there's not much sense in both being enabled. I'd agree with
this rationale.

-- 
Kees Cook
