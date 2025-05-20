Return-Path: <linux-security-module+bounces-10073-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E9FABE616
	for <lists+linux-security-module@lfdr.de>; Tue, 20 May 2025 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FE41BC2B64
	for <lists+linux-security-module@lfdr.de>; Tue, 20 May 2025 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A725D8E6;
	Tue, 20 May 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S8qv0ptS"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9B242D89
	for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776691; cv=none; b=PMMr83K5/Rymp8g6cDG84RVQnjpELzPNfIq9vqoW03wkSAn5neXfqXc6epb0EADI3vLSpue97dTt0mmE/t2VwvMMrwXiNgcQiXtYGgSwA7LnnpZfsaXqkz/aKAOW2Kg0NNVyUt/x7Xwj7b+nOZBFCc3v1PlCTSRNmzZVCFplNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776691; c=relaxed/simple;
	bh=Rp/sSKtoxvD0xDJUL1ax9jsR8XaN1Db+UrRlq03guhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfmwZC1B2TgNlyD7SMxSB+TLjRzjd/cs1tgmoIoQ8U9dVHsAsp+aqN8/rTdU97G/H7HIBQqthIfgzKJMw0SvhiTIx2vVFwPh59kW5IooPOfoLZF1dAw/v9IzexdPYvbjXeoIkAaRsKpLKkBAUKoXMziMTUWyacWt1VimE+Blw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S8qv0ptS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5456774276.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747776688; x=1748381488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YexwMppYcbZe/m8aCqtTjf6L6bo5b6rZLX60EXLxJJM=;
        b=S8qv0ptS+qog4CXjQizT49B9eBq/MmCkIY1IMNxSyXdIxqlk0sxQVA1BqhkK/bwIgK
         O4S/DVWObFNCdXo44Bq1/CGkjk8OijwXVuD71UnHg36INVS81QBRvD/ZjEaOiupFg/0b
         m9VEwcA/yZzDm0AeC0g6qXNG/ZUYMSA4kAR8xObmtuWeljORdLY7BciHMBc8AoOZ9n35
         E4LRowUaRBt4Vlq7fJ6/5elJpHdlvDK0r2Rq4rdWbmkFlov2umkXFENBrWg3kSculIXX
         rPZKLrW+I17nJ8OqOlj1uxiRMcPg4k15n9QuFRfLxHNbl2PVnyIJYoH7kfZvyF5W2Mfr
         HrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776688; x=1748381488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YexwMppYcbZe/m8aCqtTjf6L6bo5b6rZLX60EXLxJJM=;
        b=PWmzzsi1IuaBmo0ElRyBhl8CAlBCOk38N0NJKT9vGTdlRmF6w5X71pAr5+FeIJm1jf
         fI38BpCok6U08K/jp6KEYNaFNtz2nIqdlcm5zPLSQfzuVtEp/T6Al29NiEJgTm9un0rz
         Bu0J+HMMWDg2D2j5NsTGQDnRWwIWZJ4DEdhgQo9JlUy1fplZqIy7sN5Fya37cwOlKkB9
         ErdDhCQtla4Z3t+sFNgwJU/ODasEvjx5HWxk4Jc8RwAmHqNh1ue+5c5i5t2Yj3O/zg4b
         kD/ohFCsWusD5c/SGbvZTZ4opAtfzno2xSZPmV+Uh5KpDmKTdOEJSah9vDKhFQbNKZ1F
         LdQA==
X-Forwarded-Encrypted: i=1; AJvYcCVFzTlUjmK/+1Jz9lN0/wg+MyfuuohtBvHS149dX2OKUJ26FK8OLwkBkk5IZfHlrEZEHY2U4IzKTiQLUj9D2146fw/P4Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjhvse6wNwpquivWPhTz3hhoaa7J2l4ZEma1UOneL8/j+Oeoa0
	2zlQtXZNqdczPb80mcsD5Ph5iD7SlPXGGTnX4GbOb0G2nSwZIGZqDYMHSWBijRtvtsDYu8BFcq8
	KUfqXgLx+HZEGrX/LZIQxFGnd6SUM24sIyMSCE/6z
X-Gm-Gg: ASbGncvn8ao7LJRU5mJHlcAOowBOVBPZrzNNMxnLk7213ag9R6b7Riro53ILIY0wpVn
	1pKnAalRtpV2Q+xD0w99W9oU3+c2FzaUC4xbTx6t9GzJYuwZvafYVXmPZoQmNvyX4SJeF74w+4E
	R9vvb6arnxkwtwbec1HKoSwDSl6UZTCyFD
X-Google-Smtp-Source: AGHT+IGZ/rtogvtb9mmq771rmbik+el6dyUZ8s9kwWv9ZNx2CrYoN2T0d4tY5zplAYSZmSb/J7/BxKaHsq01XwQ2/QQ=
X-Received: by 2002:a05:6902:6c12:b0:e7d:585d:6aac with SMTP id
 3f1490d57ef6-e7d585d6f25mr2740629276.39.1747776688624; Tue, 20 May 2025
 14:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 17:31:17 -0400
X-Gm-Features: AX0GCFsKbQqPlLe-FjaU6xxZxNkDN5cHZfC1VDbTRZv-QCv_QCmlg4xFRTHqelQ
Message-ID: <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This patch is relative to the one linked above, which in theory is on
> > vfs.fixes but doesn't appear to have been pushed when I looked.
> >
> >  fs/nfs/nfs4proc.c             | 10 ++++++----
> >  fs/xattr.c                    | 19 +++++++------------
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  net/socket.c                  | 17 +++++++----------
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  8 files changed, 40 insertions(+), 54 deletions(-)
>
> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> folks I can pull this into the LSM tree.

Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
on this patch?  It's a little late for the upcoming merge window, but
I'd like to merge this via the LSM tree after the merge window closes.

Link to the patch if you can't find it in your inbox:
https://lore.kernel.org/linux-security-module/20250428195022.24587-2-stephe=
n.smalley.work@gmail.com/

--
paul-moore.com

