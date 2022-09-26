Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4405EAF4A
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Sep 2022 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIZSK6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Sep 2022 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIZSK3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 14:10:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D265801
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 10:56:37 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3454b0b1b6dso76976197b3.4
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=U9hwiLfYludCtXf+u0nsabYBP7stdr7yW99wIfiKPEhqMHuuQX6od3d2kHzQbh22li
         U/zTa1UeDa99ukJG6xtOrZn0LBmGQXcx5OW/YCV9ONG7IC0HDs24sEhnFeKotoq2a0mE
         OyMgLs0LpFpwtmy8snEODDWoFj9tCQkCc+YtGWJzTA6qetH5qBICh+sDbGFahSo7jzDB
         T4xdvWGGdej4b7MLGPvCIhDgZDk5+CsajAyU9jKjdUUSAigMdAqtODPI8KwwhJbr7+7U
         3parV/TeNWqYg5AxN+caSJ0MAv04AKY4P/Rsi7JvXzlChyB2mYdJqzGKo3aZ5yvTETvs
         yA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=iH0FAQJC+Q56uMdMlKMxp5dzaNEXqi7lAqzHpQS0OynMOnIIbTY+T8I10Bp12EvHuU
         /YbqKBtxh4fOCxoRygIuK+fBnp7EY6FFuN64ko4ZMAyWjSXgT+fiHvAeiS25CAgq2pF6
         RzpYdeY7vg4VY1tVQrpAydP0HgXujJgbDXelkTojvf2tJ778+5FOwzI8XYQE9f3DdWX7
         qqICW23oD8C4hM973Taz9xxLMHXmx7X6S172d3TwGdcSphfU1vDIC52dvcAH4mHBwkUA
         DY8BiHNiEvuLPbMO7oXCO4KoFaAYE1oFp8wmrj+ivYAhKdWw2x+VCO82fu+6zdJAg3C3
         82Ug==
X-Gm-Message-State: ACrzQf3u7aoAugq4hmaAD0nEEclpd4ExfVBeTkYuvqqnUuhbSX53wTGA
        /NizIc0EmfyCAp+82L7zlMRHxLu4oFTz1n8FKbo=
X-Google-Smtp-Source: AMsMyM4DtELNq3UfC6ogqw6JJnpKyAYcDqudvgTz/Cf2F94+yabovEqZ4sg5zE+TIZdy1rLTqMtQ9t3eTSSycA0RlkI=
X-Received: by 2002:a81:7955:0:b0:349:e6a4:7960 with SMTP id
 u82-20020a817955000000b00349e6a47960mr22130363ywc.74.1664214992399; Mon, 26
 Sep 2022 10:56:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7150:0:0:0:0 with HTTP; Mon, 26 Sep 2022 10:56:31
 -0700 (PDT)
Reply-To: pointerscott009@gmail.com
From:   Abdulkareem Ademola <adeomoade123g@gmail.com>
Date:   Mon, 26 Sep 2022 18:56:31 +0100
Message-ID: <CALzsaxtqUL3ixWqHqjkdPSYn1rM2gkh46kq-VCD+Grzcb7UU=w@mail.gmail.com>
Subject: =?UTF-8?Q?Bussines_offer_Gesch=C3=A4ftsangebot=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8818]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [pointerscott009[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adeomoade123g[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--=20

Hello, Do you have a projects that need urgent loan??
Granting out loans today in 10,000 / 500 Million to Interested
Investors, Companies & Private Individuals.
Revert back if you interested.


Hallo, haben Sie Projekte, die dringend einen Kredit ben=C3=B6tigen?
Vergeben Sie heute Kredite in H=C3=B6he von 10.000 / 500 Millionen an
interessierte Investoren, Unternehmen und Privatpersonen.
Kommen Sie zur=C3=BCck, wenn Sie interessiert sind.
