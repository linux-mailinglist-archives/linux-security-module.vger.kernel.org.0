Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629B37A82D
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Jul 2019 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfG3MYe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 30 Jul 2019 08:24:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfG3MYe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jul 2019 08:24:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so29771543pfn.5
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2019 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ub4kuUSnrD2CiYyKKwaDCU7WlCc+MjZGT8+i8BhCGSM=;
        b=MfQvx2dhjGV4/bSe60l+LebksrED1y3ZIlrOHn7KEst3uYq0lbZGY0vsMCXlHdvqTW
         Ye8auI8LrPtuk1JjxXNnkdo+hZ+99keG4VGsdhwKAsEXIsOsIUECaXlU8hbVHLFk9cLT
         HO8nBnDu0xGtOjVBUUGFJzgjgr3leWNo194UxYVJeI2Y+0v/K+qeQpXyF0PGeONbMN+i
         gW62oUUDBfxqW/m3zRut5eraL0BhFNM47K2DQzNbSup/f6DVATK2umRIZlAbmj5eTK+g
         Ie2+FR2iyP4pVV9kGjOO0QK2a+lbpVtyMzeY+CEhSSw2QwFdLdH8EHmR5UmLIl/CCH4Z
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ub4kuUSnrD2CiYyKKwaDCU7WlCc+MjZGT8+i8BhCGSM=;
        b=ceL0MIu52l/HtMsCYVRyaltbBqebXrVcEbEJcKSGfIS/CAoOlpsp3Cy/gUaMmDjoVg
         +cq1DUcBGqPzWRwrnh2XepTwIzesHcusFVY4IBfVqm7tjdISHp0ontccv5fXgFDt+Wbh
         7jeXTPyvQwgi4on1veJhr5oB2WYjF4rGsQinCgMv+XrzYbaiRbNOJq3fseGxaHDLcJEt
         2GV4tMF+QpiRnDUr2iAXtTM3Kqwq1JWj+jhZ1IIDksU909jWsNANwAACrhPqJMFj6Sf8
         3rRgovBdPgxR/guUcnN1LeA6vhXHgrsXe1m3EPoqcMQ+akk/EnoYQD+hwiKbmVugBZfs
         i9Rg==
X-Gm-Message-State: APjAAAWmFayT/S/8JA4NbADs0a+KdE9hsSFAeQ1OnwfAcK8eVaACsmOZ
        OWAzK/MbF3PswUKdIDmyV97SAw==
X-Google-Smtp-Source: APXvYqy9AOsI/bgpSrYC4bB6dRW/RMjRTTrIQ53nsJNjfy9Y+arPAlgz9XGruaRKwy6MTunT2Iwvvg==
X-Received: by 2002:a63:125c:: with SMTP id 28mr55618644pgs.255.1564489473744;
        Tue, 30 Jul 2019 05:24:33 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:24:33 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 1/6] tee: optee: allow kernel pages to register as shm
Date:   Tue, 30 Jul 2019 17:53:35 +0530
Message-Id: <1564489420-677-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kernel pages are marked as normal type memory only so allow kernel pages
to be registered as shared memory with OP-TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index aa94270..bce45b1 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -553,6 +553,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
+	/*
+	 * Allow kernel address to register with OP-TEE as kernel
+	 * pages are configured as normal memory only.
+	 */
+	if (virt_addr_valid(start))
+		return 0;
+
 	down_read(&mm->mmap_sem);
 	rc = __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
-- 
2.7.4

