Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5418784E4B
	for <lists+linux-security-module@lfdr.de>; Wed, 23 Aug 2023 03:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjHWBjQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 22 Aug 2023 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBjQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Aug 2023 21:39:16 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:39:14 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79981E46
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 18:39:14 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-35-64e54ad38729
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 9F.CA.10987.3DA45E46; Wed, 23 Aug 2023 04:54:59 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=UYcdebJtwrn4zCM2qj60cDtsgKvT6Fik+QUGbfZdDFzv1KWZqKaEsbcmvTujZR2Gn
          bz9ggIYr056VFlHaAEv9rrSyguAWJF5Ba33NFXDH8NPZBqtm54ZVtSDhZyi695i5w
          ceFYhbIaA06f6z6r8JkbC/73fV7vHQYC+PzRDnYhc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=j+qtB2Aqe0ADgVemYDfZu1fnqgksLUgegox4LXbhSerW1T5qiy4Hy21S5LDvp/WH9
          YUdGa92rlbEYxX8d4cBejCP3Cd3yat2Gvo5SDXHT9/9vYaefusnK9FRg2V3qiV0zS
          wT+xHR2lG8Wn058MQ5JLy6hAMwc5afriHDUmB7Q1w=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <9F.CA.10987.3DA45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-security-module@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:21 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW/ey19MUg8n7lC0+9Dxic2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCReHqyg7WLkYtDSGAP
        k8TqeRuYQBwWgdXMEndX/2CHcB4yS+z48Y4dpEVIoJlR4tARTRCbV8Ba4vGaX2CjmAX0JG5M
        ncIGEReUODnzCQtEXFti2cLXzF2MHEC2msTXrhKQsLCAmMSnacvARooIaEocm74erJVNQF9i
        xddmRhCbRUBVYsbSSVBrpSQ2XlnPNoGRfxaSbbOQbJuFZNsshG0LGFlWMUoUV+YmAkMt2UQv
        OT+3OLGkWC8vtUSvIHsTIzAMT9doyu1gXHop8RCjAAejEg/vz3VPUoRYE8uAug4xSnAwK4nw
        Sn9/mCLEm5JYWZValB9fVJqTWnyIUZqDRUmc11boWbKQQHpiSWp2ampBahFMlomDU6qBca6Z
        b3z3kfQFR5LndMRuq5bvuqzTar7iV+OEjyoTL3DyPy+/Gfua9fEN8V0818++k2l9X+b47u6S
        mz4fNKv97k2veptV47P5ZPy/SianC7K7e0JDJ6wID3sbduFwY7n3vyczPk2dfTlJsf9dp69i
        00rZG29UV2yM11my81Wra13FtLN7pbRu5ymxFGckGmoxFxUnAgDcXAX7PwIAAA==
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

