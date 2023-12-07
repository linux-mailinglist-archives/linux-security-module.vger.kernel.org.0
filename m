Return-Path: <linux-security-module+bounces-377-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA180907F
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2831C20327
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BA4EB55
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="puHq3JkW"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B049E0
	for <linux-security-module@vger.kernel.org>; Thu,  7 Dec 2023 09:08:42 -0800 (PST)
Date: Thu, 7 Dec 2023 12:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701968920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eUd3xjH2HF2EejUSWZhUOf3yJDKcu6pMWysVFu8RiZs=;
	b=puHq3JkWtcBQNKbK5bAHnkin2RfTU367Wzc1OrpC+avd7p55JGJwuTXnTu5dsJFxD5ldDx
	K6V9iF4AyslZAbVyNff4Y9Nf/U8Xw1NCt8ZIJEwr0O1wLkJaGCgAZIMJd7Ef0iHSMKdh2l
	jxh5eUm5lg2fT0kvqSeerFEajefqv9k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] vfs: inode cache scalability improvements
Message-ID: <20231207170835.yjpfpjy5or6bfkva@moria.home.lan>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 06, 2023 at 05:05:29PM +1100, Dave Chinner wrote:
...o
> Git tree containing this series can be pulled from:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale

For the series:

Tested-by: Kent Overstreet <kent.overstreet@linux.dev>

