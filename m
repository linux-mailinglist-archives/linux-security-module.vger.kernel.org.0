Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617251E0B0
	for <lists+linux-security-module@lfdr.de>; Fri,  6 May 2022 23:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349045AbiEFVJ4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 May 2022 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444137AbiEFVJy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 17:09:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4776EB07
        for <linux-security-module@vger.kernel.org>; Fri,  6 May 2022 14:06:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x23so7209335pff.9
        for <linux-security-module@vger.kernel.org>; Fri, 06 May 2022 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=PJTSNrpddi80Uz+Djs36Qc3mS8ZiBvq5TFfPDbaTkeEqvy3oDU4TN+rHEujQKuYIB8
         66SJV+vCiU9JRMXAO6lXaCOhiep9V0F7nNNMXkIDz3FzZxSA70ovwIMDInjPY9uDrXOM
         NYS3DLo2POJ2mh3kn2MymGrl3NlysMU5gvicF23utfz33EjSp/U0UXk+FqXEhj3d+bFM
         t7YM//oPotb/instdcx8nASyEqF0bHTOoykz2s+P5oIJS5Hu6Q2U4bN7V8Pw/xIC/97F
         JtdB53LaN5PM6ZcpfTf+vQTaN33wnrGXHsqlm6G5Y9lYrEqzwo+Huqg7f6zIUYiK2m4d
         216g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=2S9ZkHzMdbvquXBidp0D1yesLOtQel4k82/mBnPby6VTTOSBHtqcZd0xY4WkEJZgO8
         euAUP+bHRakzWThAV3YyDUfUcdZaTQOrL4O7Qb6Mp8UALssM69AKiK/GtZKtqrB0rbRA
         0c6o9sZeK1Tc6ki3ompYsnoJV43guRHUHjqBV3ifVrDgi9VyjVV2iPQTuuOoXkz1odL1
         8zbq4Y4WVBXPk7Aol9RzodcRy6ZtAjTFF/Os7HqfqsovSxnSY+qszVibqE7QMuHz/2fy
         ZSkSukM7BK7rq83a2Fli1p/iTwvVVDCIw8C6DZhXNdGE/dzx9dYfdFR9SwbvuZQyu7w1
         NoKg==
X-Gm-Message-State: AOAM533C81s0ZFu0sD1BKgBfOVR03EvxwXzdYudhtBp99Clgi821GzZv
        DdCJbCOcifyVvaJIjI5k9tkBdxErMctMIPQDvw==
X-Google-Smtp-Source: ABdhPJwLkAxvukvlfPdsSQWSqa7XGjVmBCKJM6w/IhcfybrGaBU2OYUf/5lBzVaJf1STq54J3YkVSIgFkFEduS4ZmDQ=
X-Received: by 2002:a63:87c3:0:b0:3aa:fc1b:3459 with SMTP id
 i186-20020a6387c3000000b003aafc1b3459mr4218528pge.210.1651871170520; Fri, 06
 May 2022 14:06:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:06:09 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:06:09 +0000
Message-ID: <CAD_xG_q02-pCaOj2MFVgNGOykABOSsgyAVjZGtaK5-+EAZubYg@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:441 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
