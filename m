Return-Path: <linux-security-module+bounces-590-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89128814651
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Dec 2023 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007271F23E7F
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Dec 2023 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BA24A0A;
	Fri, 15 Dec 2023 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="H6hP073X"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082452C851
	for <linux-security-module@vger.kernel.org>; Fri, 15 Dec 2023 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso6638525e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Dec 2023 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1702638437; x=1703243237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKvuKpR6kDazmh6thDgnN9OKi8VRnTOS23Ea0LWxTCY=;
        b=H6hP073XdI8sNYFqrRvki+deJElHiGxj+CjtcHdau2MbjA90dsmQFVJebe8CoI2D0t
         S3HKMJjvlCDR6P/UJvMj/XYVglDo/AN0E3iFvxaMTd8d3p+/ztSK/CR9e67kPHJLB1PW
         J/XgShDuTf9P/H4AWVJXmnvlhe56YQLt17Azl8j6PaC+xecA99P2nvObAFqKvvyoGYEp
         PE+CpnEv166LbhC1/bR3nE/DuwdKZjyKYUbpey2Iyv5hytvM7VR4KrVRQvqheKUVNfK1
         Yofh3ss1JfVzsYjHyEU5HYo53njLQfi3B2YiMW385X66esUg92SCjNOPc5ZJVdDuhvZY
         aWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638437; x=1703243237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKvuKpR6kDazmh6thDgnN9OKi8VRnTOS23Ea0LWxTCY=;
        b=HTykFe8GM8YnXSFuFmK5bJTVQdIz9fXJEFpvSIhCht1SCdrfediNBK93MqWc4WMyHV
         GkyKNe4LTFV3jTpolew90z7c9IoWFZSrluk5bfF67VY+W2fVkFGecqYEf5eRGxQ9v8z6
         TqwbjDcgMjnr8in/0AdN7ieE4IgkCU2SUMMNcd4egsobPxpgEylmWXOqkyTjgq5nkeA4
         ENfcrayaKBXh7LS9o6yIAj3nx7WPIXhuc6GWyh7matftqiYiJCgSvqOxLhPEv54uDU+3
         FoybjkMLmbYwdA1fxRbR4H6I5vhtGkbmiaUtSX+r3Kh2+wn901Fo4QxYu4/l6pD3HhNf
         eoqQ==
X-Gm-Message-State: AOJu0YxoEagL+kDysF0jfZsKTd9K+3Qx8T46LuvTWVRejscQI8opbi4e
	LwkEZHpSGNuuG9mL34HNviXA4A==
X-Google-Smtp-Source: AGHT+IHKXg688Frx+810+en2elPMPMkwlMfj9F36utkLlJhj2Iam2iGNSmuxb5m8+dXfSkWtYdMqRg==
X-Received: by 2002:a05:600c:6743:b0:40c:3e98:56aa with SMTP id ea3-20020a05600c674300b0040c3e9856aamr6248633wmb.129.1702638437141;
        Fri, 15 Dec 2023 03:07:17 -0800 (PST)
Received: from localhost (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with UTF8SMTPSA id t9-20020a05600c198900b0040c490db950sm18462328wmq.47.2023.12.15.03.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:07:16 -0800 (PST)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v5 5/6] docs: document DCP-backed trusted keys kernel params
Date: Fri, 15 Dec 2023 12:06:32 +0100
Message-ID: <20231215110639.45522-6-david@sigma-star.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215110639.45522-1-david@sigma-star.at>
References: <20231215110639.45522-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the kernel parameters trusted.dcp_use_otp_key
and trusted.dcp_skip_zk_test for DCP-backed trusted keys.

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..c11eda8b38e0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6566,6 +6566,7 @@
 			- "tpm"
 			- "tee"
 			- "caam"
+			- "dcp"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
@@ -6581,6 +6582,18 @@
 			If not specified, "default" is used. In this case,
 			the RNG's choice is left to each individual trust source.
 
+	trusted.dcp_use_otp_key
+			This is intended to be used in combination with
+			trusted.source=dcp and will select the DCP OTP key
+			instead of the DCP UNIQUE key blob encryption.
+
+	trusted.dcp_skip_zk_test
+			This is intended to be used in combination with
+			trusted.source=dcp and will disable the check if all
+			the blob key is zero'ed. This is helpful for situations where
+			having this key zero'ed is acceptable. E.g. in testing
+			scenarios.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
-- 
2.35.3


