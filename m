Return-Path: <linux-security-module+bounces-3424-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65548CB82F
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 03:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E671D1C20A9A
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F002159211;
	Wed, 22 May 2024 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aZuf6au"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F4158DC8
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339747; cv=none; b=nTnCkqTqdWRqKsw37EZ04XVA7UxHQSIbU4sQBa9QLAhXj8WBYl601tdaWtrAEqYI3H+O83nhtpomOSh2RwNcwV7XAKfiMtol3S6jQYryfTRD4rmllyKKYcCvGVtolkaR4rZ+J9qjCLEwDGDK7Iru8qC0TIT0kx6PT2sQhqLp4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339747; c=relaxed/simple;
	bh=EB/j6UJypAPanDLZb2I0KEJMnVzQCxSyO8B/qmHrSYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJUG6XIf87Zx1cMtB8PyyTNZ2qfxBreKK8Zlg0DdbQoc8zIWGnfrZJI26JF3BBNb/dRKSmeGZGpfe+GwMMeGEBvVDC1rEw79CL8GAP4sQto9ovRIV2ulZHqwepg1TEGM0tfoQ1jFyjgPbqonrOxjezmP5f70pNom+qxvEysFF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aZuf6au; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e54e6ba9a1so124044885ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339745; x=1716944545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm1RYHlP0yY8z+cx1ACTtX9tqSUF2UuvA0/IyJOdLP8=;
        b=2aZuf6aueSZmbQ5iwuelzjjoGKTOUfcQbw8QvThA7XvRQ9hnkctUcCccItmg941epE
         QxbQYjXS68EJU+XJL0yGEsQO0EbHbsy5AQh/LpmsrlR/yaLZ5gAyQMpinjZk9aYxQSQC
         T6SXIF0czwHWxG+4uaDRI993WoAwR3rORGcpTrgbhsen/KleiT1HkogIilOpuOTnVTuo
         3H5tIMH1gWUZqG0e83QkgOTNezwvEyNnnAnUyESqgzPtRCj1gLlvfXcVu3+HSHazf/Qd
         p33m/zaA/Td4UmjtKIokJL2vi69hJZ4v3yXMqoFbCI4SGMODnjVq9CvMnniRnyhIsYrT
         dD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339745; x=1716944545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm1RYHlP0yY8z+cx1ACTtX9tqSUF2UuvA0/IyJOdLP8=;
        b=i0AOqvZcr3UUQW93YRgF5CjoguS2D0BSqJya/ZWiFUO2J1JiBtM70HKhnsy6/Lljrl
         ay60m7jz/E05pKL0o4fVpjlVflVUpfBz6skAoe4bcIVfmKiga1843gFxKyRuFNnuY/+S
         zl6LM8NJfOOuE+8VZIxf2ch6ekp4+B5mlUWntuwQJ4esLLZhTVS3WEUI8bxsTISmpMU6
         krZXR2ptAvV9ffi12OcWCIp574yT3GN9J8ohRyKulUAn0P+70p/OrLo9ZCYQGfQLsWY2
         9vEUDo6AsqPZEmUPwFeML59NuvIzGhJnw0KozJDUPXdmd8kYmC9x4pPP4hpN04wwW5/w
         asVg==
X-Forwarded-Encrypted: i=1; AJvYcCXtJVEcFnblPxX2UgdvkHcrpkIfW46sN5lWb/jOMP02cRGDo/AxLcDwdC08V2WFdAA6dXazsRZDpgG2W3b28R0WuqC7avj3SI5yLuFLjPWoCstcPBVL
X-Gm-Message-State: AOJu0YxC/+3PXOWJ5vb3jEvF1GTngVN3DxSoApL6aPANLUY0jOCR4Dfd
	JMlnTQhfZfXLuqChqZMD0m/RR75pyCIO6B0jVe/k60RVH4keNzCNzK5zcg+1/VSDx/Ez2t58yEP
	10w==
X-Google-Smtp-Source: AGHT+IFlPItv3KQjRVyD08JVklH4KtCoAvfm4Lf6y215FzRt97XcDClrNcaWNS3yMHJbFTWQCPvk6KGG8pM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ce85:b0:1f3:665:9043 with SMTP id
 d9443c01a7336-1f31c7f3f98mr17625ad.0.1716339745033; Tue, 21 May 2024 18:02:25
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:46 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-61-edliaw@google.com>
Subject: [PATCH v5 60/68] selftests/thermal: Drop define _GNU_SOURCE
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
 .../selftests/thermal/intel/power_floor/power_floor_test.c     | 3 ---
 .../selftests/thermal/intel/workload_hint/workload_hint_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b9..ce98ab045ae9 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c53..5153d42754d6 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
-- 
2.45.1.288.g0e0cd299f1-goog


