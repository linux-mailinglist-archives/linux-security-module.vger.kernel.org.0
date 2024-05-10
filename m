Return-Path: <linux-security-module+bounces-3137-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC48C1AF3
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2024 02:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89E01C235B0
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2024 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A63136648;
	Fri, 10 May 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVgXBzW6"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183B135A5A
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299841; cv=none; b=CvLj6rnrbadfmMwOaKc11QKV5bHxm2YPLIqQwD5awZ4ByuY13ouTPuq7d4OcRbwLO+Vy7gY6kw8OGyNcFBvOo4dqRP3a2l5g90tG9unnPB402vcqvbrPs0tGEeOOjDsa/bsEKHqdFzqctucyyp6ar8y7YH6iEWm/2aV3LbmJ5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299841; c=relaxed/simple;
	bh=EZsEhYoF/Nu0QGVgoNXSBfJXGSlIe/SAEA83mlUTcYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otDXyJpbh1gEBIgi5e+ltb6lRV5inGlVkT+R20IAZcE9priHLXHvbn1aNz2hivuiusXG7Kp8XeloBhoCzAcVxcGgPPCwhxEsejJlIXPNPDqbcmE4Z9s+kz8CAp61yFH4eoNS7WKYceuWop+7zEs8B6VKJ4o2ZfXqoL+xZLRrLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVgXBzW6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f452eb2066so973980b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299839; x=1715904639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zv9hDsECpk9yhgUK8qXtrMx/MNHEvKj5YS1pAX1XIVQ=;
        b=cVgXBzW6osNho1dtP48E7xj5p2gIzytz0eolHT42zXiMQsPhvSkeLu+OOFeDj2+JRj
         frZkVmMCD8lFHqSupT7YrM5dvUcmI5wynPNaiO3XbtWUbVYJHKKgOLwfafpwrzaA9Nw8
         iSItiJN2UhGjy/QlUpZ4xZ3RohO2uECP+kJpVHPIEyOBC52kQgjMpaudMOM+QHvFnPAe
         MXiYPRvFiaQH79oj+SJcUJd4SmaU3+HFf0xoIqfDX4jYn/MJdnCizt6iKCWoQoBEKjT/
         3HvvBVQNhswAxTCNId4VV7202c4t8KtNT232RJpuyWBzVxApnIRsKrbFdV1mtJVj5h76
         L6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299839; x=1715904639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv9hDsECpk9yhgUK8qXtrMx/MNHEvKj5YS1pAX1XIVQ=;
        b=BRpU5fvQBB+C+PDBgKFdqDC01C/PxwasSfFCGEQyq0zXkjPd25kmDIduN/fsKjDVCS
         p3QhuCRLeIvut5Y73YRxN56ZACpwnDTgU5PsF0yTavXAXRvUh5d6MECEgukkVLCpFHY3
         hB/vDkTeiegQTogHDSqg5hTT4XjKR1feiO6YYwcHQmnR+MSgTYLCi8849Jhpz1imT+N2
         9idBWLl8afajrJucnL0aTTFOspffzsJchzpLPc+1V3cJAHIQb2wJVTmT6ryp+eV8HNWZ
         Q4/SXeKGxI3R2GTnZqdR4HU2idoo4WXjKZty6+qCPVkKDZgB6d1KcLm83wMy2twQHppb
         GW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGbROXm0w1EoRcxP+tfvtQ9J79WLv4plKiAPAJM6MmSNDkKd9ziJpx4UIW5+KhRK+4eJ5NmerEAHca7o1XRRQ+KN9xLO2j5GEZHKySSUYl0lq/3LRb
X-Gm-Message-State: AOJu0Yz+F4a0gdQ+fsI81LxP3wiG7Q4gp+ra6jY+IUh50WlVQaxSJFZr
	hPSc+/r7SAuWYFQNwlwaoABmXXMpN3gXiIPFh2Id54hOSgH1JZnT9k0Xr9VGJYDTQVxALHsNk0z
	Bhg==
X-Google-Smtp-Source: AGHT+IGonivkS2R1HvP1jmkZSFsjyubb1aG00OxxdbDNweBSdZoLp+FL6tawzI/d9bKsCP21+ImOsTIDeB4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:928f:b0:6f3:f062:c145 with SMTP id
 d2e1a72fcca58-6f4e03a31e6mr55150b3a.4.1715299839273; Thu, 09 May 2024
 17:10:39 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:51 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-35-edliaw@google.com>
Subject: [PATCH v4 34/66] selftests/mqueue: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mqueue/mq_perf_tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index fb898850867c..43630ee0b63d 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -20,7 +20,6 @@
  *   performance.
  *
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


