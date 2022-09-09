Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0CA5B3192
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Sep 2022 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiIIIXB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 9 Sep 2022 04:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiIIIXB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Sep 2022 04:23:01 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E32125180
        for <linux-security-module@vger.kernel.org>; Fri,  9 Sep 2022 01:23:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 202so1555847ybe.13
        for <linux-security-module@vger.kernel.org>; Fri, 09 Sep 2022 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=MxU4fJ4El5xIikQ69s5+V+M7YC/oCSbBwTvPMsApxc8=;
        b=UrVbo/N4wIWe1TMaGA2dLF7a5UA2Hj+X8NS3IMgXnSHDAoM1Jm7IJ3uuSeB++5zfeY
         yowU3ZHiauBHiCw2NOylFMZOROnxx3e84KJ8tBx9Kr9eSeEn5VLKMk3/T1nKth6Er7eG
         Du02mdzU1DARPaPvjeGQKUq2G2d4rAoNkZNmCJtj7X7kUYsf8O8lAdSJnMHZDHgteQF5
         HedbCkuMx8HNYAe3nIefj1PV3NxGMXgE56hjxPK86wOuUL7j+kB4qPCPmP0wtzpp2fC+
         cL3P0i5dCPscuBDmIcLkX8cyHyZrQSiLWpktOAg+/4KxrOy5iZHqnbu0cN4yRbmjfYp6
         hpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MxU4fJ4El5xIikQ69s5+V+M7YC/oCSbBwTvPMsApxc8=;
        b=tcFvrPncsUnouNsG6l6Mt3E0+vv0SctyP6f9HnxpwgsFPiE/Gc5uJ/HKaLBkhdmauU
         wFVfWCHnjqgMwDqJMtNC1Xzlk5SzUlbaiWlHohn2woFDfw/tXYTXEAjeNsbYPsHcMWda
         wNoOx92qQI0xB7SDFxzhGG1PkGSmkMJIhXVdz4s6Ot/E8+RcRQ2sdj4KOyvt5Hmy6Zvv
         QMSV/zuW+EjjomZ7bQpycptQl4S9lbGIUibEYhRRSt4Tdq0LEBxAx7DaUToM47EgIkAf
         aGBc5VqDmk/IPEUSKQCznKZmSr4hrGOLQksyHzgZKt4A8dKqa/7aVGQX+jY6uapHrQcw
         6yYw==
X-Gm-Message-State: ACgBeo1YtT9KpwcVXWc9TVKdbfzk580+hbcO66cBEYOQu37eaDyMMEsO
        8Le5FunDQdJzzuBFk/QTTU2ijn11Wm+VN5qY6+0=
X-Google-Smtp-Source: AA6agR7NOQSoL9pfavKCjtqBhMjbmgReo+NR/c6+NL7hpvo+IDtzqoZJwwo95jXidWR5q32BcqRWIg5OwHeBdC6fRoc=
X-Received: by 2002:a25:f85:0:b0:696:144b:ebd8 with SMTP id
 127-20020a250f85000000b00696144bebd8mr10809716ybp.123.1662711779425; Fri, 09
 Sep 2022 01:22:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:4148:b0:193:65bb:df75 with HTTP; Fri, 9 Sep 2022
 01:22:58 -0700 (PDT)
Reply-To: mr.ahodolevi@gmail.com
From:   George Levi <mr.koffiwillames@gmail.com>
Date:   Fri, 9 Sep 2022 08:22:58 +0000
Message-ID: <CAMgiTmbWu1MGutA2KRTyBx5SvZyWNCLxtH_Zdqfxz1Tg3kocnw@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr. George Levi
