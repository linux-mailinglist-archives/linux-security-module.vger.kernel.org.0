Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116F7B43A3
	for <lists+linux-security-module@lfdr.de>; Sat, 30 Sep 2023 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjI3UkV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 30 Sep 2023 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3UkU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 30 Sep 2023 16:40:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCEC4
        for <linux-security-module@vger.kernel.org>; Sat, 30 Sep 2023 13:40:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso13325842b3a.0
        for <linux-security-module@vger.kernel.org>; Sat, 30 Sep 2023 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696106418; x=1696711218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fXBByQPl8KY7eiFEi5g6L19V9juEXVrdMizugwt5T4=;
        b=UCapHfXuAQofwKnuRppIQtd8zlMH0w/4XEYYCviKk7tevL8rzYJ9Wgt/QqjQ9tcSP1
         G2jv1WU/OvcHrYjdNfxTrpCxKlTxDHjyRS0FhCt6LkteUtHeCaE0II0nxdGesZq3ZpE2
         +eUpzxfCVrpwuft3reOSlho+coG7y4SaxUO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696106418; x=1696711218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fXBByQPl8KY7eiFEi5g6L19V9juEXVrdMizugwt5T4=;
        b=WA3KLrrQZKKLHVZF51+hug24eU5cetAz/O3gc7d2MCRnlct2/PEgLsB40WBh5AzQ3C
         i44N0vGWmv3gAYYSu0KgVayrhhRQHMQrIvMw/v6YbKI6OPHXLCQ4ofTX3stUYCvHHAP0
         ovZlgIdns1QWbfW2wy+M1r8XJcCZ496Dw+SmqG04NmiuKYmoB8/oWs7kvB8YEHpgI+gs
         xsQtsJjhjELugM1j98F3AZESSOtdByjq914wjDitumWav2iHK87pWrpbuJOHt6ECpamP
         TFL/8wq3tvs5qAZc7fBFJDeWNZ5/0dRk+uXkCKe8O7tow5a7Co6/ceCP/uaIBtDr6DdX
         JlXA==
X-Gm-Message-State: AOJu0YwWJ54+cMH7L59izNAo+FbTuKvBqdNfuIYJeWoRLYp9dOWa829/
        sJUYjo2aJWm8ttzRU9R2sdF4SQ==
X-Google-Smtp-Source: AGHT+IHkTbEpe8NOY7N2PNQrvQoHeBby2OJO5lF43caE809j96ZmiK/fEidsdab5v6MBMYeNGYv2cg==
X-Received: by 2002:a05:6a20:3d85:b0:133:f0b9:856d with SMTP id s5-20020a056a203d8500b00133f0b9856dmr9963086pzi.17.1696106417880;
        Sat, 30 Sep 2023 13:40:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b0068ff6d21563sm17490177pff.148.2023.09.30.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 13:40:17 -0700 (PDT)
Date:   Sat, 30 Sep 2023 13:40:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
        casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202309301339.8196ECC78@keescook>
References: <20230928202410.3765062-4-kpsingh@kernel.org>
 <202309302332.1mxVwb0U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309302332.1mxVwb0U-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Oct 01, 2023 at 12:13:06AM +0800, kernel test robot wrote:
> Hi KP,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> [also build test ERROR on bpf/master pcmoore-selinux/next linus/master v6.6-rc3 next-20230929]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230929-042610
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20230928202410.3765062-4-kpsingh%40kernel.org
> patch subject: [PATCH v5 3/5] security: Replace indirect LSM hook calls with static calls
> config: i386-randconfig-001-20230930 (https://download.01.org/0day-ci/archive/20230930/202309302332.1mxVwb0U-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302332.1mxVwb0U-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309302332.1mxVwb0U-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> security/security.c:139:1: error: Only string constants are supported as initializers for randomized structures with flexible arrays
>      139 | };
>          | ^

Uuh, where is there a flexible array here?

> vim +139 security/security.c
> 
>    118	
>    119	/*
>    120	 * Initialise a table of static calls for each LSM hook.
>    121	 * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
>    122	 * and a trampoline (STATIC_CALL_TRAMP) which are used to call
>    123	 * __static_call_update when updating the static call.
>    124	 */
>    125	struct lsm_static_calls_table static_calls_table __ro_after_init = {
>    126	#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
>    127		(struct lsm_static_call) {					\
>    128			.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
>    129			.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
>    130			.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
>    131		},
>    132	#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
>    133		.NAME = {							\
>    134			LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
>    135		},
>    136	#include <linux/lsm_hook_defs.h>
>    137	#undef LSM_HOOK
>    138	#undef INIT_LSM_STATIC_CALL
>  > 139	};
>    140	

*confused*

-Kees

-- 
Kees Cook
