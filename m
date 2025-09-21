Return-Path: <linux-security-module+bounces-12113-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909EB8E339
	for <lists+linux-security-module@lfdr.de>; Sun, 21 Sep 2025 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E338917B23A
	for <lists+linux-security-module@lfdr.de>; Sun, 21 Sep 2025 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA31137C52;
	Sun, 21 Sep 2025 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I0h33vmx"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F34A0A
	for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479511; cv=none; b=UIVCrcdNua4YLFMkiWE42VEcnQPSCEhLXuqg4iSQzcEOD40rTSQdMR/4w3SJSKf7Mh/M9LZpD93db5w5B1n8T9a+MbO0uovEr5+8V/gAxX+NumRss6zCITJLZrHgBAYoN+3ObOnDeunKXsc4C11Mz+7zICAb4hXpLE/F2M/tKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479511; c=relaxed/simple;
	bh=0ff7v6ofXHs04ewkG4XjpRmVfBhbGpj5fhVoGSlROmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeqTIJG/rQf6eEPw5WwuLiQMqED1j+YUpq6pDF9Oa8c3uSpM8rqBwYPQ+hJAjpalrKcWRM4oigvo2Gpk6nB+SUIW9I5Mot95UHQis9ghI4OXXm6EuKoaHxFkXNNMakQ9O3mGeTDVNnRYEDh7wWNNYfWgxbFyWILF/W1bQ7h6vYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I0h33vmx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24457f581aeso36289125ad.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758479509; x=1759084309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5bmmxR03oGGFi4aRvD/c+yECGqZ+0Eg8A/9OXcVnoA=;
        b=I0h33vmxCM+rsqDL+elAqDY7r6lRzRDPM0oY9/QY1RGTXTs+MM6OCZDMTmTfa03NAb
         kB/vrRYb2RebUISQh4+fpS1E2vU20YCjwnLeG2A7vDPFOv5juXOYfZ53f6LgL9PWRTr3
         HAVzB+JiLLlhvh0rzxmgq5ktEM2mtBrLv8/o/v9kZg8SwbKrLWeAKumMyLASIbKpf2CX
         9DrbDGQYeYxo5AQ6wxtGAEqOqtEfO8o8tZKaBSIoYU7Auwd/yslTUchTByeJWyEuRw2x
         2H5zIUAKMcyCvd2ogxv/DLpN15LGEvua/FECcYPFDsP8PJadyG+cW8QOM6cGayEuN2je
         CRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479509; x=1759084309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5bmmxR03oGGFi4aRvD/c+yECGqZ+0Eg8A/9OXcVnoA=;
        b=JM5+MOs2AiSXIf5+DLtAodO6pN/H2lV1nLWvVLCldvMR52nDT5HTvaDYTc3hxJmCTe
         R2HCU7hlm+Wj9y7cP/vElKzsT5UQREkwHSKi+R1EhoKi2MJxzMSE5Ij9Fao7L7uH2rvu
         j5eK40gBPjpeMuqEoWVaMfVvjpp6Ao7oyQpp+61Hz9mQGxrH6rbLukLTCmP3fgPuynyU
         bkzo0FrNlBIwRLH7pr1mFyouGiWpiseIB/zQAZ3WbF46ywnAEslLFUK4m5OQ6MqAuGTC
         uuXMvHVovxdEPqXAdlixi/JeduRWbEwKrB90nEuNDiJLRRK49TSS+oaEARMahSF9IZHd
         +oLw==
X-Forwarded-Encrypted: i=1; AJvYcCU6bcNkdFNafT3cJP6hT14/o1V15ZHOmydK1jFSqRZ/dUIWI+zZ8lww7V1fax+tKC5FH7uCQhRydvMpzFR3a50xww8RAJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFi+Neq69WT3SsJs0OzFCEcoRKHSlEIkpzdiJbqQC42tqtIHN3
	/cXMQlYRJM0xbcu+Uc4v9lfvX96CUIOIa8ZVykTGs7n3rr6HKPmlFWqYNvpSO2sbtfm9yZ136lP
	O8qibGo1d7JxwQRKxiXBwZQKQGeUCoK0uq5OtI6lG
X-Gm-Gg: ASbGncsLcCihdCiPm9O7x2N5zOjyWVevc8Pu6kGZMDFIMcLZ9P+IdIMnrrmxr/IYEI9
	cHZQfpw5WUwp5A5iMfDRGOlZM+cFTTzEzgtPJfSkBceabSHSabcS0YIq3TKVYIrZoT/r6wm/gVv
	e9Bf0A8i6uh+E/kLjg2HCE4y+cbcGz72FC4m0B1cNadF4vPcLudIqLyL4/m4VocjELMIdKGati4
	ZjUsqk=
X-Google-Smtp-Source: AGHT+IEQBYu1bXA+JJzXZBhAMlECigDvK1kHg7kQq+Sl7o9CyFR7oQw+sV4XJfWKh2n/RmInuKKGYYsvyveVxhjLkuk=
X-Received: by 2002:a17:902:ccd2:b0:252:50ad:4e6f with SMTP id
 d9443c01a7336-269ba566603mr149763755ad.54.1758479509058; Sun, 21 Sep 2025
 11:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com>
In-Reply-To: <20250918020434.1612137-1-tweek@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 21 Sep 2025 14:31:37 -0400
X-Gm-Features: AS18NWBRwEs0bbBucktCB8_dtchuI7OGkjeA7WSI3M2q-Aj3yGux_-_Cr5q3Pns
Message-ID: <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:04=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Prior to this change, no security hooks were called at the creation of a
> memfd file. It means that, for SELinux as an example, it will receive
> the default type of the filesystem that backs the in-memory inode. In
> most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> be hugetlbfs. Both can be considered implementation details of memfd.
>
> It also means that it is not possible to differentiate between a file
> coming from memfd_create and a file coming from a standard tmpfs mount
> point.
>
> Additionally, no permission is validated at creation, which differs from
> the similar memfd_secret syscall.
>
> Call security_inode_init_security_anon during creation. This ensures
> that the file is setup similarly to other anonymous inodes. On SELinux,
> it means that the file will receive the security context of its task.
>
> The ability to limit fexecve on memfd has been of interest to avoid
> potential pitfalls where /proc/self/exe or similar would be executed
> [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> similarly to the file class. These access vectors may not make sense for
> the existing "anon_inode" class. Therefore, define and assign a new
> class "memfd_file" to support such access vectors.
>
> Guard these changes behind a new policy capability named "memfd_class".
>
> [1] https://crbug.com/1305267
> [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com=
/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
> Changes since v2:
> - Add WARN_ON when using unexpected class. Return -EACCES instead
>   of -EPERM
> - Remove extra new line
> - Rebase on selinux/dev
>
> Changes since v1:
> - Move test of class earlier in selinux_bprm_creds_for_exec
> - Remove duplicate call to security_transition_sid
>
> Changes since RFC:
> - Remove enum argument, simply compare the anon inode name
> - Introduce a policy capability for compatility
> - Add validation of class in selinux_bprm_creds_for_exec
>  include/linux/memfd.h                      |  2 ++
>  mm/memfd.c                                 | 14 ++++++++++--
>  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  5 +++++
>  7 files changed, 44 insertions(+), 7 deletions(-)

Thanks Thi=C3=A9baud, I'm going to merge this into selinux/dev-staging now
with the plan to move it over to selinux/dev after the upcoming merge
window closes.

Hugh, since the changes between this patch and the v2 you ACK'd are
minimal and limited to the SELinux error handling code (see diff
below), I'm going to carry over your ACK, but if you have any concerns
or objections please let us know.

Thanks everyone!

--=20
paul-moore.com

