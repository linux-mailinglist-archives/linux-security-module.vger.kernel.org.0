Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091E4C82A8
	for <lists+linux-security-module@lfdr.de>; Tue,  1 Mar 2022 05:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiCAExO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 28 Feb 2022 23:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiCAExN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Feb 2022 23:53:13 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D83C3F
        for <linux-security-module@vger.kernel.org>; Mon, 28 Feb 2022 20:52:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so602185wmj.0
        for <linux-security-module@vger.kernel.org>; Mon, 28 Feb 2022 20:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=wDqO81NhFUy4AUfl9g/OaMtN+AfPRGAGgd64KYk/mg0=;
        b=nx8lsyKODH2rTON1dLVPJQ6oM0jTTc/SWIjX5jgNSe4Pzt3TLbJg4a4YxDDfchUrLZ
         1mdLH5Xy8UPCT0x5Nc7wzpolMpY1XsvxmifN5fKVbawHt05TTNyyquznRoKJF57h7WpY
         NEfznuqEpvG6CWa7GXaJWHaucPqcis/XHDHgvyjfQAc5VhbijitR0qUrS3/N3AJiEcum
         pTs6ixwVOtCuWufbX8o683Y2lMz8vpF6tgjuTbjVWUefqU2SZaXKrbp57+fE5YSJupaO
         XDk0/jNDtQi8uGiWvb/9wD5qLqoI9nElISKIPoglWY5fH/H3WKI/Q18zaUpbAjXVi3x7
         2SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=wDqO81NhFUy4AUfl9g/OaMtN+AfPRGAGgd64KYk/mg0=;
        b=NzTEQ8ZxX6IQiVNOHIWmBsP7AWeYK68a+4rkW1ATwHsJzlKfkg467VvR+SGOowFlya
         tQN8AkSwzwaj6r4Zw/WBEpRyDGVdGTgCh1zYImrXYxJ3zn2FdHBw/qEdOzGjTH6/Fjli
         /slDajRLLF/gYX8mkbboxuWP82Pvxl8I7z036dQzPwykdF52O5rsWJO3Auw6Xg6usmsm
         Czc8MdMaLOGL58f4pT5xX1OY9hx/bN7f4oSunNwiBhgSdR8BdsjikmIatevn+L/XZcPn
         fsUt9qXrXPxKkQJsR1l+mxbZ+JX3maTZV9gRgt/oMqMfoZq6sXxKBeGNUCH79ZWOXlze
         3Etg==
X-Gm-Message-State: AOAM5335HK/ptVPvF+QNooawsCTuHrTXx4nvQjB/I926Rlq2t0bzg3ho
        VUnBjQTIKSkdym6i5TpP9g==
X-Google-Smtp-Source: ABdhPJyADmCpJtZ+yilwXQA5OEkYkN4RqUFXetKaJcHcdy/y5tlKLxn7v9OohTsSzubVGpjqA3+lfg==
X-Received: by 2002:a1c:ed18:0:b0:37e:7a1d:a507 with SMTP id l24-20020a1ced18000000b0037e7a1da507mr15575730wmh.187.1646110346650;
        Mon, 28 Feb 2022 20:52:26 -0800 (PST)
Received: from DESKTOP-26CLNVD.localdomain ([105.112.51.151])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm1508772wmq.40.2022.02.28.20.52.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 28 Feb 2022 20:52:25 -0800 (PST)
Message-ID: <621da689.1c69fb81.1e2e2.5b2d@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <bashiruusmnan205@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler  <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <info@gmail.com>
Date:   Mon, 28 Feb 2022 20:52:17 -0800
Reply-To: mariaelisabethschaeffler88@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich lesen

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email:mariaelisabethschaeffler88@gmail.com

