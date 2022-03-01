Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9E4C8EA0
	for <lists+linux-security-module@lfdr.de>; Tue,  1 Mar 2022 16:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiCAPLE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 1 Mar 2022 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiCAPK7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Mar 2022 10:10:59 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D10F8F9A3
        for <linux-security-module@vger.kernel.org>; Tue,  1 Mar 2022 07:10:16 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id B50C6166E; Tue,  1 Mar 2022 09:10:14 -0600 (CST)
Date:   Tue, 1 Mar 2022 09:10:14 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.haxby@oracle.com
Subject: Re: [PATCH RESEND] xfs: don't generate selinux audit messages for
 capability testing
Message-ID: <20220301151014.GA17144@mail.hallyn.com>
References: <20220301025052.GF117732@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301025052.GF117732@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 28, 2022 at 06:50:52PM -0800, Darrick J. Wong wrote:
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
>  	    !xfs_getfsmap_is_valid_device(mp, &head->fmh_keys[1]))
>  		return -EINVAL;
>  
> -	use_rmap = capable(CAP_SYS_ADMIN) &&
> -		   xfs_has_rmapbt(mp);
> +	use_rmap = xfs_has_rmapbt(mp) &&

Hm, I'm failing to find where xfs_has_rmapbt() is defined.  I just
wanted to make sure it doesn't have any side effects that you'd want
to avoid in the no-capability case.  (Seems very unlikely that it
would, given the name)

> +		   has_capability_noaudit(current, CAP_SYS_ADMIN);
>  	head->fmh_entries = 0;
>  
>  	/* Set up our device handlers. */
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 2515fe8299e1..83481005317a 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1189,7 +1189,7 @@ xfs_ioctl_setattr_get_trans(
>  		goto out_error;
>  
>  	error = xfs_trans_alloc_ichange(ip, NULL, NULL, pdqp,
> -			capable(CAP_FOWNER), &tp);
> +			has_capability_noaudit(current, CAP_FOWNER), &tp);
>  	if (error)
>  		goto out_error;
>  
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index b79b3846e71b..a65217f787cf 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -723,7 +723,7 @@ xfs_setattr_nonsize(
>  	}
>  
>  	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> -			capable(CAP_FOWNER), &tp);
> +			has_capability_noaudit(current, CAP_FOWNER), &tp);
>  	if (error)
>  		goto out_dqrele;
>  
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 46a361dde042..765194f5d678 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -360,6 +360,7 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
>  {
>  	return has_ns_capability_noaudit(t, &init_user_ns, cap);
>  }
> +EXPORT_SYMBOL(has_capability_noaudit);
>  
>  static bool ns_capable_common(struct user_namespace *ns,
>  			      int cap,
