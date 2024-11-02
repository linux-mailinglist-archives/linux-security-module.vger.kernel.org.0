Return-Path: <linux-security-module+bounces-6450-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FE9BA22C
	for <lists+linux-security-module@lfdr.de>; Sat,  2 Nov 2024 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F45E1F21AF8
	for <lists+linux-security-module@lfdr.de>; Sat,  2 Nov 2024 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9419CC25;
	Sat,  2 Nov 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NtXwhwiq"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic306-8.consmr.mail.bf2.yahoo.com (sonic306-8.consmr.mail.bf2.yahoo.com [74.6.132.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B71A2557
	for <linux-security-module@vger.kernel.org>; Sat,  2 Nov 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576884; cv=none; b=B5MS3lWuDLGqo1JUwpEZnlrYSUImz6OaFccvBJT+RB3yZFxFOk+PfoGttxbZMGyM4jRXiKvg0p5COu4SJLTntYpM6R9aFEy0QFv7OxO2JqT5sZg2jgVS+TdL2WQarMYZOPC97Wv4zCrwiqht/BQh5db39ZbYD3vWfvzFVHgHd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576884; c=relaxed/simple;
	bh=7TaV/c+5EWmmeLmt6cb/HRqJJBvxZYqOAM7Gvnlu1Ac=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type:
	 References; b=YX294UBqLZwPuxAZbvaGHZt3PopzZ/VuXaZSCx+Dq85AGFB023me0dgAtT1Ux+WuMkRwfWDJEDMiqJSW8X4VrfrFBYKS5FcQC5+x6Yae9t/7RMvGQiDv6lzql1CwaulgQpewqqXVcsErCjBDCRhuvNxijIhLaaZMmS7QzVGIxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NtXwhwiq; arc=none smtp.client-ip=74.6.132.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730576875; bh=UNaZ9mHktBR/5iT5lq+P5PzMIOjBTxIWBynAJr6XJV8=; h=Date:To:From:Subject:Cc:References:From:Subject:Reply-To; b=NtXwhwiqA0Oh0Id80VSbw4UjcBRyhq86otx2Z6jWExCWo1w067S0KWROZVWdq6pcmrrsKn+lDANiRiCUxWhsPciEV7fzY5NnGnWAoJZ6xVT0qgBEUKo8xQ2m8yGfD7T0w7Hj1kzL3U3kCh3uMWDeCHKV1cJF4JLrHl5TnU7BdGFrTp4YfqjTePk/d3Gz+qTIvUjwiuFhjzKTs0/hmWHoyBQ5/icbArxNTDVhfuwalFybNL+4amggbXoYBGeFcGXPwhSlPa4e4ReXmYa6rGn8IUnosejJ6do9bzgycswjQO73hBYdSa4NzFOP3XK06boCj1blvIW+LwjY9bBzWz08RQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730576875; bh=kEihzEjp/K3cA9d6VqdtT1dYOmjMqwCDgO40qQhYSTm=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=drkk9SjOnrW9v1xFG+3xZWkOWWaebxKpKpkURSCuHbMPhQHBdj5NOr2Bu++tWTakOjnqaMdt6YSwSz/WGl1N/TUu2yIIhmI9Ieij5aZUg02HF5M75XxHyEADp3b9aH39+ifGiQVWZJidE9/uLAiPcbhKPVqTH8lhEfM0ryNanw68xvSjcnmxORm+JVvQL/Wilnnk2ei7rRudWjqZkQR42ARxMopPDr3xQfXu4dGJFfXGV6gUxhiFpnYB0Yo2QMwumvqqL3hXcqkYoXNIZEMaL0kircNaUyB+7OmxmyRKbmN8pc+E7LFAE4FZlbbaWTAIL15eWXAfm1LHAVL2aTGBCQ==
X-YMail-OSG: p299_18VM1mn7kFyg2HJ1Iy1lbgNf0nirWB6qzb2.J10z1BuHCH7bVu56lbJvLp
 UmHFEAkFYwAalxP7PkZ_GXkbQO_w8.qnB_B0e3ZIhpZMTv4BrCRfQxNLU4cAkLrSA4bf00WWR2u.
 _CLXtLYuRKvDyw1GnugahtAku3_O2CWaRVxIlaSKchlh.pr72m52dBX.Enpj6fuZD5Er4UJd7k8Y
 sHKYRH08nKG.2y_DKQzOpZsgP52.xfy0hcH7OBgXMkRm1j0CqlG2bqGCQ7rNs0vaO4O__yWY56r4
 I0SY.VUTQHD.osJVhOm9X1l3a_Ezj54f4KcQJWVvqoV.bcF98aHdJSUkLzlf.QljObBP6JzAH6bv
 yIgox94N2c_NxtS9sZjjQmpMnOo74o_xbGDagA4oSVtA6UU4OleGQWZEL1_L1LscNO4egg1buawB
 nqAta04gQIB4_FRYYJRpOEWft7JOYKPNJD6CxTVUmSnpvejFoWUlMmSJYyGk.WwAh9qWYCx_E23w
 VNsOd5pYk_EdRwsede1TaMKOCK4a14G7cYBEoP_AAn6bPgHm9ObHGZu0Bi3pyZYz7HNXKTgwonqV
 xLyoFhDpt.KBViwTQPILPlXQTY1NjwhFXHfXs7B5NL0lz325v0SaDeT1GMGOS0aT14oA5.XHdrg7
 EDtUalicHYrx11WpimpebTp65IPwsA6cF8B8yG1.XUn6NZwUNGuYFlkh.ec46U9m6wjlq5Zq8Z8A
 8CodlhcMElDqk3HMjX1dFpXnsc9LpfeOGyZse8dIV76_IZSo3OliFiduR9Q1EDfnwlhm7lXtzx0Z
 S9GJeeg307UldYXUf3NqrobPcsUjjjjh1VQZ1G5rRiIr48.NMZK.DoyP.WPKfnX.VFppHphU56Yk
 sJXdDYpP7Of.ocSxygLLpKSurmXpdGe2XI9hIvQ68ZsjH4mnXuvFoXthR5ne270qszBmGlBgvQYo
 PTmG7mq5.fgssQ3AO_ddh.4OLMEBiGdVllCNvbsiRREGUuPDwvZcFfmG2Y1pfIutrsyvFvyuw5UW
 ja.CjA.ODrqI6zi.6rQ8fBCFYHkzB1Dp6POgtwncevoTESM3UlRauNlyyWdZESGmWKl2S4usXRdL
 _e1xbHMw_L_SUO9lON_90Uug2sPnbKnkh6lxycWtPKtCFr5boV_4wMBQ_oV_UygHJmhLTXah.LTp
 TVlHaujyNBxLBglE2vl.JS_73QS7s5vf9he6ZO7DbYl_GITUlkprG_RvLB3ROOeM8cMPbofQUxtY
 vOy249iEHe63iQzBlu8H99et6GI2pwfo0yMVn4_leanlddXGVNDVjR.TEtsXR_91okiJXhZIAp12
 yUcGDnNYryI9L7g2Tae1TzdO8pMoDxIqP5DfibR.DVDLzRalD_FZUdgD8tM9eEHhDZ92e7ZvMmQZ
 pD_azK3IedbdpYhKsLzksW9VOmYkngjuuKgWvWsSGe5rdK_j6oQKgyWWuccQO6jgcUxku2GWkrq4
 iIcot_Oj4PnCd1qRMsvX9sGBwu.SCK12sJexWBQgDyPKS39KvLuPNchMNS3oiatreUy6pvMsRNtz
 ylQJ0sKRzcYxSPrJFmaK4wzLmsJa6Why0PN2rk.6g6fVsjnT3vFnwLTfM1L9JTFrOf1xE4RtazZS
 BF2SNmGsRrvyGlgLFK8Pc_2usLLsedeOR0yPoiI0o4n7fvDv5Yz5EpgY9EzJyg5240szJG_MxAE5
 l4rI7f.BSWSnJGYRz_2S1An0n2X2Su76qKRC_2sbnD4myNkiTOSG3V0BAfjFTEKD6cBQe4V9C3kq
 cdceRLO2aaNLGfzKSmUqRW8_nK2CgiQX6qQYyNxtnCTfm8x5dwPAlIoykQw3FmlEUoyQ.gwOtIqO
 wxLmq65QFlbbyM7EDMKOsmVe0l3Nc.iGkEb986xelV_5HHSCCrqmgLJ5wKM37Ena7fMtLemEn82l
 PwdReY6TQrlxq6ST0H6WSiBEz_h72v6YSHlW21BhQ_l040YnFWxPwTTsRuw4JW127V0wHJQY5EGz
 Sf7pAZXDG4j8d07K9KefPfvDtz1LtaHpJCZm1S7nKMkn4Imywga4yNjcca5VIcpAheBZ7M1nbNDQ
 u6cYOTI1lSUu..tdeGObdIiphweDIctkROlS9_6lgNm.5DH_Dj8TYznbWSAybWrq0sRRC4YBr7kR
 857qHEfLYl2NbfP_qrCE8GTdwmMYgdk5gyBBgRt7u..Ujxqx3KXrJtOEqcq9mZEUfYqU7va9SyOd
 QVN6alF8oJ0WfFZucxQemrNjTM3M8hrU1MwGAVzT9RBg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 23079028-eb34-471b-933a-e411a3f4bc40
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 2 Nov 2024 19:47:55 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be2540088e62290e816fabcf92eccdf0;
          Sat, 02 Nov 2024 19:37:37 +0000 (UTC)
Message-ID: <55401269-240e-43ca-83fa-97b089de5f19@schaufler-ca.com>
Date: Sat, 2 Nov 2024 12:37:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Pablo Neira Ayuso <pablo@netfilter.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [Patch lsm/dev-staging] selinux: Fix pointer use in
 selinux_dentry_init_security
Cc: netfilter-devel@vger.kernel.org,
 LSM List <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <55401269-240e-43ca-83fa-97b089de5f19.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The cast used while calling security_sid_to_context() is just wrong.
Use the address of the pointer instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/hooks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 996e765b6823..93d2773bfda5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2886,8 +2886,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 		*xattr_name = XATTR_NAME_SELINUX;
 
 	cp->id = LSM_ID_SELINUX;
-	return security_sid_to_context(newsid, (char **)cp->context,
-				       &cp->len);
+	return security_sid_to_context(newsid, &cp->context, &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,


