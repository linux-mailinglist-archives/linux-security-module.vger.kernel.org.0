Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA35B06C5
	for <lists+linux-security-module@lfdr.de>; Wed,  7 Sep 2022 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIGOcL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Sep 2022 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiIGOb5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Sep 2022 10:31:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF16FA0F
        for <linux-security-module@vger.kernel.org>; Wed,  7 Sep 2022 07:31:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id r17so3421124ejy.9
        for <linux-security-module@vger.kernel.org>; Wed, 07 Sep 2022 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=hlX5LG70Pfi5xUfXCm2C7WvkXcJVP5UakJZVNodPOy7vNkSXQuxkM6JMnL0NkwpmEx
         GApIDchppryVktOBo5G41BqVss7NVeWmLRXcOx2bAZqQ+LAYFz8ePbLc684sFXT4Nmqj
         OcoPmJYuvMlwncvSBL0BFnkvuWLyKibj/n8A5QS+qmy30Nhg7xyf0NkI/q67juR/h0tY
         bD/nOML45bK21IZjrLP4cVfkyGYdsdvh6OJ7KPKPWGwDpi4WDdxiFiQ5bptV3cHn11YY
         R2/ccByiK1oIAZVOw3mE9dymIO7CzllUwLBF2JbmBffIhO2NpTaaNqhGzBB+XMxejIE1
         VDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=r0xqA6oAnuixxwFAFsZ/mkP/1c/FPD3RFNo/WEt2/iARUbJxwjexLIWo42VxhrPM7+
         5snnLFCQyLnokiROniSyX2y15HdqlFgyiLF874WsPKHPynRk2VdxkkdFO4BKI8lWPUV1
         sbzIqe9V4we2RbnmdSXemhfaNfajFlV1JoohCemmJrGO85jB/+FyKlMIBEM5qG/cCnHd
         UR+REiZOwJqi2nquHd0I13dBGDVLXi6jxCANwpTTMQaBnfsM0oyLwllHmdHgjjem+GQ6
         LExNAzvQY7hQtqPZcsxhq4a5USiz5UfWRUtUYcFPZc5tbrlFJyJWBmnB8xfI1sknbvp7
         0MLQ==
X-Gm-Message-State: ACgBeo1zB7dg4A/8nSCrT9yfNgk20+hTZ3/lvuZ7Nhk27GVOHfmCXCh7
        dqQkVrkHWizlqMxYA9YuhoBrhGFSzs1LwhKwk10=
X-Google-Smtp-Source: AA6agR4pyZsB+xbbjgKGlrl2+RDjPAQ7wWCMdSGS3qWC1Sv629AIX++hkd3miN/bJlP1/yRRoX5bdHKo53e2l2Vr/Xc=
X-Received: by 2002:a17:906:38f:b0:742:1f68:7058 with SMTP id
 b15-20020a170906038f00b007421f687058mr2510502eja.743.1662561112231; Wed, 07
 Sep 2022 07:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3fc4:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 07:31:51 -0700 (PDT)
Reply-To: lumar.casey@outlook.com
From:   LUMAR CASEY <miriankushrat@gmail.com>
Date:   Wed, 7 Sep 2022 16:31:51 +0200
Message-ID: <CAO4StN23CjT73+kAZo3jW6NA7B_rVMGFz9vZYzq4Gs86AZgN6A@mail.gmail.com>
Subject: ATTENTION/PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5014]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [miriankushrat[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ATTENTION

BUSINESS PARTNER,

I AM LUMAR CASEY WORKING WITH AN INSURANCE FINANCIAL INSTITUTE, WITH
MY POSITION AND PRIVILEGES I WAS ABLE TO SOURCE OUT AN OVER DUE
PAYMENT OF 12.8 MILLION POUNDS THAT IS NOW SECURED WITH A SHIPPING
DIPLOMATIC OUTLET.

I AM SEEKING YOUR PARTNERSHIP TO RECEIVE THIS CONSIGNMENT AS AS MY
PARTNER TO INVEST THIS FUND INTO A PROSPEROUS INVESTMENT VENTURE IN
YOUR COUNTRY.

I AWAIT YOUR REPLY TO ENABLE US PROCEED WITH THIS BUSINESS PARTNERSHIP TOGETHER.

REGARDS,

LUMAR CASEY
