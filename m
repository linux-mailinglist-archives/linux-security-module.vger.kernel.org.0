Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C088DADC
	for <lists+linux-security-module@lfdr.de>; Wed, 14 Aug 2019 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfHNRVC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 14 Aug 2019 13:21:02 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43609 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfHNRU6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 13:20:58 -0400
Received: by mail-ot1-f48.google.com with SMTP id e12so39921966otp.10
        for <linux-security-module@vger.kernel.org>; Wed, 14 Aug 2019 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CapHB563gTOtizSxiyXbQJVWOCG9VF1tSLv/Lp07kmM=;
        b=vk5MkWvX0uuNipFn1OWaISBU29AGmOV86RhMeKRZrMV69qHr6poWxkfU8A+uwSZCJf
         AXDMEt3LfVDRBJ/1RNAgV7oa7LTwMAw2xA0M6odjDxdmW+XCGEKdCs1q1TIV+8lxzHKW
         Hfmn9LEPGoVIgiLci+4YUlRZqHIEQ+0XNqFv+g9+VRLxkAoX4rkUfe1+7YNS7X31RuKr
         g/T5lqYfmIXaqnfXhskoXI0/JMo5sftY+yBUXHf2aGSeWmZ3SiuL1puXoOLEkMeSZzLe
         CoSSF4gpkjMmiwwImnyIvmcGegKlenoCDgB3vNiUPwi9blkiQWLyLyVDgnBFeFb3eFev
         dpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CapHB563gTOtizSxiyXbQJVWOCG9VF1tSLv/Lp07kmM=;
        b=CIaExPv2LWop29u4ETZ9uQtlsKkWfqNBpMmCRFBkocSQ8/GVFFgEQvb2tfKaDs/zaV
         Pp9gUND2HX0NHp5C27U35Mf4nwYiaKq8iEYjU1DmTtgN2j9Fm3XPJ0X2RpOIQb+cZTWb
         x9JymdFlfaupHZVrnbe+heARKaDgMNBweWOqy2tMJCzj7CSxKhnC43BRab17e+rYXx0V
         TEIxBlPOah66qhW1zQDYDShZm0afTdggPotdIKqdj3XNkPSLaNbm9NMUkhkrYFLohia6
         SXVqGu7aGq2Fng2dRRCWG/lHB5Bz4cFKpwrEwagSCKwmIPHZZ+5oEGJQmL01FLjA4vmp
         8sfA==
X-Gm-Message-State: APjAAAV4Y6EkOxgOCTeoC3z6nUJ3wZgTx9Ib1pdtHwfK0wF7oIVyLLe3
        jwahtD1g45kJ6ZoG8HF0VXYMSCg5M6g35ffzsG1LsoC+WFk=
X-Google-Smtp-Source: APXvYqzYB6miyPAG/mOkWvCgKIgmMST0uLDo16MefZqZnlVt+Sc3TUC3Z65Mc7LHtI36zp6DZjKHxHkp4flLBm2vGOw=
X-Received: by 2002:a6b:d30f:: with SMTP id s15mr1002393iob.169.1565803257162;
 Wed, 14 Aug 2019 10:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com> <alpine.LRH.2.21.1908141503240.27654@namei.org>
In-Reply-To: <alpine.LRH.2.21.1908141503240.27654@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 10:20:45 -0700
Message-ID: <CACdnJuvXpJoai+H7WeM_TNk2cjqr8evAm082aJgBRGvsUyaAVw@mail.gmail.com>
Subject: Re: [PATCH 0/6] lockdown fixups
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 13, 2019 at 10:06 PM James Morris <jmorris@namei.org> wrote:
> Which kernel version are these against?

Crap. Sorry, these ended up derived from HEAD. Let me fix that up and
resend. Sorry about that!
