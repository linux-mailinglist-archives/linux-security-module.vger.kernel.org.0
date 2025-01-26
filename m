Return-Path: <linux-security-module+bounces-7916-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4705A1C841
	for <lists+linux-security-module@lfdr.de>; Sun, 26 Jan 2025 15:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4AB16346C
	for <lists+linux-security-module@lfdr.de>; Sun, 26 Jan 2025 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859C136326;
	Sun, 26 Jan 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="fdYaU6Ib"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A325A64C
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900507; cv=none; b=lAW5UIoinXQ2ZyJKHOAB9ScYe7v6EI+eSSOr/AapVfP1cQmqyd+0usA/Gjbnglcb5nsQNPztYt6MSBfewJn3AulkEvGCw5CH2czjBwZ4GGxM5XqKiEjltOK9/cwnzYt5ysihCJgP3wJ8x8aaV5Vq7ByYEXALNrUR8dsVx/F+x5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900507; c=relaxed/simple;
	bh=ZEcOhEq59oPrfN9rSPj6v1bKQ43YrEzV3c4fMhY7nbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qp5Dor+nuR9cRRQwcdaQVJSS3evJF2egQ9Lj/zMHMLhCDPfvxrxDiHPrpTfbSCM35xbVRGFFL2+UwLS8BakUe3NgN+WmAKionpU+TZDkBPwA0BGc/JgzbMQodaDSV3FRvm6GsdJ0NplVO+NBdIOHonSeXbv3GBac4E4P1l1wZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=fdYaU6Ib; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737900494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XYL5oC201jCKuTwuNNf+uB00FbWPc6puKnpQEff124w=;
	b=fdYaU6Ibr4XLNFJ1jgZeZF6Kmxyf3e2bx2v15fPCuqnm55WJGhnoCpc7iP8wk9hzzPU12i
	dvWRgKS3Tfyxu0NmyhJZTNfW0mau1x9V1M2/DpMvL15ZI/1UEYajtav6se9IJ5/Yfy6zfq
	4UQv0pHFYF+VMoMjCjkRa+lPs7uGJbo=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] smack: ipv4/ipv6: tcp/dccp/sctp: fix incorrect child socket label
Date: Sun, 26 Jan 2025 17:07:27 +0300
Message-ID: <20250126140735.3296531-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since inception [1], SMACK initializes ipv* child socket security
for connection-oriented communications (tcp/sctp/dccp)
during accept() syscall, in the security_sock_graft() hook:

| void smack_sock_graft(struct sock *sk, ...)
| {
|     // only ipv4 and ipv6 are eligible here
|     // ...
|     ssp = sk->sk_security; // socket security
|     ssp->smk_in = skp;     // process label: smk_of_current()
|     ssp->smk_out = skp;    // process label: smk_of_current()
| }

This approach is incorrect for two reasons:

A) initialization occurs too late for child socket security:

   The child socket is created by the kernel once the handshake
   completes (e.g., for tcp: after receiving ack for syn+ack).

   Data can legitimately start arriving to the child socket
   immediately, long before the application calls accept()
   on the socket.

   Those data are (currently — were) processed by SMACK using
   incorrect child socket security attributes.

B) Incoming connection requests are handled using the listening
   socket's security, hence, the child socket must inherit the
   listening socket's security attributes.

   smack_sock_graft() initilizes the child socket's security with
   a process label, as is done for a new socket()

   But ... the process label is not necessarily the same as the
   listening socket label. A privileged application may legitimately
   set other in/out labels for a listening socket.

   When this happens, SMACK processes incoming packets using
   incorrect socket security attributes.

In [2] Michael Lontke noticed (A) and fixed it in [3] by adding
socket initialization into security_sk_clone_security() hook like

| void smack_sk_clone_security(struct sock *oldsk, struct sock *newsk)
| {
|    *(struct socket_smack *)newsk->sk_security =
|    *(struct socket_smack *)oldsk->sk_security;
| }

This initializes the child socket security with the parent (listening)
socket security at the appropriate time.

I was forced to revisit this old story because

smack_sock_graft() was left in place by [3] and continues overwriting
the child socket's labels with the process label,
and there might be a reason for this, so I undertook a study.

If the process label differs from the listening socket's labels,
the following occurs for ipv4:

assigning the smk_out is not accompanied by netlbl_sock_setattr,
so the outgoing packet's cipso label does not change.

So, the only effect of this assignment for interhost communications
is a divergence between the program-visible “out” socket label and
the cipso network label. For intrahost communications this label,
however, becomes visible via secmark netfilter marking, and is
checked for access rights by the client, receiving side.

Assigning the smk_in affects both interhost and intrahost
communications: the server begins to check access rights against
an wrong label.

Access check against wrong label (smk_in or smk_out),
unsurprisingly fails, breaking the connection.

The above affects protocols that calls security_sock_graft()
during accept(), namely: {tcp,dccp,sctp}/{ipv4,ipv6}
One extra security_sock_graft() caller, crypto/af_alg.c`af_alg_accept
is not affected, because smack_sock_graft() does nothing for PF_ALG.

To reproduce, assign non-default in/out labels to a listening socket,
setup rules between these labels and client label, attempt to connect
and send some data.

Ipv6 specific: ipv6 packets do not convey SMACK labels. To reproduce
the issue in interhost communications set opposite labels in
/smack/ipv6host on both hosts.
Ipv6 intrahost communications do not require tricking, because SMACK
labels are conveyed via secmark netfilter marking.

So, currently smack_sock_graft() is not useful, but harmful,
therefore, I have removed it.

This fixes the issue for {tcp,dccp}/{ipv4,ipv6},
but not sctp/{ipv4,ipv6}.

Although this change is necessary for sctp+smack to function
correctly, it is not sufficient because:
sctp/ipv4 does not call security_sk_clone() and
sctp/ipv6 ignores SMACK completely.

These are separate issues, belong to other subsystem,
and should be addressed separately.

[1] 2008-02-04,
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

[2] Michael Lontke, 2022-08-31, SMACK LSM checks wrong object label
                                during ingress network traffic
Link: https://lore.kernel.org/linux-security-module/6324997ce4fc092c5020a4add075257f9c5f6442.camel@elektrobit.com/

[3] 2022-08-31, michael.lontke,
    commit 4ca165fc6c49 ("SMACK: Add sk_clone_security LSM hook")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ce7d44509973..1084ec5fca98 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4350,29 +4350,6 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 	return 0;
 }
 
-/**
- * smack_sock_graft - Initialize a newly created socket with an existing sock
- * @sk: child sock
- * @parent: parent socket
- *
- * Set the smk_{in,out} state of an existing sock based on the process that
- * is creating the new socket.
- */
-static void smack_sock_graft(struct sock *sk, struct socket *parent)
-{
-	struct socket_smack *ssp;
-	struct smack_known *skp = smk_of_current();
-
-	if (sk == NULL ||
-	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
-		return;
-
-	ssp = smack_sock(sk);
-	ssp->smk_in = skp;
-	ssp->smk_out = skp;
-	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
-}
-
 /**
  * smack_inet_conn_request - Smack access check on connect
  * @sk: socket involved
@@ -5179,7 +5156,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
 #endif
 	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
-	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
 
-- 
2.43.0


