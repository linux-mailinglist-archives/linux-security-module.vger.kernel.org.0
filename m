Return-Path: <linux-security-module+bounces-3372-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195D8CB71C
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 03:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE531F27068
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182B4BAA6;
	Wed, 22 May 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vygb7nTa"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22404207D
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339599; cv=none; b=Mq5WmrW8YUFoOONH0Ajx1ZDIfcHw3pJ3rhPqoEd+9WbAydrX+vbstcyMkBOFP+4zTs2Vdn/RJI3B1IMDaYUe8wY7VtTeFxyIqf+wGjNibKMV7gRd/RJsaT3JFD6jRc9rPq98cXl0Ov43fjxWuG9v82PTHqTEXrHeV+TXgAJEGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339599; c=relaxed/simple;
	bh=TjcsFe0gqVzale4tacIXWA6aggwGBNR3/qZPOEmsRvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W5lfWFBls/xR1jMsM6FAITh0Uw/4nH2pMFOQJ5vzC7DwVJmqO2HktP1iSBl/2mgWtkEZ7mZwcnxntBNCLzsk0oP1bCPEdjtT5NRRcUGrPBhjlwzKl6PzagwDZssqWLB/aocdYGYjC/0hIjQCBCSUBez4pYXkdU9Hde4z8vr/zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vygb7nTa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54be7066bso23439818276.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339597; x=1716944397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ym3nXUXeH07sf/nsYazh/meC97pdGBCDIsOIJ26bWuQ=;
        b=Vygb7nTaltfQwkSIHwFz4O4/wqPIe8xBvdQZ0emCXKMSXsU+PtsH2bDmmc7xS3LX3n
         /EMvc+pKmLWaapdVOGr0Ykqgkimc+a+FQnOUlNoaxS+teG07mmYgZ5rrCkQ7HrXHLg6R
         qiP2xhaJeO1PgN67xOMv1M4eHJc4rXdlF/ermp5nzaZnIOiJs37WmfDaeaY7jGLWvSAw
         NzgYrtq4IETKmsukwAcJLZabXoGRoqtc7V2+yD8EVcAndySlVV+zfcQ76S88teTiGnFl
         p23PxjYzgtwELMdYcKv9Tlud9EDSgE3zuO0HjmIKQYCClSURyg1Lpkezh+vRFDUNwCe7
         8Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339597; x=1716944397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ym3nXUXeH07sf/nsYazh/meC97pdGBCDIsOIJ26bWuQ=;
        b=HLOk2QEOQXSoicfRcf8ahDPu8STZsC3mdlPz5VyLHrkLhVGCim8emfvSsn3O/vP6Sz
         3ufppR/RGq92YlaxepkkZhuE7pY/Okj2yaBeww8iXzq2egA10tPT1dcH3H1cOfnYouZp
         Lm6bQu+wtPOEGbmJJoB/Z1z5usH0IOUWpWkw0ymGm8urUBueTlj7CM50fHKM2LdR3aBE
         zcZpSVItQR7z/1J9VFY2wnYuODyX6jedvtUouBqG2dgxMato0s6l4vfP7UsyeAH/EaUR
         hcxC7CbaUetLxvRa+X2ZJ6ci88hviE1MyWDMYia54vcVZqoMcM/4PzxCGL8yIBHV9269
         Erjw==
X-Forwarded-Encrypted: i=1; AJvYcCXc90UGtv+OQy8ixXJ1Goy1srKNeRgyksP+/kkaKdaa1Bfeq5HolDNwjl0zUqXEN+R/gYjSGVTgtMroYFzwK6voqRKD2zOnla2+CprPf0VIHpW/cnml
X-Gm-Message-State: AOJu0YwSxnyDUfAtJ9+S97IM3fnhkZ48eaFlAei4R4GdgX4ERwuiPK4m
	V7RtjIvDT3hrO6snuGYlssgnSPEar+5VNLhw53CGxL0GZq2Q44q2Psy8v6Pvnu51u5uizq3OLRA
	XSQ==
X-Google-Smtp-Source: AGHT+IGqx4zcon16q0eoDTQDxUtzKaoXEeTVLNF4sRkWHpre7T5XR+6WmP9e2dcSPYpPAo5gyN8nv9JO98E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1005:b0:dee:7db6:10df with SMTP id
 3f1490d57ef6-df4e0be43a1mr197886276.2.1716339596889; Tue, 21 May 2024
 17:59:56 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:54 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-9-edliaw@google.com>
Subject: [PATCH v5 08/68] selftests/capabilities: Drop define _GNU_SOURCE
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
 tools/testing/selftests/capabilities/test_execve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..7c37ae2407c6 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <cap-ng.h>
 #include <linux/capability.h>
 #include <stdbool.h>
-- 
2.45.1.288.g0e0cd299f1-goog


