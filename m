Return-Path: <linux-security-module+bounces-3394-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78898CB790
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 03:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A55EB2361F
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566011CD26;
	Wed, 22 May 2024 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phSMDsef"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B614B96E
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339655; cv=none; b=huelUZN6KNPvBGlc19BZIORzlm5TmSHmpYO6VCaRnHORV97DUxYYj4Za1ALufq1bWpHsGM5OIT+XIkUK1XdSvw83xHh6/BopYru4SKi21JVIwpNjZ71UkgOgr7Ks090/OEW6W6J2JuyOveG1V1/RSrhEs86UA/dAyUlq6T1Zo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339655; c=relaxed/simple;
	bh=GLz+NiSWIjggktWvXvCcxV3SQNfJgybR45MEAL0/SM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L4KUAFxTeOucgN047Gl2RrD0bVeMZY3zVCDCDbx+0UOM2SF0lZbSrJdByX97TE5B9MWL+dmpsELB9t/XhJUTrtsv/Jpuxgykz57uUlxMPOXyejf7qQQ8x5BCOgRHfyr69egT4nerzH2LpacIaahTT1WNiGuXYtkrBoaZDIZv9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phSMDsef; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2bd9a525700so555631a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339653; x=1716944453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf/OpY3d2Q/Mya51rq/+c3LTiKmdxaF1eraxGBViHY=;
        b=phSMDsefeA2sbkUfbGrtDhUbKgOqAmIJEDa6t6Ot3Sc9JJD2auaf2auLgw/fC7ghQ+
         d+wOIzPtrNJgIWdungvxRRm2x/vhlPlnA+3ka/FmZboN+kmZJQbwa5gw/TQwTzt01Rsc
         2B3zMcEIG9xSaUeeMj4Tm4ULLEnGlGGl7+1W7wicfbFGpb2U+hoM1SZDY3Ay9hWGeqbx
         2hd6iHS+UYSvWDw1dpm8zH+J7MPCUouQrMjZXHuGRf5RkMjcWaZpAQRi/rUcLo06NHr8
         iXqRJ5ONHnGdZcS/u5s0VgDqnjqBZFtZIL4dBAYZP2jlTRqaeCpe+lTUuUB0yCgFwNA1
         L5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339653; x=1716944453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf/OpY3d2Q/Mya51rq/+c3LTiKmdxaF1eraxGBViHY=;
        b=L+1NzaWUyhP7W0tu4X+iWGG+fbQtUwoDzNcT1KTzziN+GQiaqu+8ZGTKu+eWhfJVO3
         CGgTjVSEuUfim0/ffjAIxeVhSoj3gsOPdA35iOSiqSZqiODdrWc9J5rX3dKCrqFQvdrH
         M5zo8pbmjsLgIslkLOXHLeeVlT4ygnXH4i+jGdc6ra/HaFdr4G0UmcJLT9w+qVecwgl7
         P9zfnkgTfOvJifumFaa4f3DlxbHrNaqaGpiLiQZl7SolVjY1Q9JkaPbkCuBnOynRLgEH
         qpxxCKvhMX1SrCoxt3eYSr+0CBTTRS9MszyF2BAbkHf5msFG6tKnFlZ5TFddfuM4go/L
         w5jw==
X-Forwarded-Encrypted: i=1; AJvYcCXfNTjKpskKDVe6u+h1uaNKZ2INzYlKUGRkomOxktsdc4hKG+qeYpbZXmJcMBBwyOvxmmhOsiM7qQarF5VCAhUDlvyVHKCmBTiA+ACfmz6niN2xH6Nt
X-Gm-Message-State: AOJu0Yyr6UPjAulTvY1e5MvI9YXs/AqgBhIJ/zsqOzBI3arSZKWuU8RV
	ixR/mQyQZp78LOIy02dC/CIZ1lTGkmfJlyWRXqzv4pyF1MDLSWFBWA34dmKnyD/BMBBleQx6hX4
	I0A==
X-Google-Smtp-Source: AGHT+IERmvjUACU1dGq+usdhCn15n3wBhF0S7qzqPTxOiEhahwny+LRi4B/1JnjPnSFaHmLZJYt2JZRastY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:1195:b0:2ac:992c:4c71 with SMTP id
 98e67ed59e1d1-2bd9f5d9a10mr1843a91.9.1716339653260; Tue, 21 May 2024 18:00:53
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:16 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-31-edliaw@google.com>
Subject: [PATCH v5 30/68] selftests/mincore: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


