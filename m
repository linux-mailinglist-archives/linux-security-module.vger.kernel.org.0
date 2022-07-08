Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018156C0F3
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Jul 2022 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiGHRsK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 8 Jul 2022 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiGHRsJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Jul 2022 13:48:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B05C76948
        for <linux-security-module@vger.kernel.org>; Fri,  8 Jul 2022 10:48:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e16so11322726pfm.11
        for <linux-security-module@vger.kernel.org>; Fri, 08 Jul 2022 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCpgoi0bej3E/k3q1Zzvx8WQzQbsCorWnUbIjfYa/X8=;
        b=ml3Kny+TDNHdTGvuVDpKu9tNVsI9rg6LeipWZ5ZOkteqKLFBxM5ekj3E07IlhnmCZV
         QEGA9z/6eokWng2H3lP1krXx7MXUvPNoY40dacqit8ht0YCevulLcYBnXMrbRvrml9OS
         XyUb9Idq8wvH8qCWN0cfxK4yhsSKzD1PJ0xMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCpgoi0bej3E/k3q1Zzvx8WQzQbsCorWnUbIjfYa/X8=;
        b=k+AKUsG4MDv7lCdW+gMnNWaQ/UGyujSROvav9Us2fEBA4tHTAI99jJiALZ9VhIuU1S
         yumiKFI43y+d/tYcbXeSHkQC9aPd3xcpgiZjBO18ZBGUAAusHd/IYySqyYgAx53L81ql
         3W9LzQ0V4lV4r25VkCYteWrYv24e5cjaspiBKeWWLKYZk+Ol3V8KoDPeVgyf4zWwejDL
         JmdwGqqie14a5ij3xHACS65NF7QL+UwKVeTVh5yp2A+91PbWv5rBef7EWI48LbdsfYH/
         a7400UjMix5tZXvHU5BXNnFtijpVH/Hq5DDsQ81ecFxkmsd3nvovnHNTL77JHnpzkXl9
         EgwQ==
X-Gm-Message-State: AJIora8TTm8l+gH017HNnp0n9soLwYY1SizZRZSreg8x4gtQlpKOrfhT
        Gbhfzbf4Lpi5U9NFTz9p01wMfQ==
X-Google-Smtp-Source: AGRyM1sZCb3nACbVv0Xqctc8zBRDdY2BX228aDhc1USUQoc2fpKbCJNkaQ1aAGFkZEau8j+w/Chrcg==
X-Received: by 2002:a63:187:0:b0:411:6434:d017 with SMTP id 129-20020a630187000000b004116434d017mr4274618pgb.350.1657302487803;
        Fri, 08 Jul 2022 10:48:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a74-20020a621a4d000000b00528d4f647f2sm3404184pfa.91.2022.07.08.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:48:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     jmorris@namei.org, agk@redhat.com, snitzer@kernel.org,
        mka@chromium.org, serge@hallyn.com
Cc:     Kees Cook <keescook@chromium.org>, linux-raid@vger.kernel.org,
        song@kernel.org, dianders@chromium.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Fri,  8 Jul 2022 10:47:59 -0700
Message-Id: <165730247648.3882109.12888837825450019581.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220627153526.3750341-1-mka@chromium.org>
References: <20220627153526.3750341-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 27 Jun 2022 08:35:23 -0700, Matthias Kaehlcke wrote:
> As of now LoadPin restricts loading of kernel files to a single pinned
> filesystem, typically the rootfs. This works for many systems, however it
> can result in a bloated rootfs (and OTA updates) on platforms where
> multiple boards with different hardware configurations use the same rootfs
> image. Especially when 'optional' files are large it may be preferable to
> download/install them only when they are actually needed by a given board.
> Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> at runtime. As an example a DLC package could contain firmware for a
> peripheral that is not present on all boards. DLCs use dm-verity [2] to
> verify the integrity of the DLC content.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/3] dm: Add verity helpers for LoadPin
      https://git.kernel.org/kees/c/b6c1c5745ccc
[2/3] LoadPin: Enable loading from trusted dm-verity devices
      https://git.kernel.org/kees/c/3f805f8cc23b
[3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
      https://git.kernel.org/kees/c/231af4709018

-- 
Kees Cook

