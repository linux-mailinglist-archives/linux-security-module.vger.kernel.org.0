Return-Path: <linux-security-module+bounces-15375-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JrCC6IUrWk/yAEAu9opvQ
	(envelope-from <linux-security-module+bounces-15375-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sun, 08 Mar 2026 07:18:10 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BD22EAAB
	for <lists+linux-security-module@lfdr.de>; Sun, 08 Mar 2026 07:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88628300DF41
	for <lists+linux-security-module@lfdr.de>; Sun,  8 Mar 2026 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B862281341;
	Sun,  8 Mar 2026 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFyzSWVe"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F38223DD4;
	Sun,  8 Mar 2026 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772950685; cv=none; b=jHmZ62wqD75lPmSzDsYpAF2I6LFbJEOpIdwyP97IxFmJnhhih+PlepongjcQggdzxrng2VnE6eXX2eMFURjJxbmRLgupxeG5I0ZHZ302vOiFjah+pgovl3sFNEq36kSgJw2GiBIFeLzvwhrEPvETpM3Xvs0hN/x1fXjc6dYcAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772950685; c=relaxed/simple;
	bh=nxAaiERwZRrbVoEFkZA/7woi/LV8Zt7JAJGA+8I38KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8L/N8BalqMUOPGpJXStiNaIfZZgA9LgEB57yntO8pmToUnP9iGF4eYJxMQOGRMyCqPD3fH0WTEq17hhWoSTLKFs5cJFEkE1xXINleHe6vCb7//xTz3Ie+JQ/TM19FB5Im74YBX+dyg6R1b28k5dQW9cP5sMCsJ2NPhIcQu7l7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gFyzSWVe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ORPcHXXFNh87t6JQ0B6TXMdPhRtKhPzVdV8C17u1nHc=; b=gFyzSWVePuJYNCQBca3poQGPHR
	xZfweotaR5MxofirdJPy1NduiA4S87tTeWIKC7uzhkRIPcwDcBDMYGcbRZO76ukpLjKoWJ4qi7g9Y
	fiWpOEVwIWpnv+1/HRzs1BYEii4jarkruDDXfisBQ1HaanrcHWqZQWPvvlAcN3/epecl577+7qPZo
	dN7knZ3CrhNlLUVCGxvSSeuDlE6jqAdKOHAcpWLwHqIVxXMnTY0E7YC5fJcEz7gFwOrF2o8VGQ7kN
	Kv16685EU82mNdimsgOq70EZhneGh1f3hCHaVfE+YlmkDiw5rOV2SEvkg41wNXl4Pku8cRVyg4FaI
	oJSSXrPg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vz7Sf-00000005ksQ-2rNs;
	Sun, 08 Mar 2026 06:17:58 +0000
Message-ID: <54d71465-349a-491c-9488-d779a79bf3f5@infradead.org>
Date: Sat, 7 Mar 2026 22:17:56 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: security: ipe: fix typos and grammar
To: Evan Ducas <evan.j.ducas@gmail.com>, wufan@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260308031633.28890-1-evan.j.ducas@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260308031633.28890-1-evan.j.ducas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 300BD22EAAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lwn.net,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-15375-lists,linux-security-module=lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-security-module@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi,

On 3/7/26 7:16 PM, Evan Ducas wrote:
> @@ -235,7 +235,7 @@ Updatable, Rebootless Policy
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  As requirements change over time (vulnerabilities are found in previously
> -trusted applications, keys roll, etcetera). Updating a kernel to change the
> +trusted applications, keys roll, etcetera). Updating a kernel to change to

What is the first sentence in the paragraph above?
Maybe s/. U/, u/ ?

>  meet those security goals is not always a suitable option, as updates are not
>  always risk-free, and blocking a security update leaves systems vulnerable.
>  This means IPE requires a policy that can be completely updated (allowing

-- 
~Randy


