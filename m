Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADAD7D108
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2019 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfGaWQ1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 18:16:27 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48733 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfGaWQ1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id x71so21162987vkd.15
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TNCYnHbae6Y+N46P+S/g9B2AO0ZpO70oB34sI5UpqOY=;
        b=TyMnOqTfGDABMXlcAwuv7T7jhu8BpLlOWDHO+zQGLa2ChBB8hEfFDP2zhJDEWRTed8
         itU6v2ZiJqe+i4EJYdCebruEriH2qsaxLRmEy+kII/wQA9nxDVVThu+714riM4DLr2wa
         dqNTFiVHcyLg/3anICNNZ0z666Wb7mh4oSLXpDkYPn0h5F2Y4A8+gQ6+2rah8LfVxzdw
         wZk7voII1+P+C6cSmHkgvcjwDjd0+a8PBbI14aVS+ru20lzThtzn2Q+5rBbeX4KOfgVX
         Y+u/dMRJpKtkgAr10pS4pFCWlgp1Sc3M72BYDfVV2i67o7THjKqSYGuetlXj4bVuOX+i
         Lp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TNCYnHbae6Y+N46P+S/g9B2AO0ZpO70oB34sI5UpqOY=;
        b=MyESvIcaJWWibROZWC27LqEN9hOi+QXMzWghgaDzNUs7Dewm9RkhPTfxaltwNsapuF
         hJy2kcGyWo9WxWPighQ92LeXG5FtRuTE4ltNBq8GnPJO8Mjz8PPRH738LH80YLeJBTsD
         eShK93wnguyVBTe6K7qefuvRHBuFEvJFVyzBgBC9Jv+9CrcQQAqKivVCvr5oXUto+/am
         aT1MAWXXEYJ1QQid8sSniXUDzrFIHo9I1QflYNSr68o9N1Z9YuW3Nixtvp0UO+i3rNCF
         h8d0nPzghOFN+++NqVllFb0c8NMukMO/XIU4l91ml684qwhHKPr81GqUjymP7o+AD/B7
         4yUg==
X-Gm-Message-State: APjAAAVLxcKe4HmPDEjgN1yGmRjaGFjJkpBKXzzOpitwKjyW2Iih8o64
        fRCvft/pqoT1fKLx4bz6qqDGwrKv2Q70T61cA13PVw==
X-Google-Smtp-Source: APXvYqwL9R2qHS/bl6BRUfgtjSoZ19607pzRI+aH/FxR+XimjEIv8tRaHjP3z6oMrbxKSWMVwlTwG43uv60sooxKe6omwQ==
X-Received: by 2002:a67:fc19:: with SMTP id o25mr8573319vsq.106.1564611385933;
 Wed, 31 Jul 2019 15:16:25 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:48 -0700
Message-Id: <20190731221617.234725-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 00/29] security: Add support for locking down the kernel
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A minor fix to the tracefs patch, some Acks and reviews added to the SOB
chain, and rebased on next/master (there were a couple of minor fixes needed to
align that).


