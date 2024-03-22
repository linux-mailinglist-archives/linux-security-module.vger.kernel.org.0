Return-Path: <linux-security-module+bounces-2257-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58950886F60
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Mar 2024 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A16B1C220E8
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Mar 2024 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F74AEE4;
	Fri, 22 Mar 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nTYOAEIl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B74CE04
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119910; cv=none; b=l30suYL0/pvqezKhznTphvfCaH6SKJU2GTVRkkZ+uRJ3KWW3nPbQSfvlllKqZwo78eOp7VWjgQ/h4tRELYQdLfGeuDTS2IlTgPPl5+l/TvqY/H6JENDpYezur9+MjQDfDT8gRV9rf8Lz1a8LUgBD0p1hoWUMtcDzRAXiRjgOX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119910; c=relaxed/simple;
	bh=GjL/Jw7JCKXDujppAJ+MlTPIbb64SpYew+kVjwsZ0bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrQ1BXVZzYM37V0uCh6z0cdE157duj07h7w5AKs4sALdyfOmrh5xdU4bPdYz1owmzl3Fcy6slKmv15RgtputS4/qYX9efnpqxGmvbR3Uzca0oGfXrk6PUKlvMuSZKwnMB/m+873sf8JieLeM5h6btXXgzb4QHnBYDsE29Nyo7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nTYOAEIl; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V1Qbs26x7zPtK;
	Fri, 22 Mar 2024 16:04:57 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V1Qbr32gTztk;
	Fri, 22 Mar 2024 16:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711119897;
	bh=GjL/Jw7JCKXDujppAJ+MlTPIbb64SpYew+kVjwsZ0bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTYOAEIlOom3SjXJw0hLS+Xw7DH3TcwJ4Y2NBE0h947sk1arVFdpidkL6diFnhiHu
	 8nJAQL8rcaYXUE4vozgRcMjPb6519IWqpj3o6Zyju7Ev+2FWHMSGB1gXk/oTC7P/dh
	 ValSXAdXdq6XB6kHKlCxmaLCDLEf6g+2M659Aae8=
Date: Fri, 22 Mar 2024 16:04:55 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 6/9] selftests/landlock: Test IOCTLs on named pipes
Message-ID: <20240322.Eyi5ieg8oxae@digikod.net>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-7-gnoack@google.com>
 <20240322.axashie2ooJ1@digikod.net>
 <Zf2YO8LHm3Wi4aNu@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2YO8LHm3Wi4aNu@google.com>
X-Infomaniak-Routing: alpha

On Fri, Mar 22, 2024 at 03:39:55PM +0100, Günther Noack wrote:
> On Fri, Mar 22, 2024 at 08:48:29AM +0100, Mickaël Salaün wrote:
> > It might be interesting to create a layout with one file of each type
> > and use that for the IOCTL tests.
> 
> We have already written these tests and we can keep them, but I think that we
> only gain little additional confidence from testing non-device files.  The
> implementation is saying pretty directly that IOCTLs are permitted if the file
> is not a character or block device, at the top of the file_ioctl hook.  I don't
> see much value in testing this even more exhaustively and would like to keep it
> as it is for now.

OK, let's keep them for now, it's easy to remove a patch/commit.

