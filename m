Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A2132DDA4
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Mar 2021 00:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhCDXNe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 4 Mar 2021 18:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhCDXNe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 18:13:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB792C061574
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 15:13:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id dm26so24248edb.12
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 15:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+pvUiOEZPbdTGLN8fNRt7l50iLnq5LKsr+xpPdAVAo=;
        b=0nwHNuENO61Aog4cf1zcPp2knTSezQUoTy4/9s3cVcuwXCZ2yXl1LapGYGZmiv8T1f
         x8CN1JWM9trwHDVo6EBXGs318W5rT/5PXLQiib+WZ42xkj9YX51SncLMX/uzohZKpGvx
         AR/yG+01wgcgmyNvz8pduR1lr9Hi6rkCIhFYz9aIKNmUNLoK1ZVz1SYZ1yly4jBg/gF4
         B/FE3rdsjtI5gd2lXC0QYhEpd4Nz/L3aSQn5Hj4yA8wyBpX2V7ZmdO4GZc0EnT0YtomT
         k6zPZiZaxSKf7DW8IxbZSsbhFyTVVC06hW89iOIcnxcjCBeppP0xxWaJpJ/T1iBfd/kh
         Rxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+pvUiOEZPbdTGLN8fNRt7l50iLnq5LKsr+xpPdAVAo=;
        b=DF1EknZyYlF2IPHr3FILf6NwQWabp5bkb7QdcnjAvC+pD3FxGrWMH1zUa3SlfT1yv5
         kq1QyXU+5ZB6ku9VnJZ0Mv3nVj0FxWSi0WjTWAt/mazOrFaBdOFEBX/GBnFQDVWT5auL
         8rNe76sMSXH0pa2f7ZvMPK74DZ1itFmPJUir7ayW1nW7XbC0JnWw/RMf33i71ugSjpH5
         DWnDfQU1GwaoSSemlnasugmTT2/yL2Iw7lZ7m1UpXMsR45rc6Q9J5cCZ/RTdm1C9PVpU
         fY2nRaEpidrrGarNX+nw35yzgjgvMu6URYlFl72RoU1dMhtwrZq82X616KPxPrRobSPE
         Rk8A==
X-Gm-Message-State: AOAM533b9B6W3jqJxak7PtjRi/4ALS7/F1TgsH0IoeaEAUpia0oclSqu
        PZnZVKZY6CaF78SKvJFHlzIwIX3rvHA1fO/hwfK9
X-Google-Smtp-Source: ABdhPJwJRixMFbL/qncluaBbkPYrbJ7ufs602jV8p+pecaJ8ftDoqgqOKAyeg6sSI37/qk2tqimCTEBju+ud9N+glss=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr6841478edt.12.1614899612580;
 Thu, 04 Mar 2021 15:13:32 -0800 (PST)
MIME-Version: 1.0
References: <161489339182.63157.2775083878484465675.stgit@olly> <20210304.143347.415521310565498642.davem@davemloft.net>
In-Reply-To: <20210304.143347.415521310565498642.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 18:13:21 -0500
Message-ID: <CAHC9VhTxfMOzABdAg=RO3k1cfyE2A2DEQ0gUQ9M6NVELpJVw7Q@mail.gmail.com>
Subject: Re: [PATCH] cipso,calipso: resolve a number of problems with the DOI refcounts
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 4, 2021 at 5:33 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Thu, 04 Mar 2021 16:29:51 -0500
>
> > +static void calipso_doi_putdef(struct calipso_doi *doi_def);
> > +
>
> This is a global symbol, so why the static decl here?

To resolve this:

  CC      net/ipv6/calipso.o
net/ipv6/calipso.c: In function =E2=80=98calipso_doi_remove=E2=80=99:
net/ipv6/calipso.c:453:2: error: implicit declaration of function =E2=80=98=
calipso_doi_p
utdef=E2=80=99

I think there are some odd things with how the CALIPSO prototypes are
handled, some of that I'm guessing is due to handling IPv6
as-a-module, but regardless of the reason it seemed like the smallest
fix was to add the forward declaration at the top of the file.
Considering that I believe this should be sent to -stable I figured a
smaller patch, with less chance for merge conflicts, would be more
desirable.

Or are you simply concerned about the static tag?  I simply kept the
static from the function definition; removing it causes a mismatch
which makes the compiler unhappy.

Either way, if you want this done another way, let me know what you
want and I'll respin it.

--=20
paul moore
www.paul-moore.com
