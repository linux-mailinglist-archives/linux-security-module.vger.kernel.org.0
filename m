Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9105220A7C4
	for <lists+linux-security-module@lfdr.de>; Thu, 25 Jun 2020 23:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbgFYVuE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 25 Jun 2020 17:50:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389830AbgFYVuE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 17:50:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PLXYjc034725;
        Thu, 25 Jun 2020 17:50:03 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vbn7ms65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:50:03 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PLk6WF018496;
        Thu, 25 Jun 2020 21:50:02 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 31uurw32jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:50:02 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PLo1kB34537838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:50:01 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A51628058;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58F2D28068;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:50:01 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
Date:   Thu, 25 Jun 2020 17:50:00 -0400
Message-Id: <20200625215000.2052086-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200625215000.2052086-1-stefanb@linux.vnet.ibm.com>
References: <20200625215000.2052086-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_19:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250125
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Stefan Berger <stefanb@linux.ibm.com>

In case a TPM2 is attached, search for a TPM2 ACPI table when trying
to get the event log from ACPI. If one is found, use it to get the
start and length of the log area. This allows non-UEFI systems, such
as SeaBIOS, to pass an event log when using a TPM2.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/acpi.c | 62 +++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..e2258cfa6cb1 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	void __iomem *virt;
 	u64 len, start;
 	struct tpm_bios_log *log;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return -ENODEV;
+	struct acpi_table_tpm2 *tbl;
+	struct acpi_tpm2_phy *t2phy;
+	int format;
 
 	log = &chip->log;
 
@@ -61,23 +61,43 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	if (!chip->acpi_dev_handle)
 		return -ENODEV;
 
-	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
-	status = acpi_get_table(ACPI_SIG_TCPA, 1,
-				(struct acpi_table_header **)&buff);
-
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	switch(buff->platform_class) {
-	case BIOS_SERVER:
-		len = buff->server.log_max_len;
-		start = buff->server.log_start_addr;
-		break;
-	case BIOS_CLIENT:
-	default:
-		len = buff->client.log_max_len;
-		start = buff->client.log_start_addr;
-		break;
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		status = acpi_get_table("TPM2", 1,
+					(struct acpi_table_header **)&tbl);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		if (tbl->header.length <
+				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
+			return -ENODEV;
+
+		t2phy = (void *)tbl + sizeof(*tbl);
+		len = t2phy->log_area_minimum_length;
+
+		start = t2phy->log_area_start_address;
+		if (!start || !len)
+			return -ENODEV;
+
+		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	} else {
+		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
+		status = acpi_get_table(ACPI_SIG_TCPA, 1,
+					(struct acpi_table_header **)&buff);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		switch (buff->platform_class) {
+		case BIOS_SERVER:
+			len = buff->server.log_max_len;
+			start = buff->server.log_start_addr;
+			break;
+		case BIOS_CLIENT:
+		default:
+			len = buff->client.log_max_len;
+			start = buff->client.log_start_addr;
+			break;
+		}
+		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
 	}
 	if (!len) {
 		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
@@ -98,7 +118,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	return format;
 
 err:
 	kfree(log->bios_event_log);
-- 
2.26.2

