Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5531CF75
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Feb 2021 18:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBPRpj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Feb 2021 12:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhBPRp2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Feb 2021 12:45:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D88C06178A
        for <linux-security-module@vger.kernel.org>; Tue, 16 Feb 2021 09:44:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b3so14200082wrj.5
        for <linux-security-module@vger.kernel.org>; Tue, 16 Feb 2021 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SG1PJqmUONPMltLHj/NtbdnqP3QjXhIMpbTG2ubKayU=;
        b=gJMg/HYjzxEkTtYwbl77f/5BHHhcOZMC+zF37X8B/qKaJjS1EDDbB5E9DQoW43x9Ek
         76E252nanT1F78TvtOW336XdQ5XI2pgkFLuk8lV+8PGCPWvURVZ3vJclriyK4uwRFMuu
         xGfUjWRAT6bcrntxVeoXoOGx7MwnEXdAtpUU8ZO3L7o9N0UG9lCq4KjQ3HjAgCWQTSqh
         YN5i1/QKN0WwriXEcU452g8V07c3Z2gHHT9F0sAU9nYWOKC2FS6rNeX02IvXgCzbVWrr
         gpKWN5c2DYV9aBbrvqsHZss6UZMTz1bFiM1aDIiH1mOpVXo0SQte+allBrV+Wk/LWmiP
         42VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SG1PJqmUONPMltLHj/NtbdnqP3QjXhIMpbTG2ubKayU=;
        b=ZCeQ5T3vW4kJ7P/GqwhFfsMlHTmTW254IehD76altzuzmX6ARoInLqjLhf78oFlwb2
         WxJBv19S/3Zz9OJTb28SdP3zmd6bGIQC2NiXtcFcRvt/7jjH7jCPNN1jidEZiAalW1qo
         8RkeotNsgOSmksU9Mbj/A2wF+r59234I1LrnhcE8eR1w9PM6F2f8uShKeG1WcV2atzCf
         ILyaCnHFp03JVB9xjmx2ZqVwhYMrvoviVhSxsmhKdjfEz6NRMzPyc85akTav5bw+CoNq
         ukCE7aGVAn9a23hoyH1sVfJ/tG54MIRbFRSvYM5RcUJRIBoPYJ6D0QcHyOfnSr1GKiZU
         mZWQ==
X-Gm-Message-State: AOAM531h2nftO2OZWYMUdQLAnYXd+NmxZ/6KVDL0VZeNbRBkH6HRJqgA
        E0OX4M07AGWwA16Ukg3FR51TVepQQuyHtd6lroQO5A==
X-Google-Smtp-Source: ABdhPJzWe51dgFo8YdFDbYkdUYcmO1d7+1mZzYOUd19gMk/Ayscx0kbxSccgEjton406EyAShOmFNYX5kVOyIBhDYao=
X-Received: by 2002:a5d:610a:: with SMTP id v10mr19205290wrt.334.1613497465050;
 Tue, 16 Feb 2021 09:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20210202053046.1653012-1-surenb@google.com> <079db245-a08c-0dbd-01d4-8065f533652e@gmail.com>
 <CAJuCfpGotx_04Stn5Nw6Au+TVG9LuAJ=CB_s7uxjMLOLerw-GA@mail.gmail.com> <2d303517-cdcd-9ec8-e57d-3d065edb573c@gmail.com>
In-Reply-To: <2d303517-cdcd-9ec8-e57d-3d065edb573c@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 16 Feb 2021 09:44:13 -0800
Message-ID: <CAJuCfpFC0B=jXFEuPYYBZAjgx1B6S8vG-i7_0iBc_RHeWynyzw@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Michael,

On Sat, Feb 13, 2021 at 2:04 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Suren,
>
> On 2/2/21 11:12 PM, Suren Baghdasaryan wrote:
> > Hi Michael,
> >
> > On Tue, Feb 2, 2021 at 2:45 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >>
> >> Hello Suren (and Minchan and Michal)
> >>
> >> Thank you for the revisions!
> >>
> >> I've applied this patch, and done a few light edits.
> >
> > Thanks!
> >
> >>
> >> However, I have a questions about undocumented pieces in *madvise(2)*,
> >> as well as one other question. See below.
> >>
> >> On 2/2/21 6:30 AM, Suren Baghdasaryan wrote:
> >>> Initial version of process_madvise(2) manual page. Initial text was
> >>> extracted from [1], amended after fix [2] and more details added using
> >>> man pages of madvise(2) and process_vm_read(2) as examples. It also
> >>> includes the changes to required permission proposed in [3].
> >>>
> >>> [1] https://lore.kernel.org/patchwork/patch/1297933/
> >>> [2] https://lkml.org/lkml/2020/12/8/1282
> >>> [3] https://patchwork.kernel.org/project/selinux/patch/20210111170622.2613577-1-surenb@google.com/#23888311
> >>>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Reviewed-by: Michal Hocko <mhocko@suse.com>
> >>> ---
> >>> changes in v2:
> >>> - Changed description of MADV_COLD per Michal Hocko's suggestion
> >>> - Applied fixes suggested by Michael Kerrisk
> >>> changes in v3:
> >>> - Added Michal's Reviewed-by
> >>> - Applied additional fixes suggested by Michael Kerrisk
> >>>
> >>> NAME
> >>>     process_madvise - give advice about use of memory to a process
> >>>
> >>> SYNOPSIS
> >>>     #include <sys/uio.h>
> >>>
> >>>     ssize_t process_madvise(int pidfd,
> >>>                            const struct iovec *iovec,
> >>>                            unsigned long vlen,
> >>>                            int advice,
> >>>                            unsigned int flags);
> >>>
> >>> DESCRIPTION
> >>>     The process_madvise() system call is used to give advice or directions
> >>>     to the kernel about the address ranges of another process or the calling
> >>>     process. It provides the advice to the address ranges described by iovec
> >>>     and vlen. The goal of such advice is to improve system or application
> >>>     performance.
> >>>
> >>>     The pidfd argument is a PID file descriptor (see pidfd_open(2)) that
> >>>     specifies the process to which the advice is to be applied.
> >>>
> >>>     The pointer iovec points to an array of iovec structures, defined in
> >>>     <sys/uio.h> as:
> >>>
> >>>     struct iovec {
> >>>         void  *iov_base;    /* Starting address */
> >>>         size_t iov_len;     /* Number of bytes to transfer */
> >>>     };
> >>>
> >>>     The iovec structure describes address ranges beginning at iov_base address
> >>>     and with the size of iov_len bytes.
> >>>
> >>>     The vlen represents the number of elements in the iovec structure.
> >>>
> >>>     The advice argument is one of the values listed below.
> >>>
> >>>   Linux-specific advice values
> >>>     The following Linux-specific advice values have no counterparts in the
> >>>     POSIX-specified posix_madvise(3), and may or may not have counterparts
> >>>     in the madvise(2) interface available on other implementations.
> >>>
> >>>     MADV_COLD (since Linux 5.4.1)
> >>
> >> I just noticed these version numbers now, and thought: they can't be
> >> right (because the system call appeared only in v5.11). So I removed
> >> them. But, of course in another sense the version numbers are (nearly)
> >> right, since these advice values were added for madvise(2) in Linux 5.4.
> >> However, they are not documented in the madvise(2) manual page. Is it
> >> correct to assume that MADV_COLD and MADV_PAGEOUT have exactly the same
> >> meaning in madvise(2) (but just for the calling process, of course)?
> >
> > Correct. They should be added in the madvise(2) man page as well IMHO.
>
> So, I decided to move the description of MADV_COLD and MADV_PAGEOUT
> to madvise(2) and refer to that page from the process_madvise(2)
> page. This avoids repeating the same information in two places.

Sounds good.

>
> >>>         Deactive a given range of pages which will make them a more probable
> >>
> >> I changed: s/Deactive/Deactivate/
> >
> > thanks!
> >
> >>
> >>>         reclaim target should there be a memory pressure. This is a
> >>>         nondestructive operation. The advice might be ignored for some pages
> >>>         in the range when it is not applicable.
> >>>
> >>>     MADV_PAGEOUT (since Linux 5.4.1)
> >>>         Reclaim a given range of pages. This is done to free up memory occupied
> >>>         by these pages. If a page is anonymous it will be swapped out. If a
> >>>         page is file-backed and dirty it will be written back to the backing
> >>>         storage. The advice might be ignored for some pages in the range when
> >>>         it is not applicable.
> >>
> >> [...]
> >>
> >>>     The hint might be applied to a part of iovec if one of its elements points
> >>>     to an invalid memory region in the remote process. No further elements will
> >>>     be processed beyond that point.
> >>
> >> Is the above scenario the one that leads to the partial advice case described in
> >> RETURN VALUE? If yes, perhaps I should add some words to make that clearer.
> >
> > Correct. This describes the case when partial advice happens.
>
> Thanks. I added a few words to clarify this.

Any link where I can see the final version?

>
>
> >> You can see the light edits that I made in
> >> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=e3ce016472a1b3ec5dffdeb23c98b9fef618a97b
> >> and following that I restructured DESCRIPTION a little in
> >> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3aac0708a9acee5283e091461de6a8410bc921a6
> >
> > The edits LGTM.
>
> Thanks for checking them.
>
> Cheers,
>
> Michael
>

Thanks,
Suren.

>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
