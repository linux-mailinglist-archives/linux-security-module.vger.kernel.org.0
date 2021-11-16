Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4DB45209C
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Nov 2021 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbhKPAzv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Nov 2021 19:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343560AbhKOTVU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Nov 2021 14:21:20 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD403C03D78E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Nov 2021 10:17:43 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id v3so36666862uam.10
        for <linux-security-module@vger.kernel.org>; Mon, 15 Nov 2021 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+a8ZktNn6ZKD5SR+F36fH6n6kb1h7BS7jd1Wp45NaFM=;
        b=gKjpO0lLV7NAzCVw+nwCxA8yC44R21WAWD2XjYYi0XvHIj7m390XTLd0lEN5Nn7rcB
         BuK4C1Cfgw1j9IVR5y4ccOOC9HnZhA9Q9ERm3Q22nj0xyYhHPPZ+IYpHX27qbjUCyDa9
         FjBo+0o5USkN9WjUnl/bLBY+ePanR03FsUeaamVOMTsyk1ZuvITwcd6QcOScign6Qmun
         u7WUTMpODzERw1+OGJLsaUtAupMXVPh3UXvanz5tAdren74UjX5wDmMwtt0tuKXcncWg
         TUyJQc40cjABQb16NUrbV/xR8FV0L6K9gaV5knCQzF0+juocFBSz2mXCLAEddrjvWuAo
         708w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a8ZktNn6ZKD5SR+F36fH6n6kb1h7BS7jd1Wp45NaFM=;
        b=yurLGhu/91PmpgoXOdHlI0Z9vxAhjotLclLEO1UCux7Iaa2wk+iA/KsmrXFnuRd7as
         0XYV6zmZjbLvc8R6TdRV4se/mTu4RMZdGQfZ5RemMLdQSdUWVFlw8Nonbxh6VlWuOk6V
         L1PtAJ6yb1pAamOxUuGdiLwQiT/Qdm0wItJSsmc8IGWSaNDTX2R3POsTT7XMtOHrU3R9
         OXzrQgYXIVq3fA6juYcm2m850dtrWcTt/CDjuuwJ4YE0svCEjdv037LYzttAc0vAmk3i
         XBnkIPu6b+Hm/lVNbCZLxXWKDALWOIDwl0Co6fsDjNvVEamgRi+oM5C8BLJUVGpK0zRJ
         6F0A==
X-Gm-Message-State: AOAM531v2vFj9eMNEVbrnc6jqAlqaUcMnzv9WfOw3MJc60pk+RE7krtS
        CCZyUotUGVJnd9q7oS79UkHfuImn6Wssy8c34NdlSA==
X-Google-Smtp-Source: ABdhPJya8J9a4P+RjZgEeXSNntVJy86MJNmzIPw9P4CUF+9L+z4wnWDoOasaaQi9RrdEFaJXT3F+c+2vxQUEakzHjTg=
X-Received: by 2002:a67:df96:: with SMTP id x22mr46045260vsk.9.1637000262835;
 Mon, 15 Nov 2021 10:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20211115173850.3598768-1-adelva@google.com> <74179f08-3529-7502-db33-2ea18cab3f58@kernel.dk>
In-Reply-To: <74179f08-3529-7502-db33-2ea18cab3f58@kernel.dk>
From:   Alistair Delva <adelva@google.com>
Date:   Mon, 15 Nov 2021 10:17:30 -0800
Message-ID: <CANDihLE5oO2=MDiPtGmUzZgaPuzT2_X7da-vKe+ybBJkXgnsAQ@mail.gmail.com>
Subject: Re: [PATCH] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 15, 2021 at 10:04 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/15/21 10:38 AM, Alistair Delva wrote:
> > Booting to Android userspace on 5.14 or newer triggers the following
> > SELinux denial:
> >
> > avc: denied { sys_nice } for comm="init" capability=23
> >      scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
> >      permissive=0
> >
> > Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
> > better compatibility with older SEPolicy, check ADMIN before NICE.
>
> Seems a bit wonky to me, but the end result is the same.

No argument from me..

> In any case,
> this warrants a comment above it detailing why the ordering is
> seemingly important.

Sent v2.

> --
> Jens Axboe
>
