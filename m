Return-Path: <linux-security-module+bounces-349-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB72807B93
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 23:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8030282386
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C36FA57
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A0FaZ5VP"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3274310C7
	for <linux-security-module@vger.kernel.org>; Wed,  6 Dec 2023 13:52:54 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so323495276.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Dec 2023 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701899573; x=1702504373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad4QKqllEurVWf/Pv2WnyL7sj04ktRUEA1KwimHLGBw=;
        b=A0FaZ5VPghmIMOFtE7VI5ktxGozz3Olwlubi9g38u8YjHjJ4FQqmsMbHx5O5owP402
         MCvGx1UDIadD/hB9HuYVtFRO/iIwo0dNq0lSiw4mz8KYluLoEdNgvKuQQgFIuh8Nv1eB
         kYposvN9K5OwVDmbRa3Gv9n912+wMYAeAfqA632ImawSese1WvEBzRAEmcBfENMmAHDE
         LJudlvpdo32+Q65nFFXz1GnhCjH075c+xgvoc/efJW9ZJesqy2nIpO9HcSJ8dBAPDRyQ
         yZGac/GZ9q3ZVNEXO8rmyC7iA0zgf+Vwi80FNnTTU73Q8ksqhIGRg/Y6vOxjZt64WSWi
         yKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899573; x=1702504373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad4QKqllEurVWf/Pv2WnyL7sj04ktRUEA1KwimHLGBw=;
        b=mPlklv0sNDF4yqL3QEQL36QeJGbgnck9s0n90YyZkBM+B7UwU3EcHR0TBZ+nr+xee/
         R2ndifyPgnSl6m8cHXxO8aTizzF9OsKd3JGONXCSTQ5Dk0iMOMcdP3Sd9EAt7CcpaSKu
         qjuIsjJBIJuEw2pejIVq/3x0vhZ4l7tFA6RRq01Vplp1TlTLo9DbzS8y73BXq62sNemJ
         tHbALg/Pu5oAtNo7za+VG3askejxI3KQUuKrTx9QFDhrm1rYqL8fmzAYUStpvQkPEknI
         nh00FqBhPMprML30HDNgDfCNzB2nF+/mO3mxniWPRMfYzkVSkkoQ524SPF7PF8oPfk+s
         7vnw==
X-Gm-Message-State: AOJu0Ywet/XPjtRt4RCawtwHHWsWasuX8BKNav0LNCJ+uLrJS2Y2jGws
	fHyl0N+QD+9YeZhU4jlcdnaSVHVLvIs/7Ab8gwgu
X-Google-Smtp-Source: AGHT+IEj7nPBQx69pTJuIU/DScLOgVaCvMx3IAuTkYQQJ5vMAh2Hehp1yFZ/6ct0anbgpUrLprVHp8nDNRkJVZqoN6c=
X-Received: by 2002:a25:ab66:0:b0:db7:98ba:2468 with SMTP id
 u93-20020a25ab66000000b00db798ba2468mr1505130ybi.28.1701899573074; Wed, 06
 Dec 2023 13:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206060629.2827226-1-david@fromorbit.com> <20231206060629.2827226-6-david@fromorbit.com>
In-Reply-To: <20231206060629.2827226-6-david@fromorbit.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Dec 2023 16:52:42 -0500
Message-ID: <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>
Subject: Re: [PATCH 05/11] selinux: use dlist for isec inode list
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev, 
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:07=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Because it's a horrible point of lock contention under heavily
> concurrent directory traversals...
>
>   - 12.14% d_instantiate
>      - 12.06% security_d_instantiate
>         - 12.13% selinux_d_instantiate
>            - 12.16% inode_doinit_with_dentry
>               - 15.45% _raw_spin_lock
>                  - do_raw_spin_lock
>                       14.68% __pv_queued_spin_lock_slowpath
>
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/dlock-list.h        |  9 ++++
>  security/selinux/hooks.c          | 72 +++++++++++++++----------------
>  security/selinux/include/objsec.h |  6 +--
>  3 files changed, 47 insertions(+), 40 deletions(-)

In the cover letter you talk about testing, but I didn't see any
mention of testing with SELinux enabled.  Given the lock contention
stats in the description above I'm going to assume you did test this
and pass along my ACK, but if you haven't tested the changes below
please do before sending this anywhere important.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

