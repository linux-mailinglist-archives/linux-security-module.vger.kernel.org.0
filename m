Return-Path: <linux-security-module+bounces-11152-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8EB0CDF8
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Jul 2025 01:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACDD6C49F8
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Jul 2025 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337CE253F21;
	Mon, 21 Jul 2025 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y789R92M"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E02441AF
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140268; cv=none; b=oMpHogS/cQ74gy+r5PEOX5rmjmC5twfdwnVjVj9DxGME1FRqBxyWua+hcY9nudZbc7PQOpa5Rpj4cQErkrE6V10iIMLq3B3AlqMT6yUFVXTvD0vlnXRKeiotoOQmvf7hMr0KBJON+xP0ImhZNQfWxqiv7h2RRBhkBOu/zuknIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140268; c=relaxed/simple;
	bh=rWEpVkUy2dqvcxYudz5qcZe6+gmqE6zjJ4LDoy/uBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyyA35PXLZ81QqwUdF+DsI6jreYFXUxRezxRg47rPenL6Z1+HpMuZd5++/2mhatHvKv3rwTAIUx85HOxz8GScZ0nAraASdvrz7oJDwWasZVCXOC2uAiiWBBthhei9/wqbRNsvRDibFS3RyXKCt0OaylOW+5ZLKmc6DpwYjVgTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y789R92M; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e346ab52e9so638473385a.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140265; x=1753745065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8Sty0Yvm47AQW1EJnnfuH7Z9BMi8jqNRxSa5V1vvEM=;
        b=Y789R92MI9v5iTdMpXWvAXF8os9ym7VB0mbAb/NuRqR4eoxocKiOyQEHyJM547kE+J
         Ug/HN/vMocNE8K/qZ/446nSTVQmhUPlkE6y+AApNyc77VPFZ63cNa8skDprsmCMoQgiV
         SPqitpciRRHsHtuQ2mEB7DRy4x1Hc97nXyAMMxIB3mjFhMOT3T5AaifkWxpr/MiW8R03
         UpC2mMpudKbX3asBSvDdnVQFwxKZeBNyUMcK13CHwOr2XqSYeccRrY1yjjzJCWtA8OKh
         S0iL1Knh754+UOkghNd8Infk5su6cKV6SKGFXW+cjmHtaz9xGl/2yDfR+0u4jVEE49QE
         m5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140265; x=1753745065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8Sty0Yvm47AQW1EJnnfuH7Z9BMi8jqNRxSa5V1vvEM=;
        b=wbWK4wbHPmJH+jV4N2CaBHlhn+GT9jCyNMvSceLBFWhZbsMbzFULLnQC3PZGpvD4Jb
         SY75I86eEO4kb7n75kgNt/EqT2LPXPt7OJ0i65brRm/eS1otgYfqkLYCSCwDM5jxnj/2
         b7bAlDmdaD+Y9SVdl8qFio6/b3tp6mITKVtAHVx2UhsBj1P06gpiDRJvsgBPc4m3bnRA
         GEMfll3YA0VRIHtkVG9bdZERDRm5ggK2U5yHgAsIrAV3aWlygwguwnEdkcJbdmIPriFu
         iQ1Gj97Kc31q9W5gyCl5qLg9P45EnRAHqGxAg8hL79vA/wl7qyirN/s7Iq34Qfa8DB0F
         cQLw==
X-Gm-Message-State: AOJu0YzJRVcBxU24dGeciquauFp8iPo+Jg8rKB7LrwSlo9yIGDpgitrS
	ntY80I34BymGK3v1dKjP27+qskJHYV3+YvNRcgBDk4ixcGqzMFitBO6pVy17BQ3tbHKmHW762lo
	SBZM=
X-Gm-Gg: ASbGncsrHsQ/9uv8AXt2tcC7Ylorfd7x72kKTNjUG+NFRMXy3epdmDT7FC/r5UA2RAt
	EaEGB2ShbnEDb5xgwxN30POm8xw0GIFCVFtVvDiqMOw3U1J/T9tisdfkctfHRNpeY9Y8OFn1h6K
	W0LmHkpAW6ulTYkA5sw+7+n1jRlPheccMCgpD3o/Hozj+6ygyhWmrnh/qM5n+fJ9vgbpHq3oHaE
	UMPBTpNwc9EwX9LbhpHmFyu5Lc5Wis+dOxCRdsjJ4PWCHRs0T/mfvglbxDqa0J3yv4UXJvdFk+M
	wB0JdRpHe3BOsTO2QfUCAg6kWYnOCoxANMHXZCDKwbbCzH4506vJIuUX4AD6CvpesowVuH70k8h
	iZCpUmwLbNFvhDHa1oK7mXVSdVsgSN7HYhOwz9Do+g31JHLxBUQ5mTXfMpKg5sFgUmuRLBC8EQZ
	Bd9g==
X-Google-Smtp-Source: AGHT+IF/ioivwywFnfqvSdVSQPN2IuSOsLoxM3Pn/Esma3d8AWNt592DU32kYyoZH7edPzQc0a4ppQ==
X-Received: by 2002:a05:620a:640c:b0:7e0:93bc:bf85 with SMTP id af79cd13be357-7e3435ea691mr2055145885a.34.1753140265431;
        Mon, 21 Jul 2025 16:24:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c61497sm469325685a.80.2025.07.21.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:25 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 24/34] loadpin: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:27 -0400
Message-ID: <20250721232142.77224-60-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=paul@paul-moore.com; h=from:subject; bh=rWEpVkUy2dqvcxYudz5qcZe6+gmqE6zjJ4LDoy/uBwo=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvdw9cl5BakIq0sgYNW3sKStdr6PBZN5MsfO tor3qOK3D6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L3QAKCRDqIPLalzeJ c8s2EACbdNoRMoV1ijwd+tIrou5uhKrAbPTm1eUdlY9Y3KW7u36R/O84iXs6x9oOpDQ9BRRV+md F6D9xCnJrjAjpfxJ6A9d6LcAl2hqduX0YWJG0soTu28cUKfqzh/QeuH/5z5gcjw2zbET1zkXPcf oC82iIM9TihffYbqtPLM6TqsO6dbhzVOYtx3mf7DOTmO9Sze+IoGpmw77uYhj5tR1h6jDUqX6z2 eD2QjGhPUdkm5vb3+TwMlZ9QD8CJU+F0ivc/WV4w6FaHqKGIUyVkvSQClj1MR/tI+KN4o6sVstF HvLAYxxmP4xQlG067metVdGZ4mI8qsxvaY/rPujg5M5jD7EFNSNpxWT0wVOr+EfzGUbQe6E+xf/ jv0bBQ86lqOTSoiY+GuAvmThrOw4iZ1MVDv9af74g7huwYb5dlRj5Mhtad+uXk2XJXdUpU2bfad Swij3hEkyVLI5rJlwlEs0ULL5LcL8KvlrAqzDMI/t3ocXGUH//xfOhHHzkdCdhc5DhmOjPr5Sog DCuNTAFJjJL5n4ZWwceUUNK39itsukM9akAkq2cixKlsiDa4zk4BHAJVhWFbgSRXvnmwyxgBGhi 94usN44A03+7/LCXYS0vVDmafaKQ2BK4eNxUXoiI+yPNW3Dx9k0qSYp7ur4OERG4FLI0capFtze Tx5Lcl2+y37zC4Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.50.1


