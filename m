Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E947DEDB1
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Nov 2023 08:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjKBHws (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Nov 2023 03:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHwr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Nov 2023 03:52:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B64FE7;
        Thu,  2 Nov 2023 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698911561; x=1730447561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W29RWQS2NwYdEJqUIzKH/e4ox+Bt+9jFKK7JYm4Uf64=;
  b=RdStwYVl2CrzCl8gZE8WsBHUsoE+Y5QXqdVaJ6Sp7BruHd2l8QGDH6oD
   eUykdCK13U3EgNf3H3Ya8HbdI9Cx4KFND5MP8Iv+BiQwZ9i+9YrtJBJSY
   x8W7JzFawv4A4jasoO5j64T9S3z+moeEU+EhXy0SDMDu5SUdStLdyY/ms
   DKKSos5z4/Yrxu5qTrvTlK2ovY4NMcuvCnWkVRTC48Diqw53tiMvwNbrB
   K5c+M1iOeQpiRz5CQTXuEQHu5nHEHNDaQF5iqX3VPzWsySUsmBcfEwdOu
   gZFF2tIIN7weRyESS2T8TgwLPZn9cXrvbYZKrJDL26h4RH4Es3s0ggK3Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="474898008"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="474898008"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 00:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="761210778"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="761210778"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2023 00:52:37 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qySVH-0001Dw-0P;
        Thu, 02 Nov 2023 07:52:35 +0000
Date:   Thu, 2 Nov 2023 15:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
        keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org,
        renauld@google.com, pabeni@redhat.com
Subject: Re: [PATCH v7 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202311021532.iBwuZUZ0-lkp@intel.com>
References: <20231102005521.346983-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102005521.346983-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231101]
[cannot apply to bpf-next/master bpf/master pcmoore-selinux/next linus/master v6.6 v6.6-rc7 v6.6-rc6 v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20231102-085857
base:   next-20231101
patch link:    https://lore.kernel.org/r/20231102005521.346983-4-kpsingh%40kernel.org
patch subject: [PATCH v7 3/5] security: Replace indirect LSM hook calls with static calls
config: x86_64-randconfig-013-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021532.iBwuZUZ0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021532.iBwuZUZ0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021532.iBwuZUZ0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/security.c:157:1: error: Only string constants are supported as initializers for randomized structures with flexible arrays
     157 | };
         | ^


vim +157 security/security.c

   136	
   137	/*
   138	 * Initialise a table of static calls for each LSM hook.
   139	 * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
   140	 * and a trampoline (STATIC_CALL_TRAMP) which are used to call
   141	 * __static_call_update when updating the static call.
   142	 */
   143	struct lsm_static_calls_table static_calls_table __ro_after_init = {
   144	#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
   145		(struct lsm_static_call) {					\
   146			.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
   147			.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
   148			.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
   149		},
   150	#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
   151		.NAME = {							\
   152			LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
   153		},
   154	#include <linux/lsm_hook_defs.h>
   155	#undef LSM_HOOK
   156	#undef INIT_LSM_STATIC_CALL
 > 157	};
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
