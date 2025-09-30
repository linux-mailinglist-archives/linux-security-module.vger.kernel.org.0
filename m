Return-Path: <linux-security-module+bounces-12268-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE8BACD7E
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Sep 2025 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9D63A4BD6
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Sep 2025 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8D25DAFF;
	Tue, 30 Sep 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="FmwOs9dd"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B025228B
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235520; cv=none; b=YFmCR4MVuMxLNUAizIJMa3fFyTGaxFcFhCYcN94DbWtImcpWn6/QIZxKzJ0vpizANLxuJYqwEDZ2B/KjwLPBiDfSjHIliU8dDsQIRLNTQ9g2FB1td4m3rYKIymXPZHofuKQ8C6MNQ1Tp2o2sr0prSVUIuak5PTUt0Nm98yCZXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235520; c=relaxed/simple;
	bh=zrNBAPbhmiQnUsjgu/rL9kusOKy4YihURGPUSO2uMGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TfbHV/6JW92lf124nVHV43d51fkeyXQkwAqk7a2Mzcj6ogE5NwRrcEmFO1MUPiR2ql4WzWkw2wAGuXeXAcymuELvy9iQiPpQlTCrkrmH/UJik1evvWh6oS8H4BK7TVqSFgztkcVdSOUEDRgPjwkxa3mVeM5vp/UCfDCz/VWqllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=FmwOs9dd; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1759235513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gbyQ95DIQAIGxuF13O+hhpNUZYlT3eYdIg1M/ClE7Q=;
	b=FmwOs9ddnb1lSmnf8cfZjNxh2RSy+Pq0qcD+/KEikd8vDqORZgMuJRauT7YmPpOtvhAbAP
	jzB9oHZfGLBen6psafblQI0+RlrkYpLOHoFnlqUmQTUP5XDGTTOq0C9/cqVb+R4y6Bbrxk
	5PC9VRlYGbmpeiVlaGnWJO9p5zob9/w=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] smack: /smack/doi: accept previously used values
Date: Tue, 30 Sep 2025 15:31:53 +0300
Message-ID: <20250930123153.138644-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Writing to /smack/doi a value that has ever been
written there in the past disables networking for
non-ambient labels.
E.g.

    # cat /smack/doi
    3
    # netlabelctl -p cipso list
    Configured CIPSO mappings (1)
     DOI value : 3
       mapping type : PASS_THROUGH
    # netlabelctl -p map list
    Configured NetLabel domain mappings (3)
     domain: "_" (IPv4)
       protocol: UNLABELED
     domain: DEFAULT (IPv4)
       protocol: CIPSO, DOI = 3
     domain: DEFAULT (IPv6)
       protocol: UNLABELED

    # cat /smack/ambient
    _
    # cat /proc/$$/attr/smack/current
    _
    # ping -c1 10.1.95.12
    64 bytes from 10.1.95.12: icmp_seq=1 ttl=64 time=0.964 ms
    # echo foo >/proc/$$/attr/smack/current
    # ping -c1 10.1.95.12
    64 bytes from 10.1.95.12: icmp_seq=1 ttl=64 time=0.956 ms
    unknown option 86

    # echo 4 >/smack/doi
    # echo 3 >/smack/doi
!>  [  214.050395] smk_cipso_doi:691 cipso add rc = -17
    # echo 3 >/smack/doi
!>  [  249.402261] smk_cipso_doi:678 remove rc = -2
!>  [  249.402261] smk_cipso_doi:691 cipso add rc = -17

    # ping -c1 10.1.95.12
!!> ping: 10.1.95.12: Address family for hostname not supported

    # echo _ >/proc/$$/attr/smack/current
    # ping -c1 10.1.95.12
    64 bytes from 10.1.95.12: icmp_seq=1 ttl=64 time=0.617 ms

This happens because Smack keeps decommissioned DOIs,
fails to re-add them, and consequently refuses to add
the “default” domain map:

    # netlabelctl -p cipso list
    Configured CIPSO mappings (2)
     DOI value : 3
       mapping type : PASS_THROUGH
     DOI value : 4
       mapping type : PASS_THROUGH
    # netlabelctl -p map list
    Configured NetLabel domain mappings (2)
     domain: "_" (IPv4)
       protocol: UNLABELED
!>  (no ipv4 map for default domain here)
     domain: DEFAULT (IPv6)
       protocol: UNLABELED

Fix by clearing decommissioned DOI definitions and
serializing concurrent DOI updates with a new lock.

Also:
- allow /smack/doi to live unconfigured, since
  adding a map (netlbl_cfg_cipsov4_map_add) may fail.
  CIPSO_V4_DOI_UNKNOWN(0) indicates the unconfigured DOI
- add new DOI before removing the old default map,
  so the old map remains if the add fails

(2008-02-04, Casey Schaufler)
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
The patch is verified to work on top of "smack: /smack/doi must be > 0" patch.
Link: https://lore.kernel.org/linux-security-module/20250930121602.138337-1-andreev@swemel.ru

 security/smack/smackfs.c | 71 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 316c2ea401e8..d27d9140dda2 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -70,6 +70,7 @@ enum smk_inos {
 static DEFINE_MUTEX(smack_cipso_lock);
 static DEFINE_MUTEX(smack_ambient_lock);
 static DEFINE_MUTEX(smk_net4addr_lock);
+static DEFINE_MUTEX(smk_cipso_doi_lock);
 #if IS_ENABLED(CONFIG_IPV6)
 static DEFINE_MUTEX(smk_net6addr_lock);
 #endif /* CONFIG_IPV6 */
@@ -141,7 +142,7 @@ struct smack_parsed_rule {
 	int			smk_access2;
 };
 
-static u32 smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
+static u32 smk_cipso_doi_value = CIPSO_V4_DOI_UNKNOWN;
 
 /*
  * Values for parsing cipso rules
@@ -663,43 +664,60 @@ static const struct file_operations smk_load_ops = {
 };
 
 /**
- * smk_cipso_doi - initialize the CIPSO domain
+ * smk_cipso_doi - set netlabel maps
+ * @ndoi: new value for our CIPSO DOI
+ * @gfp_flags: kmalloc allocation context
  */
-static void smk_cipso_doi(void)
+static int
+smk_cipso_doi(u32 ndoi, gfp_t gfp_flags)
 {
-	int rc;
+	int rc = 0;
 	struct cipso_v4_doi *doip;
 	struct netlbl_audit nai;
 
+	mutex_lock(&smk_cipso_doi_lock);
+
+	if (smk_cipso_doi_value == ndoi)
+		goto clr_doi_lock;
+
 	smk_netlabel_audit_set(&nai);
 
-	rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
-	if (rc != 0)
-		printk(KERN_WARNING "%s:%d remove rc = %d\n",
-		       __func__, __LINE__, rc);
-
-	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
+	doip = kmalloc(sizeof(struct cipso_v4_doi), gfp_flags);
+	if (!doip) {
+		rc = -ENOMEM;
+		goto clr_doi_lock;
+	}
 	doip->map.std = NULL;
-	doip->doi = smk_cipso_doi_value;
+	doip->doi = ndoi;
 	doip->type = CIPSO_V4_MAP_PASS;
 	doip->tags[0] = CIPSO_V4_TAG_RBITMAP;
 	for (rc = 1; rc < CIPSO_V4_TAG_MAXCNT; rc++)
 		doip->tags[rc] = CIPSO_V4_TAG_INVALID;
 
 	rc = netlbl_cfg_cipsov4_add(doip, &nai);
-	if (rc != 0) {
-		printk(KERN_WARNING "%s:%d cipso add rc = %d\n",
-		       __func__, __LINE__, rc);
+	if (rc) {
 		kfree(doip);
-		return;
+		goto clr_doi_lock;
 	}
-	rc = netlbl_cfg_cipsov4_map_add(doip->doi, NULL, NULL, NULL, &nai);
-	if (rc != 0) {
-		printk(KERN_WARNING "%s:%d map add rc = %d\n",
-		       __func__, __LINE__, rc);
-		netlbl_cfg_cipsov4_del(doip->doi, &nai);
-		return;
+
+	if (smk_cipso_doi_value != CIPSO_V4_DOI_UNKNOWN) {
+		rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
+		if (rc && rc != -ENOENT)
+			goto clr_ndoi_def;
+
+		netlbl_cfg_cipsov4_del(smk_cipso_doi_value, &nai);
 	}
+
+	rc = netlbl_cfg_cipsov4_map_add(ndoi, NULL, NULL, NULL, &nai);
+	if (rc) {
+		smk_cipso_doi_value = CIPSO_V4_DOI_UNKNOWN; // no default map
+clr_ndoi_def:	netlbl_cfg_cipsov4_del(ndoi, &nai);
+	} else
+		smk_cipso_doi_value = ndoi;
+
+clr_doi_lock:
+	mutex_unlock(&smk_cipso_doi_lock);
+	return rc;
 }
 
 /**
@@ -1599,11 +1617,8 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 
 	if (u == CIPSO_V4_DOI_UNKNOWN || u > U32_MAX)
 		return -EINVAL;
-	smk_cipso_doi_value = u;
 
-	smk_cipso_doi();
-
-	return count;
+	return smk_cipso_doi(u, GFP_KERNEL) ? : count;
 }
 
 static const struct file_operations smk_doi_ops = {
@@ -2984,6 +2999,7 @@ static int __init init_smk_fs(void)
 {
 	int err;
 	int rc;
+	struct netlbl_audit nai;
 
 	if (smack_enabled == 0)
 		return 0;
@@ -3002,7 +3018,10 @@ static int __init init_smk_fs(void)
 		}
 	}
 
-	smk_cipso_doi();
+	smk_netlabel_audit_set(&nai);
+	(void) netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
+	(void) smk_cipso_doi(SMACK_CIPSO_DOI_DEFAULT,
+			     GFP_KERNEL | __GFP_NOFAIL);
 	smk_unlbl_ambient(NULL);
 
 	rc = smack_populate_secattr(&smack_known_floor);
-- 
2.43.0


