Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A85B104A
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Sep 2022 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIGXVx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Sep 2022 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIGXVv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Sep 2022 19:21:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E839DF95
        for <linux-security-module@vger.kernel.org>; Wed,  7 Sep 2022 16:21:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f24so16104091plr.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Sep 2022 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J1/Za0Ov5W/LsRfC9drQ1qe/y45jAzIrG0Ow8/Mw3sg=;
        b=CILbz0ay4OUw65DLMQM0qEI8KdpzpfdLdZe0SYtVUe07SuK0iyyQrSmW4zul+WqDoi
         IdRBqFlG+3XdMz7dwfcVGZnkebaYBY4DTeSOSogGuT+lYcoNesuXtin60VQEAIlu1QQR
         Fhcg6DIi7D0RcB5eCzEuDqqDE9zHpQ1nv7Gus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J1/Za0Ov5W/LsRfC9drQ1qe/y45jAzIrG0Ow8/Mw3sg=;
        b=5iTs7mX4F1xoZ1uGg9hYYiaeeUcYfWVgG1cYEYz4hM9eqBef2kPV02bdwOqF8e0oTM
         C9usmiM43z1NIjZ64Ek3FW9vxzoASwIzMr+q8eSAA6w1X98kiahRtsQg5HxfyA3wqXMA
         ycZUFqutbtI4wLQgMxj0ffKgms69PuR8Guer9glQauMEj1C6j31D9Ab+/kk+7do02rw0
         NKK0BhiUya224m4jaxzYmsvHv2uj2fQA7kxlEJnF4sfA+xlNtcc1XnSjE16lr+VN3IHh
         c/9DO1w0Sux/QDNSukFgWH9mggBPmfnHO2w4eYZ/oVNUzmg3+80tD/8/cdB+U7xMBd3G
         EZPQ==
X-Gm-Message-State: ACgBeo02FANE2fyUZi15QVbqkLSl7Kj+uJEURqDNyzv2PciBFfR1SnX4
        5NN8k+eYQNjPVaTDIEouDc7bCg==
X-Google-Smtp-Source: AA6agR62ujqCFxeOt8z80wde3Il2ISPqMvBSP1XidRj9mk/mLmJ4qjABVWRifSR081Kw4WqOUqs3sA==
X-Received: by 2002:a17:902:f542:b0:175:32e0:1e32 with SMTP id h2-20020a170902f54200b0017532e01e32mr6054092plf.170.1662592910545;
        Wed, 07 Sep 2022 16:21:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902c40700b00172951ddb12sm13210328plk.42.2022.09.07.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:21:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mka@chromium.org, jmorris@namei.org, serge@hallyn.com
Cc:     Kees Cook <keescook@chromium.org>, dianders@chromium.org,
        paul@paul-moore.com, sarthakkukreti@chromium.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LoadPin: Require file with verity root digests to have a header
Date:   Wed,  7 Sep 2022 16:21:45 -0700
Message-Id: <166259290380.77851.712633939405429705.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906181725.1.I3f51d1bb0014e5a5951be4ad3c5ad7c7ca1dfc32@changeid>
References: <20220906181725.1.I3f51d1bb0014e5a5951be4ad3c5ad7c7ca1dfc32@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 6 Sep 2022 18:18:12 -0700, Matthias Kaehlcke wrote:
> LoadPin expects the file with trusted verity root digests to be
> an ASCII file with one digest (hex value) per line. A pinned
> root could contain files that meet these format requirements,
> even though the hex values don't represent trusted root
> digests.
> 
> Add a new requirement to the file format which consists in
> the first line containing a fixed string. This prevents
> attackers from feeding files with an otherwise valid format
> to LoadPin.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] LoadPin: Require file with verity root digests to have a header
      https://git.kernel.org/kees/c/d64f3001976e

-- 
Kees Cook

