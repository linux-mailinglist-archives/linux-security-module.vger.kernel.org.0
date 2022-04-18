Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63B505F33
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Apr 2022 23:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347973AbiDRVS6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 Apr 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347983AbiDRVS4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Apr 2022 17:18:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D62CE1E
        for <linux-security-module@vger.kernel.org>; Mon, 18 Apr 2022 14:16:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r83so921328pgr.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 Apr 2022 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7MNQdhfJevonqU1gbIMWRC7hAVlhGusKX2oocNDGwg=;
        b=FAuNNboCO/FPFJkwp5PqYbA8WCixhPEvKA7SW9KlYH7NB9BrlBhq3b1FZlX0I8Xvbm
         7ci+OWsvOyoWgrqCnm7OdfTfdp+eBZlK1swkaGRRPb36gVeU4JmZDP5PrtFk+SNkh7Vv
         kagm8tkFyJYvDDNS7r2EcUUpbk25fGTC1fcYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7MNQdhfJevonqU1gbIMWRC7hAVlhGusKX2oocNDGwg=;
        b=niwwTUJFFpBJ7NgYt/LVyLezxbwNuGNIoHGiikEZ/VLDyT6sWztIFe86fZ0SV+CH3f
         9kWqHiBSd5qPGT6qiNN97SZzJa3x7jQwp8b9Sk0GG7xn3CCYdvDEb3sule80fVgno1m9
         jbz5yaPHd2Dufzlp8IH5iwEHg0mDrrOsV+Xe7WGZ18LuqB9g4N3unYbWhV0N05LOCjzn
         6UgqBRSIAIeif5HmKTE0AVZq0HWw5m5U603Wuy8jiXKWj82rXqTc4+ZdAInZnAHT1s0z
         eBrOfLO5uZXg7pmaH8jR2yBruMAvMRZUJqjMwKlcCy4ps7f8ZnIO4BKI0dD+3QQuLsb8
         YqiA==
X-Gm-Message-State: AOAM533VXoi9Qm9nvG+OHiJZhq4kvcU2R9i+B50RpYb0oAHyLsiRYEyi
        01IZdhNGI0ie9LtDp0tOWf2P5Q==
X-Google-Smtp-Source: ABdhPJx4kToyubC6lCeN87zCNmuEOzpd1tCZwNVPjLaJyswe8LBMciizDAJKihUrNCpdY9/hLsvQhQ==
X-Received: by 2002:a05:6a00:a26:b0:4fd:f9dd:549c with SMTP id p38-20020a056a000a2600b004fdf9dd549cmr14275958pfh.42.1650316569446;
        Mon, 18 Apr 2022 14:16:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id n24-20020aa79058000000b0050612d0fe01sm13406325pfo.2.2022.04.18.14.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 14:16:08 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Mon, 18 Apr 2022 14:15:58 -0700
Message-Id: <20220418141545.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418211559.3832724-1-mka@chromium.org>
References: <20220418211559.3832724-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Extend LoadPin to allow loading of kernel files from trusted
dm-verity [1] devices.

This change adds the concept of trusted verity devices to
LoadPin. Userspace can use the new systl file
'loadpin/trusted_verity_root_digests' to provide LoadPin
with a list of root digests from dm-verity devices that
LoadPin should consider as trusted. When a kernel file is
read LoadPin first checks (as usual) whether the file is
located on the pinned root, if so the file can be loaded.
Otherwise, if the verity extension is enabled, LoadPin
determines whether the file is located on a verity backed
device and whether the root digest of that device is in
the list of trusted digests. The file can be loaded if
the verity device has a trusted root digest.

The list of trusted root digests can only be written once
(typically at boot time), to limit the possiblity of
attackers setting up rogue verity devices and marking them
as trusted.

Background:

As of now LoadPin restricts loading of kernel files to a single
pinned filesystem, typically the rootfs. This works for many
systems, however it can result in a bloated rootfs (and OTA
updates) on platforms where multiple boards with different
hardware configurations use the same rootfs image. Especially
when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a
given board. Chrome OS uses Downloadable Content (DLC) [2] to
deploy certain 'packages' at runtime. As an example a DLC
package could contain firmware for a peripheral that is not
present on all boards. DLCs use dm-verity to verify the
integrity of the DLC content.

[1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
[2] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 security/loadpin/Kconfig   |  11 +++
 security/loadpin/loadpin.c | 168 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 91be65dec2ab..cf3e6431e02d 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -18,3 +18,14 @@ config SECURITY_LOADPIN_ENFORCE
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
 	  "loadpin.enforce=1".
+
+config SECURITY_LOADPIN_VERITY
+	bool "Allow reading files from certain other filesystems that use dm-verity"
+	depends on DM_VERITY=y
+	help
+	  If selected LoadPin can allow reading files from filesystems
+	  that use dm-verity. A verity filesystem can be configured as
+	  being trusted by LoadPin by writing its root digest to the
+	  sysctl file 'trusted_verity_root_digests'. The sysctl file
+	  can only be written once (typically at boot) and accepts a
+	  list of comma separated digests.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..b9c174f8687d 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -18,6 +18,8 @@
 #include <linux/path.h>
 #include <linux/sched.h>	/* current */
 #include <linux/string_helpers.h>
+#include <linux/device-mapper.h>
+#include <linux/dm-verity-loadpin.h>
 
 static void report_load(const char *origin, struct file *file, char *operation)
 {
@@ -43,6 +45,10 @@ static char *exclude_read_files[READING_MAX_ID];
 static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
 static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+static bool verity_digests_set;
+static LIST_HEAD(trusted_verity_root_digests);
+#endif
 
 #ifdef CONFIG_SYSCTL
 
@@ -65,6 +71,144 @@ static struct ctl_table loadpin_sysctl_table[] = {
 	{ }
 };
 
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+
+static int proc_verity_root_digests(struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct trusted_root_digest *trd;
+	char *buf;
+	int rc;
+
+	if (write) {
+		struct ctl_table tbl = *table;
+		char *p, *d;
+
+		if (*ppos)
+			return -EINVAL;
+
+		if (verity_digests_set)
+			return -EPERM;
+
+		buf = kzalloc(tbl.maxlen, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		tbl.data = buf;
+
+		rc = proc_dostring(&tbl, write, buffer, lenp, ppos);
+		if (rc) {
+			kfree(buf);
+			return rc;
+		}
+
+		if (strlen(buf) == 0) {
+			verity_digests_set = true;
+			return false;
+		}
+
+		p = buf;
+		while ((d = strsep(&p, ",")) != NULL) {
+			int len = strlen(d);
+
+			if (len % 2) {
+				rc = -EINVAL;
+				goto err;
+			}
+
+			len /= 2;
+
+			trd = kzalloc(sizeof(*trd), GFP_KERNEL);
+			if (!trd) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			list_add_tail(&trd->node, &trusted_verity_root_digests);
+
+			trd->data = kzalloc(len, GFP_KERNEL);
+			if (!trd->data) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			if (hex2bin(trd->data, d, len)) {
+				rc = -EINVAL;
+				goto err;
+			}
+
+			trd->len = len;
+		}
+
+		kfree(buf);
+
+		if (!list_empty(&trusted_verity_root_digests)) {
+			dm_verity_loadpin_set_trusted_root_digests(&trusted_verity_root_digests);
+			verity_digests_set = true;
+		}
+	} else {
+		struct ctl_table tbl = { .maxlen = 0 };
+		size_t off = 0;
+
+		list_for_each_entry(trd, &trusted_verity_root_digests, node) {
+			/* two ASCII characters per byte and a comma / '\0' */
+			tbl.maxlen += (trd->len * 2) + 1;
+		}
+
+		tbl.data = kzalloc(tbl.maxlen, GFP_KERNEL);
+
+		list_for_each_entry(trd, &trusted_verity_root_digests, node) {
+			int i;
+
+			if (off > 0) {
+				snprintf(tbl.data + off, tbl.maxlen - off, ",");
+				off++;
+			}
+
+			for (i = 0; i < trd->len; i++) {
+				snprintf(tbl.data + off, tbl.maxlen - off, "%02x", trd->data[i]);
+				off += 2;
+			}
+		}
+
+		proc_dostring(&tbl, write, buffer, lenp, ppos);
+		kfree(tbl.data);
+	}
+
+	return 0;
+
+err:
+	kfree(buf);
+
+	{
+		struct trusted_root_digest *tmp;
+
+		list_for_each_entry_safe(trd, tmp, &trusted_verity_root_digests, node) {
+			kfree(trd->data);
+			list_del(&trd->node);
+			kfree(trd);
+		}
+	}
+
+	return rc;
+}
+
+static struct ctl_table loadpin_sysctl_table_verity[] = {
+	{
+		.procname       = "trusted_verity_root_digests",
+		.maxlen         = SZ_4K,
+		.mode           = 0644,
+		.proc_handler   = proc_verity_root_digests,
+	},
+
+	{ }
+};
+#else
+
+static struct ctl_table loadpin_sysctl_table_verity[] = {};
+
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+
 /*
  * This must be called after early kernel init, since then the rootdev
  * is available.
@@ -118,6 +262,20 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
+static bool loadpin_is_fs_trusted(struct super_block *sb)
+{
+	struct mapped_device *md = dm_get_md(sb->s_bdev->bd_dev);
+	bool trusted;
+
+	if (!md)
+		return false;
+
+	trusted = dm_verity_loadpin_is_md_trusted(md);
+	dm_put(md);
+
+	return trusted;
+}
+
 static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 			     bool contents)
 {
@@ -174,7 +332,8 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 		spin_unlock(&pinned_root_spinlock);
 	}
 
-	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
+	if (IS_ERR_OR_NULL(pinned_root) ||
+	    ((load_root != pinned_root) && !loadpin_is_fs_trusted(load_root))) {
 		if (unlikely(!enforce)) {
 			report_load(origin, file, "pinning-ignored");
 			return 0;
@@ -240,6 +399,13 @@ static int __init loadpin_init(void)
 		enforce ? "" : "not ");
 	parse_exclude();
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+
+	if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)) {
+		if (!register_sysctl_paths(loadpin_sysctl_path,
+					   loadpin_sysctl_table_verity))
+			pr_notice("sysctl registration failed!\n");
+	}
+
 	return 0;
 }
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

