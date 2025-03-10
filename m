Return-Path: <linux-security-module+bounces-8656-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB377A596AE
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Mar 2025 14:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853A3A7A02
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Mar 2025 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4022ACF1;
	Mon, 10 Mar 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibhBt64B"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836A22ACF2
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614569; cv=none; b=dekRuUerHMi4tfPLSJsNoeKkNw32sZuErSiVLyxrKhYaNZKCNg+gBvMNCcVYhsII+cLik41Fkf/jZtmi2uGJ4yBNt/WWPZbcleZ3lAI2Xuk4rjzDxm+5MGl33wr/NAt1FyiEPVczG1gNltT8bzefHqi26YuWqMKuuQL4Wmi51hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614569; c=relaxed/simple;
	bh=/+jV31PTgw6aqTRc8C6RU/6dvmmCJ1MpYAbbhnWUjPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1876vN2acDgv4nrBIJNe01fzHJde/H6sFOkHvUtR0XpoHdltWWec/eRH1nHRC+lD0zsjexwoqG8KZbhcbOS5fb5O98KZynHHpE4NbeuUmmCqkbqhGBT4Rz9nlgV5N4OSTCRzW4lJpc5nZkWw8Socd8CWKYdN+JVzPKuI4LlPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibhBt64B; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Mar 2025 09:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741614561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/YTv0hHn4G4Scu3ATutypohlkwvEToRHT1q3tOxv1M=;
	b=ibhBt64Bnx5dGjlh8qWaTtLQT4Lz408q33Aqcf4PYL8ztkoC3S5CZA7zWXODC5KvXuXmdT
	9acI5JMEQsAOzU2TBViyk45087/40QkzGXrXFWLUTTKl/CyuWlEbTO+qe0fe9/nFuycmqC
	rCRruIPipMxWkv0xrWwzHq0RQ2u3N/s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, linux-bcachefs@vger.kernel.org
Subject: Re: CVE-2025-21830: landlock: Handle weird files
Message-ID: <k7toamo7fd647262axepi5qut2axylrx4rew66jdlw5wmyog3h@3ivphkt2xkxr>
References: <2025030611-CVE-2025-21830-da64@gregkh>
 <20250310.ooshu9Cha2oo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310.ooshu9Cha2oo@digikod.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 10, 2025 at 01:00:50PM +0100, Mickaël Salaün wrote:
> Hi Greg,
> 
> FYI, I don't think this patch fixes a security issue.  If attackers can
> corrupt a filesystem, then they should already be able to harm the whole
> system.
> 
> The commit description might be a bit confusing, but from an access
> control point of view, the filesystem on which we spotted this issue
> (bcachefs) does not allow to open weird files (but they are still
> visible, hence this patch) and I guess it would be the same for other
> filesystems, right?  I'm not sure how a weird file could be used by user
> space.  See
> https://lore.kernel.org/all/Zpc46HEacI%2Fwd7Rg@dread.disaster.area/
> 
> The goal of this fix was mainly to not warn about a bcachefs issue (and
> avoid related syzkaller report for Landlock), and to harden Landlock in
> case other filesystems have this kind of bug.

Agreed - why was a CVE assigned?

