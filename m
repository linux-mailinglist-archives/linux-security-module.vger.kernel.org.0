Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACE35B2AE2
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Sep 2022 02:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiIIANI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 8 Sep 2022 20:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiIIANE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 20:13:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD13A9A9F9;
        Thu,  8 Sep 2022 17:12:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so4120673pji.1;
        Thu, 08 Sep 2022 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ZgULsBNlZ4NhESIdKTkNM5tPFyHP5bXVMW6QHN2Ukoo=;
        b=pCwYigaIFfaWwyeU4rOmTN423NPGpWLnSImRXNymVtHdO4msw5ZEqFVNQJSpAdhhcI
         6hMXczW1CAH86qPGaWdc8eCbv+uXx484SplXmSRBid+SMsAvQ80bJlWUt05LWOHU7e/c
         c8crEkG2Oe0VdBd5D5m/3hycyejDH/ZE3xi24o2dcrSlhLRQHa9DKX1QnU2197o9PIZX
         xfh+ETXq/pPUQdraexqZdSiWKX9upPwVMMU4616aaTztIshQFYuMxC+s5hJFiw6wi3hD
         0ObPOEjZ3AOL8V5MLAeVoQ4p3pB24kMKOtIGm1KRyK8kIhk9ptjpsTv3wSWvSnVvrM7n
         RuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZgULsBNlZ4NhESIdKTkNM5tPFyHP5bXVMW6QHN2Ukoo=;
        b=iByifAaq9QqhxgG0gl2h993YKD6lLqrNRQX8w2HUZSvEkED+prblr8gbKNZiBVCBlu
         gCfLwROKWFEGmuxN3Ylc9Pt6Y6m5QqJ89K3yCtFgH/6xngM2NmT8/trL3GftgE2Zmkp8
         P4elNj2pgLMeUOJFgedF+hch6XChgTVGrlee5h3R89R9q7UqH6JzvSHr0Yf0V5kLTw90
         nQrI075YgkoXd8Riov1/uAiVQlB2eus0tgsa/tD2aRa1jC20+Uo1XtRIcFCuKdXVaPRD
         ftX7mifqGtrhdCetF0f3O44UYRap5dAz7snNlTUvFxei3tjsCEekNy2Qo0sOR8WbkEoA
         4Ndg==
X-Gm-Message-State: ACgBeo3rsFMFyM3IVuTCcdrcjsS+aYM4MWIVhjbYujVAp/GIbtcx5tgz
        HOyAWmLVehQWLGi6gs/8XG4=
X-Google-Smtp-Source: AA6agR5RWLfL72aiCgCUECQkUwchpHthmGWfzoRqpSjixMVzRu4sZE7ji8FlAB9Sl6olnxXyLtx1xg==
X-Received: by 2002:a17:90b:33c9:b0:200:a0ca:e6c8 with SMTP id lk9-20020a17090b33c900b00200a0cae6c8mr6673640pjb.147.1662682377924;
        Thu, 08 Sep 2022 17:12:57 -0700 (PDT)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id s2-20020a170903200200b001769206a766sm76455pla.307.2022.09.08.17.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 17:12:57 -0700 (PDT)
From:   Adel Abouchaev <adel.abushaev@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
        shuah@kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [net-next v4 5/6] net: Add flow counters and Tx processing error counter
Date:   Thu,  8 Sep 2022 17:12:37 -0700
Message-Id: <20220909001238.3965798-6-adel.abushaev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909001238.3965798-1-adel.abushaev@gmail.com>
References: <Adel Abouchaev <adel.abushaev@gmail.com>
 <20220909001238.3965798-1-adel.abushaev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Added flow counters. Total flow counter is accumulative, the current shows
the number of flows currently in flight, the error counters is accumulating
the number of errors during Tx processing.

Signed-off-by: Adel Abouchaev <adel.abushaev@gmail.com>

---

Updated enum bracket to follow enum keyword. Removed extra blank lines.
---
 include/net/netns/mib.h   |  3 +++
 include/net/quic.h        | 10 +++++++++
 include/net/snmp.h        |  6 +++++
 include/uapi/linux/snmp.h |  9 ++++++++
 net/quic/Makefile         |  2 +-
 net/quic/quic_main.c      | 46 +++++++++++++++++++++++++++++++++++++++
 net/quic/quic_proc.c      | 45 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 net/quic/quic_proc.c

diff --git a/include/net/netns/mib.h b/include/net/netns/mib.h
index 7e373664b1e7..dcbba3d1ceec 100644
--- a/include/net/netns/mib.h
+++ b/include/net/netns/mib.h
@@ -24,6 +24,9 @@ struct netns_mib {
 #if IS_ENABLED(CONFIG_TLS)
 	DEFINE_SNMP_STAT(struct linux_tls_mib, tls_statistics);
 #endif
+#if IS_ENABLED(CONFIG_QUIC)
+	DEFINE_SNMP_STAT(struct linux_quic_mib, quic_statistics);
+#endif
 #ifdef CONFIG_MPTCP
 	DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
 #endif
diff --git a/include/net/quic.h b/include/net/quic.h
index cafe01174e60..6362d827d266 100644
--- a/include/net/quic.h
+++ b/include/net/quic.h
@@ -25,6 +25,16 @@
 #define QUIC_MAX_PLAIN_PAGES		16
 #define QUIC_MAX_CIPHER_PAGES_ORDER	4
 
+#define __QUIC_INC_STATS(net, field)				\
+	__SNMP_INC_STATS((net)->mib.quic_statistics, field)
+#define QUIC_INC_STATS(net, field)				\
+	SNMP_INC_STATS((net)->mib.quic_statistics, field)
+#define QUIC_DEC_STATS(net, field)				\
+	SNMP_DEC_STATS((net)->mib.quic_statistics, field)
+
+int __net_init quic_proc_init(struct net *net);
+void __net_exit quic_proc_fini(struct net *net);
+
 struct quic_internal_crypto_context {
 	struct quic_connection_info	conn_info;
 	struct crypto_skcipher		*header_tfm;
diff --git a/include/net/snmp.h b/include/net/snmp.h
index 468a67836e2f..f94680a3e9e8 100644
--- a/include/net/snmp.h
+++ b/include/net/snmp.h
@@ -117,6 +117,12 @@ struct linux_tls_mib {
 	unsigned long	mibs[LINUX_MIB_TLSMAX];
 };
 
+/* Linux QUIC */
+#define LINUX_MIB_QUICMAX	__LINUX_MIB_QUICMAX
+struct linux_quic_mib {
+	unsigned long	mibs[LINUX_MIB_QUICMAX];
+};
+
 #define DEFINE_SNMP_STAT(type, name)	\
 	__typeof__(type) __percpu *name
 #define DEFINE_SNMP_STAT_ATOMIC(type, name)	\
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 4d7470036a8b..ca1e626dbdb4 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -349,4 +349,13 @@ enum
 	__LINUX_MIB_TLSMAX
 };
 
+/* linux QUIC mib definitions */
+enum {
+	LINUX_MIB_QUICNUM = 0,
+	LINUX_MIB_QUICCURRTXSW,			/* QuicCurrTxSw */
+	LINUX_MIB_QUICTXSW,			/* QuicTxSw */
+	LINUX_MIB_QUICTXSWERROR,		/* QuicTxSwError */
+	__LINUX_MIB_QUICMAX
+};
+
 #endif	/* _LINUX_SNMP_H */
diff --git a/net/quic/Makefile b/net/quic/Makefile
index 928239c4d08c..a885cd8bc4e0 100644
--- a/net/quic/Makefile
+++ b/net/quic/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_QUIC) += quic.o
 
-quic-y := quic_main.o
+quic-y := quic_main.o quic_proc.o
diff --git a/net/quic/quic_main.c b/net/quic/quic_main.c
index 32535f7b7f11..bf041db280f8 100644
--- a/net/quic/quic_main.c
+++ b/net/quic/quic_main.c
@@ -359,6 +359,8 @@ static int do_quic_conn_add_tx(struct sock *sk, sockptr_t optval,
 	if (rc < 0)
 		goto err_free_ciphers;
 
+	QUIC_INC_STATS(sock_net(sk), LINUX_MIB_QUICCURRTXSW);
+	QUIC_INC_STATS(sock_net(sk), LINUX_MIB_QUICTXSW);
 	return 0;
 
 err_free_ciphers:
@@ -416,6 +418,7 @@ static int do_quic_conn_del_tx(struct sock *sk, sockptr_t optval,
 	crypto_free_aead(crypto_ctx->packet_aead);
 	memzero_explicit(crypto_ctx, sizeof(*crypto_ctx));
 	kfree(connhash);
+	QUIC_DEC_STATS(sock_net(sk), LINUX_MIB_QUICCURRTXSW);
 
 	return 0;
 }
@@ -441,6 +444,9 @@ static int do_quic_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		break;
 	}
 
+	if (rc)
+		QUIC_INC_STATS(sock_net(sk), LINUX_MIB_QUICTXSWERROR);
+
 	return rc;
 }
 
@@ -1329,6 +1335,9 @@ static int quic_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	quic_put_plain_user_pages(plain_pages, nr_plain_pages);
 
 out:
+	if (unlikely(ret < 0))
+		QUIC_INC_STATS(sock_net(sk), LINUX_MIB_QUICTXSWERROR);
+
 	return ret;
 }
 
@@ -1461,6 +1470,36 @@ static void quic_release(struct sock *sk)
 	release_sock(sk);
 }
 
+static int __net_init quic_init_net(struct net *net)
+{
+	int err;
+
+	net->mib.quic_statistics = alloc_percpu(struct linux_quic_mib);
+	if (!net->mib.quic_statistics)
+		return -ENOMEM;
+
+	err = quic_proc_init(net);
+	if (err)
+		goto err_free_stats;
+
+	return 0;
+
+err_free_stats:
+	free_percpu(net->mib.quic_statistics);
+	return err;
+}
+
+static void __net_exit quic_exit_net(struct net *net)
+{
+	quic_proc_fini(net);
+	free_percpu(net->mib.quic_statistics);
+}
+
+static struct pernet_operations quic_proc_ops = {
+	.init = quic_init_net,
+	.exit = quic_exit_net,
+};
+
 static struct udp_ulp_ops quic_ulp_ops __read_mostly = {
 	.name		= "quic-crypto",
 	.owner		= THIS_MODULE,
@@ -1470,6 +1509,12 @@ static struct udp_ulp_ops quic_ulp_ops __read_mostly = {
 
 static int __init quic_register(void)
 {
+	int err;
+
+	err = register_pernet_subsys(&quic_proc_ops);
+	if (err)
+		return err;
+
 	udp_register_ulp(&quic_ulp_ops);
 	return 0;
 }
@@ -1477,6 +1522,7 @@ static int __init quic_register(void)
 static void __exit quic_unregister(void)
 {
 	udp_unregister_ulp(&quic_ulp_ops);
+	unregister_pernet_subsys(&quic_proc_ops);
 }
 
 module_init(quic_register);
diff --git a/net/quic/quic_proc.c b/net/quic/quic_proc.c
new file mode 100644
index 000000000000..cb4fe7a589b5
--- /dev/null
+++ b/net/quic/quic_proc.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2019 Meta Platforms, Inc. */
+
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <net/snmp.h>
+#include <net/quic.h>
+
+#ifdef CONFIG_PROC_FS
+static const struct snmp_mib quic_mib_list[] = {
+	SNMP_MIB_ITEM("QuicCurrTxSw", LINUX_MIB_QUICCURRTXSW),
+	SNMP_MIB_ITEM("QuicTxSw", LINUX_MIB_QUICTXSW),
+	SNMP_MIB_ITEM("QuicTxSwError", LINUX_MIB_QUICTXSWERROR),
+	SNMP_MIB_SENTINEL
+};
+
+static int quic_statistics_seq_show(struct seq_file *seq, void *v)
+{
+	unsigned long buf[LINUX_MIB_QUICMAX] = {};
+	struct net *net = seq->private;
+	int i;
+
+	snmp_get_cpu_field_batch(buf, quic_mib_list, net->mib.quic_statistics);
+	for (i = 0; quic_mib_list[i].name; i++)
+		seq_printf(seq, "%-32s\t%lu\n", quic_mib_list[i].name, buf[i]);
+
+	return 0;
+}
+#endif
+
+int __net_init quic_proc_init(struct net *net)
+{
+#ifdef CONFIG_PROC_FS
+	if (!proc_create_net_single("quic_stat", 0444, net->proc_net,
+				    quic_statistics_seq_show, NULL))
+		return -ENOMEM;
+#endif /* CONFIG_PROC_FS */
+
+	return 0;
+}
+
+void __net_exit quic_proc_fini(struct net *net)
+{
+	remove_proc_entry("quic_stat", net->proc_net);
+}
-- 
2.30.2

