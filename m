Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8E6B601A
	for <lists+linux-security-module@lfdr.de>; Sat, 11 Mar 2023 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCKTRQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 11 Mar 2023 14:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCKTRP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 Mar 2023 14:17:15 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB4C4B839
        for <linux-security-module@vger.kernel.org>; Sat, 11 Mar 2023 11:17:14 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id x14so7632488vso.9
        for <linux-security-module@vger.kernel.org>; Sat, 11 Mar 2023 11:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678562233;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nPpnsBwc7bdIYGOIsyVCPrJFmoPHvVCCNjWwFsbHN636s+ykUgRBO/W+hoMlXjO0YW
         OWM69RKfeItfRoAIRECq/7AuMNxa2baO4SJqpwfh7QafvTEVP21/4hnsG2cy3iFC/0WS
         gvKjo/2fyBvg4u617340/0Vy3t9b1rKfk/DxPC0u+TLpLegxNWTbYnR5L28T2sBnmmSD
         hEFFZ7kanld4QSXG46R9kcBKUo1pEZkALU7w+QSBRJZSrGmIWlkGEBlLRLJm1y1xCrZV
         VsW/ZDnJM2bapsvl6r2d9ZqzNOKXBp/vBm0RN+tWdcu1QgBtuweONVE5GGproX+zY3FL
         oT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678562233;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=jOWhcmeOroSv3zhZL2Basw968XFqwsiPFxkoplguMsuCcd2c666vlXCRKCURpKBJi+
         7A6rrSR5An6HRqN6RrrNDPBxD2yPGjXKx8bQ778ETgLH6xVz4mwOJNWs33A4GeFi1KBA
         4Scte9SdIgmRlRJT9AARtxeR0cA7bjV5fY9ImsSPgUFaHW+NBilaFOwhX3qjpbhQllyQ
         Nl2/CQnfx/F3J0ANUYxwdCEzOATv3SNA5C8M3U/W+aUMwrPlul3pYi55+UGg46s22Njw
         BNwle3pcu/Wj9NL4vW40JTg6fKQgmVLpkiBm893HRTi02Wqwao7NY7QBGP6lwkLgwRKx
         UwaQ==
X-Gm-Message-State: AO0yUKWNphYzsZqfK/qffY4jFOqNiNAJfuQrYzOodrawemE8XviIM72C
        vuVsg4MZawdLhIIzXh3ZKknrUqHTAo8t1KQil4E=
X-Google-Smtp-Source: AK7set+tpJ3tJ9hcaO+apj22JuQwBcEccHzQF2SNR2IxewxR73oyHMev8KqxW1XKBEvuhkzMIN12MJQT1CWNaWDjRFs=
X-Received: by 2002:a05:6102:237a:b0:412:d18:c718 with SMTP id
 o26-20020a056102237a00b004120d18c718mr18880956vsa.3.1678562233568; Sat, 11
 Mar 2023 11:17:13 -0800 (PST)
MIME-Version: 1.0
Reply-To: katefranzoni@gmail.com
Sender: florentkangnidjissif@gmail.com
Received: by 2002:a59:ca43:0:b0:3aa:7a40:ddea with HTTP; Sat, 11 Mar 2023
 11:17:13 -0800 (PST)
From:   Kate Franzoni <katefranzoni@gmail.com>
Date:   Sat, 11 Mar 2023 19:17:13 +0000
X-Google-Sender-Auth: DOJwn1WVw0yu2pfbXgxQ_CF1q0k
Message-ID: <CAEavVTwVvpx8TeNBq75uUymMV_dn8Z0FM8XOW08spxzqiN9=yg@mail.gmail.com>
Subject: Hello, I am Kate Franzoni, from Syria. Nice meeting someone like you.
 Thanks for accepting my request
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e36 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [florentkangnidjissif[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


