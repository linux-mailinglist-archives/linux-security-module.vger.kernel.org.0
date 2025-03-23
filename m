Return-Path: <linux-security-module+bounces-8973-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D4A6D0D6
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Mar 2025 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2B73AFC21
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Mar 2025 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD731A316B;
	Sun, 23 Mar 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yym9Ydqw"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D51A23A4
	for <linux-security-module@vger.kernel.org>; Sun, 23 Mar 2025 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758790; cv=none; b=mKJ0My7uzI3tSHG7V1oN+3k6asP/Bk7n8DbRjCE6l4bGUxCXR/M181LaBwhBf5Z0y4CSfe8QGmuXetx4TFtr7i+TQZnV0gL28vshosBHTQFjE6FVsur0lOwcLQaQlDTuLu4wfQueI/UfFE6mGh59mqsBlfuezKmLGEKPuP41+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758790; c=relaxed/simple;
	bh=BRhRgkSB7z8P4IHCJlBDVXeM2viBX2/9Xb1lcpWRG/4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ptm4LSVf9X7LGZizAEHmu/nk769Mv0Gql2fE4jH/rjfqQKQST7H00KWkUA80prQRdTtsf3yoRlgfsSLxW37Zk8q6llL71+G1tkEjgwQNsO3jpIQBPSetZfwAIRnJGqoMBzca0TIEmK4PW/WBYpnejuFMYiVJUtDLkvyIsSVIm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yym9Ydqw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecf0e07954so12004126d6.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Mar 2025 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742758787; x=1743363587; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj8XaZt6/KwWc/WKs2MV1ArCjqHhkM5gbAr6nIVV+nc=;
        b=Yym9YdqwszVjWGhaHCgAJJ8NUcRth6VAtnVM+Q0Mp5M9EvRMYVyBcK5p3gq9+yZHJD
         DATekxC3wjJFcZiz9Y/6zpTvB6OKYhKYpuQiOefOyDmVjg7Wq7j4IBiRVjBIm4lt4qlK
         jDW/Lc0Rc6OduNIbKmktTeh/GXE2echYW/5P1v/uDghE5ibE0GlF1v5CRuzm08MYkdk+
         jNLLaqKSgxiW8IiTqug0XnyGv5/uRM4QrOAeypIh1Pph6xad1cQy46+FKlSZac8UeO1R
         k/VoDky08zxdAhEXloe2HeoaSl65Ig4jgvAoAhfG1FurfNXnSZMJ3+OLFxcOQsjhJFSk
         PKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742758787; x=1743363587;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj8XaZt6/KwWc/WKs2MV1ArCjqHhkM5gbAr6nIVV+nc=;
        b=f1wGvo4yLycOh2z1e0NT8Kot7Enndjm+m+h9EX20YcEDvjrkL4qj1HsCho1Qu2MIyT
         dSLnM/GaX7ZsQoZLRfRFSVDPodCtgjyUnUtFN45G2deB8ZOq22e/AlYJi23RaEyTqXq3
         pDTXvOtnRuQLqE11AC+ZsutOgan9RPpd/IhdD/kuJU4EtMOtXsueEAcsJUeZVWEywGgr
         neQm6brD1k3bevD5fpmDQ4CU/dsX5lSe0VViK+gLTLMeJuQHk7vhTcTan9h6LCvTwCTG
         smIZ+Zt/tvdVorfdlGu3s5P3cCAMXrYT/9JLRhANGwPeMyYc34K0ftz1y2P0W52fwREM
         P9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWgr/DUx/6W6hG1WNZrAhTvILS42LQxvGHgitBvkAnSUh8UixSFphzEU8DHjvckT9J+Lidur9fnplYMp8amaL1UEnwHx+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dq4+zel5NYLQ6WzCtkXTHTPvfl6jrr2b7QW0LFa/Bo9o2vmb
	CrGe6hmmWPCjZVurYTumxh2NTlPX3uuXxsVLR5mWivJwrgcn0EaOR3f5vllbYg==
X-Gm-Gg: ASbGncuDvXismlncUPjBqGnok7Gu8MZs+kRyrx5Cjo5KVrB0UzH4Itv+k/MxYLd4vrk
	ksQkU3I9u1EyckzN85j/BYBug6qbZA3yS86Ae+/NMWP7ZOax63IwuMbUhRbWw4R6JFRcloXIYQU
	2j+eRwXPUL17BwJT/mwOOtpYTiqg0+d+xeMoKBFYGxSAxbkwE90EFu4QNyOF8ITXjLV9Q2uAuql
	/GUEUzo/UX8hTqoBiWWNh/sPeODqNjSKO4u9z0VezQeeKhFyaQPokeXaQWyMd59lUJaG0Nh2CB8
	kZkPLIulo0/MeRvbxLxSTxs8mf3ZHAJ3PMqPmiL+QDUA7a014FsZuzlU1c3dkpxM+FyS2RGu1ki
	M+vmyeuliZSKviw==
X-Google-Smtp-Source: AGHT+IFAB3x6FnMVEWde6N6oN5wX7FeWdrMvjooBIQDCq5DitsfBHMnP2NiIDwyIcMgkV3xbnKNvtQ==
X-Received: by 2002:a05:6214:d47:b0:6e5:bc9:95f8 with SMTP id 6a1803df08f44-6eb3f2e8b39mr186523896d6.17.1742758787490;
        Sun, 23 Mar 2025 12:39:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef0ed51sm34743946d6.6.2025.03.23.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:39:47 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:39:46 -0400
Message-ID: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250323
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Here is the SELinux pull request for the Linux v6.15 merge window, the
highlights are below:

- Add additional SELinux access controls for kernel file reads/loads

  The SELinux kernel file read/load access controls were never updated
  beyond the initial kernel module support, this pull request adds
  support for firmware, kexec, policies, and x.509 certificates.

- Add support for wildcards in network interface names

  There are a number of userspace tools which auto-generate network
  interface names using some pattern of <XXXX>-<NN> where <XXXX> is
  a fixed string, e.g. "podman", and <NN> is a increasing counter.
  Supporting wildcards in the SELinux policy for network interfaces
  simplifies the policy associted with these interfaces.

- Fix a potential problem in the kernel read file SELinux code

  SELinux should always check the file label in the
  security_kernel_read_file() LSM hook, regardless of if the file is
  being read in chunks.  Unfortunately, the existing code only
  considered the file label on the first chunk; this pull request
  fixes this problem.
  
  There is more detail in the individual commit, but thankfully the
  existing code didn't expose a bug due to multi-stage reads only
  taking place in one driver, and that driver loading a file type
  that isn't targeted by the SELinux policy.

- Fix the subshell error handling in the example policy loader

  Minor fix to SELinux example policy loader in scripts/selinux due
  to an undesired interaction with subshells and errexit.

Please merge,
-Paul

--
The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250323

for you to fetch changes up to a3d3043ef24ac750f05a164e48f3d0833ebf0252:

  selinux: get netif_wildcard policycap from policy instead of cache
    (2025-03-17 16:22:04 -0400)

----------------------------------------------------------------
selinux/stable-6.15 PR 20250323
----------------------------------------------------------------

"Kipp N. Davis" (1):
      selinux: add permission checks for loading other kinds of kernel
         files

Christian Göttsche (2):
      selinux: support wildcard network interface names
      selinux: get netif_wildcard policycap from policy instead of cache

Paul Moore (1):
      selinux: always check the file label in selinux_kernel_read_file()

Tanya Agarwal (1):
      selinux: fix spelling error

Tim Schumacher (1):
      selinux: Chain up tool resolving errors in install_policy.sh

 scripts/selinux/install_policy.sh          |   15 ++---
 security/selinux/avc.c                     |    2 
 security/selinux/hooks.c                   |   58 +++++++++++++++++----
 security/selinux/include/classmap.h        |    4 +
 security/selinux/include/policycap.h       |    1 
 security/selinux/include/policycap_names.h |    1 
 security/selinux/include/security.h        |    8 ++
 security/selinux/ss/services.c             |   15 ++++-
 8 files changed, 79 insertions(+), 25 deletions(-)

--
paul-moore.com

