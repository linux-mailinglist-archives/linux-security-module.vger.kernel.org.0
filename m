Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D438CEE4
	for <lists+linux-security-module@lfdr.de>; Fri, 21 May 2021 22:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhEUUVN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 May 2021 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhEUUVC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 May 2021 16:21:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E37C061342
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 13:19:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so32215483ejy.7
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thIe01+lHwzzxJedNGYnXkOMlihftpqGjXXbGI6UEFA=;
        b=W+zX4pg+qPV5VVsGwBht13DCLZB6q2mUKw3vLfil5mUEswjFv1dWGsywFmS7Uhiwaf
         OY8nWzuFL3COW2K+KDmJo+wmSfc7iD4GUN9bLWSMnJW5xM6SlVuCtVwUvwlKmlz5T0ty
         YksRQKsjYR1UMz/AlMlZ/sz0jauzIecYTsL1pC0us/Ya4PNrNfgoGU8mx/Un9c873cIr
         AeM0+0cQ2RDqrcouA+tHjxWocqUH62s3o0ySgAVLMu3OIS4NG1xsIfFUUhaHAkjIfuFP
         3AMrK51OGTsWYM2SzU0A0u1IdUtNQRpeoC++i1qe+n77FVvd36So0CZHQHQn49Ck2gQ1
         hUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thIe01+lHwzzxJedNGYnXkOMlihftpqGjXXbGI6UEFA=;
        b=A1XBfRPDGVsc4rewZ01it8FB1ytiuQNlhtPbmjd/2BrrXeG6RchjsbVJEafZQccWHa
         ePSEUHFgH8YI/a91oQaE0u9OTNxgSvlIQ6e6z8Og7yyyfR+/qAT8r14XcauVKmzCpTON
         E6XyDVv6W8rexUypKyioHD/PsIP+Hzaa0pN/lztvSbb0VgVr89+CV21HZV4x/l74uNW4
         aCIsc8+XqfPrhQczeXVOpORRSCn4rcp0+eGnzWxjmPsIAhAtKOE8kr3q9GkgNh3GQIgz
         SFs/VKcsxAxGLl1A0LJKzFMhkjvadSfFYIY/GHRt7H6yV8LdZS05FGbMhDyNm1ow38Az
         qyWA==
X-Gm-Message-State: AOAM531Vn3a926Bn3Gq+UzMC7g4vukfWJNQf+8k5zU7Ulb58uKHHstoF
        OsJwZyqT00Fir4YiLf3EOPFrMgbWhZm9pLAYmZhDHqnDlQ==
X-Google-Smtp-Source: ABdhPJw0PVE6pZTKuiQy3zYlqq+cxAQrxa/Xganf0agDkuOLzcXPOC4Z4cnZeLkkxqOOBbAnCmgf66QN4Q0jU9XPK1g=
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr11897181ejx.431.1621628368643;
 Fri, 21 May 2021 13:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-16-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-16-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:19:17 -0400
Message-ID: <CAHC9VhRuUsRC4X6_zpfygUF+yWvevqbk-NYtbJbhocjiX0F6ig@mail.gmail.com>
Subject: Re: [PATCH v26 15/25] LSM: Ensure the correct LSM context releaser
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 4:24 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add a new lsmcontext data structure to hold all the information
> about a "security context", including the string, its size and
> which LSM allocated the string. The allocation information is
> necessary because LSMs have different policies regarding the
> lifecycle of these strings. SELinux allocates and destroys
> them on each use, whereas Smack provides a pointer to an entry
> in a list that never goes away.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-audit@redhat.com
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: linux-nfs@vger.kernel.org
> ---
>  drivers/android/binder.c                | 10 ++++---
>  fs/ceph/xattr.c                         |  6 ++++-
>  fs/nfs/nfs4proc.c                       |  8 ++++--
>  fs/nfsd/nfs4xdr.c                       |  7 +++--
>  include/linux/security.h                | 35 +++++++++++++++++++++++--
>  include/net/scm.h                       |  5 +++-
>  kernel/audit.c                          | 14 +++++++---
>  kernel/auditsc.c                        | 12 ++++++---
>  net/ipv4/ip_sockglue.c                  |  4 ++-
>  net/netfilter/nf_conntrack_netlink.c    |  4 ++-
>  net/netfilter/nf_conntrack_standalone.c |  4 ++-
>  net/netfilter/nfnetlink_queue.c         | 13 ++++++---
>  net/netlabel/netlabel_unlabeled.c       | 19 +++++++++++---
>  net/netlabel/netlabel_user.c            |  4 ++-
>  security/security.c                     | 11 ++++----
>  15 files changed, 121 insertions(+), 35 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
