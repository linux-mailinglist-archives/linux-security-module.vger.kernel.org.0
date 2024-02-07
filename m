Return-Path: <linux-security-module+bounces-1335-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B984CACA
	for <lists+linux-security-module@lfdr.de>; Wed,  7 Feb 2024 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610161F27FE4
	for <lists+linux-security-module@lfdr.de>; Wed,  7 Feb 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC276032;
	Wed,  7 Feb 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlMPdrxn"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C92420B;
	Wed,  7 Feb 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309628; cv=none; b=aLdufxDPg0501n6C9ZaDV9l4zbXva680y84i2aROJ1fS8rj9Rjc92m8yc22mxZwNVoVfFP01WM6/ka/ACSTtzFFflmj7ZICfW3i5pFtavWPkA9IFWEZoS0hSttBqIXIp7JMFWmIWmxR+jSJmRJKZGti6t6p+IJFNReUsn4zE4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309628; c=relaxed/simple;
	bh=Y53ZLY70rGcAu8m2agoZmy1drZPJGjOEf9BLWWTpYCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+yVhcj6H/NDf6nrXFFQkH/afcPVa9p5NHUgEzzYpVE4q9jOuUTeDqvyQROs1aGDUlbJyJenY5dAhGrQzZBfpgRh15JQLjWQ5YWt++e9b43SEXT3Ny7pkkmJ7odTQZY+zpYdm3I88eIiIfqUUpxtL5eNAzb+TLnJb8HK+N/lyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlMPdrxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CADE7C43390;
	Wed,  7 Feb 2024 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707309627;
	bh=Y53ZLY70rGcAu8m2agoZmy1drZPJGjOEf9BLWWTpYCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WlMPdrxnWrYbvI7GQoJHyt+SdyGXUgLhofDEbtJzQM400SQGaexZx3b1TKPp9MrHd
	 qsT+/qDXkmjMkphrDXx9vJYJA1yhfTVVwEX1fi2Np+kCse8HOYWLwKm29J1gukH5hT
	 2RSbMXRiCb5v2SwSVx1sOYFB6QhQ7MGM5DJ3b+t2j9QZGfkD8QlikInnSwonhw+yY1
	 XbcXigzPgyoz5H7gaOPNfbgdnJ8NWgn86YWXxycyYqMCvoos+0W5yomAf7f5HuS+wt
	 LL/WyK9FORpBBpA9tAeRwnGA85RhNL3Qo6WocOytbjeuWlst/0ZMy8UCkqDaXxxN1X
	 z6TQTCxNVzKkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B33EED8C978;
	Wed,  7 Feb 2024 12:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] netlabel: cleanup struct netlbl_lsm_catmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170730962772.18546.11260947611039945132.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 12:40:27 +0000
References: <20240204023531.2225264-1-dongtai.guo@linux.dev>
In-Reply-To: <20240204023531.2225264-1-dongtai.guo@linux.dev>
To: George Guo <dongtai.guo@linux.dev>
Cc: kuba@kernel.org, paul@paul-moore.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, guodongtai@kylinos.cn,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  4 Feb 2024 10:35:31 +0800 you wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Simplify the code from macro NETLBL_CATMAP_MAPTYPE to u64, and fix
> warning "Macros with complex values should be enclosed in parentheses"
> on "#define NETLBL_CATMAP_BIT (NETLBL_CATMAP_MAPTYPE)0x01", which is
> modified to "#define NETLBL_CATMAP_BIT ((u64)0x01)".
> 
> [...]

Here is the summary with links:
  - [v2,1/1] netlabel: cleanup struct netlbl_lsm_catmap
    https://git.kernel.org/netdev/net-next/c/23c5ae6d4675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



