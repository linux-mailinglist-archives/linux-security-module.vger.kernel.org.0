Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010112A0620
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Oct 2020 14:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgJ3NCf (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 30 Oct 2020 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3NCf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Oct 2020 09:02:35 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D9C0613D4
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 06:02:34 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id z10so1448524vkn.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfUp6uvT0mNo9qOvWz4kadVZif4hwG0EcrIPidc71AU=;
        b=c/0np4r5fnnReVFjWkDWXo8hF0To3ovSOoxgoL/QWs9VxL86iqjKdadij03d378/T5
         B7rjoCbR258EwTEX+UW+6QMPF65hDWZsco0RfSUG9stFDcsd6ZZkDH+4oFGIQiro7Wrf
         /VUafL5CtS83KydlI6lpgD86QMrk86JITh21I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfUp6uvT0mNo9qOvWz4kadVZif4hwG0EcrIPidc71AU=;
        b=dsKpz+1jQbeF2Ni5PLD4C6U/xNUTHyfS7he43qwmY1i2VrOJlosjhplPFmfgkFnkSk
         50U8Z0rY9grJW7JffzjZkJKEzZ3G6Rn8u/zWET7M9aNrJAaicLrsOklTnWHD+gwgXVDW
         EIr3oJD1O0HDS638REEn52vvKRhbTUocizZxwIEX+CLlKob6DNVJc91MUA+5+jIOAZqC
         yWJH44MWRojdgnBrzgLGIXqkG+RP2kFyVJsZWhQwJ8z7AQuFuqCy0CFOeoffWFaNTiJG
         kxTarsbVrxG89Zu+WNtW/K/mZXPDGC/rWHI2lWaZdAqgna5DtRIqDIQoZsjtmNXRTV2H
         Wntw==
X-Gm-Message-State: AOAM5337uIdfNxGGAehY8cJ9Q+upxY/HMY4fQRGyWX4JsnbEz//T2MU8
        bHDb1L3AEjkqv+2+nyGXntPPHdfQnWGqgDAFKT79cw==
X-Google-Smtp-Source: ABdhPJxPa9+zamc48OrPbKG+5+YeIbGDLouPEl6taVV7SKI2yGqJZrMzqI/DHpB0Je2VEJI3rTxbB6w6g9+fXjI8Kns=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr6640364vkj.11.1604062953264;
 Fri, 30 Oct 2020 06:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008caae305ab9a5318@google.com> <000000000000a726a405ada4b6cf@google.com>
 <CAFqZXNvQcjp201ahjLBhYJJCuYqZrYLGDA-wE3hXiJpRNgbTKg@mail.gmail.com>
In-Reply-To: <CAFqZXNvQcjp201ahjLBhYJJCuYqZrYLGDA-wE3hXiJpRNgbTKg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Oct 2020 14:02:22 +0100
Message-ID: <CAJfpegtzQB09ind8tkYzaiu6ODJvhMKj3myxVS75vbjTcOxU8g@mail.gmail.com>
Subject: Re: general protection fault in security_inode_getattr
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>,
        andriin@fb.com, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, john.fastabend@gmail.com,
        kafai@fb.com, KP Singh <kpsingh@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, yhs@fb.com,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 24, 2020 at 11:00 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Aug 24, 2020 at 9:37 PM syzbot
> <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com> wrote:
> > syzbot has found a reproducer for the following issue on:
>
> Looping in fsdevel and OverlayFS maintainers, as this seems to be
> FS/OverlayFS related...

Hmm, the oopsing code is always something like:

All code
========
   0: 1b fe                sbb    %esi,%edi
   2: 49 8d 5e 08          lea    0x8(%r14),%rbx
   6: 48 89 d8              mov    %rbx,%rax
   9: 48 c1 e8 03          shr    $0x3,%rax
   d: 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1)
  12: 74 08                je     0x1c
  14: 48 89 df              mov    %rbx,%rdi
  17: e8 bc b4 5b fe        callq  0xfffffffffe5bb4d8
  1c: 48 8b 1b              mov    (%rbx),%rbx
  1f: 48 83 c3 68          add    $0x68,%rbx
  23: 48 89 d8              mov    %rbx,%rax
  26: 48 c1 e8 03          shr    $0x3,%rax
  2a:* 42 80 3c 38 00        cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f: 74 08                je     0x39
  31: 48 89 df              mov    %rbx,%rdi
  34: e8 9f b4 5b fe        callq  0xfffffffffe5bb4d8
  39: 48 8b 1b              mov    (%rbx),%rbx
  3c: 48 83 c3 0c          add    $0xc,%rbx


And that looks (to me) like the unrolled loop in call_int_hook().  I
don't see how that could be related to overlayfs, though it's
definitely interesting why it only triggers from
overlay->vfs_getattr()->security_inode_getattr()...

Thanks,
Miklos
