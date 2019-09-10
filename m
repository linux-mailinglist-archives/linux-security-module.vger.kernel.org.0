Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27B8AECF3
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2019 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfIJO1u (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 10 Sep 2019 10:27:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36620 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfIJO1u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 10:27:50 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so37982511iof.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAJWigFQogCgXqw0GlIr6H4PJdXWKqg0KkSpMrQT/7M=;
        b=CDI61CautrcOJ596e6Ocyme/zhgxyGSPizFMEyCjc8zFk/4DmZGZuLcPRV8DX63sSy
         QfOWqPKSEDO+PN+kXadppYN6yN0ZYWSCnK8k21Pj1s30YvqJwymMQxEDYGbpEqkgCNkO
         0ff0l9JiWvTuQOzERjuVt4drIbh5FliYa9zHxcWtzXgwk7qOP1JZ5mDPzksaQjMRMDXN
         N0RuubgU/kLpA4t0q5+olIg6IQepEutG6lcPLoSy1ICNhoes3eld3+BXnFc48Jxs2DJC
         4RulZJ3sw3Ve7oUPlq5zQVUF0+r0FSs5Yo7FXP6yk+xR44XDLDLz/fPotT9tGv/Z1vg1
         ShbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAJWigFQogCgXqw0GlIr6H4PJdXWKqg0KkSpMrQT/7M=;
        b=ZAAx0d+dkXfRy919bLhNzOyXdhzb11oZ3EeTGv121Y6fMPsLJHV5ST9w37QMzehYcI
         pdmJap6GbMgACsqOK1oOnn8hILYWW4PJsL2uuTm9lypzeD/VnG3AP+BAH4DpvLVIm2hW
         AJkgF+916uHkQxis12m/u3cqAIMGfeFZEvIDliVMW8wOdSj0lNZ+uokMEFhdgKedZRGZ
         rJ2mnkrclVjCfJE6V1LTKGDV5dt7MD3h2sTMoXNbYMKGwUVy3ktcRKVucjK3e0mo8Axu
         caTvXy6lUMEk8LAshzrwQibXF6bMPaF8SBgXoOFMJLHpQskXsh2Y27Kf7lIZfmEwGeWQ
         0Vmg==
X-Gm-Message-State: APjAAAVcEKvP/tw9znS0AmNG0yYDBdcY/Jisx2qXt0dzOv/DamESrSO7
        zyAAlnc57BTWoB366+PRnhovk5U9jiGyV/9+YJCbhg==
X-Google-Smtp-Source: APXvYqwEMQEv8abs86qQwB4owkSshjlRdWMduOGeS/BxXi7DyYcvUMQBqShvZAQJ/9H8nlqE9ZM0BxWO8eLyqm2UHOo=
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr7092227ioo.104.1568125669479;
 Tue, 10 Sep 2019 07:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk> <20190830154720.eekfjt6c4jzvlbfz@decadent.org.uk>
In-Reply-To: <20190830154720.eekfjt6c4jzvlbfz@decadent.org.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 10 Sep 2019 10:27:37 -0400
Message-ID: <CACdnJuutzv+0nPKeizsiaix5YtYHU4RSoH-hPFfG1Z8sW_yy2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: phram,slram: Disable when the kernel is locked down
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Joern Engel <joern@lazybastard.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 30, 2019 at 11:47 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> These drivers allow mapping arbitrary memory ranges as MTD devices.
> This should be disabled to preserve the kernel's integrity when it is
> locked down.
>
> * Add the HWPARAM flag to the module parameters
> * When slram is built-in, it uses __setup() to read kernel parameters,
>   so add an explicit check security_locked_down() check
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Joern Engel <joern@lazybastard.org>
> Cc: linux-mtd@lists.infradead.org

Reviewed-by: Matthew Garrett <mjg59@google.com>

James, should I pick patches like this up and send them to you, or
will you queue them directly after they're acked?
