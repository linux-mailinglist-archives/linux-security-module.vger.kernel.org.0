Return-Path: <linux-security-module+bounces-3952-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABC913015
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2024 00:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77571F25F7D
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Jun 2024 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4AE16D310;
	Fri, 21 Jun 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BVxRMx2U"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE817C7B5
	for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007845; cv=none; b=OPzKnr+auuWjb1qFm0/OhjE8+lb3xNq6bGkw0Bdh8R2XLH/Pdpe3X5gegQIMcNr6OklMz83jef8E5nmT15QoNHQLFQmOjm/UjuaBl3AtnipxJoCPIAyDsoX2pyKdhhW6dSXSAilB3HKzcv78c0WdkXQ3JZt4iu/6Mpv+F4McAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007845; c=relaxed/simple;
	bh=/3OUXbxbh4HVBBwvgsX+pbK2kz+8OtQOGQtbeuGta1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRlvM/vtVHxhV5IWUkmPgRBVELFXR8dyVpaBTPSWQZtiBuMbHROSthsPTJqOZiU0QGo1Dj1vRI38aAhqXo5kcTpeoro6NYwTh8j6xknIp7blRabqaAAjdgcuMvPEeM/qMBoCT+lP0VbkVCDXehRiweEEHmY1nljKUf3ba6nDVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BVxRMx2U; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719007837; bh=W93MUuqF8YI2qTC2EngAWFfgxbIWTzpfO4cxB6FzZ44=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BVxRMx2UZ4Sd9mDni9AlM6542+M+c5KP3zShg4gsDDXyQJcA+IyJtgSfGEFzc40U3qxJUt91Ax2NIzE6T0Wl2GxlS/7hydpzGI44ToE1zvyhqe9RhANGjrJul36jkfr1ElmqAXLRMSNuPXKSueqCgvGEZal13dy8WBfKKWqItUjcF47k4bqFx8viasQLr35Yx/oFFl7gdcZkb8tYwIvYDW3gT8qW0S9/hX0f5+ye602NqXlCiVeADggDyj8GaG+0nkGUOlish2zBsdxGdU5KDDK9ZM5WehFOdQc5GKi5SDPQvNkvWeMLqjXK/24vf8pflArLc0lqP/5dl+ZoY9wcsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719007837; bh=ui6s94h4q2oudp0CSKkXKz3tYjBAbXlEXtQLpiASxhy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EuPVysbHMMYzOZdicVN27+3in9yPa/SJCP7qHyNIAYgZCF72Svkn7sYR4wUPTGv+3iDs13s7MzbijyIMvThIWAd02UA7IKmQvcxWtaCB3fscWjMxRFaE0NS8IeheG6/PdfzfoX8RlSYzrNrHS5CXI7FjELtEBHHqEsSLxbk9H3MLjUukVXG0Ld0tTTF1O1vyfHD1cd+nT57SJnJoO2Vdk0K9+b/dV0N8OSKNwuS1UzZMo9OEWYMdAjL1juOIHtsxvpiQAKmwhl0YfUcF9RGw0QwDzfrE3nmBGdRY/JBJoJAAdTOl4b58kv2QwPuJRjht1hRMwnhnfg02Sfq3NlRbLg==
X-YMail-OSG: xHIJgvYVM1l_e5pHrqiy_yh8PxQUmnnZNw03DwldaoYhvIGtjxoRyA1hUkbJVF2
 SyOTADNPwKlhsH4_83zkPIKbRq.Q0DDQVZXhiAYJiSXcCpI4pkxrfdfI3vWbH_etfKHXhHTVjZSE
 HA9zfNysDePb7ZPyH_ti6YBa2UBkPKPpnnvew_UvKOdqFRm71QQRYfAegjLsmc9dSBpn_3HWkfhq
 2x0HKa_ysth7HW2P1UYkZvIszKuYDsub_iF_rSh8nYr65Q1fDLOSK9UpkwRw1a12c3eFmJlbg0gG
 Ps.qhuEdAr69Y3LbxLYIrKwm1QmlWSyFaCxW4GRYkAmyhSzc8GD..EoXavTvvE8fvz8AAOZYWO2Q
 o3oiK8stAertTzEtGqR0VWSFo1XxCDtA2Im6C9LiZ99jz75WJ.24MDm1a5yBTXJFqFBe0p13NiRI
 laAyoDkDOk1F11Zw.0bvEP5UrWMudvqUqBMOcoVmVQHQCeUBz8ignD9gGW8tWJmNH5YIn9OL1EAC
 sLK6kt9hL_Pg00d2R.TgEfim0FuBicqwA1PecLiM4YD_llWpfGSbZ1LIDtys8G2TXmDsA52XupJx
 PMZjxcX8z7U_Z4l19e7ijxZrDfSkg02CsUczSeAbhYVo.NUZLs_Rb6nmI.15KZLAmHmqd_xQlpSE
 HmNNwR.v7AxvawVtBWhMpYm4Fien70j10RRBAXyJ3xDHBseTIV7f_f1eAJzEQfKRtHy1jSFI_5O6
 9W4ox2yyxPEAeIyvRTDJ3DpJXsE_QCHuPUaY23.mIkOVS6vbqAUc6Jes1P2vRpSC2fto3GRdtTCt
 BuaJOI1owyBSFNasUaLZb3jT1bVk.4EKVT2a56pf.sHQCSbSxXgGi6aJ0BJffqA2gp_i8u1oSZ3f
 6N.WKA.hUb2iRQ7lBTIaV.2JXAVAuRJdP0_rCTSyDr443NZTQ_GHzuY3STxDEXNsHP2BX2lIa2JT
 UPUwrhHrgTQGt40I8FtCXt0fPc.do3fDAEvnbMj3yd5kzy34.U2DukQcJ3ykWDIRnZKgwaQBFlbT
 2SPn6B6Yfte1JmW9oVQBt6Bcr0eQv.Jwsjrus0mnWb1DVqrjLzOZuLMlwC3u0oxqaRTJfpvyZcQD
 k_bAPui8HfxrlGg_yH.wqVeDrUAvUUuOv66uKwagBp2Eyl_eVayXfj3f2RzP2xxd8enU.owi.whw
 4j1OiGmAUtbNINy3mzjjRpaIQoFuR577yzUkFvYzKka61bZN61J_YbfDuPhwUlBePngWeWdasony
 XyvXRR9ac5F2y3agMebnLJSGv0E0n1RJurZ12HYCGD_mRUNfVTw_vyGNYReqT.7d32FalsrkhXNM
 YE7X70zZYy.QvxBzsj9hBywvB1wAn131GV3nDNvyu03jd9V32qpkMJUAeZ2O0s36i_sjiky2RBnE
 IR9_V9wk3p3jbdJ7umKG0BtTNjwHO2yc.K1TxmSmTGg.YyAgWznGK4qarj.5z_LAWmyAVyNnpFVI
 EUIeRBnK.jdm.oeBa_etlm.RFulscNElPDHZJaIfhlqoxSiSf0pApy_vsW756ibuOUjqt9RIaFfy
 FiaURzn6l_1w4u6FvRoYbgGCOW1tSciD3ceLtTOCX_0Az.et8w67gzyvtLQ9wApkF8Pru3jCYO3U
 SqnGkd1jqaq.D.BWNalIaF3QkpLZor5mF09f1GiHTJTmQLzRtdMbbmXBF6cDdoHhmBSgAFBWvScq
 b.DzMpIcEfNHzmK.O17slhHyZ_jfQFXwhAIJAbifTkTVWxx.PwMVxHWIpeLuhEukWJgfAF8Off20
 VCejX_LNPVoO5MDUVNnB.UeFvWep7en17N7Y6GMQ3jmJWoF7EUmjPdDrF.JPqiWCXfeksdI5Cwfx
 oKAkT7Eci3JBKS0SDAE9z3tItrRYpvceo37.dySQuLtrLhJa0ImT69QsKnCtTEo95RjTqcDKLJL0
 dxMhgkNhQdt3.dTjhhaQdvRTgawMLhdFz5vaILGYncO00Zy03VhwmPwkoaYJG2GlPcd.flgMobOs
 3tsHIk32BxbadWd5a5QpKTxIP9VT4cScMqPZr0iu.ikEYWkmxj15JdbnXchSsW7B_J_QDOGtprtl
 bKecFPJEE5a1OCuLLQKrB1xulpgMCgz24Ns60rT13dXBf4iSvPUG_fruCb1xupgZhY4HVVIHS0uD
 SHd1H0ZWEvi9xgJFapzZbp_zTk1SpF3cNUx3FPJc6.k7Y2YYZ2rba22bJEOwnDg5Y6dpidlYfXBz
 YOknam3R1lChQ7W0ePQWNYxezpArxdnk8PnmZkKVtSmrwCXzeAxdoz3O1wLXzb.2IT3Ln8viyS9w
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 40e448d0-786a-4711-84b1-e00c610a0ba3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2024 22:10:37 +0000
Received: by hermes--production-gq1-5b4c49485c-75jqb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa3be147b3108ab3bb88dd26f261d3a7;
          Fri, 21 Jun 2024 22:00:25 +0000 (UTC)
Message-ID: <2cddc480-f911-44e3-b415-33e0cec2964c@schaufler-ca.com>
Date: Fri, 21 Jun 2024 15:00:22 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] LSM, net: Add SO_PEERCONTEXT for peer LSM data
To: Paul Moore <paul@paul-moore.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
 <83ef6981a29c441b58b525e9292c866a@paul-moore.com>
 <c59a4954-913b-4672-b502-21aa683d7cdb@schaufler-ca.com>
 <CAHC9VhRjbWuFeprjNP3r7tU27cW6bEZytWq-3XTjzoN7Ki-zzQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRjbWuFeprjNP3r7tU27cW6bEZytWq-3XTjzoN7Ki-zzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/21/2024 12:41 PM, Paul Moore wrote:
> On Fri, Jun 21, 2024 at 12:06 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/20/2024 2:05 PM, Paul Moore wrote:
>>> On May 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> ..
>
>>>> +/**
>>>> + * security_socket_getpeerctx_stream() - Get the remote peer label
>>>> + * @sock: socket
>>>> + * @optval: destination buffer
>>>> + * @optlen: size of peer label copied into the buffer
>>>> + * @len: maximum size of the destination buffer
>>>> + *
>>>> + * This hook allows the security module to provide peer socket security state
>>>> + * for unix or connected tcp sockets to userspace via getsockopt
>>>> + * SO_GETPEERCONTEXT.  For tcp sockets this can be meaningful if the socket
>>>> + * is associated with an ipsec SA.
>>>> + *
>>>> + * Return: Returns 0 if all is well, otherwise, typical getsockopt return
>>>> + *         values.
>>>> + */
>>>> +int security_socket_getpeerctx_stream(struct socket *sock, sockptr_t optval,
>>>> +                                  sockptr_t optlen, unsigned int len)
>>>> +{
>>>> +    struct security_hook_list *hp;
>>>> +
>>>> +    hlist_for_each_entry(hp, &security_hook_heads.socket_getpeerctx_stream,
>>>> +                         list)
>>>> +            return hp->hook.socket_getpeerctx_stream(sock, optval, optlen,
>>>> +                                                     len);
>>>> +
>>>> +    return LSM_RET_DEFAULT(socket_getpeerctx_stream);
>>>> +}
>>> Don't we need the same magic that we have in security_getselfattr() to
>>> handle the multi-LSM case?
>> Yes. I would like to move this ahead independently of the multi-LSM support.
>> Putting the multi-LSM magic in is unnecessary and rather pointless until then.
> Starting with the LSM syscalls, I want any new user visible API that
> can support multiple LSMs to have support for multiple LSMs.  Yes, the
> setselfattr API doesn't support multiple LSMs, but that is because we
> agreed there was never going to be a way to safely support that usage.
> In this particular case, that same argument does not apply, we could
> have multiple LSMs returning a socket's network peer information (even
> if we don't currently see that), so let's make sure our API supports
> it from the start.

OK. I'll put that in v2 as well.

>
> Unrelated to the above, it would also be good to datagram support as a
> patch 2/2 thing in a future version of this patchset.  Please be
> careful not to carry over the mistakes we made with SCM_SECURITY (see
> the GH discussion linked below).

That's "in my queue". I didn't want to spend time on it until I got
feedback on this one.

>
> * https://github.com/SELinuxProject/selinux-kernel/issues/24
>

