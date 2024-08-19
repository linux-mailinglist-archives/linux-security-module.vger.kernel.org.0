Return-Path: <linux-security-module+bounces-4909-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F46D957488
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Aug 2024 21:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC321C23AB0
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Aug 2024 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2026186E56;
	Mon, 19 Aug 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NN1MTT5i"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633D1DC462
	for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096143; cv=none; b=sLNavzthTCT3n5+cp7btpyMPJBgsoR+yyC2iZpfZgAfdHvjKN0CIQ+NKjSZuW3//s2fAPtDGicBbXfcmxPAqIcOC5ANBDBb9mcI64SW1dEyoyS3HEDzWydN6Trz3wASE1CcEL9oMh6fiExCVU5QCYv7c38pvhvAyYjizrJGuzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096143; c=relaxed/simple;
	bh=+OduYjndWEcDGzbPt9anuSkV41/HMehd87djU29DX1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq0Qn0lfbt0G3A5jJls17M8KIr/IDnNn/oJ6Jxuj7j6AgU9OMeJrvEdAdRxYO2FxIdNTmAdiNgszTLH/NmRprx5zc7DbTTiukg3sQ09clVEGn+n0HzOrPkMIT90tJqBD4f8OVollmM0qhBmMedXSBIDAXt270WpEmckB562dGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NN1MTT5i; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WnjVw0JMvzqX9;
	Mon, 19 Aug 2024 21:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724096135;
	bh=kftjJDEQR6D2YRsmwipISiaWD9LCAgzCHPuYKHHQ+v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NN1MTT5i0P2mpf3bAbV7biTOHt6zSx2wXDXXO/fkx3Lr0MrhQD8+QBkb5QWnI0a69
	 7a/U/ctOYDvz9/jUw0reXobAg7TdieYVz6TtmT0/D384CuoQraCnlgLAxNNr64o8J6
	 JV7DTbSMzdjW5MviquiGu/+iSLj3PAw/ldZq3yfA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WnjVt5WmqznwR;
	Mon, 19 Aug 2024 21:35:34 +0200 (CEST)
Date: Mon, 19 Aug 2024 21:35:29 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 1/5] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240819.Noon6Ewoodoh@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <603cf546392f0cd35227f696527fd8f1d644cb31.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <603cf546392f0cd35227f696527fd8f1d644cb31.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 14, 2024 at 12:22:19AM -0600, Tahera Fahimi wrote:
> This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
> that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> abstract Unix sockets from connecting to a process outside of
> the same landlock domain. It implements two hooks, unix_stream_connect
> and unix_may_send to enforce this restriction.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> ---

> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 03b470f5a85a..20d2a8b5aa42 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -97,8 +97,9 @@ static void build_check_abi(void)
>  	 */
>  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
> +	ruleset_size += sizeof(ruleset_attr.scoped);
>  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> -	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
> +	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
>  
>  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
>  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
> @@ -149,7 +150,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>  
> -#define LANDLOCK_ABI_VERSION 5
> +#define LANDLOCK_ABI_VERSION 6

Each test need to pass with each commit (not only this one BTW), so we
need to update the abi_version test with this commit.  To be sure that
everything is OK, you can run `check-linux.sh all` on each commit.

