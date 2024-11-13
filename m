Return-Path: <linux-security-module+bounces-6562-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B929C66B5
	for <lists+linux-security-module@lfdr.de>; Wed, 13 Nov 2024 02:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087C9B2262C
	for <lists+linux-security-module@lfdr.de>; Wed, 13 Nov 2024 01:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0E22339;
	Wed, 13 Nov 2024 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VGUyDhC9"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252A1CD1F
	for <linux-security-module@vger.kernel.org>; Wed, 13 Nov 2024 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461423; cv=none; b=tEN225YxTx3iEkWTm/m/EWUyqtOQ/JMRuqskkFL6brXqlBreNZaeTCoXm/YZWQf+3YH7zZWYduey+T/emkSCZUKbkMU3SOqEWrfbOE7xWv91963hnvdvsxdmao5EoLR4fD5EiJadH4SgyvEqp8xTpn4bYQLfDHLP77dCxjpSYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461423; c=relaxed/simple;
	bh=SlroORLPVCsS8/MtfzHMV8o/2y8GFOAdZJOG9/IDfPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGrU9RkzYBnJXFeyhx7G3/3sZGeL+frpK4rC7pKndDkhasyo74FUbX67tZ0RXvJUpn/SGNW2iAAZA1XxKhombghGZPoGYMaPQgiTbm3N+DphzYbwsMLRmrMFapQ4Io3/mc34S6qttKGE0QgvyyZ7cisR9j83uA9HfYv9YALFZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VGUyDhC9; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731461421; bh=shmrktBCQXaesTtkMCJkfhQ0TWorayqU+05d82/clTw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VGUyDhC9n5YWawQDBlicfCUtPBpL0fBrv0eksiCzlDZ/lNJ3sVhZKcAXkXzI50p1Cq3pVI5fPj5G8LGNpgF6jlo0+qfXbFKEhi7unARqXJ+9Uq/LwoL6JKXN/HTGomSICgvONM+iJysVO1IkoyyG3m6D+qAx8sG5p++8D2itET4oKqMUrHCRlJH4MZ8Z/eikw4v8DAA5/LPzukI2CcqJTfvT+fvKyyRmnTjuFL9bPOOMfKkUC0Ngjo5a1cFAs9t6OZ9kiRZ8aO8e0qmLY8tCthy+uXTyvmnVgS0fE2Sgc7n1C8g2QmHZ0bMYqXPz+8xkyvVWR66ldmNc+EYfanwEKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731461421; bh=sFol5V8w4vAgRIMiiiXmVVz5BQjfA9EuJ/ng1l4VQCB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nkLod7NIx/ZfyNvqQzdt5TtZ3E35Ona/zfAVvjfMMi8XCnauSWON3s7LcpN72FUTvPE82mMI1Ipsfw0IV0drjWdww7sYtb8VZ6Xb6JhDL4qKCP2vvJgWyGfLyrfekwsY/89Lbo5VO8v1gXCh9X+ElS9i29xY1xRNx5GXwvOnyrkGasCy7p3avkIspyc7mw4YEUdxrNC67dMAi6jH/ZdUedLucAbqRr1Kk2/wgUA/hNcvfEIHYmRvYhD3q2ancOmcS1QSdcmjg8KIaC6XZnYb1XKRGpHl/LQVcvlZu3aCjTA+n66+H5hTxPzzI3U2wXq/t/3g/7aNLAy/Cs0yVkDLeQ==
X-YMail-OSG: 9qQwb9YVM1n3hctZOjGDZ1e9CJP4M7eHtuXaKtNMlwyKEl8vKzQkOliSWAiWAK2
 vM2FcfmtKXGQu0dwI2oXMJmxHbTYFRHQTBcJzdpJmRTttDHMtznIFDMo55sjBAMrzLf6Vn1J.P3V
 2wytM98bamqKz.Bms8GrSahWG85Q7G2vuldSuXgaVWxfKsqpD1bPM9_J_LHlgLXqZzsab5OtjFnc
 btunQFBzU_jzRXs2XiLqTnsTYERLN57WdAedu4kcie_xjlcLr.ITCJI3jqop7ALRQwZTa0Er2Jsv
 lmjuw.VY6qFRcMFkKpWis1YJnWyoZvjfaJD.Bx5w9PNsx4qAverbkWsZc2beSGU4g1pp9kk2TF7m
 2ZxifXqfeOddpY4DqdZAIO3RmhQde0VFGWo__zIM0wPCi1faHBxiXhQ77brbXqoH0.9i8gI.8VgS
 L13JAB.epqnKd9oi.toI7ejndOtqet_xyzJMNslvqq4ITPeO4i5DkGoZRwRJNAkDHXXkYpZ.WO45
 6UQgttt_celNg.72uEWUJnIqL6AY493s7j2B99iwzqBdO1YkKMwVmewia0NhFdvHuTewTknuM_Z0
 36fBkXjBm6qWGMb6415jnmowq48VwdIl4iTSaN81az9tHIDU_QsKmAHUMc5xxZGUfnqnfFNqxL_m
 nbr78WvU.rzlJmiqN8uqsCeVWvbHBFb_Ib5NdH3MS09_YfRGn0Dbhzcv8YaY6wuJQ1SPE3Eum7Rp
 9FYiXr0GM._bWfJXQaLfDe2a2lQJdEJ80n_lJDUh60TLS5dcI1v31OUN693NBgVLxiqNxk9wjJBl
 CssVRiocHA7knCVtNpdXNTqm5u45pnuDLjkriMYnkDnio5NsX0Gv014brX5G2koSy7D5mmxh9gUZ
 kc.tiA27whPDJ9TTomTfITPEKRw7RDW4orc2Esm4SqIqRS5sNtvStaSiUnfwMPqqIoc7Tnm7debJ
 vib14lLjxlWPE061_.BB6FQjQ5sNv4QOU20_OXs5mgNxjOeu5eBrN6VSUnH1QvVjIGWB3F4oEgwJ
 TO0noVeTTKHe21jt1Zw88.K7VnHxoF6jWXyCxQ3Jdy0u2WVBCNhJaLNSPuN3.QVpqNUg4tGaav9s
 IXfSIitCSVQtTjiNDeOEYNWPTTEF4ifKSrP.LZJ5LLF0NZ3QhBT_Zxm.TUju_qQorzyHT8.5Bwbw
 Tsrp6kQljJZtlGbdXpZTbCmR.CTxN99d7WQ6owtvB3S.zmApAl1sh98zVeU3PEIS6iBVs4u.qmbq
 Y3Xu9Y6v9DGLdYOEcwFdxPCan_WADSL6IVHJSyU.qbW4x24NWFUe3JenN8ibWO0lmozQPigys6NI
 SI9tn8rkKZoZdd5DzMlIMvfIHR8qnoSEn4gnMhjl2BiFlVH_P2Yt3NmDpnPB.tGAe.ZoeMzoF84O
 hDN5tYwjGpeeGHRc8ejS_Chf29zuySjRkR8QEYub00I7ulHwcsrSoSCO.KmQ2YTOBoqhzcMaEeAE
 Yp4855y8Jz.XLRdgb8.p5QiAkWwwL1gC2NbOwPXPz4lkJLXeJ2xVdSOPorMLgYRKvvqhTHUip1hn
 i3rZBiCaeA_CGQSmFS16BpAlA7W5f9GyaJpfmjhMJfaMf2nFYeQAz5y1Lucvpxmk8xsg76bSbr4c
 D3wg8hy9HX8AqCHmsr0PAwBnNi8vdhfsB6Bmsg6tsf17MoGVB4tXL1EQKPrgLSsgZGWX6G6Yp56T
 Eh62gzvg_ujBtn4pUd.TVdSV9EylsBYBM_ROKN7YE3ejvI7aHXXWQi_yRHtQzDmTL6jn5WLnjulb
 dNQXsI6survJsrB5jAi8EEzVisj1NnYfEVAPIVsxN4jqofjWp_ycnRQCpZaSSnqipo.2TX_vqGF8
 3O9lyC5w8D_WmG1dBpWV_9.zDx3j0yugfHk0z7vWH7cXdRhqgZk4noRcjBq9cRsHVGQGPCST7VsG
 skgrEWZhetI.kw3xoAozAT478JMbDmRPiS06iqK_GEgNFLQegGEbkd05aCvgUu2Utbmz9q0.RMar
 yRybM4u1fZseCzMLWlHSNP1XtLRpiHsZQCNHWFvYcE3E7rvLtSJ03c49nQGHki4oWgnqgUs3cE28
 wUm0NlWgTa1p1Wdk7x.mkJ0n8OJgH1U9tqggrF1m5PTHi4.6tAvnoia1DNhGOOe1PgXOQYV8JlXW
 zOqutjx5bh9LVhX833FctZTIoT5XdGnH.tpa6Vh1QpDz7Yvwx6wGYzIuaCyIhul7HBp4EIRJ77lN
 bWJgEsCkD3QeXKXLe42FK9FQag20jFflf1v9Jou3_GFBhyzwqAVyfa9TGi2l9Ciowrztdo10.Gw-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 516c5a87-90ca-4dce-9f38-6a1b53fd3cec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2024 01:30:21 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e9528446bd432b6a011384ccbc674449;
          Wed, 13 Nov 2024 01:10:06 +0000 (UTC)
Message-ID: <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
Date: Tue, 12 Nov 2024 17:10:03 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "repnop@google.com" <repnop@google.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/12/2024 10:44 AM, Song Liu wrote:
> Hi Casey, 
>
> Thanks for your input. 
>
>> On Nov 12, 2024, at 10:09 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> On 11/12/2024 12:25 AM, Song Liu wrote:
>>> bpf inode local storage can be useful beyond LSM programs. For example,
>>> bcc/libbpf-tools file* can use inode local storage to simplify the logic.
>>> This set makes inode local storage available to tracing program.
>> Mixing the storage and scope of LSM data and tracing data leaves all sorts
>> of opportunities for abuse. Add inode data for tracing if you can get the
>> patch accepted, but do not move the LSM data out of i_security. Moving
>> the LSM data would break the integrity (such that there is) of the LSM
>> model.
> I honestly don't see how this would cause any issues. Each bpf inode 
> storage maps are independent of each other, and the bpf local storage is 
> designed to handle multiple inode storage maps properly. Therefore, if
> the user decide to stick with only LSM hooks, there isn't any behavior 
> change. OTOH, if the user decides some tracing hooks (on tracepoints, 
> etc.) are needed, making a inode storage map available for both tracing 
> programs and LSM programs would help simplify the logic. (Alternatively,
> the tracing programs need to store per inode data in a hash map, and 
> the LSM program would read that instead of the inode storage map.)
>
> Does this answer the question and address the concerns?

First off, I had no question. No, this does not address my concern.
LSM data should be kept in and managed by the LSMs. We're making an
effort to make the LSM infrastructure more consistent. Moving some of
the LSM data into an LSM specific field in the inode structure goes
against this. What you're proposing is a one-off clever optimization
hack. We have too many of those already.



>
> Thanks,
> Song
>
>>> 1/4 is missing change for bpf task local storage. 2/4 move inode local
>>> storage from security blob to inode.
>>>
>>> Similar to task local storage in tracing program, it is necessary to add
>>> recursion prevention logic for inode local storage. Patch 3/4 adds such
>>> logic, and 4/4 add a test for the recursion prevention logic.
>>>
>>> Song Liu (4):
>>>  bpf: lsm: Remove hook to bpf_task_storage_free
>>>  bpf: Make bpf inode storage available to tracing program
>>>  bpf: Add recursion prevention logic for inode storage
>>>  selftest/bpf: Test inode local storage recursion prevention
> [...]
>

