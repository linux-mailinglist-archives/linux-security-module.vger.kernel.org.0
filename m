Return-Path: <linux-security-module+bounces-11974-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDFB85131
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3486417D35C
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96530313D66;
	Thu, 18 Sep 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaBODtnp"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9230C603
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204376; cv=none; b=HldU2CT1Ph5fRmwEOAVowswFVSzT93CuEr6/Blhd57/DH9yj+sEONxE4+d4vUli/b6Dn3wbhKyg8BhftKk8WKRw4Mxrv6CGjA+3EeyyAFJoH4003YuCGltIBW6/rWdGzT2nGOnbLKlbzGJxpTv7Cga+H0BHLGzsRA/6Sszhr/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204376; c=relaxed/simple;
	bh=LHYO9FLHePXvRunBbFXq2yIww9rcJFc0YdqotGUFypU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPfeY508p/9QXdfz23qGRimzLf1ymJcjM1RIkroC8YoyLXsID0TKHPqz/BPnxlCREGVtBwgAvpEbYp0B7Z/CSYfuzTMjePAVuxM7gkUKbhqksdUSH1RWxxnl/0/vZ7fFKI0d93oN80Z3jfHs0rI7muugCV9/RtWI/R6/DAGn+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaBODtnp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so4589175e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204371; x=1758809171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMl1c+2bip1CSgLpfgWYnQ0cyIrLa9qex036CuBQq14=;
        b=BaBODtnpzDBF/OFJHTE40E/4T7S7KJC0zb39WSvju68bQKDcgpKGS3jacz4BS8JY5f
         yiu8tfYSVNi4+V1dBLIHyK8G3yW0Ow1Fi9Ymqq8EUJO+cFIUxQTvkvacWgYkMIJNKvSH
         K/r00Hu+1k1icO3lcw+Tz0mxSOJhg7tdnB3RZC90NCUtf3fyrj/PPHZ0b6otHenzAn5G
         WAiGgXOKltuIiOiqAn07wQtT0cFBD5O9Y8KjkiCkkw/0iqMy/IZwsn51F5x2VG0C/srJ
         0eBMmXLXAvMH8IQY3PHD6DZ1Z65C94v2e6q/QECaIRJFRF3uZLG61xxH4ub2JWp026DD
         Idag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204371; x=1758809171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMl1c+2bip1CSgLpfgWYnQ0cyIrLa9qex036CuBQq14=;
        b=FJoCUEwii5Jah2rTDjHAgt9KP1OjiiB0IbkQFgjw8rvdRGVyWhCV08psVvMuOVQuWR
         PVqOTuHelDSt8blAIOFlHZMHnHuEbJS08NVXhhMgw749J/3lMWtnvto+IHJbaUHOi1U6
         ZauhVv2jJcdKnFgZ5oqVuxjrCtXHamX0a9zej85CC7LUU+ZlvduXXqiX5MAe5D/CAriL
         AYDPMnaOHl/4WGDxpqRbi6qInZOn8vAWCbbVLZKwEFfQ6+thDZ2DlxHCJVz6w+ihdiY9
         ho1yamnO7ucCLpw/sbtavf7Bgqeu1BemsAF8M6BeffAz3cOFddFD9JQR9FbOgAwR1Qu5
         gi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6RSu3LobTq9cogKHqvRgkOfvYGyzQLrpD5NMYM7lRDUQVNyJYDMOTnkvg34NNN7+ByONvUNHozroeaLzH48uAXJzZLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeB0AF3yPOj0iUs3IU5CisWCK4ZUUg2oHaj+wEwi7oNogDwCRN
	HA7Li4IjU02/WBLZppgaCKsM6b7JPHusthZ36d+i8FeBwuKroP+5OjrNYc46VGrwhhBTnlwF9rL
	tJQ==
X-Google-Smtp-Source: AGHT+IGGSan2NMk0haZJyAnJIFJtZQy4kWfduj7BSWtkqxKSEROyPCMlVWawyq2y1FSCfdmQzsRbgTIQaw==
X-Received: from wmbay25.prod.google.com ([2002:a05:600c:1e19:b0:464:f7d9:6b0])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64c5:0:b0:3ec:dd12:54d3
 with SMTP id ffacd0b85a97d-3ecdfa1eb5amr4911144f8f.35.1758204370434; Thu, 18
 Sep 2025 07:06:10 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:27 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-17-elver@google.com>
Subject: [PATCH v3 16/35] kref: Add capability-analysis annotations
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

Mark functions that conditionally acquire the passed lock.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kref.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index 88e82ab1367c..9bc6abe57572 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 static inline int kref_put_mutex(struct kref *kref,
 				 void (*release)(struct kref *kref),
 				 struct mutex *mutex)
+	__cond_acquires(true, mutex)
 {
 	if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
 		release(kref);
@@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
+	__cond_acquires(true, lock)
 {
 	if (refcount_dec_and_lock(&kref->refcount, lock)) {
 		release(kref);
-- 
2.51.0.384.g4c02a37b29-goog


