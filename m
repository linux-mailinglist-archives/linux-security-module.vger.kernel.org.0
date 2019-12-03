Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABCE10F4E3
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Dec 2019 03:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCCQb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Dec 2019 21:16:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35861 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLCCQb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 21:16:31 -0500
Received: by mail-io1-f67.google.com with SMTP id l17so1908570ioj.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 18:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FmVBTXjq88Hry0qiiEQRrTy4JWsRY3e3a/izCmj+jE=;
        b=RM4sdkKos0+DLSXtTaOY/VFWAUpjWnozpfLZnskKBTYr2hlXMdUI7Bt6pFVEInVFRj
         eqtV7pezZixxEHUgibpWPJg7p9EH5TZVSQcHgHGdP1ZyPyD/5md5aexijOe5ZiP+p4kP
         ZlAmDKaBeXIrHcUdYyD9E868pRUw7a7R3Rl6zFKtZB2oZfwC1cT5WjFcllc0DcQ+/itH
         QAQhwoOlb+9DLnfyR4wYGTcIgh4Eser1Chw09f+p+HCRnU8rLgLHW3ilNek5zubK2JpF
         Km7Uu45iSsrLuGuhcF6TR4ogZ9rKH/T2zZKJ91xYe2O1ANiEvLkRMU4E/QKWqzhJsv1S
         c+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FmVBTXjq88Hry0qiiEQRrTy4JWsRY3e3a/izCmj+jE=;
        b=XN64wPq6Vk2DzCSZH8fC6eJyujOCXRtRdriti0j6lumg3r6W0KmM/b3hoktO4Nubyp
         dFf1OJsIpfONo4a+2dS0MGaSsXSw0Y6ERAzdDPNQGBSCrbcz24jbjj/YST8dpaAihz12
         76Qe+rCYN80kTKdjzZmlPHnmlRyROIizEkfCbVnaMQwiZ3uPomf1Eggqqdkd4YmssuoR
         s9ZnsGhqerb4H5jmDPgIH8jyvzYkKmr3Pc9IlQMYFZ/ITK9ly66cSc1oiS6qkgHeU5LV
         spHhIleFtV8uknlL7mgY7ag/uPuIX/u/+GbfEsZ1s0ntuPYJPJWiEG/He4NFREZAw1wl
         w2uQ==
X-Gm-Message-State: APjAAAU52oDby4VPNYLtiX1Y+BP9NtAdhNRP1ZXfHL/636YV1xRJylST
        h9INVk7Xd8YQIZiA6wtqc2Gh7Hc81dxRR1LBu09az39TRe0=
X-Google-Smtp-Source: APXvYqy27FU1e+ptmkUmaAPdFoJQGG4+jrGnqqjqlhA3O1hJysk8Xh1GrzuoCnBYI4fgyqymiKu6oE2MxycGDK+lzb4=
X-Received: by 2002:a6b:f70e:: with SMTP id k14mr525410iog.169.1575339390110;
 Mon, 02 Dec 2019 18:16:30 -0800 (PST)
MIME-Version: 1.0
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook> <62ccc074-ac6d-edea-10c6-925f99dfc592@gmail.com>
In-Reply-To: <62ccc074-ac6d-edea-10c6-925f99dfc592@gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 18:16:18 -0800
Message-ID: <CACdnJuuDKX2GXZoubLGFoh8D3a1a38j+9rwu2iBZG6pqpqgokw@mail.gmail.com>
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Matt Parnell <mparnell@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, matthew.garrett@nebula.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 2, 2019 at 6:01 PM Matt Parnell <mparnell@gmail.com> wrote:
>
> I should also mention the kernel itself thinks it is vulnerable with the
> MSRs locked down:
>
> [    7.367922] L1TF CPU bug present and SMT on, data leak possible. See
> CVE-2018-3646 and
> https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for
> details.

The lockdown code doesn't touch any of the codepaths the kernel uses
to access MSRs itself (a *lot* would break in that case), so if the
kernel is asserting this inappropriately then that seems like a kernel
bug.
