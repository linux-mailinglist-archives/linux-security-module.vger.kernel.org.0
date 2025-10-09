Return-Path: <linux-security-module+bounces-12347-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8671BC94D1
	for <lists+linux-security-module@lfdr.de>; Thu, 09 Oct 2025 15:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFC319E83CD
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Oct 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86DE55A;
	Thu,  9 Oct 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgQorJjI"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773612E8B6C
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016608; cv=none; b=AYQ/I4fRjcSfBgLvfCyuf3TL9by6cRPb0deapkwIlMQfkMFfgnDpf0OOnIyob80IuhsNWKKlZERC0n23ODvNLfdD7PFWIIMyGurdW7ljPoc32O9zLY5cRSnL9FQqOzwNEpwvJpnJL3+DNnGC1auffA9q1LIm0lP0yt+opw3H9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016608; c=relaxed/simple;
	bh=hlfDrzZ4vQCNg2o/4wFzb/lT3BMxHUYVrByGrDbetes=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lcU1BTp2DAPNp9K2AGUSQJpGfPRSy6Td9Bl5/vnifKZVln54mq/J5M71rI9M6yqyPWKgjVbio90p59FAZLfBACCZVFedUqHxBDlr+kzrhlqt0fq16buVdIvfE+2UX6cqxbbSbSpOqUtuYP4SXGprnN8oyJj1/Gf8/IE/468ZKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgQorJjI; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760016604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDbZw4EkKYByMngi5LsLiYm57ZTPBi4akhsxsRB/1tg=;
	b=LgQorJjId+FUsLqkSr3f4CIiuB+kBhFpT4Ebdxf0RCiNMd+UfkpPO0vRAnBAq5u7L24Lvy
	S7E5pszTaHZ94b3igvWNd37B2TMuFc/T12pxGyiLwVQd8Yl16L5xdJyO6W4ty+FhnYzvR7
	VRS4gMxUxW+Yp5ZmCS3jHYPoRwE2vq0=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] KEYS: encrypted: Use designated initializers for
 match_table_t structs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <9e7488652ab73d7c5c2f93ea3c68253a9f08cd82.camel@HansenPartnership.com>
Date: Thu, 9 Oct 2025 15:30:00 +0200
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <93D80E9A-7CBC-40D1-BC21-7BC2BB465AC4@linux.dev>
References: <20251009115817.368170-2-thorsten.blum@linux.dev>
 <9e7488652ab73d7c5c2f93ea3c68253a9f08cd82.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On 9. Oct 2025, at 14:44, James Bottomley wrote:
> On Thu, 2025-10-09 at 13:58 +0200, Thorsten Blum wrote:
>> Use designated initializers for 'key_format_tokens' and 'key_tokens'
>> to allow struct fields to be reordered more easily
> 
> How does it improve that?  The key,value pairs are surrounded by braces
> so we just cut and paste the lot anyway.

Using designated initializers (especially for global structs) allows the
fields of struct match_token from linux/parser.h to be reordered or
extended more easily, improving overall maintainability.

>> and to improve readability.
> 
> I don't think I agree with this when looking through the code,
> especially because this is the way it's done for *every* option in the
> entire key subsystem.  So firstly I really don't think it's helpful for
> only encrypted keys to be different from everything else and secondly
> when I read the code (as I often do to figure out what the options
> mean), the additional .token and .pattern just get in the way of what
> I'm looking for.

I just stumbled upon this and didn't check any other files.

I do think it helps with readability, especially for people unfamiliar
with the code. With designated initializers, it's clear what each value
represents without having to look up the definition of 'match_token' in
linux/parser.h.

Thanks,
Thorsten


