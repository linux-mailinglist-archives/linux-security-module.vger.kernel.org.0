Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD55F5CCD
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Oct 2022 00:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJEWj5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 Oct 2022 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJEWj4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Oct 2022 18:39:56 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2412D21
        for <linux-security-module@vger.kernel.org>; Wed,  5 Oct 2022 15:39:54 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1321a1e94b3so341723fac.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Oct 2022 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7/IEhAoDkrzzX8X0U3ubIc7ql44z59RBqzANu2Z5Uf0=;
        b=kZ23b8E7E6/0FLR94upG7egESjzi3A1tyWH40/a3UzVA1adzmBn18Dczn8uaxvuKCl
         Tr/HaGWe+RPW+BXG7sX14nJg/D1KRz0nKztxkwZbiC3RHZlEJa+4QEfA+8Xptm+YcDsb
         YSPidZ/h7S49vbmAt5BBra97njX2wVHj2jDIXrjIaQExOO3Iii6dQ1B8YYqQiGKKvWWz
         2T+Zcbdco8UaftMSpx6qbmGvgGxKvU9qApbz0VU52uZg41EzPl4GEnzHOs25lhXI2jn9
         n+0FsmAm4RIm+Yoa93PmnrUqhXVcrie44VIuZgQIR0RtZ3r81CrDmSvC98bxfjp68XJI
         Axuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7/IEhAoDkrzzX8X0U3ubIc7ql44z59RBqzANu2Z5Uf0=;
        b=5bajf4yM5H68xT1tl+wjpXffyUufFRAilChnM+ZZUVukGnqqEr3qQe/CTTxqgRQTLt
         s869TIGAbJVkx7kIGU63JQM8QrnwvLprfZCbiFZMiORB8x9JNApAXq70MuKhu17O41gI
         qCiYc4zjBVx8zR6og4+Lr6AlF2IEY1/D6WQCmD6E3j/n5suoznwV9RctcHyo7q4Lvh7g
         nLWbYsltn/vwm/4yFoGzh1OOXXcWY7eJ3x2BRA+DpPyTVV1xEe6I/gVXQ1SS3EPRf+oL
         NH/E+kFlP1oUml+QO+Dzesz2RyKpHduDxawPXxHB9j63zoNEek3rFuHo9eKa4ffSkUZq
         zBwQ==
X-Gm-Message-State: ACrzQf0/joTq1OZmAigfzsRNO0HENLuHyLPVat7tvlVvf8Z6lIOjAltM
        CuiWTvsfFTQe1hJRzV8jG2vAfO98MFoJHwIvYFQzFaG4uA==
X-Google-Smtp-Source: AMsMyM5AAhn8YgtcxdVMXOFsfKzzHCfetyAskkmbd280FHnRv2Kq5uc0B6aaAvruABfTQT9GgQ8/MZ2CUNz/QhJvBA4=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr1042018oab.172.1665009594158; Wed, 05
 Oct 2022 15:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
 <87r0zmigx6.fsf@email.froward.int.ebiederm.org> <CAHC9VhSK=oYxV=MzT7BLD3TuzQYiX0aY7h1aPb25wuRN=vPyKg@mail.gmail.com>
 <87a66ae15h.fsf@email.froward.int.ebiederm.org> <CAHC9VhTmfRhYCJibpZ20ibH-JhVMrwbpFdCtKUz5tqFHsjLRiw@mail.gmail.com>
 <874jwic66q.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jwic66q.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 18:39:43 -0400
Message-ID: <CAHC9VhQ+WRgtrdzc_WedFM8=LMdApBDLORV56pCk_KSNkH0ugg@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 5, 2022 at 5:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Wed, Oct 5, 2022 at 11:33 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >> > On Wed, Oct 5, 2022 at 8:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > ...
> >
> >> >> Effectively he said that where two or more out of tree LSM policies want
> >> >> something it makes no sense to discussion the actual reasons people want
> >> >> to use the hook.
> >> >
> >> > Runtime kernel configuration is inherently "out of tree", this
> >> > includes not only loadable LSM security policies (e.g. a SELinux
> >> > policy), the system's firewall configuration, things like sysctl.conf,
> >> > and countless others.  Please understand that "out of tree" in this
> >> > context is not the same as when it is used in the context of kernel
> >> > code; the former is actually a positive thing ("look we can configure
> >> > the kernel behavior the way we want!") while the latter is a
> >> > maintenance and support nightmare.
> >>
> >> Paul are you saying my experience with /proc/net pointing incorrectly at
> >> /proc/self/net instead of /proc/thread-self/net is invalid?
> >
> > My comment was that runtime kernel configuration is always going to be
> > out of tree due to its very nature, and conflating runtime
> > configuration with kernel code is a mistake.

...

> Given that the logic and it's bugs are going to be out of tree I do not
> agree that we should only consider what goes into the kernel when
> looking into that kind of code.  Instead we should treat it will all of
> the due diligence that we attempt to use when creating a system call.
> That very much has not happened here.

Eric, I disagree with most of what you said, to the point where we
could probably go round and round in circles for days on this and not
be any closer to an agreeable conclusion.  I don't know about you, but
that is not my idea of time well spent, especially since Linus has
already voiced his opinion on the matter.  I will end my comments here
with the hope that someday soon you can at least find the ability to
respect the consensus decision, even if you can't bring yourself to
agree with it.

-- 
paul-moore.com
