Return-Path: <linux-security-module+bounces-11970-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90EB850CE
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610DF7E05A8
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693253126C2;
	Thu, 18 Sep 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fu5tYxIF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3133101DD
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204364; cv=none; b=cns0bTUxPrCRil8/hlqZc570VwKg2IbVRM3O2FKLchPJDHmr85klgIRmOFjwLkzRNZitpwKvzLE/YKZdUTwKpaNnnMWNLBGx4Swo7Ic8l4UVxzcmpP4KzsdVTgTsZC97m/uBQ+sMfDNVdCwgV+8tTJUQoW20LteycPz3kq/Lt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204364; c=relaxed/simple;
	bh=/5HhdQcxMvAGlf0Tsk8GdQh2Mls549x0+PiJde1VHsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QM2VGNp/Pe+pOSEcfROI+92ultdZUgzHWXN6v3v7UJBeUIREOPAOXSJVzl2l2rZ+pxwxnEPgMAWmu2sONgfWTnuApUlmGxJ4V153vOMP5tfTTZ1D/DV1419MktSM4pxJbw0JYk34815vC9mLmV3/LVLS8WiysmJk+Rz6Ainz2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fu5tYxIF; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso765605f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204360; x=1758809160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lBqaGhUvOv+7EeFvUiY/U7KvKRahgMMUHhFj4QhTCc=;
        b=fu5tYxIFzwau3Xm1wdr0WGRp5ptZCJAJQVTlKpZwqrCtlICyGAjF7UzjqvBwHsdaLP
         Kc3cVxXFggh+BePUS4Ya+lROGTLBQ6uyBkKGG+4EWlFeP2lofLzLWDKWA0jKO5AtbPXi
         3u/TZxquGICV5ffmgTzU+LnepwblIAkqXL31s1cPxdRG3ZlbplVqrdQMmsYdwxbe/eRE
         3cm8wba1+q5PPQCOx2c4EjO2s7G+czYPBxoGtfo7AWsyyqa8ExPzkUPHiCOz9+i/IuZ9
         /T7ktlHM7wqGFqSJFOi4rQ+tq0TaDFEy9v4kN+4f34aMiRrUv+fOXeM98MD7hHAyrqWz
         Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204360; x=1758809160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lBqaGhUvOv+7EeFvUiY/U7KvKRahgMMUHhFj4QhTCc=;
        b=fs5DnFbIJqvACh8kAWSZNKEfQLem+jkobme5vjsbrViNG7b91VrV+iXAMi4Fvumqv7
         dpEGBC4PC2CpXXdp05zcSUk5zqcDMhgAxn0Z758LVNUpf9oAP7CAZ5cyghzjyTLFNb9B
         jkX8rpmqNiO4/1riLMt0NOFyMxV+Do/IFksLLSG5+x4mtGGPTkMEM9yveZN8BE+oh52t
         pThPmKuNGpp7Oeg49aLDB2Tk7Ey8iP+xtSkmik9V3JC++23auuZ8+BSUJ4Lcr7MKiMtm
         4V+2he2E98gbVfnK8x+HJ4SUw5NyItMN6HkBCwXdu3iLJ8P3K0VMEiDh58tq12S/ZRly
         KfAw==
X-Forwarded-Encrypted: i=1; AJvYcCVq5geFKc3erthaIX/dXF0ivH8RG441WtQE6RNj95jonPN+/TDmzr+xIfZkVmCJTX0dnSibZ9NmMej5ZIssurl3FMY7wZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/E7Kzx8zSjf3+KiLuaKebuZULlKOecVv6MTfSbTXLXB4wJGn
	7wkjO+dl1av6p5eZwwXUzcrYvqS6gpjRKj7+0qQuFX5XKYDuvSzyrmMo3w41coxYgUyyBaT1L5I
	r4Q==
X-Google-Smtp-Source: AGHT+IHiULKUOB+EsrBDrVl5HZcjneDq5C1ugpdpG+JWPfxVb71lR0xGZgLTOsEBDQp8WA+TeuGcjvm7Gw==
X-Received: from wruk7.prod.google.com ([2002:a5d:6287:0:b0:3ec:da84:10a4])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:40cb:b0:3ee:1461:1659
 with SMTP id ffacd0b85a97d-3ee146119c6mr1267126f8f.31.1758204359630; Thu, 18
 Sep 2025 07:05:59 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:23 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-13-elver@google.com>
Subject: [PATCH v3 12/35] bit_spinlock: Include missing <asm/processor.h>
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index c0989b5b0407..59e345f74b0e 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *
-- 
2.51.0.384.g4c02a37b29-goog


