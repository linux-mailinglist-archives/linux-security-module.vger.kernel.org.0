Return-Path: <linux-security-module+bounces-14217-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH9KA7Gqd2kZkAEAu9opvQ
	(envelope-from <linux-security-module+bounces-14217-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jan 2026 18:56:01 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE88BD09
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jan 2026 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89410301CFE5
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jan 2026 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917434BA3B;
	Mon, 26 Jan 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPwhaQYY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955234D390
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450156; cv=none; b=IgC++u+J7auAvcjAFT81bj3+7hvvUhuVAfrgZTr+ftRNlvzU4yRjJRnY90mHbAx8vOn0An8yCo4G83Bmn6qZxtQg046GiCgtVxn7EZPlA5c5n6K5i/N/rUhxLt6PbjBm8OcDq8LUgmTo4qwLERbT20foUbF9mSJmTxK0w0TpcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450156; c=relaxed/simple;
	bh=W9DRjOPAVpHjT2O1j9oUr2MBPeqq6bmnMBBGGuZlkgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyk4Jlf2KlnK8ANLP0wgNZ0BrA2oyWFYdcHeWBNk2P/5DQ0ioLadeWKMLdJ8XlOQMJ86/uzpnCHDSqFSvL7CcgIsWmANIQW72BSIynDC4dzfyUrbb0jNAMoRHm/kTiTTpegB9h8ZbktHEB8eqQi9GblAPs6aI6m4DkUpZPl4x1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VPwhaQYY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NrtTHT1WuCqdftMCpD7Z34eSW1yX4kdbcp00nY35cbI=; b=VPwhaQYY8QOUhwqoXUCwLNVBzY
	KHIQSFuZIzNBGwCHjlrI1Zos/j7DpDToS+TOOG6R3sZQuRU9E1uPYE3qwrSPQTBuOLrCcqVEq+Ma5
	hPMAbbg/iEKisVUbPVhVgrINLB4Lbrjy5IndxnuBoilRaQu2/tHJtqW6FYRY2U+Rsv2478CS4inty
	iCAKdwyoAhkpChS87icqaw2tDgyGKgkae0tTnBa3Vzl8gRLrwarcLP1wTYyxc6BFMDp+LfF/Y+XBu
	Dwc9u8/cxwrpc0EeyhgLXe0fVk4Aqr7oqUI7YXMAVoTsg4dOndOywnwOkRONRLpnYOciH6Iu9Y5wi
	7RaBQVPw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkQoV-0000000D1QR-2R9n;
	Mon, 26 Jan 2026 17:55:49 +0000
Message-ID: <d75185de-d8e8-475c-be57-9100ddd2d9fc@infradead.org>
Date: Mon, 26 Jan 2026 09:55:46 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Justin Suess <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org>
 <20260126.fd8c7b7537e1@gnoack.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260126.fd8c7b7537e1@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14217-lists,linux-security-module=lfdr.de];
	FREEMAIL_CC(0.00)[digikod.net,vger.kernel.org,maowtm.org,gmail.com,oracle.com,buffet.re,huawei-partners.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77EE88BD09
X-Rspamd-Action: no action



On 1/26/26 8:52 AM, Günther Noack wrote:
> On Sun, Jan 25, 2026 at 02:02:50PM -0800, Randy Dunlap wrote:
>> The first line here is confusing: "in @rule in @masks"
>> Maybe:
>>
>> On 1/25/26 11:58 AM, Günther Noack wrote:
>>> +/**
>>> + * landlock_unmask_layers - Cross off access rights granted in @rule in @masks
>>
>>                              - Update (or Remove) access rights in @masks that are
>>                                granted in @rules
>>
>> ?
> 
> Thanks, that is a better wording indeed.
> 
> Will be included in next patch set version,
> I think this is less grammatically ambiguous:
> 
> - * landlock_unmask_layers - Cross off access rights granted in @rule in @masks
> + * landlock_unmask_layers - Remove the access rights in @masks
> + *                          which are granted in @rule
> 

Ack, that's good. Thanks.

-- 
~Randy


