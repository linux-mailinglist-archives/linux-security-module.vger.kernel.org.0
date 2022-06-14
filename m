Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CC54B056
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jun 2022 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356766AbiFNMOo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Jun 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357006AbiFNMOV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jun 2022 08:14:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CBC34BB2
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 05:14:14 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id s20-20020a056830439400b0060c3e43b548so6420085otv.7
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lBFrwc11MgcaK75qf3EwNhKoIfwLYz4Dn7scEjO7Hwc=;
        b=UNA00ExpSe/IYk9qRpK3nhNY3MQGhIZVH9b+TBjq+LdlUjXIh78z6gPdY8GF0sQHK1
         HJ2n3gfPpUPhyyacfGQvRyEpF1QlynrQ30w+G5Aew5oVgyNdOMVYVhySdHNUBZObva2y
         PuLir0DHRxYshYjhyycNkTLQ7VsAQLmTK6m5EVJfcKtgRbmxa7D08ugJk7y5pLRJ/ze1
         6cL1+ieOt2sNltOPHDSKZebgxow79UdI2TUNij2cNTn50jsq9VR126vHNmWni88LExVM
         7xKsxa1nHQ7JrwK4VAXG7j0wCn6FqCQrLI4ANDOm8760jdm8KbeqIvWnFua/uGvpfZQ4
         nejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lBFrwc11MgcaK75qf3EwNhKoIfwLYz4Dn7scEjO7Hwc=;
        b=WbjaX5Mcni0qky9otEXEwEUMs6xgQptrE66+C9t1qL/X9stBX+IpluxeD/+4O3f0UG
         O7C3brPTtUHgAwc9ab6a98F/ZcSz6//OtkqbiPyWh6KVOj4autrj/ghS6FBFDjuXwPd0
         4GXde9e+Fsl5t2Tho3/IHfEyFtfaKFWifRA82f1Z0e9flj6bcT79D7NsDQ5hqntByePm
         ydhQgx7wHupVX+6r7lBltzX2ACebxYADIW9yLszffpGmwFA0loWts8Gb7NiwxKUV4Def
         cFEh5P59MUMiifBF49lXZRDWn+8WqCCnRB3iJ+PAy0pt19j8jrtfzJwYL42C4W0IK1TS
         iAjQ==
X-Gm-Message-State: AOAM530bMrKx1U0UKO2NH6lthX8vKAcfMTSzHGNSK7m/zdqmfpK+raEA
        6D1a1NamLusI7fjMFsZnz802OAr2ngNxcmA363s=
X-Google-Smtp-Source: ABdhPJxH036Sb3549Y0f3hc7Zhwns93SCbnuybCuqmcROW8sIBDtc8O0vPfU6QLql+6epoXLTxfkWaoTwfvvDQjMptA=
X-Received: by 2002:a05:6830:1691:b0:60c:1eb1:6ddf with SMTP id
 k17-20020a056830169100b0060c1eb16ddfmr1906144otr.205.1655208853785; Tue, 14
 Jun 2022 05:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:c46:0:b0:42d:ab20:ed24 with HTTP; Tue, 14 Jun 2022
 05:14:13 -0700 (PDT)
From:   Daniel Affum <danielaffum05@gmail.com>
Date:   Tue, 14 Jun 2022 15:14:13 +0300
Message-ID: <CAPkju_PQmptLCUNLrFjDqn4sN-xwFQ9XOg5Cv+KN_pd6V1aXpA@mail.gmail.com>
Subject: Confirm Receipt
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Dear,

I am Daniel Affum a retired civil servant i have a  business to
discuss with you from the Eastern part of Africa aimed at agreed
percentage upon your acceptance of my hand in business and friendship.
Kindly respond to me if you are interested to partner with me for an
update.Very important.

Yours Sincerely,
Daniel Affum.
Reply to:danielaffum005@yahoo.com
