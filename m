Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860F32A5EBB
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Nov 2020 08:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgKDHaY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 4 Nov 2020 02:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgKDHaY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Nov 2020 02:30:24 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9EDC0401C1
        for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2020 23:30:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p15so21914124ljj.8
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2020 23:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6uu6Z6ky+r+rcyvyYgMWjkwNM6+s9AhNr3MRBsZ2/I=;
        b=E0cJ+jHraSDuUh4fuxwuAVZS85upupkHBuQ+SK2D8bgGCXNai8aN2Gx1DXfUyYrKYe
         15jV0d+lyYdbyEynlP2OT9nF+AGcCJxnMVgCfTpJ2E22tZ8mL2Yq6S3cPJcRBwyRCD+2
         jcOdlkYPrH4JIjKEtu3WdGCVBuokcPx9sLTUA2lS757W4EwjchKA+O7fCdw0TscLbsNw
         BjcEUURS3Obhur1p+87jFKfU7h+ArWAmndGBUva9O1ScPU44CR9EGsbpPgeQTT6NdoF/
         ka+ruQgFZMZN1gnKpTSOsoaMLRvha9hW70WjrnHaMTilsU5KFLpt5xcqBYVyEkzLgaHN
         oOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6uu6Z6ky+r+rcyvyYgMWjkwNM6+s9AhNr3MRBsZ2/I=;
        b=RMRcsyS7F+/PX8+zZ4c12mQfv/cVl9H+l6nJ3tSe2Vi0Gk1E03Uc7ldbbs2BJ5H1Yn
         D6drxw3ORGhsLfBbn4ALQN2c9BMhjhmFCpYSy9xu1OYdylFukwWY+yabS+aikLt+jQOY
         MPh3Ty6+iq3myC+sg8KEv18yJW7Nnp6+lUwcE2auEt8LjeO5WJobhx6P4rJbG/Y6T+1a
         ffkNsVN8jNteCDsfwSl8qHg9O0+aMb7PZRs3klfFx4OmEdGJzLXa1vqRvz7ElVwDnzAN
         v+v7j/YAlUox6YdBWX2Z6qtk1dwm9DSw3qqOXmG9fUdbM7eX0eg+wlW2yaVLRsR32ckl
         0mLg==
X-Gm-Message-State: AOAM533fEvopWAZITl0vkpEHxR4SVgsAu/XIKS1zSE4xihF1noRjKoA2
        DFYBzELGFs0ZvUBSy5nvEsDpYldeWff6YhzHVWY34g==
X-Google-Smtp-Source: ABdhPJxPLFvtPAZKjP0KSXg/0Hp4jnUOjD2KoCamdiXt23wmGWgA2J27FJCT/vGIN5+FCSQU7R9JNMK9IRnGHmonGpY=
X-Received: by 2002:a2e:984e:: with SMTP id e14mr1714875ljj.110.1604475020891;
 Tue, 03 Nov 2020 23:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20201013025156.111305-1-jarkko.sakkinen@linux.intel.com> <20201104011909.GD20387@kernel.org>
In-Reply-To: <20201104011909.GD20387@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 4 Nov 2020 13:00:09 +0530
Message-ID: <CAFA6WYO4HJThYHhBxbx0Tr97sF_JFvTBur9uTGSQTtyQaOKpig@mail.gmail.com>
Subject: Re: [PATCH v4 3/3,RESEND 2] KEYS: trusted: Reserve TPM for seal and
 unseal operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        stable <stable@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jarkko,

On Wed, 4 Nov 2020 at 06:49, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> When TPM 2.0 trusted keys code was moved to the trusted keys subsystem,
> the operations were unwrapped from tpm_try_get_ops() and tpm_put_ops(),
> which are used to take temporarily the ownership of the TPM chip. The
> ownership is only taken inside tpm_send(), but this is not sufficient,
> as in the key load TPM2_CC_LOAD, TPM2_CC_UNSEAL and TPM2_FLUSH_CONTEXT
> need to be done as a one single atom.
>
> Fix this issue by introducting trusted_tpm_load() and trusted_tpm_new(),
> which wrap these operations, and take the TPM chip ownership before
> sending anything.

I am not sure if we really need these new APIs in order to fix this
issue, see below.

> Use tpm_transmit_cmd() to send TPM commands instead
> of tpm_send(), reverting back to the old behaviour.
>
> Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")
> Reported-by: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: stable@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/char/tpm/tpm.h                    |  4 --
>  include/linux/tpm.h                       |  5 +-
>  security/keys/trusted-keys/trusted_tpm1.c | 78 +++++++++++++++--------
>  security/keys/trusted-keys/trusted_tpm2.c |  6 +-
>  4 files changed, 60 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..283f78211c3a 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -164,8 +164,6 @@ extern const struct file_operations tpmrm_fops;
>  extern struct idr dev_nums_idr;
>
>  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
> -ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
> -                        size_t min_rsp_body_length, const char *desc);
>  int tpm_get_timeouts(struct tpm_chip *);
>  int tpm_auto_startup(struct tpm_chip *chip);
>
> @@ -194,8 +192,6 @@ static inline void tpm_msleep(unsigned int delay_msec)
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
>  struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> -__must_check int tpm_try_get_ops(struct tpm_chip *chip);
> -void tpm_put_ops(struct tpm_chip *chip);
>
>  struct tpm_chip *tpm_chip_alloc(struct device *dev,
>                                 const struct tpm_class_ops *ops);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8f4ff39f51e7..804a3f69bbd9 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -397,6 +397,10 @@ static inline u32 tpm2_rc_value(u32 rc)
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
> +extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
> +extern void tpm_put_ops(struct tpm_chip *chip);
> +extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
> +                               size_t min_rsp_body_length, const char *desc);
>  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>                         struct tpm_digest *digest);
>  extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> @@ -410,7 +414,6 @@ static inline int tpm_is_tpm2(struct tpm_chip *chip)
>  {
>         return -ENODEV;
>  }
> -
>  static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
>                                struct tpm_digest *digest)
>  {
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 7a937c3c5283..20ca18e17437 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -950,6 +950,51 @@ static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
>         return p;
>  }
>
> +static int trusted_tpm_load(struct tpm_chip *chip,
> +                           struct trusted_key_payload *payload,
> +                           struct trusted_key_options *options)
> +{
> +       int ret;
> +
> +       if (tpm_is_tpm2(chip)) {
> +               ret = tpm_try_get_ops(chip);

Can't we move this TPM 2.0 specific operation within
tpm2_unseal_trusted() instead?

> +               if (!ret) {
> +                       ret = tpm2_unseal_trusted(chip, payload, options);
> +                       tpm_put_ops(chip);

Ditto.

> +               }
> +       } else {
> +               ret = key_unseal(payload, options);
> +       }
> +
> +       return ret;
> +}
> +
> +static int trusted_tpm_new(struct tpm_chip *chip,
> +                          struct trusted_key_payload *payload,
> +                          struct trusted_key_options *options)
> +{
> +       int ret;
> +
> +       ret = tpm_get_random(chip, payload->key, payload->key_len);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret != payload->key_len)
> +               return -EIO;
> +
> +       if (tpm_is_tpm2(chip)) {
> +               ret = tpm_try_get_ops(chip);

Same here, to move this within tpm2_seal_trusted() instead?

> +               if (!ret) {
> +                       ret = tpm2_seal_trusted(chip, payload, options);
> +                       tpm_put_ops(chip);

Ditto.

-Sumit

> +               }
> +       } else {
> +               ret = key_seal(payload, options);
> +       }
> +
> +       return ret;
> +}
> +
>  /*
>   * trusted_instantiate - create a new trusted key
>   *
> @@ -968,12 +1013,6 @@ static int trusted_instantiate(struct key *key,
>         char *datablob;
>         int ret = 0;
>         int key_cmd;
> -       size_t key_len;
> -       int tpm2;
> -
> -       tpm2 = tpm_is_tpm2(chip);
> -       if (tpm2 < 0)
> -               return tpm2;
>
>         if (datalen <= 0 || datalen > 32767 || !prep->data)
>                 return -EINVAL;
> @@ -1011,32 +1050,21 @@ static int trusted_instantiate(struct key *key,
>
>         switch (key_cmd) {
>         case Opt_load:
> -               if (tpm2)
> -                       ret = tpm2_unseal_trusted(chip, payload, options);
> -               else
> -                       ret = key_unseal(payload, options);
> +               ret = trusted_tpm_load(chip, payload, options);
> +
>                 dump_payload(payload);
>                 dump_options(options);
> +
>                 if (ret < 0)
> -                       pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> +                       pr_info("%s: load failed (%d)\n", __func__, ret);
> +
>                 break;
>         case Opt_new:
> -               key_len = payload->key_len;
> -               ret = tpm_get_random(chip, payload->key, key_len);
> -               if (ret < 0)
> -                       goto out;
> +               ret = trusted_tpm_new(chip, payload, options);
>
> -               if (ret != key_len) {
> -                       pr_info("trusted_key: key_create failed (%d)\n", ret);
> -                       ret = -EIO;
> -                       goto out;
> -               }
> -               if (tpm2)
> -                       ret = tpm2_seal_trusted(chip, payload, options);
> -               else
> -                       ret = key_seal(payload, options);
>                 if (ret < 0)
> -                       pr_info("trusted_key: key_seal failed (%d)\n", ret);
> +                       pr_info("%s: new failed (%d)\n", __func__, ret);
> +
>                 break;
>         default:
>                 ret = -EINVAL;
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 08ec7f48f01d..effdb67fac6d 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -130,7 +130,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>                 goto out;
>         }
>
> -       rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +       rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
>         if (rc)
>                 goto out;
>
> @@ -211,7 +211,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>                 goto out;
>         }
>
> -       rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +       rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
>         if (!rc)
>                 *blob_handle = be32_to_cpup(
>                         (__be32 *) &buf.data[TPM_HEADER_SIZE]);
> @@ -260,7 +260,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>                              options->blobauth /* hmac */,
>                              TPM_DIGEST_SIZE);
>
> -       rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +       rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
>         if (rc > 0)
>                 rc = -EPERM;
>
> --
> 2.25.1
>
