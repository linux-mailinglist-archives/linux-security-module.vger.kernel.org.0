Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4707119F920
	for <lists+linux-security-module@lfdr.de>; Mon,  6 Apr 2020 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgDFPqk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 6 Apr 2020 11:46:40 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:37147
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729014AbgDFPqk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Apr 2020 11:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586187998; bh=u9TuYQPVtRNgQ8g5I4yb48Qt6delhNncMIN462fqPug=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jW1KK0W0R2sfX/2XVOX/PN6QtGYVIQYeDTCNWDR1NwEF8E3ISCyz602ih7/akGCElFOBnLFbbN4VtDo3d/G7mWz0QR8hheHasbI3T9pA9GklJQ2BB+sAJoMGAe2f2cR0IV5oj5SMWQ6rkge1XOwlVuwU8ZD5qx0ecDAfF7yCSmc2disLhmkEGCcN9tv7uJ42VKF5zNO+UBwUhg6pdXaMRSptUp+nezMKiPQ4FgcI5qgQJZHjw0dMKjbyE5Sji9hZKEmJ1dAgMNqNz9E4ITjB1Jj3cNNs3D0N5avHJ2bJo0azE5EB9HQOXAUU5pguCsZxmZ39rFEMDjlQwU0avq6b6g==
X-YMail-OSG: tOTbmfkVM1krNBT0fueURHdVo3_1duNEfGi.UE4dJ7C0iHlBJrK4TOqpcEdRaU8
 h73v.J3uQneoRLV8SoRX1iSWmIf5t95ZrngE3yPtWt3vAQFlUX5lfc9ALnU.J1kVJHrx3G.cjs.I
 4HMag56Z2Jrt4Z4dmCC.JYo3pXLn7kK6ho6ZHXubT8OThP4a8SQ0DO3Zy8AaCXuJfYDMLq4RC5uy
 Qjgfsegw.B9JbWNp9rPWEL.t38SyvDUyjEi2XGebNQaUNVl_1fyQ5cIWk6aFMZeqetx3.tTSnG77
 Up.BswgGjWL0LvXrgLuvky4GWQtaMpEQ14gL7ZSuQVoE2io6_GC0r9xZRK.JIZxI0T4xESDK5nwp
 q3Goduq8P1EB6X8.aYDg8XliBEg9pziWOjQRlkiAnoEuXFmqCnXoX_O14bHdqCn4b8saOVVqWuE6
 DhhJNEfQeCZzQa2MTad3sQQzy_cULhAbOXc2E9aqktkkiHMOeJPJiRXZvjZP5THsKO6u7nrgxnLI
 1gdCzAC8oq5gt7kXT1cotdfpjuM7mbm5YUqY4TRNmN5WzBcX44UNcECqSmUG9r.5ckkMyzpVQgJp
 aFvhWK64qImKsrUhLZDj07KmsbeMTlC7H3gyPbJq.4JWIHWzTi.wRwmjK9.k29fsSxZ2dzvuHBs7
 sHGd9oAo0SdG7FRiNkpLQN4aBYwYAlh5e2SEQdkE_ceQvEMGZt4iVaTkQRLo6gCqaFL7MW_Om02E
 Rac0BbvZU9Xt_Oxb2EE.lOFEw.xc.U__XSFp7Zmhr8yqBChrNkfoYqutxEjNRl7UzhZV9iBRHKYi
 ptyswP2mN9ZOn4j7jg7eUNtpclQ9q.zsm3StcEtOlz4U9f4xqGr8DdbcP4OlXZHVFEqIGikhN2Rr
 bX6nDiooadhEK8oGXuvJywGwez3nn4ClSGaqK1bhJecyXlTSBAj5WNYcitdiJImVftEavpRWrKXC
 NIuBw7VRUY3Jx3sxZFMEVPeCGf62Z4KeRmrP31jXRAyHCg8lpXkz9ntspomvgfCXG0kWSvU4fxgJ
 NDJFSZ03ozhq3FExrcgkKAOjeYsfIPRO7WR2pY.B9vdBR7vdLRPk0RT4mZ7U9Hx5rvBLBmDHqoW7
 vuAJKDst8V9Z8scx4mMnT8Z0LlEPpDw74iL9xgYJua.OZRDQ1kF8_fc0GKZEIXe6gEpcIQI1K.m1
 JYlIYqt0jbyD4beZLXM2GCvFt9vN.IrmAxm1lxvTXiCTYSR3Bgs1fQso677GQMZ55kluwcoU2dOy
 Igjy9HfdaeEm2o86pUyIN1guKn4A_XQyA8C2TT5AiZpb9v8y8xYYdbRdrVp_CpT3k8IYOBtm..4X
 rx8qcXGL_W9fyk9V3ZJ5r9P5FXyUlw24bz3904w2xVS3jum8Myd5QtpT92DW6SPQs4oBdLMpbm_d
 4CDWZJ.z2lr.NtkFC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 15:46:38 +0000
Received: by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ea47b7214172e7452b1af6db9f20f223;
          Mon, 06 Apr 2020 15:46:33 +0000 (UTC)
Subject: =?UTF-8?Q?Re=3a_=5bSMACK=5d_Build-time_warning_from_Linux_5=2e6=2e2?=
 =?UTF-8?B?OiB1bnVzZWQgdmFyaWFibGUg4oCYc2lw4oCZ?=
To:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <lTqravVBK9-oBbja6fvn3DqA3lv42gF_wg4Q9fC0FhfG1DbinZb4oKl7JV_meJYykJtkvN2gXhy-bCAgIlRglRT2z-oQ6wFF6aPx2vo-ZAs=@protonmail.ch>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1261c28e-3de5-8122-d3db-fa78fb89e34a@schaufler-ca.com>
Date:   Mon, 6 Apr 2020 08:46:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <lTqravVBK9-oBbja6fvn3DqA3lv42gF_wg4Q9fC0FhfG1DbinZb4oKl7JV_meJYykJtkvN2gXhy-bCAgIlRglRT2z-oQ6wFF6aPx2vo-ZAs=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/6/2020 5:02 AM, Jordan Glover wrote:
> Hello, during build of Linux 5.6.2 (also happened on 5.5.x series)
> gcc (9.3) prints following warning:
>
> security/smack/smack_lsm.c: In function ‘smack_socket_connect’:
> security/smack/smack_lsm.c:2838:24: warning: unused variable ‘sip’ [-Wunused-variable]
>  2838 |   struct sockaddr_in6 *sip = (struct sockaddr_in6 *)sap;
>
> My kernel has set CONFIG_IPV6=n during build.

Thank you for reporting this.

>
> Jordan
>
>
>
>
>
