Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3401D1F0333
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jun 2020 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgFEXA1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 5 Jun 2020 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgFEXAX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA6C08C5C5
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 16:00:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x22so5641941pfn.3
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=DddQCiXRX1Ff2VjJue5029khE7zXTPVOk4i+DChznThHLDeXlzG3+nvkXj6POMuacx
         /eRQIscx6ELQ1tOSpsNWu/DTbYWenBGkNgLwCgp3TEntHPXj+XzM91HLMps6eoy05kRh
         7kiDFmG4F4kh0v2oSO0tlMVuHdQJXQsAwU/4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=k8YwAZ++qSmEA1Su5IAmmqCOGCjTUjbjoKHfK9JiTA7UdB7/0kD3Jm2d6V8/Mqfe3o
         Ngfli2zQdBHpvOZMw67UgefzWomM+8nSVJFwMAUfIDO8uPiqoFPul+8UsY4r0bciMp27
         6qxz75zJmwvNq9Kp2333R5ZHtAsCYHng3XtTWBX4dAyoif1vzHe/qnrPCmw1LiIAGcq7
         MJf6O4fFe6yO8uAlfPV4IIN+e+LqlzgWmOGljyRXdprWipwh8OeuEJ49QlvfzyCF82Wn
         Qc70tKF8PxnvCgzl/kQFJ3HwW7/Sw5qVLgbCwxLhnv4FSCf8e5U2SnZbm0BfXp1KCMGr
         9wRQ==
X-Gm-Message-State: AOAM530U2BDCkKvXNKfTVcwQIrgcJwpa9cHTpeEhRjTKxjECc9aNALmw
        evEv3igJpjnC7lsCf8GWdMawHg==
X-Google-Smtp-Source: ABdhPJyTPXETXSC+SDrmIjf0gnNUpufJi6Oy/4CmnBDCfqCwUDWV86SBReuy8swdd2AyratRREv+ww==
X-Received: by 2002:a62:770d:: with SMTP id s13mr12085282pfc.266.1591398023080;
        Fri, 05 Jun 2020 16:00:23 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:22 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v6 4/8] firmware: test partial file reads of request_firmware_into_buf
Date:   Fri,  5 Jun 2020 15:59:55 -0700
Message-Id: <20200605225959.12424-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605225959.12424-1-scott.branden@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add firmware tests for partial file reads of request_firmware_into_buf.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index fcc281373b4d..38e89ba1b4d3 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -149,6 +149,26 @@ config_unset_into_buf()
 	echo 0 >  $DIR/config_into_buf
 }
 
+config_set_buf_size()
+{
+	echo $1 >  $DIR/config_buf_size
+}
+
+config_set_file_offset()
+{
+	echo $1 >  $DIR/config_file_offset
+}
+
+config_set_partial()
+{
+	echo 1 >  $DIR/config_partial
+}
+
+config_unset_partial()
+{
+	echo 0 >  $DIR/config_partial
+}
+
 config_set_sync_direct()
 {
 	echo 1 >  $DIR/config_sync_direct
@@ -207,6 +227,35 @@ read_firmwares()
 	done
 }
 
+read_firmwares_partial()
+{
+	if [ "$(cat $DIR/config_into_buf)" == "1" ]; then
+		fwfile="${FW_INTO_BUF}"
+	else
+		fwfile="${FW}"
+	fi
+
+	if [ "$1" = "xzonly" ]; then
+		fwfile="${fwfile}-orig"
+	fi
+
+	# Strip fwfile down to match partial offset and length
+	partial_data="$(cat $fwfile)"
+	partial_data="${partial_data:$2:$3}"
+
+	for i in $(seq 0 3); do
+		config_set_read_fw_idx $i
+
+		read_firmware="$(cat $DIR/read_firmware)"
+
+		# Verify the contents are what we expect.
+		if [ $read_firmware != $partial_data ]; then
+			echo "request #$i: partial firmware was not loaded" >&2
+			exit 1
+		fi
+	done
+}
+
 read_firmwares_expect_nofile()
 {
 	for i in $(seq 0 3); do
@@ -319,6 +368,21 @@ test_batched_request_firmware_into_buf()
 	echo "OK"
 }
 
+test_batched_request_firmware_into_buf_partial()
+{
+	echo -n "Batched request_firmware_into_buf_partial() $2 off=$3 size=$4 try #$1: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $4
+	config_set_file_offset $3
+	config_trigger_sync
+	read_firmwares_partial $2 $3 $4
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct()
 {
 	echo -n "Batched request_firmware_direct() $2 try #$1: "
@@ -371,6 +435,22 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware_into_buf $i normal
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 0 10
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 0 5
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 1 6
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 2 10
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i normal
 done
-- 
2.17.1

