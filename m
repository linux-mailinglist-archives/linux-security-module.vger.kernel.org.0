Return-Path: <linux-security-module+bounces-14539-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKTbHh+ZhWmUDwQAu9opvQ
	(envelope-from <linux-security-module+bounces-14539-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Fri, 06 Feb 2026 08:32:47 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBABFB051
	for <lists+linux-security-module@lfdr.de>; Fri, 06 Feb 2026 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DE4E300A583
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Feb 2026 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834343101AA;
	Fri,  6 Feb 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6k44sk"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789D30FC0B
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363133; cv=none; b=plnNfG8/0Ll6Si6SPGXlboapj3H2BGunppN6YM97BuulZBR73AcRf/FF/hy+BD+/Vd+xaFdXa9Vo2S5JrDTV4DmeIhE+rfIIZUtACsdwqpOJTXyRlzrrtVZgKkxrUFZN2RMbpITqOiJr9jw661ds0cPJCDtD3SGpfcHdaRVKuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363133; c=relaxed/simple;
	bh=p8cng55a+4iKLK4lOtDyIEYdWlCWqEUFZ7vCQ43TCts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRE2Nw5yLbnHkC1HxGFUZlGsjBbZaBzfgRrtNeMsHX6iUBuSh5fYVyCe2o2n85ptvmrnXOqNxrX/IwNH8LNHEoxLVV4TlYMRz4lJaTNVqc9eTc6JULhsndhMNm66GmNTjFfcyg5WMyTOAEr4LRdayVz9qqyZmQCZsoMeHRvC74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6k44sk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee07570deso2884935e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770363131; x=1770967931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6uPHzwizm43O9+oSN/6Zv24/3lf0JzVWUDy+YUjNAE=;
        b=Ud6k44sk7RDKPJapgIOuhhMa8thKmNXwFyIj1f6V+iKbDW9zSdMzqR40iXTjHDXLfK
         sQvnNnqJ4l7KChkBc9eQdex2IVkQhU7WnL4wfKmlIRHPm7mf5LGVVO7u26yfK1UdHyqK
         CHau6BLDjPeWF90g+urxVHuQWaK7nfRIkbhMNMGVlxwxL+VPFegdL/uzSH6GbL1A7hjH
         TurJYZGrdf6tYv3olDrLLfIJ4goNEryQyww/jgx4wOTNxzA8DZoItPxVsTTnxnawFKnX
         sEvL/HxAhmdLOBwG9U+ZhSDha17IGoHltLAD+mkRNu7JJnlMBVH6EVV9nx3ttlsEPzYi
         Nzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363131; x=1770967931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6uPHzwizm43O9+oSN/6Zv24/3lf0JzVWUDy+YUjNAE=;
        b=YXoKfF4FjEzUck+aszd/S9GAq9CHS75gYzYK1zrqgHl1anC4w8pIxV/sdophvg4pEo
         GGNen41dqpUnnIUxoyGkO1t4bNiHspC/AN8JeEPMYkrtRi0VnbFq/38uktigk1baWw66
         cgc+jsInplu/pk0QG5HAAC88PJOMc2hWJlO0C7+Cc3eeJmEmEGSLGs9zD3KzRZh2YLp4
         Nfdgdwm1BMCp105M3JnBF7prwtRmgRj81yFtu4NN0LJ9zsgymR5oj5dQ+0rKA4+hZx1z
         3VRbnHC91sqAoNGfsbfWrkSrVoFWrSGo2IcZj2fjCtZowO/lS+jPLRPk4B2UnIKHNRlx
         fzoQ==
X-Gm-Message-State: AOJu0Yz3Oio/xz0w0RXCmZ6FlIuWgoT4yYF3jS5qoXFoLrPoovGPkjBA
	7uydZe/Cd3BfN+pTFuuwU9v0gYhdU1ZcAo7J+ucbOHl4VfvauSllcTzm
X-Gm-Gg: AZuq6aJc/Uz+IzMEs8DZJNfYM2his262QWPzYpOPjv0oym0BSFba8u87AJJUDAmECAq
	h9BbkK8BZWh/CihzEvAHNRlLTQbuBnuQ7OTeUEn0X407LIUMXOFg58v5REq5WIlmMdncoMCwrU1
	KSdhfFFYNwtMMEHyBn/faP9DCXsRzqZxtUvNeG/VfN+8Fe1ZaGv7UV/+U3d9R+sP4uhSoKOs/oR
	FV/GyLNJGSeSM40tWuAOUqfRh1PsQqtikEn2DA2TWwvunBCjdTA5TAJ/vn/vR1DZ9CJi19IONZs
	WQ/0DaLA/v7C8GvaHxdnoAOWx1WAOOmyiJgiUIVUDeiqmJwMYcevIeM0/IrUHtH9Lr7N+VP3i6t
	IU9rHqbXMxfi7Qk8xXtOyc1WVjcTE78exWTSJ8pnHRivrRF/45Jp50oetdvmt6M2D43Knrx0/D1
	bB6nJCRTp58Vt966iAxVsbhhL+7JAlxWOwvS5d
X-Received: by 2002:a05:600c:354f:b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-48320212babmr18662125e9.20.1770363131215;
        Thu, 05 Feb 2026 23:32:11 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm99804145e9.2.2026.02.05.23.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:32:10 -0800 (PST)
Date: Fri, 6 Feb 2026 08:32:06 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/3] landlock: Refactor layer masks
Message-ID: <20260206.9509420815f5@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260128.jiethoh2Zeem@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128.jiethoh2Zeem@digikod.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,maowtm.org,gmail.com,oracle.com,buffet.re,huawei-partners.com,huawei.com,infradead.org];
	TAGGED_FROM(0.00)[bounces-14539-lists,linux-security-module=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DBABFB051
X-Rspamd-Action: no action

Hello!

On Wed, Jan 28, 2026 at 10:31:07PM +0100, Mickaël Salaün wrote:
> On Sun, Jan 25, 2026 at 08:58:50PM +0100, Günther Noack wrote:
> > P.S.: I am open to suggestions on what the "layer masks" variables
> > should be called, because the name "layer masks" might be less
> > appropriate after this change.  I have not fixed up the name
> > everywhere because fixing up the code took priority for now.
> 
> Could you please clarify your thoughts and explain why this name might
> not be appropriate anymore?  Any list of name proposals?
> 
> If we rename the variables, this should be done in the same refactoring
> patch.

When this was an array of layer_mask_t, the name layer_masks was a
description of that underlying data type.  Now that we have removed
the layer_mask_t datatype, it is not as obviously true any more.

When trying to name these variables after the "role" that they have in
their declaration context, I think of them as "unfulfilled per-layer
access requests", but that strikes me as a bit long.

For the upcoming patch set, I'm leaning towards naming these variables
just "masks", to keep it short.


> > Changes since previous versions:
> > 
> > V2: (This patch set)
> > 
> > * Remove the refactoring around the deny_mask_t type,
> >   it is better to send that as a separate patch (mic review)
> 
> Feel free to include the new dedicated patch in this series.

I'm afraid that this one did not get any further than what it already
was, and I'll have to leave it out for now.  But I have it on my TODO
list.

–Günther

