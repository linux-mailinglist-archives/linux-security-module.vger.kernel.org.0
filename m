Return-Path: <linux-security-module+bounces-7177-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC3B9F5DEA
	for <lists+linux-security-module@lfdr.de>; Wed, 18 Dec 2024 05:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD0188A810
	for <lists+linux-security-module@lfdr.de>; Wed, 18 Dec 2024 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62E154457;
	Wed, 18 Dec 2024 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evNnJy9Z"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABD13AD3F;
	Wed, 18 Dec 2024 04:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497273; cv=none; b=O+8y9bz741ge8Ht+OeL9B45HaIceiGZB1Q03EuNNG0V/frNBgTe8lPzhodETXdkCk7oNE3KWllZ3moKNoTejokPloZgAtFtRlvhY6VTXXQR68S0lkfRkmBy9fl8JOvoUVj93wtj4awMJS28tA9Z9P4el6Ls/GulL+lnUi8eGVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497273; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUEeOfXvzfH7ILAByrnMYyEr8NP3MwSFypVHd/c1hfQ+rDzSYJA93xS902FnHMyMM7NW9r3X9F/KTkxSJ3WL7J8l3QjGpsaFAPsjOEP38Mtb5AUl22QBoZNxB3auJ4wDZUdPynuzfRyfRUXUB//xSa4WWvCgbOiInOmGbx+K/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evNnJy9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E7EC4CECE;
	Wed, 18 Dec 2024 04:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734497272;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evNnJy9ZNCOzQUAfMVDuSCo6d9Mb8P/6jQnoNtUEaYgLtxQgQOuK5GzrFTfMhFxhQ
	 WqspdLvRhoiOT6qR3uteeiWwkkM4bVf3FcF/SuUnFP4vZsb7MK5eLF1UcMCzi5gw6i
	 0PeiQxpHsgLV1WZGmCjd67sexxyXxmzSramszET4oBywK2hWY6ZlEIbJpBUr+8gMYp
	 hz3B7/Ks3tZQn+gf6LHxW1OrYwKhG36vywapPFneAgNoOAWL4Y9YnNVJfMDuxjTiMO
	 4MUPZqr5T3sllo7Io7Sl+zD/LPe+kIfj9GimiMmKvwfIsKlwweM6R1yiW0KayagjKP
	 X8jlY8nFlr6GQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 3/5] bpf: lsm: Add two more sleepable hooks
Date: Tue, 17 Dec 2024 20:47:09 -0800
Message-ID: <20241218044711.1723221-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218044711.1723221-1-song@kernel.org>
References: <20241218044711.1723221-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_lsm_inode_removexattr and bpf_lsm_inode_post_removexattr to list
sleepable_lsm_hooks. These two hooks are always called from sleepable
context.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 967492b65185..0a59df1c550a 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -316,7 +316,9 @@ BTF_ID(func, bpf_lsm_inode_getxattr)
 BTF_ID(func, bpf_lsm_inode_mknod)
 BTF_ID(func, bpf_lsm_inode_need_killpriv)
 BTF_ID(func, bpf_lsm_inode_post_setxattr)
+BTF_ID(func, bpf_lsm_inode_post_removexattr)
 BTF_ID(func, bpf_lsm_inode_readlink)
+BTF_ID(func, bpf_lsm_inode_removexattr)
 BTF_ID(func, bpf_lsm_inode_rename)
 BTF_ID(func, bpf_lsm_inode_rmdir)
 BTF_ID(func, bpf_lsm_inode_setattr)
-- 
2.43.5


