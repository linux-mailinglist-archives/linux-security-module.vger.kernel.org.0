Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B8308D3E
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Jan 2021 20:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhA2TSx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 29 Jan 2021 14:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhA2TSg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jan 2021 14:18:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087EC061756
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jan 2021 11:17:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g10so9932556wrx.1
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jan 2021 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liQfDKvRKceA7XB6EKb5XWgSjLuEM3AmhST72W3zclo=;
        b=r/J571DBqfnEqLsI+YdH9pPH3fNemwjMXmCToqWZN0ajmzYjzIB6ybl1uPrEyHWGyE
         Tm8m8e38iNOFBCSc0OtD5SmSvepHS8GMW7M3mZxKgQE4opvDaAqSJJqKfL3l33nUxWkK
         8fEyVZME5PgmIXUFNXgJMSAaBTLdjLS06wMkRuEhIWlZOzlCBdvh5epP0I5IHTYU43OP
         gxwbRAjxdTZ4S1K4q1yC13HUB5ytms5ZYyQpCW7oxdAo+kC/RZIR37XqeqDIu3ikiKYK
         3rj6bmpJqB481oplLKH3iPPe/xYbbIEdSEnP3msVN4sxw2Hs8A5IDrsWrYsz64AF6RHt
         2FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liQfDKvRKceA7XB6EKb5XWgSjLuEM3AmhST72W3zclo=;
        b=ob7Hh5Gn6XJd6vdjs+Sw8CeeSpz8B1j4cuBQ3qvXfHjzMITJTwCR2wXTJQM1iB8/Wx
         t6uor1UD1LQxTxvOcFZdX+smx/gAldXvQ1HjypBlOdV6sVMj5dozZxxfMulQOygNVOLB
         E+2CubdA4UyH4PJYIy20F7Mi2/FPt4zSnDbqmGzK+aE7v1ImA6AlXbLwDi0Xo9PGX359
         0/yUIZIvq0igTwv9JeZ9Vt4LxPElb+jTD6k/kJBmComgU9dVmBviQXIJAP0H4XDbsezi
         3lJgWdCPQd3S194/dAmvk4Q+TXhfv/k1UrKgNvPv8knhGwBlqTf/LOVpx7ha+SG2xDcZ
         OXEw==
X-Gm-Message-State: AOAM530R2+AmPiuhLxCCxs1IeQJzfRE1oZFODHcvoPQIpAOO50GzSDyB
        JFLtzp6tytwgxvYKuUY3thKUSPEFuYfeROuUbEiP2Q==
X-Google-Smtp-Source: ABdhPJx5v0ab46b1kJYrdxWZaYXyPlDCIt5iGZT0fcZOugZx0nnLUENhofHF3wQBwn7hh81dmLgKxN8I/Wilxf5OgM8=
X-Received: by 2002:a5d:538b:: with SMTP id d11mr6364343wrv.334.1611947868795;
 Fri, 29 Jan 2021 11:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20210129070340.566340-1-surenb@google.com> <YBPRw5KuegGfnWuh@dhcp22.suse.cz>
In-Reply-To: <YBPRw5KuegGfnWuh@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 29 Jan 2021 11:17:37 -0800
Message-ID: <CAJuCfpGNkQaKeNmkq=MAOJGTkKESLL+c3LMfSxDzLfo1A29aBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] process_madvise.2: Add process_madvise man page
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
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
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 29, 2021 at 1:13 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Thu 28-01-21 23:03:40, Suren Baghdasaryan wrote:
> > Initial version of process_madvise(2) manual page. Initial text was
> > extracted from [1], amended after fix [2] and more details added using
> > man pages of madvise(2) and process_vm_read(2) as examples. It also
> > includes the changes to required permission proposed in [3].
> >
> > [1] https://lore.kernel.org/patchwork/patch/1297933/
> > [2] https://lkml.org/lkml/2020/12/8/1282
> > [3] https://patchwork.kernel.org/project/selinux/patch/20210111170622.2613577-1-surenb@google.com/#23888311
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Michal Hocko <mhocko@suse.com>

Thanks!

> Thanks!
>
> > ---
> > changes in v2:
> > - Changed description of MADV_COLD per Michal Hocko's suggestion
> > - Appled fixes suggested by Michael Kerrisk
> >
> > NAME
> >     process_madvise - give advice about use of memory to a process
> >
> > SYNOPSIS
> >     #include <sys/uio.h>
> >
> >     ssize_t process_madvise(int pidfd,
> >                            const struct iovec *iovec,
> >                            unsigned long vlen,
> >                            int advice,
> >                            unsigned int flags);
> >
> > DESCRIPTION
> >     The process_madvise() system call is used to give advice or directions
> >     to the kernel about the address ranges of other process as well as of
> >     the calling process. It provides the advice to address ranges of process
> >     described by iovec and vlen. The goal of such advice is to improve system
> >     or application performance.
> >
> >     The pidfd argument is a PID file descriptor (see pidofd_open(2)) that
> >     specifies the process to which the advice is to be applied.
> >
> >     The pointer iovec points to an array of iovec structures, defined in
> >     <sys/uio.h> as:
> >
> >     struct iovec {
> >         void  *iov_base;    /* Starting address */
> >         size_t iov_len;     /* Number of bytes to transfer */
> >     };
> >
> >     The iovec structure describes address ranges beginning at iov_base address
> >     and with the size of iov_len bytes.
> >
> >     The vlen represents the number of elements in the iovec structure.
> >
> >     The advice argument is one of the values listed below.
> >
> >   Linux-specific advice values
> >     The following Linux-specific advice values have no counterparts in the
> >     POSIX-specified posix_madvise(3), and may or may not have counterparts
> >     in the madvise(2) interface available on other implementations.
> >
> >     MADV_COLD (since Linux 5.4.1)
> >         Deactive a given range of pages which will make them a more probable
> >         reclaim target should there be a memory pressure. This is a non-
> >         destructive operation. The advice might be ignored for some pages in
> >         the range when it is not applicable.
> >
> >     MADV_PAGEOUT (since Linux 5.4.1)
> >         Reclaim a given range of pages. This is done to free up memory occupied
> >         by these pages. If a page is anonymous it will be swapped out. If a
> >         page is file-backed and dirty it will be written back to the backing
> >         storage. The advice might be ignored for some pages in the range when
> >         it is not applicable.
> >
> >     The flags argument is reserved for future use; currently, this argument
> >     must be specified as 0.
> >
> >     The value specified in the vlen argument must be less than or equal to
> >     IOV_MAX (defined in <limits.h> or accessible via the call
> >     sysconf(_SC_IOV_MAX)).
> >
> >     The vlen and iovec arguments are checked before applying any hints. If
> >     the vlen is too big, or iovec is invalid, an error will be returned
> >     immediately.
> >
> >     The hint might be applied to a part of iovec if one of its elements points
> >     to an invalid memory region in the remote process. No further elements will
> >     be processed beyond that point.
> >
> >     Permission to provide a hint to another process is governed by a ptrace
> >     access mode PTRACE_MODE_READ_REALCREDS check (see ptrace(2)); in addition,
> >     the caller must have the CAP_SYS_ADMIN capability due to performance
> >     implications of applying the hint.
> >
> > RETURN VALUE
> >     On success, process_madvise() returns the number of bytes advised. This
> >     return value may be less than the total number of requested bytes, if an
> >     error occurred after some iovec elements were already processed. The caller
> >     should check the return value to determine whether a partial advice
> >     occurred.
> >
> >     On error, -1 is returned and errno is set to indicate the error.
> >
> > ERRORS
> >     EFAULT The memory described by iovec is outside the accessible address
> >            space of the process referred to by pidfd.
> >     EINVAL flags is not 0.
> >     EINVAL The sum of the iov_len values of iovec overflows a ssize_t value.
> >     EINVAL vlen is too large.
> >     ENOMEM Could not allocate memory for internal copies of the iovec
> >            structures.
> >     EPERM The caller does not have permission to access the address space of
> >           the process pidfd.
> >     ESRCH The target process does not exist (i.e., it has terminated and been
> >           waited on).
> >     EBADF pidfd is not a valid PID file descriptor.
> >
> > VERSIONS
> >     This system call first appeared in Linux 5.10, Support for this system
> >     call is optional, depending on the setting of the CONFIG_ADVISE_SYSCALLS
> >     configuration option.
> >
> > SEE ALSO
> >     madvise(2), pidofd_open(2), process_vm_readv(2), process_vm_write(2)
> >
> >  man2/process_madvise.2 | 222 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 222 insertions(+)
> >  create mode 100644 man2/process_madvise.2
> >
> > diff --git a/man2/process_madvise.2 b/man2/process_madvise.2
> > new file mode 100644
> > index 000000000..07553289f
> > --- /dev/null
> > +++ b/man2/process_madvise.2
> > @@ -0,0 +1,222 @@
> > +.\" Copyright (C) 2021 Suren Baghdasaryan <surenb@google.com>
> > +.\" and Copyright (C) 2021 Minchan Kim <minchan@kernel.org>
> > +.\"
> > +.\" %%%LICENSE_START(VERBATIM)
> > +.\" Permission is granted to make and distribute verbatim copies of this
> > +.\" manual provided the copyright notice and this permission notice are
> > +.\" preserved on all copies.
> > +.\"
> > +.\" Permission is granted to copy and distribute modified versions of this
> > +.\" manual under the conditions for verbatim copying, provided that the
> > +.\" entire resulting derived work is distributed under the terms of a
> > +.\" permission notice identical to this one.
> > +.\"
> > +.\" Since the Linux kernel and libraries are constantly changing, this
> > +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> > +.\" responsibility for errors or omissions, or for damages resulting from
> > +.\" the use of the information contained herein.  The author(s) may not
> > +.\" have taken the same level of care in the production of this manual,
> > +.\" which is licensed free of charge, as they might when working
> > +.\" professionally.
> > +.\"
> > +.\" Formatted or processed versions of this manual, if unaccompanied by
> > +.\" the source, must acknowledge the copyright and authors of this work.
> > +.\" %%%LICENSE_END
> > +.\"
> > +.\" Commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
> > +.\"
> > +.TH PROCESS_MADVISE 2 2021-01-12 "Linux" "Linux Programmer's Manual"
> > +.SH NAME
> > +process_madvise \- give advice about use of memory to a process
> > +.SH SYNOPSIS
> > +.nf
> > +.B #include <sys/uio.h>
> > +.PP
> > +.BI "ssize_t process_madvise(int " pidfd ,
> > +.BI "                       const struct iovec *" iovec ,
> > +.BI "                       unsigned long " vlen ,
> > +.BI "                       int " advice ,
> > +.BI "                       unsigned int " flags ");"
> > +.fi
> > +.SH DESCRIPTION
> > +The
> > +.BR process_madvise()
> > +system call is used to give advice or directions to the kernel about the
> > +address ranges of other process as well as of the calling process.
> > +It provides the advice to address ranges of process described by
> > +.I iovec
> > +and
> > +.IR vlen .
> > +The goal of such advice is to improve system or application performance.
> > +.PP
> > +The
> > +.I pidfd
> > +argument is a PID file descriptor (see
> > +.BR pidofd_open (2))
> > +that specifies the process to which the advice is to be applied.
> > +.PP
> > +The pointer
> > +.I iovec
> > +points to an array of
> > +.I iovec
> > +structures, defined in
> > +.IR <sys/uio.h>
> > +as:
> > +.PP
> > +.in +4n
> > +.EX
> > +struct iovec {
> > +    void  *iov_base;    /* Starting address */
> > +    size_t iov_len;     /* Number of bytes to transfer */
> > +};
> > +.EE
> > +.in
> > +.PP
> > +The
> > +.I iovec
> > +structure describes address ranges beginning at
> > +.I iov_base
> > +address and with the size of
> > +.I iov_len
> > +bytes.
> > +.PP
> > +The
> > +.I vlen
> > +represents the number of elements in the
> > +.I iovec
> > +structure.
> > +.PP
> > +The
> > +.I advice
> > +argument is one of the values listed below.
> > +.\"
> > +.\" ======================================================================
> > +.\"
> > +.SS Linux-specific advice values
> > +The following Linux-specific
> > +.I advice
> > +values have no counterparts in the POSIX-specified
> > +.BR posix_madvise (3),
> > +and may or may not have counterparts in the
> > +.BR madvise (2)
> > +interface available on other implementations.
> > +.TP
> > +.BR MADV_COLD " (since Linux 5.4.1)"
> > +.\" commit 9c276cc65a58faf98be8e56962745ec99ab87636
> > +Deactive a given range of pages which will make them a more probable
> > +reclaim target should there be a memory pressure.
> > +This is a non-destructive operation.
> > +The advice might be ignored for some pages in the range when it is not
> > +applicable.
> > +.TP
> > +.BR MADV_PAGEOUT " (since Linux 5.4.1)"
> > +.\" commit 1a4e58cce84ee88129d5d49c064bd2852b481357
> > +Reclaim a given range of pages.
> > +This is done to free up memory occupied by these pages.
> > +If a page is anonymous it will be swapped out.
> > +If a page is file-backed and dirty it will be written back to the backing
> > +storage.
> > +The advice might be ignored for some pages in the range when it is not
> > +applicable.
> > +.PP
> > +The
> > +.I flags
> > +argument is reserved for future use; currently, this argument must be
> > +specified as 0.
> > +.PP
> > +The value specified in the
> > +.I vlen
> > +argument must be less than or equal to
> > +.BR IOV_MAX
> > +(defined in
> > +.I <limits.h>
> > +or accessible via the call
> > +.IR sysconf(_SC_IOV_MAX) ).
> > +.PP
> > +The
> > +.I vlen
> > +and
> > +.I iovec
> > +arguments are checked before applying any hints.
> > +If the
> > +.I vlen
> > +is too big, or
> > +.I iovec
> > +is invalid, an error will be returned immediately.
> > +.PP
> > +The hint might be applied to a part of
> > +.I iovec
> > +if one of its elements points to an invalid memory region in the
> > +remote process.
> > +No further elements will be processed beyond that point.
> > +.PP
> > +Permission to provide a hint to another process is governed by a
> > +ptrace access mode
> > +.B PTRACE_MODE_READ_REALCREDS
> > +check (see
> > +.BR ptrace (2));
> > +in addition, the caller must have the
> > +.B CAP_SYS_ADMIN
> > +capability due to performance implications of applying the hint.
> > +.SH RETURN VALUE
> > +On success, process_madvise() returns the number of bytes advised.
> > +This return value may be less than the total number of requested bytes,
> > +if an error occurred after some iovec elements were already processed.
> > +The caller should check the return value to determine whether a partial
> > +advice occurred.
> > +.PP
> > +On error, \-1 is returned and
> > +.I errno
> > +is set to indicate the error.
> > +.SH ERRORS
> > +.TP
> > +.B EFAULT
> > +The memory described by
> > +.I iovec
> > +is outside the accessible address space of the process referred to by
> > +.IR pidfd .
> > +.TP
> > +.B EINVAL
> > +.I flags
> > +is not 0.
> > +.TP
> > +.B EINVAL
> > +The sum of the
> > +.I iov_len
> > +values of
> > +.I iovec
> > +overflows a
> > +.I ssize_t
> > +value.
> > +.TP
> > +.B EINVAL
> > +.I vlen
> > +is too large.
> > +.TP
> > +.B ENOMEM
> > +Could not allocate memory for internal copies of the
> > +.I iovec
> > +structures.
> > +.TP
> > +.B EPERM
> > +The caller does not have permission to access the address space of the process
> > +.IR pidfd .
> > +.TP
> > +.B ESRCH
> > +The target process does not exist (i.e., it has terminated and been waited on).
> > +.TP
> > +.B EBADF
> > +.I pidfd
> > +is not a valid PID file descriptor.
> > +.SH VERSIONS
> > +This system call first appeared in Linux 5.10,
> > +.\" commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
> > +Support for this system call is optional,
> > +depending on the setting of the
> > +.B CONFIG_ADVISE_SYSCALLS
> > +configuration option.
> > +.SH SEE ALSO
> > +.BR madvise (2),
> > +.BR pidofd_open(2),
> > +.BR process_vm_readv (2),
> > +.BR process_vm_write (2)
> > --
> > 2.30.0.365.g02bc693789-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
