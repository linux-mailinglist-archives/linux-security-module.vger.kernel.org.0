Return-Path: <linux-security-module+bounces-511-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE7380F115
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Dec 2023 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C4AB21DD2
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Dec 2023 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04C76DC5;
	Tue, 12 Dec 2023 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rClKY08+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DFD6E;
	Tue, 12 Dec 2023 07:29:57 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCEtXdd029416;
	Tue, 12 Dec 2023 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=w1ODz96wzh/XsSmij5pnqGAR0TWyczrhaf7tqTa/lOM=;
 b=rClKY08++F+YMfiPl9BK0taJ8CwWk9sH5VojXyqee3Py41p6Vne9A6KDRtsxucHEuTOd
 EXaeiSTl3e945GYoD6YaT5qWEXdwtvDH6KNN1LL+viknx/7+tYSzcvlGnmNYsPsACgvw
 8Xn2kIXyLVE8+GEtlUP/qrpeJZf2oPgDCN0tHg4v5oEiLTChrjJV/mtCrfZtBurcYVzr
 1qCpvkxPr/Uxk9SGkC9Vk3HW9Gw7I8tkmS17hVsa1J9+RbRHBxAUt3kmeI7P8Aif/ZmH
 X9HNOVsnnNRMrBqraUXziPIWrp9E9AHuxxL2T1rs6prMJ2EDlfuJgv6RLTYjVIe9ZmQr 5w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxnjyskbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 15:29:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCEI0bi028229;
	Tue, 12 Dec 2023 15:29:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xyj233-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 15:29:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCFTh5H45220230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 15:29:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 096A620040;
	Tue, 12 Dec 2023 15:29:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6496920043;
	Tue, 12 Dec 2023 15:29:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.159.221])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Dec 2023 15:29:41 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Eric Snowberg <eric.snowberg@oracle.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Eric Snowberg as a reviewer to IMA
Date: Tue, 12 Dec 2023 10:29:36 -0500
Message-Id: <20231212152937.928126-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NIXSGYKjKeFZbtxB4Dzvje-feiDmQUhb
X-Proofpoint-ORIG-GUID: NIXSGYKjKeFZbtxB4Dzvje-feiDmQUhb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_08,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120117

Digital signature based IMA-appraisal relies heavily on kernel keyrings.
Eric Snowberg has been involved in adding the machine keyring to allow
the system owner to add their own keys.  With this addition,
IMA-appraisal usage can be extended to allow loading local and 3rd party
software keys onto the IMA keyring.

Add Eric as a reviewer.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffaac404d1e0..4dbf1cc238c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10557,6 +10557,7 @@ INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.ibm.com>
 M:	Roberto Sassu <roberto.sassu@huawei.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
+R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
-- 
2.39.3


