Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672FC4CEDD3
	for <lists+linux-security-module@lfdr.de>; Sun,  6 Mar 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiCFUwR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 6 Mar 2022 15:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiCFUwQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Mar 2022 15:52:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D381FA41;
        Sun,  6 Mar 2022 12:51:23 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 226FoOph022250;
        Sun, 6 Mar 2022 20:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kDQtasFnKBps0wyc7bSFbQi7VDcJ2zGDFYtS546BHZA=;
 b=Y60RCvV1egz9FbqiHb2BkanNvszyGUbmkb5kGVpj3WUEz0eH5Ni5HK0dumwS/Psnbpsb
 xFbj1IiMXyXQydnoLhR8H4q/iqnaB7+2wIFfXRRPfejCtOu0CMDwpEiobLivhQTqvxB2
 0bfEPb4UVcZ2QZf5FRmECJjmgRREhQDJhsfTgm354cAABeDuY7seE5dDhyydU4DrfwG5
 Y3eQWJqyBdMJFMteFN4/KR4sHxlooeqspBLZXkGbefddR91Ys2Vq+kTOPAFrnK5pNfAM
 +ti1dBm2xi1VoN0aFAOD9Da1h8MB+2smWQH8vtaEdKoh9NHtDQ0ZdcO1vjjIhQJxyIMQ 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emsauqhf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:19 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 226KZbGx024330;
        Sun, 6 Mar 2022 20:51:18 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emsauqhed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:18 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 226KgbEn031040;
        Sun, 6 Mar 2022 20:51:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3ekyg92mb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 226KpCbC40173968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Mar 2022 20:51:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C554811C052;
        Sun,  6 Mar 2022 20:51:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6479A11C04C;
        Sun,  6 Mar 2022 20:51:10 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.113.126])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Mar 2022 20:51:10 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v10 2/3] integrity: make integrity_keyring_from_id() non-static
Date:   Sun,  6 Mar 2022 15:50:59 -0500
Message-Id: <20220306205100.651878-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220306205100.651878-1-nayna@linux.ibm.com>
References: <20220306205100.651878-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vInnJ2XbuMj4U1kKlPDP6GH8oxuskCdY
X-Proofpoint-ORIG-GUID: MJMRwmuXhhTwdBogPB4vIRGqWoNzKVjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-06_08,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203060140
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make integrity_keyring_from_id() non-static so that it is accessible
by other files in security/integrity.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 security/integrity/digsig.c    | 2 +-
 security/integrity/integrity.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index c8c8a4a4e7a0..9c3165c07935 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -39,7 +39,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
 
-static struct key *integrity_keyring_from_id(const unsigned int id)
+struct key *integrity_keyring_from_id(const unsigned int id)
 {
 	if (id >= INTEGRITY_KEYRING_MAX)
 		return ERR_PTR(-EINVAL);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 2e214c761158..76e9a9515f99 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -168,6 +168,7 @@ int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
 			       const void *data, size_t len, key_perm_t perm);
+struct key *integrity_keyring_from_id(const unsigned int id);
 #else
 
 static inline int integrity_digsig_verify(const unsigned int id,
@@ -195,6 +196,11 @@ static inline int __init integrity_load_cert(const unsigned int id,
 {
 	return 0;
 }
+
+static inline struct key *integrity_keyring_from_id(const unsigned int id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
-- 
2.27.0

