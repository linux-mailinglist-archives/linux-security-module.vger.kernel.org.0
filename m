Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1810760F77D
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Oct 2022 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiJ0MhV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Oct 2022 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiJ0MhU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Oct 2022 08:37:20 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D6EDDA0B
        for <linux-security-module@vger.kernel.org>; Thu, 27 Oct 2022 05:37:16 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id y20so493415uao.8
        for <linux-security-module@vger.kernel.org>; Thu, 27 Oct 2022 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQtHVIh1aNe4Qh0x0ragWBnOPchUE+ZIYXzmSXO/abc=;
        b=qlNsrosJercoAIRBP7rls2+DO6N2QChzhgrNubVLaP/XZ7tWFhYD2doN/zhwy9Cs1e
         L5AwTxtyURDNZaSaQ/ebp/8aEvsmYaIF6x+x+FqPBBWJiYFyt9OMCwRx9tMBIPWnp7F/
         mUwDIG4hGvbAjjLj04uUrwrXcq+uixbDkyXOBjL8NnckOq2OmwSIksNEzw9+DXuTkjel
         anWxa84DOGXhwpFrWIcQXqpOCeE5cO/HPba2rzhAE2cJjKVoruNhznc5g3zZO/KjaCcy
         qLrw3OvYOuUqzMkaPfqOFOyoslmE8CQnW0J9t/SP+zdB02OLr+lewqCLEghdRsaiAnnR
         M2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQtHVIh1aNe4Qh0x0ragWBnOPchUE+ZIYXzmSXO/abc=;
        b=CjvMk8m++9ZeISXH1uLzVy6nLJwNY5roOFTQSK6UymKTeIkWZKELx16S0M8lF0dts3
         D0Z//YJqJz+IJV2iFik2f39+q5Xt7AHrOqtsJSOm1TC/EbT0eEphfZM/vpuh4sl2Qbia
         y/xD51L1PbTBv8hbXFACp0CFncEa0p6DaEuaIaVIl7c8dFNFPvIMb0vA6qUFyppT4uxa
         O8F8md7U1ZsVt1xrQwCtX3UefM4c5rss7AN0Zlq7AbR493Jl9LtdWv3wqBMg6e7HcCdE
         gYGiz38w0zcECJHyoxeQBUjl/7Qbhi7RPzTJeJ4maeoll0UThRR5f2h401iJbaQghB3F
         y7vg==
X-Gm-Message-State: ACrzQf0zSzNvvP2MqxUj01AK0NslmbGjpM12Mpp3fPoICe2bIs1A45SE
        ltpcWZON/N2bz88Q0l90W/6Fq0COn4jysDLw+CM=
X-Google-Smtp-Source: AMsMyM6N08J1cioI6DLoa3mFh9ZAP88WuUeI6aE0ejM3764JQ988W4bu8pKA91x/cekbo5NTW4+llGzKYI0ICPZU6fE=
X-Received: by 2002:ab0:32cd:0:b0:408:ffa4:85f9 with SMTP id
 f13-20020ab032cd000000b00408ffa485f9mr4028372uao.62.1666874234647; Thu, 27
 Oct 2022 05:37:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:3d83:0:0:0:0 with HTTP; Thu, 27 Oct 2022 05:37:13
 -0700 (PDT)
From:   Cheickna Toure <metk1959@gmail.com>
Date:   Thu, 27 Oct 2022 13:37:13 +0100
Message-ID: <CAOAL42hQPJ6_wWrbOjTu=aUC1hBe-EmZ85SW_AE6rkYp283tBQ@mail.gmail.com>
Subject: Hello, Good afternoon
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,
Good afternoon and how are you?
I have an important and favourable information/proposal which might
interest you to know,
let me hear from you to detail you, it's important
Sincerely,
M.Cheickna
tourecheickna@consultant.com
