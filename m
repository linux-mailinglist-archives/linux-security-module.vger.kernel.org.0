Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A7737651
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Jun 2023 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFTU7B (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 20 Jun 2023 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFTU7A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jun 2023 16:59:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05941726
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 13:58:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39eab4bcee8so3130054b6e.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687294738; x=1689886738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyHaRq0HBfQqVo5s8buEN7LujzAfgb9I0SYf36k6c18=;
        b=gjpIAjNi0q26w85xbhx99EmvN7R5nLOdLbIyyNpHc/kPJZF1GdVg5ao/8mmRQk4KP2
         kbt+Q1mqU0Wp90KhCHzRb2hp9TadaSkyoankHAdYn2YpmNQDHJwP04B8+x7Dad2xF+wZ
         AmZQDdEcLYZ/ugQLWaaRrD7spqzmS05ZYSZ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687294738; x=1689886738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyHaRq0HBfQqVo5s8buEN7LujzAfgb9I0SYf36k6c18=;
        b=IrYYTwnMsqDLb/NoD56fqBK2cMdxpR6C3paCLtTYLOTNuBnUXCmudJXf4asOgqkPpe
         cBKyjkE3zaCTVlngHGS/jZETuz2ZpVdV3UB0AsbwRnoaVR7OjHVOaEx34/mrGZA+QI69
         VaqHMo0iDr/g4VhQE5RjSRX2V8jXL/ijMbacNe1XvfwyfU4QqTiXEaKDqhTeImjRbWuM
         1fIt3iGW7Hsl00Ydr3Me8HhRJ3kwnjRp9ZtP5qFNO/GXD+epvn5Ht56dWVg1HeDLJR6o
         VgxmNkDSe9irf8XemUpyFd2aEudLURUMMtn8WMRaS12cf2Eh/cK9upBB8UfoyQAgJndj
         oEfQ==
X-Gm-Message-State: AC+VfDzAho9mNbJbnS/VruvHTujvvANJpFWVYUOPksow0M9NdxjDOw7R
        pKpYhEJnqmRRNC4Hfxy5alZBJw==
X-Google-Smtp-Source: ACHHUZ7IrFPQw4q1ooChD8KSBhUJhW14oI0ZPD00EolniJ7S6GpF+9CBIyAM2unv/zFTrCh0/X8bwA==
X-Received: by 2002:a05:6808:1143:b0:3a0:333e:1f4a with SMTP id u3-20020a056808114300b003a0333e1f4amr6239433oiu.15.1687294738245;
        Tue, 20 Jun 2023 13:58:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q136-20020a632a8e000000b00553dcfc2179sm1806811pgq.52.2023.06.20.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:58:57 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:58:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202306201356.CF454506@keescook>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
 <20230616000441.3677441-6-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616000441.3677441-6-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 16, 2023 at 02:04:41AM +0200, KP Singh wrote:
> [...]
> @@ -110,6 +110,9 @@ static __initdata struct lsm_info *exclusive;
>  #undef LSM_HOOK
>  #undef DEFINE_LSM_STATIC_CALL
>  
> +#define security_hook_active(n, h) \
> +	static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY, &SECURITY_HOOK_ACTIVE_KEY(h, n))
> +
>  /*
>   * Initialise a table of static calls for each LSM hook.
>   * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
> @@ -816,7 +819,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   */
>  #define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
>  do {									     \
> -	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
> +	if (security_hook_active(NUM, HOOK)) {    			     \
>  		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
>  	}								     \
>  } while (0);
> @@ -828,7 +831,7 @@ do {									     \
>  
>  #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
>  do {									     \
> -	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +	if (security_hook_active(NUM, HOOK)) {    \
>  		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
>  		if (R != 0)						     \
>  			goto LABEL;					     \

I actually think I'd prefer there be no macro wrapping
static_branch_maybe(), just for reading it more easily. i.e. people
reading this code are going to expect the static_branch/static_call code
patterns, and seeing "security_hook_active" only slows them down in
understanding it. I don't think it's _that_ ugly to have it all typed
out. e.g.:

	if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,		     \
				&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)) {	     \
  		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
  		if (R != 0)						     \
  			goto LABEL;					     \



-- 
Kees Cook
