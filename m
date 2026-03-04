Return-Path: <linux-security-module+bounces-15310-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JuCAuWKqGlXvgAAu9opvQ
	(envelope-from <linux-security-module+bounces-15310-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Wed, 04 Mar 2026 20:41:25 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543BE207282
	for <lists+linux-security-module@lfdr.de>; Wed, 04 Mar 2026 20:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FDA302F71D
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Mar 2026 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23443D6CC2;
	Wed,  4 Mar 2026 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DQBZ3tSI"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22823D5653
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653281; cv=none; b=Pv3Y9DRP+O7zU3au5U5GKPsJwe2i9p/MGHswPe6ro8fr0x4/feSnRk6fEm/TRO4shQfB7vMHIedfLIGMdWL9Ixu2h6NrW7Sp51587W3uFRNW8/mWrfTjevv9Qx62dFV+oA9IshTig5HpYs5Tco6JGR+BpKtuIMJ7SJQKL4dQbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653281; c=relaxed/simple;
	bh=s5XAnhG99USSeXVgUSWbgXCMK0v0/hR/TzdUvS1VJ8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuy/rwuRP2kRyOdgHsUPA80wzzHoNSfvH29Mjw+eKQpKmZagEdSwDdv0KJ2EZarmEbgu7ZRFsKTt7TcsinIBkF3JbCXxUB+RkUEGCls7Rs4WN7LEF2cyQJX4kTCU8Yh3nC1PP6EpcSmBEzmFgaA6HOOMBNr5SIDJ4pU75mznZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DQBZ3tSI; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fR2q72hbkzb0h;
	Wed,  4 Mar 2026 20:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772652707;
	bh=AphWglXpcagLgevXEHTccmDxJenKNpWo31IVMCGMGIg=;
	h=From:To:Cc:Subject:Date:From;
	b=DQBZ3tSIYVpxGdD0s7F4q7nyh3nPAq5kSnfPf4bBnDyRAjasQZ157QRAIXqMGJx0E
	 2LPNJ9ouoX/+L/RsNR4lQQsXidfPiXjxa+a6XTt6mYXBUoktLZOOXGSdOBhWQVapZW
	 +/sObXWK88nPfQ+HLZLlX3exfsOenktwIQDnPpj0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fR2q671B4zvRb;
	Wed,  4 Mar 2026 20:31:46 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/4] landlock: Fix kernel-doc warning for pointer-to-array parameters
Date: Wed,  4 Mar 2026 20:31:24 +0100
Message-ID: <20260304193134.250495-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Queue-Id: 543BE207282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.07 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15310-lists,linux-security-module=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The insert_rule() and create_rule() functions take a
pointer-to-flexible-array parameter declared as:

  const struct landlock_layer (*const layers)[]

The kernel-doc parser cannot handle a qualifier between * and the
parameter name in this syntax, producing spurious "Invalid param" and
"not described" warnings.

Introduce landlock_layer_array_t as a typedef for the flexible array
type so the parameter can be written as:

  const landlock_layer_array_t *const layers

This is the same type but kernel-doc parses it correctly, while
preserving the pointer-to-array type safety that prevents callers from
accidentally passing a pointer to a single element.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/ruleset.c | 4 ++--
 security/landlock/ruleset.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 419b237de635..a61ced492f41 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -108,7 +108,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 
 static struct landlock_rule *
 create_rule(const struct landlock_id id,
-	    const struct landlock_layer (*const layers)[], const u32 num_layers,
+	    const landlock_layer_array_t *const layers, const u32 num_layers,
 	    const struct landlock_layer *const new_layer)
 {
 	struct landlock_rule *new_rule;
@@ -205,7 +205,7 @@ static void build_check_ruleset(void)
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
 		       const struct landlock_id id,
-		       const struct landlock_layer (*const layers)[],
+		       const landlock_layer_array_t *const layers,
 		       const size_t num_layers)
 {
 	struct rb_node **walker_node;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 9d6dc632684c..87d52031fb5a 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -37,6 +37,14 @@ struct landlock_layer {
 	access_mask_t access;
 };
 
+/*
+ * Flexible array of Landlock layers, used for pointer-to-array function
+ * parameters that reference either a stack-allocated layer array or a rule's
+ * flexible array member (struct landlock_rule.layers).  This typedef avoids
+ * the complex (*const name)[] syntax that the kernel-doc parser cannot handle.
+ */
+typedef struct landlock_layer landlock_layer_array_t[];
+
 /**
  * union landlock_key - Key of a ruleset's red-black tree
  */
-- 
2.53.0


