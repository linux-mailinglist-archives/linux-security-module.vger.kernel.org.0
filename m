Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9177CBF3
	for <lists+linux-security-module@lfdr.de>; Tue, 15 Aug 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjHOLqY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 15 Aug 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjHOLqB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Aug 2023 07:46:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A3171F;
        Tue, 15 Aug 2023 04:46:00 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBh0is028669;
        Tue, 15 Aug 2023 11:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7DP/Q/hdQzJhswhaeMjJO8a+YDVLokFn098hnf6tMK8=;
 b=dBFYrqtQrK0B3axK48PpS7bTUEgg+STtGdJZPdQPMh48PciRfPh6TwWFan8GTOxIlQ8R
 XarDxdt7Zx7b9zfgo3zeHKzmfnxfqycaoDx+op3CxYo8qM2OaQ6UhWNeLZRrti31eSQ4
 MOSmG7am2+3424cFlQx/FRTHUS4JlHCfJOUr40ggSE4yXY4JaIbzAVu/W3NN3NZ4Yx6a
 bVQHEKw+11DHge8efPiKWjyAztT9Pi1RMma9w2lsIao/Ez88zXsc7HJnbWSPwb/mFnDU
 8umgCZozKaFG9u1wxafoJuQi19JDXrfPH0wW7oMT8eRV0pFisaIEG5Bltiq2rizd01PE gw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg8qy81fa-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:45:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37F8o951018920;
        Tue, 15 Aug 2023 11:27:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41bsg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:27:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37FBRYlc5636652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:27:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB67920040;
        Tue, 15 Aug 2023 11:27:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E30620043;
        Tue, 15 Aug 2023 11:27:32 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Aug 2023 11:27:32 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 0/6] Enable loading local and third party keys on PowerVM guest
Date:   Tue, 15 Aug 2023 07:27:16 -0400
Message-Id: <20230815112722.1591829-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yc7FbDNlJv9AoCdA7QD2NPr9cBhAPEhp
X-Proofpoint-ORIG-GUID: yc7FbDNlJv9AoCdA7QD2NPr9cBhAPEhp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On a secure boot enabled PowerVM guest, local and third party code signing
keys are needed to verify signed applications, configuration files, and
kernel modules.

Loading these keys onto either the .secondary_trusted_keys or .ima
keyrings requires the certificates be signed by keys on the
.builtin_trusted_keys, .machine or .secondary_trusted_keys keyrings.

Keys on the .builtin_trusted_keys keyring are trusted because of the chain
of trust from secure boot up to and including the linux kernel.  Keys on
the .machine keyring that derive their trust from an entity such as a
security officer, administrator, system owner, or machine owner are said
to have "imputed trust." The type of certificates and the mechanism for
loading them onto the .machine keyring is platform dependent.

Userspace may load certificates onto the .secondary_trusted_keys or .ima
keyrings. However, keys may also need to be loaded by the kernel if they
are needed for verification in early boot time. On PowerVM guest, third
party code signing keys are loaded from the moduledb variable in the
Platform KeyStore(PKS) onto the .secondary_trusted_keys.

The purpose of this patch set is to allow loading of local and third party
code signing keys on PowerVM.

Changelog:

v4:

* Fixed build error reported by Nageswara R Sastry
<rnsastry@linux.ibm.com>, as part of his testing of patches.
* Included Jarkko's and Mimi's feedback

v3:

* Included Jarkko's feedback for Patch 6/6.

v2:

* Patch 5/6: Update CA restriction to allow only key signing CA's.
* Rebase on Jarkko's master tree - https://kernel.googlesource.com/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
* Tested after reverting cfa7522f280aa95 because of build failure due to
this commit.

Nayna Jain (6):
  integrity: PowerVM support for loading CA keys on machine keyring
  integrity: ignore keys failing CA restrictions on non-UEFI platform
  integrity: remove global variable from machine_keyring.c
  integrity: check whether imputed trust is enabled
  integrity: PowerVM machine keyring enablement
  integrity: PowerVM support for loading third party code signing keys

 certs/system_keyring.c                        | 30 ++++++++++++++++
 include/keys/system_keyring.h                 |  4 +++
 security/integrity/Kconfig                    |  4 ++-
 security/integrity/digsig.c                   |  2 +-
 security/integrity/integrity.h                |  5 +--
 .../platform_certs/keyring_handler.c          | 19 ++++++++++-
 .../platform_certs/keyring_handler.h          | 10 ++++++
 .../integrity/platform_certs/load_powerpc.c   | 34 +++++++++++++++++++
 .../platform_certs/machine_keyring.c          | 22 +++++++++---
 9 files changed, 121 insertions(+), 9 deletions(-)

-- 
2.31.1
