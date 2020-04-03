Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740FB19E1B2
	for <lists+linux-security-module@lfdr.de>; Sat,  4 Apr 2020 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgDCX71 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 3 Apr 2020 19:59:27 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39986 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDCX71 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Apr 2020 19:59:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so3738167pjb.5
        for <linux-security-module@vger.kernel.org>; Fri, 03 Apr 2020 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YCa/Qs0yPmh3XTwnN4PsbMB277OSr9D+GN0maXxjMHA=;
        b=Bbhh3fmXAiGdRNFedcwh3XwyQ26GhP6Z9oRxi/DD0ElrQbHJt8FP23Due9BPsALnlu
         cdsBGZMeu1Kd8/vgELs72HvtyNixfzg4EaDAo5O2ENQpAqF+HriRbxrU9MqmUByE9IP0
         IyiltCvmyvjnf3QdBrKiVqJ2X8ZPSJrLSlitI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YCa/Qs0yPmh3XTwnN4PsbMB277OSr9D+GN0maXxjMHA=;
        b=rS6xsoLCFikiNLnj2YupeReVRP8oPPfz2gc3bxZ7NTJx0xQ/2tMOiTUFbV/01rT3zr
         e/kbCQLk/IZxr0XFE0EOKqVtMKu8mxZhqqnOMjOy/H6quwXsItCWI4oB0XCBXK6/1Hkq
         1qm92gRNaC3kR/d8f/YzTPOca2JMLNohAzauYoNkyOF5XpVGn/6KFwfwtMNizIwspYrh
         c6XAG5/2c6BJ8cunN4mKcFhiveozw0QIm9gbJTrAK/p+bYNjqG80W6ttm4hFEHRS/+nb
         decX5CGgmTtDcUWD1/eFDjtL2Rhv5gzxUTsbgcqhhPHQ8IaJqE+3S8E/WKypMyzkBdEO
         +jpQ==
X-Gm-Message-State: AGi0PuaYtOb3vjSIpBWBOb3/2yphr23Z5poMT9Y6h6K/DxAN2KZqjN1y
        rBBB6qcvOAte/sD/jiQ2OBLN7Q==
X-Google-Smtp-Source: APiQypKaLpvqre5tI8MwDWqt73Tqg7m9h+IsHfp66R3KYbvS+0hTX2lg8k4AHfoG5/7A9eafgxz9Gw==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr12995017pjc.41.1585958365843;
        Fri, 03 Apr 2020 16:59:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm6071311pgt.27.2020.04.03.16.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 16:59:24 -0700 (PDT)
Date:   Fri, 3 Apr 2020 16:59:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 7/9] proc: move hidepid values to uapi as they are
 user interface to mount
Message-ID: <202004031658.8D0C048E3@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
 <875zehkeob.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zehkeob.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 02, 2020 at 11:58:28AM -0500, Eric W. Biederman wrote:
> 
> I will just say that I do not understand exporting this to the uapi
> headers.  Why do we want to export the enumeration names?
> 
> I understand that the values are uapi.  This looks like it will make it
> difficult to make changes that rename enumeration values to make
> the code more readable.
> 
> Given that this patchset goes immediately to using string enumerated
> values, I also don't understand the point of exporting
> HIDEPID_NOT_PTRACEABLE.  I don't think we need to ever let
> people use the numeric value.
> 
> My sense is that if we are switching to string values we should
> just leave the existing numeric values as backwards compatiblity
> and not do anything to make them easier to use.

Yeah, that's what I had suggested too. Let's not export this to UAPI.

-Kees

> 
> Eric
> 
> 
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  include/linux/proc_fs.h      |  9 +--------
> >  include/uapi/linux/proc_fs.h | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >  create mode 100644 include/uapi/linux/proc_fs.h
> >
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index afd38cae2339..d259817ec913 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -7,6 +7,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/fs.h>
> > +#include <uapi/linux/proc_fs.h>
> >  
> >  struct proc_dir_entry;
> >  struct seq_file;
> > @@ -27,14 +28,6 @@ struct proc_ops {
> >  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
> >  };
> >  
> > -/* definitions for hide_pid field */
> > -enum {
> > -	HIDEPID_OFF	  = 0,
> > -	HIDEPID_NO_ACCESS = 1,
> > -	HIDEPID_INVISIBLE = 2,
> > -	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
> > -};
> > -
> >  /* definitions for proc mount option pidonly */
> >  enum {
> >  	PROC_PIDONLY_OFF = 0,
> > diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
> > new file mode 100644
> > index 000000000000..dc6d717aa6ec
> > --- /dev/null
> > +++ b/include/uapi/linux/proc_fs.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_PROC_FS_H
> > +#define _UAPI_PROC_FS_H
> > +
> > +/* definitions for hide_pid field */
> > +enum {
> > +	HIDEPID_OFF            = 0,
> > +	HIDEPID_NO_ACCESS      = 1,
> > +	HIDEPID_INVISIBLE      = 2,
> > +	HIDEPID_NOT_PTRACEABLE = 4,
> > +};
> > +
> > +#endif

-- 
Kees Cook
