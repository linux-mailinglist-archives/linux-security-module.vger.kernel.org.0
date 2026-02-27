Return-Path: <linux-security-module+bounces-15033-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGj0I44romkq0gQAu9opvQ
	(envelope-from <linux-security-module+bounces-15033-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sat, 28 Feb 2026 00:41:02 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50E1BF0C4
	for <lists+linux-security-module@lfdr.de>; Sat, 28 Feb 2026 00:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FC5B3062620
	for <lists+linux-security-module@lfdr.de>; Fri, 27 Feb 2026 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83935A39B;
	Fri, 27 Feb 2026 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fp/aQ5Px"
X-Original-To: linux-security-module@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170E40B6F1;
	Fri, 27 Feb 2026 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235591; cv=none; b=CPhwJOI7Q2UP3e7pmHniRYNaI2/HwNXbHooGYveA8IemOmyNPBm495HMxmyuzN6/hAzucpsYTNtpz0ECv2isPhV9KmS/pTpKCfFVv2p9iB+VYe9EhuAlgPTxVbZsw1MQ/rmUs/ABjecCqPNgqle71BZUUgd8B3MqZY+5cqsQ+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235591; c=relaxed/simple;
	bh=9J5pI0QzBg2k8lGD1+3yJvxO6hbHGrco/o78EYTO2Mw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV9y1BZzVHe++FhsRZn/hzl+1ZbJ2lMjVSBPXKMKQ1LRtOP8wgTk/Cmuse1cSxMO0N/gy6ZrPbytGiWXlyzfxg2jlQ8eU754ARvJh178gpEUwd0L9hseCPCrWyhBAUT2/LBwnEL8FESzR7LnmEPN/zK2T0Kn5Ic57tH5dh4pyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fp/aQ5Px; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC73320B6F03;
	Fri, 27 Feb 2026 15:39:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC73320B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235584;
	bh=XHWpOIC0JpwTONHs2oWFeOobOFzwucdVPR6LOaM0dYM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fp/aQ5Pxhyv8KmgNxkIPwWXAbuOfGv1FBsJtyLpOezDS4IM9SqTUXynVqFw8tM7M9
	 zgW/L2RqOYmCpGTyg+hAkWRZ5sj+spRGkxdEzhnugVUKn4prYNSEjc/H25kEb1F8DD
	 Gft0lR0T4h2J+uJ7qDB8ewpkoYsrSctenNwl5IN0=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 01/10] certs: break out pkcs7 check into its own function
Date: Fri, 27 Feb 2026 15:38:30 -0800
Message-ID: <20260227233930.2418522-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[linux.microsoft.com,lwn.net,paul-moore.com,namei.org,hallyn.com,digikod.net,google.com,treblig.org,linux-foundation.org,HansenPartnership.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15033-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bboscaccy@linux.microsoft.com,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hansenpartnership.com:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: AD50E1BF0C4
X-Rspamd-Action: no action

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Add new validate_pkcs7_trust() function which can operate on the
system keyrings and is simply some of the innards of
verify_pkcs7_message_sig().

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 certs/system_keyring.c       | 76 +++++++++++++++++++++---------------
 include/linux/verification.h |  2 +
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index e0761436ec7f..dcbefc2d3f6d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -298,42 +298,19 @@ late_initcall(load_system_certificate_list);
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
 /**
- * verify_pkcs7_message_sig - Verify a PKCS#7-based signature on system data.
- * @data: The data to be verified (NULL if expecting internal data).
- * @len: Size of @data.
+ * validate_pkcs7_trust - add trust markers based on keyring
  * @pkcs7: The PKCS#7 message that is the signature.
  * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
  *					(void *)1UL for all trusted keys).
- * @usage: The use to which the key is being put.
- * @view_content: Callback to gain access to content.
- * @ctx: Context for callback.
  */
-int verify_pkcs7_message_sig(const void *data, size_t len,
-			     struct pkcs7_message *pkcs7,
-			     struct key *trusted_keys,
-			     enum key_being_used_for usage,
-			     int (*view_content)(void *ctx,
-						 const void *data, size_t len,
-						 size_t asn1hdrlen),
-			     void *ctx)
+int validate_pkcs7_trust(struct pkcs7_message *pkcs7, struct key *trusted_keys)
 {
 	int ret;
 
-	/* The data should be detached - so we need to supply it. */
-	if (data && pkcs7_supply_detached_data(pkcs7, data, len) < 0) {
-		pr_err("PKCS#7 signature with non-detached data\n");
-		ret = -EBADMSG;
-		goto error;
-	}
-
-	ret = pkcs7_verify(pkcs7, usage);
-	if (ret < 0)
-		goto error;
-
 	ret = is_key_on_revocation_list(pkcs7);
 	if (ret != -ENOKEY) {
 		pr_devel("PKCS#7 key is on revocation list\n");
-		goto error;
+		return ret;
 	}
 
 	if (!trusted_keys) {
@@ -351,18 +328,55 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 		trusted_keys = NULL;
 #endif
 		if (!trusted_keys) {
-			ret = -ENOKEY;
 			pr_devel("PKCS#7 platform keyring is not available\n");
-			goto error;
+			return -ENOKEY;
 		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
-	if (ret < 0) {
-		if (ret == -ENOKEY)
-			pr_devel("PKCS#7 signature not signed with a trusted key\n");
+	if (ret == -ENOKEY)
+		pr_devel("PKCS#7 signature not signed with a trusted key\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(validate_pkcs7_trust);
+
+/**
+ * verify_pkcs7_message_sig - Verify a PKCS#7-based signature on system data.
+ * @data: The data to be verified (NULL if expecting internal data).
+ * @len: Size of @data.
+ * @pkcs7: The PKCS#7 message that is the signature.
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys).
+ * @usage: The use to which the key is being put.
+ * @view_content: Callback to gain access to content.
+ * @ctx: Context for callback.
+ */
+int verify_pkcs7_message_sig(const void *data, size_t len,
+			     struct pkcs7_message *pkcs7,
+			     struct key *trusted_keys,
+			     enum key_being_used_for usage,
+			     int (*view_content)(void *ctx,
+						 const void *data, size_t len,
+						 size_t asn1hdrlen),
+			     void *ctx)
+{
+	int ret;
+
+	/* The data should be detached - so we need to supply it. */
+	if (data && pkcs7_supply_detached_data(pkcs7, data, len) < 0) {
+		pr_err("PKCS#7 signature with non-detached data\n");
+		ret = -EBADMSG;
 		goto error;
 	}
 
+	ret = pkcs7_verify(pkcs7, usage);
+	if (ret < 0)
+		goto error;
+
+	ret = validate_pkcs7_trust(pkcs7, trusted_keys);
+	if (ret < 0)
+		goto error;
+
 	if (view_content) {
 		size_t asn1hdrlen;
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index dec7f2beabfd..57f1460d36f1 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -44,6 +44,8 @@ enum key_being_used_for {
 struct key;
 struct pkcs7_message;
 
+extern int validate_pkcs7_trust(struct pkcs7_message *pkcs7,
+				struct key *trusted_keys);
 extern int verify_pkcs7_signature(const void *data, size_t len,
 				  const void *raw_pkcs7, size_t pkcs7_len,
 				  struct key *trusted_keys,
-- 
2.52.0


