Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2931138CEC3
	for <lists+linux-security-module@lfdr.de>; Fri, 21 May 2021 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEUUT6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 May 2021 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEUUTx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 May 2021 16:19:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD4C06138A
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 13:18:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb17so14187943ejc.8
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nlgh0TQ54JfISjNkuE+6vXCbSzvDn6Db13HObefQGo=;
        b=VXlAiKygqHU4e+y2w1wYEVp8ltO11dQD7mS0i7xMktZsZBOh7IjbrnQlFEHrZgLBPt
         LPPPjKQMK/I6M3Ex7YXV46hB5k15+DVlVHJufjK14ZdmI1A14k2vnsERbsWl1JamCaFB
         BV4HyiVHXHnpCjNocTuao5uTcLbVmP7CWfFvYvYHgys3TZo6Iz/6XstxrABVGgjool74
         2dWU/ilFlcQyXkAXGk9Ta9rB916XDVMw4jU+SiXe/EREXBkEd1W0kq6t4u62HHAJtIbO
         CKMdGPRrSXZNDhkqDJ2Yegsc5YAn3DfPywaDJPGx2psFOqbvrlhyZjzKr66M6y7OF238
         ZVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nlgh0TQ54JfISjNkuE+6vXCbSzvDn6Db13HObefQGo=;
        b=AL+v6aGPPvR/zYShER7x8LXPl4Hgnqimn4/5wH8favwqOgUjVe1GIP8zQQmtxsQkX3
         4spxjQN1QOLMNE+LTGz0f4VrUWAKDj8EEdnTVQQxU6eonM66fDpVkXYh3v8mpEpcb8AU
         FcrJFQrVMGRDSSXfoSSoREgL8R80fbpGIIBPxYhNl4AMlpuY/kDzvU4rXrPTlz/Fm0zQ
         GDJaBkBw0ehvs6WiNuE0Sbc3nHRBXCI3R7ihx8CJhZKLLWve4or980jnE2P1AMukdh5q
         4KD3G4Q90fR+h/DVSskl/7REkJw7Zjz/n+ZDC9jt95vOfo+kfR6jFSZ70r2vCJmHRj3+
         frdw==
X-Gm-Message-State: AOAM531d9BZtOZDzNnhUfqD8cx1dpzmmDYHguDeBkNyUjezkF/63rN3q
        AIw9pV8zHZqa/3zU0ihY8mrUpAXCDus1K0oZVViA
X-Google-Smtp-Source: ABdhPJyuyS2L6lmTp+jUY7WZYbtb0aAruf3WAqiCiM7sDpi5Jow+cezV/k6G8N/8ymdaUuX65MmhhvE9Q5v4Z/UQj8A=
X-Received: by 2002:a17:906:9e21:: with SMTP id fp33mr11995874ejc.488.1621628307963;
 Fri, 21 May 2021 13:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-9-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-9-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:18:16 -0400
Message-ID: <CAHC9VhSZDX3KVzGJQuksDo_mfsg7Qb7Vs+goqbzF9qsF7hRUcg@mail.gmail.com>
Subject: Re: [PATCH v26 08/25] LSM: Use lsmblob in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 4:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may be called upon
> to translate a secid to a string, as can occur in the
> audit code.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-audit@redhat.com
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> To: Paul Moore <paul@paul-moore.com>
> ---
>  drivers/android/binder.c                | 12 +++++++++-
>  include/linux/security.h                |  5 +++--
>  include/net/scm.h                       |  7 +++++-
>  kernel/audit.c                          | 20 +++++++++++++++--
>  kernel/auditsc.c                        | 28 +++++++++++++++++++----
>  net/ipv4/ip_sockglue.c                  |  4 +++-
>  net/netfilter/nf_conntrack_netlink.c    | 14 ++++++++++--
>  net/netfilter/nf_conntrack_standalone.c |  4 +++-
>  net/netfilter/nfnetlink_queue.c         | 11 +++++++--
>  net/netlabel/netlabel_unlabeled.c       | 30 +++++++++++++++++++++----
>  net/netlabel/netlabel_user.c            |  6 ++---
>  security/security.c                     | 11 +++++----
>  12 files changed, 123 insertions(+), 29 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
