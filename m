Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693204F8734
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Apr 2022 20:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiDGSnK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 7 Apr 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbiDGSnJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Apr 2022 14:43:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3461C6EE6
        for <linux-security-module@vger.kernel.org>; Thu,  7 Apr 2022 11:41:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so12633092ejc.6
        for <linux-security-module@vger.kernel.org>; Thu, 07 Apr 2022 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SZKa31xilIIm1WkDXfN5SJbBDWwDZwkYsD2F84X190Q=;
        b=X6AWf3W1YYLcVuB1QK/ljk1CuQIv9u7/Fqi/Souc3YJrD527+23vqjJ4A6ttbiIIKa
         eaNWQFoB+Fw4mScfUp5g45tx//yd6bq63NKGtmibvGL0Zl2L84ppBGGok51JWvZCv85r
         8DA93OKuh/ei1lfQxilpUGDspVpGwyKaSyFg+q/61id408sCFwaEEwca7I6zUPRCYNds
         yYLZydo2oKDdverOpP3PbaNQvgc0V+7ykiR8jCI67+M8Q/Dzn0oyouir/LCXa8CX1OY7
         NJiyanx3Bwo8WdtrgKGJWz3kRjjQ0Ji13DmJnDV6ta2dsZxiLZFj+w7LRVWxRh5P7h8H
         ld/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SZKa31xilIIm1WkDXfN5SJbBDWwDZwkYsD2F84X190Q=;
        b=gX47ZhCWRfmMW9Sv11XSLwCwMVKS5c9HP4wmMHR2RDH+AdZGIOJWL+Ppw8JhfP7YGN
         IL2M5HHPxnmB2DeobVKyuEf6zn4mZvxSEpVcEQ8effqCCbg5lmsk6mLkR4NuyfpQK3L0
         Yj5smEEK5+D52n5QNN6gEMiaVgOzcqr+qX+V3WhfG6TovPbjajjhFsgMw+LYx7uMgG1M
         w3i0SwvQgnoN4WjsWsKA419NPt/DUDPwPB9q+peMhGD5TZwnst0RX273QI5NkMg48Iys
         aqJvHE8uP0agBAUZFlz/ZFp39nM7CezbWbRG4QVv0PbZ/SB+EAvuE2wF23obTNttvcTL
         0nnw==
X-Gm-Message-State: AOAM532rwG38DPgBXaC3tdw2Q0XQT3DwDtKFTGNN8XpWeFTyIWe+HmFg
        DT3TNQY+E7M0BfYLQgc+ZKwbZB3HcTyXlWVqyRzvdWxujrRruAoe
X-Google-Smtp-Source: ABdhPJwbfz0ZKjRPZpIzjLj+8PD8J4rMYczqTIzcmdBBMENrj6djdYfMcZqXZTEumSjxeWkrfnimm2qMtwkIZH6k3LQ=
X-Received: by 2002:a17:907:1b10:b0:6e4:bac5:f080 with SMTP id
 mp16-20020a1709071b1000b006e4bac5f080mr14749015ejc.24.1649356867329; Thu, 07
 Apr 2022 11:41:07 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Thu, 7 Apr 2022 19:40:55 +0100
Message-ID: <CAHpNFcP+GWMK+8=GuQWP7tsoyUFH_gTxM7brAksjhW1rfADnxQ@mail.gmail.com>
Subject: Android, Windows & Console source create right away! Faster Games &
 quicker WebBrowsing (c)RS VecSR X-OR https://lkml.org/lkml/2022/4/7/672
To:     info@vialicensing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Android, Windows & Console source create right away! Faster Games &
quicker WebBrowsing (c)RS

VecSR X-OR
https://lkml.org/lkml/2022/4/7/672
