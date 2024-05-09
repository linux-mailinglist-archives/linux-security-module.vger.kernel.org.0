Return-Path: <linux-security-module+bounces-3074-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D08C1705
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804CB2843DE
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F5145B18;
	Thu,  9 May 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5wq2bX+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399871459FA
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285016; cv=none; b=K9BKhyuF3sKTrEAgU5/AeDE56cACopFpNqS6TaICYCq7lAvFmHW7RylOZbGMZhQfmrVZt7ie+YZv+bjIc1vTKlZgUtr/POa+gAz1XUs4z9d/n1X+TJfhP2tZb+NfyzZjw/xO5EFeGvizbXIp+pQWUq6iGDzCAAJbqJ0yEGml+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285016; c=relaxed/simple;
	bh=/khkP8W7dsNEuasGGV6J5yljpMQh0ZwmIXillppvC7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qe7uoDkIuMijH5bhUqKMZxJbgvQITSQKIsgNPjzOOWJXteUrPQHLJADHzZIBo5U1QIDbR72SOL3eENfPTjxmOjRZ2tP8+7SEICwRommEsMXrXmBrGi0riRYM2k/NSHdTsoxQbQGZM0cZ9pJ+t5zdNl0wbdlsjjrSCe0trk/OkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5wq2bX+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee3b4f8165so11514605ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285014; x=1715889814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbb2U4Zk3Yr6WN7VZqepw83lSldjIXt27jnu3vVFb54=;
        b=j5wq2bX+KXkA9TDwBdQoSVuHx5AppMahH1S4aMQNVrG4EjMFfjGJVRuBpYmlG8wqMn
         EYMdL9lOKcFcFGURggvCojUJPwasU+X+iszsw2aLi0AgicDCU7ghPZjhlKmlDaGVYbP6
         jZ9nG4zrbpaN5IKF5VKh6r0/t5aAshVeY+aoUg/iH3qVEtuIclnVD0TvXrJnSt+DOzRv
         2pP7DfaOBOq28Xr1UqTck4tubiBhK2L4HOLjWzH6wk1VWgC82LHlNk5uPtuVYAM+leeM
         UDzA/gVgSgU5l4QAqupdKhWvunrpF3wIl7tC5ykLUXs8k/FSDDaoGoVFY6ZD5eGEk+93
         84aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285014; x=1715889814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbb2U4Zk3Yr6WN7VZqepw83lSldjIXt27jnu3vVFb54=;
        b=NkMPb63a9l8bWCKcpHcX+uu9ZZ4BUtBYEfLwps+2pBusVrsNUPmSKzhLW8VqStqIdo
         cEoEz2QtuIy0SL1HJ4c2ZsvN/qLM+hXsgQGNG/fDVTGzMyUMnEzZRaJMV8rT/dQ0lPUJ
         FKOUdsFPmRnBTQA7nGkAyG/8UM54A7lXk0o+mMmWD8izT5k2mKFBG5PqUbb+CBk9yYiq
         uUCmdWPM9boGuSkHNBGfA35IC/aTsULsW6fcGGdDaypRfH9PYuc0dSBLzSeJgV58ifqy
         8n75h0T6zEoM5dPVgtelAo9lpujVw61/UJV7rHsEhTrzI+InACxGZik/ylMCErR58OYr
         Bfog==
X-Forwarded-Encrypted: i=1; AJvYcCVzq+qakR2dBVc7qG6nmPgdoDkkwQG9apqIeRpZoraZz875ggdgeDPqwGda+HWjdcaGmp8WvVRAeOb4c/+IF0AG7p3QHBfh3NWAAoXzVcXY5sB4DZUH
X-Gm-Message-State: AOJu0YxEhjcYX4GhDJyV6cmKx1EYb2hlsiDJ9o+6cez7JrXE5WjY2Q3m
	B5GSWUTRupGG9D04lyow7a+2r0K4R+eTAIDuSgqN6vEjGrSFRrTekVnxNA9Tz54l4esrad6XW7V
	flQ==
X-Google-Smtp-Source: AGHT+IHaW8up98KKY0DKIREM61ZE6uwLOqj4Q30aku4j5YlMl7GJZFBGsR2DlfHZ+DXteqca0hW/DEYGwCQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:da8e:b0:1eb:d72d:55c5 with SMTP id
 d9443c01a7336-1ef43c0c9aamr312765ad.1.1715285013596; Thu, 09 May 2024
 13:03:33 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:49 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-58-edliaw@google.com>
Subject: [PATCH v3 57/68] selftests/seccomp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..3632a4890da9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -2,7 +2,6 @@
  * Strictly speaking, this is not a test. But it can report during test
  * runs so relative performace can be measured.
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <err.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..972ccc12553e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4,8 +4,6 @@
  *
  * Test code for seccomp bpf.
  */
-
-#define _GNU_SOURCE
 #include <sys/types.h>
 
 /*
-- 
2.45.0.118.g7fe29c98d7-goog


