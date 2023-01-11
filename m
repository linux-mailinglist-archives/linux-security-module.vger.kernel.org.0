Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E0666550
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Jan 2023 22:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjAKVJL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Jan 2023 16:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjAKVIY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Jan 2023 16:08:24 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968983FCB5
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jan 2023 13:07:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so11401125pgr.12
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jan 2023 13:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NKA7LHbWkU/8uEBxGN30Hlf6bRn1CeHLZXrUPmworgc=;
        b=YTWKn86KW4x9YIu2uafO07bEbTWPUAYLZAXyoGtZy/TGSDvE6wAicpswdP1o+auAIh
         HJ+f9FuLbRQVqNSUfTmG5N3/DxZ5vrYN06dgVhn2/b62GbC4KwJDCjx38SGaR/+9oBfR
         m048K7zPe8w+9smfql2kO/QZeQbFS29Xex8ODOAld1orFR/3AejLnqzThDR3ejV/dFFl
         cffqrO0rkpjvdAb8sFIiudEXvXE/Cs8B9WOe98SylAZyTJMQDPLdP002IgtwMsbmbXFx
         srf2Jjid2Anwe3++xKzQ5MM0nvxaNeWLmVXoibMb9zq3LpbaL5SDGoUhu1PeZgFx4cn7
         Qh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKA7LHbWkU/8uEBxGN30Hlf6bRn1CeHLZXrUPmworgc=;
        b=TNEeDHNB3BN5HR7taUF6X1MsxffE8xWD/PD3vn6TPrYx2631PFXglV8HhP5DaBcHbG
         Qw3iC2N9oSE4i5AAVZtY6/lj1J/EFMpurI/taPE/CBR182rhf2KgbK393+0QfsVIU8vP
         g0pjUiQmlRIKEnywIrUuOS0cHWdratV8eXlJVJYbp9axmaqhqmkr0neDPOn15j5iaO3f
         zKQgU5fgYDYXSpHVBcm2CkFZstw2lyIbIwABoL0dYxFnTW2QyM8p9oOKKG1emGiBw9vg
         LyQ9MORmeGn2d6zOzB294/94CdPbgEMS6HaxMzDXuFbKPSAJAdmjR636ICzoJ8aZofze
         mMpg==
X-Gm-Message-State: AFqh2kq5fBWkEh9ISfN4M0K2/vqKQKHmQ4RAEwVAIwkcwlqQ8OWcMi6U
        f5U5cL0zjDRWpFas7X43+V0KFpGZLHG9lc0nElpx
X-Google-Smtp-Source: AMrXdXt0bj4jdytGJ4plzWTsJ+IVWBeKmA0w9dDcNsRRMHju9Xsvs60/JpLNKiY2Xi07XKEV7BCWlHI/+wxxDKTxrE0=
X-Received: by 2002:a63:e20b:0:b0:479:2109:506 with SMTP id
 q11-20020a63e20b000000b0047921090506mr4153612pgh.92.1673471276090; Wed, 11
 Jan 2023 13:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com> <20230109180717.58855-6-casey@schaufler-ca.com>
In-Reply-To: <20230109180717.58855-6-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 16:07:45 -0500
Message-ID: <CAHC9VhTFRXdRZnnORw-fU4Wo84HMUMw8+JTTJvc4+pv8YELBHw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] LSM: Create lsm_module_list system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 9, 2023 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
>
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/userspace-api/lsm.rst |  3 +++
>  include/linux/syscalls.h            |  1 +
>  kernel/sys_ni.c                     |  1 +
>  security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 55e8bf61ac8a..92af1fcaa654 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -180,3 +180,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
>         kfree(final);
>         return rc;
>  }
> +
> +/**
> + * sys_lsm_module_list - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_module_list,
> +               u32 __user *, ids,
> +               size_t __user *, size,
> +               u64, flags)
> +{
> +       size_t total_size = lsm_active_cnt * sizeof(*ids);
> +       size_t usize;
> +       int i;
> +
> +       if (flags)
> +               return -EINVAL;
> +
> +       if (get_user(usize, size))
> +               return -EFAULT;
> +
> +       if (put_user(total_size, size) != 0)
> +               return -EFAULT;
> +
> +       if (usize < total_size)
> +               return -E2BIG;
> +
> +       for (i = 0; i < lsm_active_cnt; i++)
> +               if (put_user(lsm_idlist[i]->id, ids++))
> +                       return -EFAULT;
> +
> +       return lsm_active_cnt;
> +}

Similar to my comments in 4/8, I would probably create a new LSM hook
for this syscall so that the lsm_ctx is passed through the LSM layer
directly to the target LSM:

  int security_sys_setselfattr(u64 attr, struct lsm_ctx __user *ctx,
size_t len);

--
paul-moore.com
