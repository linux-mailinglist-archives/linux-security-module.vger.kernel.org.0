Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F454B16E
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jun 2022 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiFNMpN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Jun 2022 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356919AbiFNMpH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jun 2022 08:45:07 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90644A01
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 05:45:04 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1016409cf0bso1161821fac.12
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lBFrwc11MgcaK75qf3EwNhKoIfwLYz4Dn7scEjO7Hwc=;
        b=BLPt3Whga/35puJNJe8qXtvQa8qVmyqziKSeeoay2BkfZzLmL2kjet48QjIHlqGgqM
         hJrfxQdJK5AoxDU7CWdC0FstM42nB5BZMl1HL4Pk4iVJwSU+vC6w1KJrj5xMhekFVmm0
         0MsIGOyg25y6/oyEKGPZ7dh2cYRSV76IiiqZklsjUfvRcFiBLZiWJ82kwuTL3P2i2hd9
         i0H7+mIdGJAQNJEMwtTL54gB8P0jwnVjKn7y3GnaCbX2/WcnBcAJOnSXOQLimrsbE/Au
         Ug673+luECUcnElmy46JUA2aaQBd8SEIBO9pdN8O8H126eLKdTlUNuGrlPKdwayk15FE
         osgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lBFrwc11MgcaK75qf3EwNhKoIfwLYz4Dn7scEjO7Hwc=;
        b=fFo0ju7AKiPO8IJ2tE958SjzkO8TX8ga9w+U0fdC19YquEtfX+Rv7tGI/re5mGc9UR
         B/y6JmBGz8yeLK9ndyoiyxN9CnNNzVHqpc8jyah4QM9nU22HcTCYsgsy/fal8NAY2O3n
         /9pOPJ0ETW438lBx6Oh1V8w4BXijnjIT+fKsxc7hdrCrP9WXyouuvtoigI4pEm3+pC4b
         Hg5bk6AVJjbWP2hm4ETEdglIie3KLRAPSjKPzo2sye+rMShv6uKC7Q+VK3iHGkVsjZH9
         y+KKeObKVaDfFaDLD0oiEdzPEkt1PiNpIZG1hV9cg5ysSsLoscNrlTauGhkOP5F4hjIj
         ooew==
X-Gm-Message-State: AJIora/esl0As7iQjh5vRStiE9hQoIr4icOFljHhCFAUsWRfkWpSomSl
        9eAsnqmSP6YKt5voVthFyIZdsGhPMHCAnuL9E8w=
X-Google-Smtp-Source: AGRyM1sAfOuObHV26Bg5/54l4JTOQHohavQsoKJhsRr0ubOd+Plp6gyN7sZbwNgPwBQs7yUKGU1CtTrAFYTKfLds5oU=
X-Received: by 2002:a05:6870:648a:b0:f8:7602:8402 with SMTP id
 cz10-20020a056870648a00b000f876028402mr2144743oab.194.1655210704163; Tue, 14
 Jun 2022 05:45:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:c46:0:b0:42d:ab20:ed24 with HTTP; Tue, 14 Jun 2022
 05:45:03 -0700 (PDT)
From:   Daniel Affum <danielaffum05@gmail.com>
Date:   Tue, 14 Jun 2022 15:45:03 +0300
Message-ID: <CAPkju_OnkYx0C6OwsrBS51C+hwRyz43LzORShgubPkwu8j7XxQ@mail.gmail.com>
Subject: Confirm Receipt
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Dear,

I am Daniel Affum a retired civil servant i have a  business to
discuss with you from the Eastern part of Africa aimed at agreed
percentage upon your acceptance of my hand in business and friendship.
Kindly respond to me if you are interested to partner with me for an
update.Very important.

Yours Sincerely,
Daniel Affum.
Reply to:danielaffum005@yahoo.com
