Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F56461C7
	for <lists+linux-security-module@lfdr.de>; Wed,  7 Dec 2022 20:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLGTef (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Dec 2022 14:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGTed (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Dec 2022 14:34:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA963D5C
        for <linux-security-module@vger.kernel.org>; Wed,  7 Dec 2022 11:34:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2388938pjs.4
        for <linux-security-module@vger.kernel.org>; Wed, 07 Dec 2022 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9z3Yt2PBo18qYunOpCHSPswOByZMftBdK6j+zR34ffI=;
        b=zvMrRVY/o9fLXT3y3FfDgQz2NEUvTSvTRBTg1+lx501PR4aCWQOhT0QioyJo+PlmxU
         XIEjUBhuPt/IgQzvoWbMYIRdqL2YBM5msSJ8/pt7+Xb+1XR5c+km+C8jE7dn+lb0sI2a
         C2vKo4olQWOAQaaeyzKIDSIbEDNG0UHkeFH7ui9q9/N7yomHU/nStVC+YWb4ysisTiFu
         FmIdcZURkUKYQGxNQ95II1A7YI23oro2eWyBX0VcHV/yJjeSnUFXjLamgxBcTFPsD7Z+
         rguKZkCAWR4rDNO+zl7QpS4bIRvU1ZRO+FDTYcgn3M5UJ1OGHfg+UW6Wel+ZYaUe8mlz
         iWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z3Yt2PBo18qYunOpCHSPswOByZMftBdK6j+zR34ffI=;
        b=LEGR6EfgvuSvPdvedPW5ijBwECDJnfmevaUm+JNmjVlMRzLQrmH8hNdncUi71wSNyd
         l2V5GQeORmVBorkQqeSmeG5M+RQSq3HneySDGgHZj9j9+CcMq+yFDcr46BtaLP17TtBQ
         qAyll/wthPAWYAtQy+znboSLA99+kNd3K/7dA2GntvHwDqpYqa+GuncylvAahpuBfV82
         13oHMepiHWX0knmW5ec1PXCskKWSpSSetIKIOOIaJY2+LnLv40Az8yIAClZr+hKM3TG9
         Xb6RuyzL3odMkGgxsguZJO5fNafMf3heIM0D9sMtMfziFQzprbiDWSvNACxNkmuZEiB7
         t67A==
X-Gm-Message-State: ANoB5pl9/uNQOXIW4N/OVcM2SGhI5XoRLUBAyU234hb/Du0V2dddwAhU
        WEIWxUb8C7R1rS/9PoTgR6l/Cvkz5Do1mBCdxBJK
X-Google-Smtp-Source: AA0mqf7llbTT7/xYcSl19afyTz9X95rENoUylpQu0v3bF9V3D+gn61e7KUScrkRB46EF4YF6Ys7aBoQ21vY7xKb7Niw=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr105614882pjb.147.1670441672151; Wed, 07
 Dec 2022 11:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
 <20221128144240.210110-3-roberto.sassu@huaweicloud.com> <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
 <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com> <0682348d9601ca3847ce9ba035e4ab1b586cf712.camel@huaweicloud.com>
In-Reply-To: <0682348d9601ca3847ce9ba035e4ab1b586cf712.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Dec 2022 14:34:21 -0500
Message-ID: <CAHC9VhQZ3VKWsNarUGPcHZuoRLgb8owKgbdLymwR759qVyQ+2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     David Howells <dhowells@redhat.com>, casey@schaufler-ca.com,
        omosnace@redhat.com, john.johansen@canonical.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 7, 2022 at 4:18 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> For this patch, I saw it is already in lsm/next. Paul, should I do an
> incremental patch or change the one in the repo and you force push it?
> I would just remove the three lines after the parameters description.

Just send a patch against the current lsm/next branch to remove those
lines, and please do it ASAP as the merge window opens this
weekend/Monday.

Thanks.

-- 
paul-moore.com
