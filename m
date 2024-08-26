Return-Path: <linux-security-module+bounces-5041-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0711995EEDD
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE921F21F0F
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A71F152160;
	Mon, 26 Aug 2024 10:50:09 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE914EC4E;
	Mon, 26 Aug 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669409; cv=none; b=RgL7eFPN77iwV1YKalpjqfTzoxhecbM5Q8aXNpDPFLu6YI8f5tHLcwUkRrryJGxF/bGKB4tD6AGGmS2WSUUraRMG0IFMqKRK1y+IKxZWFo0BPtYw1OxUOwBr0qWavbD/BAqSOzOI333QTVJhMikXu9lwdopLTheA0E154yE9oOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669409; c=relaxed/simple;
	bh=+8yWqdXXLHGTFoBRqwclamyaWePmRERrr6FXaYFygho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Na27IwKosyxDT/Jk2QEFDQwV0Iqw0B/XSgKlMzvLljUrJOAvMrXYyXMSXbRtUT/fHJ54uk1QYPYm4Pu2Kmbbwi2GWa1uZZ1kIRdD8iwsqp2k4dDOZ5kJJG3Fhx9SWMe+rIWiYbyX4YTD0wQYenejsvdgIk/XLz9KfdiMqRIgp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbVfg003421;
	Mon, 26 Aug 2024 05:37:31 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbVYw003420;
	Mon, 26 Aug 2024 05:37:31 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 05/14] Add root domain trust implementation.
Date: Mon, 26 Aug 2024 05:37:19 -0500
Message-Id: <20240826103728.3378-6-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826103728.3378-1-greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trust.c contains the support infrastructure for anchoring the
root modeling domain to a Trusted Platform Modul (TPM)
implementation if one is available.

The Platform Configuation Register (PCR) that is selected for the
trust root is extended with the security state coefficients that
each security event maps into.

Also included is functionality that computes the hardware
platform aggregate measurement that is the linear extension sum
over PCR register 0 through 8.  The hardware aggregate
measurement is generated and maintained in multiple cryptographic
digest forms depending on the cryptographic hash functions used
in the security modeling namespaces that request the value of the
hardware aggregate.
---
 security/tsem/trust.c | 261 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)
 create mode 100644 security/tsem/trust.c

diff --git a/security/tsem/trust.c b/security/tsem/trust.c
new file mode 100644
index 000000000000..762bca735afc
--- /dev/null
+++ b/security/tsem/trust.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * On a platform that has access to a TPM device, this file is
+ * responsible for maintaining a root of trust based on that device.
+ *
+ * As with other trusted platform implementations the root of trust is
+ * a linear extension measurement maintained in a Platform
+ * Configuration Register (PCR) on the TPM device.
+ *
+ * The PCR is extended with each unique security state coefficient
+ * that is generated by the model being implemented for the
+ * root security modeling namespace.  As with other trusted systems
+ * the value of the PCR will be variable depending on scheduling
+ * artifacts that are experienced by the root modeling namespace.
+ *
+ * TSEM uses a strategy of executing the TPM extension transactions
+ * using an ordered workqueue rather than doing them at the time the
+ * security event is processed.  This is done both for performance
+ * reasons and the fact that the coefficient extensions may arise from
+ * security events that are being invoked by processes running in
+ * atomic context.
+ *
+ * If the trust_init() function detects the presence of a TPM an
+ * ordered workqueue with the following name is created:
+ *
+ * tsem_tpm
+ *
+ * The tsem_trust_add_event() function places a work request
+ * containing a description of the event on this workqueue that will
+ * then asynchronously extend the security state coefficient of the
+ * event into the PCR being used to measure the trust state of
+ * the root security modeling namespace.
+ *
+ * This file is also responsible for providing the hardware aggregate
+ * measurement for injection into both internally and externally
+ * modeled namespaces.  The hardware aggregate value is the linear
+ * extension sum of PCR registers 0 through 8.
+ *
+ * Since TSEM supports multiple cryptographic digest functions on a
+ * namespace by namespace basis the hardware aggregate value is
+ * maintained in multiple digest forms.  The tsem_trust_aggregate()
+ * function returns a pointer to the digest value for the
+ * cryptographic digest function that is being used by the security
+ * modeling namespace in effect for the calling process.
+ */
+
+#include <linux/tpm.h>
+
+#include "tsem.h"
+
+static struct workqueue_struct *tpm_update_wq;
+
+static u8 zero_aggregate[HASH_MAX_DIGESTSIZE];
+
+static struct tpm_chip *tpm;
+
+static struct tpm_digest *digests;
+
+struct hardware_aggregate {
+	struct list_head list;
+	char *name;
+	u8 value[HASH_MAX_DIGESTSIZE];
+};
+
+DEFINE_MUTEX(hardware_aggregate_mutex);
+LIST_HEAD(hardware_aggregate_list);
+
+static struct hardware_aggregate *find_aggregate(void)
+{
+	struct hardware_aggregate *aggregate;
+
+	list_for_each_entry(aggregate, &hardware_aggregate_list, list) {
+		if (!strcmp(aggregate->name,
+			    tsem_context(current)->digestname))
+			goto done;
+	}
+	aggregate = NULL;
+
+ done:
+	return aggregate;
+}
+
+static struct hardware_aggregate *add_aggregate(u8 *new_aggregate)
+{
+	struct hardware_aggregate *aggregate;
+
+	aggregate = kzalloc(sizeof(*aggregate), GFP_KERNEL);
+	if (!aggregate)
+		return NULL;
+
+	aggregate->name = kstrdup(tsem_context(current)->digestname,
+				  GFP_KERNEL);
+	if (!aggregate->name) {
+		kfree(aggregate);
+		return NULL;
+	}
+	memcpy(aggregate->value, new_aggregate, tsem_digestsize());
+
+	list_add(&aggregate->list, &hardware_aggregate_list);
+
+	return aggregate;
+}
+
+/**
+ * tsem_trust_aggregate() - Return a pointer to the hardware aggregate.
+ *
+ * This function returns a pointer to the hardware aggregate encoded
+ * with the hash function for the current modeling domain.
+ *
+ * Return: A pointer is returned to the hardware aggregate value that
+ *	   has been cached.
+ */
+u8 *tsem_trust_aggregate(void)
+{
+	u8 aggregate[HASH_MAX_DIGESTSIZE], *retn = zero_aggregate;
+	u16 size;
+	unsigned int lp;
+	struct tpm_digest pcr;
+	struct hardware_aggregate *hw_aggregate;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	if (!tpm)
+		return retn;
+
+	mutex_lock(&hardware_aggregate_mutex);
+
+	hw_aggregate = find_aggregate();
+	if (hw_aggregate) {
+		retn = hw_aggregate->value;
+		goto done;
+	}
+
+	shash->tfm = tsem_digest();
+	if (crypto_shash_init(shash))
+		goto done;
+
+	if (tpm_is_tpm2(tpm))
+		pcr.alg_id = TPM_ALG_SHA256;
+	else
+		pcr.alg_id = TPM_ALG_SHA1;
+	memset(pcr.digest, '\0', TPM_MAX_DIGEST_SIZE);
+
+	for (lp = 0; lp < tpm->nr_allocated_banks; lp++) {
+		if (pcr.alg_id == tpm->allocated_banks[lp].alg_id) {
+			size = tpm->allocated_banks[lp].digest_size;
+			break;
+		}
+	}
+
+	for (lp = 0; lp < 8; ++lp) {
+		if (tpm_pcr_read(tpm, lp, &pcr))
+			goto done;
+		if (crypto_shash_update(shash, pcr.digest, size))
+			goto done;
+	}
+	if (!crypto_shash_final(shash, aggregate)) {
+		hw_aggregate = add_aggregate(aggregate);
+		if (hw_aggregate)
+			retn = hw_aggregate->value;
+	}
+
+ done:
+	mutex_unlock(&hardware_aggregate_mutex);
+
+	if (retn == zero_aggregate)
+		pr_warn("tsem: Error generating platform aggregate\n");
+
+	return retn;
+}
+
+static void tpm_update_worker(struct work_struct *work)
+{
+	int amt, bank, digestsize;
+	struct tsem_event *ep;
+
+	ep = container_of(work, struct tsem_event, work);
+	digestsize = ep->digestsize;
+
+	for (bank = 0; bank < tpm->nr_allocated_banks; bank++) {
+		if (tpm->allocated_banks[bank].digest_size > digestsize) {
+			amt = digestsize;
+			memset(digests[bank].digest, '\0',
+			       tpm->allocated_banks[bank].digest_size);
+		} else
+			amt = tpm->allocated_banks[bank].digest_size;
+		memcpy(digests[bank].digest, ep->mapping, amt);
+	}
+
+	if (tpm_pcr_extend(tpm, CONFIG_SECURITY_TSEM_ROOT_MODEL_PCR,
+			   digests))
+		pr_warn("tsem: Failed TPM update.\n");
+
+	tsem_event_put(ep);
+}
+
+/**
+ * tsem_trust_add_point() - Add a measurement to the trust root.
+ * @ep: A pointer to the security event description whose measurement
+ *	is to be extended into the TPM.
+ *
+ * This function extends the platform configuration register being
+ * used to document the hardware root of trust for internally modeled
+ * domains with a security event coefficient value.
+ *
+ * Return: If the extension fails the error return value from the
+ *	   TPM command is returned, otherwise a value of zero is
+ *	   returned.
+ */
+int tsem_trust_add_event(struct tsem_event *ep)
+{
+	bool retn;
+
+	if (!tpm)
+		return 0;
+
+	tsem_event_get(ep);
+	ep->digestsize = tsem_digestsize();
+
+	INIT_WORK(&ep->work, tpm_update_worker);
+	retn = queue_work(tpm_update_wq, &ep->work);
+
+	return 0;
+}
+
+static int __init trust_init(void)
+{
+	int retn = -EINVAL, lp;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		return retn;
+
+	tpm_update_wq = alloc_ordered_workqueue("tsem_tpm", 0);
+	if (IS_ERR(tpm_update_wq)) {
+		retn = PTR_ERR(tpm_update_wq);
+		goto done;
+	}
+
+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests), GFP_NOFS);
+	if (!digests) {
+		tpm = NULL;
+		return retn;
+	}
+	for (lp = 0; lp < tpm->nr_allocated_banks; lp++)
+		digests[lp].alg_id = tpm->allocated_banks[lp].alg_id;
+	retn = 0;
+
+ done:
+	if (retn) {
+		destroy_workqueue(tpm_update_wq);
+		kfree(digests);
+	}
+
+	return retn;
+}
+
+device_initcall_sync(trust_init);
-- 
2.39.1


