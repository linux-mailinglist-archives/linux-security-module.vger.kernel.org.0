Return-Path: <linux-security-module+bounces-6726-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC89D4915
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Nov 2024 09:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03027282D04
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Nov 2024 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C151CB320;
	Thu, 21 Nov 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OUxGPnmh"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CB158D79
	for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178605; cv=none; b=h6qHanwvnSrep8B47PG6poNwyEGnC31RuKnMt5TAU0amecrUgclZR92gQ10QziLyImmzb8EtCAqiCrX4K+pOshi14lZROJPSJM+2zh7WV2HfDL/5Coe5nVg2NLzc/pQjXi3YKBrtOxeo3ArXlvIzx8m5MpBDd0lujTOuk2X9Y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178605; c=relaxed/simple;
	bh=8MYhJTbJ7F4usSFmd0mps/eCDIHG/TRkGxMTXjlpUuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZdfUf0bpn9H9CzpdIVHbh0cjwq5XRSANipydT3zYKXMbCL4wAvawnG+MF7RHDeQZyPm1NKJUkzU4WrJTJIJ/jyrG8MyE/0/BYdwO6AtVGmHWDvfucmCHTtVN7ZwlX8XkHqvDjp8xCT/nt/fxgOa4dWDcNtlUer4zo4lgCGNDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OUxGPnmh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382296631f1so413375f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2024 00:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732178602; x=1732783402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLSsZ5JOZPvpqG/LZBTATMNgJ0P8sq7dJjWcV7/MSNs=;
        b=OUxGPnmhszi9+s2zlkVFjOjItVjRFc8h7vJyW0x+6CIBllJ1LYAb+ncSzzUrv2qjS5
         uopUfpKJ9UsdjLz9rrqadaGLmadcgoiNqrxNaxrHhw0BlqHNzvXhijQsxIEpTlaxepXP
         Yn8G5nJJTWe3qqJ+bud3HkdZqtWzMEtCRqFdl7gnTqbMoW+dfirFLA3XJHopnm2DkV1V
         BfWAROzd2sZzhbX2hnzUo9Zpho7Z5Zjcfaq18UdTmGGGF15Q4CwLUVzNZiZAywmCOUoL
         cIDpX8L/sy3hMePe3uka15eAqtWQuZmYemtLxWpll2hHma/hkY3Y2eiFLFGZtiAV2Tly
         LtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178602; x=1732783402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLSsZ5JOZPvpqG/LZBTATMNgJ0P8sq7dJjWcV7/MSNs=;
        b=i4zbuVGVgwDP9NuHZrUDi4amlHUC6ZqEOd7YTXS0aKPbl/P46yrRmilWwdW6YqfDQg
         orVmfGk7DYMNCUwMKt3VO0edgxafgoxyJjqLy40aXj5ch0PUAtXsbsWlaohv4TRq6AwD
         Nv1e2YDVTS7YiJEHZ/Xv0b4c8DAwZ7rpB/yATQmqi1BVMoNiVdjIpuNjMM4za6i6lGt8
         JG8OV8geYuCdmKNrsmHTLhRdRS85RcCqJE7MqFf/I92zfnCm9aeMdNgNxVyPNQRs13z2
         FsH8m5dNHexx4BQwp06vEVKd6WMUn75Uy1pG0ClsLJbcsuNrPnDdyh+i9RdtKgdlRQqA
         E+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW45OfnZZcGpwAfc2eEzMRXo+De8qD0Tmz5o1jWW81+CwTK8DZ6bjGXM5amcO9RQuUcg2qgDETOx78+9doi144FVRnOi8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9XAGyzxEz+0j9vwG7fr3lCnnfimBp+8TXPebCoEJ7+HkG9T/
	miD4t1dFVlsljE8D1ECeMyk6XxclhsGtU7ozFGims204meAkjQyH+DvNuDfd3YPnn6e7DWxYyYs
	S
X-Gm-Gg: ASbGncs9CPoXrBdISa2oWY4BdMQqKaMmJIwgae58hNW2/UAS4hEWeyRwfdWQY0LU73b
	rz9oeWuulW+FtqRyoptJx+OxUzeXUl0ki8p3VROVyblkM6soRWCOq8ssSdoNGsf4JZ5nzfCZZoJ
	A3IN7c2GvtFQnSPiMc6b2ltE+XmkqiLYS2cUVVUZTwdMpVfeEgKmk62Fb4WSdIfgxDGBnbzzNj5
	+f/YnW1qycPLHqdFYr1YCs6vgu06VFvdjr9TFJ7
X-Google-Smtp-Source: AGHT+IFpzheFe8Pg8r0thIYlyEIejMxQZNthE+3ERMHDXChvRhZ7QOfLnjgXRaCi9TO530mI1wAQ6Q==
X-Received: by 2002:a05:6000:154c:b0:382:359f:5333 with SMTP id ffacd0b85a97d-38254af5268mr4115907f8f.22.1732178601810;
        Thu, 21 Nov 2024 00:43:21 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490ca19sm4207193f8f.39.2024.11.21.00.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:43:21 -0800 (PST)
Date: Thu, 21 Nov 2024 09:43:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>
Subject: review process (was: underalated stuff)
Message-ID: <Zz7yqeI0RatH4ao5@tiehlicka>
References: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>

On Wed 20-11-24 17:39:09, Kent Overstreet wrote:
> Michal's (as well as Steve's) behaviour in the memory allocation
> profiling review process was, in my view, unacceptable (this included
> such things as crashing our LSF presentation with ideas they'd come up
> with that morning, and persistent dismissive axegrinding on the list).
> The project was nearly killed because of his inability to listen to the
> reasons for a design and being stubbornly stuck on his right to be heard
> as the maintainer.

Couple of entry points that might be helful for that.
https://lore.kernel.org/all/YxBc1xuGbB36f8zC@dhcp22.suse.cz/
I have expressed my concerns and set expectations to move the
work forward. I've had couple of back and forth with Suren about
specifics of overhead assumptions from the stack unwinding IIRC. 

For the first non-RFC version my feedback was
https://lore.kernel.org/all/ZFIMaflxeHS3uR%2FA@dhcp22.suse.cz/#t
not really "maintenance burden only" but a request to show that alternative
approaches have been explored. It was not particularly helpful that you
had expected tracing people would implement the feature for you.
https://lore.kernel.org/all/20230503092128.1a120845@gandalf.local.home/
Other people have also expressed that this is not completely impossible
https://lore.kernel.org/all/ZFKNZZwC8EUbOLMv@slm.duckdns.org/
The rest of the email thread is mostly a combat zone that I have avoided
participating as much as possible.

I didn't have any reaction to v2 at all.

v3 was aiming to be merged and I've stepped up as there was no single
review at the time https://lore.kernel.org/all/Zctfa2DvmlTYSfe8@tiehlicka/

I admit that I was really open that I do not like the solution and I've
said reasons for that. Allocator APIs have always been a large mess of
macros, static inlines that makes it really far from free to maintain
and alternative ways should be considered before going that route.

I was also clear that support by MM people was necessary to get this
merged. I have explicitly _not_ NAKed the series and backed off for you
guys to gain that support. 

So essentially there was a clear outline for you and Sure how to achieve
that.

I would really like to hear from other maintainers. Is tnis really
unacceptable maintainer behavior? I am OK to apologize but the above is
in line of my understanding of how to ack properly.

[...]

> Next up, PF_MEMALLOC_NORECLAIM over Michal's nack - I was wrong there, I
> only did it because it really seemed to me that Michal was axe grinding
> against _anything_ I was posting, but I still shouldn't have and that
> was more serious infraction in my view; that sort of thing causes a real
> loss of trust, and no I will not do it again.

Yes, this is simply unacceptable! Just to put full context. We are
talking about eab0af905bfc ("mm: introduce PF_MEMALLOC_NORECLAIM,
PF_MEMALLOC_NOWARN"). I have pushed back on that https://lore.kernel.org/all/Zbu_yyChbCO6b2Lj@tiehlicka/
Rather than searching for support elsewhere you have completely bypassed
the whole MM community including Andrew and pushed that hidden in
bcachefs PR. This is breaking trust model we are all relying on.

I am cutting the rest of as something that is not really material to
maintainership discussion.
-- 
Michal Hocko
SUSE Labs

