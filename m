Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9833A1C4FFB
	for <lists+linux-security-module@lfdr.de>; Tue,  5 May 2020 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgEEINU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 5 May 2020 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbgEEINR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 04:13:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED88C061A10
        for <linux-security-module@vger.kernel.org>; Tue,  5 May 2020 01:13:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so639189ljg.12
        for <linux-security-module@vger.kernel.org>; Tue, 05 May 2020 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCtbnn/mPSYMTovrACT2kKrxnwGdokswItkXqrNBN20=;
        b=Ds/TGo88InOgXEcC2Gt5/VgiFUU8yBoN4mf50voWf0ReQi8v5PKgYBXhp/82AjMhqB
         rTJsuC5+jFz4XMfzl/6020xwtmeCq6QkJs2++a/n+/kMYDSpiRAHYh1yF8UfJO5L7UwR
         2DAf67oLsyBJ5mLJtL91w5TAlbn6wdGv9X5gfILWFZD9RbWmIJkxZ8WXX6BiBOpJ4ZZs
         H0UY8zhoYXsuMzNUNAukprACSGCpQMCw7tvWQYxBu6+4K9+5sgqLkPHgIEuklCZyYvqd
         iSoCM2UNPS79xcfwFMFQgG3A2znyPS1q8ogklxD926Qj892yKoqT7ioU+9X6DS6s78N4
         KFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCtbnn/mPSYMTovrACT2kKrxnwGdokswItkXqrNBN20=;
        b=ft85AyOnqBv9cQCsnv0meE8/rqa5o1a5mSoeTscuzFJu0tw0jvUiOLIQzbYn3NCEv9
         1eVrTkCXd3ofWN+D2MXxGidvEv+rV07Oc5b8c+tffH9Pp3XuSbwwfRSxyUgmibdSEYv7
         2hlZLH9P8pC9VbfCTMcRh4nVX5eRmCZse9jIp4Coiayy8fFcavFJurDi85EI/J6/+ZCW
         c0UC3/KGdkJXR1tc4kAdxIcJjk7oNIeWDOVjYtyLwS6TF0GF1DIbWwuIhEPJM99LXAuB
         pyHUc3LoFqNxnAyf4jrBLFu1drXqtDOfNjZcjbxxGlxQGyD5TG/LDU32xgR068LfVRhY
         RQeg==
X-Gm-Message-State: AGi0PuakyRfpuLSKFju9uIrh874wsMaPJR5KjBpsIBJESkTYt1uFYidB
        Z8cm6KUQb70YPsEDI0jUOwcPGEJ/V2rdMIeh1evvuw==
X-Google-Smtp-Source: APiQypJUpeM7dR82Dn4AY7wcHcK7ejTccxr/K+9YNhjOMoBLs1Z8eehQdWNAzTelKtxHX1iwrzM/YGhrn32nrSdwdS8=
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr1135471ljc.8.1588666393650;
 Tue, 05 May 2020 01:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org>
 <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com> <CABVgOSkAAb7tyjhdqFZmyKyknaxz_sM_o3=bK6cL6Ld4wFxkRQ@mail.gmail.com>
In-Reply-To: <CABVgOSkAAb7tyjhdqFZmyKyknaxz_sM_o3=bK6cL6Ld4wFxkRQ@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 5 May 2020 10:13:02 +0200
Message-ID: <CADYN=9+AvFYgXKCrT_xwR50b0cPihgCiBvzOypOGNkho2GsvBA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Marco Elver <elver@google.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 2 May 2020 at 04:11, David Gow <davidgow@google.com> wrote:
>
> On Sat, May 2, 2020 at 4:31 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Fri, May 1, 2020 at 1:35 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > Make it easier to enable all KUnit fragments.  This is needed for kernel
> > > test-systems, so its easy to get all KUnit tests enabled and if new gets
> > > added they will be enabled as well.  Fragments that has to be builtin
> > > will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
> > >
> > > Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> > > someone wants that even though KUNIT_RUN_ALL is enabled.
> >
> > I would LOVE IT, if you could make this work! I have been trying to
> > figure out the best way to run all KUnit tests for a long time now.
> >
> > That being said, I am a bit skeptical that this approach will be much
> > more successful than just using allyesconfig. Either way, there are
> > tests coming down the pipeline that are incompatible with each other
> > (the KASAN test and the KCSAN test will be incompatible). Even so,
> > tests like the apparmor test require a lot of non-default
> > configuration to compile. In the end, I am not sure how many tests we
> > will really be able to turn on this way.
> >
> > Thoughts?
>
> I think there's still some value in this which the allyesconfig option
> doesn't provide. As you point out, it's not possible to have a generic
> "run all tests" option due to potential conflicting dependencies, but
> this does provide a way to run all tests for things enabled in the
> current config. This could be really useful for downstream developers
> who want a way of running all tests relevant to their config without
> the overhead of running irrelevant tests (e.g., for drivers they don't
> build).

It will solve that as well as for a tester doesn't have to go through all KUnit
tests fragments to turn them on.

> Using allyesconfig doesn't make that distinction.

We could also create a config fragment file in kernel/configs/kunit.config
where we set
------start
CONFIG_KUNIT=y
CONFIG_KUNIT_RUN_ALL=y
CONFIG_SECURITY_APPARMOR=y
------end


So, these two can only be enabled if KUNIT=y
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_PM_QOS_KUNIT_TEST=y

and for this one we have a pre-request of SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y

Other tests solves the dependencies with 'select' like
CONFIG_EXT4_KUNIT_TESTS, that adds this row in
fs/ext4/Kconfig, 'select EXT4_FS'

But I think we should try to minimize the number of 'select' statements,
in order to avoid circular dependencies and unexpected behaviours.
Maybe we should add the CONFIG_EXT4_FS=y into the kunit.config
file instead ?


>
> Ultimately, we'll probably still want something which enables a
> broader set of tests for upstream development: whether that's based on
> this, allyesconfig, or something else entirely remains to be seen, I
> think. I suspect we're going to end up with something
> subsystem-specific (having a kunitconfig per subsystem, or a testing
> line in MAINTAINERS or similar are ideas which have been brought up in
> the past).
>
> This is a great looking tool to have in the toolbox, though.

I agree!

I'll prepare a patchset with individual patches as was suggested by Marco
shortly.

Cheers,
Anders
