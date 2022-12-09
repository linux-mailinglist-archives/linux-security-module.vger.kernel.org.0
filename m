Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29964894B
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Dec 2022 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLIT5z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 9 Dec 2022 14:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLIT5v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 14:57:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DAE11444
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 11:57:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so6042076pjo.3
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/HWN1rYxC7zqqh9NLR282rgIMZMEdI98wd3PXfAsK4=;
        b=iLHbQTaPpfYAY3PAixj5CAwnoYNb9cKPfdrBeByC8OoQn3iAm/Ul6GXUp/oSKIZb+m
         TJKdvHSfQ6Ct4eQjfXAqaymo7N/K761ddfJ0tKKJkShmU6T9zuZN6/1ywTiI5qYCIk1R
         DhfEq7F1XWlBu+RYvITIdfg8ocwm4OGGVQ4zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/HWN1rYxC7zqqh9NLR282rgIMZMEdI98wd3PXfAsK4=;
        b=X0GOwK6ZKQ4s8xabC/9tfF129Z4znEDOBIpvYpC+B8MvaUuA79E3XRdP7mo2zZmMNW
         XEnErXCb70TUJNyRrgszaR22G3tB6LiETd++gTas0lnM5B6OjH3MXd/gsrJtOcboYlO8
         RyJxjW/nPejCNJOyfrEx38CQVtaoTYRNbePdFWwr12mYjpHdIBWp2O+VDvyC6DjLNfCe
         ejgl1x7Syqk/5Qgg02KYdieVx7vaZlPG5g9zkF+S7JtNMETzkp6KREl3l6f+d5b7pWY3
         VaCLi8hO8UlLJPTeCYId3aZwgmTMeNbVDidyzG1TKvEJ9N1bWzC+Rnqx2tSf5JLajoaq
         7iRA==
X-Gm-Message-State: ANoB5pl/vTnasEaTDWHB5SzchF1d53xQb5BEYUSe3GR3UQz5mBYgK9p4
        4o/nqiSQryyaAdJHpp5GlU9t/Q==
X-Google-Smtp-Source: AA0mqf5k3pCfVBHBU4QquFPbvut4m9Nu8znFCAkduAMlfS/nvX1/gQsy6LeeX3fNoYjfWwrxbsMn/w==
X-Received: by 2002:a05:6a20:662f:b0:a4:cb41:298f with SMTP id n47-20020a056a20662f00b000a4cb41298fmr6044546pzh.6.1670615869098;
        Fri, 09 Dec 2022 11:57:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s1-20020a63f041000000b0045ff216a0casm1336663pgj.3.2022.12.09.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:57:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] LoadPin: Allow filesystem switch when not enforcing
Date:   Fri,  9 Dec 2022 11:57:41 -0800
Message-Id: <20221209195520.never.357-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=618; h=from:subject:message-id; bh=+nryc41vQfgiZxHCuNSNqDAbomd6sCJfIFUcZmpvNPg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjk5M4+FhVo9ou2lxGYgE2D8ZhXK4TWFWC91oaF6uu 7bPI9b+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5OTOAAKCRCJcvTf3G3AJmu+D/ 44LmrxSKtfx7C1fELprrQ4bZPv6J5KQO/juAYQU8ZZQ7O3DobYJoFbOuoGgsB46clB+hrr5IWxbDkQ v864YnIHdyKx2fayWoEKEBMO8iuIuiAu+xEyfXD/RoVtrBIfb9666hyexlDnhk9VUtLz4Bsm/ylm3j 5KeRDZPv7p8mGlsQXoxRgsAnkHoBJb1zAWgF22GGZbA1Qt8Y6bEE+LlLQvpgkfg7nlpNgAUJOSqCtf eC95tnKKn+yuYF6dV/CA8GJ7rqtILIU2VVe+jxe4n3GWP1iBp/HOwf29EFjRPafLJCIEkWrZBkErrg pDFw4BfMdKQkJRLitaIhs6KlwqgimfeayVCm67VTJxeOJ/KJoF3/Xp6g+wCBi0JS2pEZVEO7pB/prl 5m7YxF/nWzC4UdRazJE9GjeY731j+Tn8eOsx0E9JLW6r4noVbnoVCPZbApuQkfeXAqSFjcvfCAsjjS BJbjABn1BHe+h70DAWQXLtJcUOG6ostC+CXzGT/vXUa3ly/ifLBLSSQ5teuPIkdFMgALSb7IAhfDKO DT5pSTUSItPeVAE16KolYObza7pRJp5PdpCwFg8blAuCrYV7SsFF4LB7y5zJ1HBIv56kqp2NN7Eso7 jAoX7jFTOA/NSgeQBpWc41lY8nL52ha7rmIDhMPEI5Bp1aIGJ4C+WNirkITQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Right now, LoadPin isn't much use on general purpose distros since modules
tend to be loaded from multiple filesystems at boot (first initramfs,
then real rootfs). Allow the potential mount pin to move when enforcement
is not enabled.

-Kees

Kees Cook (4):
  LoadPin: Refactor read-only check into a helper
  LoadPin: Refactor sysctl initialization
  LoadPin: Move pin reporting cleanly out of locking
  LoadPin: Allow filesystem switch when not enforcing

 security/loadpin/loadpin.c | 89 ++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 37 deletions(-)

-- 
2.34.1

