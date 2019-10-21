Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF637DE50C
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Oct 2019 08:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfJUG6R (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Oct 2019 02:58:17 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34740 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUG6Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Oct 2019 02:58:16 -0400
Received: by mail-wm1-f43.google.com with SMTP id v3so949050wmh.1;
        Sun, 20 Oct 2019 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mERVdcaabbZ+RvMpGbS0z6Z3nUjRdN4OI0NdeA+OOR4=;
        b=HBZp3Vv63r7qWNzhZZo/J1iBwBRP00R3PaQRH/bIsI3unpSAfuZ9cqZJrKPvZnabih
         uWD94+v5UMRwZ7GxMCrqnFChgFfiKGHykz16CWicQ81nA1iieM15R0bdNjUxFUH9kFNe
         rNZcXSjWzzJFWPcn4U6KyqCvbmE8bsKSqFaZv83BwGM0/lxqp4T916hOn/nrdMMVlczC
         v9cSubA3O0ZqrPyNRnIXfwHzvjuYpVTIRM7TP6hOG6e/ZqDNuQFWK8tM/gn14xLHxXF9
         3wVMdn7iS3wFl1HNp4spfRdVawMUBRNzP6KEwZIK5YhCLnJWQmINvjFfF+sT/VYRT+nx
         Ve+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mERVdcaabbZ+RvMpGbS0z6Z3nUjRdN4OI0NdeA+OOR4=;
        b=syVw3vDxDqu34BDp34tpidKpmG36EWSzDvKINwTLhuWrRaXtuNTSd/ihdCpC2mn+Xu
         kwhsm4pXBcxvb9bk/pFpWTwrWPYf1FupPvKsy/AXLL2ABHVAY/UWKHlrd5IpOTLVdl1t
         PUU9BfhD4QYVx45sI5s7YlJbVE2rsklN1LNsA6QTkRXXHYo/dCGfmXvk9gwH+N/Aw5oe
         ouCbQUKcPXdOj/P95m5f0l/hynkkeRDpXt6Jb8U6QfKrWF65uIiDwYUC8Q8A7S1kFD4X
         3kT9p08zBK8sBzQBtmmixP414PsjQSY1otOVoerOkDFVJ4rbl/IOpKKhgbBt4P2RZQGQ
         JUXA==
X-Gm-Message-State: APjAAAV/44/Ubs3SewpZhUzU5HgafRkxjAKMx55xsHGpzVChvGiCeqc1
        frkiUW69olKwUrJV1dJBcCw=
X-Google-Smtp-Source: APXvYqzXQPg7XyemOX/s7mVyBUJ2KZpv8Kd4wG9xlKHcZIW9h1X21edPHRzToz3pc0bCmiPgshwxQw==
X-Received: by 2002:a05:600c:294c:: with SMTP id n12mr16751201wmd.99.1571641094964;
        Sun, 20 Oct 2019 23:58:14 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d11sm15924646wrf.80.2019.10.20.23.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 23:58:14 -0700 (PDT)
Date:   Mon, 21 Oct 2019 08:58:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Micah Morton <mortonm@chromium.org>,
        Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
Message-ID: <20191021065811.GA17098@gmail.com>
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <20190923233038.GE7828@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923233038.GE7828@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


* Paul E. McKenney <paulmck@kernel.org> wrote:

> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -383,20 +383,22 @@ do {									      \
>  } while (0)
>  
>  /**
> - * rcu_swap_protected() - swap an RCU and a regular pointer
> - * @rcu_ptr: RCU pointer
> + * rcu_replace() - replace an RCU pointer, returning its old value
> + * @rcu_ptr: RCU pointer, whose old value is returned
>   * @ptr: regular pointer
> - * @c: the conditions under which the dereference will take place
> + * @c: the lockdep conditions under which the dereference will take place
>   *
> - * Perform swap(@rcu_ptr, @ptr) where @rcu_ptr is an RCU-annotated pointer and
> - * @c is the argument that is passed to the rcu_dereference_protected() call
> - * used to read that pointer.
> + * Perform a replacement, where @rcu_ptr is an RCU-annotated
> + * pointer and @c is the lockdep argument that is passed to the
> + * rcu_dereference_protected() call used to read that pointer.  The old
> + * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
>   */
> -#define rcu_swap_protected(rcu_ptr, ptr, c) do {			\
> +#define rcu_replace(rcu_ptr, ptr, c)					\
> +({									\
>  	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
>  	rcu_assign_pointer((rcu_ptr), (ptr));				\
> -	(ptr) = __tmp;							\
> -} while (0)
> +	__tmp;								\
> +})

One small suggestion, would it make sense to name it "rcu_replace_pointer()"?

This would make it fit into the pointer handling family of RCU functions: 
rcu_assign_pointer(), rcu_access_pointer(), RCU_INIT_POINTER() et al?

rcu_swap() would also look a bit weird if used in MM code. ;-)

Thanks,

	Ingo
