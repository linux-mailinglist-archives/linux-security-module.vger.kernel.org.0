Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BDB362005
	for <lists+linux-security-module@lfdr.de>; Fri, 16 Apr 2021 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhDPMnI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 16 Apr 2021 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbhDPMnI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 08:43:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A0C061760
        for <linux-security-module@vger.kernel.org>; Fri, 16 Apr 2021 05:42:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r22so20203539ljc.5
        for <linux-security-module@vger.kernel.org>; Fri, 16 Apr 2021 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSvAjT7fJoqP/gXy5cezTHjGsp7EVSxfqA5TLEclTpE=;
        b=N2R8BSwyq6L8HhG5VF4U5Z8XYGGb6pNZoJAMJ/1ur+kAdwX70KKdhm9t/ER//BaaGC
         fC4yv1tQxMxfYFuoTo68rLF2UuyW3JekVhz9+xQTJG4RX1Wt0FDpW6dQvwTKDH8OM8Zz
         XAo0SRVp1WoY1+uTX8CCAhHkBip3hAiwW/z33RlDq4grtd4yD6iC5gCsYfE3/YttwM74
         9ESseF9WStozPeMahssUKibfjLnzyh0IYD2MntIGJfmz/2Q41q3iwDSPRZEbSLBVmSor
         LIkZIbmEOSH4ZRpgTXu6gbMHD7g9CJ48nYg3M1i/vvv2u+k7s9/zlK1edCwq5oRehlTe
         3GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSvAjT7fJoqP/gXy5cezTHjGsp7EVSxfqA5TLEclTpE=;
        b=N2NF9wbB+vP2DxGPJgGC1lI69j5d6fpgx8cc5T5Py3N3U+saMqfD1C0Vt6nVLP4NKm
         SohX8iuJLoVy9OnIgIggqcKsDtpQeIsnRWBKJ4Wlii033KVKE18ePSTO0tJZEdwtwnKg
         Ma7fMNpBVKXPm/qX/z1z+SiHPslmclpWOfl3ShE7u6UMRzReMKIcwgorwNl9h3rkkrOn
         G8flZS8KKzeza2bvkthPhM+JrFLFAH++OFxzj6rdxOsZJuTCAzPGfbZMBs2Vgoe+YExj
         vB56aDSX2F9n7PAhSmHf6Br+gP54F8q2ojyGz7WS/prsSEUoPQ6iZSSq8KznjKn3sQ8W
         3uqQ==
X-Gm-Message-State: AOAM533TDmV+PLztNSW10zRAkzyfBb9Qiu2LYWzRreTIQ3o/1458xgdU
        OWPmkuLreLRY0BxBW5LGkqX2Ue7+HtdNlbHZdj+Omw==
X-Google-Smtp-Source: ABdhPJxpPsOb5Vn7O+jFE45i/Oi8eyCRoGdm3iVzaaI0n2gDmIuJE5RiWb1Ekfzr6QRG9wCTQ7AnfakUvrfliDClOow=
X-Received: by 2002:a2e:7607:: with SMTP id r7mr2559286ljc.226.1618576961144;
 Fri, 16 Apr 2021 05:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <YHaG+p5nlOXQFp1n@mwanda>
In-Reply-To: <YHaG+p5nlOXQFp1n@mwanda>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 16 Apr 2021 18:12:29 +0530
Message-ID: <CAFA6WYMpeX=j3tk2edBs_kQNKmL0Kjp32kY0O-SshAX9V6OYiw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix a couple error pointer dereferences
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Dan,

On Wed, 14 Apr 2021 at 11:39, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If registering "reg_shm_out" fails, then it is an error pointer and the
> error handling will call tee_shm_free(reg_shm_out) which leads to an
> error pointer dereference and an Oops.
>
> I've re-arranged it so we only free things that have been allocated
> successfully.
>
> Fixes: 6dd95e650c8a ("KEYS: trusted: Introduce TEE based Trusted Keys")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>

Thanks for fixing the error path. Although an alternative simple fix
could be [1] but I liked your approach to get rid of redundant "if"
checks. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

[1]

diff --git a/security/keys/trusted-keys/trusted_tee.c
b/security/keys/trusted-keys/trusted_tee.c
index 2ce66c199e1d..c4a54b0fa3eb 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -84,6 +84,7 @@ static int trusted_tee_seal(struct
trusted_key_payload *p, char *datablob)
        if (IS_ERR(reg_shm_out)) {
                dev_err(pvt_data.dev, "blob shm register failed\n");
                ret = PTR_ERR(reg_shm_out);
+               reg_shm_out = NULL;
                goto out;
        }

@@ -145,6 +146,7 @@ static int trusted_tee_unseal(struct
trusted_key_payload *p, char *datablob)
        if (IS_ERR(reg_shm_out)) {
                dev_err(pvt_data.dev, "key shm register failed\n");
                ret = PTR_ERR(reg_shm_out);
+               reg_shm_out = NULL;
                goto out;
        }

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index 2ce66c199e1d..45f96f6ed673 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -65,7 +65,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>         int ret;
>         struct tee_ioctl_invoke_arg inv_arg;
>         struct tee_param param[4];
> -       struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +       struct tee_shm *reg_shm_in, *reg_shm_out;
>
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
> @@ -84,7 +84,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>         if (IS_ERR(reg_shm_out)) {
>                 dev_err(pvt_data.dev, "blob shm register failed\n");
>                 ret = PTR_ERR(reg_shm_out);
> -               goto out;
> +               goto free_shm_in;
>         }
>
>         inv_arg.func = TA_CMD_SEAL;
> @@ -109,11 +109,9 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>                 p->blob_len = param[1].u.memref.size;
>         }
>
> -out:
> -       if (reg_shm_out)
> -               tee_shm_free(reg_shm_out);
> -       if (reg_shm_in)
> -               tee_shm_free(reg_shm_in);
> +       tee_shm_free(reg_shm_out);
> +free_shm_in:
> +       tee_shm_free(reg_shm_in);
>
>         return ret;
>  }
> @@ -126,7 +124,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>         int ret;
>         struct tee_ioctl_invoke_arg inv_arg;
>         struct tee_param param[4];
> -       struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +       struct tee_shm *reg_shm_in, *reg_shm_out;
>
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
> @@ -145,7 +143,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>         if (IS_ERR(reg_shm_out)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 ret = PTR_ERR(reg_shm_out);
> -               goto out;
> +               goto free_shm_in;
>         }
>
>         inv_arg.func = TA_CMD_UNSEAL;
> @@ -170,11 +168,9 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>                 p->key_len = param[1].u.memref.size;
>         }
>
> -out:
> -       if (reg_shm_out)
> -               tee_shm_free(reg_shm_out);
> -       if (reg_shm_in)
> -               tee_shm_free(reg_shm_in);
> +       tee_shm_free(reg_shm_out);
> +free_shm_in:
> +       tee_shm_free(reg_shm_in);
>
>         return ret;
>  }
> --
> 2.30.2
>
