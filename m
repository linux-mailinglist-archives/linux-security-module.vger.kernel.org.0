Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6D28C242
	for <lists+linux-security-module@lfdr.de>; Mon, 12 Oct 2020 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgJLUZF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 12 Oct 2020 16:25:05 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:41337
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbgJLUZF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Oct 2020 16:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534303; bh=JGjAwespAPb3JVqmhZ7TbOhf6aYGDK3913Y95xKvmdo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mtmaczPsfHdOIXjzZDotxxY7p73WMG2yf6/QLGTPKggO2/Zj493g9+sJb68s842EbwSRKGO7HPvULslDqUea29hzJXdQ5rb4AAcXBLZdyeaLdxaVSqN6EoNnU3Wg4QWezvzJU3J+2elyBBkdkXKyaZJ6B6c9Zj3VLQlIdunSWuLgkaaJm0reDvnXWIgpITS306lbp/nxkTlWIyayi99My4e2KUmjTrScYqEndIs8OCm1dejIbTLKVYlbwxY0Q/JIcedJUhF38wfu+XD3n7WH6jZNz3ev4+dJXMZFE2qcBTq4dC07s61AbC/OqvmT+z6bV5V4xZPeXpdAOy4UmCQJvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534303; bh=1fu3N2gXxMe1n9B73Va9OEaQiF+zEN/TkJW+6+MIEHb=; h=From:To:Subject:Date; b=mbBcfBk6u/b7UbVn+SqX5PYdMOtmqCZGqNyqZALl1rl3A1/NrAfybFMXthn7JMNrSprkfZucUTsuPSYjF4t7DZf1Szt++NfarFaKLyj6cjXoEHYB/HXEYe8RkAdQAkebGjK3btO9prk+Gj6zTUQWA3nifZpAFnIYF8hkePlAxheXPQIzqPN7rUpa+h8rzRrhSjtIrcgov/NMMDuZPxNXNYJ4EEc6cMBGpKeAVeszfXGfcVj1Mdhg1k2Whv8HaS+rV2RyKvYL87OyORQantE5LFCXZjx97NHiTSeMSrxUFJ0ljx/rNlnOVHRysUmoV/OEM7Xt++/SOs0Jq33b6F5pLQ==
X-YMail-OSG: 29OiDm8VM1k8antZCrfG0HZAFTNjpcf8_ltqhMulgIpSn5NLDizWpixC_9owl0j
 ZM41HjBMHDeRsTk0qqCOkbPx30Ob0IUQxI8oVHZRBAYdjPO_m_KeAbVLL3GXYYNLTFperYGV6GVU
 yx.DA3aaa7JFVraxrpebmfiKlhzOXwTwf2YVGLGgtDJAedV.q0VY.k4ngLf0jhXxTjupkZY9Ccm6
 _tsWO8Uvm8MxtNLws49DOgRqXygWRBAvn9KAdNMnr5M1a3R1M0jncthEsk7h7PDHdoLRAccjFb_4
 xRAHiVrVcAVREqXSZnHmKgYCtFMdf48QYAVdmrloTGzu6WqX2E2jMRU1YMieCUP29ouLtmRXtWDh
 GqG3svVuO54kz01d5DMdfcKqiKuKNnnLScXIIynbgJukyxVJ7tv6wSws48.QF89p3ESc4t_dxCOi
 BlrKxgmgW4gNyyGIik3hc_O6HIEgSxAp5H48o9bNbxDg2lOH07aUbo8ChwKpDysmCCgq3llahoXk
 sTVJ6B01lQElz5lULW7lsYvEkXDflCooZySNTPDtkPdY9tiqcjSAA76YVxTSvUy2C2RGg_AuJlYP
 Iju9d.0Nq5VBtklvO1CZ584diTHzKzGPtj9CRkuqBSJ5q6AQtulUrjaiVfwl4bhp1aiVXMl9Vo2D
 m628xG1wWUSd_p1H3TvSgiHk_fwgG1mUShMoiBj7JRKfvga9G5aj81q3vBmnmdyAblW6UPTC3fIm
 S95Bmf9g2lqFw9V1CE9CW3ya1KJgep6NdRqfPJbdVpZ2s6VusMTtToXPpi13nHDlrza2GKfZXXqW
 kxYq9KxquRsQlWDDfPOyxdyfwJV5rf_tqWu4kv3DzBlW.J4xV9uH39pPoIMaj9A7F3LqeVkpIEVi
 bzvhk8DpKa8q6CU_wRwYjLOV9w6O9viAA0dCNvPHpTqOuIu18lAXnGgNzy1pY8jhPFiltmvcbOht
 lmWkrylIWa.Vr_ks9hd4LMpEYnsjiqE0PDmpLRpgCGvBR1rBZ8V5K7ABqE3RpEDzFWwAi7n1pb31
 FkEiYoXM1VzyBgTtqOiNCX60jD2JYDebxZ7TfUog48DUrB2TaU..1_5SkH5QrFcYa6oQaAZiE0NY
 R_WjaCKPX.hX5X.TB3NE56ISKBXurXaOwime9FEbO2n3rMVuIFtxpEDaa4.xNuU9dPV0JFUKmyIa
 f1BrwjMPqgge7xwRonwWAUkPDyoATU9FT99Hg6EmdONzhKcw6sCn4AvgFG07VCPymMzAmXkY860k
 ZkwabkqVdHwWzhLtVlHQkw37Fd6TKCXnRQbeA2FSLGqW4pLyMcjmkXK3rGru9rr4oKpY85J35Dv3
 xQ27nQ0I_tVBtVBRl6zcAJMMOQ.QE121K2sO8J8vkFcOkObh20jwFArWwE2X43Pf8OtORcdzsdsX
 r9EFDkFONFpdcQqbC_zP4.eTsyL8likuiBDQTVSGGaaaA5bfXtGRPk9mdJhk5_pFOXu0G2IQzLhX
 2RsLIWHgfWMTEvUS3Mt1B.T9G6wIAyHFlxQ.oBOxCA5DPa17zYCWIK0lozeAbNxQklll.4KIm6mz
 fyEWY7YDbu_.4.51IWYBPSZEoklHXut2eho5QNm7tbQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:25:03 +0000
Received: by smtp411.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 13807960e1e38fa09279c5d8597f8867;
          Mon, 12 Oct 2020 20:24:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 05/23] LSM: Use lsmblob in security_secctx_to_secid
Date:   Mon, 12 Oct 2020 13:19:06 -0700
Message-Id: <20201012201924.71463-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Change the security_secctx_to_secid interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its callers to do the same.

The security module hook is unchanged, still passing back a secid.
The infrastructure passes the correct entry from the lsmblob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          | 26 ++++++++++++++++++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          | 10 ++++----
 net/netfilter/xt_SECMARK.c        |  7 +++++-
 net/netlabel/netlabel_unlabeled.c | 23 +++++++++++-------
 security/security.c               | 40 ++++++++++++++++++++++++++-----
 6 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e2ef982b3dd7..056c58ed3339 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -190,6 +190,27 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 	return !memcmp(bloba, blobb, sizeof(*bloba));
 }
 
+/**
+ * lsmblob_value - find the first non-zero value in an lsmblob structure.
+ * @blob: Pointer to the data
+ *
+ * This needs to be used with extreme caution, as the cases where
+ * it is appropriate are rare.
+ *
+ * Return the first secid value set in the lsmblob.
+ * There should only be one.
+ */
+static inline u32 lsmblob_value(const struct lsmblob *blob)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (blob->secid[i])
+			return blob->secid[i];
+
+	return 0;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -503,7 +524,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
@@ -1322,7 +1344,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 22e0e7cbefde..848306c7d823 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -757,14 +757,12 @@ EXPORT_SYMBOL(set_security_override);
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
 	struct lsmblob blob;
-	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
 	if (ret < 0)
 		return ret;
 
-	lsmblob_init(&blob, secid);
 	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 7bc6537f3ccb..259c8e2ab2b4 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -811,21 +811,21 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
-	u32 tmp_secid = 0;
+	struct lsmblob blob;
 	int err;
 
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
+	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
 	if (err)
 		return err;
 
-	if (!tmp_secid)
+	if (!lsmblob_is_set(&blob))
 		return -ENOENT;
 
-	err = security_secmark_relabel_packet(tmp_secid);
+	err = security_secmark_relabel_packet(lsmblob_value(&blob));
 	if (err)
 		return err;
 
-	priv->secid = tmp_secid;
+	priv->secid = lsmblob_value(&blob);
 	return 0;
 }
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 75625d13e976..9845d98e6b77 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -43,13 +43,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
+	struct lsmblob blob;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+				       &blob);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
@@ -57,6 +58,10 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* xt_secmark_target_info can't be changed to use lsmblobs because
+	 * it is exposed as an API. Use lsmblob_value() to get the one
+	 * value that got set by security_secctx_to_secid(). */
+	info->secid = lsmblob_value(&blob);
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 77bb1bb22c3b..8948557eaebb 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -882,7 +882,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -906,13 +906,18 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* netlbl_unlhsh_add will be changed to pass a struct lsmblob *
+	 * instead of a u32 later in this patch set. security_secctx_to_secid()
+	 * will only be setting one entry in the lsmblob struct, so it is
+	 * safe to use lsmblob_value() to get that one value. */
+
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
-				 &audit_info);
+				 dev_name, addr, mask, addr_len,
+				 lsmblob_value(&blob), &audit_info);
 }
 
 /**
@@ -933,7 +938,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -955,13 +960,15 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* security_secctx_to_secid() will only put one secid into the lsmblob
+	 * so it's safe to use lsmblob_value() to get the secid. */
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
-				 &audit_info);
+				 NULL, addr, mask, addr_len,
+				 lsmblob_value(&blob), &audit_info);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index d6d882b1f7d5..508a6dac3742 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2065,10 +2065,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+					      &blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -2219,10 +2231,26 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	/*
+	 * Only one security module should provide a real hook for
+	 * this. A stub or bypass like is used in BPF should either
+	 * (somehow) leave rc unaltered or return -ENOPROTOOPT.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (rc != -ENOPROTOOPT)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.24.1

