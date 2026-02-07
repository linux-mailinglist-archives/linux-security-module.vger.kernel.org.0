Return-Path: <linux-security-module+bounces-14577-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIA6MMUhh2mWUAQAu9opvQ
	(envelope-from <linux-security-module+bounces-14577-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sat, 07 Feb 2026 12:28:05 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C9105C13
	for <lists+linux-security-module@lfdr.de>; Sat, 07 Feb 2026 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4A913013A73
	for <lists+linux-security-module@lfdr.de>; Sat,  7 Feb 2026 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785B30CDA9;
	Sat,  7 Feb 2026 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q3b73wVC"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352021A239A
	for <linux-security-module@vger.kernel.org>; Sat,  7 Feb 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770463682; cv=none; b=sxVIt5Uig7y7Z+3+BaH0s1e7/dybD+B+r1GU/RKMMgwVnz1N3QlPKB9sg0uEkb5NiG3XvozVOa5VfXB8fXyle7Cvtj0dbJ6WApK93MvhvIP7/Gltr2i173xl02s2dEfjECTLo2IPXmenIEYp58KyuimwR8lM1MXBkk6XbQ+9FLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770463682; c=relaxed/simple;
	bh=HEzcP5cl/jKaJ71NDTHevYxVQGvgs1Qvb+5UCWLQ8AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RA4tu0EQKk6J71sg0Xo/zYAwBm7zuuMU7vzNnJHlqDjYz+jZIm9YaRSwJzu1W26SYyW59Od+Cgu0I96YQ5GiHAhrTw/bIsyq3i6B5X24qJ0Rjsk9ac/mV5P9BPySSFCfNrJrwCp1xpbwil4tlMuyzzk/AYvvk21cEdP6lig0Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q3b73wVC; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f7Svl5mN5zY0H;
	Sat,  7 Feb 2026 12:11:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770462707;
	bh=UoVtAS2Jof8vX5026Z9cSNgwqZLbIT760bNdfLH7Jbc=;
	h=From:To:Cc:Subject:Date:From;
	b=Q3b73wVCJa7RzhEJtS88FNhw0R4h1SoGSH/2nUPKKSI0pSInNSpIWjD39llsnPSCZ
	 lAQ+SSjWBEdloPX0Qy5tUK/ngJq7oX3tv5CIqV+aQjtlsoboS5l3pZRP8+dbOolVAN
	 E8+qKdMUhLX/BkUajF+mNexmpmG4LJm3j2bjKHy8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f7Svl2BBmzCNX;
	Sat,  7 Feb 2026 12:11:47 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jamorris@linux.microsoft.com>
Subject: [PATCH v1] =?UTF-8?q?mailmap:=20Add=20entry=20for=20Micka=C3=ABl?= =?UTF-8?q?=20Sala=C3=BCn?=
Date: Sat,  7 Feb 2026 12:11:35 +0100
Message-ID: <20260207111136.577249-1-mic@digikod.net>
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
X-Spamd-Result: default: False [0.59 / 15.00];
	R_MIXED_CHARSET(1.25)[subject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14577-lists,linux-security-module=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,digikod.net:email,digikod.net:dkim,digikod.net:mid,zoy.org:email,lespinasse.org:email]
X-Rspamd-Queue-Id: 016C9105C13
X-Rspamd-Action: no action

My Microsoft address is no longer used.  Add a mailmap entry to reflect
that.

Cc: Günther Noack <gnoack@google.com>
Cc: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 22db8cfc18fc..2f2a06e8d3f9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -558,6 +558,7 @@ Michel Dänzer <michel@tungstengraphics.com>
 Michel Lespinasse <michel@lespinasse.org>
 Michel Lespinasse <michel@lespinasse.org> <walken@google.com>
 Michel Lespinasse <michel@lespinasse.org> <walken@zoy.org>
+Mickaël Salaün <mic@digikod.net> <mic@linux.microsoft.com>
 Miguel Ojeda <ojeda@kernel.org> <miguel.ojeda.sandonis@gmail.com>
 Mike Rapoport <rppt@kernel.org> <mike@compulab.co.il>
 Mike Rapoport <rppt@kernel.org> <mike.rapoport@gmail.com>
-- 
2.53.0


