Return-Path: <linux-security-module+bounces-3398-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191238CB7A6
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B71C20965
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD714F126;
	Wed, 22 May 2024 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWO96TLL"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540D14EC7F
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339669; cv=none; b=VZHv6/VfRNXmN89sl2484lfuT65VOqJxfut4LHJJjRSHL0/yWUlGnCpSZGyxlWBiDjcKfPPLLrkPyNIKYZP3WgKf+gOXvhNnB+y2KsE/gz+tJPPCJHINT5cRMs8l/8aSlgJKZDNWGMZ4L9MRRtKmT111Ufp3fmuANxeI/E8nd5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339669; c=relaxed/simple;
	bh=eIDZq+0xm3dfSBw7qVu6+2fYNcoy6VlTd+X6zySyELM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BocMrvC0+6yU62DGDerZso6LapRx27Lz4haYzv09Zj2a8hx/xNINGbcjnZ+EBSOdzS9oWH3U8+b5ulPaWvrM9F86SG68i22vgwQz1OoIPtoANQcFESiWNzCZrZd1QTvtQLWEkfSXGRT2C+ZycF2DadSy6tIe3WJFv9DTKcKj4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWO96TLL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ba0fd5142dso296427a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339667; x=1716944467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks1TxZm74BwnYcvWntsjvOvPgr4COyU4wUcMCGvwta8=;
        b=eWO96TLLIim57gih6eEo0LseBu6tndf7ONG+xkUKNfAEWmLub31qhdjw8ni6WGvPlj
         g9ClqRAxjI5wzR3FSuoJf6x5wmC8HMFrEIF+hTQpxGaK/hB5ltN2tJKI95K8FVf4nnLG
         NbOWqBwnry/KPqj1+LnjyKnNJ6fYBq8u7JqFMI4D1d0ZJIxhiuoJ3FHrA47sYV7dmL52
         C8ZJTW6UrFfHW7yMu/cCYaXjnW4ibr+L+LQWbDleygOzozg0XtbiVXbijGu/cYZsw4et
         qIQ1lIvRF3Go5H51oAeAnnL64UY40wmNRBiN4+EAlJFUogyfx76dib4oGs49jaur4leI
         BsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339667; x=1716944467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks1TxZm74BwnYcvWntsjvOvPgr4COyU4wUcMCGvwta8=;
        b=K9Tl7FkuYYTrXXJa+HPtQhA7VZJ/2+NOWoAn1EbqXoR2m73ODdvFJk2ABVIV1CWran
         LU3vvjfbXq54aovVbOIB7HXvPLj0Z16T+iRCfrv58sRUxibSwM6vjUF1fpW5Dn1yYTpz
         lgjOewrYppuXjXnGPV1onlebfoPe7OzrtwNEw7pJ2hlnmg+9WlvfYN3uO0nmGCigj0Qm
         4YWcCdHhSoISEMldxst9/j9JR2bL5aeiDji5Wt7KbF0MNuJzUj+44oTrhvRjzz/3YbyB
         EpOcdv4IUm7hzaYzighCsVk9VMBaMVY4Ang092I9v91YDmPfpkRr2IY/9i5n/Iajtp7K
         ItHg==
X-Forwarded-Encrypted: i=1; AJvYcCXcyKjWEk6IGLtpJn5cD0eJ4U0e67JLldz7XdXn2N1FBjempmFA7ZGIDDxPz6YLNrHIYiBNmatsjrR6Dmk+Xdss4U1OcCgjxyZVlAS1+SDOvwqV3rbi
X-Gm-Message-State: AOJu0YwKO2F1aum9K+4IgT0xBHtqpOFmDII5iMVBJ0hXtQyzEXrcjAq2
	IMFWyAV/HZMipX+mDX0Zfw7Z/bgCCeraPQG3K8dsSuPImiWCWYz7NRtY+NPNbCqTRLNBeGC5zf7
	ayQ==
X-Google-Smtp-Source: AGHT+IE2BPpNcURJ4aVDF/EWLlqxZisBRuDQmW3J9W1FLhDsuBG8XYND6sv5FfH6pfqz3Ivw8kpZfbXcVwI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:b78d:b0:2b9:6fd8:2ff7 with SMTP id
 98e67ed59e1d1-2bd601f0e18mr74966a91.0.1716339666568; Tue, 21 May 2024
 18:01:06 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:20 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-35-edliaw@google.com>
Subject: [PATCH v5 34/68] selftests/move_mount_set_group: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../selftests/move_mount_set_group/move_mount_set_group_test.c   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index bcf51d785a37..bd975670f61d 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


