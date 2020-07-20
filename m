Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F097322636F
	for <lists+linux-security-module@lfdr.de>; Mon, 20 Jul 2020 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGTPgY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 Jul 2020 11:36:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44281 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGTPgX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 11:36:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id j10so13341069qtq.11
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFoh97oae0Rb5vUdSdKUGZfnYVAcArS7V5JbhPMh2wE=;
        b=O6nKVBUmQqXzRt7+GpvHxCiUUwgUrnaz0Pwbo86uzQMh4Hr6OmEG22OjM4euw1Mysx
         +z6+jkh73xiMDZT7yE59bdgRRSg5nO6tg4q1acw/GasxZ+2sBb0ydvPpZq19yN7d9Psv
         Y5PybKPlFE0pJT2//wXxATjb1NKTwwlmIQe8bvH9iwZrSl7pRDhRBxmR/PVFJuZaB9LI
         MhFQPrwulvB7AIqN7oJr1QcqxW0W3u00VHh2wGs/E8fAWqGk/mbLOqAdsNuGfqHAuOri
         lkfoxCRcK9xTBtkdTXW7viVlUkzS9zwXRIzokmvfAr42CsxS82AJlgS2zcSJFbEBaIfd
         bdaQ==
X-Gm-Message-State: AOAM5304WitvbcEvGb+w+FhkMyYgysXIMMSfLeWFoR1T5grOFBekC3gv
        gHc/L+/WHXkCeA2LyJ8jKGMlhvhoqlyZvaVl12bNHg==
X-Google-Smtp-Source: ABdhPJwC++Gvn0aYYwS9C91dR/Tp2tJPv0oqOZJ9lXe3RtEgUOjvnIxUxPgGjYR4ezkRPzcWmrtAbJFUM4YqzuRXWR4=
X-Received: by 2002:ac8:1a26:: with SMTP id v35mr1367514qtj.177.1595259382589;
 Mon, 20 Jul 2020 08:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200720091328.290336-1-mtk.manpages@gmail.com> <20200720091328.290336-13-mtk.manpages@gmail.com>
In-Reply-To: <20200720091328.290336-13-mtk.manpages@gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Mon, 20 Jul 2020 08:36:10 -0700
Message-ID: <CALQRfL5-aL3h6M+CYqkVHSpPKQ-i3s+RWD8060AicrGPP3vSfw@mail.gmail.com>
Subject: Re: [PATCH 12/15] Manual pages: cap_get_file.3: NOTES: note the
 effect of the Ambient set
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I've applied all but this one. This one seems to imply that if the
effective bit is lowered, but the permitted bits are raised, the
ambient will have some sort of effect. This isn't how it works. Any
file caps (even an empty set) suppresses any effect of the ambient
vector.

Cheers

Andrew

On Mon, Jul 20, 2020 at 2:14 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> The addition of Ambient capabilities in Linux 4.3 rendered the text on
> the effect of the Effective bit during execve(2) out-of-date. Fix that.
> Also add a couple of paragraph breaks to improve readability.
>
> Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> ---
>  doc/cap_get_file.3 | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
> index ceacbaf..dc7b571 100644
> --- a/doc/cap_get_file.3
> +++ b/doc/cap_get_file.3
> @@ -103,13 +103,18 @@ or
>  These functions are specified by withdrawn POSIX.1e draft specification.
>  .SH NOTES
>  Support for file capabilities is provided on Linux since version 2.6.24.
> -
> +.PP
>  On Linux, the file Effective set is a single bit.
>  If it is enabled, then all Permitted capabilities are enabled
>  in the Effective set of the calling process when the file is executed;
> -otherwise, no capabilities are enabled in the process's Effective set
> +otherwise, the process's Ambient capabilities
> +(or, before the Linux 4.3 addition of Ambient capabilities, no capabilities)
> +are enabled in the process's Effective set
>  following an
> -.BR execve (2).
> +.BR execve (2)
> +(see
> +.BR capabilities (7)).
> +.PP
>  Because the file Effective set is a single bit,
>  if any capability is enabled in the Effective set of the
>  .I cap_t
> --
> 2.26.2
>
