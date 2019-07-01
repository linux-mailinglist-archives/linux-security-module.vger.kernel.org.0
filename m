Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE131627
	for <lists+linux-security-module@lfdr.de>; Fri, 31 May 2019 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEaUdF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 31 May 2019 16:33:05 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41478 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfEaUdF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 May 2019 16:33:05 -0400
Received: by mail-pg1-f169.google.com with SMTP id z3so4640939pgp.8
        for <linux-security-module@vger.kernel.org>; Fri, 31 May 2019 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uy+PJdNhNNYWmW2SYbVenlVictCiccYq0JuoB6toabI=;
        b=Jz9krRjsm6lNZDVE3lzRiVxmi2w0/9Fv++xQ39+FzyKuSnfwcVVEeWJ+71t7Rms9La
         SG0OTtc0mdJFWmMSyPO+QMfBtOJbAYl2+qWlQYYr02+AFUg3FpQM5Dhl5CY4x0wgm/EB
         /74wjVVcMlWpZajDex8gRmJrMZaP9DS5SzoQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uy+PJdNhNNYWmW2SYbVenlVictCiccYq0JuoB6toabI=;
        b=I7w7UwQKh5/Jx2FIizHp5UBbnkj+8DMkCBt/Daqzh3FfEf7SupF3kOLbULiRHVjA+W
         rbk5RURx1sky01fcJJd76zQ0cplA8oXnDrExIjad2QecAxrtXZYhPSH0CLPAOJUJ7xL9
         Qgp6EvmeaG51ueCQtmWMt4HRUymMGKIDmRhMV0+bfcN8PtsmhbknIpibye7d4A3BSSM/
         POMJzVB47vvUE4gVlrTfp/4CNUM+4pPB5uIVINbU13G/U4eLAAEkoQunMCnXlYxkH1fq
         tJSdQoF8Q22vBMcCONt3bwVe+eUezUAPUQCkUsoJeOlVtOkx/KE8+RvkUEgig4qXT5cl
         fKYg==
X-Gm-Message-State: APjAAAXGqwTpl7SSmDsRa4OPDYnwAvxzgimS1CyE7LkcCOtivajNyyuN
        5pnAi9GRVoeeIwhmFWufV+wTOw==
X-Google-Smtp-Source: APXvYqw52rZLQjWIzKJ9G6BGxcByELUH3J09kHhxfkW7luSsySLnOIjCNSGBGJ/9JSu7lpSe1f+Z0Q==
X-Received: by 2002:a63:a34c:: with SMTP id v12mr11020501pgn.198.1559334785058;
        Fri, 31 May 2019 13:33:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a25sm213079pfn.1.2019.05.31.13.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 13:33:04 -0700 (PDT)
Date:   Fri, 31 May 2019 13:33:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ke Wu <mikewu@google.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: security/loadpin: Allow to exclude specific file types
Message-ID: <201905311330.EA6B6E5F@keescook>
References: <73fac64c-fe49-4738-49a4-0afe668eed94@canonical.com>
 <201905310740.522B3A7C1@keescook>
 <c80362bd-1dec-3e4f-c3e8-1c58d3a33070@canonical.com>
 <CANRnR9Q4AY1nyTebWgkVM-wUfZv7kKNLnsrchWPBH4HPbB-X6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRnR9Q4AY1nyTebWgkVM-wUfZv7kKNLnsrchWPBH4HPbB-X6Q@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 11:03:17AM -0700, Ke Wu wrote:
> I think Coverity is correct. Note that it's the size of
> kernel_read_file_str (rather than exclude_read_files) doesn't equal to
> ignore_read_file_id.
> 
> This is because READING_MAX_ID is also an element in
> kernel_read_file_str, which makes the size of kernel_read_file_str to
> be READING_MAX_ID+1. I will send a new patch to fix the issue. Thanks
> for the  analysis!

Ah! Yes, I see now. I was looking at the wrong things. It should be
possible to just do:

> > >> 209                for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {

for (j = 0; j < ARRAY_SIZE(ignore_read_file_id); j++)

and add a

BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) < ARRAY_SIZE(ignore_read_file_id))

for future robustness checking.

Thanks for looking at this more closely!

-Kees

> > >> 210                        if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> > >> 211                                pr_info("excluding: %s\n",
> > >> 212                                        kernel_read_file_str[j]);
> > >>
> > >> CID 81977 (#1 of 1): Out-of-bounds write
> > >> overrun-local: Overrunning array ignore_read_file_id of 8 4-byte
> > >> elements at element index 8 (byte offset 35) using index j (which
> > >> evaluates to 8).
> > >>
> > >> 213                                ignore_read_file_id[j] = 1;
> > >>
> > >> According to Coverity ignore_read_file_id is an array of 8 integers.
> > >> However, ARRAY_SIZE(kernel_read_file_str) is 9, so we have an out of
> > >> bounds write on ignore_read_file[j] when j is 8.
> > >
> > > What am I missing? This doesn't fail the build:
> > >
> > > +       BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
> > > +                    ARRAY_SIZE(ignore_read_file_id));
> > >
> > > They have the same number of elements.
> > >
> >
> > Yep, that's very true. I'll discuss this with Coverity as this seems
> > like a weird false positive.
> >
> > Apologies for the noise.
> >
> > Colin
> 
> 
> 
> -- 
> Ke Wu | Software Engineer | mikewu@google.com | Google Inc.

-- 
Kees Cook
