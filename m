Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E04395DA
	for <lists+linux-security-module@lfdr.de>; Fri,  7 Jun 2019 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfFGTgV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 7 Jun 2019 15:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729809AbfFGTgV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jun 2019 15:36:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E3F208C3;
        Fri,  7 Jun 2019 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559936180;
        bh=gG0fzbTga8LoGGVYD2WsUM6GEgTPSTFuyJUyiTwEX+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hv/M4uJ0fax16PoH5DpbyJodbXUenOQcy+ag8FX26U/I/YRZ6OzNjAX+3ECXC+eH4
         MC7CRfrlxTwMXbbeMKveNOvji0m2NL/uud+kvTUqOv9/ZjACm7cTK840GBqOs5FOMf
         tkrXHyfd+40xcas2DwBBKaw3ZDyXH3T01nwH6YN4=
Date:   Fri, 7 Jun 2019 15:36:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com
Subject: Re: [PATCH 1/1 v2] Add dm verity root hash pkcs7 sig validation.
Message-ID: <20190607193618.GN29739@sasha-vm>
References: <20190524230411.9238-1-jaskarankhurana@linux.microsoft.com>
 <20190524230411.9238-2-jaskarankhurana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190524230411.9238-2-jaskarankhurana@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 24, 2019 at 04:04:11PM -0700, Jaskaran Khurana wrote:
>The verification is to support cases where the roothash is not secured by
>Trusted Boot, UEFI Secureboot or similar technologies.
>One of the use cases for this is for dm-verity volumes mounted after boot,
>the root hash provided during the creation of the dm-verity volume has to
>be secure and thus in-kernel validation implemented here will be used
>before we trust the root hash and allow the block device to be created.
>
>The signature being provided for verification must verify the root hash and
>must be trusted by the builtin keyring for verification to succeed.
>
>The hash is added as a key of type "user" and the description is passed to
>the kernel so it can look it up and use it for verification.
>
>Adds DM_VERITY_VERIFY_ROOTHASH_SIG: roothash verification
>against the roothash signature file *if* specified, if signature file is
>specified verification must succeed prior to creation of device mapper
>block device.
>
>Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
>specified for all dm verity volumes and verification must succeed prior
>to creation of device mapper block device.
>
>Signed-off-by: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
>---
> drivers/md/Kconfig                |  23 +++++
> drivers/md/Makefile               |   2 +-
> drivers/md/dm-verity-target.c     |  34 +++++++-
> drivers/md/dm-verity-verify-sig.c | 137 ++++++++++++++++++++++++++++++
> drivers/md/dm-verity-verify-sig.h |  31 +++++++
> 5 files changed, 222 insertions(+), 5 deletions(-)
> create mode 100644 drivers/md/dm-verity-verify-sig.c
> create mode 100644 drivers/md/dm-verity-verify-sig.h
>
>diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>index db269a348b20..da4115753f25 100644
>--- a/drivers/md/Kconfig
>+++ b/drivers/md/Kconfig
>@@ -489,6 +489,29 @@ config DM_VERITY
>
> 	  If unsure, say N.
>
>+config DM_VERITY_VERIFY_ROOTHASH_SIG
>+	def_bool n
>+	bool "Verity data device root hash signature verification support"
>+	depends on DM_VERITY
>+	select SYSTEM_DATA_VERIFICATION
>+	  help
>+	  The device mapper target created by DM-VERITY can be validated if the
>+	  pre-generated tree of cryptographic checksums passed has a pkcs#7
>+	  signature file that can validate the roothash of the tree.
>+
>+	  If unsure, say N.
>+
>+config DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE
>+	def_bool n
>+	bool "Forces all dm verity data device root hash should be signed"
>+	depends on DM_VERITY_VERIFY_ROOTHASH_SIG
>+	  help
>+	  The device mapper target created by DM-VERITY will succeed only if the
>+	  pre-generated tree of cryptographic checksums passed also has a pkcs#7
>+	  signature file that can validate the roothash of the tree.
>+
>+	  If unsure, say N.
>+
> config DM_VERITY_FEC
> 	bool "Verity forward error correction support"
> 	depends on DM_VERITY
>diff --git a/drivers/md/Makefile b/drivers/md/Makefile
>index be7a6eb92abc..8a8c142bcfe1 100644
>--- a/drivers/md/Makefile
>+++ b/drivers/md/Makefile
>@@ -61,7 +61,7 @@ obj-$(CONFIG_DM_LOG_USERSPACE)	+= dm-log-userspace.o
> obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
> obj-$(CONFIG_DM_RAID)	+= dm-raid.o
> obj-$(CONFIG_DM_THIN_PROVISIONING)	+= dm-thin-pool.o
>-obj-$(CONFIG_DM_VERITY)		+= dm-verity.o
>+obj-$(CONFIG_DM_VERITY)		+= dm-verity.o dm-verity-verify-sig.o
> obj-$(CONFIG_DM_CACHE)		+= dm-cache.o
> obj-$(CONFIG_DM_CACHE_SMQ)	+= dm-cache-smq.o
> obj-$(CONFIG_DM_ERA)		+= dm-era.o
>diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>index f4c31ffaa88e..56276669ac20 100644
>--- a/drivers/md/dm-verity-target.c
>+++ b/drivers/md/dm-verity-target.c
>@@ -16,7 +16,7 @@
>
> #include "dm-verity.h"
> #include "dm-verity-fec.h"
>-
>+#include "dm-verity-verify-sig.h"
> #include <linux/module.h>
> #include <linux/reboot.h>
>
>@@ -34,7 +34,8 @@
> #define DM_VERITY_OPT_IGN_ZEROES	"ignore_zero_blocks"
> #define DM_VERITY_OPT_AT_MOST_ONCE	"check_at_most_once"
>
>-#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC)
>+#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC + \
>+					 DM_VERITY_ROOT_HASH_VERIFICATION_OPTS)
>
> static unsigned dm_verity_prefetch_cluster = DM_VERITY_DEFAULT_PREFETCH_SIZE;
>
>@@ -855,7 +856,8 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
> 	return r;
> }
>
>-static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
>+static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>+				 struct dm_verity_sig_opts *verify_args)
> {
> 	int r;
> 	unsigned argc;
>@@ -904,6 +906,14 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
> 			if (r)
> 				return r;
> 			continue;
>+		} else if (verity_verify_is_sig_opt_arg(arg_name)) {
>+			r = verity_verify_sig_parse_opt_args(as, v,
>+							     verify_args,
>+							     &argc, arg_name);
>+			if (r)
>+				return r;
>+			continue;
>+
> 		}
>
> 		ti->error = "Unrecognized verity feature request";
>@@ -930,6 +940,7 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
> static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> {
> 	struct dm_verity *v;
>+	struct dm_verity_sig_opts verify_args = {0};
> 	struct dm_arg_set as;
> 	unsigned int num;
> 	unsigned long long num_ll;
>@@ -937,6 +948,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 	int i;
> 	sector_t hash_position;
> 	char dummy;
>+	char *root_hash_digest_to_validate = NULL;

Does it need to be initialized here? There's nothing that relies on this
logic later.

> 	v = kzalloc(sizeof(struct dm_verity), GFP_KERNEL);
> 	if (!v) {
>@@ -1070,6 +1082,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 		r = -EINVAL;
> 		goto bad;
> 	}
>+	root_hash_digest_to_validate = argv[8];
>
> 	if (strcmp(argv[9], "-")) {
> 		v->salt_size = strlen(argv[9]) / 2;
>@@ -1095,11 +1108,20 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 		as.argc = argc;
> 		as.argv = argv;
>
>-		r = verity_parse_opt_args(&as, v);
>+		r = verity_parse_opt_args(&as, v, &verify_args);
> 		if (r < 0)
> 			goto bad;
> 	}
>
>+	/* Root hash signature is  a optional parameter*/
				  an
>+	r = verity_verify_root_hash(root_hash_digest_to_validate,
>+				    strlen(root_hash_digest_to_validate),
>+				    verify_args.sig,
>+				    verify_args.sig_size);
>+	if (r < 0) {
>+		ti->error = "Root hash verification failed";
>+		goto bad;
>+	}
> 	v->hash_per_block_bits =
> 		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
>
>@@ -1165,9 +1187,13 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> 	ti->per_io_data_size = roundup(ti->per_io_data_size,
> 				       __alignof__(struct dm_verity_io));
>
>+	verity_verify_sig_opts_cleanup(&verify_args);
>+
> 	return 0;
>
> bad:
>+
>+	verity_verify_sig_opts_cleanup(&verify_args);
> 	verity_dtr(ti);
>
> 	return r;
>diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
>new file mode 100644
>index 000000000000..ba87c9342d55
>--- /dev/null
>+++ b/drivers/md/dm-verity-verify-sig.c
>@@ -0,0 +1,137 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (C) 2019 Microsoft Corporation.
>+ *
>+ * Author:  Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
>+ *
>+ * This file is released under the GPLv2.

There's no need to explicitly state licensing here, we have the SPDX
line at the beginning for that.

>+ */
>+#include <linux/device-mapper.h>
>+#include <linux/verification.h>
>+#include <keys/user-type.h>
>+#include "dm-verity.h"
>+#include "dm-verity-verify-sig.h"
>+
>+#define DM_VERITY_VERIFY_ERR(s) DM_VERITY_ROOT_HASH_VERIFICATION " " s
>+
>+
>+bool verity_verify_is_sig_opt_arg(const char *arg_name)
>+{
>+	return (!strcasecmp(arg_name,
>+			    DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG_KEY));
>+}
>+EXPORT_SYMBOL_GPL(verity_verify_is_sig_opt_arg);

Why are you exporting all these symbols?

>+static int verity_verify_get_sig_from_key(const char *key_desc,
>+					struct dm_verity_sig_opts *sig_opts)
>+{
>+	struct key *key;
>+	const struct user_key_payload *ukp;
>+	int ret = 0;
>+
>+	key = request_key(&key_type_user,
>+			key_desc, NULL);
>+	if (IS_ERR(key))
>+		return PTR_ERR(key);
>+
>+	down_read(&key->sem);
>+
>+	ukp = user_key_payload_locked(key);
>+	if (!ukp) {
>+		ret = -EKEYREVOKED;
>+		goto end;
>+	}
>+
>+	sig_opts->sig = kmalloc(ukp->datalen, GFP_KERNEL);
>+	if (!sig_opts->sig) {
>+		ret = -ENOMEM;
>+		goto end;
>+	}
>+	sig_opts->sig_size = ukp->datalen;
>+
>+	memcpy(sig_opts->sig, ukp->data, sig_opts->sig_size);
>+
>+end:
>+	up_read(&key->sem);
>+	key_put(key);
>+
>+	return ret;
>+}
>+
>+int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
>+				     struct dm_verity *v,
>+				     struct dm_verity_sig_opts *sig_opts,
>+				     unsigned int *argc,
>+				     const char *arg_name)
>+{
>+	struct dm_target *ti = v->ti;
>+	int ret = 0;
>+	const char *sig_key = NULL;
>+
>+	if (!*argc) {
>+		ti->error = DM_VERITY_VERIFY_ERR("Signature key not specified");
>+		return -EINVAL;
>+	}
>+
>+	sig_key = dm_shift_arg(as);
>+	(*argc)--;
>+
>+	if (!IS_ENABLED(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG))
>+		return 0;

Do we need to explicitly check it here? It would be nicer if we just
rely on verity_verify_get_sig_from_key() to "succeed" if the config
option isn't set.

>+
>+	ret = verity_verify_get_sig_from_key(sig_key, sig_opts);
>+	if (ret < 0)
>+		ti->error = DM_VERITY_VERIFY_ERR("Invalid key specified");
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(verity_verify_sig_parse_opt_args);
>+
>+#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
>+/*
>+ * verify_verify_roothash - Verify the root hash of the verity hash device
>+ *			     using builtin trusted keys.
>+ *
>+ * @root_hash: For verity, the roothash/data to be verified.
>+ * @root_hash_len: Size of the roothash/data to be verified.
>+ * @sig_data: The trusted signature that verifies the roothash/data.
>+ * @sig_len: Size of the signature.
>+ *
>+ */
>+int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>+			    const void *sig_data, size_t sig_len)
>+{
>+	int ret;
>+
>+	if (!root_hash || root_hash_len == 0)
>+		return -EINVAL;
>+
>+	if (!sig_data  || sig_len == 0) {
>+		if (IS_ENABLED(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE))
>+			return -EINVAL;

Is -EINVAL the right error here?

>+		else
>+			return 0;
>+	}
>+
>+	ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
>+				sig_len, NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
>+				NULL, NULL);
>+
>+	return ret;
>+}
>+#else
>+int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>+			    const void *sig_data, size_t sig_len)
>+{
>+	return 0;
>+}
>+#endif
>+EXPORT_SYMBOL_GPL(verity_verify_root_hash);
>+
>+void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts)

Why doesn't all of this cleanup code live in verity_dtr()?


--
Thanks,
Sasha

>+{
>+	kfree(sig_opts->sig);
>+	sig_opts->sig = NULL;
>+	sig_opts->sig_size = 0;
>+}
>+EXPORT_SYMBOL_GPL(verity_verify_sig_opts_cleanup);
>diff --git a/drivers/md/dm-verity-verify-sig.h b/drivers/md/dm-verity-verify-sig.h
>new file mode 100644
>index 000000000000..4cdb5eeb90d4
>--- /dev/null
>+++ b/drivers/md/dm-verity-verify-sig.h
>@@ -0,0 +1,31 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (C) 2019 Microsoft Corporation.
>+ *
>+ * Author:  Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
>+ *
>+ * This file is released under the GPLv2.
>+ */
>+#ifndef DM_VERITY_SIG_VERIFICATION_H
>+#define DM_VERITY_SIG_VERIFICATION_H
>+
>+#define DM_VERITY_ROOT_HASH_VERIFICATION "DM Verity Sig Verification"
>+#define DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG_KEY "root_hash_sig_key_desc"
>+#define DM_VERITY_ROOT_HASH_VERIFICATION_OPTS 2
>+
>+struct dm_verity_sig_opts {
>+	unsigned int sig_size;
>+	u8 *sig;
>+};
>+int verity_verify_root_hash(const void *data, size_t data_len,
>+			    const void *sig_data, size_t sig_len);
>+
>+bool verity_verify_is_sig_opt_arg(const char *arg_name);
>+
>+int verity_verify_sig_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>+				    struct dm_verity_sig_opts *sig_opts,
>+				    unsigned int *argc, const char *arg_name);
>+
>+void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts);
>+
>+#endif /* DM_VERITY_SIG_VERIFICATION_H */
>-- 
>2.17.1
>
