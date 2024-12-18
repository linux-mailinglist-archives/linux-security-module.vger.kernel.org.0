Return-Path: <linux-security-module+bounces-7167-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082059F5A51
	for <lists+linux-security-module@lfdr.de>; Wed, 18 Dec 2024 00:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA30D165775
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Dec 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F761FA8E6;
	Tue, 17 Dec 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p8S1822F"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5F1FA8D6
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734477656; cv=none; b=QNbl2tMqk/ISGvXrJEoe7kwP1OuTxwXr/yKbv/zZqqbMRXZ7cSccsovPm7ArFufrsApaHmDAmS4yShnEu8H8V3YiGthWTI9vOx9A0x4x2IKdPo98u/arTrfmltm7+QMWYy1gUNguLpreNiGhsz51tGxnzzIjlfDFGkPGudLduwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734477656; c=relaxed/simple;
	bh=VM+QNCXnDrP8UdH6BTMvIiVKcNzsZ2RXafK3kh/Ccp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCU0ztLPRxL6jcFtjUsulRlNtqTN91w+kGaIS4HLkmy9RwREaZK4vLUPtF+mEGKKEjnHpVlVtIAgmQHcpc007625GlT2RZRLJtJbMaj8db8rTIjpALaJyQx3aJ/KOJ2SMPkF0Qtp20nPREZCvmV6Tgykd5oMOklCQjMLLYeOjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=p8S1822F; arc=none smtp.client-ip=66.163.184.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734477653; bh=CkfaRO9JYS7vUe8PJGPmI990qOhAOdjfpe5IHX5+gXE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=p8S1822FFG1t10IW0Y5p5KZpmqS0EyZCjQI7GPB6Oai8bZ2l6swyCpyuoV8aVWB/rgvqg9kr4zDdLLyhz4tURnf41scW66Ca0r/F95SZ0ygrvfmtDzs1tMwB5+EVHZv4on6EPyoOn8H/lyNuPBexvrf1G/cW2OknPefBkZdpaviLIGRWMbRaNQ7Ru99RQX0+6HX3Y9bMsXqVdXkzWFrZkVX4w7wEVpZVTmAhkLxK0DdL2b4mSbZJUk6pVJe011dbbszIE3zZgXvw4+fSNC4OVhxNiSeDF0BQQXxQ36DItOf4WYx8Kb9rQ5iuWxsrWkAk45b3Wq2/nC+xhWJ6XGk5dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734477653; bh=Dohxa8/2GlHHLim552tdO/UCw8X7yBTSwC347KVWffB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XveGgBM4E+dWO3FL/J4RO/YcJ3prP+yjCHHudbrdGL4IDePUc3l3X8omilDOaMcZo9f5K4jOrl2CEXC2G4qtrsqEscERj3/b3CFOaX5zo6OAeXLLUUrCSHlR9O112e320CsdXx2BPvzhVIFgoGX33GOWg+n4WRCHUijaUfkJQhZygsMQBSwlpd3Gsdjf8kcjnvH4o7wy4eDz1LD5djusDVsPNmq9nrzdbstX080+LSJqLTj4WW3A6I0KFSkuz89hNoFd/ww9DksYqFXuLNDVPmj1us1UctI/0t2q3p54UNmYmV8xOZ8KCbanVP1kvjCw2z5g3SmRQAVAtptO6BPsYg==
X-YMail-OSG: R3p_G44VM1n1WgS51k5wjr5DJYZHnUzgypwjNOmo7XHXhMBooQ0hvCt8qUDtuPY
 3HihUo42Azh2IZL7ktQqYEHRmSBDLD2tj6YftrNT9iGkWRlCjDQ5wBrfhvgu7HrmmnQGftNwCEZU
 hJoh2ALq8yYmQ63uWdzpqGcJ7wMq84rTL328934QsqzbwxoIuZnOW1VcT6VMhPyAJN1fXpFh81im
 aXpmCjXHdgjiB7Jovf05G8Ue0Tnco57qvEVduvdDqHNZefPAZXL0XgUg.uu0OQn92tDoa5gmVCDj
 L6R7e1VKLZAmIUuWr0meOcanBhv7X.vpkIf9hntKlbl_mXzxnsmV4WR3x7JlVLsee1AvQ0XzQL2x
 db_ZccNIinC5bJlM9TKrmm3UJqMF8bvD_71FqNiEBeDtjGjmpjpz4pYjSkw3lmRnTO92MQ_ZQAbB
 .YGAlm92pa8HSmjTBfijCZIbnpn8ykQT8lG9nxveZYdoz3KO_sks8zZfidk7sp5oUUkdvXpnpvcU
 Psxm2SM1L6.R68RLIhOYm5aLYm8xLXgza2WP.6exx8UUanY7GDFGqKADPTtykAb3KkWkESgu5Kal
 SP4ecD8hTaCs6Al7KOSJEN96YBxwrYkxGCqdbzoQOs47zz2sUi32KC2p0360zBMW7Hwkuwg9gSu7
 Et3R72iEdo5fUmmlTsWR7M2UiRMU4aVU0EmuyBZ5jJFlxHnlywn6CZJWy9UnSYQbfJbXmF.OfHAo
 UUWFBK3Qk02hOfIdOAbfG88CPZy32pgWvCsZvaNWn_gGlbZgAYxqQyCr5npuB5zQqE4UAncigWC7
 UcmDSQ_6nAVxn4Wp57KjLxCDvTTdPpiYy4jN9dKI7KGEFAZOYolHcBPwblVn95PgfImLAdyapw3Z
 75LZkdRV0h3e9ZGBrW6_3_ae5ajpWJ1BNP0sjKzAvLFzyjqJgQ0MjCfu7GvhhC73OYv.Xgo36ZUc
 uEBmTepyD1IFERZohNp1QiGwqdLoqsH9_VaFUS2yt5KMxb6gyGZVEUcz.n3fU.lwyPpA_87UjNh9
 AKOicixbicJOYrBWKAsmwCQRAtZCMrk4MC.ptQUbOPop8dgFw27c4alJMApG1QlC0oPbHxVgQs.A
 MaPZs2HSH_NeqpxuVeWOJxrsGLfo1wCoShzh4o.HdP.CcSE8iG1Sd2rAI4a9Qw0UpbbFqzUo7lmG
 gzzjCAVmCE3kqFfHuHoJJn50fz4WK1_19kCDfkP7dUw6IFCKsC5q54bFK4ky.dKomGYtfz.WPkwv
 rLFJ2mTWNEXpfeE3lMqy2DjiKq7SH7WSsH_1rrlleC5tmdljKtwaKrSO5i52xT6XOHXrWVvWlRU8
 2S0Ek7egkRc3QvaK5VOkH6mbtFhXbJ06hPTXD9Y67JgT9PRoKkm6NNrW4ByUN5qPVbsfHM8sQmDI
 zYTAMomxWsvao0fNWTlrTH_.o9PwZN4lXpxLN1i6seVl3gvAlFLS.A7xhw9Kj5tc4wzShUoZIHwl
 geosxV21JBCHPBciS75KXzK0olTgVujzco3eb1jfQOsJ_Qkm3xhSPzxFUoKT87Pc8d.8C17RZiqA
 Fs.QyFcbFoqzqe2Jo_BhZs7tiW81TlZjEu_m0f7MEmH8V6rYAKftS23IEKbkRaanMdaCX4chVhhH
 YPV6qBpFyiQEdd7KRwWUwClzZ9qOxFuuXFurK7K9Hso0i_cx376VaH5lNMIkdvyPamkc3AqQvhdx
 HqrhUTcMGA4A8PE0gDS.edVMVWMyREZJRRqMGfSwmLZFfCX5CU1b4MR0vR9J0W5tprd4fDG2HaBu
 rcaoNP0dqe6nfe2SCfTKeflta17wkUrbpux5QwkUfA2nKiNu17.5bI1pfgzZyAHeIlrozIpyRMvZ
 jNTldpv1L7OER5wPY2G9JgyheuRHysjl_p1.qzPCcEyydc.RbH.CzznLmnrpcNe49oN91sAaDmPC
 Vj78g07rObZRwKPZCDNZx20vcrgff.dm3ZI4C3DmKjydEcd_PxKfZeofa81UdoPkej_5ieib2QDk
 5SmgOLb53YWU4FRRrkVl4nhXz8PHz1avMpAuq9bYN687MULvsq3R1J49mIEIKx_l60WN9ugf2c7U
 0ev4ovlSeQm7mMh29rM5sLY2GyK7c7.V6AzQiwV.vm.6DYJ374N7Ae49ToC4CXapGOwW21qWxjVD
 lMpbENsWh8MOJmPLiLu05frBvARTeCStDhsaE5If8ElPigJ8Utc5GcaL7QDbLTs7vQPiZMXWVWVB
 JFlTeOqV15UiO8DNH8IeIAXcS.D0IMtCY0qvCDcuuYDtqk5UEe2Y-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58ab0613-f260-4b5b-a443-9be5a63982cd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:20:53 +0000
Received: by hermes--production-gq1-5dd4b47f46-5qmz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5db27b1e04260d36afba83cfa77500a5;
          Tue, 17 Dec 2024 23:10:40 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 5/6] Audit: multiple subject lsm values for netlabel
Date: Tue, 17 Dec 2024 15:08:53 -0800
Message-ID: <20241217230854.6588-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217230854.6588-1-casey@schaufler-ca.com>
References: <20241217230854.6588-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor audit_log_task_context(), creating a new
audit_log_subject_context(). This is used in netlabel auditing
to provide multiple subject security contexts as necessary.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  8 ++++++++
 kernel/audit.c               | 21 ++++++++++++++-------
 net/netlabel/netlabel_user.c |  9 +--------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..ee3e2ce70c45 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -37,6 +37,7 @@ struct audit_watch;
 struct audit_tree;
 struct sk_buff;
 struct kern_ipc_perm;
+struct lsm_prop;
 
 struct audit_krule {
 	u32			pflags;
@@ -185,6 +186,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subject_context(struct audit_buffer *ab,
+				     struct lsm_prop *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -245,6 +248,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subject_context(struct audit_buffer *ab,
+					    struct lsm_prop *prop)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index e8661be573a3..f58bfa5c9635 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2238,20 +2238,18 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+int audit_log_subject_context(struct audit_buffer *ab, struct lsm_prop *prop)
 {
-	struct lsm_prop prop;
 	struct lsm_context ctx;
 	bool space = false;
 	int error;
 	int i;
 
-	security_current_getlsmprop_subj(&prop);
-	if (!lsmprop_is_set(&prop))
+	if (!lsmprop_is_set(prop))
 		return 0;
 
 	if (lsm_prop_cnt < 2) {
-		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
+		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
 		if (error < 0) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2270,7 +2268,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	for (i = 0; i < lsm_active_cnt; i++) {
 		if (!lsm_idlist[i]->lsmprop)
 			continue;
-		error = security_lsmprop_to_secctx(&prop, &ctx,
+		error = security_lsmprop_to_secctx(prop, &ctx,
 						   lsm_idlist[i]->id);
 		if (error < 0) {
 			if (error == -EOPNOTSUPP)
@@ -2290,9 +2288,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subject_context");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subject_context);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return audit_log_subject_context(ab, &prop);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 6d6545297ee3..3d46ea6a8bb8 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsm_context ctx;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -96,13 +95,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	audit_log_format(audit_buf, "netlabel: auid=%u ses=%u",
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
-
-	if (lsmprop_is_set(&audit_info->prop) &&
-	    security_lsmprop_to_secctx(&audit_info->prop, &ctx,
-				       LSM_ID_UNDEF) > 0) {
-		audit_log_format(audit_buf, " subj=%s", ctx.context);
-		security_release_secctx(&ctx);
-	}
+	audit_log_subject_context(audit_buf, &audit_info->prop);
 
 	return audit_buf;
 }
-- 
2.47.0


