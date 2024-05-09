Return-Path: <linux-security-module+bounces-3028-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F18C1610
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 22:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DF51C221EA
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C912D1FD;
	Thu,  9 May 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeTTxI6A"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72312D1E0
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284883; cv=none; b=aLR096sNHp/uh52aBrq7GRpCPFI0QYm2sQrZKOh2pHSuekCFWaENijfTIXHye74sPe6wlWbL/bYdrGvXxG3hjWVhwi6JzVw3e3P97VgjJ5ZTCIDtKuBRClgZJiu8/hHv5h7jSmVPLzeM+lM6/Kfl7C67eMDcSGrMCjpX2UdF0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284883; c=relaxed/simple;
	bh=cdDEWfBHKO3HAJkkrjJc89EWN+jW+q7IeEi18D/icdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WB2hX8zJFrodj3IUuOLIyM3AAbtPbwG8YZ8ze4z2LeJ9t3C4kNu3mAdgGRR5+k2L6XnjvTSmJLcxuKdK4QgHQeTf42StmhQ+85t2V7yfmEJsF0rpPWDsHOMSGeomPof26BzBPZMie3L7/J+OPzqcwuiHnSVnEw0IEVkatqDscTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeTTxI6A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso23812557b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284881; x=1715889681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eQ6XGkPYgeissWdzFADaWCQSCh1US1lB39uUrru0zE=;
        b=LeTTxI6ANrrocxEThieg8eKgy9RaqISXcr5I1nQSy1dntfAWTB0elCVVX93pMaD+8X
         gQ8lTfhmZ/Oqj2560xLEgiI+3lVNYc6WzVOMr5hM1alTY96AFZv99DWtEyhbQK0PM7Ib
         TkG3GS2t1EqgY6P8CgxUWYOocAbWh65pkgTDDzJJTE38/IJn6UBSI3576Oc9LN+/2fIg
         szwGpnuZeVeh4v9fd+LiW3IpWRgOnc2zNTmPF2gJJXTr6FpwWPk3bSUiYBntTDlgrNnJ
         0fWZHJdgMb/YINJXa5GxbCXitDXlIKryPL8EdRvL45nExc1emgLrkVA9nPLjltJsbjsY
         heBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284881; x=1715889681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eQ6XGkPYgeissWdzFADaWCQSCh1US1lB39uUrru0zE=;
        b=DYtKOk00FbxbI6p6p8T7Ihfq8L/+YLTOGposG1cS6IGnDm0EyGy5q7Hn/lBrFraIf2
         sy+TdlkKALIpykxvqks80gUluuzdZDyhhHhBF9ur8FkW3ElOPhJRCpUiQMH0NdiKBF6E
         lMj/AJLFD3h6T8qq9+ixoEVuv7EZEV3PAsXA1fzvNImDsZRRT9DY69Eu/KbdED5Cx4tT
         dTEUTaBmFWHwu/oILqDL+ylCBcvNisnTwxtHxSy/FCjF6pTg2+Ngg3JZtv8yuO/5AO1d
         PA+xPVfoTQyL6Oos2JufR0qcd5Oo0qyc37apaA23rdTqccphn+gagMfHK3VYzlu0h3sM
         8IhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOoo2NzTpQXM+4xGAfUe7jXaeuSo0j0uY3cYPQOBjbmUeH54BCj7pelIR0anluusmOzT1OfCpLTUuC8/ovGI0d7Gp1Wj8bDzbXpOfVgnILTypGZGij
X-Gm-Message-State: AOJu0Yznc6Z3oSbVG3KNGFuEa/zc4nl1BSkMoxelRk3773CeUd6M/AqP
	Y2MePFXbIaP+SYgzIuDnkp89dVVlIfyLTiQyG3da8URHbur8RKZczVMpE3nsOv50+VcOjeA21wh
	JuA==
X-Google-Smtp-Source: AGHT+IEKmXN2OtUcDH29uDFP6MEwl8SNHUgfbX774CgKav0w50QMF09nqWEqskXHszGXL8AiwTeDuk75cw4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:2e04:0:b0:deb:8bc5:eb5b with SMTP id
 3f1490d57ef6-dee4f2de0bamr140844276.5.1715284880822; Thu, 09 May 2024
 13:01:20 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:03 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-12-edliaw@google.com>
Subject: [PATCH v3 11/68] selftests/clone3: Drop define _GNU_SOURCE
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
 tools/testing/selftests/clone3/clone3.c                        | 2 --
 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c | 2 --
 tools/testing/selftests/clone3/clone3_clear_sighand.c          | 2 --
 tools/testing/selftests/clone3/clone3_selftests.h              | 1 -
 tools/testing/selftests/clone3/clone3_set_tid.c                | 2 --
 5 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e61f07973ce5..ce2c149dab46 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Based on Christian Brauner's clone3() example */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 31b56d625655..bb99ea20f7d5 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -7,8 +7,6 @@
  */
 
 /* capabilities related code based on selftests/bpf/test_verifier.c */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index ce0426786828..8ee24da7aea8 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..172e19d5515f 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -3,7 +3,6 @@
 #ifndef _CLONE3_SELFTESTS_H
 #define _CLONE3_SELFTESTS_H
 
-#define _GNU_SOURCE
 #include <sched.h>
 #include <linux/sched.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index bfb0da2b4fdd..a6df528341bb 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -5,8 +5,6 @@
  * These tests are assuming to be running in the host's
  * PID namespace.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


