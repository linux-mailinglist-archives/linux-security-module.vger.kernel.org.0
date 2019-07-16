Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7306B257
	for <lists+linux-security-module@lfdr.de>; Wed, 17 Jul 2019 01:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbfGPXWv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 16 Jul 2019 19:22:51 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41132 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbfGPXWv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 19:22:51 -0400
Received: by mail-vk1-f194.google.com with SMTP id u64so4557651vku.8
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjpiai5hkCYLL6Diojv89YWK7LVysGGzfUoUrfBoeQ4=;
        b=RpCqwPCvhvOPAtlSlatjK+atlcOC50FQcSClS0zKZgzBPDO/DW9MiVWDoZF58z5MdB
         fnyNbMK3RMD8HWeS3xtOcaJ5UaNwSop31ZerBzqTWC0XCvKIsd1S8s95vHljNbcIZWXE
         fI5qKOqIfdpP3Hm/+0L6i62IX70ZMgzJc4HqcoGlLbXi3l0P+f6a+f0T1CMKj356LoWd
         mH1CD9c8Pr7oWbnQkDunKHAZE7tI6iiPcWQyHiGGYiNIZQhRWEAvw4YNZho4wxeVkn8U
         AVpyxNe1w6+FrA59cJIayB2b/wKm+AVSzszC68evKv0kBMXA36YaJRP0LTi1WGRp4Zfu
         oi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjpiai5hkCYLL6Diojv89YWK7LVysGGzfUoUrfBoeQ4=;
        b=ZuuwebfZeRXNi45cEKg//tlw7tWguQy8lifQyH0/Z3mtLaLbmDxyCS0EwNVme5jHyN
         IzsT43wyES5YOj9l6W9KPcWvaqUHw8GtHQE9b+yC3CX+niFKa4ycHKF254ss1y7EUCwO
         59Y3uHynjPEoqF3vQy6ITJ25V306WBtJz5u7U15aIoY460QCGUxDyvlIRiR/K44Z16M+
         OetDc90Q73AZScXKnFtN6iAgmaHIFn3NdaejtzGh/oNfYlHFAf4+wKrtpp96RJUxYZJD
         5SpmyERyxEEFJo/VS+ouMebLXz/b0+G3WMcGf1FIW9NTvkAhzZS1b7eBkWMnNYFOpoXK
         3BvQ==
X-Gm-Message-State: APjAAAWBFxcIV3rWpXiXfqEM3WUAZJ1xLma6QGgU4wBq1AkqcuQWATZc
        /7dhYoSJ+lNK2HbbyzZ23tJkkQrAAMCqRAIJDdUNDxF7KJw=
X-Google-Smtp-Source: APXvYqypcm143UE8WXo2p4xQIYE4/nSLIYw9Jmalgee0YoQ3TxaTvtAIBcOrWMDEUoeTN8IBjeyCTb/bN9WDKfiOz14=
X-Received: by 2002:a1f:3dc1:: with SMTP id k184mr13794381vka.24.1563319369484;
 Tue, 16 Jul 2019 16:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-28-matthewgarrett@google.com> <20190716191439.59a1ac32@gandalf.local.home>
In-Reply-To: <20190716191439.59a1ac32@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 16:22:38 -0700
Message-ID: <CACdnJut3FDAqpELYOicR9-tYCF+G_213J0nGJHeR5EPqXqToVg@mail.gmail.com>
Subject: Re: [PATCH V35 27/29] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 16, 2019 at 4:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> Small nit, but please add this as the first declaration, to keep the
> "upside-down x-mas tree" look. I know some of the other functions in
> this file don't follow that (which should be cleaned up some day), but
> I'd like to avoid adding more that breaks the aesthetic of the code.

ACK.

> > +
> > +     if (fops)
>
> I think you meant "if (!fops)".

Blink. Whoops! Yup.
