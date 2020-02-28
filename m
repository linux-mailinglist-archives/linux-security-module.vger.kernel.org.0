Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6065F172E71
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Feb 2020 02:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgB1Bw0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Feb 2020 20:52:26 -0500
Received: from sonic308-3.consmr.mail.bf2.yahoo.com ([74.6.130.42]:45189 "EHLO
        sonic308-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbgB1Bw0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Feb 2020 20:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582854744; bh=5G2Xm0QSWKBGGZcml8rVsjkCJF9JjLl6j5seXrKrOew=; h=Date:From:Reply-To:Subject:References:From:Subject; b=AJr/GGM+j+U4wpsmp3JmNK1cWOjbKoao9Rf3b0FiXAataY6iAXPWk/701+VWSQW084ElRUSl0Sn39V9hl3m/L8pbQAVeSzuFBY0LO4zQSw6/NKtidpF6Gq5hjMZRdht1yAjWeD1llOlsD03SPcSy3H5MmI3vf0NEW1jTnSd8LZcQgKOwE9DrxEoEpPOVvYxLP29zTvpFjjOPndD8mSzyZRtJBm1ekM7mEbsSv+zj/bBnhMr3YcX3n7n+/RB+ItZWPrfeP4om1s4SibGDCUXQ2tPBgAYAHJuXrEk/gsB3XKtcfeL/3XKyGIZNRRiUeFikJUV0+HZL/V7NDSI+gw+qWg==
X-YMail-OSG: i2rou84VM1nAxI0RAU5ugkjdzadhTCAZZtteq0bZDsdElC0q9YvyOINrjUnf5_j
 J6O2a9yRWI7YgkYrup1U5MQLNHRdj3U.nYHHkyPxBQ3wfFjBf1awRPVP8R.J7ASpQXTqYEMCKv.g
 OoVAESh38AxyyN1FfXnjDc0AroDpY9soKLukzegDg6FxwEsKnwHOFc9gQEDW_CETzOIBuSiQPLRb
 jrCvrtsJP0keDL1SqAmvwJV7yZjvxsczNoDhc05zjcn.bxqHCx4tZuNRq2y1MdvvZ22uADOI7J8O
 .e.P.eJZh4.TnMp8KVSbpM12NuJjk0mK84MV8LtNXm5BCV6sUEMpvAmAEI84SdgHF0UCfrC5lCyX
 l1bCq04XLcJC9rin4FOSu9qZ66ro11Ewxkoi_0qJFJsKxuUng6swZa8JmGodrU2ET0jkC1SM6qAe
 rYGxmdUsxFkfky7l8_giiVkIG3ArgNgO_ZGOPKGmHfKOzzn.V1SGf3SfDKhAmDx8KfycZi9BvhZv
 nKzXbnQPsZRrWpzVepdaAigdzYH7pK2aR4sHLhYtHeBbhb2hAhs42ypQP6KjJOIeCYN1qsG3nhab
 V_U3JaZ8jN8thZsxAFF_vWhbagyaVzSGlXJJ2hNRrwANpv1._nEc3ikFXQN_1UbYhY63K_gxLr7u
 iwWHC.aSI2rHAVJ8SvQFDGeRlJIUqHrI7QTO12lCn6QlHiat05VlAQ2SjgclRcN4yW6Ev7QsHxen
 hueEthZg84CnU9nQyYYzCbF8wNKT_if48bqG6ZQidNd8opV_fU1eeijUsEnvy1tEgteJRCT4CX2_
 .F4CiuoYmjlqelKLOtY.67bqfAz0vKNsNF_qxW4QW0tu3aCokgpkCSgRPxDWWGgtZdz97LeMvbmh
 P3fnF44GHZOtzvouY8fgffT1xYAPDtVceCz7RhyxdtiFrjtyTnU.ouSuMEwBsPKaceBAP2oHA0ql
 JCw4DZM5vU4q.3qAcypETQZfQKxKgTnX3CIiFwujF0jwMzKLG0FARrn4jgCkU6pfMheZL_XEdoVl
 0CM9nSGpxLxAIqRM6u68XdWHDKllgtfnzlBW8t5d1DO0OFPxkBSHz6cRHVe5MSFOrbPI5Hq.B767
 x_U9TP4KDpNnfi5lf4yKhOIM5p1WS0VrbuWYHVane3QxxRfcF6aaK5xEuHkZjw5CztRIxr9szLKm
 viGVUUvOT6U2pCNNo5.ZDCJblNixhfgavcN3iqrhV10zFVSVjbcPg.DNbZQeB9JvlCuKZHokQtnr
 1bFaKmV3Zd3pPwprANgnxZjAq87pax4DRqLrEwUdFLRy0HLGPvG2Xpa6LBSbZEeQOZM4DUWyYSNg
 2qbAPy1dotUlvk8CeYW3HLCD91IS3kIA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 28 Feb 2020 01:52:24 +0000
Date:   Fri, 28 Feb 2020 01:52:24 +0000 (UTC)
From:   "MRS AMINA KADI." <mrsamina.kadi12345@gmail.com>
Reply-To: mrsamina.kadi33@gmail.com
Message-ID: <1060441909.1224054.1582854744331@mail.yahoo.com>
Subject:  COMPLEMENT OF THE DAY TO YOU DEAR FRIEND.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1060441909.1224054.1582854744331.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>









COMPLEMENT OF THE DAY TO YOU DEAR FRIEND.

 I am MRS AMINA KADI. i want your assisstant to transfer the sum of 5.5USD into your account, I will give you more details when i hear positive responesd from you,

 Please contact me with your below information to proceed for more details awaitin your positive response.

1::Your full name::
2::Your home address::
3::Current occupation::
4::Age::
5::Your Country::
6::Your current telephone number/mobile phone

 contact me with this my private emails I.D (mrsamina.kadi33@gmail.com)

From

MRS AMINA KADI.
