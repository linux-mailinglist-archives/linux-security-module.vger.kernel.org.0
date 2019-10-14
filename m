Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAECD67C7
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Oct 2019 18:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfJNQyl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 14 Oct 2019 12:54:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33150 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388045AbfJNQyl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Oct 2019 12:54:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so8279459pls.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2019 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYebUPfyNzPvvFP6j5p7uvU8uZK4poYJs3oTBiRKm0g=;
        b=yHO5dTtAuvHOPwCvhm/oWcoY2hcMLNAkmng6d4K3ooyyc8zFnTpjyWc9bK7HKdw1eF
         uhd/5dQxKHkqFVLlVXpfn4EdvctySb+we4N53Caoh1g2VXNi0pMG0qKb3Z8UqTC95VEv
         mxyZBN43b74Lp/RypZ2DXb9hata5FSUyE2Yxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYebUPfyNzPvvFP6j5p7uvU8uZK4poYJs3oTBiRKm0g=;
        b=Um30MMRxq1Tizy3sq0C3ljrRenUh082Nd5MIKflkRTsl6rY1iJIwtvD31+xmJMLSXt
         TCq2BgkXjH6/Y8O/g/sbVC2db+kYLDSyJFxijwiySdxwO5QNIm+Hu3WtcqA57cXuKJxE
         STjiSTTgET5M6zUIiLXTezMH2ObVEy2I7i2lIO2o6jGwJtOXpmtTPcmT5ICQtAPBdGsR
         wDOx8f5/dasqhbvbdYpZ8Y3GYojmBZsZ8cbyBdLcfJceHNfJdKK2nMx9PXOiB3SxyTvF
         Y48cUGU9cSM0iVWNP5AUYT29qEBeJidXqJR0sO2S3wB42HxyUaDoZ3v/bX5nDkmAP2Yh
         XjXw==
X-Gm-Message-State: APjAAAWg8nHXeaW6LgGc61Mog0bVC+e4LGswwS5G4Dzr5ntW7YkBzEBX
        zlWcEz/PKTqO5SUMzq6dkqWimg==
X-Google-Smtp-Source: APXvYqyKVWUXBeWglNde3TqlO343XuFeYMHzVKt0SNBc79A0whQtME9EbjWCNDqvZmCRkvRhU7Yjbw==
X-Received: by 2002:a17:902:a712:: with SMTP id w18mr31527230plq.304.1571072080087;
        Mon, 14 Oct 2019 09:54:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i7sm14063475pjs.1.2019.10.14.09.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:54:39 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:54:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191014165438.GB105106@google.com>
References: <20191011160330.199604-1-joel@joelfernandes.org>
 <20191014093544.GB2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014093544.GB2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 14, 2019 at 11:35:44AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 11, 2019 at 12:03:30PM -0400, Joel Fernandes (Google) wrote:
> 
> > @@ -4761,6 +4762,7 @@ int perf_event_release_kernel(struct perf_event *event)
> >  	}
> >  
> >  no_ctx:
> > +	security_perf_event_free(event);
> >  	put_event(event); /* Must be the 'last' reference */
> >  	return 0;
> >  }
> 
> > @@ -10553,11 +10568,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
> >  		}
> >  	}
> >  
> > +	err = security_perf_event_alloc(event);
> > +	if (err)
> > +		goto err_security;
> > +
> >  	/* symmetric to unaccount_event() in _free_event() */
> >  	account_event(event);
> >  
> >  	return event;
> >  
> > +err_security:
> >  err_addr_filters:
> >  	kfree(event->addr_filter_ranges);
> >  
> 
> There's a bunch of problems here I think:
> 
>  - err_security is named wrong; the naming scheme is to name the label
>    after the last thing that succeeded / first thing that needs to be
>    undone.
> 
>  - per that, you're forgetting to undo 'get_callchain_buffers()'

Yes, you're right. Tested your fix below. Sorry to miss this.

>  - perf_event_release_kernel() is not a full match to
>    perf_event_alloc(), inherited events get created by
>    perf_event_alloc() but never pass through
>    perf_event_release_kernel().

Oh, through inherit_event(). Thanks for pointing this semantic out, did not
know that.

> I'm thinking the below patch on top should ammend these issues; please
> verify.

Yes, applied your diff below and verified that the events are getting freed
as they were in my initial set of tests. The diff also looks good to me.

I squashed your diff below and will resend as v3. Since you modified this
patch a lot, I will add your Co-developed-by tag as well.

thanks, Peter!

 - Joel


> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4540,6 +4540,8 @@ static void _free_event(struct perf_even
>  
>  	unaccount_event(event);
>  
> +	security_perf_event_free(event);
> +
>  	if (event->rb) {
>  		/*
>  		 * Can happen when we close an event with re-directed output.
> @@ -4774,7 +4776,6 @@ int perf_event_release_kernel(struct per
>  	}
>  
>  no_ctx:
> -	security_perf_event_free(event);
>  	put_event(event); /* Must be the 'last' reference */
>  	return 0;
>  }
> @@ -10595,14 +10596,18 @@ perf_event_alloc(struct perf_event_attr
>  
>  	err = security_perf_event_alloc(event);
>  	if (err)
> -		goto err_security;
> +		goto err_callchain_buffer;
>  
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  
>  	return event;
>  
> -err_security:
> +err_callchain_buffer:
> +	if (!event->parent) {
> +		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> +			put_callchain_buffers();
> +	}
>  err_addr_filters:
>  	kfree(event->addr_filter_ranges);
>  
