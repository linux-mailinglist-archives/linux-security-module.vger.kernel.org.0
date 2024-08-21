Return-Path: <linux-security-module+bounces-4971-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490C959BF8
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Aug 2024 14:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346D6B23806
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Aug 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5A19993D;
	Wed, 21 Aug 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K385DyvN"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9ED196D90
	for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243804; cv=none; b=Vfo6Kok69GxLeRWdpPSM+nzYKqhfHHSxeyLgpEOejCeZC3VmbXXUQvJQnXCngP7HvenHbz6NLeO5jdWyit0d3FJlBg1ysm9G2uwZ5f8ck5MtyHaQt4MN3poazKIXvmuIU+cY2n6XjBlos04ge1Ls48ntJ8HiyqiqLO3jemPRdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243804; c=relaxed/simple;
	bh=oivQtnOu9efmEnO/ADZ+WlTYAALrj3lzSKJQB2IwQIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QergUl0s3jCyUZ8uYv6Y6V6MCZYy347u8F0gFVVgOLw9ZlJsjyY2oLKBuOVW5v/d2mgAkr1kFeh03XkdDhnbwySPXaVPKZAxmMilNF3xbnRMwmq+54VeT+TIGT2rwv/nqpoSSkOLE8zxegOhumpE4HcDVu0WDEbB0hBuZ9tqtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K385DyvN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXncICABB6w0gnMhh6f892KrTOfN/hhwAjfLKmFuv/M=;
	b=K385DyvN4HW9LLzKH23x/A2sIFTRADHE/mDS5dmtuBH3PC/ltvn6u1iq5PE+408JObf6PN
	ZW4r+VtRWSxkbgu5DiQtKoBWqmUZ/dvYsobaHyzSGfSvJJkpY3z6UqlprfER+T9rPRzt19
	+veWyTA6f36Xyije0Srb9vVeYkc/RBA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-BBAWbVe6PLCVnuVLaV_XxA-1; Wed,
 21 Aug 2024 08:36:37 -0400
X-MC-Unique: BBAWbVe6PLCVnuVLaV_XxA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CF581956048;
	Wed, 21 Aug 2024 12:36:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 773AA300019C;
	Wed, 21 Aug 2024 12:36:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] keys: Add a key_ref_get() wrapper
Date: Wed, 21 Aug 2024 13:36:12 +0100
Message-ID: <20240821123616.60401-5-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a key_ref_get() wrapper function to go with key_ref_put() and use it
for the place that needs it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 include/linux/key.h     | 5 +++++
 security/keys/keyring.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 08062b4f807c..50a19e5f9e45 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -315,6 +315,11 @@ static inline void key_ref_put(key_ref_t key_ref)
 	key_put(key_ref_to_ptr(key_ref));
 }
 
+static inline void key_ref_get(key_ref_t key_ref)
+{
+	key_get(key_ref_to_ptr(key_ref));
+}
+
 extern struct key *request_key_tag(struct key_type *type,
 				   const char *description,
 				   struct key_tag *domain_tag,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 0eed018448cb..7f02b913c560 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -920,7 +920,7 @@ key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 
 	ctx->now = ktime_get_real_seconds();
 	if (search_nested_keyrings(keyring, ctx))
-		__key_get(key_ref_to_ptr(ctx->result));
+		key_ref_get(ctx->result);
 	return ctx->result;
 }
 


