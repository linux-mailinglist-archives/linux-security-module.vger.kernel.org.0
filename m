Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEA320356
	for <lists+linux-security-module@lfdr.de>; Sat, 20 Feb 2021 03:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBTC6Z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 19 Feb 2021 21:58:25 -0500
Received: from namei.org ([65.99.196.166]:53842 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBTC6Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Feb 2021 21:58:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id B195967;
        Sat, 20 Feb 2021 02:55:54 +0000 (UTC)
Date:   Sat, 20 Feb 2021 13:55:54 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
In-Reply-To: <161377734508.87807.8537642254664217815.stgit@sifl>
Message-ID: <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
References: <161377712068.87807.12246856567527156637.stgit@sifl> <161377734508.87807.8537642254664217815.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 19 Feb 2021, Paul Moore wrote:

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56ac..39d501261108d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		u32 secid;
>  		size_t added_size;
>  
> -		security_task_getsecid(proc->tsk, &secid);
> +		security_task_getsecid_subj(proc->tsk, &secid);
>  		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;

Can someone from the Android project confirm this is correct for binder?

-- 
James Morris
<jmorris@namei.org>

