Return-Path: <linux-security-module+bounces-2961-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D158BEF0A
	for <lists+linux-security-module@lfdr.de>; Tue,  7 May 2024 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9001F24F93
	for <lists+linux-security-module@lfdr.de>; Tue,  7 May 2024 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A214B94D;
	Tue,  7 May 2024 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAOb0VTr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BD78B60
	for <linux-security-module@vger.kernel.org>; Tue,  7 May 2024 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118338; cv=none; b=pkOSgD5fW77Yg8MeW3/c7gubS9sE20eHTampGonHSFvXM+cXZbNwHn0MP8brUxn7J1AKK3aCf/gFMRwLx32McWuYJ0nXQrfBEML+LO1KkKp0j1WBnZPQNDffKAZOOL7qS8SWmZ/Fwdj3KQgcMl86wHgFzSmp1TBRA7v531DNnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118338; c=relaxed/simple;
	bh=u1WhBmcckAt2rdhPGlHMEW1L6rz0lHqek1WxWKv+Lpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dsRZyA/OsB2TOjjBIe7fRO2TCu02GFYJY+2D9/fgQhdOpfgF/hZVMc1ZJVvQgFm+zbaR40ssem++yUiKTa64aNGDlAfPX+v7miZEXjvW+H1mKbjer1SubZ3sClQKc0XjTHZnRZqtkiHNU/8aTvy68TffDZFgqb44m/+itycgT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAOb0VTr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso74786067b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715118336; x=1715723136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxqkolGdAHnL6PdsZ65UERLJRMYbiNDsN8K6maFf6SM=;
        b=EAOb0VTrPa0tgInHil+vnvBckQGZucDqfwvtGJfDLsKxwUt6aDMz9FzfrLNEiKUiWx
         A82FDY5UaQ3tDdNFRZxcjHUsG41rlv92k4eKKpZYWkYoWQsOO/xh7oRNXBkIT7COUfwN
         Wqiu85thMq9c2nhmYYFmQ7jwvh0zx8Vn1B+Vxb88WGBqDtCl5BDXOnxGVrZlODe0VFnh
         HnjqSQ3H5IkMdC+93OwNMVM52Pfid1yMsQyVoJjGrPgHTZgsDcH9TN39O1Xst2WX10ZQ
         c15OvAuaaV6COMyBPjRJyQ1xTAusna1000y7vafImuBeX/te9uk9Q0HIehMo19kbpOTI
         y5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118336; x=1715723136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxqkolGdAHnL6PdsZ65UERLJRMYbiNDsN8K6maFf6SM=;
        b=sGoXfNjcKxVSbTTG5BSyfpm6ee9z/oRXAao7OrfqHmYQrUTztEXD4vm4sI0Lr28YAO
         32i/N1Qc4b8kzD563D4N5fjsGrUg8PilYhX5/CBKRooAWZ2/zsqmnoMeWxZBobR9Kjq7
         0UzUIqPkP+0ByiewSlocOuKpGGxj5XYyUtB+H5Pk4UotSqVM8nuAqnlGyTNOsAeplbFC
         tqA8IxT6MOJI2J3s22Q/p8Is4N6IjjVU4MvBIzTWYUQojNH+TdeqTiQrKZfamnOigdIU
         POKckHKBYiA2TBs9BVsE+ELKRmEha8fpT670uidZlVhC42VLAiZ+igoGwvoeG3gux1oJ
         WXZw==
X-Forwarded-Encrypted: i=1; AJvYcCVX+CawrTGNHjigDjFnsdoMGnNBogIzv/Jgc+XVntzmvZY4mxQDxNOp8aRw/1pUNLe3df/WD09WEcMHKyz+nreaz6eYbHhy0L/BwIDhOa8zyr9MK7lD
X-Gm-Message-State: AOJu0Yy0slF74svPhFVfJY92M7iN5TFbCgQTMWOl1IdnyhGMMc69coUh
	nciJ/5ydBTVCL6z4Hi+828xb8Nhax4AxqEp0Ci+B2dT9XRZaYtNOYDvktQcbPkTsRuh9t2Tgg7t
	wvA==
X-Google-Smtp-Source: AGHT+IGJgoOMG1JaBSE0UtHVyyig8KidzCIEzcvbINCcSvOASMpuIMj9uEKB71a44HvjahOWnOHiagC8tKE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1007:b0:deb:8bc5:eb5b with SMTP id
 3f1490d57ef6-debb9d87cd3mr271839276.5.1715118336096; Tue, 07 May 2024
 14:45:36 -0700 (PDT)
Date: Tue,  7 May 2024 21:38:27 +0000
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507214254.2787305-3-edliaw@google.com>
Subject: [PATCH v2 2/5] selftests/sgx: Include KHDR_INCLUDES in Makefile
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Seth Forshee <sforshee@kernel.org>, 
	Bongsu Jeon <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add KHDR_INCLUDES to the CFLAGS to pull in the kselftest harness
dependencies (-D_GNU_SOURCE).

Also, remove redefinitions of _GNU_SOURCE in the source code.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile    | 2 +-
 tools/testing/selftests/sgx/sigstruct.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..26ea30fae23c 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror $(KHDR_INCLUDES) -g $(INCLUDES) -fPIC
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index d73b29becf5b..200034a0fee5 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
-#define _GNU_SOURCE
 #include <assert.h>
 #include <getopt.h>
 #include <stdbool.h>
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


