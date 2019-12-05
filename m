Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1702114034
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Dec 2019 12:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfLELhJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Dec 2019 06:37:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39350 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLELhJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 06:37:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so3211928qtj.6
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 03:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfYIZA1x1hWCQA6g7oQ19DH7tEX6ualy3pbm/P3Lk+A=;
        b=FjAqSfZWtL5kJIRnjAfh3psbkl8pAdn9kqdwrkrc6B4f8S1BQX57V7yNhGnG0BgwL4
         z15JyoonOBeE0tT3TytWPHa3CYQzBD9Tx1POq43C8+CKKbYgMmPV0L4s8BZLCisZW0Pm
         f5LkYEtNxM7sPloRggdzD8iVN6W49sZsR+I/jfJbS6KjWa+Z1FJ1NvmgxtfYC2CLp305
         w4/Zdw6lu3ne6ZYwhPkYooh4vLuzcrPNHP7Rj3jkgz7jaVzaahUIH1/iG1bVjXkBegYp
         /DU83BC87lTZAbNf8X47Bpt+FqvVbEZvFIVSsSmXIuUebjxYpvSkwl+OHCAaL0gmPODj
         tlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfYIZA1x1hWCQA6g7oQ19DH7tEX6ualy3pbm/P3Lk+A=;
        b=ADO0I0IXRXivenh7RQcQ9vnKrs69nbHwnnK/1S9rIdDjQlw4j/M++vHDzFlLEYNn9i
         dKPrpMpxqXO1MJhu7TxyRsBOk1Gbj5O2ioj7gsPNVyn/Wkgc1LUZ03EyrorVdlLWucgy
         bgKxkeqrpff55jvNIIFLVn/amkRRcuVL8tYPkK+Wji707yWVDGZvIZj3a/GEDxF/vwn4
         /Pl83R91fV5Mb0S7+posROM9VP25qpH/d1oZNARg0DeaoP0E/6Z4XoAJx8WM335qhNkU
         fg2bpDJhVu3TD9Czo8r6rVCdqsW90CHRqiJNBsXuZ7sQQVPQT4lP1EniRUqS7XP/1bmS
         MLRA==
X-Gm-Message-State: APjAAAURph3U2X89vc1bdKw2Au+ykzWp10WL5cihtfmzVeTwN7Sy8A+K
        wPCbETmjH1cfe+jeqsh5UWN5s2AZcTFz6I6+yC5KkA==
X-Google-Smtp-Source: APXvYqzfgZJ9l6UJOOMZ2Qo7SFoVkzP/jw5YHvEyX7L/cw3KsXRUm/icBbPq7v443TCg8aD8BOA0xHa3BtNpRac5BEo=
X-Received: by 2002:ac8:ccf:: with SMTP id o15mr7086616qti.380.1575545828141;
 Thu, 05 Dec 2019 03:37:08 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003e640e0598e7abc3@google.com> <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com> <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
In-Reply-To: <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 12:36:56 +0100
Message-ID: <CACT4Y+bUkzJAezH9Pk=c1amtzO0-r1Hcn3WmDuS+Drn-R3GAQA@mail.gmail.com>
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
>
> Also, (unrelated but) it would be nice if we can have "make yes2modconfig"
> target which converts CONFIG_FOO=y to CONFIG_FOO=m if FOO is tristate.
> syzbot is testing kernel configs close to "make allyesconfig" but I want to
> save kernel rebuild time by disabling unrelated functionality when manually
> "debug printk()ing" kernels.

I thought that maybe sed "s#=y#=m#g" && make olddefconfig will do, but
unfortunately, it turns off non-tristate configs...

$ egrep "CONFIG_MEMORY_HOTPLUG|CONFIG_TCP_CONG_DCTCP" .config
CONFIG_MEMORY_HOTPLUG=y
CONFIG_TCP_CONG_DCTCP=y
# sed -i "s/CONFIG_MEMORY_HOTPLUG=y/CONFIG_MEMORY_HOTPLUG=m/g" .config
# sed -i "s/CONFIG_TCP_CONG_DCTCP=y/CONFIG_TCP_CONG_DCTCP=m/g" .config
# egrep "CONFIG_MEMORY_HOTPLUG|CONFIG_TCP_CONG_DCTCP" .config
CONFIG_MEMORY_HOTPLUG=m
CONFIG_TCP_CONG_DCTCP=m
# make olddefconfig
# egrep "CONFIG_MEMORY_HOTPLUG|CONFIG_TCP_CONG_DCTCP" .config
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_TCP_CONG_DCTCP=m
