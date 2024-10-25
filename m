Return-Path: <linux-security-module+bounces-6361-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6C9AFA89
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Oct 2024 09:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609D31F2147A
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Oct 2024 07:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DA18E021;
	Fri, 25 Oct 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RQ7meULe"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4018C03C
	for <linux-security-module@vger.kernel.org>; Fri, 25 Oct 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839768; cv=none; b=L5IrbZi7hiVii2ACcn1rSC4LX96GdtL4w9nVawRgiMALqCnk47AHVgOGO/nyhQ+Md8PsWKZWhYz1NZ9a4HldgXzhGz6dwHGAQwRsCP7P5G3QFaVH6QQqTpOpzIdvAXCUnpAc9Md3DolMM/olDd4jFTY6MdAWQk944WqyLpShnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839768; c=relaxed/simple;
	bh=GYTKW8AR6kJETWDLmU3RwLAkZzS9wj4woVPeGpF5vr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j28mdYRpYPHam4il9sVUJnDxx98SE1aW8aX3M30vxdmLefHX5jMhkIqGXC9duezU9MAbz9kPHbEIT4Hv7OCCdX9k1oh7v6jrf72a7mLPhsS70cpMcNc3tYEglxMYz1X2UzCQ0Fu4hIBd46cym2kdrsrkqQd1VOopuqJ9AhvLuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RQ7meULe; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729839764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BJIqE0qSpciuGWzdnF6o/Z2xAKQwtHlYnbvWaPa6KI=;
	b=RQ7meULegmHYP1ijBo9675lMljUuAoc/gbOxFT0BmKODVHyGvOy9Fxe4Xr9SiK/3Nf3xv8
	62L3Rd9PMm4IsPlkshOpEJSlt70CfFLreb6a5DcTKbQfhkiGxG1t238CDoGhaWZcggEjJA
	iiiRNnLlpbVLmhJ725F2w6kzfV7qPx4=
From: George Guo <dongtai.guo@linux.dev>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dongtai.guo@linux.dev,
	edumazet@google.com,
	guodongtai@kylinos.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH 1/1] netlabel: Add missing comment to struct field
Date: Fri, 25 Oct 2024 15:02:29 +0800
Message-Id: <20241025070229.1006241-1-dongtai.guo@linux.dev>
In-Reply-To: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

add a comment to doi_remove in struct netlbl_calipso_ops.

Flagged by ./scripts/kernel-doc -none.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netlabel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 529160f76cac..4afd934b1238 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -208,6 +208,7 @@ struct netlbl_lsm_secattr {
  * struct netlbl_calipso_ops - NetLabel CALIPSO operations
  * @doi_add: add a CALIPSO DOI
  * @doi_free: free a CALIPSO DOI
+ * @doi_remove: remove a CALIPSO DOI
  * @doi_getdef: returns a reference to a DOI
  * @doi_putdef: releases a reference of a DOI
  * @doi_walk: enumerate the DOI list
-- 
2.34.1


