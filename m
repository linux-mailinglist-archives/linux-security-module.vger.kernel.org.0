Return-Path: <linux-security-module+bounces-3409-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D618CB7DE
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 03:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F01F29924
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B787153BF0;
	Wed, 22 May 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMSiG7N9"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F92B9CC
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339709; cv=none; b=ilmUHwCavZhG5s/QG0z2jrjZaV+CoH/xiPiwsjyXFSFUVrPSZU2IInWTL+37CD0Wzwao1D3uNjdhXcOO3LtEszT1Jvf+fehT0R+5xSe3cib+Vxcy6K3r3vf9LxswRvb65Drtol4zewte/cJCt/MZZp148YcrV6RxaPUnLHgP4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339709; c=relaxed/simple;
	bh=Zy+x1uRprdnX1Tlrv8ZyVGm6ZAlOs3M7f83fVZKsXqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHMDvH56UlJI80T7oUMUjs567IJzob6bApWmnY+zqnlX0QQUDtDvrAY9YuLQp5JeCz6h9GZwL6UQ+rbg2a/IulEMtIM9y9C0gG4NPLPJ+GmS15nL8HVkHhgYw6gPEUft8/7MzJducYrnu4SUQmRwKbNH5kfhNbWHJIYDXgWxTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMSiG7N9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so12784640a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339707; x=1716944507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqiMTNBgzJveM+1U2NKL51RHxmum4u5pgeXNwn+APY=;
        b=DMSiG7N9Vx2N2aLHs7pKdX+UM9nRKSI2SRAXwfTF8VvgCG7vmSYeuGBFpKseONTkly
         xnhWF5U7VrddZEJCQV0We2gKBLBv8lBfSLasG8whRSjEYUwOuGTosP5xYUja4qatAWHC
         lyesj0KwYyDzu7Rts/PhiZOLQheVAvHMdzWnG9iqwrWpH1rcEEZrSXejcbIwxgvpSePh
         1d3+1PYH27+QoNZ3LEj+VvxN9d3YfTDQqS7PPSkoqJfEsEIzgGjMRNK4cNeKLDi1oBkC
         8t8JK+ntIy738B8VB4/p/4dpFbzBeYYfOMs32dsuvpBs41kK1vx7XM1T9LT5s9cbw8NV
         L1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339707; x=1716944507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqiMTNBgzJveM+1U2NKL51RHxmum4u5pgeXNwn+APY=;
        b=sspHx1WDZidXpEUAIJOaJS8CLeHaoG72DEWDrdnkCfagaBuoKq86ngLmYLuoz5DUh4
         /o3yKGXjGUUTiURQSeKPR9sVM898lz+ObOE6yvOEETbPrXeVsfDlgoeWqg3Jm8MZ2Ru7
         cH16hxMlzCRyKlh14V0He5XBpP8kD3LWdq5r2uaDWbn85eFOeGq1/ejc29eS2Podjx6q
         4SWLqW9SkYhc5M8+jgHfEv0IbWhjadvTXbgp1LbMA8U3wyb841h8I7jp40qEoEPBibzI
         tCmkHW/Ml4nX3jl7j1TwSB0oM5W4g8aprqbAhwiCNp+zN4ZUdWDhCuHzzQE6Z9VvgqZ5
         qzaw==
X-Forwarded-Encrypted: i=1; AJvYcCXH49tlSOkIpnL+bHGw0GruocpKoGHAhm0c762cdzEcOc6MAeXXLVuwafCBJZXcwTF+isjSqOSO4RRPJ0b/zpLRp2ammiLwgCeuUME3BOw3tZ+jv+KM
X-Gm-Message-State: AOJu0YzBxihagmpSaMiQf5nDj9A1aErxjQw/2Pn78tfJApQs5fTxt4xr
	RD2C+Rd8mdHkEBChAT/5JqoCGV4Mp23Tlz2g5H6jEJO6hlTry904Uj9SUEd3voizU1HLAldEkJt
	74g==
X-Google-Smtp-Source: AGHT+IHx//11iRXfF9jU7Y+WwJe3/GdLuBAfz6WDem92qdspDh3/TEq+7NzW8GllbYjjYjpp726oyFnk0SE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:22c4:b0:1f3:aeb:321c with SMTP id
 d9443c01a7336-1f31c9e8135mr338475ad.13.1716339707160; Tue, 21 May 2024
 18:01:47 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:31 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-46-edliaw@google.com>
Subject: [PATCH v5 45/68] selftests/proc: Drop define _GNU_SOURCE
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..f92a8dce58cf 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,9 +23,6 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
-
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


