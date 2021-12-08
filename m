Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3B46DB66
	for <lists+linux-security-module@lfdr.de>; Wed,  8 Dec 2021 19:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhLHSpR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 8 Dec 2021 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhLHSpQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Dec 2021 13:45:16 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565E7C061A72
        for <linux-security-module@vger.kernel.org>; Wed,  8 Dec 2021 10:41:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x6so11544433edr.5
        for <linux-security-module@vger.kernel.org>; Wed, 08 Dec 2021 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skLeJaSpw0/vsaEY+mYw5f7GsY+8sigTDomXYlalyaQ=;
        b=DSkFahY5Mhcqkm7rNA6F7ey2SgnwCSizMEsMeQOOFZyoz0th8u0eISTZuR6GwnR7iE
         ajgFF5IMY6zf6XTGXSQJcB7WyYcBmvFwWuMPtjmWHjuGDtvkI1SX5cIOJKlHm166Ka/2
         mNurd9yCZ4ewoRxcgjGVg4BiOyEmskpd4mnsGs21hFqF+Am2O1DBExT+WzjJdErNsmn8
         SYoVC2VzsYfUCdujQ2FGePWL70ds7Y7VLWG99EtzyZDRfeTcCun+Cozf+RDdMoskksiH
         jMN4ZdavDJ6j2F5rrIfasj0Q9rAf4ZQ9W2VoFWv+rKkcvAh1PrZ0DlfEob+8aTQcqp3s
         on8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skLeJaSpw0/vsaEY+mYw5f7GsY+8sigTDomXYlalyaQ=;
        b=S6if83wD3Mp49GMqzsYxcok25jp2zLtm+HtmJQBr8TTgJgJ/P3FcUmzPuHC+L9NNcA
         Wq7aEUAme8d3UJa+aFotU3n6E7S0BTQFmsF0a93JfoWix9MJTtxr90rT1yt7XHkZtm8V
         ws6JwRPsohJ/O22DyUcHf1Afg8wvBmIOxtOfNsE4nPVpIiGAqgkiiZA8E6axdK/gCoVY
         4260+uBbrlsaxZnQmTMwEi7oMuunYVKIKM1cg4ER1JCQfBaZOxCUj0ZztL4sKJwnh9yq
         IJdkIFHQ+F+Aag21OLO+tlbabe2pLp81X8tA+Z4eFgQFWhPmDk/SPLSPkLyRjW1WAzub
         WT+g==
X-Gm-Message-State: AOAM532x15gThoC4KXimr9Ks2GiOoiKTSmALEBBhZOqy37vpwcOIxE+7
        WPKl/CWGbh/tBtvgIFbML6F01OFzfRCrNm7cebIOXHJ4JXyL
X-Google-Smtp-Source: ABdhPJwzd+X2ZmGvjAeJGgn47kj3o0CAYIlLFGj0DvXH6heL09BQOS+lXEPboLTYzGvb5vpWRpawKty9Cs5cHbwwnEU=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr9460277ejc.24.1638988902834;
 Wed, 08 Dec 2021 10:41:42 -0800 (PST)
MIME-Version: 1.0
References: <163898788970.2840238.15026995173472005588.stgit@warthog.procyon.org.uk>
In-Reply-To: <163898788970.2840238.15026995173472005588.stgit@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 13:41:31 -0500
Message-ID: <CAHC9VhTP-HbRU1z66MOkSyw9w7vhK7Vq8p0FrxVfEX-+tSD43A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] security: Remove security_add_mnt_opt() as it's unused
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, anna.schumaker@netapp.com,
        kolga@netapp.com, casey@schaufler-ca.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 8, 2021 at 1:25 PM David Howells <dhowells@redhat.com> wrote:
>
> Remove the add_mnt_opt LSM hook as it's not actually used.  This makes it
> easier to make the context pointers in selinux_mnt_opts non-const.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: selinux@vger.kernel.org
> cc: linux-security-module@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> ---
>
>  include/linux/lsm_hook_defs.h |    2 --
>  include/linux/lsm_hooks.h     |    2 --
>  include/linux/security.h      |    8 --------
>  security/security.c           |    8 --------
>  security/selinux/hooks.c      |   39 ---------------------------------------
>  5 files changed, 59 deletions(-)

There is already a patch in the selinux/next tree which does this.

  commit 52f982f00b220d097a71a23c149a1d18efc08e63
  Author: Ondrej Mosnacek <omosnace@redhat.com>
  Date:   Mon Dec 6 14:24:06 2021 +0100

   security,selinux: remove security_add_mnt_opt()

   Its last user has been removed in commit f2aedb713c28 ("NFS: Add
   fs_context support.").

   Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
   Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
