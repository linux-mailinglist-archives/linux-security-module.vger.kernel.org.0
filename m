Return-Path: <linux-security-module+bounces-8264-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0BA3D361
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Feb 2025 09:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61633B26E5
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Feb 2025 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7223B1EA7EA;
	Thu, 20 Feb 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shwLwVQ0"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474271E9B07;
	Thu, 20 Feb 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040799; cv=none; b=dWWLVK5a3wd7Z4ibFsSjVLFXUYK0Oa76tXGkgwAWykmbubuDbaWPPqYNjeCFLC5gbzizIC99I2fnpYRupRlnLyH1iUGHiCeDGWos4GAgEpMBP8RlV/6ezPvOnD+OeGB9COtzXH0ksKI5CvgorWmr68gxynIEyba8RpuZgwf93UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040799; c=relaxed/simple;
	bh=0EcBJxz9mfkh23PcIR3DTUy1k/b2btO/vBMMPMNe5Qw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3UqBfqWjHxl4sk6BvSrMXcP8Gs8ocqMHN9ImVq7exnvfUoMYhh2tcck0kk4INPlFiuNmlPBMdI83GSuPJ6FKomraY/fW46jbTiVhOdgCpOr0d0isKb72i62h7lw4WMQ9M7BK2vM2SAkYkbsJAD3lqEFoljE1OI171e/ibIjDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shwLwVQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BD8C4CED1;
	Thu, 20 Feb 2025 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740040799;
	bh=0EcBJxz9mfkh23PcIR3DTUy1k/b2btO/vBMMPMNe5Qw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=shwLwVQ01mIRxizgzAz74e1emjIfOBuuY8VA8s/IrfgWja7BwZ6wjYBIqNI+1Pmbr
	 DIgMqYGksVNVRVaT5IGtixHXDjjqeG81DpgeQyrj9dEq6K8LyfnxaMt2yBLhYOTOWL
	 fMp5PiS5NNgak8I3qV9341xoim5vLSPXQh0vRtyY1xRJ92UJvf8sAyGDlQonvotpLI
	 WQuT2nf8KTszsCIlG+O6g2Zu6ibbmPu/RrkD7J8f7DIWPQDE6QwjKn3atAxPaCdwII
	 ZwaiUFe3P+0YurxA28yLw2i4x07DE4AStcKyZak3g/mbfaftMEx8/OYgH1bpqmFf2q
	 q3HOqUnkuU3iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF20380CEE2;
	Thu, 20 Feb 2025 08:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp: drop secpath at the same time as we currently
 drop dst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174004082976.1211626.2598809142396901405.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 08:40:29 +0000
References: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
In-Reply-To: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, kuniyu@amazon.com,
 dsahern@kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, xmu@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 17 Feb 2025 11:23:35 +0100 you wrote:
> Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> running tests that boil down to:
>  - create a pair of netns
>  - run a basic TCP test over ipcomp6
>  - delete the pair of netns
> 
> The xfrm_state found on spi_byaddr was not deleted at the time we
> delete the netns, because we still have a reference on it. This
> lingering reference comes from a secpath (which holds a ref on the
> xfrm_state), which is still attached to an skb. This skb is not
> leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> skb_attempt_defer_free.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: drop secpath at the same time as we currently drop dst
    https://git.kernel.org/netdev/net/c/9b6412e6979f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



