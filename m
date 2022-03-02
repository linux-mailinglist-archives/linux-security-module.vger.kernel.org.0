Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2809A4CA2A7
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Mar 2022 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiCBLCI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 2 Mar 2022 06:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbiCBLCG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Mar 2022 06:02:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9929A6E8CC
        for <linux-security-module@vger.kernel.org>; Wed,  2 Mar 2022 03:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646218882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NL90XATKKIX97C6VYVucVBu43shampcQFg2cfhQPbI=;
        b=gMN9txtT4FPqbONYHN5kYQSw/hgoeLEb1m1+323USGPI6haYuyhEBksmBQjnLQmaqSXEbP
        Ngv3uhzzylYkR044GClXTWmDWL4llcLqTnVRD85QPlJMnKOvCRpNhLyezJMY1rYFnplo+X
        EM83FWnYMnhdePPUu4/JBTDYxuWWyG0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-jf459M2EOQKvqBKBhDTxwg-1; Wed, 02 Mar 2022 06:01:21 -0500
X-MC-Unique: jf459M2EOQKvqBKBhDTxwg-1
Received: by mail-yb1-f200.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so1096790ybg.8
        for <linux-security-module@vger.kernel.org>; Wed, 02 Mar 2022 03:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NL90XATKKIX97C6VYVucVBu43shampcQFg2cfhQPbI=;
        b=Vq+43pcZlsmf7aui3bXfcRVYZfTwtdGS/qTFxvq5awp9IBlhGX0YHupuYnGn3iX+b9
         EEJIkyfxAgBU4ohtD8/A3mDRk6O0MlX1bnpEJ8cK3OldEuC6H5opFxbs6plMyp0zrziu
         4G65nm2W3FWbrhocF4K7DLNHa5HIvsjeijh9Z6r0m+b7zIU8LOm5zKnm0I5kJbZSt+rZ
         wX2UablgRPEYy5bPFmobHFrec8BycHQUsFLqBDHFaDwovY0LC/subX8x5wAujKFPeuK4
         uHCLG5QNuNIiN+XOCdLqB/yRAy6Pi5ZYGE/0eI+RGJx7S/Us9rO+MtOAPpFk4kEy4+BF
         BrZQ==
X-Gm-Message-State: AOAM531S+gIoTtboCWSko2YT40gT1VVb6ygHQ60Fdy6ip4LE9IiLSmc/
        SUdbSngDaqMkIF5j51tKwptqY+m8DgCF/WKrLScvf8N5HW8ogYXKXEHt+qsXmloHh0oU/7hn8KU
        NeB8AHBvQVIw2HOcI7ttnDdHrqh4rZ8k3ARrDM5HRc6fgrGKaV1RH
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id g7-20020a5b0247000000b006244d2494eemr28789731ybp.197.1646218881078;
        Wed, 02 Mar 2022 03:01:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7ZbJdJ3VdDsL0VpbGEgMbJsVW9RlhUr/FGHk5e6AUbSgJCJi4pT5cbcixtFEVKgVekZiufimv5mHqHzT0ZO0=
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id
 g7-20020a5b0247000000b006244d2494eemr28789709ybp.197.1646218880870; Wed, 02
 Mar 2022 03:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20220301025052.GF117732@magnolia>
In-Reply-To: <20220301025052.GF117732@magnolia>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 2 Mar 2022 12:01:09 +0100
Message-ID: <CAFqZXNt3YqFTAq51D3TpV813hgtK8M47_VwGCoxigC25wpYmEg@mail.gmail.com>
Subject: Re: [PATCH RESEND] xfs: don't generate selinux audit messages for
 capability testing
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, john.haxby@oracle.com
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 1, 2022 at 3:51 AM Darrick J. Wong <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> There are a few places where we test the current process' capability set
> to decide if we're going to be more or less generous with resource
> acquisition for a system call.  If the process doesn't have the
> capability, we can continue the call, albeit in a degraded mode.
>
> These are /not/ the actual security decisions, so it's not proper to use
> capable(), which (in certain selinux setups) causes audit messages to
> get logged.  Switch them to has_capability_noaudit.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> ---
>  fs/xfs/xfs_fsmap.c  |    4 ++--
>  fs/xfs/xfs_ioctl.c  |    2 +-
>  fs/xfs/xfs_iops.c   |    2 +-
>  kernel/capability.c |    1 +
>  4 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
> index 48287caad28b..10e1cb71439e 100644
> --- a/fs/xfs/xfs_fsmap.c
> +++ b/fs/xfs/xfs_fsmap.c
> @@ -864,8 +864,8 @@ xfs_getfsmap(
>             !xfs_getfsmap_is_valid_device(mp, &head->fmh_keys[1]))
>                 return -EINVAL;
>
> -       use_rmap = capable(CAP_SYS_ADMIN) &&
> -                  xfs_has_rmapbt(mp);
> +       use_rmap = xfs_has_rmapbt(mp) &&
> +                  has_capability_noaudit(current, CAP_SYS_ADMIN);
>         head->fmh_entries = 0;
>
>         /* Set up our device handlers. */
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 2515fe8299e1..83481005317a 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1189,7 +1189,7 @@ xfs_ioctl_setattr_get_trans(
>                 goto out_error;
>
>         error = xfs_trans_alloc_ichange(ip, NULL, NULL, pdqp,
> -                       capable(CAP_FOWNER), &tp);
> +                       has_capability_noaudit(current, CAP_FOWNER), &tp);
>         if (error)
>                 goto out_error;
>
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index b79b3846e71b..a65217f787cf 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -723,7 +723,7 @@ xfs_setattr_nonsize(
>         }
>
>         error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> -                       capable(CAP_FOWNER), &tp);
> +                       has_capability_noaudit(current, CAP_FOWNER), &tp);
>         if (error)
>                 goto out_dqrele;
>
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 46a361dde042..765194f5d678 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -360,6 +360,7 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
>  {
>         return has_ns_capability_noaudit(t, &init_user_ns, cap);
>  }
> +EXPORT_SYMBOL(has_capability_noaudit);
>
>  static bool ns_capable_common(struct user_namespace *ns,
>                               int cap,
>

Thank you for respinning the patch[1]! And sorry that I couldn't find
the time to do that :/

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

(Yes, we should still clean up and document the capability functions,
but if no one has the energy, let's at least do the minimal fix.)

[1] Link for reference:
https://lore.kernel.org/linux-xfs/20210316173226.2220046-1-omosnace@redhat.com/T/

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

