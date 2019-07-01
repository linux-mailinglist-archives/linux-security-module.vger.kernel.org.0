Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F084552C6
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Jun 2019 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfFYPBp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 25 Jun 2019 11:01:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45976 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfFYPBl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jun 2019 11:01:41 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so174125ioc.12
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jun 2019 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yr5BGG5Soxpasmq18l/eZqmRu+7BCvMsxIS8QQvWds=;
        b=diW+vWQ1cK8J8mbuShje1qzBD5LFfkxUEduZIToixNkQRkqTqpie/l61eMQPXHYH8O
         83tsgOqMuHQTprd4S6JdERPZE+TlxqaeV+MxFjieF4rmW7BqkBkEBIRyr9y5Olsh0sTb
         kIbFYqnnzV8WHY/LxxBOrCMY++yq5mUHnh9ZG+/Ek62tmmnp2bHS2rtGjtrV8ABgPH6W
         TquBKMaN6GcosVz98HHhNV+0NvruRiFUsmKjmdE785L08+iNoeeI3/Wq7JKFOFmgVmrU
         D5UXmgUdyiU4hGGM09aMFeL0jxTwN8DElgDAw/0DXsTVEGpmjT9rHg7Q4p0qlVJDliFD
         Nr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yr5BGG5Soxpasmq18l/eZqmRu+7BCvMsxIS8QQvWds=;
        b=boI+SLtLTnMRBnj6wTE2woKAlOJCROZpOwz1LfNr7z+qat1SYXdecx2IGztJMnqanM
         4npODk0mc+XNvPZ0qGCnUIm4/uWqsEymPr/ZbfwUjxmRSd9EmgLjiaT+YisolVlNFnTf
         Iw5/IBGi8ATt2ZMeNJey4BLd+fgtn0SYF3Emd10DPLljIGzvQ0NOjlrAtkyga/2RzNWD
         busVkNUSdXLHIIGUrfVg3hP4Mil+a6kXE6lRsYo+vjhlsIccbeODvNSoV0HugvcZfqg5
         xHzv0lZwdQ3oydmMWX6X7FPU0uM3rN8smMMBJ011LQSRXF5dBwsiv1aTz8x4S+fFwIX2
         EcDw==
X-Gm-Message-State: APjAAAVJcCDNZqdS3oV/+E/U3KBT8luO8k7PZkg0wELIndliwMyab5X6
        huWGBYWQcQZ1ilZpmCKlhJDQNKwsYDdM9eOyIAkfsA==
X-Google-Smtp-Source: APXvYqzEVNC69Mi27uf6m7Bi3ZeIToOuD/jem/DgkFporAtOaz6bRyAKyT9CIE+AjyVnl2gTizP/1dBjhuxNC4RZ9+o=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr13470506ion.65.1561474900420;
 Tue, 25 Jun 2019 08:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190618094731.3677294-1-arnd@arndb.de> <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
 <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
 <CAK8P3a2d3H-pdiLX_8aA4LNLOVTSyPW_jvwZQkv0Ey3SJS87Bg@mail.gmail.com>
 <CAKv+Gu9p017iPva85dPMdnKW_MSOUcthqcy7KDhGEYCN7=C_SA@mail.gmail.com> <201906221324.C08C1EF@keescook>
In-Reply-To: <201906221324.C08C1EF@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Jun 2019 17:01:29 +0200
Message-ID: <CAKv+Gu90nGDYFwdi69centW+yyS16u1QDVNT7C7VcRaCkCaRyA@mail.gmail.com>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 22 Jun 2019 at 22:26, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 21, 2019 at 03:50:02PM +0200, Ard Biesheuvel wrote:
> > On Fri, 21 Jun 2019 at 15:44, Arnd Bergmann <arnd@arndb.de> wrote:
> > > One pattern I have seen here is temporary variables from macros or
> > > inline functions whose lifetime now extends over the entire function
> > > rather than just the basic block in which they are defined, see e.g.
> > > lpfc_debug_dump_qe() being inlined multiple times into
> > > lpfc_debug_dump_all_queues(). Each instance of the local
> > > "char line_buf[LPFC_LBUF_SZ];" seems to add on to the previous
> > > one now, where the behavior without the structleak plugin is that
> > > they don't.
>
> Ewww.
>
> > Right, that seems to be due to the fact that this code
> >
> > /* split the first bb where we can put the forced initializers */
> > gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> > bb = single_succ(ENTRY_BLOCK_PTR_FOR_FN(cfun));
> > if (!single_pred_p(bb)) {
> >     split_edge(single_succ_edge(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> >     gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> > }
> >
> > puts all the initializers at the beginning of the function rather than
> > inside the scope of the definition.
>
> Do you see a sane way to improve this? I hadn't noticed that this
> actually moved it up to the start of the function. :(
>

Not from the top of my head, and I won't be able to spend any time on
this in the near future, unfortunately.
