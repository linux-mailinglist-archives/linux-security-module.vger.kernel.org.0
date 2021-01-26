Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9F305416
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Jan 2021 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317706AbhA0Aql (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 26 Jan 2021 19:46:41 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:45570
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728742AbhAZRCL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Jan 2021 12:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680485; bh=9YoXmcR9GfEUUKOi9Heh7nYvpBpiCcLdyEdcPUGrvg8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JqkoMjtE0EjzT3LnnJkYntYj5joWDk/HBhTCZXOa155OWW2bRzYHDDOpSvqIoi0DDkeBf5zf/1LmmWq1Aj5Vd1CGzAojXxCXG0o3RIPew3hOE4h31ie+zxf3+SPu50NBed01ZM9jYJW+R2wdSI0+QTjxbVfiupVciwPsqilHHfD1E3WsJUfKoaKovE1QdyM5Q2pE1R6mcnyiO9OKFFttOf7y2urQZQ6te+65Zli4K823cJGxsuiUWe6ieNC811salAp9719fYg8uJWD0qrObexl6uaxTMrTXeuUZAUus/lgVxwNAOZ9drcO3s1Yio1m6EseCEHWRSKv4+jE8Q+2USQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680485; bh=bVuCUsFGKiRWMV4Cd81rbOX0bsQ6NomNR9M9qO3SiUj=; h=From:To:Subject:Date:From:Subject:Reply-To; b=mkRf8Sr500HyLv755kQNjemWkXKBVmKaYZ+TAZytOsNTa7dU57W8mW5+iEKC1BzsTXYIijQ69ZfFb+2d7HUE22J4wEuiiyNgTKFws6DeD1j02ZUbEjbnud+3RRaGVGpxxkseh3iP415BZ1bAaGT/l/8bDoKKnEk4bE4ek+3dNnAvbVxeTs+dGldUAOnbO43EszkWki/xkGpQVSU1Fx5zqgCBMjApJOqUCsIEqAJEVvyQU+dUb20qUidpbHjL2EuwqqP1OmPOe+zTonnZSMgnVQMD4N2ib2Q6t2T4CdPWjePKft7I/BufslXfTeJ5Y+qAaRXLPXG63b7pOVAhcxVuig==
X-YMail-OSG: iyNXdgMVM1l5kVouslgwArlYw_zQUwYhnjGiVNgegINh71EjMeP6nBim2DQHaQn
 mrPBuQCiT595uHdwCAgFEUjwvaIy573GdC_VwgtjyMQKK6eKCGIeNq2xjsJcvrE82ZDWwmIGt6Mw
 LshpITZ3KfjsIxt4l75SI7HT1_N99.SfCEAuu_uxYXKbbjotmEiwO5qKmajbcWvTyaPbATPXpFzG
 jbBweaV5x9SZqylU7t6U9GM6dq4uDpp0tVjlOYtvK9iHf_U6wait.1.fAFz2eFo_j01sjUOP91wn
 P.ujPJpOH9TXCzNvDfO8xwRRAbBCkl1TATU0IWPeorZ90cq5wMYNXhQhfj8tExD3Gmn8IfDVX_bx
 75Cypv_AemvzXQ4sEon8ZirkLBVNtHZopGA66PfZPwGLor2.I7lQZ.mbTVZf4diwCczPRnc3Qfwi
 QWOSdfPYv16RByCaKujEXvr_I5vItVEblV_pgcw7EdkBLLJDar1skC5txxyAY9gPUONelZmPsH9_
 ZN_UCW4SdXItrY1VDcwkbWL6VLL3iZ0q4hc6NQ026lS40VaW0aAexEUvgeNyw2LDvgZ_HE1L5joI
 200XNHLQvvIeKMea1K7bzEj0LPLIQi5ITTMfc6wrf68GjUJU93D2.GBaNVfj9.WGl786A5Xe_QrI
 dhyNIl8qzDNiGF_b.KECjHfaqwuT9wMXqUmv_kYQW0Z2kokflldmgHW1ORkqbincjJIEfL.iHidQ
 _5DOYJ1B48iGRoWw5VOmHhGEZ.HZD9Q7lJLMxzuehpGXEdOusMKzKKJXFcJ0LPLrytKUe9.q1O_2
 qO.xNXJKFyPl5YXxm1unN.8PzL.8.vxnl8UU4ZFxfeQHZK6ZVhgDLgDeVIu.P4S3FhM62P2ppSl2
 q_WLlyIHPaQzj3pf75ZquiyaVI6ynq99_REDySB24h83Q7gbaMnx3TE6w8OPq_V02IizduuZGs_S
 If_ibaIpYaWzgRAVisy5_v6feR7H6uY5DrtEb5JO2TJS.57CEjofKhJX_FP7NsCvq4NGN6WucIsj
 kRxqPgDs7QlwFDYCSsddZCIuke_bBvzy2ZMw0XZYmSXcT7m1ic9cO6dFDCu81Y4A_3b40dGiY8Qd
 KlHOn9vwtiBdfMXbMvnW7FPWZLivVm_wr4kbicAw9VR7BanJpU4nhHBR03lBofOQR75gA5aZUiUJ
 FH5Ra5jLNwxS5uuPYcpCKytVGytaO9Zj1atoy0zGlh95t9PrF9WgqAJ7TnKktir0NuyqYkEKt6R1
 KJolTQqCv_0EzCECyjKyzT0jbDrwqQhongr9DYgjwqr_Qw.Dwyp8cF_248f9bEpwBSSDjpe4w2vn
 P1lbIMtnGGi7WIRorncBqZYFofQa0ORSJGHkdLUt7KFBA.DWM7cUO36yyo9CsLHA3tFvc.6WH3Rq
 BzRdTn1tuj1J4hxkpWU8CkV.ejbVCsJOFogjpquGsyEZ7T7YvVFHc6r8.D3wdyfKIaIh7wClDN8s
 7f04EkKVSTvTYNMm1Oj8Yg2ON6ljCe0LLGXxNP5zIw5dhxUjhxfZCCHfrJWS6V30SdpKrbatBglU
 uorp11tqBMSvh1P8nupoJq6tI3yYxVxEmusnHWHIt0X2e.ntgchDLkKzprxN7ekQajzJGtA34FEy
 tXd6s.b9BzlqUz0CYUCxHPcrVL_jgIvTjqHdub2sT1GAKFDOwHL3rIA8N6Hf.Im76eeySbmOXioq
 fEw6dx_H1RdMuB0yb1ss6OoRJrWbpSMmSQro95QEZjrfeMvau_s2qB8o9pQ1BOQ101znya1iTq7L
 u09eVKpZPgetMxzBmL2_6MfqFShjOhLRuFa7ujpUe9qYgGi5QD_0Y4gt7bYYQsFhNvQIEMCIg4XE
 POO1NUJB1BwL9mlMOCdMsQHOMNGqdj2hWyVt5x0y4BIAEvviSdc57vZ3JzPycpPz5IUpexXYfKVQ
 h1Jrim3g7SvZUxxCdzv0VcEnTICfNhu3DN4Rz_7TZxQxtnkOW2X3iZ.QeyiaRmQXElCIhLz3Ml0c
 GXUt8Nw.5Eq2WLoyxnSRvbnJwbDw9OrONfGYMhxY9b7isfiK580qTeigB3MfiOhGNuiBogVoV0Iw
 ph9QK1LoWCAKvYNqIHhxd0uaH5t8XU4KrJ.MbH71a.ZUu2roLfZ20vmPwDrv6y2A54xXdzTOWLGl
 VSB3fKFCM9pAYgTzdPBrGjpDMXbcEtIy19lLPO5GKgEgzWxbMEj0jpe6xAfgHqwHwbM7a2Yd8Vjb
 78D22yqjs5jBlQU4thVMB4yVafSA2iHSFjQimV4MFoD2Au.XhGXoh6o7y9hI2a06Y65Cxjfibrhg
 3rE3MiVO.gvgYnbUYmsAUMDao1vuMTYSVyG9EB2KndCYLlbx__4sPxvEsUJgfsECoMJ2xMJWNbJw
 s2QuHZDDVc1_wY.GAV4nxvwxgK2g2Vigxyzdr9BUuQGFoDxEWbtlCgVaRnDqn6Met3lxtfr3_raT
 Wq4J3UYx0fieu5swyDAtNIx9YocFJ_7pzzKa5Lj4fiWRWfr235T6oTlq07lz6Com_oqWsNPBykVx
 D7ZyNnwvdMkbYwp3rc8RnWhfRu6AMNQ0mzP8dD4jg2Zl0EXI48psQnUNN12t.wYojcYMl28hwF_b
 Q9wXc1LZiiSm.EuQq1KxYb3SzXA4307t_OIo4GwgKw.yDRv_zY2ocn8nKR_DFMzijdswcw3m05yV
 9URyOb.AwBdahIlCSPbAhWUEsM251Zj2HIQsR48C4160SS.0ArO18YVNqeIVXIKO8irrRvQGThVz
 s4GpieIWnmU4i75yjykIhK2ezHpRG2dknt1m3._hxQtUYwrJc2mUpqx3sCm5g9vZENafv.pJZTTX
 rRI30Tx7tXYmeQkc_dfb34PBVEQ37YldBFhnS.MzPA2l6xv_LMfMPnW3xHJ6yoUinI1EBGRbn7e3
 JrFF7hXhZJxE274wCVbedHLWb6ENfiG0W2KtZqAOf.Cdt9my.M7Tq9rOIqTKFrOcIQPSGiqdKclp
 ij3wPs2.goDZ4GDOF2qPi2__eWiRNBEh1rPWC7gX_CnNWl7rcaUpdUeaVhaibDB3oH2uTRhkXxpk
 0yM1GUIheVP2r7FWMzZUmTO4ugiDYfKuXBCxcJom0nAZ6Gus4.uxmQ_Cc4yIrOJaByE6HiooxP3a
 YWUxmbNVisml33CCB3h3PUmuchQTuizCIBzbKUFLBQ9uJrAFvZ0OM0mfirybxVNPNdndGg4X9.u8
 SEEreVft5Cjxw59.YdvZQgKr6KUfh74rpktxIvp42O404KnihkWpnARwDbAfFHZ3CWhXjF_ndrZo
 7YdKjstm5rrlxRlrXR9CZraxqFELqytB5t6pEGHVvxaE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:01:25 +0000
Received: by smtp406.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 95bfae2557e9d921feb8a05f30947867;
          Tue, 26 Jan 2021 17:01:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: [PATCH v24 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Tue, 26 Jan 2021 08:41:01 -0800
Message-Id: <20210126164108.1958-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Change netlink netfilter interfaces to use lsmcontext
pointers, and remove scaffolding.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
---
 net/netfilter/nfnetlink_queue.c | 37 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 84be5a49a157..0d8b83d84422 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -301,15 +301,13 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 	return -1;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
+static void nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 {
-	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsmblob blob;
-	struct lsmcontext context = { };
 
 	if (!skb || !sk_fullsock(skb->sk))
-		return 0;
+		return;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
@@ -318,14 +316,12 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 		 * blob. security_secid_to_secctx() will know which security
 		 * module to use to create the secctx.  */
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, &context);
-		*secdata = context.context;
+		security_secid_to_secctx(&blob, context);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
-	seclen = context.len;
 #endif
-	return seclen;
+	return;
 }
 
 static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
@@ -398,12 +394,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	struct net_device *indev;
 	struct net_device *outdev;
 	struct nf_conn *ct = NULL;
+	struct lsmcontext context = { };
 	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
-	u32 seclen = 0;
 
 	size = nlmsg_total_size(sizeof(struct nfgenmsg))
 		+ nla_total_size(sizeof(struct nfqnl_msg_packet_hdr))
@@ -469,9 +463,9 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
-		if (seclen)
-			size += nla_total_size(seclen);
+		nfqnl_get_sk_secctx(entskb, &context);
+		if (context.len)
+			size += nla_total_size(context.len);
 	}
 
 	skb = alloc_skb(size, GFP_ATOMIC);
@@ -604,7 +598,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (context.len &&
+	    nla_put(skb, NFQA_SECCTX, context.len, context.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -632,10 +627,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (context.len)
+		security_release_secctx(&context);
 	return skb;
 
 nla_put_failure:
@@ -643,10 +636,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (context.len)
+		security_release_secctx(&context);
 	return NULL;
 }
 
-- 
2.25.4

