Return-Path: <linux-security-module+bounces-12526-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF8C01D7E
	for <lists+linux-security-module@lfdr.de>; Thu, 23 Oct 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310DC3AFF48
	for <lists+linux-security-module@lfdr.de>; Thu, 23 Oct 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BE315D20;
	Thu, 23 Oct 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ARAU11sL"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFF2D0611
	for <linux-security-module@vger.kernel.org>; Thu, 23 Oct 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230012; cv=none; b=MiqhgyQFWS2qXFufvOghjrncz/3SLOKDlqxOHX6uFl4V1niaSfvy73xnxySQRbMwNRo2Z0gATlfPzM+lkeShua/PEF8KVmtWssNDPXv3YziDxUdUwUj/OUCrGm52kkHTUrkec9D0EjXvzw63VcqNgREQhuv1gjCz3uwtNeMv+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230012; c=relaxed/simple;
	bh=q1noXuVmhs6IzlRRMFuZy58aKYcPzSJFmQpmGkuDL18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK8P6RPJyBuJ6nmNUbPZF9b4f0qqm0yGDXUanKRk0SqS3/wV0JerJjW8ZzahDm32bg8nM2k/7WZZvl/rwtuoiO+XbUu352q1yL8XiFctf6QDE1M7mtDWlrKlP+19gdzrKm0UKoZP9CeziCP0dBrqplFA/WhgTlFFyn/oPxzasRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ARAU11sL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761230008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI5x2xe0LgJrlOJDS01Ib8lu2qcPZVA4kvnCx2FtvEk=;
	b=ARAU11sLfSlto6LfgVIvpg8VCG786XBRpbRUGlpOnhdSTI3veQOPtRMbwqdkrvU6iU2De8
	ZCHpG4ThiWZ8OuV/qbIil8iw5kSYtEyvVFH88Q+sVDf0KDHfc3pihX3+5lzkf9dn4VdmjS
	u46a48AJdtQRJqI0LSUJBwtA3X8OlQk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] keys: Remove unnecessary local variable from proc_keys_show
Date: Thu, 23 Oct 2025 16:32:33 +0200
Message-ID: <20251023143231.2086-4-thorsten.blum@linux.dev>
In-Reply-To: <20251023143231.2086-2-thorsten.blum@linux.dev>
References: <20251023143231.2086-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'rc' is only used to temporary store the result of
calling key_task_permission(). Use the result directly and remove the
local variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..39af57af2aad 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -160,7 +160,6 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	char xbuf[16];
 	short state;
 	u64 timo;
-	int rc;
 
 	struct keyring_search_context ctx = {
 		.index_key		= key->index_key,
@@ -188,8 +187,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	}
 
 	/* check whether the current task is allowed to view the key */
-	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
-	if (rc < 0)
+	if (key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW) < 0)
 		return 0;
 
 	now = ktime_get_real_seconds();
-- 
2.51.0


