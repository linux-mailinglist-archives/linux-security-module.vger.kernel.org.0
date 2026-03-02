Return-Path: <linux-security-module+bounces-15059-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK1cNHDfpGn5ugUAu9opvQ
	(envelope-from <linux-security-module+bounces-15059-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Mon, 02 Mar 2026 01:53:04 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D71D2358
	for <lists+linux-security-module@lfdr.de>; Mon, 02 Mar 2026 01:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4E0300B9E4
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Mar 2026 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D71E7C12;
	Mon,  2 Mar 2026 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqd3AUSC"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF1DDC5;
	Mon,  2 Mar 2026 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412717; cv=none; b=ey0klRXxZlp3iDhB0XcB6BxGbHXT3V5D4/i00NYsfCVxcB9hxa/E1P5HdYDJVWyTtVPglM6HtnlgqAReaWVY6LAzfBrM9HpbtVidnBzmA1tsOKqNVymiauTUcy1M6vM/T22SI7AbXYio1VrB6J82ouC39ewpIfOmOcE1S+53Z6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412717; c=relaxed/simple;
	bh=gEnZzOPlr/pGSdp2NBRsYp0+b2CQTTTgpenMn0guDwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekzwQBDNCZlJe1tRcVRkqYHMtSY19hwE5rIdmlW6b9r29BipZmF04a9++VWfcOM3dvaRdhXEwbpGHAcZbBNBCBE1FTnoLgoPKlDjEbEYRNKl3CEova5Bp58bcHasW/GnhJ6b6IH+DlhZmlo7s6eYHntiQ0fDL9BFfFGE3KsasXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vqd3AUSC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3K8zpBQg3FXVAxGmjdQ7iDBhiF4rMaXTwVkx5Jp15TE=; b=vqd3AUSCi/N47AQsZtURUJWjPi
	xp67zhLM01jPIpTXnwSv8K7mKAi1IKeJPiSqU7an9c8wa5OFvySoqDGnjLnFpqkVE/aEa0lvv6rq9
	3kdzp7NymTNWl1Pvbze61X7BOj7AG0B5GuZf5sc/X3Y0pWUxtMY9DB2sR/UyJXKEfm28romj8Yqfj
	1zHP/2b1ugcf7GHzu6kanuo6O4tLWBpdsEyODEtB28ZK2khsOhj8nRf86m0LaCsZ3fUgHFzysBcb/
	HTSiVBF5+7YlXS9hPB6N81XRoDqkBaz8Fgbl6L+Bd/r5gyOk4Kv+UJGUKE524wrx6qEYxhYg28q3M
	gw/su6mA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwrVr-0000000C27R-1Mnx;
	Mon, 02 Mar 2026 00:51:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] cred: cred.h: fix kernel-doc warnings
Date: Sun,  1 Mar 2026 16:51:54 -0800
Message-ID: <20260302005154.3468238-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15059-lists,linux-security-module=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: 534D71D2358
X-Rspamd-Action: no action

Use the correct function parameter names, function names, or kernel-doc
format, and add function return comment sections to avoid kernel-doc
warnings:

Warning: include/linux/cred.h:43 function parameter 'gi' not described
 in 'get_group_info'
Warning: include/linux/cred.h:43 No description found for return value
 of 'get_group_info'
Warning: include/linux/cred.h:213 No description found for return value
 of 'get_cred_many'
Warning: include/linux/cred.h:260 function parameter '_cred' not described
 in 'put_cred_many'
Warning: include/linux/cred.h:260 expecting prototype for put_cred().
 Prototype was for put_cred_many() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>
Cc: linux-security-module@vger.kernel.org

 include/linux/cred.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-next-20260227.orig/include/linux/cred.h
+++ linux-next-20260227/include/linux/cred.h
@@ -33,12 +33,14 @@ struct group_info {
 
 /**
  * get_group_info - Get a reference to a group info structure
- * @group_info: The group info to reference
+ * @gi: The group info to reference
  *
  * This gets a reference to a set of supplementary groups.
  *
  * If the caller is accessing a task's credentials, they must hold the RCU read
  * lock when reading.
+ *
+ * Returns: @gi
  */
 static inline struct group_info *get_group_info(struct group_info *gi)
 {
@@ -209,6 +211,8 @@ DEFINE_CLASS(override_creds,
  * usage count.  The purpose of this is to attempt to catch at compile time the
  * accidental alteration of a set of credentials that should be considered
  * immutable.
+ *
+ * Returns: @cred when the references are acquired, NULL otherwise.
  */
 static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
 {
@@ -246,8 +250,8 @@ static inline const struct cred *get_cre
 }
 
 /**
- * put_cred - Release a reference to a set of credentials
- * @cred: The credentials to release
+ * put_cred_many - Release a reference to a set of credentials
+ * @_cred: The credentials to release
  * @nr: Number of references to release
  *
  * Release a reference to a set of credentials, deleting them when the last ref

