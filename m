Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AAB362119
	for <lists+linux-security-module@lfdr.de>; Fri, 16 Apr 2021 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhDPNgo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 16 Apr 2021 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbhDPNgn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 09:36:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93293C061574;
        Fri, 16 Apr 2021 06:36:18 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXOdd-005laJ-Hu; Fri, 16 Apr 2021 13:36:01 +0000
Date:   Fri, 16 Apr 2021 13:36:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     =?iso-8859-1?Q?=A0Zhongjun?= Tan <hbut_tan@163.com>
Cc:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongjun Tan <tanzhongjun@yulong.com>
Subject: Re: [PATCH] lsm:fix a missing-check bug in smack_sb_eat_lsm_opts()
Message-ID: <YHmSwVpR2oq2yqUG@zeniv-ca.linux.org.uk>
References: <20210416095303.530-1-hbut_tan@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416095303.530-1-hbut_tan@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 16, 2021 at 05:53:03PM +0800,  Zhongjun Tan wrote:

> @@ -710,13 +711,14 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  		token = match_opt_prefix(from, len, &arg);
>  		if (token != Opt_error) {
>  			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
> +			if (!arg) {
> +				rc = -ENOMEM;
> +				goto free_mnt_opts;
>  			rc = smack_add_opt(token, arg, mnt_opts);

			if (arg)
	  			rc = smack_add_opt(token, arg, mnt_opts);
			else
				rc = -ENOMEM;

and no other changes are needed anywhere...
