Return-Path: <linux-security-module+bounces-3031-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C278C161F
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5AF1F2350D
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E9133997;
	Thu,  9 May 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxk876M4"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A313340B
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284890; cv=none; b=Q/Fp7vYiN+C/Hj9ag9WimvBF8eqIlk+mgRzdKNta/8Z8snF+Mz9/2mrklT4PyQEyJwcf54oYbNIGVzxGw4/9I4ADNla4GrBMRRUHZ04WOORTlf7Eua3uHXNz77z6JmZqJhs07m4arVb3swM7cC3uf1KwP6osCzfMj9jQauWkaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284890; c=relaxed/simple;
	bh=NLfWchjBMnfj0uHgc+lZRCh3/hwhcn1C4pDxOTbEqG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJdfCBZezBt5/X0aqrsLZlHYnVLq/8vYdn2tfbpUeTGDCI30v1S2HDAJ3fo4/dbkNQdZcNe4U2Y9Za+5DQHxfDBSJe5bIFyCxuoobkGY1CLT0ielCR9kOMrrWKqmDhbUVvIV1vVZosCUM9a4EcMeZ6DIIPiqh/yM0BFbb+YZvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxk876M4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1613999276.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284888; x=1715889688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wSVWuIBaY3YuCyJCESt9Kj/Ip4PjdWD4+MMXdzxtY=;
        b=nxk876M4d4a7uleVvTf5RtGdGgChoJfyTYNgKVRutTKLrwGPv6yIdH5v87Ml+5M8ZQ
         bxH1k6jxaPdIqFXxmFU8FSl+KF5EuABHYaoWqAyD/qw6/bwddWKQU/lN3K4s+6QK29NR
         Q9x4qbNpF+BsZkcUJKg6lit9J6G5g/FFh7WrxsQUYHjBDwZbifXo6G+2spLGhXWy604e
         AnM08jUI4vNZlxWvdl7pmI0TKQZrQ+uToSYVEX3jCrHrTPjhks3uL+i2N/RT7Z9dkXLR
         Ij8OY+vHiiaw7Eg8uZ+o6miOgyavCX7k7poZhiTFZcZHWKpgY1GOFYA2OC6crFzE3GCl
         p+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284888; x=1715889688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wSVWuIBaY3YuCyJCESt9Kj/Ip4PjdWD4+MMXdzxtY=;
        b=kNMOQImXV1w+SRYy0ELtVvoL47e/zYoYemogloD4CKR6kmgMrvSd5g0ni8iLN3Qqwv
         Dvomvzcrnkp8ig5/FkffeKh0Jp2aiSpxIrEuFnpeJyahAUKXk6pnQi6/jbgYWJcqaVo5
         bgDv+w9zMsRG48onS9TywNuW1zRunxEf1Lo8fuPPIymqC2N8vKOZROgFD/QxEifB/JbQ
         AriYSKBJveFO3GoYGfLB652a6Rnf1fmMviYi7f+/mfykCK1OHQKkwqK3x+3ORgWrBhZe
         /jWj7EBmZp1YeEzt46txQNhPGvJsy6OhVPdY9rIkGAYtpxvU2rLWFFhqAN6sN4Umpih1
         tyVg==
X-Forwarded-Encrypted: i=1; AJvYcCVvfdYqXpUTs2oeIbl9eYayfLzaSYOrETv+VSI5az5yQCuAdmgVgNM3PC87tEdjY901Npx8b1PtB6wCWl5vr2Fzlw/NKl54g0bFp7oLiiWWke2WkW55
X-Gm-Message-State: AOJu0YxFA9D2/dFownA3c/wwtGMX4fx0KuPgaX284AC13d3qwLqwaCpI
	XtZmf6BJ3hZ2OkiLL3up9sI0fmiP/8yoAX/WOVzIiF8RnysvNaDCCvEpCJp0Xn3S1OM0gmJYAaC
	HAg==
X-Google-Smtp-Source: AGHT+IG3vixfOgsVRvWw8ba1GSc0WVoejlZw5UUOvsn+v5cimkQ1a21N59uv9KSFtZ774wjBAuCjwsx2Iew=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:d3c7:0:b0:de5:c2b:389b with SMTP id
 3f1490d57ef6-dee4f1924eamr46589276.5.1715284888528; Thu, 09 May 2024 13:01:28
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:06 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-15-edliaw@google.com>
Subject: [PATCH v3 14/68] selftests/drivers: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..7c8dbab8ac44 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


