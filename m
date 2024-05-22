Return-Path: <linux-security-module+bounces-3407-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763FB8CB7D9
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3107A2882EA
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC7153575;
	Wed, 22 May 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M749ZcAA"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5120153578
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339700; cv=none; b=ZurwB2bIsDhFjhD1/9mp9LXr3sSJIp/s1WCVJSXNFcJXkURdbtf5D+Lvfzj5j9jEetQJvPhJY6flsdEn1KwJB6iQ7tX3Wjp3tYBf/tQ52M9ZwLqF/dCu3oAoefdx+fvPuGL+mOG9mRJR8CoaiOX/c1UM2Wmsi7MY4Wh4bBpTu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339700; c=relaxed/simple;
	bh=5HwaigB++GvyNQzZfOX3IT/xGcxYHjiLCiVX8SmJdZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ppogocirJFwf6/YqgbFAXNv1+mcnx1upp4N7IfVUR2kuSgjDy77hm5GPSarFBlbnFIvT/rfJgFnyave0wKN6VJU8FSgLeDrV4BRWCkrxQRkjj4bPHMl0sAmUav8IBRKaTcfl6zK5IbwbmOoiGcNs1jTDJ0Ap4dCllBfmPRUoRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M749ZcAA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f68523fda2so3717485b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339697; x=1716944497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOshFmf6G7zEK9XyWMlNtDhU83mdpWiA8UPY2QVI6c=;
        b=M749ZcAA5xq7A3+Tuwt4nS1nmkCwG1KujGuwQN0ysupV2FApOkscbgCJzqctSaSzCb
         h60rUj5SKdU4GTmiHIHtCCuSOuefMN843XzFZUDFpQVVfqXcp9lkw/K1ZZAsw+QylMq8
         iQbm8E9aBzGZhmfXeg1sElT0CS7jUlZaxRBP8lz1L9lout/mqHahuAsaO0LOTD6ECv5j
         NaZE5DTy0TlYFOXAqaDjXuK8BzC8To5JeDkNd48Mx/WXL/aa5h7kxpPoTDrCoKNOJEvN
         REhVgJ/HrBvOGavUvOGkIUy9Ck7eEFDx1EaPf7GZ8csf/Jf0je2eiozvvWTnuEh7VJPk
         dwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339697; x=1716944497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOshFmf6G7zEK9XyWMlNtDhU83mdpWiA8UPY2QVI6c=;
        b=awHBUs8k7a+hPDWbTGOTBncJler50FTp3Gn2XMTbb1tyLfJzj+cJ119AHc0MJeWdOk
         dia1YBPeH71w2t/wJ2A/aIYCZlmEdEEk3Py+w436kySySiyZMZDVSEHldf5ARB3tZY9l
         ajy3LjM+0eg5R7O5OmlgG9HqicmfwyPie6bNrhFzZojIU1+dyFetQ/G/A7x3K1w61N98
         xYXGefNkAn3Z/tasuwrEDcj8c6Mc480Htd1MlVW4iE6tEILIqgVB5H4Tyno8CwXKCA+c
         psYTOv6OT0KNfkozxQeA5gniGUt3hVsGcLi2bxRLgrJA1RLZm0uCrUUy5jpcgnegr+Oy
         teXg==
X-Forwarded-Encrypted: i=1; AJvYcCWa6wGbjMJIOyB1rYjoUJkiH+1JdspnMeUTx57rcM/426DqqVd+sUhugR4dfkaq2RIvtXjBTRE77b/jVZ0HVzJ5LJRBOI0p/9g0bM/qsevK8sv808hm
X-Gm-Message-State: AOJu0YwguPOBTbjEPoP3p06lJOkMYXD7/PHhuf5E9WD2xeHw84HoZ+C+
	eeeL1xx0Yok1nK/7f8+oH7vyGILMkO/l7Gknv6hEXnpzUqO+/oX0KWazpcI6eY6MCNBPdjpc9V3
	Bqw==
X-Google-Smtp-Source: AGHT+IHysubaIzqInuZoraBMn6KY3/zhAPfwf/Xk9cMSLEOs6DDr4Qj7OXFhv9O7YBXKJiOesYtWd3F2Ac8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2e17:b0:6f3:eeda:a844 with SMTP id
 d2e1a72fcca58-6f6d5fdba7fmr15269b3a.1.1716339697132; Tue, 21 May 2024
 18:01:37 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:29 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-44-edliaw@google.com>
Subject: [PATCH v5 43/68] selftests/ptrace: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ptrace/get_set_sud.c | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
index 5297b10d25c3..054a78ebe8b5 100644
--- a/tools/testing/selftests/ptrace/get_set_sud.c
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include "../kselftest_harness.h"
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index a6884f66dc01..1b7b77190f72 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


