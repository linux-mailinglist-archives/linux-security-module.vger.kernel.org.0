Return-Path: <linux-security-module+bounces-11516-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EE7B2DF50
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Aug 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 451B14E508C
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Aug 2025 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D4261388;
	Wed, 20 Aug 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Kt94xQjW"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4901A7264
	for <linux-security-module@vger.kernel.org>; Wed, 20 Aug 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700213; cv=none; b=tXl7SAp7O7GsQ2M37C9szgs+vpCzOBzRABi+u99feAvyEgfa5e4/XpBU2N5NqStJXnwFAlnMB7Is275sE62QQq+0I7PEASBkHWtMgMETPV2PpPMZaLdkNVXOfsUTB5U7nax7JdfJnY+jIVDx7hU1OpMhnxaB+LCsb2iyaI1ROSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700213; c=relaxed/simple;
	bh=0TOR+DWEQveln64ogY19kIycWh3ujoS1GDWw1oUi7mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhHmu9RZ1I24KRm9novhd+1k56Mkledew+VL7KfaQCVsZO/pTpvOZvbptGO52i43yYLWj6eIBlaUG9ZsckYSXZw4CZ+4xX2fbUFoAPKC+5apqaK4vFv1N5hRULjsTarqOMhH+2I4L5PB+0rc5oLnJqCxbsMOv3QTtKWy/w4VKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Kt94xQjW; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c6TCk5jswzdGp;
	Wed, 20 Aug 2025 16:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755699698;
	bh=CXR191gI9VFxnHUj46tHAq2zbqPVStTyJFC0XmKMaGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kt94xQjWz/H6FyKlVjzQsdddQ/ksR4ttzoYQrrvq+nRhYG5W3suZ1U0s8XB0BGzaV
	 mMOHSk5fkpWzefFUW3h1M7m3MBpNqqLOmROVOB8pFsCkNPtJ1qbH4PYCKPvkqWdt+e
	 ChrCDYSkIRKceVvbtPaMp9G8NSnzyz6pFZ9vDP60=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c6TCk1JbMzwvP;
	Wed, 20 Aug 2025 16:21:38 +0200 (CEST)
Date: Wed, 20 Aug 2025 16:21:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
Message-ID: <20250820.Ohei2aj4ie0a@digikod.net>
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <20250709080220.110947-4-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709080220.110947-4-maxime.belair@canonical.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 09, 2025 at 10:00:56AM +0200, Maxime Bélair wrote:
> Enable users to manage AppArmor policies through the new hooks
> lsm_config_self_policy and lsm_config_system_policy.
> 
> lsm_config_self_policy allows stacking existing policies in the kernel.
> This ensures that it can only further restrict the caller and can never
> be used to gain new privileges.
> 
> lsm_config_system_policy allows loading or replacing AppArmor policies in
> any AppArmor namespace.
> 
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
> ---
>  security/apparmor/apparmorfs.c         | 31 ++++++++++
>  security/apparmor/include/apparmor.h   |  4 ++
>  security/apparmor/include/apparmorfs.h |  3 +
>  security/apparmor/lsm.c                | 84 ++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
> 

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9b6c2f157f83..0ce40290f44e 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1275,6 +1275,86 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>  	return aa_sock_perm(OP_SHUTDOWN, AA_MAY_SHUTDOWN, sock);
>  }
>  
> +/**
> + * apparmor_lsm_config_self_policy - Stack a profile
> + * @lsm_id: AppArmor ID (LSM_ID_APPARMOR). Unused here
> + * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
> + * @buf: buffer containing the user-provided name of the profile to stack
> + * @size: size of @buf
> + * @flags: reserved for future use; must be zero
> + *
> + * Returns: 0 on success, negative value on error
> + */
> +static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	char *name;
> +	long name_size;
> +	int ret;
> +


> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +	if (size == 0)
> +		return -EINVAL;
> +	if (size > AA_PROFILE_NAME_MAX_SIZE)
> +		return -E2BIG;
> +
> +	name = kmalloc(size, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;

This hunk should be part of the syscall code and shared amongst LSMs.

> +
> +
> +	name_size = strncpy_from_user(name, buf, size);
> +	if (name_size < 0) {
> +		kfree(name);
> +		return name_size;
> +	}
> +
> +	ret = aa_change_profile(name, AA_CHANGE_STACK);
> +
> +	kfree(name);
> +
> +	return ret;
> +}

