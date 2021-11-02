Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860F2442E98
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Nov 2021 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKBNBZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 2 Nov 2021 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhKBNBY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Nov 2021 09:01:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B390C061714
        for <linux-security-module@vger.kernel.org>; Tue,  2 Nov 2021 05:58:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m14so22659428edd.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Nov 2021 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oS5P08rKOHmHVOqFsv1wlAiyj1NrRmUfampI9oL2V64=;
        b=n5PHQAW9dm9kSkiLYV9daCoVja0+TvWv0SvPUz8RC2NAWnAS31ToFveGA1/UPb7uYB
         f2DFw4kpYFhgjAav2FZdaU4krkdZ7po9IsPMKSRj4oEE7vb5V/lMQlEBKVfIZlCwUM6y
         W9aK0lSYkAOZmx8r4UpzYRovgJbgvMlb7iUfZ+YUBflrQE4/62VAeOfpv26y5Xn0Gm3J
         q3zC3SpxcC96EDC1+fvOA9T2Wf5EiD6cs6axCkiyJICxLsJq6xHYZRb0RShO3obZkJMU
         aEtStNkbcZgbr2ZF4OuZBneJBBa0HWbEyaYhLCSyNlaANsI6r0GVcXsUG8TWX1fH649s
         W1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS5P08rKOHmHVOqFsv1wlAiyj1NrRmUfampI9oL2V64=;
        b=HSw6XftqKc+Fcg4Wqm16zfjLyWlGnY+6iTTZ9LrMtBDkQcl6osh9QbHA7IxLYZISI/
         tXEpHgZBUJyoCD63ti89UxmNhqSLK1oMeS7Mq5zcVURzqVF9npaEIQMfyJ3ypAQhCTCS
         YJbjd2DYX0D89Qvp5+daO601MGn4VA4b1Lx9oA/xs3P2iVsatf67WMNlq5V0RH1zc/XT
         eCSq1N97AaUXUg2RQJ5N2ku3FY1C0DPIP4e8g/Da7g8T+tsRAsjqsIwj+H2CP51GySn/
         zcGAv4GZ7S3jQxFEiPDBbI6mFMVHx1f0JGRjxFkTqhqgydDrXI5UTfF3KTKFkzAPEirx
         bGlQ==
X-Gm-Message-State: AOAM533JxOHccwslUBy+aeh4Sa80dieGdjHMGttChEzzHUcFlQk+bKa7
        mSoBzZ2dHXSBdJqilySjWQnCkzQVAD8FcaYzT3zEYHDoSw==
X-Google-Smtp-Source: ABdhPJydRuxERCqDLUerKHEo8hrEbU94yrYYszodlvCbnReZNWzPvF4WrAzB6P1x8AOkiMpqhUts8Pw23pMvedkoZ/M=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr25449694ejc.126.1635857926118;
 Tue, 02 Nov 2021 05:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
 <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com>
 <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com> <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
In-Reply-To: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Nov 2021 08:58:35 -0400
Message-ID: <CAHC9VhTZW-thM3rhMArYNQYD1PjLWh3Y3XBQ_XGv86TqkN3GVg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 2, 2021 at 12:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 1, 2021 at 8:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This follow-up was sufficient. In fact, the original should have been
> > sufficient for me.
>
> ... and as you saw from the pr-tracker-bot, it's all merged now.
>
> Sorry for missing that part of your original pull request.

The important part is that it is now in your tree, thanks.

-- 
paul moore
www.paul-moore.com
