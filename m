Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A431B620EB4
	for <lists+linux-security-module@lfdr.de>; Tue,  8 Nov 2022 12:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiKHLV4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 8 Nov 2022 06:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiKHLVr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Nov 2022 06:21:47 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001524C240
        for <linux-security-module@vger.kernel.org>; Tue,  8 Nov 2022 03:21:43 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-370547b8ca0so131024577b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 08 Nov 2022 03:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=TH6ODfpzgWQOI6wK8En85vWReym/6MZKLaa27NkF6wKNmePYkJDD4IOjEcA55zYEoa
         HHB0a9gnxmJPipnjfbR/VTrTtbZP9JbC3khMivblt/XvUW8aBVIZyTmxKN/Qv0xNEpBV
         X05HHz+nqmiHXAfjfgiHxkx67gPkCb15hnBSl7YhnxRThqtJ0izawNEQRCBRgNr7/Vnw
         pgJhAFeW/Oo0lmTvp7FOO3mONf7oOkQPFxaPHBWSyR1yI88QGW2abJQWrY8AU74+txMd
         gKcxlEKpQy8Dh7cC+yRZRubj5o+X3LQDqSvIxldsnQinpZXNaqtta7vJkEyAVlZvCJO1
         TrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=lIQElDGwJfDlQtm+5KAzSGlV1foYC1mvgPbb4oZUjFUGdp6EiyfTXYaiH9ga/1eG5T
         jTzVP8krQ5FA8U1byX7DSP33Gp5RmexU1M9X35I9RarxqTuPXJD+rtGCJSeqO6berKpw
         Ls8zQ7+A7NZqflVajO7zl/kArr94/dCr3YDEdfhzYreCuKdIJMdcHtCHDJa77NtY91V3
         qRUOOJXhyggFFiDpTkDfHdT9s+G00W3WhYP1g9kCX1P7vyaBYBY/3vLcERvzdJ+5XMYO
         q4P49RRDWUfHKMtHeDTMHGKHXhq6ePlzfH21ktlKNXbvliiEcTLMKUVvzcU2rKZDVsHU
         DBLA==
X-Gm-Message-State: ACrzQf1gSC5cwHbWZTpymvOdvwHMpT7zchEqcd5yMRBv2k3ZTr6j2k6o
        YwEpPOwDm3Ds4RuxIpyuZLw+X5fqXGUYfiHJ/4w=
X-Google-Smtp-Source: AMsMyM73Po92pkBAuMw1lnuuxVsDEt6vWZsXPrYQ9yqzpQAFsXcQLr1QePow3gpIHUdrgggOwyqdpjF4eWyEAjgQlxQ=
X-Received: by 2002:a81:8644:0:b0:349:1126:97a4 with SMTP id
 w65-20020a818644000000b00349112697a4mr50326237ywf.333.1667906503158; Tue, 08
 Nov 2022 03:21:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a38a:b0:313:c983:1d7e with HTTP; Tue, 8 Nov 2022
 03:21:42 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik2@gmail.com>
Date:   Tue, 8 Nov 2022 03:21:42 -0800
Message-ID: <CAC9COZcaXufcjypwUNRcwAEKjKwxfz16pebG_pB5BL8dL_E_kA@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik2[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

-- 
Hi

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

If you are interested for more details.....

Sincerely,
Kairi Andrew
