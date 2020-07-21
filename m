Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA71228B90
	for <lists+linux-security-module@lfdr.de>; Tue, 21 Jul 2020 23:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgGUVnT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 21 Jul 2020 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgGUVnS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Jul 2020 17:43:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84400C0619DB
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2020 14:43:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so3040219wmm.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2020 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xi0hCpRkmcf6gK8tASFxK3aaOMPZtOr07eR1uGQZQ3Q=;
        b=WyitzgLCPTotTvFyXBjJCUBLv9LTVIGuV0BLXP/t+rNxyFRvxJQhiYjVQxrxFWakWu
         49H70+HEYP6PnW9KhlJ465HMbNOR6C7Be16Ag+Ttve3BCJ0H/uLHpyc9JTOy696ifuKV
         FDhgso1RDz81jzni2fNhhGBmN+KDfYXTEOgY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xi0hCpRkmcf6gK8tASFxK3aaOMPZtOr07eR1uGQZQ3Q=;
        b=kDf7jv9NRtcAw4SdXEWgv9xnfmmka7faSgdvvzqmwzA5C6JZbS1d9+DxrZx9obncyz
         A/7arIfc4F0WFlgcXquq6CLbETYdk7jmaRj2/EN+jRpeT5hmbiCOFBQiIHDZDwueg6y3
         RTMemlRZ25dhfWE1qEb2diVzDCEcQ5Uu9jtz6b4HNw4nbEhHi8D3r7uN0/5zSRlKz7Sz
         QlZEK9XWqMugPwC8U4Zm+hxZqT75eXabBsc3p20fE/8ZR0fAeawRPX6kE0g6nqAVnq3I
         n64MTz//0xHqOVk7csWIwUyT2xaJvyXJokvJhDD/kF7J4fTLVD9HI6Lxxnv78oAvaLYe
         o5Yw==
X-Gm-Message-State: AOAM5319SfiZmhXzTD5Ej0uaiGVItwCvRA7EHoSrPYbipZCoZ6XepODs
        G2nvmCn9SNWKSoc+wMz1234doQ==
X-Google-Smtp-Source: ABdhPJylo9oBD0Nkc2IZhuODZGWhVfU7dT9PhCcECwJI5ehMiPxyWlzltkQd49Y0rX47zJzR6OdmzA==
X-Received: by 2002:a1c:2402:: with SMTP id k2mr5758664wmk.138.1595367797160;
        Tue, 21 Jul 2020 14:43:17 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y11sm23591601wrs.80.2020.07.21.14.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:43:16 -0700 (PDT)
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <ec326654-c43b-259c-409c-63929ad5b217@broadcom.com>
Date:   Tue, 21 Jul 2020 14:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-7-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

On 2020-07-17 10:43 a.m., Kees Cook wrote:
> In preparation for refactoring kernel_read_file*(), remove the redundant
> "size" argument which is not needed: it can be included in the return
> code, with callers adjusted. (VFS reads already cannot be larger than
> INT_MAX.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/base/firmware_loader/main.c |  8 ++++----
>   fs/kernel_read_file.c               | 20 +++++++++-----------
>   include/linux/kernel_read_file.h    |  8 ++++----
>   kernel/kexec_file.c                 | 13 ++++++-------
>   kernel/module.c                     |  7 +++----
>   security/integrity/digsig.c         |  5 +++--
>   security/integrity/ima/ima_fs.c     |  5 +++--
>   7 files changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index d4a413ea48ce..ea419c7d3d34 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -462,7 +462,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   					     size_t in_size,
>   					     const void *in_buffer))
>   {
> -	loff_t size;
> +	size_t size;
>   	int i, len;
>   	int rc = -ENOENT;
>   	char *path;
> @@ -494,10 +494,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   		fw_priv->size = 0;
>   
>   		/* load firmware files from the mount namespace of init */
> -		rc = kernel_read_file_from_path_initns(path, &buffer,
> -						       &size, msize,
> +		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
>   						       READING_FIRMWARE);
> -		if (rc) {
> +		if (rc < 0) {
>   			if (rc != -ENOENT)
>   				dev_warn(device, "loading %s failed with error %d\n",
>   					 path, rc);
> @@ -506,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   					 path);
>   			continue;
>   		}
> +		size = rc;
Change fails to return 0.  Need rc = 0; here.
>   		dev_dbg(device, "Loading firmware from %s\n", path);
>   		if (decompress) {
>   			dev_dbg(device, "f/w decompressing %s\n",
>

