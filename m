Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34610137414
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Jan 2020 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgAJQuh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 Jan 2020 11:50:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35952 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgAJQue (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jan 2020 11:50:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so2828289ljg.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2020 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vSiXmE4hm+vY407xZeDV00oZSz7P7Tb6Wxmt50cGzo=;
        b=qHL+7rDPAtspkZeTYhcfP5LoXq67SOKKWsQSUhE/9KZkhRscH/4+cy9tHxCw98hexJ
         KUDzz5DRsUDx6nHt72wgmEmyqxMhcBcJoQKzoV/LtB57t0eVZdBK8FxX7ZpGa+B95FAU
         IN3AiIFwMlm/s7QAh03vjgtcgPMb/tcOlA66kCH9ESNrqIhKPzyG6uUrPaaDOTVtkn5J
         YiLoKcBituDgLH7WqtJGBX5GhfjaYerfqaRX21UTu1bnJS83vLFVJcYqYZb28ZVdcp0d
         KH/d7sMxvnJzUbITb0kmRGHuj80q7Qm+8DF6zwo83ev2bICMJ9k8w3ko7UKQa3jjeEOV
         ssNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vSiXmE4hm+vY407xZeDV00oZSz7P7Tb6Wxmt50cGzo=;
        b=fyzrQS6A8LjlZk4+9sG8XbL8tvM0Kwjzrjg8AFcGgcXlVvqUTQIYChsg74ype0Scuw
         1ZysvSDLJVr6+njb4yU0Fl25/cdx1rhf3O8RX8zBYSZI8KbVdkU+GJ9ptPd0hCa00PQ+
         SraSGKelHKE96Bl+vqc07919/EZjXNCJOuenAmzhMgS5PYikW9y0xa6cc6ecpX79sPG5
         2149OT2NpB5q2k6LA1MB58q/1fBwER6y+5u47GvKBuhOG15zdYdxB63QSOsmtwnxOXeP
         dni4txfag5xpFLk1pPVsF0wGvuG0Z6IZgYURmS8gX1/EJl8QlChLiJ4rkI5BEwnBDqME
         rKrw==
X-Gm-Message-State: APjAAAV9JO8d+gsZUEs4CSFj1RxPVcxUYrmUNp3Up3aVotPfxqjiHR8g
        C/mfFVHBfoBft1xR0tBXQWAjePOqlnVVxgqt5DZ+
X-Google-Smtp-Source: APXvYqyAow6uZx4yK/nJw6QxaEppyphJRbmhCS4VKJRHdMK34mml0Z79SHsmLh9ts8uHbUdaVBz7t4sgms9axT1NQCw=
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr3321630lja.81.1578675032313;
 Fri, 10 Jan 2020 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20200110095856.76612-1-yehs2007@zoho.com> <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
In-Reply-To: <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 11:50:20 -0500
Message-ID: <CAHC9VhT-8R4iT-V-A+6NvZgG=bh4Knieif2fuKwybnDuXvC6ug@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Huaisheng Ye <yehs2007@zoho.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, tyu1@lenovo.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 10, 2020 at 10:13 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/10/20 4:58 AM, Huaisheng Ye wrote:
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
> > do nothing else. And also msg_msg_alloc_security is just used by the
> > former.
> >
> > Remove the redundant function to simplify the code.
>
> This seems to also be true of other _alloc_security functions, probably
> due to historical reasons.  Further, at least some of these functions no
> longer perform any allocation; they are just initialization functions
> now that allocation has been taken to the LSM framework, so possibly
> could be renamed and made to return void at some point.

I've noticed the same thing on a few occasions, I've just never
bothered to put the fixes into a patch.  We might as well do that now,
at least for the redundant code bits; I'll leave the return code issue
for another time as that would cross LSM boundaries and that really
isn't appropriate in the -rc5 timeframe IMHO.

I'll put something together once I finish up the patch/review backlog
from the past few days.  Looking quickly with a regex, it would appear
that inode_alloc_security(), file_alloc_security(), and
superblock_alloc_security() are all candidates.  While not an
allocator, we can probably get rid of inode_doinit() as well.

-- 
paul moore
www.paul-moore.com
