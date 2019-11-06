Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537CAF0B16
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Nov 2019 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfKFAff (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 5 Nov 2019 19:35:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45458 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfKFAff (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Nov 2019 19:35:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so11394234pfn.12
        for <linux-security-module@vger.kernel.org>; Tue, 05 Nov 2019 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV6+nAXCqKLxAkJ73MkPjCdygA/6kDv8a5/d5YqbKKM=;
        b=iwk05Z47ymun6qVZ2ZqvWQVrNbyrFI4pKJaqVPuEkPVoeZ8TkgQOMYeUjohJyfTxHy
         i35BEo94zplaDsUpCIniLT2yVpRSn0rD/LIMZNRRDFvwzV2sw5aV+CntsHEXnIS5QRWU
         credwKAD1iKpgmUDD//nXU9d/JxDgA1iEl62DNLFnu4wvD4qkNgQ8PPueRPgDYOLgbG/
         wRQ40/pTEPmrga86TUsN55Q89f3ccHt/vgpMxsPdm95ao3HIHGPXqJhoiqMN+sz2D0kx
         L5TvL5vphZGSYA4WnzDDvIMRkLoCjBCDf84EfTVmSdk0cpkisx4MeLqnP8yYmbqeUxse
         0Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV6+nAXCqKLxAkJ73MkPjCdygA/6kDv8a5/d5YqbKKM=;
        b=Eaycz5POnuEiooBSnu/TUyaF6vNEBXI5zUISup2pMsT7cFGM0b+uTCnV73ycudF90P
         ES4ww+1f+xP7YGGttY/s3EvjR7GF3h+mK/7ECWCFmctuyR6YjoxgSk0vn8RpeLVusc81
         j7jxOVLkQeOE7l/WDifd/xYCr1B7VYDEzOLCQfwGRRB59teh76xEZg1YJVzWlSPHZwQd
         fzUAjluYOmYkoTyy+ctwv5KuIeCbzE2IAHkR/9NsmdDnezE4Lj3J3bi9zyVxJ406xszO
         BjFqzvO5h12dlKjRYPBZKhi2eB91IU0ICSfbhfsTyAI5xfMbpDlkn+szjUZyScf+LhXz
         ivFw==
X-Gm-Message-State: APjAAAUNeuiErNiB19d/CB9mlevmwkwfR4e9QPN82ujHbnJpbHig2JJD
        t3loy8BjNIg6fwtR5w0t+rTwtlH7PAtrUUOcpeJtmQ==
X-Google-Smtp-Source: APXvYqxx7uF9ghHiBuV0xbVds7C5n9sNEWRuLJWVo2JcGIMQ4ueurVpCMm+qC8uxe/bJIIoWwyQx/y3NuBylgqCZee4=
X-Received: by 2002:a63:234c:: with SMTP id u12mr38258741pgm.384.1573000534052;
 Tue, 05 Nov 2019 16:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com> <201910301157.58D0CE4D3@keescook>
In-Reply-To: <201910301157.58D0CE4D3@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 16:35:22 -0800
Message-ID: <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 30, 2019 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> > On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> >
> > > +config SECURITY_APPARMOR_TEST
> > > +       bool "Build KUnit tests for policy_unpack.c"
> > > +       default n
>
> New options already already default n, this can be left off.
>
> > > +       depends on KUNIT && SECURITY_APPARMOR
> > > +       help
> > >
> > select SECURITY_APPARMOR ?
>
> "select" doesn't enforce dependencies, so just a "depends ..." is
> correct.
>
> > > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > > +       KUNIT_EXPECT_TRUE(test,
> > > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> > otherwise there could be a buffer overflow in memcmp. All tests that
> > follow such pattern
>
> Agreed.
>
> > are suspect. Also, not sure about your stylistic preference for
> > KUNIT_EXPECT_TRUE(test,
> >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > vs
> > KUNIT_EXPECT_EQ(test,
> >                0,
> >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));
>
> I like == 0.

Oh, I almost missed this. I think the *_EQ(...) is better than the
*_TRUE(...) because the EQ is able to provide more debug information
if the test fails (otherwise there would really be no point in
providing all these variants).

Any objections?

Thanks for the catch Iurii!
