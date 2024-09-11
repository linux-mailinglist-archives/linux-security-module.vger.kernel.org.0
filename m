Return-Path: <linux-security-module+bounces-5446-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85D975A2C
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Sep 2024 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EA31C22D29
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Sep 2024 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB41B3734;
	Wed, 11 Sep 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rKuo1xxl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419011B140D
	for <linux-security-module@vger.kernel.org>; Wed, 11 Sep 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078648; cv=none; b=Vz1HP0EsCTBWsbKDTW9jzQTk8HUBRRCf8spPENDD5I3zB+OH5MSdL2kk4YPYugx+qNy8xI5/GJ1I0krCBGsuvyOtuNlVl18FzVS/C/UIAw6V5cKEZrRAkXtxjhKGJpwrC1fbdfuyIG0j9qayE+ATySXPNF787cNgJ5ZrmO+/y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078648; c=relaxed/simple;
	bh=Iv7X5S71r9G8/8xCax5nJjG2CNB8/rQcjQXAMuNXl+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTzQw3qcEoSbaxkH/FyM6zOhSB1vAArM2KqJtIKfYeA5mS9E2Mr4D8Pqe+Pi1mn30uH2BXiKmyjQ3BpJJIwg/MbaAAngVfOupmZTAF/HyrlvgOwj/zN2WcrEe5tmdyvRlDdb15AOeYSrBcFD1N0bl0cTyKaC7cnf7tau8pHcrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rKuo1xxl; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X3pgs0CMCzXH1;
	Wed, 11 Sep 2024 20:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726078632;
	bh=2VJrSaRcSGNHnP75mgU3Crci81AkrircpLyaN62nmUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKuo1xxlqeWVXz6ApHqUCrGp3w15gL0PNnZpT//NwiuTTPeN91YRkh4uAcKy269vk
	 TDHwGnSdeK4bYWP0MHroX/UK6Ork+jTHv07FgZPgG5+BboRnpcFSOdQyrCoN+XIOZX
	 MkCYLnA4y8XMFjm14OG6db/bKOJ0LmJkeLhMdxuM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X3pgr0xH1zWmB;
	Wed, 11 Sep 2024 20:17:12 +0200 (CEST)
Date: Wed, 11 Sep 2024 20:17:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/6] landlock: Signal scoping support
Message-ID: <20240911.BieLu8DooJiw@digikod.net>
References: <cover.1725657727.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725657727.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

We should also have the same tests as for scoped_vs_unscoped variants.
I renamed them from the abstract unix socket patch series, please take a
look:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

I'll send more reviews tomorrow and I'll fix most of them in my -next
branch (WIP), except for the hook_file_send_sigiotask tests and these
scoped_vs_unscoped variants that you should resolve.

On Fri, Sep 06, 2024 at 03:30:02PM -0600, Tahera Fahimi wrote:
> This patch series adds scoping mechanism for signals.
> Closes: https://github.com/landlock-lsm/linux/issues/8
> 
> Problem
> =======
> 
> A sandboxed process is currently not restricted from sending signals
> (e.g. SIGKILL) to processes outside the sandbox since Landlock has no
> restriction on signals(see more details in [1]).
> 
> A simple way to apply this restriction would be to scope signals the
> same way abstract unix sockets are restricted.
> 
> [1]https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
> 
> Solution
> ========
> 
> To solve this issue, we extend the "scoped" field in the Landlock
> ruleset attribute structure by introducing "LANDLOCK_SCOPED_SIGNAL"
> field to specify that a ruleset will deny sending any signals from
> within the sandbox domain to its parent(i.e. any parent sandbox or
> non-sandbox processes).
> 
> Example
> =======
> 
> Create a sansboxed shell and pass the character "s" to LL_SCOPED:
> LL_FD_RO=/ LL_FS_RW=. LL_SCOPED="s" ./sandboxer /bin/bash
> Try to send a signal(like SIGTRAP) to a process ID <PID> through:
> kill -SIGTRAP <PID>
> The sandboxed process should not be able to send the signal.
> 
> Previous Versions
> =================
> v3:https://lore.kernel.org/all/cover.1723680305.git.fahimitahera@gmail.com/
> v2:https://lore.kernel.org/all/cover.1722966592.git.fahimitahera@gmail.com/
> v1:https://lore.kernel.org/all/cover.1720203255.git.fahimitahera@gmail.com/
> 
> Tahera Fahimi (6):
>   landlock: Add signal scoping control
>   selftest/landlock: Signal restriction tests
>   selftest/landlock: Add signal_scoping_threads test
>   selftest/landlock: Test file_send_sigiotask by sending out-of-bound
>     message
>   sample/landlock: Support sample for signal scoping restriction
>   landlock: Document LANDLOCK_SCOPED_SIGNAL
> 
>  Documentation/userspace-api/landlock.rst      |  22 +-
>  include/uapi/linux/landlock.h                 |   3 +
>  samples/landlock/sandboxer.c                  |  17 +-
>  security/landlock/fs.c                        |  17 +
>  security/landlock/fs.h                        |   6 +
>  security/landlock/limits.h                    |   2 +-
>  security/landlock/task.c                      |  59 +++
>  .../selftests/landlock/scoped_signal_test.c   | 371 ++++++++++++++++++
>  .../testing/selftests/landlock/scoped_test.c  |   2 +-
>  9 files changed, 486 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c
> 
> -- 
> 2.34.1
> 

