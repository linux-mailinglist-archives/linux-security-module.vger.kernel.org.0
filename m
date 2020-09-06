Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94D225EC2E
	for <lists+linux-security-module@lfdr.de>; Sun,  6 Sep 2020 04:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIFCqO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 5 Sep 2020 22:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgIFCqM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Sep 2020 22:46:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C139C061573
        for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2020 19:46:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so9506857edk.0
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2020 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZqDWW5vNAoJJAbX0kuyb7Ud5+qbw+9T/B7X+7yryh8=;
        b=DmhPGb7AyMoKvO+EZ6qSA6y0mbdaxr6Hf+3iisa/FrUxspdnpBXYMQLIrBlGXFwX/I
         msIH1xrcZozf6lMLykq8tZh1ognEbytLSE67zNmMiBFjNvGt923/zAuglw0hFw87dbRc
         A1nyUIALkitD3VJq/qWFJuvK+ZkX1gzGCVZ+BrlG+poI90JAyIDZaw4uM0Ck9giFZ+Gg
         F6AfmR4omPmNAUbd9YHfF7akFNYhRd5gAvcLH1JH7gjnFQE9VKaNDBHNXkVikQ+++umT
         2W6r1to8acOWY7IG4HMbK5dMFncajEXDc1z81RDr8E9youj5oQovA0CzpF8j+MGWg1Y0
         VZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZqDWW5vNAoJJAbX0kuyb7Ud5+qbw+9T/B7X+7yryh8=;
        b=RpZdLvc4DmvGeKoS+G/mbZGDHdvt3DPkMSD+nlznev/ZaQYiM1Bq9U/Lfp5zLUrru6
         kkk4aDbStJTFGwbDCqOxrzCOgvGy396s5vySskwbaCtG6+3ywQsBHHnrvQKVPHVG2QNf
         95Waj5QeG2L64DvE27gPhOGpwv5CKMSS3YN99qDBj23hW7AONDe7ajZ2yk7x9E2QkedF
         WdwL3uA80p2PRY42pGIlChv8tL2VQkai7i5GEwQoe6T+C08DmmaflRvV6s8PttLucKcP
         qdPx6u7A2c5TjiN/CTfmIckJfVV8aC9E5TPCxZupGi7M6mKsyZ+6XmKmgisobxl7DkAi
         edpw==
X-Gm-Message-State: AOAM530Wleh1QNP4Rsgp/4jPp+zCr9Hse73jmWhMFnM0OG4DsuZaeqS3
        LxeXC4zqMeKlmikhjR2VtC6jFDQUqOHscwmD84LZ
X-Google-Smtp-Source: ABdhPJwEnqc7V1NRJVUfKvCRxDcLWxHKwC04LW/AslJ8t3tHT+VIhkM1GtvHSi9RzbnnsIGUXVyYSmBJ5klezGQfiL8=
X-Received: by 2002:aa7:ce97:: with SMTP id y23mr16089395edv.128.1599360369151;
 Sat, 05 Sep 2020 19:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-15-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-15-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 22:45:57 -0400
Message-ID: <CAHC9VhQmEgNgsXmk8MeMsfkvZ82GuHBguoBvG5WR9mcoztBDOA@mail.gmail.com>
Subject: Re: [PATCH v20 14/23] LSM: Ensure the correct LSM context releaser
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 11:16 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
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
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
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

One small comment below, but otherwise ...

Acked-by: Paul Moore <paul@paul-moore.com>

> +/**
> + * lsmcontext_init - initialize an lsmcontext structure.
> + * @cp: Pointer to the context to initialize
> + * @context: Initial context, or NULL
> + * @size: Size of context, or 0
> + * @slot: Which LSM provided the context
> + *
> + * Fill in the lsmcontext from the provided information.
> + * This is a scaffolding function that will be removed when
> + * lsmcontext integration is complete.
> + */
> +static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
> +                                  u32 size, int slot)
> +{
> +       cp->slot = slot;
> +       cp->context = context;
> +       cp->len = size;
> +}

Here is another case where some of the intermediate code, and perhaps
some of the final code, can probably be simplified if
lsmcontext_init() returns the lsmcontext pointer.

-- 
paul moore
www.paul-moore.com
