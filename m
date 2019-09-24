Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7BBD1E6
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2019 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392061AbfIXSfb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 24 Sep 2019 14:35:31 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:45864 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392031AbfIXSfa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Sep 2019 14:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569350129; bh=chh31s1B9gFc9S3ra8SW50sADiv81UzRf7dhYmBJWq0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=byH/bGdRWX7DecdiUVNPrXUH6TpT/hVF9DPcfnIDfmZVGFC/wbz8pfv4+yDKhFB4bbY7LxF2Q7EqKniMDWlo5BEop4cInJxar3QW2UmIkmw9C7eXjxNFJP6EGq4SN2OZpUMKpNZCK8ON2XbYh2of7V4R21OF05c88kOEJcxHT0wDTooA4CsuZXfxex4BsA0aw6vj/kFw1et4A2SdO1irPZzdjG6CuScjXvpZgAzvUk5xY277hIFVqVA/1KK9/NRaZvIiFFEMmhQ0/jM4WV6Ow02wKYCoAh9xuHUyet0I23gOnawg0CIWcoE2CuP8vwUy1dnx17dmfoVe2IFsDhtngA==
X-YMail-OSG: I753CgMVM1k30I.tDZiTH.LVLPcNuCNNbXPG43uBHdcZczFVOgxL3knpwqm3YTN
 PNeLpk2QHO.yUsEi5sW7q5hkgagVNCyIpEr8IIJbp2N3iIc_VLwZwpdyvRVG8nZR4IZl2TBcFpFT
 GnauofxaCG4FObr_pfz5du30kvqrZtUhlPrK0fHXNdF5D6ArQMoElJok3k7Oc0guumyX.G9mdMLL
 ryzrOZxCrkiXj9PV7Z8Yaiob2JT11ln.PpABOhKdoooCzH8v9leUObSeRRPpZKpu8wNECEa5a0Zw
 mmvwG6YNSawQEd.m3hYS0kcvONGjoyIH_dd8Ic6MLSbqMU7w8JPMpbCFitf1loNrsx4BdAqR0Qfz
 PiQs3bO.LW3EI8CCs6EqAMlWcpkZEy3STJ3RK.CZXVIfre4AwRlKlE2Qfe.8YHyhDybu6O_AYKul
 Xk_2huJDlEigY7vAkyk.39mk2AeNM29zF1A4X42IC6fWilD8PpCs82M70TlC0pVGV98q_IpGaH17
 VLCwRIte7wjZfvkWjrOzHAgu8fgZQG35sjzQZsxfUtiD7n1i.Xfa0QBdxcI6j30e0v_P4NYaTTj3
 agJkP1YQIKmkMZyot931fS7DiHYH9ao9O3HpElgWgXNJziEJKNEj1Z7o_qCQejbcAu58n8QpcBRV
 hVTh9n6sDfhWmAWqNUDQuTIvZzrpAmrov7Pn3bahiJsLhyCcZn2EO6Aj9cukdiZA2B8M.0K0KQPO
 n2cWoWUltcSp4b29t9u3vVMl9EU2Sobi.bjUNx5hQxpOpkhm6t.v5mvM7J8yzoc0YsRB7J9Y9.ci
 mOWzQtuSPfjOKPauemwhX2pnp8u3n3zqz_V.W0d5Ans6cP48eOMGTy1ZHvhITjNLOUZXhf5yStH7
 UZNlLFkD7awiI1Y0ZfYipxBkqich0qozvkw626prbSbdexbMePEuKVOtPwUYazjmjdJGGUYETq.o
 ewfibPmhGTVHYTa6w9t2Sor3RgmtQjaiwKoWbcf_GEKDgaL41TTPIJ88deuIivXeKeIvyE_r2Vht
 GJOMRWrWZNOEccFWNmYLBfxzqD.BCBDwkvdiHIWhiDATO73fdnYCCeIDGJSfIUJscJQeUzAe6CBb
 yo6jbfld_vpaQjYFWGd9Ng29OqGcimHwSKV3SwIF5nPpZatA3i_gKYDTrS6YxeHBAjCpoCeok4SR
 5wotsbKyPk0Uiikw0KrVz0CUQb3Bj2daIQ7TIcpdVi9P0o21gXV7VAIetFGejLHGdEhybHLoIeCD
 3IkKDPc8uDs5y7XKre6hj1uAVM7taIgs.A7X4GYJbMQKCD7kpltnQzXXJe_lz5z6Hl320RRIQw4Z
 DDNVZy1JmKkx5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 24 Sep 2019 18:35:29 +0000
Received: by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8d33e6df3fbe0a82e79e57bcb042ea5e;
          Tue, 24 Sep 2019 18:35:26 +0000 (UTC)
Subject: Re: Do you plan to rebase next-general any time soon?
To:     James Morris <jmorris@namei.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <260cc0b6-f19e-36f7-b8e4-dad0dd0c5ded@schaufler-ca.com>
 <alpine.LRH.2.21.1909250355190.1810@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e8854a65-28c7-3137-b7bc-eec593b1073d@schaufler-ca.com>
Date:   Tue, 24 Sep 2019 11:35:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1909250355190.1810@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/24/2019 10:56 AM, James Morris wrote:
> On Tue, 24 Sep 2019, Casey Schaufler wrote:
>
>> Hi James. Do you have any plans to rebase next-general? I'm
>> working on the next revision of the stacking, and want to be
>> prepared for whichever way you decide to go. Thanks.
> Not unless there's a need to.

OK, thanks.

> I'd probably create a new branch (next-stacking) from v5.4 for this work.

OK, that ought to work.

