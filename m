Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63FD660B3A
	for <lists+linux-security-module@lfdr.de>; Sat,  7 Jan 2023 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjAGBEs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Jan 2023 20:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbjAGBEj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Jan 2023 20:04:39 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465C848C2
        for <linux-security-module@vger.kernel.org>; Fri,  6 Jan 2023 17:04:29 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-15651a0e01aso2587080fac.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jan 2023 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=bcoS6C2817GyhpLzxWz4AennzXQkVoalnht/kvY2qVGPJamxy0FVqumbcSAm2l1NqQ
         hy/EbmIuwDTqYxeMFZQN6XY18JkVILmKJT/GygXMgrvO6//waE+nQTdbIbNXVkha/zXn
         GTUOUKR5VzfSvierNOKOb/fypmxrHJfV3dGXeMQqdfnzt0Cnrb/L8gWvzi035jYxnf7T
         7v0UvpHiznbIuUeWHusLWvId8cd2/fVvMjCYCEKh4iKZk61FcaAay2hkvbgFy+ydojvU
         JrG+tnw0oS+u030j8LlVXM+z0/t4QaguOLB1OQQCddSARexpMkLpKszPWSy0AHDm5mEH
         6hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=KHjTH89hpOqaUB/PmhLqBn2AXSlHexCJCcW+1Verh+PIoyvjzJ8smxX1CNZjRqsl81
         7Jq6jDSzqATB+chzBe9SCyV/UqbzA6V0H/Mfe+JKU8MQT75+5wHXfOyI7P9EM0DgnSVi
         UYSgQEuyt874IYd0ppf3vDUEfxq0tuJOO5KRombhqX4Y1ol0jAPGing5ySu/UWSCFmXA
         /1s1JdIRkKKKN5gzMjH/PnAAGknxK1XdeDVVDBF96JIhAz6pVDCjyzdTSCdVh0Ajlq++
         TaVfcwxOxMan9fbVTlAn73QWPshLfcgL0ugemYidbFpfxI3AzIJ1Rmsvrutw+33D4mqo
         m5Vg==
X-Gm-Message-State: AFqh2kqKFRJNoXqoW2lWkjNBwDL31ZAzwOLV8XFGUdsJnaR+kF4lBuPA
        Uoxh0og3NOgcqzUtmw25g1hzvf/xxyYwIh3Sg68=
X-Google-Smtp-Source: AMrXdXuLIkczffrw/nGPLzU+T6JxiPMjzQSjI9ZGkHR5kSqJF4HT1c1+MtonQsd7rfA5ATZjfHy3pOf2qpZaN69zav8=
X-Received: by 2002:a05:6871:6c94:b0:150:8bf9:1c04 with SMTP id
 zj20-20020a0568716c9400b001508bf91c04mr1587529oab.239.1673053468965; Fri, 06
 Jan 2023 17:04:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6808:2387:0:0:0:0 with HTTP; Fri, 6 Jan 2023 17:04:28
 -0800 (PST)
Reply-To: jamesaissy13@gmail.com
From:   James AISSY <samueltia200@gmail.com>
Date:   Fri, 6 Jan 2023 17:04:28 -0800
Message-ID: <CAOD2y7=cNgFAGNQm9FK_b=Ut3J4M_0=BtMdunxKn86M9z64y9Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello My Dear,

I hope this message finds you in good Health.

My name is Mr. James AISSY. I am looking for a partner who is willing to
team up with me for potential investment opportunities. I shall provide the
FUND for the investment, and upon your acknowledgment of receiving this
Message I will therefore enlighten you with the Full Details of my
investment proposal.

I'm awaiting your Response.

My regards,
Mr. James AISSY.
