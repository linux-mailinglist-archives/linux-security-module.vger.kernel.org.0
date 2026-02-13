Return-Path: <linux-security-module+bounces-14665-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBLcMJwuj2nTLgEAu9opvQ
	(envelope-from <linux-security-module+bounces-14665-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Feb 2026 15:01:00 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EB136D7D
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Feb 2026 15:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02AF73061750
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Feb 2026 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC5360722;
	Fri, 13 Feb 2026 13:59:59 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C021684BE;
	Fri, 13 Feb 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991199; cv=none; b=XeieFXyb/pg3oxVumzvv2Q8I5Qhsq+PzV/io4XgQ36rfMsoQ74ssUX1lO28WrjgG2uHAx5wG2emnR9wZygZJ8M3wv+JHewCFDdXezF9eabrzdceqvD5A41fIa+WtvN+e/A0GswGj+kErab19t3Mcy/n8YH9yKQuw7f9dUI40b+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991199; c=relaxed/simple;
	bh=oIITJHToT3jgpyMYTOKivfMG2iGdep9oSi1Q7sfvBzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmXFAOsZsFWhD+9m2mYRC/FQzerOR/vkML9iXi8vgm9h2aOnh8Qm9cu6esSnTBXIDf0izxDuRnZYlxDDcg2ymZupNu51G9zI7Wd1RCxHfM/ECYPQZsgPLUGisGlxzZW5ocEY31ktC88DR5CNcj/y+jmhnFvA7ESoFZuRQY4A21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61DDxGKm000148;
	Fri, 13 Feb 2026 22:59:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61DDxGgJ000145
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Feb 2026 22:59:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d20f1b63-714f-48ba-9bee-cd074205404f@I-love.SAKURA.ne.jp>
Date: Fri, 13 Feb 2026 22:59:15 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com>
 <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
 <aYnDWbxo-jAzR4ca@secunet.com>
 <7c17884d-dbf1-4c2c-9813-0c5369cfdcc9@I-love.SAKURA.ne.jp>
 <aY76t_xYCHmLq6Ur@secunet.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aY76t_xYCHmLq6Ur@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[I-love.SAKURA.ne.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-14665-lists,linux-security-module=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4C9EB136D7D
X-Rspamd-Action: no action

On 2026/02/13 19:19, Steffen Klassert wrote:
On 2026/02/13 19:19, Steffen Klassert wrote:
>> The NETDEV_UNREGISTER path can be triggered by just doing "unshare -n ip addr show"
>> (i.e. implicit cleanup of a network namespace due to termination of init process in
>> that namespace). We are not allowed to reject the cleanup_net() route.
> 
> And here we come to the other problem I mentioned. When a LSM policy
> rejects to flush the xfrm states and policies on network namespace
> exit, we leak all the xfrm states and policies in that namespace.
> Here we have no other option, we must flush the xfrm states and
> policies regardless of any LSM policy. This can be fixed with
> something like that:

This something is what I explained at
https://lkml.kernel.org/r/1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp .
The "task_valid" argument does not always reflect whether LSM policy can reject or not.

Anyway, the patch to add xfrm_dev_unregister(dev) seems OK if we do like
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?h=next-20260123&id=fc0f090e41e652d158f946c616cdd82baed3c8f4 ?


