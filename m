Return-Path: <linux-security-module+bounces-3046-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908628C166F
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 22:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D66286F90
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8B13B298;
	Thu,  9 May 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBVVxbVp"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379913AD2F
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284930; cv=none; b=KEKyCuwEaDyCLVHD3YvfaDbSdmUXegvKp8efK9fA47PGwkD0uJSN+H/x9MHQTIQtib3z2yXsSr90RHYEc02UuYZ/xP/p9FVfYQa0sV8RMgYwDzal1dv8AZnaBYoqyDDZWI7oJuaW2nWJhcAQt3d45dhbA8luQ9GWGtvgJrhV0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284930; c=relaxed/simple;
	bh=16xQFZUemPEW+OmTRE/3AJIID4VuLDiTh8Uti+95Avc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pSoCoMUkwjvATake1DZ4IKNP/c4BhpY3MB/3qn6EsFYtJYKxm8LwiSgydMJnPoXHKmFukiDFA/AaHwoDwfggcXguGBjzhuyaV7lHhhBZNfbyd/FQWJij2luuvU8e0qXL9zGR8u8kne72u+Hsr3NoW8wsEfzfO76oo6/Smfhkn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBVVxbVp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so2833803276.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284928; x=1715889728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4la0VxD3l5sUUAGJ4Eky+q6o3Kf635llpLjU0Q2ns=;
        b=XBVVxbVp0tDi1eejJVKANr+8xaxS/RZuT7cPK9azYrwtike+1VH1jwViW/jBCCJLsZ
         hupPKaiadKuVDG9F61e2VC7dz2WWlo1OJ0xyC3AZv/ehIs9gj7HSyrsnO+AKhQDAq8FI
         +0zVDs+SkVvFSnP86mwJg2loLZnsQjj6DrXYNwjXw5zCPhGFjOSbMKNxvI8QqP8c0oaH
         p5EQxr+oR2Qcz16c1EdviPH3wsgHREVRBM4YMZRAgpS8P0Squ52ocsQQeVXgt3ozvZtd
         LON1xSoAlM3uF+AtUiqyCkFCkd8BIZOP4/5H/FBtStBt6D8UzjR/IebYtdq88C0B3BqC
         QYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284928; x=1715889728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4la0VxD3l5sUUAGJ4Eky+q6o3Kf635llpLjU0Q2ns=;
        b=mrP9SjjI2Uj41pds6TxrM2fL5AOIBSVUl1/NqPN2sVRl5f1dpDHQ1uuniRErrfYtU4
         0JMVTtvMQcT1AXF3sqOdFII9trOb37YlOQp6kLK75rqS7EB21TnJTSSKitPCoUS8hk3r
         aSf9/OR+LVYcTeeYhxjv0q/Ndx3lHKkVcv7vgNOCnCwG2TCsbTavW0nHKKboMWlQrkYL
         TVfL/UFD6MjLxkOBP2Ndr10c/322ZGUfOwjkyi+YPXdgtlFR91vRHXbNSLlVlulRrtIn
         fhD7HU28s7KOjsYqapawZ7me/k6bBMMiHnJbctdPl0lMzWsIgbVlhwM7ndrg/L6QOkk7
         lPxA==
X-Forwarded-Encrypted: i=1; AJvYcCWEzn8/TGcSkgOc7lu7eOF5dzB1INPMOmCjuTECHWl22ERwa1mT6JZi6ipjXznmLV8K0Pxx4a7qJLPr2x6BGV7aGzEdUlJCP4OrAuMxGKPnVIZ+AKk1
X-Gm-Message-State: AOJu0YzZ7YhYf0e4w4xdQDdp4crOtwOe87BqIEH3RqXZ693qQJzMkq3w
	BgTb5FoAfyYhsUWact55Xg8w0AST0X6lvwB8kvA492RK0Tf0bDUNzxBrcsB1jED0L6OvfpqnMfX
	AXQ==
X-Google-Smtp-Source: AGHT+IH7mCutPVAsCyjnUwqjavBhEaHc72uO0KGnsx9I5mIx6c+B/OzfNxUabcxwf0ME6yuKTrwEQgs1qvI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b03:b0:dd9:20c1:85b6 with SMTP id
 3f1490d57ef6-dee4e48f302mr225691276.2.1715284928394; Thu, 09 May 2024
 13:02:08 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:21 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-30-edliaw@google.com>
Subject: [PATCH v3 29/68] selftests/membarrier: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
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
 tools/testing/selftests/membarrier/membarrier_test_impl.h        | 1 -
 .../testing/selftests/membarrier/membarrier_test_multi_thread.c  | 1 -
 .../testing/selftests/membarrier/membarrier_test_single_thread.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..a8a60b6271a5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index 4e14dba81234..c00f380b2757 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index fa3f1d6c37a0..c399fbad8efd 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


