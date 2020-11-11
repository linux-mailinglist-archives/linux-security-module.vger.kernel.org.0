Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5F32AFC37
	for <lists+linux-security-module@lfdr.de>; Thu, 12 Nov 2020 02:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgKLBdu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Nov 2020 20:33:50 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:35429
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgKLAJW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 19:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605139761; bh=gbDRRLj3nC+66Gz+0gdW214wwNJkkNR+I4HxPH7eHqE=; h=To:Cc:From:Subject:Date:References:From:Subject; b=o/Hs0K9/mluqcCgtiWye711nKRPZzfTZU5qxvZ/uHvXppHCFNzvg2PURg6UNEplsHbI8aYPi/yAFr1IivXQPCLZOdpo9IOF0nW+NHEIk3GkZMMfmyPUcozcj38ALmsJIh+VUUIpFbSlPyArklc3Ktusbw6/QfQuS+FU7MKDOVwMqVqGinizoMfwzIeWYLeC5eVBFPaUuIbYA7vqRpEqaiE8Bnm2mR2fbbT9K4W3cvEihs532vgBnuSCnCl+zFo5fm3j/gLEzPmbeZ/aVa/Jot/c9nHci14N5QeBnsYRIrNGUDbYRIq4CvZ2d9yETRGqpn80DrQ7pua4ztwETAXBnBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605139761; bh=xS755tmpiSST2izJwMYgtRdkMk7y3TA8tye59b8hCRm=; h=To:From:Subject:Date:From:Subject; b=hFAYnyjWw35M8W/sGLlUwSi+CGPCWrA4a7Me8J7a2ILiJr1om2VofusVGMcITb3RcVmxFQwikhkp59nte4AlmgokHEXnoZpVf4Jt7dUNkI4AeVaQ9xQJf3HAaYYhB30hCLt4Ud+SpkZxVnTzvXEO/SUNWz/fdYEBMxkTI8xoRunwu1j/ecQ3dS9YmwgCFDLojX/tQRAZ1Qh25h+kcm7QUh9GVe6H4unAcqxr8hKJsFs5MqAt+9x3rzxna8yqcYWEBUQgteGKXPNnkxzV+y6jXogcVZ4yIxNvRu8W5+0JvYnRrGtXEsmaPJP+Kdr571nY4ApYvrANyLO4fCcMJCw8+g==
X-YMail-OSG: H8fUJRwVM1mJBcCnxbktDbhZMeC6X_4kOngMMLVsXLjQnIs2q9nan8wWD74DyP9
 PbT9fW.TnVJLW1Ulq38wCM_Tl4F4OILSlT2NwVF6BTeQXNTCp6sCuvsWbnHxhB6tVbdVIcH5_PK_
 HKjU7KRaDxTJRM5EThleaY8nS5n5ENrIkaaCACvlPf.4_VrxKFpyeQa84ot2Tr0lkNw8DRMqQPt9
 O5Xfa.NrWPkJrsAlnhjR83979nAf9WoE_Iu3HMVRcZOKa_p.wPkvlMW.w5xGZAlfLXvSJkuBANvz
 MCxjnDYOQOT.AJ30qFgnbkqDL8QHk4vvB6q_paD3WULlcN2Sa_LeSZ0wiE9u1ooVdcRctSg1.jmz
 fA97PiqVfVMAQDEkWLnrH.sRhNBP6LulqHaIUvgzsStS.MbWuovL.dGO0LPCuSroEMKsyHVI33MP
 RTL4lQPhw_UMfuMDvxHNiUwzMFcI43pOSmLQ6MiSnP3vCS2jJQWXOPmtGEsyBu1NPIb2KIKjCZE2
 Zmxe.iGzIp_fqarE8Si_uwpohiQrXKS4qC5_NC4PwNFcnTpcQoi7SZOa0EPwiMul7bR0RerzzMIV
 BjSAxCmBdwNVbO11A00aZnFwV1Vnyv1EgDbx4xCxK1QMC02Y9xXfktienHq3J.xUulZMLTwUW05S
 g_5pftKdM21eXU4uBHBnqIPPMfAHWrutipqZ6gp2pC3oxNV9v61uBSK8jVuw55E2U6JTGJDwaMWS
 .9q8RdfXHtrI8sgGbmDkqZbtQOaWgz4UQj5ZnhCPS9K63ShIL_Ng4QBTjm3qmW9Ydn66JxkgecI1
 DiJkGvrox2pLTbgKPkYn9z06mBJWToY8LKM2W9Kd97YHtZahzLBn.Fukpt2HIa4..r_O1Ejeacux
 Qc92E0Uct4wmfgOkPP1gYEpaMik8N7E8JXXfHzdrlS1zy1bVP.Vjd12DNnIJxzznzkKo6heKAXaH
 4qUwe1dlNZQ5QXORBkPpcKIEFCDoaHzsDPykQ.PFnNNJ_2kzpNm8qvKGFzF_0Qom.bhXEnTyog.4
 0MYtwvbTdGyfVF648MYQ5ZX.kIeqKt4xTXXqjerEZ2HKxa6MUl_wMliPnCafz7YS5hKy8ySKWajr
 pENZLK5FAltQhJYQAoUKsWhb7KvIZV32vy4zkTc3t3kct3DcT7Zq44g.UVvDZrEXIhVQ0RZoZFa8
 .e0oHwbzuZ1yyCVxbNxm9rjeyr2iNNbYPCokH8q_pm7RIl.MXeR.2s8hnN6Tr.TXw9_ltmsZo9S_
 Xu3l4ANS9QY71W5Er7n.0IkeL9MLrOw6_FdmcXqv.J7dYbvsG6z4zso0NKUYdE4_bT_gzGBrILj6
 y8EQ3sGl935RRq.aHbfLtKYywTRBWvic0yLjrQ.p7Mm4wlg2h2qoMkPQsWVCVbkdtFOXibnJuHQI
 kZBeNnP1O1EcwTYjsLXQL5WDJ9SvzylT09wZOwN_nS5HTbxiWpy7o1VWzRJkStJ9KOuv4vNZCwLM
 4ZV.qNph8KNlVUGS8gvQTp.hf1x_o6WobhUYgXI3naTBbQ161g5yNme5H2KOYmtlSn0dcEogAU_v
 kalJvEqkPrIhWx0B3eqV_4p5lBKjlSQa3x6UG1fjOlUH5NTVVL8NA3Xln4v7vCCCVEL9YEYJQ29r
 sU0Y8yEIyjj_O3.2eyaS7VO5FuVA13oxtXloZcCOfOAcHlVaeQzfPN08930vd2kNYrkJHtmBcfdx
 HScy15rHyJd56FIWOQJu5oKoqcdgdsBU0e3KdnO_2su0n5lcKbIBXOtP6xyq0Wb5cvrw4BxQ0M0W
 K1kuHa7uR0htcuXqUeqTerv_GIg53cwtx9m5YP8TqUL5DDiS7hJM4WCr97dhRUwEYlb6jobd5heB
 hYvTJg5NNBCHruSSpA.DYi3RXmWGF_3.LT7kX31iaIJTk3EAp16MISL8l0wiMxUcuo.ieKLjdGmF
 6vw9GI8DXyN5lOgKnwgSHF49XkUiR6MKwHbtzGvuIT1RtWTK1xgNlwlzYZeHm85p_C5TL3R8.v2u
 pdOGjerjgz2KN.9RLBR1.pr4V63fqNufyhEntO08ReJrxCBwDQoQR0KTzQ9uMkBIh2FUrY4Kjvi9
 cBikjCUwtSsoftifR.c1Jow7hK.WLmqITr4J1sa17cGRT78edudNM2YOOxpYZmdEUm1Cp._P2CRA
 s65o_SbiMgov4r2LlwsFLUHmk.BOzlXqWTqc3p6lNGy7gzADBs5OT2zlrO2wWgf2bZsKJOxAvK67
 dcYXzkRIHI3ka7TyYEeHh6pqUtObZ9AZhBywLZVdfuK7CUKoAFufV5ReuAEsC0SFyLmhbPg8WP7Z
 u42XgwI5LBDldXkPhoJeOVLiHjdBUu8dyLoZJRHomHU0hZFSse3EKiQ0z1bbOg0fneGAB.HuLHg1
 _R7wlsambfVRL3KLtltEyllB9AXcmUWCIZfKOzu5W3RN.RoliRthmuumBI6bKRhDpcCKdWg66N0e
 DeY_QYyVsVRQaSqMdf368aQ5BUFQ6yyKSvP5hqTJH0yyhpuuSabBK_XuB1BcjaTaukZvnH.9WQCc
 CeyTEeEpbMnZtnH2TnGn02Tz9MqCrC9e.kxL5_8.uwQnGNmErI0VtQ3ANVCJZI8hyPCtc78cNxzD
 tj878Lmgx0GzAgyRtUMMgoCSeIZxrMZ1.ixocuJ5.aeoqcSjVjb1hBSVtHOzgh335RrJfsTdCzrx
 c723DI1HlJVT9MvOiNutg_WNtSTnUGrZpOy5I2qCl49bqdSIU4B7lI22mdFXVCc8PICV4rH3HoJj
 8Ns4X2inmkA0Z7wisp3gTn1NwQhpl9BQ._qoWnnlJb5FNfB0igHzQRWWWKNS1asj_Gd22JPiiz9L
 lIM8s52seslHycw6xokKPkCYIk3rC3t8FHvVUHv98DenoKQSUM8DKC.gtgSR.tTIS6UJF1JNhgXp
 qn1KAs0f4tNq0HI3C8mSqH.w0t0z66bAVwwTL3g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2020 00:09:21 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID edb9b4c4f175c87ac7707af56e977ef8;
          Wed, 11 Nov 2020 23:57:17 +0000 (UTC)
To:     "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        smack-announce@lists.01.org
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Smack kernel test suite
Message-ID: <471fb2bc-646d-a7a9-6fd2-3e4fba2a6b8a@schaufler-ca.com>
Date:   Wed, 11 Nov 2020 15:57:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <471fb2bc-646d-a7a9-6fd2-3e4fba2a6b8a.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It is long overdue, but I have finally created a Smack kernel test suite.=

The test suite includes about 100 simple tests. You can find it on github=
:

	https://github.com/smack-team/smack-testsuite.git



