Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9AE39EA01
	for <lists+linux-security-module@lfdr.de>; Tue,  8 Jun 2021 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGXTx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Jun 2021 19:19:53 -0400
Received: from mail.hallyn.com ([178.63.66.53]:37260 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFGXTw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 19:19:52 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2021 19:19:52 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7E0A0867; Mon,  7 Jun 2021 18:09:13 -0500 (CDT)
Date:   Mon, 7 Jun 2021 18:09:13 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next] capability: fix doc warnings in capability.c
Message-ID: <20210607230913.GA12581@mail.hallyn.com>
References: <20210605062602.678602-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605062602.678602-1-libaokun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jun 05, 2021 at 02:26:02PM +0800, Baokun Li wrote:
> Fixes the following W=1 kernel build warning(s):
> 
> kernel/capability.c:490: warning: Function parameter or
>  member 'mnt_userns' not described in 'privileged_wrt_inode_uidgid'
> kernel/capability.c:506: warning: Function parameter or
>  member 'mnt_userns' not described in 'capable_wrt_inode_uidgid'
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  kernel/capability.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 46a361dde042..27a959aa897f 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -480,6 +480,7 @@ EXPORT_SYMBOL(file_ns_capable);
>  /**
>   * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
>   * @ns: The user namespace in question
> + * @mnt_userns: User namespace of the mount the inode was found from
>   * @inode: The inode in question
>   *
>   * Return true if the inode uid and gid are within the namespace.
> @@ -495,6 +496,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
>  /**
>   * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
>   * @inode: The inode in question
> + * @mnt_userns: User namespace of the mount the inode was found from

The mnt_userns comes before the inode in this fn.

>   * @cap: The capability in question
>   *
>   * Return true if the current task has the given capability targeted at
> -- 
> 2.31.1
