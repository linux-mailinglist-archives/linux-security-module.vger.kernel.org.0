Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32596207DA
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2019 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPNUB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 May 2019 09:20:01 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42050 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEPNUB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 09:20:01 -0400
Received: by mail-vk1-f196.google.com with SMTP id u131so1006241vke.9
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Mom9MODQ5/QqS+RDXttev2mPfjd0+NlE9IuL/dY7r0=;
        b=NyYpd+dkEe2YZFx36BzlohQJ+8JNYLj3zvAZeOi8NXLBd9Cfc1WAr4LKDFtfqnGpad
         StU7H7B3CNs4PTRtMPNyu48VG0OZOTZup0nt++JNMt27PlrD0ZmxJV1bfN72QLCfNuf6
         w7gdkwYzuTZZNUyNWLDDFcEpc+Yt/Koj5aaJMPvc1MnekJnzFPwg/6VOt0JMkZ3JCPck
         x3J0yX/c5zszJjTgdOGbi0c8d6dY2RpB2WP5V1wutc4hZGvz37FMXRudGdXPGb3adGS4
         HMQw1aG9pYnoANuDja2STHdq5iiD076Y53phnswgHQxYlemD+OLxg7fnU/di1ZVQ146z
         ojdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Mom9MODQ5/QqS+RDXttev2mPfjd0+NlE9IuL/dY7r0=;
        b=cBomDeeVLSOD14WtOJrs5LdRiRguSDHcOCfs/gzbXaKmdR24Eyj9YtfbE1JKpsI9pA
         ui4jo4SFkuGz3wpNisMW5CjeIKQpnPNZi1oMOvC3Rhcwo6asaEQ25YYzhD+sG30tbBwl
         ti2AfuJav49hcPALwjU/EVXnDySqL0luTsGvzOi10RBuuC6SyXQ87brjtaCEDcI37YT7
         gp0Yp2jZioYVPctiMeBx2WIBSHHzr+2NTykxCaCNPOezpE6TwXWfdZHvFJWdqt5CjJBq
         KWJ9H6LmqZYP3jW7NpBto/wqjSM5mt6x/+Lix4DNYfj4YMPtKyxu58tyeKFZZhGRXjfe
         3hnA==
X-Gm-Message-State: APjAAAUew+zf4755Gux6SI8IXDoadXWiE0FjzLCNksSgXeClxpraQiBf
        lRZVZUShLll69KhWhONhHPgGNAUd/1SOyi4/JVFvTg==
X-Google-Smtp-Source: APXvYqwHkWIjT82JQxz+Mhj+wFekyLzeKbvlA3oD6vV2Dm+OkWUy416z1duYLdzrQPrdKwcvwPtwQgxdzG09+lz8BzY=
X-Received: by 2002:a1f:3492:: with SMTP id b140mr22269628vka.8.1558012799699;
 Thu, 16 May 2019 06:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000032685a058900d170@google.com> <2b0b9d18-6773-f2dc-ecb2-9f8782d0962a@i-love.sakura.ne.jp>
In-Reply-To: <2b0b9d18-6773-f2dc-ecb2-9f8782d0962a@i-love.sakura.ne.jp>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 May 2019 15:19:48 +0200
Message-ID: <CAG_fn=UHjDv=Jc_nEKKknVGrr9CC4rZ+a+hw_yAL-j4y4=89cg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in tomoyo_check_inet_address
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+1018d578c410f9f37261@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, May 16, 2019 at 3:13 PM
To: syzbot
Cc: <glider@google.com>, <jmorris@namei.org>,
<linux-kernel@vger.kernel.org>,
<linux-security-module@vger.kernel.org>, <serge@hallyn.com>,
<syzkaller-bugs@googlegroups.com>, <takedakn@nttdata.co.jp>

> On 2019/05/16 21:58, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    3b955a40 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       kmsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1027e608a00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D602468164cc=
dc30a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1018d578c410f=
9f37261
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang 06d00afa61=
eef8f7f501ebdb4e8612ea43ec2d78)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> This should be already fixed in linux.git.
>
> #syz fix: tomoyo: Check address length before reading address family
>
> commit e6193f78bb689f3f424559bb45f4a091c8b314df
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Fri Apr 12 19:59:36 2019 +0900
>
>     tomoyo: Check address length before reading address family
>
>     KMSAN will complain if valid address length passed to bind()/connect(=
)/
>     sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
>
>     Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>     Signed-off-by: James Morris <jamorris@linux.microsoft.com>
Apparently the fix didn't make it to 5.1, I'll cherry-pick it to KMSAN tree=
.
OOC, how did you know about this bug?
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/2b0b9d18-6773-f2dc-ecb2-9f8782d0962a%40i-love.sakura.ne.jp=
.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
