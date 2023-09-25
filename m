Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A157D7AD894
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Sep 2023 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjIYNGd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 25 Sep 2023 09:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjIYNGb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Sep 2023 09:06:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801E112
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 06:06:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-692c70bc440so2021658b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695647183; x=1696251983; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXglc8opTBOxqxBVnbKKZEfOjkArzaJ5mbcscFyV/Wo=;
        b=E9p/DdAhQv/UcBbrSHqMLXHKKFmTmAEugjpfcAaJIi0oAhHW91Fn3L148iHyI9tq6y
         1AXxdfTrMhS72Zy9gDH3x6BZX047nWgHv5SIYLenoGYIxmyhv/3Z0OHCspeSEWUjv/Dr
         5v3ZlzF9MCgA6c4GY0EVCOxSXAvWL66AAIUVTzUcrOiHt1xQuSXO/meOJiZwKRblOuuE
         cKIGL6pARcFlHbPhB2iJsp7kw3Bog0Y/ZW5yTM9A3tyq5lZSSMxCvErvB3dVJ9fa+G8q
         yvN079Vrw4bkbbYAlPNEYfEE1Ty6s7Y2UpwRLImeV4hkPd1Mji5zfoNrzlvslblzeye5
         9Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647183; x=1696251983;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXglc8opTBOxqxBVnbKKZEfOjkArzaJ5mbcscFyV/Wo=;
        b=QHcGY5myOdiK5COynHvwIXNufCsI2dARBnie5hNfeC/ay8O7LMfGVCaA545hjv0YT6
         CTnovX/1HH7kRuXfmeAZwxO4hcSjneBPCwOOS9W0E1Hcsws9tJ3op2nVA+IaSxMoGMuD
         pao309DQjb/jgY7swBalo+lrtZB05u7g2eojK2XuB2mOUutUNhX1yWEneUV+thPYDhLE
         INiueK3WjUMgYIjMA8/9IWr1szF7t2/AcXDs5LEv5Qsx9uJhvQlah2cUhMTGyAyMEFRB
         3wrhzb1iq9JE/MtEP+mCrdochXux4QMjYumv7L3zFJjKPZEpuESFRoz031Oq3rrHcexA
         Tn5g==
X-Gm-Message-State: AOJu0Yza/lXsydTrwkWHyr8YrSpCIdPph1kz24QKTpT7iC/xgi6OJPDf
        4MP9V4gIC4DniKnyZZSIyjAzE/nX3uZhcTNhBb0=
X-Google-Smtp-Source: AGHT+IFXiu+hIuGpbMGnryBZPI9zrQcfgcwULkxd1ATRGTszst7B+kzsc3FXYgt1Oi/EhIFKc10wDAE9O22h3BLnnC4=
X-Received: by 2002:a17:90b:33cc:b0:268:553f:1938 with SMTP id
 lk12-20020a17090b33cc00b00268553f1938mr4364657pjb.4.1695647182818; Mon, 25
 Sep 2023 06:06:22 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.isaiahnwabudike01@gmail.com
Received: by 2002:a05:6a10:4410:b0:4e6:519f:124c with HTTP; Mon, 25 Sep 2023
 06:06:22 -0700 (PDT)
From:   "Mrs. Rita Hassan" <ritahassan02@gmail.com>
Date:   Mon, 25 Sep 2023 06:06:22 -0700
X-Google-Sender-Auth: yeq3_xtuipO1P77d2qeKwPgsd4c
Message-ID: <CAN0kuD_Mb6r_ybPEbbHkv8BKeKwvyedgB_EOczj0YvEYjcG2ZQ@mail.gmail.com>
Subject: Please I need your help,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,MONEY_NOHTML,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please I need your help,


Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, I came
across your E-mail from my personal search afterward I decided to
email you directly believing that you will be honest to fulfill my
final wish before i die.

Meanwhile, I Am Mrs. Rita, 62 years old,I am suffering from a long
time cancer and from all indication my condition is really
deteriorating as my doctors have confirmed and courageously advised me
that I may not live beyond two months from now for the reason that my
tumor has reached a critical stage which has defiled all forms of
medical treatment.

As a matter of fact, registered nurse by profession while my husband
was dealing on Gold Dust and Gold Dory Bars till his sudden death the
year 2019 then I took over his business till date. In fact, at this
moment I have a deposit sum of $5.5million dollars with one of the
leading bank  but unfortunately I cannot visit the bank since I am
critically sick and powerless to do anything myself but my bank
account officer advised me to assign any of my trustworthy relative,
friends or partner with authorization letter to stand as the recipient
of my money but sorrowfully I don t have any reliable relative and no
child.

Therefore, I want you to receive the money and take 30% to take care
of yourself and family while 70% should be use basically on
humanitarian purposes mostly to orphanages home, Motherless babies
home, less privileged and disable citizens and widows around the
world. and as soon as I receive your respond I shall send you my
pictures, banking records and with full contacts of my banking
institution If you are interested in carrying out this task please
contact me for more details on this email. ( ritahassan02@gmail.com )

Hope to hear from you soon.

Yours Faithfully

Mrs. Rita Hassan
