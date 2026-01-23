Return-Path: <linux-security-module+bounces-14163-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF7VLYzicmkyrAAAu9opvQ
	(envelope-from <linux-security-module+bounces-14163-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jan 2026 03:53:00 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A66FD83
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jan 2026 03:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E973029278
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jan 2026 02:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5F3876A2;
	Fri, 23 Jan 2026 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QAfG5voc"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983CF37F8C8;
	Fri, 23 Jan 2026 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136706; cv=none; b=Z8/Rjn93r5Rcv3+kIrIB0x0kSzSdYEOhiwxgk1i9hh8AtVfWV0v/VAzPuQU/p9wU0yND36btusXjw/6tRed5hXZkfmlYtZlmCgYPaO7WTxBKyjFGa5QmfnZB1Smss6fZj4070uHWWytRKyMI7wY8ZvpGVZVIsimf8tlqhZkA+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136706; c=relaxed/simple;
	bh=ijsc2vYRTGvnu+6v0yeMDn19OX3wWsUn3E6YiSydZ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0ZblIPeJeize1L/Gk3phKwOA1OA1I224B4hSobqBkmhRtk9fFLOooOGKaxGjfWXaT8RG8hlc5mNyYp1/j8eoghy+/T+Pi5BYgMAy7sfpvAshB/HajS5AKjaCC/9f3jnsrx0NLgbSnTBVEQqEx4HXxZ2PRMGxWrXKw9cTEqpw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QAfG5voc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PeeVDlba9WeDqSD+8U9G9g9YRwqxUxNfd6Pm/uxWRtw=; b=QAfG5vocN0o8MnYwPuhQeZ6e94
	K3YA9hYxBOWQr0SOAiE9VwFQZVm1IcYBpl056c7OjLVZC9xjxOpGun2dbGozP/B84y6/RguDGTn2p
	EHUa9bCmFSer1UXep5VcOYZn3WSLTjEAawOK9aLZbWo+xG8pxebb1MGKw79dLnJLtn7GYfxjnobkV
	m11iDZ7RMj5jXiIr/VS+Yz1x5o54pbuD0OWUMA7H0ulZYRK0Zg7//BQ77a0apxMhaSH6UWJj3fW7G
	Cj9TozjLIYw45t+Q/2gdqXCpWaQDibUqw+xmbIS8zSs75CvPxH2we1h4zFnfKZQALliRXWubripAg
	LdY9gV/Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj7Gc-000000084Bt-1afB;
	Fri, 23 Jan 2026 02:51:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] landlock: fix struct layer_access_masks kernel-doc
Date: Thu, 22 Jan 2026 18:51:19 -0800
Message-ID: <20260123025121.3713403-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,digikod.net,vger.kernel.org,paul-moore.com,namei.org,hallyn.com];
	TAGGED_FROM(0.00)[bounces-14163-lists,linux-security-module=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[namei.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email,infradead.org:email,infradead.org:dkim,infradead.org:mid,digikod.net:email]
X-Rspamd-Queue-Id: 240A66FD83
X-Rspamd-Action: no action

Use the correct struct name and describe the struct member in
kernel-doc notation to prevent kernel-doc warnings.

WARNING: ../security/landlock/ruleset.h:313 expecting prototype for
  struct layer_accesses. Prototype was for struct layer_access_masks instead

Fixes: 1ebf8e8d3245 ("landlock: Transpose the layer masks data structure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Something like this is needed. Feel free to massage/correct it some.

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>

 security/landlock/ruleset.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260121.orig/security/landlock/ruleset.h
+++ linux-next-20260121/security/landlock/ruleset.h
@@ -302,9 +302,9 @@ landlock_get_scope_mask(const struct lan
 }
 
 /**
- * struct layer_accesses - A boolean matrix of layers and access rights
- *
- * This has a bit for each combination of layer numbers and access rights.
+ * struct layer_access_masks - A boolean matrix of layers and access rights
+ * @access: This has a bit for each combination of layer numbers and access
+ * rights.
  * During access checks, it is used to represent the access rights for each
  * layer which still need to be fulfilled.  When all bits are 0, the access
  * request is considered to be fulfilled.

