Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49652BBABE
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Nov 2020 01:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgKUAOR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Nov 2020 19:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgKUAOR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Nov 2020 19:14:17 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A94C061A47
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 16:14:17 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so11840688ljc.9
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 16:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOhlCXLQ7me4aX62QOG9RwxgBAhj7Ibflx4qGQLcgl4=;
        b=ZXn6sV+kmyx7QPspcL9OH8Ac7HBSusOAhV7jGyMTLB/Ng2bK8UvEtybGL/9quDiS5B
         kazkzkKO7lr3zNI3Yu+yMrqkQjVBxUJzcFOWfHwMnTARFBBzXJn8b08522F4e0VARaE1
         yiMyfJlmkJMEE5xjV0mq1dX7Vp48u0EpkChkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOhlCXLQ7me4aX62QOG9RwxgBAhj7Ibflx4qGQLcgl4=;
        b=OUi6SFVizqPz8C94IqYAlav3UoWjVCeTIXXL2dSZXhavpjKKDWSHGI2eLh+msz6IwJ
         eRrG+U4086ncq1bqiL5+11yf9bdCs4Tj9SNquebjelCv7ZPtR/s++Cdx6ukbGtsCpJL5
         cOeYr/BVkSETwKjrYSjhebPzIhOL+ZrTdz4Z7A2ZdcOT638RCtF0Toyp85lRXoHkCeQu
         NNkca3t9cJwZ1GuNf/LY24xvypD8m347FJNyQJvO8Sficv2wUcncQqcQI0b8OK3wBhSw
         QC0cpjJy7wNAbTPwleEQUsNGjhqm2cloNpz/QcDH8J4dRy07osNLF334o6Ez1yPqOHMN
         n5nw==
X-Gm-Message-State: AOAM532KG/d01oO/5zJngmMEyYiyBOSVtT1dvTPuC0NUPMVD8uyBzYa0
        QjKGCqlRWJf6od/Zz3i9V17co+yCrV/JY0O5D24vBA==
X-Google-Smtp-Source: ABdhPJyI5y9/w8jHkxQAIdO6MKmQNNfY/wh+g99sPjgo0T0PGpb9YCvSxqIeWiqNOT7ZTYQ+tHnXuk7VJNy+u/hJtz4=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr9465290ljj.110.1605917655576;
 Fri, 20 Nov 2020 16:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org> <a9336dd5-df17-85d9-7c63-d8ab4b74b459@fb.com>
In-Reply-To: <a9336dd5-df17-85d9-7c63-d8ab4b74b459@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 21 Nov 2020 01:14:04 +0100
Message-ID: <CACYkzJ6bZBybX5tg2DvyJUkBPQ6_qP5FVKvMxdCe+CbA-OmPag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[...]

> > + * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
> > + *   Description
> > + *           Returns the stored IMA hash of the *inode* (if it's avaialable).
> > + *           If the hash is larger than *size*, then only *size*
> > + *           bytes will be copied to *dst*
> > + *   Return > + *            The **hash_algo** of is returned on success,
>
> of => if?

Just changed it to:

"The **hash_algo** is returned on success"

>
> > + *           **-EOPNOTSUP** if IMA is disabled and **-EINVAL** if
>
> and => or

Done. (and the same for tools/)

>

[...]

> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > +     .arg1_btf_id    = &bpf_ima_inode_hash_btf_ids[0],
> > +     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>
> I know ARG_CONST_SIZE_OR_ZERO provides some flexibility and may
> make verifier easier to verify programs. But beyond that did
> you see any real use case user will pass a zero size buf to
> get hash value?
>

I agree, in this case it makes more sense to ARG_CONST_SIZE.

> > +     .allowed        = bpf_ima_inode_hash_allowed,
> > +};

[...]
