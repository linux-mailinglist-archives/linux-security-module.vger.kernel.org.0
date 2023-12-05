Return-Path: <linux-security-module+bounces-296-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3318048A6
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Dec 2023 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B8B2079F
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Dec 2023 04:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99929D278
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Dec 2023 04:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5NTyIbk"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473729C
	for <linux-security-module@vger.kernel.org>; Mon,  4 Dec 2023 20:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701749677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCXWaTK2cT20XJ2gH5tKnNoHz1rvmd5jnRMvdwguqmM=;
	b=g5NTyIbkCmRfGKTZAb6jboDO85HY0LiF3H/ay9JQX0b7erAAUCCpqRaAREFBud30bE57r3
	CMguK2AI6Nnd6ASER4YGKWvEilGOenetAJlf5uRZfZJUX/2dyHFbKT7RhSJHqYkcSDscym
	2l01mLiuS2/2J9Qd9d2m0BD1sdlCaCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-TNjQEJEQNHGBd5ntzJrjVA-1; Mon,
 04 Dec 2023 23:14:33 -0500
X-MC-Unique: TNjQEJEQNHGBd5ntzJrjVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E15F73C0BE2E;
	Tue,  5 Dec 2023 04:14:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2104C2166B27;
	Tue,  5 Dec 2023 04:14:26 +0000 (UTC)
Date: Tue, 5 Dec 2023 12:14:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW6jjiq9wXHm5d10@fedora>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4hM0H6pjbCpIg9@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Dec 04, 2023 at 11:57:55AM -0700, Keith Busch wrote:
> On Mon, Dec 04, 2023 at 01:40:58PM -0500, Jeff Moyer wrote:
> > I added a CC: linux-security-module@vger
> > Keith Busch <kbusch@meta.com> writes:
> > > From: Keith Busch <kbusch@kernel.org>
> > >
> > > The uring_cmd operation is often used for privileged actions, so drivers
> > > subscribing to this interface check capable() for each command. The
> > > capable() function is not fast path friendly for many kernel configs,
> > > and this can really harm performance. Stash the capable sys admin
> > > attribute in the io_uring context and set a new issue_flag for the
> > > uring_cmd interface.
> > 
> > I have a few questions.  What privileged actions are performance
> > sensitive? I would hope that anything requiring privileges would not
> > be in a fast path (but clearly that's not the case).
> 
> Protocol specifics that don't have a generic equivalent. For example,
> NVMe FDP is reachable only through the uring_cmd and ioctl interfaces,
> but you use it like normal reads and writes so has to be as fast as the
> generic interfaces.

But normal read/write pt command doesn't require ADMIN any more since 
commit 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands"),
why do you have to pay the cost of checking capable(CAP_SYS_ADMIN)?


Thanks, 
Ming


