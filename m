Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9859C224630
	for <lists+linux-security-module@lfdr.de>; Sat, 18 Jul 2020 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGQWKb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 Jul 2020 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGQWKb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 18:10:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C887C0619D6
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2020 15:10:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k5so5988820plk.13
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2020 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kXPLjDrHtFXbNmet3AnHCGh48BJAIHJk8m3fZv071oc=;
        b=PpAc1HNYIT+QLMKhWHW1jl69NR1BoJnESjDZGrSJSD8rmjkUEt+Wtl439d/aUbqRFQ
         FQi3HlJUBrRonE9RjdfjP+55VLF3PgOo7bjCzzwuvZNhV9QGuaV3KdgQexhmz0n06eze
         dLlPv+vO46p4W2lZrmOGc+zuXZml1lcIQ8UeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kXPLjDrHtFXbNmet3AnHCGh48BJAIHJk8m3fZv071oc=;
        b=VgCYx0MB4ANHaUJ6sEZoUYjTKaNwZP4zaSth0PvjlgSZZswUUqI6t6WQqZIGDR3AsX
         g2AYAptf0LTcSNaYhmJVLwpfTbVK4fz1VgMCR/1pFknqEKMjpgAIDkRa7mGmp2Aht8Dx
         LUD50L7D95IRFjupr2vIjEjukRVLPQ3BTOtD0jGBa7OI7lBXAS/CMjDGb2UXYy2QpL/m
         a+vvkJ4XEEbwup6IfUFUaRkjuF2Ss7ZDC27mWTNQDBcKSv8V5UwptZGgnY84UPPsPvfG
         WpD7z5YNiqrmWrLK70KFtxamWeB9Y2A7s2NAi3YYAgF48FtmXWGRWs2IONDwqJ6L+2cG
         +qlw==
X-Gm-Message-State: AOAM531z6AC9brd2Lwh8Ed/8PnJocQXusTHq0T8MWAnYz7YMv/N2OvxY
        TonzEGgn87AMd/JDQIg/gO944A==
X-Google-Smtp-Source: ABdhPJxl+/7V6fVqG2R0M/UfwPRNbJnc/viXiuvUuaSeof1VNQLC0wgELrpHCv+61l/+32K9tfMnwA==
X-Received: by 2002:a17:90a:17e4:: with SMTP id q91mr11673037pja.61.1595023830564;
        Fri, 17 Jul 2020 15:10:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11sm8353780pgm.1.2020.07.17.15.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 15:10:29 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:10:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Introduce partial kernel_read_file() support
Message-ID: <202007171506.CCE3902A9@keescook>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <8de85fc3-9f31-fc59-abc1-29f43fb90988@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8de85fc3-9f31-fc59-abc1-29f43fb90988@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 17, 2020 at 12:17:02PM -0700, Scott Branden wrote:
> Thanks for sending out.  This looks different than your other patch series.

Yes, it mutated in my head as I considered how all of this should hang
together, which is why I wanted to get it sent before the weekend. I'm
still trying to figure out why the fireware testsuite fails for me, etc.

> We should get the first 5 patches accepted now though as they are
> simple cleanups and fixes.  That will reduce the number of outstanding
> patches in the series.

Agreed. I'd like to get some more eyes on it, but I can get it ready for
-next.

> At first glance the issue with the changes after that is the existing
> API assumes it has read the whole file and failed if it did not.
> Now, if the file is larger than the amount requested there is no indication?

The intention is to have old API users unchanged and new users can use
a pre-allocated buf (with buf_size) along with file_size to examine
their partial read progress. If I broke the old API, that's a bug and I
need to fix it, but that's why I wanted to start with the firmware test
suite (basic things like module loading work fine after this series, but
I wanted to really exercise the corners that the firmware suite pokes
at).

-- 
Kees Cook
