Return-Path: <linux-security-module+bounces-12443-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF88BE1061
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Oct 2025 01:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC02A5416E0
	for <lists+linux-security-module@lfdr.de>; Wed, 15 Oct 2025 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01F3164D0;
	Wed, 15 Oct 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NbnSpDOX"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A92C3258
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760570512; cv=none; b=afqz0tOWo2jZ+i6qab0S6Wue4yRcyFlqQb5shYJ380wKqUACA36dL1rBn/tujVUOiyTwjsP1gQc+mYtaj7mrjF9mXfCigsvtVV5xkF6PoyQ9ucid/b8JL/i5Z6qtQUIBsbYe0oJSazj4bxDs2iMA7ugcKosBV5Fhaz2ctaY7+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760570512; c=relaxed/simple;
	bh=yWic66bS3VynQ/DlDLVXJvCD4KLELc71hnpgwtJZVKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGN5HYZwKNnVGXwDDiNxHKmi92SIQtdK9IogAVU3RTsO+jirl5VkpYoPb7naJHzwSTamKIJ/rIFCx9kWmP8AI3zz3QEFqioYXhZfGIvKx2hQesiuZbgnMHOJWbAa5fItPg/SZs7srA8nUOuxTLQ4KcT3T7jEHofwo2QpAdL+OiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NbnSpDOX; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760570508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I5xh0RH6Adw5rpUXdBY/V9hNljoQ73UVKA6h/cH9mIs=;
	b=NbnSpDOXfgB+2vXNaETYYzcZnRsvNYkp/oD8PO15y+dwLD/qd5pEYUVNUjyxHLR6Hjt1El
	7klBluFJmj5Bn05GWOfmQMpfYTPmOOmcd4GNBuak70EvFYkViDipUsjUAGIeHBo0oUChz/
	WplCn4rgsEg1j9AxIew0ofoR8DfswHk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: encrypted: Simplify determining 'format_len'
Date: Thu, 16 Oct 2025 01:21:12 +0200
Message-ID: <20251015232111.71276-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Don't unnecessarily negate 'format' and simplify the calculation of
'format_len' in encrypted_key_alloc() and __ekey_init().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/encrypted.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index aef438d18da8..d70f71d37f5f 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -581,7 +581,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 	if (ret < 0 || dlen < MIN_DATA_SIZE || dlen > MAX_DATA_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	format_len = (!format) ? strlen(key_format_default) : strlen(format);
+	format_len = strlen(format ?: key_format_default);
 	decrypted_datalen = dlen;
 	payload_datalen = decrypted_datalen;
 
@@ -704,7 +704,7 @@ static void __ekey_init(struct encrypted_key_payload *epayload,
 {
 	unsigned int format_len;
 
-	format_len = (!format) ? strlen(key_format_default) : strlen(format);
+	format_len = strlen(format ?: key_format_default);
 	epayload->format = epayload->payload_data + epayload->payload_datalen;
 	epayload->master_desc = epayload->format + format_len + 1;
 	epayload->datalen = epayload->master_desc + strlen(master_desc) + 1;
-- 
2.51.0


