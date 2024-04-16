Return-Path: <linux-security-module+bounces-2755-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF388A6FCD
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Apr 2024 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4765D2823C2
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Apr 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB0130AE7;
	Tue, 16 Apr 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdQfa1YM"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24F130ADA
	for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281368; cv=none; b=q4Rfk+/mmRIISQrx7h3F6FM5GRRknCl8TRgMKEe2IEVdH6LgDLPKfSCWjkwBHZ4gNdyQ+90VmBSukvKv6S9ho4b9hiAY2XNm0JvKHDNfmE41MqNx5oXrFX+kmHKc9z8zqCdCt9kCqCKuW8BNA4VeZrRLWyzrkMBj/h1gTpKIUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281368; c=relaxed/simple;
	bh=QVMyCi85OBTLwvKYhGqmV8c15nSsfnt8Qk+CafeDfY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvX/DLtd0sqO8BaYb3uSBU6MWv7wMsh8UI1QKzvyCOiYcouoXGh8I+81s5I/tJ0Ji6nwawBflat2rnSI0CedlBOdak6hgygDDsZqS2IQandKsk749my6G5ICQe62Lt4aHYNaXnGzOQneLQWYmj5QmUnp5xWmjMdxp88H2QpFaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdQfa1YM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713281366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P0LUfI2AvXIK+dBsLwCwt18efQKG/JZH1UkFxx8/Z0=;
	b=bdQfa1YMDeBTgz1cJ5uZArtVbQJ3ObA3wrHzNS27BK7sh0hlGXFPUN5PrItP89A0QUYA5n
	/f8U2eVlCe+w8yIPyzotbDeAZJcLsuhMxgY5MVhjSNx9E1qtRAbyU5QJIreCUCDNDc0dDS
	NDkYut3osqzYiP7KKmOJCbPwOWtm4oY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-dTT1JMRkMn22hVN3YgYGNQ-1; Tue, 16 Apr 2024 11:29:24 -0400
X-MC-Unique: dTT1JMRkMn22hVN3YgYGNQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d86787efa3so38210831fa.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2024 08:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281362; x=1713886162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P0LUfI2AvXIK+dBsLwCwt18efQKG/JZH1UkFxx8/Z0=;
        b=PHU+oQq0RH6rdZN8cSPuRLRZnURbhSLjRa3oonX94UygCGIGKrS2fmty2gq0JKzGDw
         6tcxxATbCqK0e+GJ4z0ZfCgUNmvpZ8zteAvNuDPKHT+5Ek8QlPuVwuNqt1ZCOr14/jZv
         TUEHVxzr+D/Zg5USYnMmoVL/ymQgOAdyk4/Ud20DnXZlEl7ruTWmrLLVE2DZTSJsrkaO
         ZfvecZnhQyYgAig+/kG8ldzyLrMhRZhjy1HDJaCBpLzmSXj7iSyO3rX2JaDUGJRYJcq8
         Cn0zYpqU25AdhbH/DbMi5Trb20BwIoyDkYz78twCMpQYuqZME18O13LiXIynvWyV0qNN
         TxWw==
X-Forwarded-Encrypted: i=1; AJvYcCXgVBHJedTcWxepqkksFwZTKv8oRgOTikGTqOLNfv355/a5rM4NMpumSoLvHr9xwF2RYGocwLkpEvz7cZ8zJxIL9i8Afriw2BsHm6oAaTpiuXDhVG1Y
X-Gm-Message-State: AOJu0YyA6hG82GjYyQSgGguocgru0FHxfpyyTyTCh2LxbgCVw6ZLr1T0
	C1KaJYkOp/VLj4Bn1tDmWu9hS1oGKAmm134QmafulFD0rTR36dr4evYvwXyvITthY0VvSc0rJvk
	wirvnDG09FR3Y8B4FXIw4xuv/JB+fflAPMzPqRFaUiPrb2+bqEhA7dCvkupnPgJwH4rKBUYIy2a
	FhV5o99w==
X-Received: by 2002:a2e:97d4:0:b0:2d8:41c5:ad64 with SMTP id m20-20020a2e97d4000000b002d841c5ad64mr9406574ljj.13.1713281361925;
        Tue, 16 Apr 2024 08:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDl2Y27sra8V2YK8ZMhrGngTVobwwtW2ufTsiynugk1zfPTqIBdnQGj7iThjBSBtPGRZSZyQ==
X-Received: by 2002:a2e:97d4:0:b0:2d8:41c5:ad64 with SMTP id m20-20020a2e97d4000000b002d841c5ad64mr9406558ljj.13.1713281361472;
        Tue, 16 Apr 2024 08:29:21 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0041816c3049csm14695155wmq.11.2024.04.16.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:16 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] cipso: fix total option length computation
Date: Tue, 16 Apr 2024 17:29:12 +0200
Message-ID: <20240416152913.1527166-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416152913.1527166-1-omosnace@redhat.com>
References: <20240416152913.1527166-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As evident from the definition of ip_options_get(), the IP option
IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
the loop that walks the IP options to determine the total IP options
length in cipso_v4_delopt() doesn't take it into account.

Fix it by recognizing the IPOPT_END value as the end of actual options.
Also add safety checks in case the options are invalid/corrupted.

Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endpoint")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 8b17d83e5fde4..75b5e3c35f9bf 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		 * from there we can determine the new total option length */
 		iter = 0;
 		optlen_new = 0;
-		while (iter < opt->opt.optlen)
-			if (opt->opt.__data[iter] != IPOPT_NOP) {
-				iter += opt->opt.__data[iter + 1];
-				optlen_new = iter;
-			} else
+		while (iter < opt->opt.optlen) {
+			if (opt->opt.__data[iter] == IPOPT_END) {
+				break;
+			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
 				iter++;
+			} else {
+				if (WARN_ON(opt->opt.__data[iter + 1] < 2))
+					iter += 2;
+				else
+					iter += opt->opt.__data[iter + 1];
+				optlen_new = iter;
+			}
+		}
+		if (WARN_ON(optlen_new > opt->opt.optlen))
+			optlen_new = opt->opt.optlen;
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
-- 
2.44.0


