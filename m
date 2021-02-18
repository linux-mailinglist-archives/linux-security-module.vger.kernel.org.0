Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EB31EFA6
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Feb 2021 20:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhBRTUa (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Feb 2021 14:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhBRSWT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Feb 2021 13:22:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB5C06178A
        for <linux-security-module@vger.kernel.org>; Thu, 18 Feb 2021 10:20:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r21so4005019wrr.9
        for <linux-security-module@vger.kernel.org>; Thu, 18 Feb 2021 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6JvujsO2Df0YCGBHxHBzGTn/K+aJ9sF4URnvS2DhpE=;
        b=PdfBdSipNfU5cOPT5ougmEeo1+CgHeQo5k4LU11qUA75lMd1w6OVTj8jJ35bSIgRjS
         EMd5rFVvXZiggdJW8H+Wl8zQtqf+9sRr+g1Vf8b7CpIMTW8d1cehZKK4q8vcDen9wlEI
         bqdwgI3tBZ9gFMBkPkLMtJ5nGzKss0j+GGyaOuXBZiaoD3iLWdFC28cHR/0gamPSICv/
         d3AYYIWpahamNxP+PDQVxHmZRkbDK2Qu3eMPrmHz4qNPQ6Re0FzknP3g8IHuxNkUbgF8
         uA+tgiA8NeNwQVMQ98t6CBAuh2ri7ALC9Un3EZ609BRhXPPN2b45p48itrnlUsRt1z41
         AG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6JvujsO2Df0YCGBHxHBzGTn/K+aJ9sF4URnvS2DhpE=;
        b=Qr4Wm9Wt4CsaUBjHxG4vEbesl9NOPpjW6frCWbTpU9R4BisGZEUo0Rdrbf7jPxQAtl
         cudRHR5LJ4Gq5FpSB3zaL8VvLS/kjwFNKKZmtePnrP2hb3JoURncM/Kl4aQuCy70hFZo
         KrqAMZ0v6UReeOsUujjr2Zcz0ybkf9fI2lZhM7HMacB/0eGj4r6gwTvNJWVnBR3D2L6J
         nhYVx+hM0AMCuljLt07A6+wzmhg9+zuPi8MPHPCM4ErJs8WKxeiP/swsESY1GkCg7iqi
         ekhUpAO1KOywmwWWoCZ/bBnLr4fhs+7UuuuKE895LFs9oFf4/9ay9GyuE7Cn/4+KsPCb
         n21g==
X-Gm-Message-State: AOAM5333s3K8NYRSwyXG8CYLO4B1qg3lmHUEuMO+HZTWhCu/cM9L/1O/
        WSRKHVxcLX4+V6YmXvOuXceYaHNV72cudy/+GcXPhQ==
X-Google-Smtp-Source: ABdhPJwUro94gO/qGz4eRbhu+BIbq6W4NJ6UwoC0fGKFP2tvyoO+3SM/RLEPxTtE0knIsRq3pcxCN07LlInrrW6ZteU=
X-Received: by 2002:a5d:610a:: with SMTP id v10mr5622545wrt.334.1613672442415;
 Thu, 18 Feb 2021 10:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20210202053046.1653012-1-surenb@google.com> <079db245-a08c-0dbd-01d4-8065f533652e@gmail.com>
 <CAJuCfpGotx_04Stn5Nw6Au+TVG9LuAJ=CB_s7uxjMLOLerw-GA@mail.gmail.com>
 <2d303517-cdcd-9ec8-e57d-3d065edb573c@gmail.com> <CAJuCfpFC0B=jXFEuPYYBZAjgx1B6S8vG-i7_0iBc_RHeWynyzw@mail.gmail.com>
 <7fb20d93-92d0-14b3-f7f9-8b9af4ebb584@gmail.com>
In-Reply-To: <7fb20d93-92d0-14b3-f7f9-8b9af4ebb584@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 18 Feb 2021 10:20:30 -0800
Message-ID: <CAJuCfpGpeccwOueJFdZo-XUdr856Gk1sMUFvZN003HEvNgTTQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] process_madvise.2: Add process_madvise man page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 17, 2021 at 11:55 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Suren,
>
> >> Thanks. I added a few words to clarify this.>
> > Any link where I can see the final version?
>
> Sure:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/pro=
cess_madvise.2
>
> Also rendered below.

Looks great. Thanks for improving it, Michael!

>
> Thanks,
>
> Michael
>
> NAME
>        process_madvise - give advice about use of memory to a process
>
> SYNOPSIS
>        #include <sys/uio.h>
>
>        ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>                                size_t vlen, int advice,
>                                unsigned int flags);
>
>        Note: There is no glibc wrapper for this system call; see NOTES.
>
> DESCRIPTION
>        The process_madvise() system call is used to give advice or direc=
=E2=80=90
>        tions to the kernel about the address ranges of another process or
>        of  the  calling  process.  It provides the advice for the address
>        ranges described by iovec and vlen.  The goal of such advice is to
>        improve system or application performance.
>
>        The  pidfd  argument  is a PID file descriptor (see pidfd_open(2))
>        that specifies the process to which the advice is to be applied.
>
>        The pointer iovec points to an array of iovec structures,  defined
>        in <sys/uio.h> as:
>
>            struct iovec {
>                void  *iov_base;    /* Starting address */
>                size_t iov_len;     /* Length of region */
>            };
>
>        The iovec structure describes address ranges beginning at iov_base
>        address and with the size of iov_len bytes.
>
>        The vlen specifies the number of elements in the iovec  structure.
>        This value must be less than or equal to IOV_MAX (defined in <lim=
=E2=80=90
>        its.h> or accessible via the call sysconf(_SC_IOV_MAX)).
>
>        The advice argument is one of the following values:
>
>        MADV_COLD
>               See madvise(2).
>
>        MADV_PAGEOUT
>               See madvise(2).
>
>        The flags argument is reserved for future use; currently, this ar=
=E2=80=90
>        gument must be specified as 0.
>
>        The  vlen  and iovec arguments are checked before applying any ad=
=E2=80=90
>        vice.  If vlen is too big, or iovec is invalid, then an error will
>        be returned immediately and no advice will be applied.
>
>        The  advice might be applied to only a part of iovec if one of its
>        elements points to an invalid memory region in the remote process.
>        No further elements will be processed beyond that point.  (See the
>        discussion regarding partial advice in RETURN VALUE.)
>
>        Permission to apply advice to another process  is  governed  by  a
>        ptrace   access   mode   PTRACE_MODE_READ_REALCREDS   check   (see
>        ptrace(2)); in addition, because of the  performance  implications
>        of applying the advice, the caller must have the CAP_SYS_ADMIN ca=
=E2=80=90
>        pability.
>
> RETURN VALUE
>        On success, process_madvise() returns the number of bytes advised.
>        This  return  value may be less than the total number of requested
>        bytes, if an error occurred after some iovec elements were already
>        processed.   The caller should check the return value to determine
>        whether a partial advice occurred.
>
>        On error, -1 is returned and errno is set to indicate the error.
>
> ERRORS
>        EBADF  pidfd is not a valid PID file descriptor.
>
>        EFAULT The memory described by iovec is outside the accessible ad=
=E2=80=90
>               dress space of the process referred to by pidfd.
>
>        EINVAL flags is not 0.
>
>        EINVAL The  sum of the iov_len values of iovec overflows a ssize_t
>               value.
>
>        EINVAL vlen is too large.
>
>        ENOMEM Could not allocate memory for internal copies of the  iovec
>               structures.
>
>        EPERM  The  caller  does not have permission to access the address
>               space of the process pidfd.
>
>        ESRCH  The target process does not exist (i.e., it has  terminated
>               and been waited on).
>
> VERSIONS
>        This  system  call first appeared in Linux 5.10.  Support for this
>        system call is optional, depending on  the  setting  of  the  CON=
=E2=80=90
>        FIG_ADVISE_SYSCALLS configuration option.
>
> CONFORMING TO
>        The process_madvise() system call is Linux-specific.
>
> NOTES
>        Glibc does not provide a wrapper for this system call; call it us=
=E2=80=90
>        ing syscall(2).
>
> SEE ALSO
>        madvise(2),          pidfd_open(2),           process_vm_readv(2),
>        process_vm_write(2)
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
