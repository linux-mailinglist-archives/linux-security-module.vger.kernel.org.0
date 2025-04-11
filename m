Return-Path: <linux-security-module+bounces-9300-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B055A8513F
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Apr 2025 03:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C38E8C85BE
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Apr 2025 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469EA94F;
	Fri, 11 Apr 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EVKS/cZj"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic313-16.consmr.mail.ne1.yahoo.com (sonic313-16.consmr.mail.ne1.yahoo.com [66.163.185.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A3EAF6
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334961; cv=none; b=uMCZsDzS+QVnBsNAncZQtePlRHAb4NdjAzjgI2E878ZO5NGjZeExXfWyVWdVpemXd1eFwIZDSLkA/XuDrS/GNIfu7IiWh33bWPr/1c07Q9Kyf/KJtys5f/wN8wMiF33bzfdvUgFvQAIHx6Oncr511DCEMQ6JxALZ9wDWair9sC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334961; c=relaxed/simple;
	bh=bGyPUyI2VTEZCCu4Gg2nbEgKRDX4SV2djzd8qMStHrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJtL+GtCi4zy56RKShIWhpNHHii31ByIpyybzYrmUemaski0jZd6i4QaWOcDL8jDcyVcQOx4DrdQ8l3LeqVXi+2WHJEAHUN0gRRRJg9C1XsPePUM+jQjErd0VybHI0Px/8H9fExcNdk/xcrAytIVjcq1ZcAMRvGLqMabf+qCE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EVKS/cZj; arc=none smtp.client-ip=66.163.185.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744334958; bh=+gfBpPZikXi3DUtgUbivPiG8JP42rMRyPjo+JoS6oVg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EVKS/cZjjeAM8w8135hXV5JLbNTidwMss/lgKw9SQ/BEqdPzlmVepLv6v3YI4OymVOSThPJfaGWgf7SaM6fgjNlejcnoPPzzdsZ3OAIIIlV6Lma3hQD13tecuEakOOcyH3/CgUxQt874hFBvgzWzNrfIVNr0iiBQlHONz5BgxQ1ZSQWAjxbJcbyi/B+hb55JnDSpvErCd692+JnM3p84rzXjsNgb4MMdQXZ8v1mPzEP3H7MNk3hITlaqwUH8sEMqKxnsoBV8GZw3wlEiSE7nvRE7XIdBlZZeCdPtn5SxOpHoRw05dCvn6X55ASC7hru6/JuvixQdT18FLmmHJwqxEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744334958; bh=LcB4+gfpgveMnhDI1qzEZcpZXlIhNHuP6n26+6YCaoc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=j/AcO8Pdert1ullqgndI3KrCDjWhIcB+qEEjK/hZnxvz5bKYTWMGaDW5NrmOezPeL4r9Pv3NKrGqoF9zvkdxlGo7oAm4ODkZdUCKL4sH4PX1ZBAz4LgDOgi6GPY73QJAfPJY1Eyr+4UQ58OUH+LAx6FUhI8N83B59YevTD7Dcp1FPlTzahDCBNMfjg07Qxargi9u23ctjkHTy+531w51aayPSEBfBibTdXkb5ha+q0IQPGH+2aG6Sw7kXOQlp8oMeTttwhE/CDYRxz8/8XNN5oHKEh0nyENMHUHgNdliIIL4wlvI8lucSgJDy3Eaumt+qs4Z7l7jt/sG0m4kY3TvyQ==
X-YMail-OSG: H6TaDp0VM1kjLMjzWBzpKFbx0WrV2HH7jQLw3QQ4xn2AyK23xoadF1ebeqpFxaV
 eaW6_YeCK.cE_jdd.4YjrSJQrtwql6kgYAI7DZXpciDbB84AEaRdyf0BFZlssCfjrCIO2QVA_pTh
 MaDY5etFZHp36_y_.pzc6YeI6X_nn8Xe.XSyOSZ7w7ESKR5gCs_0qMuMH6DQ1ug7uQD_rciOKGUQ
 d7Nuhc8zyDhVhL9lH62YcdbtaVwkb5NSZm4DKy.mGyjn2u8jmEsHAC7E5Fv4iAqwzDTleskspmhZ
 Cj.95gkOKFW50iaWKqh1G_x6rd848BCTcgeF6WxClR4YgjYf9J6fWgSgnGSyO0MwvJHvmXtmpaz6
 7Y_UmheTp7DS9G4X4eeEFAF7kasTHnPvSDttHT19pP7i7frMQDsq2KMGfYk48qYRHkYsb1Q.mxF5
 L9JE7gNCOGaO_MtYacZA186tKz3K5xcDOECGr5ln9tZtjwgqIPUdE.BjDMJRw2wrdA7lcfeS1ahZ
 v3v_cE7.O2.g6_AEw8tXcXsnxBdMUgWcXsv6td3a6eJ8EUjjvU_HljOXYSdfOba0DzkkqcGUwKXO
 DwN.uuQULWoU6lv0fO7R4_CDJ8JlEr0ADTv7OQvd3i2aNAvXOyuxgJ9QvaJ0vNpqSykvYKk1SVpu
 k9yxOGwuECbbA8r7ORM3.9.VP6cCHEP9T6lEyVX1uH_C6qckZS6LrOx4CiqoCKjOF5VgxcU_GAL2
 qf5nPz8cwiEsptLez26heM0qQ_wMerUeWvzTDUiPdz773Y6pfal7ZoKTDEjJYKmgvwd6qTXM1w1Y
 LRi7pckOfjL5oyyUQuqsrloPrcwC.1OLWvOjMilPl4UtHLyYCqjAnRbmvOTp_N6poJtG_qCW58j1
 1nwYssfKc3YrEvsw.sgLLXp7WOCGCAO.d5hpWviRDNFpRzbVevLLDcOJjb5INAdrJhItbBEx5cCs
 7J152sobkJYP3hkpy_saDGPqn2TkBeIQiIH_3ZPeuSaUq_52VvrzI.svMCX73kHUlrNZPUHsnhUb
 fFTMs32UNOZqqUjBIU2w6XTMpOXc3lBVk1qlY.jQATkoFTcamCuC897P6y5aSQ4wKQx_YegL88r1
 u4sz65LBPfG5mwu.eZi4blAU_ZRvFqMPTp8B5RT.NvYdkVXl8E5jO_f1HF1iD8Z_5fzgAztKggyd
 EibHp0HEcW8tNaFVxnrF6vNt46eSnwLiagh_NiulNU3fVQ5wsSSnmtj2cv_ZnSPfV_BZOTzBao7t
 HmGKTD3f0pT1RAjxa.3cNTSzB7gZYL1Q3j0LYEBjbQqr7zGp1LgYv_IiAGYWES3i5GxwqEkj.52Y
 KwGwgERcSZGQEy7VM6fJCBa2j97QyFjz8OFsP866Jd0oO8Y0G8czgO.ywIoIuXQjqd5MyfDJ.MWf
 I9TOCRLFc7nB2WCaYbikVncCVK9WampNeI4phPZhh8doLPyiRPrBuNG7MYjOVt2lUujamodQ5Gpk
 g3YqFxW1N8yrPwN52EP4AR5CzsscPLiMe7s67TWDIfGq3ChvYnBm9ACcYPRlEbZmVkENmuwk81K3
 cg7ZzPXF4fIQ1K3uYTQrer0nSUThheOOUVoZ63YgZ.lnGLqAO8XcSIjgdef0GixITSxWyEZJLdju
 BPBVnnKzgdyG1LcsrEL8.pL9OXZQ7thFGI3zkCsbFw0ast3Yxxxn1UZP5Ze7_U1Ez3LvAyG9yAOJ
 c2bQEqPyAZHDscGO1Ti_Ld_sBr4hdSGgj7VXzUzPPC.qet3cx33TqjmaJGyHXaxBH8bhjKBIj6dj
 lMc6RFo8wcyCAkysEFOkEH3XEDIYAxvv9hOrVe6oczD7ygAXeCoZjH0iInxACl2bKDAu0g6uZxMt
 OqaJ2T3KnRy3T_UjrxUakYQUEij4InJ3BiDueBY1H_hSHu0TEXIe_T6vTCHCzB5pepAfPzy4b6bG
 4WGKTUoHq8mtwwtKyktlmWwwOstovoEiOKPBcs2yCZMLUJeeXWZBMkrBVdKXCmnTIWiLXNenOH8.
 Ade1zCXGLlGSRypwel86BWKTDMAqzk77cHY8vTXwc3Iigji1e3KAQz6US0Elz90iB1n1AmSIQvzo
 BLkdXdl9rXpGBGKnTQYVJKkKE2WfDA6NL6ujq6hzf7MoU7CeP5.gIMZr_bW7Fm7aBC829qmUN8mg
 VP4Fg1BQEu.6HJ4j00VFmDBd9Xsea2c09cYs8JRAKEzCP7XdeXO5MO6BkNPHmrYb1HjX2el3ai19
 sxuj8AVZR6xJEVeKNlOqlLsJL4jNqWF0FjwuSiWJdQc_5ML3RSb3M276GPf0bR4dzuSSU5zOaUeT
 cXpCvZNeKE7dlXpWby9e.xMBevppOj0gq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 79ac8f6b-f216-4850-9c7e-a007caa7459f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Apr 2025 01:29:18 +0000
Received: by hermes--production-gq1-6f8bfcd964-g7jn2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e936a47855da028a6f6000b5683c216e;
          Fri, 11 Apr 2025 00:58:55 +0000 (UTC)
Message-ID: <63b4c34d-94f5-4da6-88cc-98a808d418f7@schaufler-ca.com>
Date: Thu, 10 Apr 2025 17:58:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-38-paul@paul-moore.com>
 <202504091603.107B41F4@keescook>
 <CAHC9VhT+yr=Pf=sSpFAO7RbAGejRgQhKPDLppCeOmydfhds5qQ@mail.gmail.com>
 <202504101524.827B6FE55@keescook>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202504101524.827B6FE55@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/10/2025 3:25 PM, Kees Cook wrote:
> On Thu, Apr 10, 2025 at 06:04:38PM -0400, Paul Moore wrote:
>> On Wed, Apr 9, 2025 at 7:06 PM Kees Cook <kees@kernel.org> wrote:
>>> On Wed, Apr 09, 2025 at 02:49:52PM -0400, Paul Moore wrote:
>> ...
>>
>>>> diff --git a/security/lsm_init.c b/security/lsm_init.c
>>>> index edf2f4140eaa..981ddb20f48e 100644
>>>> --- a/security/lsm_init.c
>>>> +++ b/security/lsm_init.c
>>>> @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
>>>>  static __initdata const char *lsm_order_legacy;
>>>>
>>>>  /* Ordered list of LSMs to initialize. */
>>>> -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>>>>  static __initdata struct lsm_info *lsm_exclusive;
>>>> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>>> I don't care either way, but why re-order these? Just local reverse
>>> xmas-tree?
>> Sure?
>>
>> Honestly can't say for certain, at this point in the development
>> process I had somewhat resigned myself to having a mess of a patchset
>> so I figured this was an opportunity to make it look "nice" (er?) in
>> my mind, and I suppose at that point that looked better to me ... ?
> Understood. I think I ordered the original way because I was hopefully
> we'd remove "exclusive" soon,

In the pipeline. Small values of "soon".

>  and it felt better to remove it from the
> end of a list of variables. *shrug* yay code vibes
>

