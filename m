Return-Path: <linux-security-module+bounces-3146-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63E8C1B29
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2024 02:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C371F26D42
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2024 00:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493F13AD04;
	Fri, 10 May 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihijklfl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262D13A896
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299872; cv=none; b=NM27ivXm0x+z5rahazri7bsiCt/T98RNTH5R2TjBTTUAzi0cWLXnmSZoHjXBeEHH1PzHimNeiGn8gBG3b7fa1hdgbzG6Q7PjwI/OWzaWBznSdRFLrHKy493T7Xv4Fayj/hi+xgU75x/+JM8nb6pL/cZQGKhN2XG9CXtEkLMhX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299872; c=relaxed/simple;
	bh=D+lO9RJiz0JqcAKo+iLXjUNg3VNWTwEI/ljWSIi/yJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcsdY0rlSkTCVfFwdVoUZYZtoAOwGvaJRLVe6Lf/5mch0nncuDnDjjavcne7ns8/MV+gN+UJaK4TegTf/LZJxTGWbukPd9tdhHi0oHoLO5kA6kGU70WKZ5AUAEnCIciVxf07GEkqsScpalVkNJrJZhbkGgb/MMe1z1tBnVOHUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihijklfl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so1389934a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299869; x=1715904669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH/PIKk2jB1jyNx8bwLH0dpZjssl+xjC9urhdkKkpFc=;
        b=ihijklflM/LXZxFpQ53Argdo7ZXQMLLVmKPMognN4gaCMmD44G2oEg1261nUbvD4J7
         Y8GvGFipy4oqYd4WMLd8bzoVPx7QpJV4A7MQ0qmBDw4QDbLiqM1942mPy+bMMQxJTFVo
         L7B7rg3mYDqiX9L7TMBrZdAnnUXZiRasUOxcWf3xnUlzXyyl5eQmIYaKuqXhevtAbv4S
         0P6lSUE+uUKm+HvcCwzpO7ZDIq/cH/fAieJl0OsSUazilFf4LwDJJN+oJgZqkI8+ysYF
         rl/QIH0EnrfBk1MUWc6/M8gTxpLjNbawQBhcTGTKwpiAPY/pSC1gTA6NB7ZYoTgSyJSL
         k/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299869; x=1715904669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH/PIKk2jB1jyNx8bwLH0dpZjssl+xjC9urhdkKkpFc=;
        b=IHJaNGnUbVtvNLJFSPN77zxdOQgeMqbFAROoD0RKJ9LJ70q7WmEIBWih7aPJKjKdjw
         fTKOdSW3l6FA6CTH/aVe8UrtoGJ9cTUQNUM0zE5LJRHoNHRRqBagC2bVwkl5cEmDVYdy
         m/B2ZN0LABQOewEOWCyAr0JrEufKZX49xSoIMb6LKc0ZJVDmd4t4W3dcOQQGZr8Pdv5i
         pTU+UyZ9SpJEyyr5/Uq3fTAPCGcCUU29cfS2SFd/hfb76FmsyJcubJIZhSL/DynNAKk0
         Ms1W/jxSiuyUy/SUWCAStrpxWftxJrKMbh0SV+RiR4z6lFtf4f1fdLddHOs/dTNPsQu0
         S/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa3GRcwzbnQAVI8/mGmAauFKtqtSttK1albzEWprGaiMoaVBUNCFA8EyBIM+IG3KlHRwhrCxj744H3ay4gE+evQmrCU/PoKt/NZFQrrB2Q+UubJZ0a
X-Gm-Message-State: AOJu0YztJn2R8KJNHqzeuqInabhlV2TMsolG9sOZJKiUm66Q7r3NHHip
	qRqkVseCR/yaagZOVh5DrVtfnKgMco8R2APXoEE5L6AINLnLKEV0cLy5+oKAfa6MGe/fWwKQH5G
	9Mw==
X-Google-Smtp-Source: AGHT+IG+AWPXfoUCb1Oi86gOdIU3+gShVVbb026/H7Tu9SdBzskU+3a26qTumDrP4NKVHaPqPJ5R/T8IRu4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:534d:0:b0:629:b0b9:e381 with SMTP id
 41be03b00d2f7-6374183ee66mr2181a12.7.1715299868986; Thu, 09 May 2024 17:11:08
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:00 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-44-edliaw@google.com>
Subject: [PATCH v4 43/66] selftests/ptrace: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog


