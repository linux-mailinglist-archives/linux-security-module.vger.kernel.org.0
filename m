Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590A63254F0
	for <lists+linux-security-module@lfdr.de>; Thu, 25 Feb 2021 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhBYRzS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 25 Feb 2021 12:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhBYRy2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Feb 2021 12:54:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921EC061786
        for <linux-security-module@vger.kernel.org>; Thu, 25 Feb 2021 09:53:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h10so8005132edl.6
        for <linux-security-module@vger.kernel.org>; Thu, 25 Feb 2021 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgNSI6OFSfnppaC+GMrdAWjNalo2gYA8gIH9UOQ8AyI=;
        b=EInhMibNQy7yoPTPdzoBOkEWw/tMNCXklzkCg9G6gGpqiKFEvNk1t3g3PlWN9ABngP
         95lwEZ2BIvfh1UgOe+RbVF8gfaj7tKOQVRp9lVvC/Duz7MAR5LoZLY63eZxkZizfiam/
         wnhMpzaHUWqfFGEAeuFG0tDiuB2HLTXENPGGhrWVQa8vNECb/88YYB9ckUs5b8N/PgGb
         m9lUbKUwMX1pGUZLoqvT9/VWmGIHcwwwnnCS930jFrJHeNBoiDwLVknudEBYZJnBt9T0
         FiV0AF8Mz6UkS8kmqtNooPwefwQ51D8dVFPTqgxrFuKsHO1A4VC4NZBWFvm2+RWNBGez
         WdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgNSI6OFSfnppaC+GMrdAWjNalo2gYA8gIH9UOQ8AyI=;
        b=K2AR6p80hqqq7DEWFLKQkJoWKvAswZqRqVlOAk///2NzNTIPWJASiskeFEFwvMMrWi
         STEdKORNvEoyUYd4if7EKKAFIDvt8vWmGV570JUrNvaeE0aUjM4O4uFn6iYoqEcfVSrh
         o+f5qxGu5jKmiMHr4DCYUvkWc/il3KN8TdCoNqM4oeugxO7fYxzh+aRS8E0skJ2fV92x
         8q+shvX29YF9H2fp7so94mnkIsXzVUvR6Zsa7d40amnQJhebBq15A/qpv+/LO5aYC+qK
         0Ch2jmPf3adP71QiD5IR/LeKlU7tmpxLoWnWG02FNNLQPKoAcP88RVz68Ew5SS/2k6T4
         /+5g==
X-Gm-Message-State: AOAM532Fbg3yZdWTWi/9bSeTrCXpPdjAklEAeEFGTA0O74LCS5iDhFGD
        qrUu7UeKx1s0FvYQM9osQ6IZOttLZhzQFCFOUrRx
X-Google-Smtp-Source: ABdhPJz/O6xMq/eAU3Tt16scLm3nsGPZAvfSl4Uf27U//Dy+Smsnb0KhHRqVnGVDWvdz90JjpiBiPNMoSidkS4U1Rss=
X-Received: by 2002:aa7:c410:: with SMTP id j16mr4097065edq.135.1614275626835;
 Thu, 25 Feb 2021 09:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 12:53:35 -0500
Message-ID: <CAHC9VhRKLBNNfUE0FMgGJBR5eBQ+Et=oK1rcErUU_i62AGhfsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 5:25 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a new hook that takes an existing super block and a new mount
> with new options and determines if new options confict with an
> existing mount or not.
>
> A filesystem can use this new hook to determine if it can share
> the an existing superblock with a new superblock for the new mount.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  6 ++++
>  include/linux/security.h      |  8 +++++
>  security/security.c           |  7 +++++
>  security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+)

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a19adef1f088..d76aaecfdf0f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -142,6 +142,12 @@
>   *     @orig the original mount data copied from userspace.
>   *     @copy copied data which will be passed to the security module.
>   *     Returns 0 if the copy was successful.
> + * @sb_mnt_opts_compat:
> + *     Determine if the existing mount options are compatible with the new
> + *     mount options being used.

Full disclosure: I'm a big fan of good documentation, regardless of if
it lives in comments or a separate dedicated resource.  Looking at the
comment above, and the SELinux implementation of this hook below, it
appears that the comment is a bit vague; specifically the use of
"compatible".  Based on the SELinux implementation, "compatible" would
seem to equal, do you envision that to be the case for every
LSM/security-model?  If the answer is yes, then let's say that (and
possibly rename the hook to "sb_mnt_opts_equal").  If the answer is
no, then I think we need to do a better job explaining what
compatibility really means; put yourself in the shoes of someone
writing a LSM, what would they need to know to write an implementation
for this hook?

> + *     @sb superblock being compared
> + *     @mnt_opts new mount options
> + *     Return 0 if options are compatible.

-- 
paul moore
www.paul-moore.com
