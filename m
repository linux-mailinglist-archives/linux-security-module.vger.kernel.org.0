Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8772277A49F
	for <lists+linux-security-module@lfdr.de>; Sun, 13 Aug 2023 04:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHMCQA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 12 Aug 2023 22:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMCP7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 12 Aug 2023 22:15:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09779E3;
        Sat, 12 Aug 2023 19:16:01 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37D23On8001718;
        Sun, 13 Aug 2023 02:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2K+xOl9iCiEdHbs8U9vWbwZhgSfvBN7iaw7oWsKkQPc=;
 b=Y1MlxIf/1ZjDvARGS/38b29bYPgWKDhDA8lLNVpODheoWZHzVE8EqrZOPoShmLD9arzy
 SFO8Ig+6nfkQuUNZkyKMxO1etM6NSoq9umm46EcWA4d/hdrIxWnht+tV0JUd4WDMK0P8
 1d8PjmxcK8A1cNfjeYm+RCoXbQJ8939c5L01vx40azrROo2AmN/eg3FVk5Ja/j4Q6t0e
 tlI2Rjf85LKibNSNEdGE8IpOzlJbqfvWT70z+BdfN0T57u97IVxnH2VnxwflhHLOdZ68
 LmJcDEsZB7Wu2yO03sGXZiPKFWdbQLeHYu9Azbyyx8VSJskstD/x6+RIY16w1sXvxFcq EA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sep23g9jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 02:15:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37D1JJRG002421;
        Sun, 13 Aug 2023 02:15:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendmgakp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 02:15:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37D2FnC046792962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Aug 2023 02:15:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB32020043;
        Sun, 13 Aug 2023 02:15:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE75720040;
        Sun, 13 Aug 2023 02:15:47 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 13 Aug 2023 02:15:47 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3 4/6] integrity: check whether imputed trust is enabled
Date:   Sat, 12 Aug 2023 22:15:29 -0400
Message-Id: <20230813021531.1382815-5-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230813021531.1382815-1-nayna@linux.ibm.com>
References: <20230813021531.1382815-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q8MMqNLo0iQYYxOCPC_ddTykZoT6zN_v
X-Proofpoint-GUID: Q8MMqNLo0iQYYxOCPC_ddTykZoT6zN_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_27,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308130016
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

trust_moklist() is specific to UEFI enabled systems. Other platforms
rely only on the Kconfig.

Define a generic wrapper named imputed_trust_enabled().

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig.c                    |  2 +-
 security/integrity/integrity.h                 |  5 +++--
 .../integrity/platform_certs/keyring_handler.c |  3 ++-
 .../integrity/platform_certs/machine_keyring.c | 18 ++++++++++++++++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index d0704b1597d4..df387de29bfa 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -113,7 +113,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
-		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
+		if (id == INTEGRITY_KEYRING_MACHINE && imputed_trust_enabled())
 			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bdc..d7553c93f5c0 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -320,13 +320,14 @@ static inline void __init add_to_platform_keyring(const char *source,
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
-bool __init trust_moklist(void);
+bool __init imputed_trust_enabled(void);
 #else
 static inline void __init add_to_machine_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
-static inline bool __init trust_moklist(void)
+
+static inline bool __init imputed_trust_enabled(void)
 {
 	return false;
 }
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 1649d047e3b8..586027b9a3f5 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -61,7 +61,8 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
+		    imputed_trust_enabled())
 			return add_to_machine_keyring;
 		else
 			return add_to_platform_keyring;
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 9482e16cb2ca..a401640a63cd 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -34,7 +34,8 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	 * If the restriction check does not pass and the platform keyring
 	 * is configured, try to add it into that keyring instead.
 	 */
-	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+	if (rc && efi_enabled(EFI_BOOT) &&
+	    IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
 		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
 					 data, len, perm);
 
@@ -60,7 +61,7 @@ static __init bool uefi_check_trust_mok_keys(void)
 	return false;
 }
 
-bool __init trust_moklist(void)
+static bool __init trust_moklist(void)
 {
 	static bool initialized;
 	static bool trust_mok;
@@ -75,3 +76,16 @@ bool __init trust_moklist(void)
 
 	return trust_mok;
 }
+
+/*
+ * Provides platform specific check for trusting imputed keys before loading
+ * on .machine keyring. UEFI systems enable this trust based on a variable,
+ * and for other platforms, it is always enabled.
+ */
+bool __init imputed_trust_enabled(void)
+{
+	if (efi_enabled(EFI_BOOT))
+		return trust_moklist();
+
+	return true;
+}
-- 
2.31.1

