Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB060504AB6
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Apr 2022 03:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiDRB4Y (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 17 Apr 2022 21:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiDRB4X (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Apr 2022 21:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14707183A6
        for <linux-security-module@vger.kernel.org>; Sun, 17 Apr 2022 18:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650246825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmgtMzqaKnL8aPpoTFZVoZARNQjGgBGisAlqoiEq6pY=;
        b=J60Dq9IIG8QlsbYEtE/D+rcItJZ52cabNJGIRlS77krcXWyEphu4kWZhiXJw6yfxq+SXwh
        f35uN+/3soZXjbgvm211F9FG+dd/Ey/IwNzhvJz0Wo6LNdOb9L0j+v5amYeRBEHyZd3CB9
        zmI002O+MMA2i3Q82mnxOzV8MNtqU+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-JLpaGNtRMqOds3ODpEuqrg-1; Sun, 17 Apr 2022 21:53:41 -0400
X-MC-Unique: JLpaGNtRMqOds3ODpEuqrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37AA78001EA;
        Mon, 18 Apr 2022 01:53:40 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBE2E2029F8F;
        Mon, 18 Apr 2022 01:53:35 +0000 (UTC)
Date:   Mon, 18 Apr 2022 09:53:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <YlzChw5kPOlPmK9Z@MiWiFi-R3L-srv>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014344.228523-3-coxu@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 04/14/22 at 09:43am, Coiby Xu wrote:
> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
> signature verify") adds platform keyring support on x86 kexec but not
> arm64.
> 
> The code in bzImage64_verify_sig makes use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
> verify signed kernel image as PE file. Make it generic so both x86_64
> and arm64 can use it.
> 
> Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")

Will the code in bzImage64_verify_sig generic not being genric cause any
issue? Asking this because I don't get why making code generic need add
'Fixes' tag.

> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Reviewed-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
>  include/linux/kexec.h             |  7 +++++++
>  kernel/kexec_file.c               | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..f299b48f9c9f 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -17,7 +17,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/efi.h>
> -#include <linux/verification.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
> @@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> -static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
> -{
> -	int ret;
> -
> -	ret = verify_pefile_signature(kernel, kernel_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_KEXEC_PE_SIGNATURE);
> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> -		ret = verify_pefile_signature(kernel, kernel_len,
> -					      VERIFY_USE_PLATFORM_KEYRING,
> -					      VERIFYING_KEXEC_PE_SIGNATURE);
> -	}
> -	return ret;
> -}
> -#endif
> -
>  const struct kexec_file_ops kexec_bzImage64_ops = {
>  	.probe = bzImage64_probe,
>  	.load = bzImage64_load,
>  	.cleanup = bzImage64_cleanup,
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> -	.verify_sig = bzImage64_verify_sig,
> +	.verify_sig = kexec_kernel_verify_pe_sig,
>  #endif
>  };
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 413235c6c797..da83abfc628b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -19,6 +19,7 @@
>  #include <asm/io.h>
>  
>  #include <uapi/linux/kexec.h>
> +#include <linux/verification.h>
>  
>  /* Location of a reserved region to hold the crash kernel.
>   */
> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 const Elf_Shdr *relsec,
>  				 const Elf_Shdr *symtab);
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#ifdef CONFIG_KEXEC_SIG
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);
> +#endif
> +#endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3720435807eb..754885b96aab 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_KEXEC_SIG
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	int ret;
> +
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
> +}
> +#endif
> +
>  static int kexec_image_verify_sig(struct kimage *image, void *buf,
>  		unsigned long buf_len)
>  {
> -- 
> 2.34.1
> 

