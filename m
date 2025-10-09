Return-Path: <linux-security-module+bounces-12354-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045BBCA87A
	for <lists+linux-security-module@lfdr.de>; Thu, 09 Oct 2025 20:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8284832D5
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Oct 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F4243968;
	Thu,  9 Oct 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XdrslLBy"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD423B63F
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033242; cv=none; b=IdAArMbc8WFBacaRmH6vOhjm1cD/4CCjUv0uEmOYMiz1mMQdUPDcv2rabfbYVmNgeSACm1xPDENh2Gys/7QkWScn+yGJ6zTA4kpCIvpzxUAfEyaQuLPxtMEjbdRAo2qK8GKEij6atsTYVXC63L2ZIyjkFPRo28899CRoJ65ZzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033242; c=relaxed/simple;
	bh=+XROxS/6axodpUAsRfm1JbYQuQXZCNtj0a3EoWZH/LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLbmdhIYLZVMTA7SewGWMShX4NopjzWdry/wJWnygWZqtz93/SJVcFDE3jmpmDEhLBayrEPjp47rjnRLJSu+U2JaIfA0LWQPo7D079t1urY0Pi+LrFtqRQFJ5i1L9jurSRfHQHNmQRGkhAnr8yPdzekUbKAMJk9lLi4RMiLWG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XdrslLBy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760033225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EwX0KL5LDLB0rYQfiUxmeS4R3P9DgIfWZ4jyJPaAZqI=;
	b=XdrslLByArftI55uoHmsSsnxNGGLi5UoQYq8vD1LR5CnQyBNPnLFwO13gqjf+AOI8lRdga
	1d+Q51nchqY2H4fYdTtKlxmAoIdfoNXrELZiCZUAOTIa4N4mCwl5l4LNtaaPEnfjztUmus
	tn1Am2ibCPJWaqbFRMY9sI9pqk+SskQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] keys: Replace deprecated strncpy in ecryptfs_fill_auth_tok
Date: Thu,  9 Oct 2025 20:03:17 +0200
Message-ID: <20251009180316.394708-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy_pad() instead.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index 8fdd76105ce3..2fc6f3a66135 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
 	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
 			     | ((uint16_t)minor & 0x00FF));
 	auth_tok->token_type = ECRYPTFS_PASSWORD;
-	strncpy((char *)auth_tok->token.password.signature, key_desc,
-		ECRYPTFS_PASSWORD_SIG_SIZE);
+	strscpy_pad(auth_tok->token.password.signature, key_desc);
 	auth_tok->token.password.session_key_encryption_key_bytes =
 		ECRYPTFS_MAX_KEY_BYTES;
 	/*
-- 
2.51.0


