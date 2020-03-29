Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3AA196AC7
	for <lists+linux-security-module@lfdr.de>; Sun, 29 Mar 2020 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC2DRI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 28 Mar 2020 23:17:08 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39497 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgC2DRI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 23:17:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id z3so5190321pjr.4
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4II2bc92WqcI1jJHIbHJBRCr9XHybTRKP72pOZ2vBn8=;
        b=m9oqaykcy7+GRfPUA0qekrpwJwNqG0S1mlKb9K3dSMoiUplMP4jDXKYYiUxNSn1n+v
         4oyL3E8RvMsSp58YQD7MyGe1pOXmUDh3zVX3F14wt1es3/kyO62xLP1vqLHROC2/iG5A
         NA5fTeT/j2lxo6j6d+AbeShqGk6CPpwln0Emo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4II2bc92WqcI1jJHIbHJBRCr9XHybTRKP72pOZ2vBn8=;
        b=baoCO9v/AvG0X3iufxFu6o8fFI7CoUP573XgA9xt/0QX9PmloJ0gl0zMYXIz+5v+CQ
         0Qm8OMbDB5fxDnBmF8cES1HulbXDrz2BVW8axCiEAVMoWogkhcEoEE8Y5EyUHd3aT5ZG
         YNonZ4xWuV3LZQDJsyg1RFqAvbkwSL2iaqSqAzCWVstaqNEdcTerIOEzDMwiYVglgkDD
         ck7UIiynplEa1l8p/g28UTS/BTr7bi1lXR7CEbeXqK1fA4ylcENTBAmAIsto8c42XuAv
         fr0c0NEd5amAG7zt05rJ+F0BWiGLM/3R6eqBMvzTLx3xO4ZzR8KMv5gGyXMteCNmSOTI
         6xWA==
X-Gm-Message-State: ANhLgQ3mxxvgM3NpPH1SqVutTze5zcLXZt6MfgcoFBlsJoCMOdFU5A81
        h7t1wSiw4pUmdvQ837ypI3WP3w==
X-Google-Smtp-Source: ADFU+vtseLSYN5So1Oobu2UiukVUxTzuZN3FTYmpLjJuga7kllNUrhEyIWnwcYJIyJMu6YW0JBI/4Q==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr8294662pjk.54.1585451827508;
        Sat, 28 Mar 2020 20:17:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm7123511pfp.127.2020.03.28.20.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 20:17:06 -0700 (PDT)
Date:   Sat, 28 Mar 2020 20:17:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 7/9] proc: move hidepid values to uapi as they are
 user interface to mount
Message-ID: <202003282016.19E071712@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
 <202003281340.B73225DCC9@keescook>
 <20200328212547.xxiqxqhxzwp6w5n5@comp-core-i7-2640m-0182e6>
 <202003281453.CED94974@keescook>
 <20200328230046.v3qbffmbtl4sd7tg@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328230046.v3qbffmbtl4sd7tg@comp-core-i7-2640m-0182e6>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Mar 29, 2020 at 12:00:46AM +0100, Alexey Gladkov wrote:
> On Sat, Mar 28, 2020 at 02:53:49PM -0700, Kees Cook wrote:
> > > > > +/* definitions for hide_pid field */
> > > > > +enum {
> > > > > +	HIDEPID_OFF            = 0,
> > > > > +	HIDEPID_NO_ACCESS      = 1,
> > > > > +	HIDEPID_INVISIBLE      = 2,
> > > > > +	HIDEPID_NOT_PTRACEABLE = 4,
> > > > > +};
> > > > Should the numeric values still be UAPI if there is string parsing now?
> > > 
> > > I think yes, because these are still valid hidepid= values.
> > 
> > But if we don't expose the values, we can do whatever we like with
> > future numbers (e.g. the "is this a value or a bit field?" question).
> 
> Alexey Dobriyan suggested to put these parameters into the UAPI and it
> makes sense because these are user parameters.

Okidokey. :) Anyway, ignore my HIDEPID_MAX idea then, since this could
become a bitfield. Just checking for individual bits is the way to go
for now. Sorry for the noise.

-- 
Kees Cook
