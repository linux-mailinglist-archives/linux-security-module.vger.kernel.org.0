Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13E066364E
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Jan 2023 01:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjAJAcH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Jan 2023 19:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjAJAbC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Jan 2023 19:31:02 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748FC1119
        for <linux-security-module@vger.kernel.org>; Mon,  9 Jan 2023 16:30:58 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4b718cab0e4so135223477b3.9
        for <linux-security-module@vger.kernel.org>; Mon, 09 Jan 2023 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0APB/zykDxbiH2tuTIX9EMGYkGcv+YfvyuAJpMFuhY=;
        b=WVc0BDUp9SVjJ6q3wUC++WI7N/Tni/g/aXwHGXr1MeeP1qPk+en2yOArUr266ynZlE
         mUxsVueCV5uMPXe6uFIOwA+TS/oyDRyjo5ZnsAT1iyfnHo24A3u2q9vW5T4cjdkER9Zt
         jGxqEbCN4ejClYW8kPalGpueAsZNsSV0UzGqgSh2TkcP2Ty2IF1dAZ0W92oRCMq1lYag
         X5a/nCVa7ADbfMhkqWMdrq5ws9wES8sTC7spB9bA2oGMMCBMG6qGivxlYkglqjo1G6Hv
         CJLIVbFNkJTj+P4NM4JqfjV68njgS8HNAHab1qES/we2jiazHOZfjSJUjmRYWWGQUBgN
         Ikcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0APB/zykDxbiH2tuTIX9EMGYkGcv+YfvyuAJpMFuhY=;
        b=hVAv/d3bJ06gMLweLGUBNUGAq/kJOH5bJW8y0/txBxGKtRNtpdV29gZpRTbfUu/zMS
         KQT0Ipu9e6159ipfNGC9aGJu4PVxP0fP+Ceiyds2310Wti9SiHayP7aGw3nNp6vC6Js/
         UccyL6ve98U8LQn5HsCGup+21Iwhl4kwGMwTSuBQQzVcnc08Uia4p/qUlaG7f/tPCfqN
         S8/NCOGkyW2KHrYyrj8ZZvPv5OIzylbOVPBCMnfvQn7jjYiM3YTSbR3v+/NGChmkbV9A
         d6/muf/ULeapIqHPsTOy/o5rO8edaH6ESD/bhPmPhvn+eyoyKqH43jbccfmcwAKZ5aMY
         2vbg==
X-Gm-Message-State: AFqh2kqDHoLzBd8Vp8mg1oUzQhDQcCt1AkKFhYF9qAeWo/mYxYSP59Gx
        dht4WmkO/NlehbYhnn8zi0bOhpGNKtxXQmWWAU+alw==
X-Google-Smtp-Source: AMrXdXuBtmwbNkgEKUV7QelHV3Tp3qZbn19ES4i7h3TahXzAvTmx8xk8GcbqOd7qMvBI1otZnZmBQGsCP+NBLfv3GfE=
X-Received: by 2002:a05:690c:688:b0:4ab:cd28:a5e2 with SMTP id
 bp8-20020a05690c068800b004abcd28a5e2mr3509792ywb.234.1673310657407; Mon, 09
 Jan 2023 16:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <20230109213809.418135-5-tjmercier@google.com>
 <7e1610e7-c131-e162-be47-8983be7d9aec@schaufler-ca.com>
In-Reply-To: <7e1610e7-c131-e162-be47-8983be7d9aec@schaufler-ca.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 9 Jan 2023 16:30:46 -0800
Message-ID: <CABdmKX3BhNxdgF2dAuwPCPASe1raYYx6UUWRv0L5p3FxoU5MUw@mail.gmail.com>
Subject: Re: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 9, 2023 at 2:28 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/9/2023 1:38 PM, T.J. Mercier wrote:
> > Any process can cause a memory charge transfer to occur to any other
> > process when transmitting a file descriptor through binder. This should
> > only be possible for central allocator processes,
>
> How is a "central allocator process" identified?

Any process with the transfer_charge permission. On Android this is
the graphics allocator HAL which would have this added to its policy.

> If I have a LSM that
> is not SELinux (e.g. AppArmor, Smack) or no LSM at all, how can/should this
> be enforced?

Sorry, why would you be expecting enforcement with no LSM? Are you
suggesting that this check should be different than the ones that
already exist for Binder here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lsm_hook_defs.h#n29

> Why isn't binder enforcing this restriction itself?

Binder has no direct knowledge of which process has been designated as
an allocator / charge transferrer. That is defined externally by
whoever configures the system.

> >  so a new SELinux
> > permission is added to restrict which processes are allowed to initiate
> > these charge transfers.
>
> Which is all perfectly reasonable if you have SELinux.
>
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  drivers/android/binder.c            | 5 +++++
> >  include/linux/lsm_hook_defs.h       | 2 ++
> >  include/linux/lsm_hooks.h           | 6 ++++++
> >  include/linux/security.h            | 2 ++
> >  security/security.c                 | 6 ++++++
> >  security/selinux/hooks.c            | 9 +++++++++
> >  security/selinux/include/classmap.h | 2 +-
> >  7 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 9830848c8d25..9063db04826d 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
> >       if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
> >               struct dma_buf *dmabuf;
> >
> > +             if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
> > +                     ret = -EPERM;
> > +                     goto err_security;
> > +             }
> > +
> >               if (unlikely(!is_dma_buf_file(file))) {
> >                       binder_user_error(
> >                               "%d:%d got transaction with XFER_CHARGE for non-dmabuf fd, %d\n",
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index ed6cb2ac55fa..8db2a958557e 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -33,6 +33,8 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
> >        const struct cred *to)
> >  LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> >        const struct cred *to, struct file *file)
> > +LSM_HOOK(int, 0, binder_transfer_charge, const struct cred *from,
> > +      const struct cred *to)
> >  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
> >        unsigned int mode)
> >  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 0a5ba81f7367..39c40c7bf519 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -1385,6 +1385,12 @@
> >   *   @file contains the struct file being transferred.
> >   *   @to contains the struct cred for the receiving process.
> >   *   Return 0 if permission is granted.
> > + * @binder_transfer_charge:
> > + *   Check whether @from is allowed to transfer the memory charge for a
> > + *   buffer out of its cgroup to @to.
> > + *   @from contains the struct cred for the sending process.
> > + *   @to contains the struct cred for the receiving process.
> > + *   Return 0 if permission is granted.
> >   *
> >   * @ptrace_access_check:
> >   *   Check permission before allowing the current process to trace the
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 5b67f208f7de..3b7472308430 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -270,6 +270,8 @@ int security_binder_transfer_binder(const struct cred *from,
> >                                   const struct cred *to);
> >  int security_binder_transfer_file(const struct cred *from,
> >                                 const struct cred *to, struct file *file);
> > +int security_binder_transfer_charge(const struct cred *from,
> > +                                 const struct cred *to);
> >  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
> >  int security_ptrace_traceme(struct task_struct *parent);
> >  int security_capget(struct task_struct *target,
> > diff --git a/security/security.c b/security/security.c
> > index d1571900a8c7..97e1e74d1ff2 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -801,6 +801,12 @@ int security_binder_transfer_file(const struct cred *from,
> >       return call_int_hook(binder_transfer_file, 0, from, to, file);
> >  }
> >
> > +int security_binder_transfer_charge(const struct cred *from,
> > +                                 const struct cred *to)
> > +{
> > +     return call_int_hook(binder_transfer_charge, 0, from, to);
> > +}
> > +
> >  int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
> >  {
> >       return call_int_hook(ptrace_access_check, 0, child, mode);
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3c5be76a9199..823ef14924bd 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
> >                           &ad);
> >  }
> >
> > +static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
> > +{
> > +     return avc_has_perm(&selinux_state,
> > +                         cred_sid(from), cred_sid(to),
> > +                         SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> > +                         NULL);
> > +}
> > +
> >  static int selinux_ptrace_access_check(struct task_struct *child,
> >                                      unsigned int mode)
> >  {
> > @@ -7052,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >       LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> >       LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> >       LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
> > +     LSM_HOOK_INIT(binder_transfer_charge, selinux_binder_transfer_charge),
> >
> >       LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
> >       LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> > index a3c380775d41..2eef180d10d7 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
> >       { "tun_socket",
> >         { COMMON_SOCK_PERMS, "attach_queue", NULL } },
> >       { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> > -                   NULL } },
> > +                   "transfer_charge", NULL } },
> >       { "cap_userns",
> >         { COMMON_CAP_PERMS, NULL } },
> >       { "cap2_userns",
