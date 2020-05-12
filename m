Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80D91D0338
	for <lists+linux-security-module@lfdr.de>; Wed, 13 May 2020 01:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbgELXvc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 12 May 2020 19:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXvc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 19:51:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB9C061A0C
        for <linux-security-module@vger.kernel.org>; Tue, 12 May 2020 16:51:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j13so164527pjm.2
        for <linux-security-module@vger.kernel.org>; Tue, 12 May 2020 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+F4liAaMr4vgR2fMURd01YkZSvvte2W6gqbbzWKG5c=;
        b=SrKIZ8AEXY1eEqueHNpwaWV+9SfeA1ktJrITPsb+4ODj2OLx3HeoWSVg4b1yiBK0kk
         6MROIbFjB6t0AOStv7l25VgYcJLvH4J1cFT3bMK+Hb/sttDC/HHYMSJ6wqV0ytmucRxo
         Vv6Ki9QiL8gnNgKQeoJ6ivZeumPVZXIHJ2kXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+F4liAaMr4vgR2fMURd01YkZSvvte2W6gqbbzWKG5c=;
        b=GwIP6ev4XNqmQctzb04GyMtJJySmi6zWLIHWofwstgfArkJHmhM6gdd2y338ETw8+J
         KSf3U+HAMXPKH5CuSL+Yo812pQrokqYphahLAuPxSU1lbwwMfdHEvcaH/jlc0Cq3MkYz
         G+dVXKqYi99fPu5advAtcFO3DuCAuT6OEhLMr9JE6orCR0k7fEx48VjyBLLddoh8L+X9
         t69uFGqcmkibP3o3+7ZXBk287vajRnYAapkRhbooz6uW/BtoNA/HDG1vVvBfX6/LfeUB
         9T1OggXixS8be//v0D2x7hgvJlrNvBEtSlhsvAqUX8XdF1BeyLtuqBlFir6OgmoHAqHG
         4wUw==
X-Gm-Message-State: AGi0PubO9nEccex4tK+peAENjSGqNc285q6HxdqEe56IvPbpdqrZQUN4
        nJKKqbpIRGMY4+VoSVkuTw+6rg==
X-Google-Smtp-Source: APiQypIsjXL5Mme58Z3NS8DKdjPSdKDukPTRuwRTh1n5ysNxcgUm6R8R0NcxFEIPIOiwow+wowUAow==
X-Received: by 2002:a17:902:ec04:: with SMTP id l4mr22412099pld.6.1589327491660;
        Tue, 12 May 2020 16:51:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o11sm2521576pfd.195.2020.05.12.16.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:51:30 -0700 (PDT)
Date:   Tue, 12 May 2020 16:51:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
Message-ID: <202005121649.4ED677068@keescook>
References: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
 <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org>
 <202005121218.ED0B728DA@keescook>
 <87lflwq4hu.fsf@x220.int.ebiederm.org>
 <202005121606.5575978B@keescook>
 <202005121625.20B35A3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005121625.20B35A3@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 12, 2020 at 04:47:14PM -0700, Kees Cook wrote:
> And now I wonder if qemu actually uses the resulting AT_EXECFD ...

It does, though I'm not sure if this is to support crossing mount points,
dropping privileges, or something else, since it does fall back to just
trying to open the file.

    execfd = qemu_getauxval(AT_EXECFD);
    if (execfd == 0) {
        execfd = open(filename, O_RDONLY);
        if (execfd < 0) {
            printf("Error while loading %s: %s\n", filename, strerror(errno));
            _exit(EXIT_FAILURE);
        }
    }


-- 
Kees Cook
