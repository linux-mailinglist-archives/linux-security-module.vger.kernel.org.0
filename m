Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3D220033
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jul 2020 23:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGNVlI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Jul 2020 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGNVlH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 17:41:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1501C08C5C1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so7613040plm.10
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVz0yoqE7nbKLxEfE0Ni6YZf8hVnVv/lZnqHDwHd9EI=;
        b=d2/Gu/BmUNB5aqve7jAShkkdGjL9w8kucpLcU7onUISWOA1mEYKDfwakrLbMq+FLcv
         m0luqWY1m/cPBVHnz3QKPRILQXGtjXZfWHubOLuYJtO3zgaijkhqOiEDpIpkqipJixUJ
         aKgOIaNB2Nd6SJXbuWDUosoe/bMhO5LT++RmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVz0yoqE7nbKLxEfE0Ni6YZf8hVnVv/lZnqHDwHd9EI=;
        b=hUGGhhZFzPWENM82hIOlHoR4UXHGoc3JAWN8Y7Adgs1keSAjplG2R1fdF65UQSU5kJ
         sH3JMemU7KKazJAtsczW0VTU/tizUJkL6agMR6vul0BibEq3xGSbglAuryEcbMtB4rhy
         ykZsF6KO8kY7PTdObPNvRvagUf4CTadgNTwou6hHyZKWXyx22wUyn9dQqRwsAyRlTa1q
         tVB+MDIcqsGjSa+l8JYFLzaHXMc9IfxiktFmdyEwNoX2/7oSNSdh7jvlr5lLTO1O1qDj
         3Vw3ruaDWqZarm7/YFyXSD3q6sJqYcp1fLuRsb6FQIsWI7ujFyHKyPlRCLSgB4xNiy4Z
         eE6Q==
X-Gm-Message-State: AOAM532Rp7AuIQGFhtvUpZL1b7i1oYT9uHCPOr3siyKeD9S1ooIG2vnr
        8uZWJh6/fyiyZHXYDeJEV4EfSA==
X-Google-Smtp-Source: ABdhPJxhN/Y39BnxM0uRcYuZZMzDRRwoDiA3Y/6MHYVyzHW1tffbpD9XK/UIV8xeYgDAxt4YVSdZhw==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr6773703pjb.69.1594762867408;
        Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm113755pfq.197.2020.07.14.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:41:06 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:41:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/7] exec: Factor bprm_stack_limits out of
 prepare_arg_pages
Message-ID: <202007141441.C612C34E7@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87365u6x60.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87365u6x60.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 08:31:03AM -0500, Eric W. Biederman wrote:
> 
> In preparation for implementiong kernel_execve (which will take kernel
> pointers not userspace pointers) factor out bprm_stack_limits out of
> prepare_arg_pages.  This separates the counting which depends upon the
> getting data from userspace from the calculations of the stack limits
> which is usable in kernel_execve.
> 
> The remove prepare_args_pages and compute bprm->argc and bprm->envc
> directly in do_execveat_common, before bprm_stack_limits is called.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
