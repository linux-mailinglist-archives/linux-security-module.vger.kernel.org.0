Return-Path: <linux-security-module+bounces-4906-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06421956F1A
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Aug 2024 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73071B27F4B
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Aug 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF171E5A;
	Mon, 19 Aug 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SmFr9kQK"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1813AA38
	for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082193; cv=none; b=V9T8tFzcIukl/vaY4Ra7krdYjO3ZxtfiJ0IMNeWOxLCIMQ5YmAobnNp76XuhJM1gVWAWAVYB1uvtDhHtBhAmeEdwpNhfQTfeBJkpS4lwAmMe3P9Kf1oCWu4c5jAoXXbSRZkmKycvu11XA4wtSsIsvnUCtx9JGTsO2odTlsp4aDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082193; c=relaxed/simple;
	bh=cfOi2EqN2wbz5WESbiQrgJNbC2uGzCRVgxqHEayf5VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1h4fLtx+bx19OFm6CkWA8LjQ6dCV6suej9YibOjipfpMXiQbfLM+KWkaeUDlO5wN7jfEX9W1octKK9pzNkmyug1GcWP5VL6yvJYDklNwmx8f0t+Y62/2nTRVUL8AaOmP4C4lUwB6OixqJm1fgL8+Ygnle/Kgw5eOl1xmQOU20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SmFr9kQK; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WncLb1HyTzmky;
	Mon, 19 Aug 2024 17:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724082183;
	bh=bHUJCTUzyBNVaOte3ZrKbREiOQ+ZAWWBO7szS17bYlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmFr9kQKTAHPFbX6Vp8dGrlYOp6wvDJEr8EGcYq9uHhbeSr533YvaB+hCzu+vhGte
	 Q569kTLc8Yr7PKh8KM8YQn9nncsrQoDk8/79PxNUzMoCiCmR/lLvp4XWSetaN2/qgF
	 gIMZyvWWYDoW8vZe2FnJC0ayMK1jFkjckw01Jsbs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WncLZ3kmczP6s;
	Mon, 19 Aug 2024 17:43:02 +0200 (CEST)
Date: Mon, 19 Aug 2024 17:42:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/5] selftests/Landlock: Abstract unix socket
 restriction tests
Message-ID: <20240819.ig5eekohQuoh@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <2fb401d2ee04b56c693bba3ebac469f2a6785950.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fb401d2ee04b56c693bba3ebac469f2a6785950.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 14, 2024 at 12:22:20AM -0600, Tahera Fahimi wrote:
> The patch introduces Landlock ABI version 6 and has three types of tests

"and adds three types" ?

> that examines different scenarios for abstract unix socket connection:

Not only connection.

> 1) unix_socket: base tests of the abstract socket scoping mechanism for a
>    landlocked process, same as the ptrace test.
> 2) optional_scoping: generates three processes with different domains and
>    tests if a process with a non-scoped domain can connect to other
>    processes.
> 3) unix_sock_special_cases: since the socket's creator credentials are used

"unix_sock_special_cases" seems a bit too generic and is not
self-explanatory.  What about "outside_socket"?

>    for scoping sockets, this test examines the cases where the socket's
>    credentials are different from the process using it.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---

> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -0,0 +1,942 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Abstract Unix Socket
> + *
> + * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2019-2020 ANSSI

You can replace these two lines with your copyright (same for the signal
test file):
Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>

