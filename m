Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2084857
	for <lists+linux-security-module@lfdr.de>; Wed,  7 Aug 2019 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHGJEK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Aug 2019 05:04:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43303 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHGJEK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 05:04:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so1016605otp.10
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEID4hdTU9OsE5Olv2ITic1w7RC+FwSfy06kTRhmLAU=;
        b=tm3vjwdrSmhydT/BngaZ4D2guziS0KvNUwGsyqlHQwb+vS5LAKappAwNqm16YG4s80
         1iyco+xqoSe9NicXaMOzfQkqvNQ54gDo442yWGxxUrP44xp9u+toJpj5d7lYRyOJxkwN
         Y1+9yQtqXWmVbmzbi49/xNT9OaVoZti+48FQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEID4hdTU9OsE5Olv2ITic1w7RC+FwSfy06kTRhmLAU=;
        b=hodtJMe8M1yd6KUNEHdHao70Yp8qHg+drj+lkiH/hBT15J7h8xRic6JAWATVqJFkHg
         Q61D0a9WCL54dMMX95y0EdnuyFtpSuiFMx5V5AXLUAooykCgLA6CsO2+6C4BnW3RVY0/
         cj+paXd0moPQj8foJy+HDOBkkQUkyJz6v8vbm0wHP3bo1DSkLyKycrVw+FRfq1VBtNRK
         Nj17L0CoTQWmy8sB5h8Acg+CGhRxUzK+rkn4Sp936suHVuF/a2Aeycba1CrCOUOPfWAz
         T3akj06yhs1DACxqTqGOJELSGEADNWio9YTt/1Chva5vjA6fEC5nEGWApZ5WhDFN962i
         jiBA==
X-Gm-Message-State: APjAAAXQ6apUWPliynFzses1+WsXJNSBdrIhEqHLJqLpJQqfL5DN6N/F
        MewKrmfZi10Ab9HWG2wzj9FUJtFfXF+4awCB+ByOMQ==
X-Google-Smtp-Source: APXvYqxo3V1y9sCi7dZxUrDx795buEc6t5ypLDcJyjSBO2fNRxIwTpRSLHtVX8CsTXxFONDTe86DoWRJdEj11+wyvcY=
X-Received: by 2002:a05:6830:1485:: with SMTP id s5mr6423742otq.132.1565168649273;
 Wed, 07 Aug 2019 02:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <D4040C0C-47D6-4852-933C-59EB53C05242@fb.com> <CALCETrVoZL1YGUxx3kM-d21TWVRKdKw=f2B8aE5wc2zmX1cQ4g@mail.gmail.com>
 <5A2FCD7E-7F54-41E5-BFAE-BB9494E74F2D@fb.com> <CALCETrU7NbBnXXsw1B+DvTkfTVRBFWXuJ8cZERCCNvdFG6KqRw@mail.gmail.com>
 <CALCETrUjh6DdgW1qSuSRd1_=0F9CqB8+sNj__e_6AHEvh_BaxQ@mail.gmail.com>
 <CALCETrWtE2U4EvZVYeq8pSmQjBzF2PHH+KxYW8FSeF+W=1FYjw@mail.gmail.com>
 <EE7B7AE1-3D44-4561-94B9-E97A626A251D@fb.com> <CALCETrXX-Jeb4wiQuL6FUai4wNMmMiUxuLLh_Lb9mT7h=0GgAw@mail.gmail.com>
 <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com>
 <20190806011134.p5baub5l3t5fkmou@ast-mbp> <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com>
In-Reply-To: <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 7 Aug 2019 10:03:57 +0100
Message-ID: <CACAyw9_fVZFW_x4uyTAiRfeH6oq1KHv0uB2wO84u5JZyD+Unaw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 7 Aug 2019 at 06:24, Andy Lutomirski <luto@kernel.org> wrote:
> a) Those that, by design, control privileged operations.  This
> includes most attach calls, but it also includes allow_ptr_leaks,
> bpf_probe_read(), and quite a few other things.  It also includes all
> of the by_id calls, I think, unless some clever modification to the
> way they worked would isolate different users' objects.  I think that
> persistent objects can do pretty much everything that by_id users
> would need, so this isn't a big deal.

Slightly OT, since this is an implementation question: GET_MAP_FD_BY_ID
is useful to iterate a nested map. This isn't covered by rights to
persistent objects,
so it would need some thought.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
