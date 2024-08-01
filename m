Return-Path: <linux-security-module+bounces-4588-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58676943FEE
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2024 03:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4ADB2CEFD
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2024 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3D1E672E;
	Thu,  1 Aug 2024 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEvN3otC"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86751E672A;
	Thu,  1 Aug 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472793; cv=none; b=o2q0IrFYYO4p60h98oM4eUQdtsvd4IOpvaMvz8ZMw9sbJl6t8J79HPKpUYiC9NgwhqFuXXUo12sjp8TzDz7YDZvL1m1bduGVElkrfF/81z7SqKgHD9afN0dVVIv6MBVemAkbhPUS33etRygn2CMsbx/sR99uqBr1gwC5wQLm4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472793; c=relaxed/simple;
	bh=Ws+HXSKlCElIc8+FpImuch7iVk+Xs/7j2A2vf/PxU30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6Zw7KgsNnjJaBtpcKyGBvQ5idySred6ZDYXs6g81lEWgepzV/26oDZnnVosYPEhDVgUxDAC9GXNld2YefmhPff9zLs47YWCn+EhLnf10E9Iws23MA3be9Wro1IUL7xcRXMHHJ50pBXXSc4YR7YkUHueBB+hhSBrj/7RzTa2m70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEvN3otC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ECFC4AF0C;
	Thu,  1 Aug 2024 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472792;
	bh=Ws+HXSKlCElIc8+FpImuch7iVk+Xs/7j2A2vf/PxU30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEvN3otC1dyh3Mok7PjGENaotbgOJ1Fv4uEiIFb1YtYaXsCtPHy+rOHrLESv8mOuu
	 +NvatRJKmgcKJG06i6e3TRu8vGup5sxRWRC+Rk2jan1huTQmK6e35F/eMrjmaJNoFv
	 BhYPkKZPVMQki7AOo/W2qpCO6OAtR4+orKp0IYFb255zUva5Qex9U45WH1mj+nbRpk
	 mD/Op7PJ6ZWVny9iO/Yr8Mub/xQOYRMZDpwam4cYkUdzQcT1GnrtJacSKWQRLcMW7/
	 qOoun5jFkK17NtFQ4vdyVm8s1DWy53XY1ZjGTQkQnXHuhDURf+EMOTRUNeeS/Ta6pc
	 AqSe3BRUumJvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Konstantin Andreev <andreev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 09/22] smack: tcp: ipv4, fix incorrect labeling
Date: Wed, 31 Jul 2024 20:38:38 -0400
Message-ID: <20240801003918.3939431-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit 2fe209d0ad2e2729f7e22b9b31a86cc3ff0db550 ]

Currently, Smack mirrors the label of incoming tcp/ipv4 connections:
when a label 'foo' connects to a label 'bar' with tcp/ipv4,
'foo' always gets 'foo' in returned ipv4 packets. So,
1) returned packets are incorrectly labeled ('foo' instead of 'bar')
2) 'bar' can write to 'foo' without being authorized to write.

Here is a scenario how to see this:

* Take two machines, let's call them C and S,
   with active Smack in the default state
   (no settings, no rules, no labeled hosts, only builtin labels)

* At S, add Smack rule 'foo bar w'
   (labels 'foo' and 'bar' are instantiated at S at this moment)

* At S, at label 'bar', launch a program
   that listens for incoming tcp/ipv4 connections

* From C, at label 'foo', connect to the listener at S.
   (label 'foo' is instantiated at C at this moment)
   Connection succeedes and works.

* Send some data in both directions.
* Collect network traffic of this connection.

All packets in both directions are labeled with the CIPSO
of the label 'foo'. Hence, label 'bar' writes to 'foo' without
being authorized, and even without ever being known at C.

If anybody cares: exactly the same happens with DCCP.

This behavior 1st manifested in release 2.6.29.4 (see Fixes below)
and it looks unintentional. At least, no explanation was provided.

I changed returned packes label into the 'bar',
to bring it into line with the Smack documentation claims.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 072ce1ef6efb7..7d04b21737cf5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4196,7 +4196,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
-- 
2.43.0


