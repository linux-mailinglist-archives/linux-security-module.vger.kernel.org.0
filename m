Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD34511402D
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Dec 2019 12:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfLELfb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Dec 2019 06:35:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44672 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfLELfb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 06:35:31 -0500
Received: by mail-qt1-f196.google.com with SMTP id b5so3168400qtt.11
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFj7/o8CY27u2EP/Ii6IWyV6V/qKCHo8NGPo9OoyP2o=;
        b=VLVyGXFmunojbceinV2tb/wrcOELq58HBQBO3PG1yIVJE9cJvQrEbuqEZfs1I80KNB
         NpsR6uAqwQ1je6sENpKTPDm/ZPRPYiyWVyhKhz0Gkvv7qxp0qEVtFkBBxA6A80T2TXsl
         X7m1sn9D0K3nhXLdO1yN+hrVDQu5/hiurh8lYBgW2BPj5Yycs6wAmQwzKT1tL8kEMsPy
         K0NR8MTeoPaHhZSlq8XJVOGWI8DaOELPIF19c03IuvUui/HejI8FD0EVyWCqT64GrbmK
         +X5RQyE6wCiiWL0oRAogajCglCRovqnXNNoySkGhPdL0ztR8wC2vD0Gl8PA4lCPMJHcV
         sd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFj7/o8CY27u2EP/Ii6IWyV6V/qKCHo8NGPo9OoyP2o=;
        b=AVIjT4C65NPA0cLQQ3FbPm2eFIyOW6j9Od5VVTyLXJ+slfrumCouYGkv11iA+H0EzL
         gVz30KzQeHGoVx+U/jGa9/rbPI2KH4eQPYD1bfKSjs4Mx94cMBWVBEQwqZs4+mc5kjl9
         0AJQqKGyGMquiQZAHpynhVea27Vm7LKRu1qhxfvLaZWofZ1PFSWoWHSuUZVoYww778Fa
         itrg61yxBd3VHniODCQWCPPpjKow6k6EHbH38VeL3og904ZfI0mID+S7LQA7fGzy4tnF
         TzUb68M6nP6cFbmbna5442aTMuZxKBRpYFsov9Tv+z6c9HO165OLU197htMVFPWKFMWi
         hkpg==
X-Gm-Message-State: APjAAAWHjCr+U03xKJtiYhJSFWm2kOFR1c3AESNYlhTk1H2ZyrxWsfCh
        FOYNV05QmphDst/LkAir5cFLOJ8kEnD8icYhCrEw/g==
X-Google-Smtp-Source: APXvYqywdNT7YtUlcyhBayK1c5G6KgoYnokHv4gbK83yKRI9KmJz2M3nmPsIV9emnEuu9bBpOrULeU5+4XFCmFaRuPs=
X-Received: by 2002:ac8:2489:: with SMTP id s9mr7043538qts.257.1575545729972;
 Thu, 05 Dec 2019 03:35:29 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003e640e0598e7abc3@google.com> <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com> <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
In-Reply-To: <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 12:35:18 +0100
Message-ID: <CACT4Y+YqNtRdUo4pDX8HeNubOJYWNfsqcQs_XueRNLPozw=g-Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com,
        Gleb Natapov <gleb@kernel.org>, gwshan@linux.vnet.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>, James Morris <jmorris@namei.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, stewart@linux.vnet.ibm.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 5, 2019 at 11:41 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/12/05 19:22, Paolo Bonzini wrote:
> > Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
> > backtrace and I get to share syzkaller's joy every time. :)
> >
> > This bisect result is bogus, though Tetsuo found the bug anyway.
> > Perhaps you can exclude commits that only touch architectures other than
> > x86?
> >
>
> It would be nice if coverage functionality can extract filenames in the source
> code and supply the list of filenames as arguments for bisect operation.

What is the criteria for file name extraction? What will bisect
operation do with the set of files?
If you have a feature/improvement request, please file it at:
https://github.com/google/syzkaller/issues/new
