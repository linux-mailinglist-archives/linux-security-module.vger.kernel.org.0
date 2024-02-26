Return-Path: <linux-security-module+bounces-1660-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187AD867BF0
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Feb 2024 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83A8291E47
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Feb 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32212C7F4;
	Mon, 26 Feb 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zYEG/ovZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F112BEBD
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964873; cv=none; b=pZEenC2EnFpN+fspHKu9qecwkfks3ZckHcLwPbmihDRZ8jMMEVAnchovovXZPZszwNniQobjcf8TfUeZyReQxGKKQ9Qo7bUSXXKI51FLfAy+Na0eKXiLCNzWp8HQ2gm9mPBHd56jHSXNj4RCPs069BMtWWdp9413DieFNjDNln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964873; c=relaxed/simple;
	bh=9oIJaUSzzlfVyV6JEd/5V+zZ2B5DVJZOSdtTGUS1/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcPZb+0w67JEIopcjCea0xVmez1JqBLgGtEo9cbcjX++mPBG3UXoXQITq7bkFUu056jjLXy5gmQuExN0PVBhml4QOwRcvfq0gYzqXUuuxBxLb+TzmEvPlLGDSgS6lwLyU07tuIeiYwi6Kjp7zIxKWUQ/Ww0BDx5WT9V7S08Pjh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zYEG/ovZ; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk5ct5KzYz7kl;
	Mon, 26 Feb 2024 17:27:42 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk5ct1T5kz8JZ;
	Mon, 26 Feb 2024 17:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708964862;
	bh=9oIJaUSzzlfVyV6JEd/5V+zZ2B5DVJZOSdtTGUS1/DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zYEG/ovZoEHk3G1dlz0YQyNIvsDRQNqe1gt7Eygn5EZTGo/wfWYNkmjzUjcQH+O4R
	 VfG5q3Dg5EQWoAcyg206oeap9fRk/sYXi9hYZfN/RdGPsLklur7SCsUJ4ZlVub3DGM
	 aecKX9zgbRozPacZWnTWRb2BqG3CgpKZrkO7qE8g=
Date: Mon, 26 Feb 2024 17:27:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240226.Juthoojee3qu@digikod.net>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240223160259.22c61d1e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223160259.22c61d1e@kernel.org>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 04:02:59PM -0800, Jakub Kicinski wrote:
> On Tue, 20 Feb 2024 11:22:24 -0800 Jakub Kicinski wrote:
> > When running selftests for our subsystem in our CI we'd like all
> > tests to pass. Currently some tests use SKIP for cases they
> > expect to fail, because the kselftest_harness limits the return
> > codes to pass/fail/skip.
> > 
> > Clean up and support the use of the full range of ksft exit codes
> > under kselftest_harness.
> > 
> > Merge plan is to put it on top of -rc4 and merge into net-next.
> > That way others should be able to pull the patches without
> > any networking changes.
> 
> Hi Mickaël,
> 
> would you be able to take a look at those changes? landlock seems to be
> the sole user of the "no_print" functionality in the selftest harness.
> If the patches look good I'll create a branch based on Linus's tree
> so that anyone interested can pull the changes in..

Hi Jakub,

I missed your patches before this series.  I just sent two patches to
clean things up before you change them.  This should simplify your
patches and improve the overall maintenance.  I'd appreciate if you
rebase on top of them.

Regards,
 Mickaël

