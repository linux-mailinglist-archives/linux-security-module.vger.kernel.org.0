Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DBD4ECA33
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Mar 2022 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349110AbiC3RAr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Mar 2022 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349117AbiC3RAq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Mar 2022 13:00:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69083E0FE
        for <linux-security-module@vger.kernel.org>; Wed, 30 Mar 2022 09:58:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c10so24369805ejs.13
        for <linux-security-module@vger.kernel.org>; Wed, 30 Mar 2022 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=tC9xiYjFteTOncjiaBTt8b1lonIMt5KBs2kzaARMTvg=;
        b=gKilfGZ/BW4ymBas9eTaslJMraxFS69x8emaggw5hq09SM6nYnv9h+AV/76n0VI0oV
         diIJ1dvJN+Iyfdp/NHmHmzUOK/AdR4GMzuzjkXkLM3ssOqJC0deW4IAX7imMiRryVMIN
         EuX3A6lcmpNH2R9sEPCFSjiWmFK/9V7Q4WBxUIAyqOa4e2UHy/OUW2A/kumVQAYtHwGF
         0LZevRFY4+Dp8P4U115YBFCZKlro1ppgzRYDJ2gmZr2v3KKtvvgsqWWX7Rgv+1B8d4i7
         BjEZvJ5KglcpLyachzbPFEWjCjXho5hmJ05TNYs3Bp+uE2j4sGUf6kvtIJ9p03RcNJd/
         S08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tC9xiYjFteTOncjiaBTt8b1lonIMt5KBs2kzaARMTvg=;
        b=VQ82BKtNhl1qdPKHsnJo1hPFwJXYg6BNVO2bW0FU5rH7SARdJfZBgk1F2DsCYceX8Z
         Z1GmYj2/6RnuXZWHQOQdZyd3eqDbGco81e//nJx5iAyV62tAJbnoooWlmEBOIzRQs1zW
         /itFTbWgAxMRlSodkPHRXtm8bVuNuetTD0gVMYYeshNKNIIL5pwGCIGDd9xPwfzUzR7U
         My0rm02ah1FfqV8RxbJ44S47hw5zW4O7wJLBbCRxzfeVEadr1pWzhoeHPAf98pamWfND
         4y2F0lOvNW8y7VPdHxIMRYmIVGC0Yh64zGMl3YnJFWb/6abYJr5QeqZzYm91iM8Nmeo0
         mlIw==
X-Gm-Message-State: AOAM532zJz1gOIbeDXo0cVC3eVy2CnwP8JNav5sNzgdpgvhxedbufGu6
        yQBnjRrl1NATv0vpYelc61XwLKQko1pxjT1p984=
X-Google-Smtp-Source: ABdhPJww1SXOxh8nP7o9HrnJ/L1MBAAibUfwnCN0DkBlbqocQ/BR/7lGbG0fiXP7I2EAmgZqSgcPOR/b/3gCtBN78cU=
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id
 ji13-20020a170907980d00b006d6f910513amr447634ejc.643.1648659537865; Wed, 30
 Mar 2022 09:58:57 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 17:58:53 +0100
Message-ID: <CAHpNFcNLTDRtiLZ4sSTzWpOtX_UgdNOZUowgfKoMrTbJN44V8A@mail.gmail.com>
Subject: (Security & Performance Profile : RS-PSPVita) +PSP ARM Features &
 Secure DMA : headers cpufeatures: Sync with the kernel sources https://lkml.org/lkml/2022/3/30/1060
To:     submissions@vialicensing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

(Security & Performance Profile : RS-PSPVita) +PSP ARM Features &
Secure DMA : headers cpufeatures: Sync with the kernel sources
https://lkml.org/lkml/2022/3/30/1060

So + Properties PSP & for simple reasons ARCH Basics By Creational A-Sym-metry

RS

On the subject of PSP processors : Arm features include NEON2!
Why not use this to our advantage? if safely potentiated! Every SiMD
matters after all,

Particularly preparing for the GPU & Audio output!
As a driver specific the advantages are around 13% improved
performance & 20% improved code flexibility on SiMD compatibility.

We can also directly utilize for Automated Direct Reactive Secure DMA or ADRSDMA

(signed RS)

ARM Patches 3 arte enabled! https://lkml.org/lkml/2022/3/30/977

*

GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
boxes including ADSL & Fibre

Cloudflare Kernels & VM linux, I pretty obviously would like to be
able to utilise cloudflare Kernel & Linux & cloudflare is very special
to me

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?usp=sharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.com/

https://www.phoronix.com/scan.php?page=news_item&px=AMD-PSP-Sysfs-Expose
