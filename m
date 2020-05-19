Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADD1D9EE1
	for <lists+linux-security-module@lfdr.de>; Tue, 19 May 2020 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgESSKP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 19 May 2020 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgESSKP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 14:10:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1AC08C5C2
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:10:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so220678plp.6
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jDYo4m5PP7xufMNqX2IQkJ1zE2G71qHXVTGfdTFjKEY=;
        b=G872pkcm8w6Qv241zfp28F0Fi28C447LZGFxMoMou558duvg393y5a4Y+yvm4hpY23
         /B3SoivGMflaBaRqQXD0/Tt4XmF8m6Ru1YrRQBVVftz1Vjj8MjKTaYP8ziUFmvhgimd5
         q9FHPEqaNOcBWF2dh/VDjEYZ5KzcghWUGivs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jDYo4m5PP7xufMNqX2IQkJ1zE2G71qHXVTGfdTFjKEY=;
        b=E3Ok/1tUMiCww+/7R9vCEPrVRhhPcNgrHwb8Pot4oEfm1tj3d2H9fQLuV5JKWlcRNb
         t0o3euiz1k/JBlbIMWOaWa2D0+wTqK4aOMR7aJ/3xrtLO16pVAZ4v0GGWEZg/DFhXGYP
         wm6KHQiqNo1XYMYoSQXfhJ+g1JHvaEROpSnMEZ2u6tZJdSS0wqVUKR9X0iDi+GrBUUqF
         +tyKtxZB+v52pQnrsL6WVzufO/c+T1EaEovQ2iCMurwzlEZPeBc71TWmnkm7dauPBWN0
         txQrkn59g2CZ5r5sEAZi46y8Zysvnirlxmm2r38pZKFCzNzgH4F573znyYSTVZSfe3VN
         Bb1Q==
X-Gm-Message-State: AOAM53005Y2BY+8C6sIpSByZbf+frsBRqx4IcMtNufz5DiWUP7+EaqdC
        lsscdDOGwbInNgrq1TFchsAM0A==
X-Google-Smtp-Source: ABdhPJyOVFXnc+Pfx1v9jQO9B9KqYsUGKOm81RvBW5K5UxYTvg5PBkCKO2dKISXN+l0RgynZFoT3yw==
X-Received: by 2002:a17:90a:6d90:: with SMTP id a16mr821079pjk.138.1589911814441;
        Tue, 19 May 2020 11:10:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13sm138380pfh.118.2020.05.19.11.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:10:13 -0700 (PDT)
Date:   Tue, 19 May 2020 11:10:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 2/8] exec: Factor security_bprm_creds_for_exec out of
 security_bprm_set_creds
Message-ID: <202005191108.7A6E97831@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87v9kszrzh.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9kszrzh.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 18, 2020 at 07:30:10PM -0500, Eric W. Biederman wrote:
> 
> Today security_bprm_set_creds has several implementations:
> apparmor_bprm_set_creds, cap_bprm_set_creds, selinux_bprm_set_creds,
> smack_bprm_set_creds, and tomoyo_bprm_set_creds.
> 
> Except for cap_bprm_set_creds they all test bprm->called_set_creds and
> return immediately if it is true.  The function cap_bprm_set_creds
> ignores bprm->calld_sed_creds entirely.
> 
> Create a new LSM hook security_bprm_creds_for_exec that is called just
> before prepare_binprm in __do_execve_file, resulting in a LSM hook
> that is called exactly once for the entire of exec.  Modify the bits
> of security_bprm_set_creds that only want to be called once per exec
> into security_bprm_creds_for_exec, leaving only cap_bprm_set_creds
> behind.
> 
> Remove bprm->called_set_creds all of it's former users have been moved
> to security_bprm_creds_for_exec.
> 
> Add or upate comments a appropriate to bring them up to date and
> to reflect this change.

Yup, awesome. One nit below.

Reviewed-by: Kees Cook <keescook@chromium.org>

> [...]
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b77..718345dd76bb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> [...]
> @@ -2297,8 +2297,6 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  
>  	/* SELinux context only depends on initial program or script and not
>  	 * the script interpreter */
> -	if (bprm->called_set_creds)
> -		return 0;
>  
>  	old_tsec = selinux_cred(current_cred());
>  	new_tsec = selinux_cred(bprm->cred);

As you've done in the other LSMs, I think this comment can be removed
(or moved to the top of the function) too.

-- 
Kees Cook
