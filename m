Return-Path: <linux-security-module+bounces-3042-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB88C1658
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A0C1C2324C
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 20:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C538594C;
	Thu,  9 May 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN8esj6P"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D192137931
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284919; cv=none; b=uu95XLDFF6kCq2jjkf+T42MF2r56BONihrNRHMudzr13OK6fu9Z+AtnRB1zmkIwS2AdtctcV4OJfceio+ORzfSpZuvKLpIb4RDmN7z5pbznkGjBLmX0vFw4dQ195jDJ0gueRFlWer6r0SD+kCL9748DyZdwlieXbTLNWqdItbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284919; c=relaxed/simple;
	bh=pT+XZwZoOeLRlGPh8pZw/75/DuYvyGsmPHR7OeRuxIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLdw0UBOCgl3pHQkEDNJHhRnf8fYVaptgN1olkBOc/jRdFJlOaXbPX0i7735bGMflMNPuHTTForG4/JV4GstIXEG5/qpoHtefenp7QwrOoj23G2FuZdYVJ3MwJMjAxHdo0rblLORsMVniQUH209sImGO4AVI40bA2+vXcupdjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN8esj6P; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so1893790276.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284917; x=1715889717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M28n04MiCB7Rki3XUCV56t9NRfCH7Yl0gF/ySSCW1F0=;
        b=SN8esj6PlFLoH9EqdS6xZcr5jJ7OJxmljsN2sEnwZPD4Ri8gxIkGxlumG8n5yBxv71
         KMB/58Wbpqrk4Q0E7z4DToiQCx3Ysdk6inUuB0ayfHUQl1vQVdCk5PhiE7L4fDshm1xo
         VQYr7hM274WrfMkut9AOOFCrJ8BZu+d027DJYZAj/SMuCyGMm7Amx262l57j11NFJm/R
         UCzRAs1gZ3ALQ76uCivG1PnNIZSTzFMDoXRAf2h9fAKsAboPZwOoUFchnivgxqP3pigd
         H2ttxDtXP/O1itgDEIzfgjKUli7Y+PJfPGx+D8yME22RP6gMs/KOpf9CGeXbxkS8xh83
         lFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284917; x=1715889717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M28n04MiCB7Rki3XUCV56t9NRfCH7Yl0gF/ySSCW1F0=;
        b=JbZLiAgwlRRhBAgg0IgR840amyshwMwkBBP0ImAFJSwpYo059k/vG2Uq2ezyDa5+La
         /ImoWatGIn/lPfRiUOqb2R6zZp9/hptXdN8t9DmFHEbThHiOfwBlCgXTmHxAMUQyBZfJ
         WB/zFiESBUM4veuX0JOaBjlt6ql3Ny8nqKGCiuD3Uo2oDaBn+/0nBnqO8HmkeqK7fwQe
         bLXPLQiG65P5Pu9az9ngDXCA1EA98qz1hJS2Roo3VSvl/kDYl3LaNwaQOHcpfUiuYHlS
         T3VzwPdQ0s8IWV7kU1yRTA1NkzuCp0Ss7DeQ2l9AgZLQPigiXcoJ+oFauhuslsp1t1wo
         TCUA==
X-Forwarded-Encrypted: i=1; AJvYcCVRWzSgBbT+Mcfeurq4nP1Cw86mlHsm4qO25+FM4plpQO37D7di3TbUPsRqPfmFg8ad2AC8kKD0JYdh6+Ob/IvrGt/6QjQM+61hLYA/55M5+vYzYANq
X-Gm-Message-State: AOJu0YyJ5+ZY/0vfphQEqOS/G0an2VCNpvOn5mMb8x53JHQJ8MKwM+QD
	WIRcroOfjIhGmTWjyqrPeInmma6wH9iEXi15UI0oWl+rU1Wb3KtHRgyqRGX2IP8KFZV2o0AEneg
	rDw==
X-Google-Smtp-Source: AGHT+IHWuDbcMQme6+YKWpzBKBlieTWCJg0j/ENyLXdW3EFA6jYO7wvSVmCsFiuxu9QxPYdg7/f2jHZsKVs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20ca:b0:dd9:2d94:cd8a with SMTP id
 3f1490d57ef6-dee4f4f51bamr60630276.9.1715284917151; Thu, 09 May 2024 13:01:57
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:17 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-26-edliaw@google.com>
Subject: [PATCH v3 25/68] selftests/ipc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
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
 tools/testing/selftests/ipc/msgque.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index c75ea4094870..45aba6aa8e1d 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


