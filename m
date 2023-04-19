Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8DF6E83C1
	for <lists+linux-security-module@lfdr.de>; Wed, 19 Apr 2023 23:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjDSVad (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Apr 2023 17:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjDSVac (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Apr 2023 17:30:32 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6876BD
        for <linux-security-module@vger.kernel.org>; Wed, 19 Apr 2023 14:30:30 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id t15so879495ybb.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Apr 2023 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681939829; x=1684531829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQu0mN/FgD6XFymkM6bnNZhxdrbRxxLlBGzvH5ZIfR4=;
        b=b/FfQZsCRJa6do1l6J7aORvknuMn8CTcVm6qMfuSiMTMpWJrE7xYxuJ+Wvz8th6e7N
         oeBlv+DHmD9GcpbKuZfRfiDBbsi+Nke1V4pDBSGPji7J5S1B4z1V7aIAsEngBkoNmyA0
         spJWoJ6KCvrO7FeQJj1T2sdsnoxUvzE0WFoShZxTyoAeN2lT2u95lDWDHJdmBmdtT6Ax
         tfBk2WWdQG7oSyLWiR0UjaLw4yHvdiB1dxmQ1luYYRdn61GjOVzzTVSccleFyqTh6P6N
         d1iaGxWwlMXIn1xwXGk4KQlvxbZ+XwEa2MVZbOkK6Fcx6/myhwmjAZKEqpDaqM47WB1i
         KGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939829; x=1684531829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQu0mN/FgD6XFymkM6bnNZhxdrbRxxLlBGzvH5ZIfR4=;
        b=afNJXGMG3DgM9RFaMjiWScsgVELwF7EIxajSGdieymIiKHO9A4K2WeJtYl6dlssEsZ
         +3pH27uabq9YRWPdmEt35D6Hk8ALRvkgbA0PzEGbbJlZzPAXFM/438lkZU5hIlH5qAJn
         hOBGKhrCNHTc3Zai1BGyk2F8o39NadrwiP0S1LSlvLCi1DZFc4YL/9FwWYg+Lz62SWTi
         LLCOHePveanXCokdFHlT609yeL/EnLnyxeIQU0cQ5vetfLSvZpQullrfVKqCp71hYL67
         fP10sBerWnyhAPAHJk/duHX9YDoztuH0/f+UagWr/4wJGFCnc4n7qhEvttPSM8JoBnMx
         Xkhg==
X-Gm-Message-State: AAQBX9fd5CnvDwXeiy5ZudOXxgIZgAKs4koTZh1xsq1QCmvNUFBc4koH
        Y3I9tCoUaOIVRGITn5odlXWo/l/NsnZF8R6FxTZF
X-Google-Smtp-Source: AKy350a7nHcqYyWU4VZcvtBsSLeV6EvDSxEIgfjTR8AbKaviQKyh8+I7NGxVtMaW2OKcydp+tf/BcO8TIBQ8eQZpif0=
X-Received: by 2002:a25:ac23:0:b0:b8f:5196:3c8f with SMTP id
 w35-20020a25ac23000000b00b8f51963c8fmr1085621ybi.28.1681939829245; Wed, 19
 Apr 2023 14:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net>
 <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v1-1-9d4064cb0075@tessares.net>
In-Reply-To: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v1-1-9d4064cb0075@tessares.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Apr 2023 17:30:18 -0400
Message-ID: <CAHC9VhQsbSO5o+hVT-Tae-HyWMTjh2ffqQvz+pQQXkrMty7NYQ@mail.gmail.com>
Subject: Re: [PATCH LSM 1/2] security, lsm: Introduce security_mptcp_add_subflow()
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 19, 2023 at 1:44=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> MPTCP can create subflows in kernel context, and later indirectly
> expose them to user-space, via the owning mptcp socket.
>
> As discussed in the reported link, the above causes unexpected failures
> for server, MPTCP-enabled applications.
>
> Let's introduce a new LSM hook to allow the security module to relabel
> the subflow according to the owing process.

"... according to the main MPTCP socket."

You might also want to stick with a consistent capitalization of
"MPTCP" in the commit description, but that is being *really* nitpicky
on my part ;)

There is a suggestion for some additional comments in the hook's
description below, but otherwise this looks good to me.

> Note that the new hook requires both the mptcp socket and the new
> subflow. This could allow future extensions, e.g. explicitly validating
> the mptcp <-> subflow linkage.
>
> Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=3DP1e3rixEDqbRTFj2=
2bpya=3D+qJqfcaMfg@mail.gmail.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/mptcp/subflow.c           |  6 ++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 28 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index f4170efcddda..24cf2644a4b9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4667,6 +4667,21 @@ int security_sctp_assoc_established(struct sctp_as=
sociation *asoc,
>  }
>  EXPORT_SYMBOL(security_sctp_assoc_established);
>
> +/**
> + * security_mptcp_add_subflow() - Inherit the LSM label from the MPTCP s=
ocket
> + * @sk: the owning MPTCP socket
> + * @ssk: the new subflow
> + *
> + * Update the labeling for the given MPTCP subflow, to match the one of =
the
> + * owning MPTCP socket.

I would add a sentence at the end making it clear that this hook is
called after the socket has been created and initialized via the
security_socket_create() and security_socket_post_create() LSM hooks.

> + *
> + * Return: Returns 0 on success or a negative error code on failure.
> + */
> +int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> +{
> +       return call_int_hook(mptcp_add_subflow, 0, sk, ssk);
> +}
> +
>  #endif /* CONFIG_SECURITY_NETWORK */
>
>  #ifdef CONFIG_SECURITY_INFINIBAND
>
> --
> 2.39.2

--
paul-moore.com
