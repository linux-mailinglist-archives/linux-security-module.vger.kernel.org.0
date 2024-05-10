Return-Path: <linux-security-module+bounces-3159-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831348C1B6A
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2024 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F42AB2348A
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2024 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B913DDBF;
	Fri, 10 May 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMrb/fZw"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B913DDAB
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299907; cv=none; b=SOdLviVQH5dlu/DafcfdaOCaB5js7O/rspeVf1lH/bOO3s1NioRJ+8Xaicsekhg68WpNoUhDy/DlimthRoi0+VN12azUDPZ6VA/YWwzMz/1DgVtq0UofHnZOmhMP4a40ZutNc6ZqWKCxnAEAT8z09uQkIZNBeCNnUmwBVo4No9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299907; c=relaxed/simple;
	bh=ePampeVNrBlZKDN+0BSw41zefNA0MNugUHscvuEKTwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G0DG+NxWn9Em/PS9TRCUSI3YNBiO7n97sY3E9kJNnLKBphKNOkMlOj3EN3D03Jkt0BB2jbGlLM/wqLu17kjfeTnHGo/2EB86Cgx8L/4/8AffMiKR518N16FaI6sYLyRHLy6HWlZr+7q79FIA7VY/djlMT+yim3895oLwEghDFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMrb/fZw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b38f8cac9dso1943220a91.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299906; x=1715904706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm4mQmUfjR+WgpaOe5aEacZBA1kgFDY/sgKTjpP98e4=;
        b=EMrb/fZwcD55D5cFaUrWtFupfB19CKLb10vUjZEUOF93zz3lCAv7BsGYS2sjE6nNn6
         hZuoq1LT8U6L5ZucLHv5xZhL/1qv0kErwSxfolpu3w6kG+LGjLMYEyhx5YYGrfLj8NvU
         59whe+okJaZfHSubpaaa6X4M7JQAx9asb1nVuKwoGKtoth+dMecAMc4RGXPZtJJy/SYH
         KhMDfFoG4T+l0BvRGmt/RuwVOjcPG1I8Tzw5QbzE9mWqvhV/hVnieLm8vBRqYZ4ECx38
         mhLt22bj/WmZ28uhC+s1IW7+v/q7nO2Nl55efKuZWZ/xntx/I4UulCer5IrhE+Fq+Ama
         +uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299906; x=1715904706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm4mQmUfjR+WgpaOe5aEacZBA1kgFDY/sgKTjpP98e4=;
        b=BU5MafGR/4zzGUzy7mGlM0MbAUpvNH1F78gFvjNtuwgS4pay4T8Bg6PMU2W6N/tFjO
         ZudB67mGaXou+LQg9X4zlXty5ApNVeLn9XN4eHGsWkdRX4vto65gGEw4afj3RLVSz2ew
         ZW1PPe11lHKgYW/kcz2/RGXukAHtd/LmSQN6q+qfmEpWgZcuxXln5cJAEgQjRdmNjEYn
         2xgGXUCpVgYGZudESUgloZEBp6lmKklpPjMcceAoV9HwWekwBnToS7cGsSgxbC2+vbl4
         ZYBNIZDF43j/i6CCB6J7wjsdioFzYSPVCqJnP5bAk3dNuJ9KQJGYJzEbHvAcyRW9oMpw
         ImKA==
X-Forwarded-Encrypted: i=1; AJvYcCVG2j5DihC6cgh/k75RbtLb0BQ/dRv31JPJXEAfVPQh5ao9iHzar+dnqgTiS7+5wjPfc6lyJ1sKzMvpyP8wxGBQEnM0WTX1fmFG1K1fPA2G/o8i31EK
X-Gm-Message-State: AOJu0YzhnAIhT4g8EgZeYgivYLJyawAwlapCk2NNo6calIFJ4qK7XXk4
	6shLrZZmSilMbIQYZ1P4Y694hkuRW4Zo0Nyj/6Z4DBCAP9nMgmsobeeyiiNAEizczGlxhZJzw4z
	E2g==
X-Google-Smtp-Source: AGHT+IGGq3KFPEwa7lhjHSB9rjlQ5hpVHZZ8faELDrI+h0bXPf/lmpDE5vCfaX29bPFEVhT8vg9UMGQRxfE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:1f8f:b0:2af:499a:fc9b with SMTP id
 98e67ed59e1d1-2b65fe1f31bmr26724a91.2.1715299905725; Thu, 09 May 2024
 17:11:45 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:13 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-57-edliaw@google.com>
Subject: [PATCH v4 56/66] selftests/sigaltstack: Drop define _GNU_SOURCE
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
 tools/testing/selftests/sigaltstack/sas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 07227fab1cc9..36b510de0195 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -6,8 +6,6 @@
  * If that succeeds, then swapcontext() can be used inside sighandler safely.
  *
  */
-
-#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.45.0.118.g7fe29c98d7-goog


