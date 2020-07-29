Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1127232461
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jul 2020 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG2SIy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 29 Jul 2020 14:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2SIu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jul 2020 14:08:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A58C0619D5
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 11:08:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so2258123pjd.3
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHo9JWZzUyjBazerQ4BEANBUtQtdpP9atcQMB9aajac=;
        b=NvT8VXoujTZ0Hj5eqlf9jwL52OCMFhndos/nuWgslFO5jsHrdJ+euSuji8sSq6MGTE
         9bdxX24HOJgiw32VpiFb2Ogi9cTWzFi89Yja1P46LAEVVsmBkg4ipNrzaLwk5f+SLIG+
         3Gek5p342VvarO/kZVcuTzVDF6NRDxs355NlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHo9JWZzUyjBazerQ4BEANBUtQtdpP9atcQMB9aajac=;
        b=HRFkS8VSjOKLyeIeNvGDY48TE+PdV59r5g+1LUkac44Rd1/7YBedwoKlHHNxweY4Bd
         3qOYyBmVixTYR/AMr5I95erDNHHBe4jr6dXn3iCg6JF7vJ6o1xKX81+w0FjwUc6GpbK/
         QuVZsFj4jlbTAij77XB5pHCGoP4HVG5HlyKs9CS4MrxbZbktZluO4b3fU6c7gexqRlEa
         qvisa7ZB5cOVc6acGuOng4nnPwvQV1dR+qt2cLMe2Y4gstF4QzKof2YHfGWN2Jgmh06W
         V+kZSRP7yoqVfbVioqbjxxihR63mN+G7Uh2V+JhSjXpNmSeqIN9E9GaHf+J/b2oKHjOo
         p+qg==
X-Gm-Message-State: AOAM530AuQX5Jn+XfScdqZaXYhqnaJbucTrYCi+SM1Lf5/2u45tKZblZ
        AozsRs6olgpDaO/q4tE85TWldQ==
X-Google-Smtp-Source: ABdhPJxCXFyAXbDqIabQ4k/mW+HoDdIBwjXl7/WETODepWvJ4iIAmA3BDJKmHWMB5w2xD1QIrM5OFg==
X-Received: by 2002:a17:90a:d583:: with SMTP id v3mr10867142pju.33.1596046129542;
        Wed, 29 Jul 2020 11:08:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25sm454550pft.134.2020.07.29.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 11:08:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/17] test_firmware: Test partial read support
Date:   Wed, 29 Jul 2020 10:58:45 -0700
Message-Id: <20200729175845.1745471-18-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Scott Branden <scott.branden@broadcom.com>

Add additional hooks to test_firmware to pass in support
for partial file read using request_firmware_into_buf():

	buf_size: size of buffer to request firmware into
	partial: indicates that a partial file request is being made
	file_offset: to indicate offset into file to request

Also update firmware selftests to use the new partial read test API.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_firmware.c                           | 154 ++++++++++++++++--
 .../selftests/firmware/fw_filesystem.sh       |  91 +++++++++++
 2 files changed, 233 insertions(+), 12 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 62af792e151c..387acb94eeea 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -50,6 +50,9 @@ struct test_batched_req {
  * @name: the name of the firmware file to look for
  * @into_buf: when the into_buf is used if this is true
  *	request_firmware_into_buf() will be used instead.
+ * @buf_size: size of buf to allocate when into_buf is true
+ * @file_offset: file offset to request when calling request_firmware_into_buf
+ * @partial: partial read opt when calling request_firmware_into_buf
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
@@ -89,6 +92,9 @@ struct test_batched_req {
 struct test_config {
 	char *name;
 	bool into_buf;
+	size_t buf_size;
+	size_t file_offset;
+	bool partial;
 	bool sync_direct;
 	bool send_uevent;
 	u8 num_requests;
@@ -183,6 +189,9 @@ static int __test_firmware_config_init(void)
 	test_fw_config->num_requests = TEST_FIRMWARE_NUM_REQS;
 	test_fw_config->send_uevent = true;
 	test_fw_config->into_buf = false;
+	test_fw_config->buf_size = TEST_FIRMWARE_BUF_SIZE;
+	test_fw_config->file_offset = 0;
+	test_fw_config->partial = false;
 	test_fw_config->sync_direct = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
@@ -236,28 +245,35 @@ static ssize_t config_show(struct device *dev,
 			dev_name(dev));
 
 	if (test_fw_config->name)
-		len += scnprintf(buf+len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"name:\t%s\n",
 				test_fw_config->name);
 	else
-		len += scnprintf(buf+len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"name:\tEMTPY\n");
 
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"num_requests:\t%u\n", test_fw_config->num_requests);
 
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"send_uevent:\t\t%s\n",
 			test_fw_config->send_uevent ?
 			"FW_ACTION_HOTPLUG" :
 			"FW_ACTION_NOHOTPLUG");
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"into_buf:\t\t%s\n",
 			test_fw_config->into_buf ? "true" : "false");
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			"buf_size:\t%zu\n", test_fw_config->buf_size);
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			"file_offset:\t%zu\n", test_fw_config->file_offset);
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			"partial:\t\t%s\n",
+			test_fw_config->partial ? "true" : "false");
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 
 	mutex_unlock(&test_fw_mutex);
@@ -315,6 +331,30 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
+static int test_dev_config_update_size_t(const char *buf,
+					 size_t size,
+					 size_t *cfg)
+{
+	int ret;
+	long new;
+
+	ret = kstrtol(buf, 10, &new);
+	if (ret)
+		return ret;
+
+	mutex_lock(&test_fw_mutex);
+	*(size_t *)cfg = new;
+	mutex_unlock(&test_fw_mutex);
+
+	/* Always return full write size even if we didn't consume all */
+	return size;
+}
+
+static ssize_t test_dev_config_show_size_t(char *buf, size_t val)
+{
+	return snprintf(buf, PAGE_SIZE, "%zu\n", val);
+}
+
 static ssize_t test_dev_config_show_int(char *buf, int val)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
@@ -400,6 +440,83 @@ static ssize_t config_into_buf_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_into_buf);
 
+static ssize_t config_buf_size_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int rc;
+
+	mutex_lock(&test_fw_mutex);
+	if (test_fw_config->reqs) {
+		pr_err("Must call release_all_firmware prior to changing config\n");
+		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
+		goto out;
+	}
+	mutex_unlock(&test_fw_mutex);
+
+	rc = test_dev_config_update_size_t(buf, count,
+					   &test_fw_config->buf_size);
+
+out:
+	return rc;
+}
+
+static ssize_t config_buf_size_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return test_dev_config_show_size_t(buf, test_fw_config->buf_size);
+}
+static DEVICE_ATTR_RW(config_buf_size);
+
+static ssize_t config_file_offset_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	int rc;
+
+	mutex_lock(&test_fw_mutex);
+	if (test_fw_config->reqs) {
+		pr_err("Must call release_all_firmware prior to changing config\n");
+		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
+		goto out;
+	}
+	mutex_unlock(&test_fw_mutex);
+
+	rc = test_dev_config_update_size_t(buf, count,
+					   &test_fw_config->file_offset);
+
+out:
+	return rc;
+}
+
+static ssize_t config_file_offset_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return test_dev_config_show_size_t(buf, test_fw_config->file_offset);
+}
+static DEVICE_ATTR_RW(config_file_offset);
+
+static ssize_t config_partial_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf,
+					   count,
+					   &test_fw_config->partial);
+}
+
+static ssize_t config_partial_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->partial);
+}
+static DEVICE_ATTR_RW(config_partial);
+
 static ssize_t config_sync_direct_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -655,11 +772,21 @@ static int test_fw_run_batch_request(void *data)
 		if (!test_buf)
 			return -ENOSPC;
 
-		req->rc = request_firmware_into_buf(&req->fw,
-						    req->name,
-						    req->dev,
-						    test_buf,
-						    TEST_FIRMWARE_BUF_SIZE);
+		if (test_fw_config->partial)
+			req->rc = request_partial_firmware_into_buf
+						(&req->fw,
+						 req->name,
+						 req->dev,
+						 test_buf,
+						 test_fw_config->buf_size,
+						 test_fw_config->file_offset);
+		else
+			req->rc = request_firmware_into_buf
+						(&req->fw,
+						 req->name,
+						 req->dev,
+						 test_buf,
+						 test_fw_config->buf_size);
 		if (!req->fw)
 			kfree(test_buf);
 	} else {
@@ -932,6 +1059,9 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config_name),
 	TEST_FW_DEV_ATTR(config_num_requests),
 	TEST_FW_DEV_ATTR(config_into_buf),
+	TEST_FW_DEV_ATTR(config_buf_size),
+	TEST_FW_DEV_ATTR(config_file_offset),
+	TEST_FW_DEV_ATTR(config_partial),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index fcc281373b4d..c2a2a100114b 100755
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
 
+read_partial_firmwares()
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
@@ -242,6 +291,21 @@ test_batched_request_firmware_into_buf_nofile()
 	echo "OK"
 }
 
+test_request_partial_firmware_into_buf_nofile()
+{
+	echo -n "Test request_partial_firmware_into_buf() off=$1 size=$2 nofile: "
+	config_reset
+	config_set_name nope-test-firmware.bin
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $2
+	config_set_file_offset $1
+	config_trigger_sync
+	read_firmwares_expect_nofile
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct_nofile()
 {
 	echo -n "Batched request_firmware_direct() nofile try #$1: "
@@ -356,6 +420,21 @@ test_request_firmware_nowait_custom()
 	echo "OK"
 }
 
+test_request_partial_firmware_into_buf()
+{
+	echo -n "Test request_partial_firmware_into_buf() off=$1 size=$2: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $2
+	config_set_file_offset $1
+	config_trigger_sync
+	read_partial_firmwares normal $1 $2
+	release_all_firmware
+	echo "OK"
+}
+
 # Only continue if batched request triggers are present on the
 # test-firmware driver
 test_config_present
@@ -383,6 +462,12 @@ for i in $(seq 1 5); do
 	test_request_firmware_nowait_custom $i normal
 done
 
+# Partial loads cannot use fallback, so do not repeat tests.
+test_request_partial_firmware_into_buf 0 10
+test_request_partial_firmware_into_buf 0 5
+test_request_partial_firmware_into_buf 1 6
+test_request_partial_firmware_into_buf 2 10
+
 # Test for file not found, errors are expected, the failure would be
 # a hung task, which would require a hard reset.
 echo
@@ -407,6 +492,12 @@ for i in $(seq 1 5); do
 	test_request_firmware_nowait_custom_nofile $i
 done
 
+# Partial loads cannot use fallback, so do not repeat tests.
+test_request_partial_firmware_into_buf_nofile 0 10
+test_request_partial_firmware_into_buf_nofile 0 5
+test_request_partial_firmware_into_buf_nofile 1 6
+test_request_partial_firmware_into_buf_nofile 2 10
+
 test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
 
 # test with both files present
-- 
2.25.1

