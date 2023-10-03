Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E879D7B6ABD
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Oct 2023 15:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjJCNko (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 3 Oct 2023 09:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjJCNkn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Oct 2023 09:40:43 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF9AD
        for <linux-security-module@vger.kernel.org>; Tue,  3 Oct 2023 06:40:41 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a24b03e22eso11754697b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Oct 2023 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696340440; x=1696945240; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puh49xxlHdZn1qw+vgX3cUDO6cZOkdYsWxDz9zkeBeQ=;
        b=Tl15g8U4BjY3b0bI6V37MZq2x/Ar9pSP1YjwwW6/EFbb00t0hZGvg1AWE5dxYTrdv6
         u7vnA1tg4wmiEDpaUl9JX0sXGCWa/zaT5xpimLw20lmnKWyY4iHAHI+95PdRJV8lP90p
         /ZLZFrMH+tMuJSX8uWZOg0Hnq35Ejx2WTUBRcBWDRtQGhiUfIPR5L9Pl6gf2G5CuBAzW
         1EOteBZI2FhA5fwCIX6PQntYTaVXi/0Kc0nAv/TNEDEAHEakGe1vGWMnhI0G5Qt2u5De
         NU1laqUYaPAYhlNmTBqW77MvcJAcpphRflO6FaRgq+6W3+AB1IOwTEQZdHkQS5Ox21Fa
         vzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340440; x=1696945240;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puh49xxlHdZn1qw+vgX3cUDO6cZOkdYsWxDz9zkeBeQ=;
        b=Yus0/mtFE613DmEGsBINd2hSbaTReK80FBRUSdFjY7HAOUQlFg+Yau/OtFACnC1rJA
         t1LwUNUDpthZeuUS+6ifZ5Ic1rs4eQ2okP3Sk0S/yuEl4oRUlfkZsv3J2Lo5BdKSc/wP
         gOQuB/PjGfXpPFc9UaHRo6X1Megvq7x5p4+7AyqJzUPLAkrcpLqtQHsmxeHi9aJwNR4P
         +DtDaMp0FHHc8MgLVYMbcQOAUNqlpa0eMJ2ktsxY10gcvtF1TINRBalHKXec19IvFHKI
         DUgWecr6GAIEE/X/mdoMjqHV0oLCezl2R48jI7A8Rzy2gH7DlYyWWrEr/h4+Wbg3Mg45
         XCtw==
X-Gm-Message-State: AOJu0YzVXI2EPyHFIm7Zstku3v1HMxORmT7dP7YWpj7eCcfmbw6OaI1Y
        pVOd83XoIApX9aJJDCWeU3Xqa5YNoyVOg9w5mLo=
X-Google-Smtp-Source: AGHT+IErGxsjD/v8N8pWdKVVVwEQXIugQTTC6VEJuvfGv15R+Hxgg5sB0QFg2M4ISFhjVQX86gqduiGUtnFVrCCUYAs=
X-Received: by 2002:a0d:e041:0:b0:59b:8da4:dc2 with SMTP id
 j62-20020a0de041000000b0059b8da40dc2mr13979047ywe.48.1696340440388; Tue, 03
 Oct 2023 06:40:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3e12:b0:383:ba9:50c2 with HTTP; Tue, 3 Oct 2023
 06:40:39 -0700 (PDT)
Reply-To: info.moneygrampostunit@gmail.com
From:   moneygram <moneygrampostunittogo1@gmail.com>
Date:   Tue, 3 Oct 2023 13:40:39 +0000
Message-ID: <CAGN3jeZgqZ++BhPZriu-yzVDs3U=g4K=J6cxxz4p5C31adTvBA@mail.gmail.com>
Subject: Oldingi xatlarimni oldingizmi? yangilanish uchun javob bering
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Oldingi xatlarimni oldingizmi? yangilanish uchun javob bering
