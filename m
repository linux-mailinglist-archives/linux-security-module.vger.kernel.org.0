Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69836708674
	for <lists+linux-security-module@lfdr.de>; Thu, 18 May 2023 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjERRMK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 May 2023 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjERRMH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 May 2023 13:12:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A24CE
        for <linux-security-module@vger.kernel.org>; Thu, 18 May 2023 10:12:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-759413d99afso744521685a.1
        for <linux-security-module@vger.kernel.org>; Thu, 18 May 2023 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684429920; x=1687021920;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cecl9/VHNrUpwV+RdOSr5dFrFgITmiZdkzQ3/+k+0yQ=;
        b=a2ydk4ldMY3LUl/eE5ctuLgxGkcOXHpcEF1REqj9U4oziCWpBY7+M1vl0aAg3jH8fD
         Eh1j2EKiYtpxeu4ZuwGEJRyWSb8rVw3GkQtuSsnxjYE24+z5ChkSv3wZJLfgNGw0j18E
         ktmjgCXabZREwUYoe7Gv5/MOihuM2iCS8awmKQPm/hZfXx1jW6Ws6KUYCsO0+3A8bfPV
         mC4nwI8ApCqRevArqH7TLyOEMH/ILfHRICm0MD+qkRiCOSUpmipB2ajOA75f2KCVto8r
         gH0OV0GJS+ksdWhZnnhvHGwj4IMBNrJCDeHg1FyxTWcuUbVXWeEzkh6FLvCVXOgUORAx
         nkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684429920; x=1687021920;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cecl9/VHNrUpwV+RdOSr5dFrFgITmiZdkzQ3/+k+0yQ=;
        b=PQZTDUsRJNBaxngxD2JULcPU/Pu6N+TZ5YuRCPstwl9OtNyp9MQmhYm87hYJFc/Vkj
         /H/GRtuqv2ApxpSHutkhcAP/rJ3R8mS/+GDKpO79xOQvBovVSRCqydpDvoVoQRMFGg9i
         6+QRC0opYZNH30tvXlfZ+W1D2SEjR91g0tPI9Io1QuTEO9B/M16FFYp8fS/A7gnbx34I
         gM+76HPyL+H0o2bvrcSCzZ0r6NK4aW2487GCztL7VP6ML0ARYYjMZTdxua0vDZoWuvVN
         BsQH9QcMqYEdg4cTO/MrckhkR7sr02Nqyvw6ERdWsFH5XxMEZThE5PbnsV0oMDAwpHgJ
         Wq2w==
X-Gm-Message-State: AC+VfDyG6hWGMc09YeQNaS653nYVNQ51qvF1fczqKiN6+NamuPmOP8m6
        05ps6JJDlimulQNacNMPYzO4
X-Google-Smtp-Source: ACHHUZ4LsTB7q1F+LkU0VgKhIPV1d/23LQEAnPXa/KV2SBxXXGd78bsDIwfWZ/R5mwTiYrkpganOsg==
X-Received: by 2002:ad4:5be5:0:b0:621:6804:b8c0 with SMTP id k5-20020ad45be5000000b006216804b8c0mr202874qvc.8.1684429920194;
        Thu, 18 May 2023 10:12:00 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id ep10-20020a05621418ea00b0062162d2c0d5sm648447qvb.68.2023.05.18.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:11:59 -0700 (PDT)
Date:   Thu, 18 May 2023 13:11:58 -0400
Message-ID: <2a3b77fc369dd3b3e611db00c992060d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 1/2] security, lsm: Introduce  security_mptcp_add_subflow()
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-1-e7a3c8c15676@tessares.net>
In-Reply-To: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-1-e7a3c8c15676@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Apr 20, 2023 Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> 
> MPTCP can create subflows in kernel context, and later indirectly
> expose them to user-space, via the owning MPTCP socket.
> 
> As discussed in the reported link, the above causes unexpected failures
> for server, MPTCP-enabled applications.
> 
> Let's introduce a new LSM hook to allow the security module to relabel
> the subflow according to the owning user-space process, via the MPTCP
> socket owning the subflow.
> 
> Note that the new hook requires both the MPTCP socket and the new
> subflow. This could allow future extensions, e.g. explicitly validating
> the MPTCP <-> subflow linkage.
> 
> Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> v2:
>  - Address Paul's comments:
>    - clarification around "the owning process" in the commit message
>    - making it clear the hook has to be called after the sk init part
>    - consistent capitalization of "MPTCP"
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/mptcp/subflow.c           |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 30 insertions(+)

This looks good to me, merged into selinux/next - thank you for all
the work that went into this!

--
paul-moore.com
