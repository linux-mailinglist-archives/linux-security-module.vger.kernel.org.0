Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8706DEA3B6
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Oct 2019 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfJ3TCc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Oct 2019 15:02:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40084 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJ3TCb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Oct 2019 15:02:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id 15so2082386pgt.7
        for <linux-security-module@vger.kernel.org>; Wed, 30 Oct 2019 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGDBahFoMPSIZ29sHXhe1mehZlhHuZjEGPvioRijuyg=;
        b=ITHLhKwYHLawxDKJoXVFazyKfWfmJx5VWQYSzCXI3uwCtcs0q7fLyaj9SL04wb9vsM
         RlSKIzlfu4E7whMcthOGZ0RckEeTvwu4OzrBanTEIRe9aOYcmYXOA8e4hm7V0kDaVqJU
         d50WeQX+Habf5zhjgR6kw/cCCYQZ5jn9IttQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGDBahFoMPSIZ29sHXhe1mehZlhHuZjEGPvioRijuyg=;
        b=Us75zmiq9h1SKlqfkt73eb22pbUNJHHd8VgOkxPNtljFPo042Jd77F8s5DOBfdOZIy
         pwvbfAoR8u1wRyH0yAA51BCbww53hho6i83SBEl9Mw1kJEBBWSYULycWm/iBCAkb+IwE
         GWtDjWJwfKjv79iC+HGrD7fNQgXtZfMlE14DtCPmlS92m/f/OrM1TeVLQK0UJlkeI0QQ
         5byI7q7I3AqSbR7mNL10u3ItkguYDIpCZsjUg1dSRjeDew7ujABzedEAySYHsNcCUrac
         X7sMs0OmQQf31vmNL0JMR63F2VrB5VKbl1XECBy4yCXysQsFF5VxDo4mnYIbbmp1IAKt
         Hu/Q==
X-Gm-Message-State: APjAAAV2MDvD9B78IwkksrgP0i9/KHYBPCBrI0pii/GBaSbCXVemS7hh
        GPDC0syDOb/50NWsIYxfDdOHqg==
X-Google-Smtp-Source: APXvYqzota95kx11bi1wNxwIZc9AQEa/YsaYDEtNJUaPGRly4YWFB/enVi4ZfTsIfFi/BRYxa1QUGQ==
X-Received: by 2002:a62:83c6:: with SMTP id h189mr892782pfe.213.1572462149354;
        Wed, 30 Oct 2019 12:02:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm508386pgi.92.2019.10.30.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:02:28 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:02:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201910301201.404F0E3BB@keescook>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018004307.GA95597@google.com>
 <20191018162519.GH21137@mit.edu>
 <CAFd5g45LmnbD7L4LqdbfBV5YR377e81m61+z==RKCGjWBFqDGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45LmnbD7L4LqdbfBV5YR377e81m61+z==RKCGjWBFqDGQ@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 18, 2019 at 02:41:38PM -0700, Brendan Higgins wrote:
> On Fri, Oct 18, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, Oct 17, 2019 at 05:43:07PM -0700, Brendan Higgins wrote:
> > > > +config SECURITY_APPARMOR_TEST
> > > > +   bool "Build KUnit tests for policy_unpack.c"
> > > > +   default n
> > > > +   depends on KUNIT && SECURITY_APPARMOR
> > >
> > > Ted, here is an example where doing select on direct dependencies is
> > > tricky because SECURITY_APPARMOR has a number of indirect dependencies.
> >
> > Well, that could be solved by adding a select on all of the indirect
> > dependencies.  I did get your point about the fact that we could have
> 
> In this particular case that would work.
> 
> > cases where the indirect dependencies might conflict with one another.
> > That's going to be a tough situation regardless of whether we have a
> > sat-solver or a human who has to struggle with that situation.
> 
> But yeah, that's the real problem.

I think at this stage we want to make it _possible_ to write tests
sanely without causing all kinds of headaches. I think "build all the
tests" can just be a function of "allmodconfig" and leave it at that
until we have cases we really need to deal with.

-- 
Kees Cook
