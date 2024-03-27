Return-Path: <linux-security-module+bounces-2329-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3F88D8E1
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476C6B21E44
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1038DFE;
	Wed, 27 Mar 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="JUuOLwHM"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1F31A81
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527920; cv=none; b=HkCzadug2op8js9l2vhjD6oSrKcNB+jPMHmfgauO+jdUdTtj6MlHtF4InMkMCQ0738gNwgHD290rWSyoSzXuxmgedIdIaBwyuffjJWcF4/2xeAbKmn47hCiFtvAFHTPVrE3p0ac3B7rysh/hjJCZYvkPHmozxpEgEs/c2pq0Yag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527920; c=relaxed/simple;
	bh=C4f+kFBy0hAQAYDAa01rmYY1nrmGyMmYFu2esSN4yes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptM1Z5dgd2peWa0FN9Q3eEjbg6bKNkuNizHgruQhqF+QcHJfcXpzORy3Gtuye17w+nR6huEtp7lzvghAKKJhBfuBcSFkKp8GzY3AxnRa6EdXPzNzPXmFmZLpjY8JOYgHIEJZvrE1SpRWvsveSmQFpt2P2jI2RQBhNitILzVWRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=JUuOLwHM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e285a33bdso3938009f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1711527917; x=1712132717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41GOPkTc4lXAIZ+9zm1p6sZ+N7KmKdpT4tLVWCOmpjY=;
        b=JUuOLwHMx9zBO73wuvgAl5783kTwSoGx7XIDdNE/pKn/y4k5mYjOUDWZ5wGjJ1XfyU
         777VqNNZZMCSv+lyy9lxlk5WHj0lhQYPFu309JuESmzW1IuX07qf64Bkx9/AF7KvUjdu
         qtoQ5UAUPnx26nUzyuYDzpc+MQrsmBWl0ZkpreVtKmfK3wTq4a9JNhYWuVg9/0DOC8rK
         /D0KJQmelwHXLc9mO9UWjdoYN/P2AlYqlSD9MKTUEvVZcB7ig3pQ0RRwQD0CRRwJuLeH
         os6FR4lA7gAwTT/uZ5NSUk/9gO/KTysc/6L5QGshtPCcxWsda6/qBuRZ4bozCMTGgmwG
         65jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527917; x=1712132717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41GOPkTc4lXAIZ+9zm1p6sZ+N7KmKdpT4tLVWCOmpjY=;
        b=Ugl5nhh2/MhBwrbkaqv/5Dg+sRT0oa0f4wAZPl0RjaBJtxWb/Q7RpT8HASByHukHeO
         4n7jRicXvZQrqKzJHHOVn09C7F2SeFmviVvG3T57QrN9waE8wjCekixd8etgq9siTljz
         +xtX9MDji+4tyWsPgMscV5zBBCmX+3qz+6eNvqtd+82G4v0c94v8mM/WUJtivl6xJZdJ
         OnxtmuAakbQrot4+DW8bb1PStRZn9u8+Vg0IbFTtgKNX2W0lR+4qGiTELB0f3HjSAaCr
         XQm8RZl8ElJBqPmd4cOVXbqLgSfhAtnHjqwOKcZy5oJXe+hIpYqhDy9U6l0jTjG5E+Hq
         paLg==
X-Forwarded-Encrypted: i=1; AJvYcCWF99V20DVqlcUs/DOE6Vv3zR2XcOiPO+Qu08yJJfM/xTAHpzDdl0m1iagPT/YjSRb0XssWR2KpKq6CiEIHPhqj1g3uYIUZZoGmmT7yuKQK94ZKJwL2
X-Gm-Message-State: AOJu0YwjiqVHrwuXe25r5sx/aZn4CLW1TKryfKdLNf5XNMgNnVjfEq1l
	mCBnEPyiDbGyYdx0ODMDQ0hAz8M0TLlf2YP9NztckcxzADsP/k7Gfi35zl/Jsv8=
X-Google-Smtp-Source: AGHT+IHlYgiwwFkkQ0bYRo4ux1xbHOrikHhT8qJd8DY/AJq8DdShBZcoa1JSm1RCgDbg3Zs77MGl0Q==
X-Received: by 2002:adf:fd51:0:b0:33e:8c7e:608c with SMTP id h17-20020adffd51000000b0033e8c7e608cmr2580372wrs.13.1711527917000;
        Wed, 27 Mar 2024 01:25:17 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id x4-20020a5d60c4000000b00341ce1b64f0sm6951265wrt.17.2024.03.27.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:25:16 -0700 (PDT)
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
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 2/6] KEYS: trusted: improve scalability of trust source config
Date: Wed, 27 Mar 2024 09:24:48 +0100
Message-ID: <20240327082454.13729-3-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327082454.13729-1-david@sigma-star.at>
References: <20240327082454.13729-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling trusted keys requires at least one trust source implementation
(currently TPM, TEE or CAAM) to be enabled. Currently, this is
done by checking each trust source's config option individually.
This does not scale when more trust sources like the one for DCP
are added, because the condition will get long and hard to read.

Add config HAVE_TRUSTED_KEYS which is set to true by each trust source
once its enabled and adapt the check for having at least one active trust
source to use this option. Whenever a new trust source is added, it now
needs to select HAVE_TRUSTED_KEYS.

Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index dbfdd8536468..553dc117f385 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,3 +1,6 @@
+config HAVE_TRUSTED_KEYS
+	bool
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
@@ -9,6 +12,7 @@ config TRUSTED_KEYS_TPM
 	select ASN1_ENCODER
 	select OID_REGISTRY
 	select ASN1
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Platform Module (TPM) as trusted key
 	  backend. Trusted keys are random number symmetric keys,
@@ -20,6 +24,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
@@ -29,10 +34,11 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
 	  (CAAM) as trusted key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
-comment "No trust source selected!"
+if !HAVE_TRUSTED_KEYS
+	comment "No trust source selected!"
 endif
-- 
2.35.3


