Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D74BC0C1
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2019 05:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409006AbfIXDbJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 23:31:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45947 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408868AbfIXDbI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 23:31:08 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so839484iot.12
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEueK3CR530Cn8YwvlpswATDviFm42G64mVpbmzRlU0=;
        b=DvZFu4PhLqNkQifEHPCTm8AzcdIc5wXbzz/cLcFIqSUlaU06CXDVV2lpreOn70UcPc
         uQAMp1TtvZ/IIQ/M+wyycdhlTmptZ8be3gluSJLsBEB/VPDPoXvAu/LJGyFG31V/9Q/O
         nQVdJdICfjCmj4ZopxyIiAoE+ObpZRpoS4oJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEueK3CR530Cn8YwvlpswATDviFm42G64mVpbmzRlU0=;
        b=tt0Ev/ZEDQjP/DvVRHdeaXxCjSdYPZsDKZp4QNtgN5b6tR4p1MALdEQ/hHUMkAG1ni
         Z1yLnO1VmEWl3lFpmcL9pYJ7+NZdSSMG3LtWi2soDHnmpjYQM49Od8l5piT3YE8gHg9H
         EYb/wk8uWGe6+BR8/OaXPLPiISXZlMzrgb2cWMeY47y+GH5qghx0KbOEM+WWEB9KEOcT
         O6fwBvmKQom9kiRsdg1E4ywOO+d5I8uz97Fq7JLuFSR9HQQFmGJ4fnCOoWuUkylppj8y
         L7Jaqvb51werv8bS+PNMTkBfyvDsaoYqfrjdlrWFBceZtog4m/XgAB2oqPkiiccxd6/l
         mAkQ==
X-Gm-Message-State: APjAAAUriuzu6tlN+iW6+v8ssK2nTV2SfgcQQ/6vsWH76ASnetNQBvEG
        JXjgze94TZOknLarQrRzZdfGtPRF1G5+ChYT2BQzLbpqeUs=
X-Google-Smtp-Source: APXvYqz0WKVcfAtIDnOv8+vZOsCQbnc4AlcTrWDoQGlP5KcmtkDB+q77PwCxqlr7szAGoWsuneUbSv5kn57gIprr7Ig=
X-Received: by 2002:a5d:9441:: with SMTP id x1mr933357ior.160.1569295866351;
 Mon, 23 Sep 2019 20:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
 <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 23 Sep 2019 20:30:54 -0700
Message-ID: <CAJ-EccMy=tNPp3=PQZxLT7eovojoAdpfQmqhAyv7XO3GwPQBMg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Morris <jamorris@linuxonhyperv.com>,
        Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 5:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 23, 2019 at 4:35 PM James Morris <jamorris@linuxonhyperv.com> wrote:
> >
> > My understanding is that SafeSetID is shipping in ChromeOS -- this was
> > part of the rationale for merging it.
>
> Well, if even the developer didn't test it for two months, I don't
> think "it's in upstream" makes any sense or difference.
>
>                      Linus

Yes, SafeSetID is shipping on Chrome OS, although I agree having that
bug in 5.3 without anyone noticing is bad. When Jann sent the last
round of patches for 5.3 he had tested the code and everything looked
good, although I unfortunately neglected to test it again after a
tweak to one of the patches, which of course broke stuff when the
patches ultimately went in.

Even though this is enabled in production for Chrome OS, none of the
Chrome OS devices are using version 5.3 yet, so it went unnoticed on
Chrome OS so far. In general the fact that a kernel feature is
shipping on Chrome OS isn't an up-to-date assurance that the feature
works in the most recent Linux release, as it would likely be months
(at least) from when a change makes it into the kernel until that
kernel release is ever run on a Chrome OS device (right now the most
recent kernel we ship on Chrome OS is 4.19, so I've had to backport
the SafeSetID stuff).

We've found this SafeSetID LSM to be pretty useful on Chrome OS, and
more use cases have popped up than we had in mind when writing it,
which suggests others would potentially find it useful as well. But I
understand for it to be useful to others it needs to be stable and
functional on every release. The best way I know of ensuring this is
for me to personally run the SafeSetID selftest (in
tools/testing/selftests/safesetid/) every release, regardless of
whether we make any changes to SafeSetID itself. Does this sound
sufficient or are there more formal guidelines/processes here that I'm
not aware of?
