Return-Path: <linux-security-module+bounces-14711-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOxzFu5dlGnODAIAu9opvQ
	(envelope-from <linux-security-module+bounces-14711-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Feb 2026 13:24:14 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A2614BE60
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Feb 2026 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B27E300CA28
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Feb 2026 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC833984B;
	Tue, 17 Feb 2026 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ImvKomHy"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C43396E8
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331050; cv=none; b=CrQvoKEQp+8LM83jwRzzlsaVjW+IcGbbzzzuSl+RX5/c7ap7WsghGpa7JUiSSxW9B65Dv8qblJOAEPpS+FsctDIvTY/Wb3MyUs7O5HkKaAIOeSiqdwILxKE39iPtjhNC7zVnh5MLYLpfSS9TCMNNMXAg06NSnD530mi7ciu7brQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331050; c=relaxed/simple;
	bh=dJdNEL/rXIkh0T6k/muZm/9jbWjLHMJXIxuaEfvU7TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rL1pOv0AD4g8KAhhXAgldABvhddW94wwaN8HuaR4qWKAUYGpwuoYrl7k1eHA9aH56hqR2IyJTPmdR8SnpJz6HkxhFNq8EO6DYr2Vt0lC2T/Vw+t+uC+OmdUWOX/7oX+6OP23ttwKDA0Z9LWtu018crtHE6Zt4s1j68AcVF1no+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ImvKomHy; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFf2P0S2Zz80q;
	Tue, 17 Feb 2026 13:23:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771331036;
	bh=J3zSHk146ig3XRJjeWqh7P+HcWD4qnmd7iN9+SsGh5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImvKomHyOadJsJXrwyN0lE4LNcpQ+ENg1n4lYhUKhchI8DKi9y43qnnKRw2s1Fa2c
	 0X6LgvKZu3tcKXQMUlDha3tRfUNxwo0tmTM3HYJkN0anot/vCPKnSnEEyVQSGFstv+
	 TB1tHZWazGHiLr936mo8kH8de88z9gOxfEHGTadM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFf2N3wNJz8j0;
	Tue, 17 Feb 2026 13:23:56 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 2/2] landlock: Improve TSYNC types
Date: Tue, 17 Feb 2026 13:23:40 +0100
Message-ID: <20260217122341.2359582-2-mic@digikod.net>
In-Reply-To: <20260217122341.2359582-1-mic@digikod.net>
References: <20260217122341.2359582-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.25 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.91)[subject];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14711-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:mid,digikod.net:dkim,digikod.net:email]
X-Rspamd-Queue-Id: 00A2614BE60
X-Rspamd-Action: no action

Constify pointers when it makes sense.

Consistently use size_t for loops, especially to match works->size type.

Add new lines to improve readability.

Cc: Jann Horn <jannh@google.com>
Reviewed-by: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- Added Reviewed-by Günther.
---
 security/landlock/tsync.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 42cc0ef0c704..c588cdd111d3 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -290,13 +290,14 @@ static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
  * tsync_works_contains - checks for presence of task in s
  */
 static bool tsync_works_contains_task(const struct tsync_works *s,
-				      struct task_struct *task)
+				      const struct task_struct *task)
 {
 	size_t i;
 
 	for (i = 0; i < s->size; i++)
 		if (s->works[i]->task == task)
 			return true;
+
 	return false;
 }
 
@@ -318,6 +319,7 @@ static void tsync_works_release(struct tsync_works *s)
 
 	for (i = 0; i < s->capacity; i++)
 		kfree(s->works[i]);
+
 	kfree(s->works);
 	s->works = NULL;
 	s->size = 0;
@@ -329,7 +331,7 @@ static void tsync_works_release(struct tsync_works *s)
  */
 static size_t count_additional_threads(const struct tsync_works *works)
 {
-	struct task_struct *thread, *caller;
+	const struct task_struct *caller, *thread;
 	size_t n = 0;
 
 	caller = current;
@@ -368,7 +370,8 @@ static bool schedule_task_work(struct tsync_works *works,
 			       struct tsync_shared_context *shared_ctx)
 {
 	int err;
-	struct task_struct *thread, *caller;
+	const struct task_struct *caller;
+	struct task_struct *thread;
 	struct tsync_work *ctx;
 	bool found_more_threads = false;
 
@@ -438,10 +441,10 @@ static bool schedule_task_work(struct tsync_works *works,
  * shared_ctx->num_preparing and shared_ctx->num_unfished and mark the two
  * completions if needed, as if the task was never scheduled.
  */
-static void cancel_tsync_works(struct tsync_works *works,
+static void cancel_tsync_works(const struct tsync_works *works,
 			       struct tsync_shared_context *shared_ctx)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < works->size; i++) {
 		if (WARN_ON_ONCE(!works->works[i]->task))
-- 
2.53.0


