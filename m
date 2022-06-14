Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B154AEC3
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jun 2022 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiFNKtK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Jun 2022 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355920AbiFNKso (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jun 2022 06:48:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6D4924F
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 03:48:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w2so14467780ybi.7
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=qby759UAPKtxT8eJG66PBY7Z1k1fKw6qzVykk1h1XH1vBVQJ+GKetH3yAwgfqOzOG/
         iIyY/iiTcGmiB+vEfXiUkwuKy3eoiywuLFwE1tySRmTi3R7zO/D4K/HNblgUzSQxhw7/
         WbgobjHLB//3bVsviP+2vrYCa9kfQVahrDNZoEKLmBN9H98MqnThfHXA9qvbVn5w5q9x
         m6gkwoseqh8Mn+WcgxD7qoYw6LbNOcauyxeaPltoUWqry2UhIgfhHkHAkyEAAOuR8Ikq
         cN8HbVU07sFGwGfoonU9+ePKb/6JEp+lnBIF1PlpynU0GG+QFKkx69rkm7c5x5hNxvGO
         4aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=tXxaJwz4y+/7T5vbLY5zgJqLPGdso7LWQFdQl9aq4YQFv7kFfBWfudHrL7F1EEfkUn
         bPCOJoPtXiLOa3ePbwRPjaOI3t/gkmhMTjy81xHO7gu6b2oIg1IBV6UXXF0pmYUopWLA
         gSMn97LuIDArGi7xubc+uaNVPcaV9p4Grr1MlapQ1bAW9HJNY7DiKVsZpfR9WgGE2Qdz
         pipbgX2dHEv/0xeyfGJD08Uh/u010z0ap16pcuBuZ/zRzbCIcOLdB3uEc8YuzVIEmChs
         Newpw1plQKUEIbAo/hFhFRQWPsEUxF5+Ssx+TQHxPwYQvpVugaAlXAuDZmQML3N+PwJ1
         kV4w==
X-Gm-Message-State: AJIora+ql9kGdlc5vzYv/a9JL18ogWDjK4LfTJhtOXV5qzxkQtse4D7i
        hTwh8U4PumHD+cfaGF/jAAT2ms+2/+HuB3cREZU=
X-Google-Smtp-Source: AGRyM1tcmHe0yjDtD3RvkPE4/FaCCrWHxr8Xzq/1JoVkObGn0WCnySrPBO4LFx0eFtSYL8Kyz6DdoTOYcuSS5uocSuU=
X-Received: by 2002:a25:b212:0:b0:65c:e077:7ed3 with SMTP id
 i18-20020a25b212000000b0065ce0777ed3mr4506919ybj.264.1655203721158; Tue, 14
 Jun 2022 03:48:41 -0700 (PDT)
MIME-Version: 1.0
Sender: ifeanyiomaka1@gmail.com
Received: by 2002:a05:7010:50cd:b0:2d7:29e5:3e4f with HTTP; Tue, 14 Jun 2022
 03:48:40 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Tue, 14 Jun 2022 10:48:40 +0000
X-Google-Sender-Auth: EA4ehhyLlRbhdmRUMAbuiv9eYTM
Message-ID: <CAO-KV1-bsQH=_SCZypksQGsvXLp5ij+B1FKJ733=MnpurCRfEw@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b32 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6370]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ifeanyiomaka1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ifeanyiomaka1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley. Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Howley. Mckenna.
