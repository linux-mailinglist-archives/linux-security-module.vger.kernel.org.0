Return-Path: <linux-security-module+bounces-14496-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OnFFdCKhGl43QMAu9opvQ
	(envelope-from <linux-security-module+bounces-14496-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Feb 2026 13:19:28 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E4F2553
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Feb 2026 13:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26563009F1F
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Feb 2026 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1833D3488;
	Thu,  5 Feb 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkNTiBNF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A03B8BCD
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293965; cv=none; b=Sz4P3EB5UCfGq2BpYO+0ngZYFwNBTfhvtdwsE05mcr21jhi8M5DhgPYB46XcG705xJ6/Mz6rKRMMwHXPAApfsYJOK7SdY4rcaVZQo/N0lhqPlmmrxNq4eNvIHNGwqOxEI02uK83JUI2jkrdZnRZMrFVMkizc3/h8PP9H0sT73MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293965; c=relaxed/simple;
	bh=jTOOlJM9SM62Nbi8NEcvFMVTGFfdGPEdNCXAy/8F3qY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofJHQ2r5fLD4UDkk88Atfu/3N9Lt5+/brtCUPkjivATinbmOPLnHhgVr1nSLorVXKz1a3yIaWh7KXvUhNuQidY1H0cq/2m3CWw5rK3IRB6V1PVPHT1Qnd6peCx5Nn11VAq+QawKzW9cOiUvQ9ppx0m3iX0g2PTxPaoDeE0mDjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkNTiBNF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483101623e9so10933605e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 04:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770293963; x=1770898763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8VHEdoXvHCSSaRGXtsdIdrKYHnRM+3rTei5HgbDzfs=;
        b=JkNTiBNFP0NFHqPYYcMXgk0uuWV5/J+ofqckOWsz4+E4ei9Uve4MZU276BLHV43qjh
         ElA+JWwKPMxbVdymu1gPlFQXT3J7HM0wZoUoISGrujvbObwR7X2XOpSiFRMBizSteOS4
         j/Z0Ei0GdW1xk4BsHZWs/42Ra7Y83bFUBFmAXBy3e5x+/zL5qz0M0upF/PJFlL8/yryZ
         RjqFQjewbYpvRNgll+M35BM4/43M2ivnwar6q7BkGby9ugQ9Jo3o995Q0FKlyQrdU35S
         MIiMYTfzMuAwZju3YDMSmD4cHkzPLzJUWy0uHa/IRM373Di+Y3l+DBeeNlhVGU3hhqqR
         lzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293963; x=1770898763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8VHEdoXvHCSSaRGXtsdIdrKYHnRM+3rTei5HgbDzfs=;
        b=w09Ets+3pDvZU2TNRZ9BRTUzj+EOyqfXrhYluF8Op9/3P4b9R7DqaP1qRh93e9dtXP
         G6c/8JIRvme14lU9QDMcdnMxg0/Zniw5rfb4WMKEFQFQFWuCYTankijjfYMpo886Nw07
         tCk8ShP/0XUAEDNPZJ48CrsTN5cvBQ50e3Nat5wM9wXuxRgBYGTq+f+dD7nu/hqLMQzY
         bZyezwdsDEII3aSgNvcUXUEGqQdQGn1OURfxZMO/lRzUlLjhV6a/YDmqhQZB/7uAVYtp
         GYPNYS8wFg9Z5vTnA675zS8iSbDWmTOMgK8NLoBVyMX0PcJ9f6+kt/7c95+f2E+1TPXk
         Tbrw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ST4EbbJqDAHuSj/fYaJhjIHZ/BOxjq4/dgvTfIzafVCtl3CUULEnvtx0eWpC54qfyuckb+0OLuQOlmJbRSsxqEPWBbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh++hUuGvMvEPHgThQqPFupDU2AhRl4bQAZlCOK/kGzWS1S3xj
	K4Z1NIxVYZRvEDcDRFM1SdRFVms56T0yoXm4FKP1a1aYQ/TaKHU1Ic/wXUwfQcxdw2nuq+DQwPI
	vne6FnTLzyUxJpRrpCw==
X-Received: from wmbgy21.prod.google.com ([2002:a05:600c:8815:b0:480:4a03:7b5a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4513:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-4830e97a05bmr85132145e9.33.1770293963417;
 Thu, 05 Feb 2026 04:19:23 -0800 (PST)
Date: Thu, 5 Feb 2026 12:19:22 +0000
In-Reply-To: <8856c839-1a94-4e4d-9ded-d3b1627cd2cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org> <aYSFyH-1kkW92M2N@google.com>
 <e7247f3e-8a88-4b46-91ba-cb73cce1346a@lucifer.local> <8856c839-1a94-4e4d-9ded-d3b1627cd2cc@kernel.org>
Message-ID: <aYSKyr7StGpGKNqW@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14496-lists,linux-security-module=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-security-module];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C69E4F2553
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:13:57PM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 13:10, Lorenzo Stoakes wrote:
> > On Thu, Feb 05, 2026 at 11:58:00AM +0000, Alice Ryhl wrote:
> > > On Thu, Feb 05, 2026 at 12:43:03PM +0100, David Hildenbrand (arm) wrote:
> > > > 
> > > > I don't expect anybody to set zap_details, but yeah, it could be abused.
> > > > It could be abused right now from anywhere else in the kernel
> > > > where we don't build as a module :)
> > > > 
> > > > Apparently we export a similar function in rust where we just removed the last parameter.
> > > 
> > > To clarify, said Rust function gets inlined into Rust Binder, so Rust
> > > Binder calls the zap_page_range_single() symbol directly.
> > 
> > Presumably only for things compiled into the kernel right?
> 
> Could Rust just use zap_vma_ptes() or does it want to zap things in VMAs
> that are not VM_PFNMAP?

The VMA is VM_MIXEDMAP, not VM_PFNMAP.

Alice

