Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659967EDABB
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Nov 2023 05:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjKPEdy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 15 Nov 2023 23:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjKPEdx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Nov 2023 23:33:53 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B419D
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 20:33:49 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77784edc2edso20792185a.1
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 20:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109228; x=1700714028; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bndky/isFZdPv4y+9HMU+8QO0OsZEFaDO/mxDCye0C0=;
        b=Be2nyhJV8JByTCu9BsElBdGHDrrhMuIfyJI/dW5Ptt4EUKql5kjRdkX35r7Ph+ocBB
         /LY1ZvqLo1a6v3v/Mji8zsoeKxpSQeJaWYTwmZTLARnwOL+UqNKskMYW81yULkInncEW
         y/PVI9i7A2a/GmitESvrxjUERfNuMYi4JjrntU7AwykluwNteWHkgFBBJsCpSOCPMjbE
         Wy9K70Nl1QZaIPNNbUGKu4zdspq8PzlFWKrViqaq3xAsJ7X5SePmlVcXHUWZl176RH3U
         JEEv8/hCNT7+uizusuOj0/z6OHBcVfKgfMlYBpnKTxfuQO8eXa/2j+IP9b+ViTfn8PHX
         NsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109228; x=1700714028;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bndky/isFZdPv4y+9HMU+8QO0OsZEFaDO/mxDCye0C0=;
        b=FUtEFaiMzEf2u+eOSwXbKiW3Bku6yTQg4IAclCMaTxpe0+pTwC7rmb8xt7tiff7iGz
         BOSUWbHrM9LufPtQbFDM734v6vmUM759KwlTxumuSWGAGz8iOPiyEUMxFlw+nve1e5VT
         EoXhWNP4xCYsfwvbQSeIEnU9wEHd/VMn5q9pkYwVlX9J8/+tPVxHm0z4ogYNrM3QbeNG
         MWvcYdB2H5PZV1+o2SaCNd7tvuaZS1tSxphYLHTmx/gZISQLL6KhpCvPd5eE3QQhCP9E
         gE2sLqkOlc0NWyVTeZzvtd7RzbhkP0PzBA2bXypRA3GOi4wGZhi0RYPLmYvp3Bx7lchD
         PbWg==
X-Gm-Message-State: AOJu0YzAdVspROqopsWUNZ+bT8ab9Cmo5AujAiQQTV/PPMWha8IujhXR
        7FDvgmJA8sDEntiubPPwb8EH
X-Google-Smtp-Source: AGHT+IGCdgvNrhLjs0RBnM3O7h6Ri70uA7en86HSqfGY/HAxnYl36rBdMYafIeqWPJt4yM0F6QD9XA==
X-Received: by 2002:a05:620a:4156:b0:775:cf5f:8a57 with SMTP id k22-20020a05620a415600b00775cf5f8a57mr8673614qko.7.1700109228335;
        Wed, 15 Nov 2023 20:33:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a005a00b0077263636a95sm4006757qkt.93.2023.11.15.20.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:47 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:47 -0500
Message-ID: <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
References: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_pre_free_security hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> LSMs could also take some action before the last reference of a file is
> released.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..64ed74555e64 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -385,6 +385,7 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> +	security_file_pre_free(file);

I worry that security_file_pre_free() is a misleading name as "free"
tends to imply memory management tasks, which isn't the main focus of
this hook.  What do you think of security_file_release() or
security_file_put() instead?

>  	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)

--
paul-moore.com
