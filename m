Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39A1D2547
	for <lists+linux-security-module@lfdr.de>; Thu, 14 May 2020 05:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgENDFN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 May 2020 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgENDFN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 23:05:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F80C05BD43
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 20:05:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so656955pfb.10
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RI4af4t+Hr3cwRvViCD0C0VTSsdcgl2WIZRjAD5Dbd8=;
        b=ER81wy6Nm4qqHe6/4nA1T72QieIUsDZr9xcEPXqlwCuu1bwbRzbDDp76o/GaGyv6ZN
         LhIsA3q1GqyyyLFIO5q4UxMKZ/DLFp4DOO12AImeksODZzTLEOUUYcEhUXA8eb5xmUfr
         WADVBn7cABTbN0GqYscdMzowjTlrjm+0sez/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RI4af4t+Hr3cwRvViCD0C0VTSsdcgl2WIZRjAD5Dbd8=;
        b=A3i1Ka3yOsQ67JGgGZhNxijnJ0KGGnxB/xaKvoFgHR9i7Nq/LyX6bnmoNcVdqUxc7/
         gQAV4ahz5tYC4fCbK9xSWCMdCOLTWKmUYvBrQdZqvMQt7htPws8UxhJbS8z8PeT8A7IJ
         GLyw0AZuYjt7WLDzKPL5+eyXMGwh32akTXFoNl5L1mnCoVP/e71MPuEZBKqs5VK4KI6o
         6Lv8mttKMDxG2o5SMznLdmBjuSMT1aS2Az87AeXIVaz0aj8k78MA5Xrqfxy96GimhZmO
         AT1PTQP5x6sREcrdWSRR62NuOkzRkrNKOTLmiuEayIV9CsSrTVLI/Vjg7nCpz7jULnim
         KIaQ==
X-Gm-Message-State: AOAM530SLePVwtdh9jZfHycMiWZtrrWeF+rmvLubbotENFFBrHqyGf7f
        Jrc/ZnYngBLJsYXjqCVs9qBoBA==
X-Google-Smtp-Source: ABdhPJyv6W4n0Q3ekaCcNquQfPEI0ohUKwE+N8w+M8dJ+JkwyMY+fS9GmFM65yiwziqJLP/Q/8otoA==
X-Received: by 2002:aa7:958f:: with SMTP id z15mr2213370pfj.10.1589425512261;
        Wed, 13 May 2020 20:05:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z7sm818011pff.47.2020.05.13.20.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 20:05:11 -0700 (PDT)
Date:   Wed, 13 May 2020 20:05:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
Message-ID: <202005132002.91B8B63@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005131525.D08BFB3@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 13, 2020 at 04:27:39PM -0700, Kees Cook wrote:
> Like, couldn't just the entire thing just be:
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index a320371899cf..0ab18e19f5da 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2849,6 +2849,13 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>  		break;
>  	}
>  
> +	if (unlikely(mask & MAY_OPENEXEC)) {
> +		if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT &&
> +		    path_noexec(path))
> +			return -EACCES;
> +		if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
> +			acc_mode |= MAY_EXEC;
> +	}
>  	error = inode_permission(inode, MAY_OPEN | acc_mode);
>  	if (error)
>  		return error;
> 

FYI, I've confirmed this now. Effectively with patch 2 dropped, patch 3
reduced to this plus the Kconfig and sysctl changes, the self tests
pass.

I think this makes things much cleaner and correct.

-- 
Kees Cook
