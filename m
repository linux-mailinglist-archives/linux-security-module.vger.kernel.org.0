Return-Path: <linux-security-module+bounces-12400-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB6BCF78C
	for <lists+linux-security-module@lfdr.de>; Sat, 11 Oct 2025 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4983B969E
	for <lists+linux-security-module@lfdr.de>; Sat, 11 Oct 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840AF34BA2D;
	Sat, 11 Oct 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpe+Vwbt"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE6231A30
	for <linux-security-module@vger.kernel.org>; Sat, 11 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760194163; cv=none; b=d4o0hTa+U3D062ajea/bYf8FHgU0m7W0hA845vxAxM1P5sd4eni9wmsdp8d7qJONYGwwOidG+lRLbCh97Mez2VMjn6z/Dve+gDKee4UUL3nN/jicx9b8IB8SSi+xOMtkUfpcwnUIUz9aBfS1aFZwglMumZQdH3TosI9rpSFZmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760194163; c=relaxed/simple;
	bh=2LERlmS1vY1U+NW2HOrpEvvqS8bG+J6MpZoickTEyAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpjhD1CdTdXfINzRfJ/ryQCU48ayNIN8jThXglVvUQrwR6OawMvVeEfKz6z6mS75aC+9FTJ1K6QLWr+jP7cRtc0gVRDsBavU44p8sZdBQLIM7DwYhhgNQ9ugQPDjSTBhy2OXkN59VliuqFf7k/csyqBSRXaFwomql0GSJxNPdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpe+Vwbt; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760194149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZxYRLUTD2uxRCoYKFaakgljNkh+iJSv3MNQujQNqkSw=;
	b=rpe+VwbtbpQlkCr9fqr7XX3PxCviZbVyag+t8RzbZhF+Q7kytqER/wbOIhjib6ChhTFUWO
	bYrAY+Z0Th3f9C1LqpLdvS/QLuL7GbimMaEGhNFE0v+NYIBUlMXKnMdD8ngCaHVBNTsWSa
	2dy71SokltYlrJK2P4lJ7UGarD38YMk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH] keys: Remove redundant less-than-zero checks
Date: Sat, 11 Oct 2025 16:48:24 +0200
Message-ID: <20251011144824.1257-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variables 'size_t datalen' are unsigned and cannot be less
than zero. Remove the redundant conditions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/big_key.c                   | 2 +-
 security/keys/encrypted-keys/encrypted.c  | 4 ++--
 security/keys/trusted-keys/trusted_core.c | 4 ++--
 security/keys/user_defined.c              | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index c3367622c683..d46862ab90d6 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -66,7 +66,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 
 	BUILD_BUG_ON(sizeof(*payload) != sizeof(prep->payload.data));
 
-	if (datalen <= 0 || datalen > 1024 * 1024 || !prep->data)
+	if (datalen == 0 || datalen > 1024 * 1024 || !prep->data)
 		return -EINVAL;
 
 	/* Set an arbitrary quota */
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index d70f71d37f5f..57f88ae000ba 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -786,7 +786,7 @@ static int encrypted_instantiate(struct key *key,
 	size_t datalen = prep->datalen;
 	int ret;
 
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
+	if (datalen == 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
 	datablob = kmalloc(datalen + 1, GFP_KERNEL);
@@ -847,7 +847,7 @@ static int encrypted_update(struct key *key, struct key_preparsed_payload *prep)
 
 	if (key_is_negative(key))
 		return -ENOKEY;
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
+	if (datalen == 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
 	buf = kmalloc(datalen + 1, GFP_KERNEL);
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index e2d9644efde1..b1680ee53f86 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -157,7 +157,7 @@ static int trusted_instantiate(struct key *key,
 	int key_cmd;
 	size_t key_len;
 
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
+	if (datalen == 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
 	orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
@@ -240,7 +240,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	p = key->payload.data[0];
 	if (!p->migratable)
 		return -EPERM;
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
+	if (datalen == 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
 	orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 749e2a4dcb13..686d56e4cc85 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -61,7 +61,7 @@ int user_preparse(struct key_preparsed_payload *prep)
 	struct user_key_payload *upayload;
 	size_t datalen = prep->datalen;
 
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
+	if (datalen == 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
 	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
-- 
2.51.0


