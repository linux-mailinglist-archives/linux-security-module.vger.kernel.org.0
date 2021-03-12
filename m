Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82E93396C0
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Mar 2021 19:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhCLSjt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 12 Mar 2021 13:39:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50206 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhCLSje (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Mar 2021 13:39:34 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1lKmhB-00088y-Rp
        for linux-security-module@vger.kernel.org; Fri, 12 Mar 2021 18:39:33 +0000
Received: by mail-wr1-f72.google.com with SMTP id n17so11561687wrq.5
        for <linux-security-module@vger.kernel.org>; Fri, 12 Mar 2021 10:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LrjNNl1HaKs81EwyUtlVbxVaHe5LD/KaCHpzeDYGj+o=;
        b=HgvLoa+QB7/tQjc9orqcaTFFGJVlcYKjvQwkPUyyHLjerTq/b1KtyZwRrKMQ5wa5p3
         cnyniLA0/2RyvKc8smncmgMFZULpDFwwuZnYtCBMWWivOpfZZCgehoJwxZOTYFdetshW
         fSwynsXGNTFfqvZJVJhwcqk0D68jxyH31SwKfk2TG/HDlBX6knFqdXtNfXh+Rz6pxfYi
         P6B5BG8Rh3LdjN6SKa6Rvvf/Xxit72V5bwwebaEUMjiKvbJkZMqf8GSehweGdPJNW7ZJ
         81nOGPYDMEpDuHjM7QEmQAYa9fHJ+pZ85uCPv2TQwiUkG0+EZTEbo3es4a/odajbtSrh
         2uKA==
X-Gm-Message-State: AOAM5303bgfMPCUTLFh6Qz0Qg+9zlPf2QMBobwToQMI+KXns+cjsCyDL
        n2KitPeDpuvx6U9JVU59ciAeb8xLOdzW2U2zLOG7xvxXV5ebHEt3LFXw2V9NaeCgd54t0yAPLMt
        G+OmfdmivtcRNTdryTem5dZbJCyEBQ824tD3D04xtqld1N2j3D1AEjA==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr14496830wme.21.1615574372795;
        Fri, 12 Mar 2021 10:39:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh1ffwB1Uew4hafYvV0CTsLEim5/cOL5h+Fe/qbWWW0iWFNrKSI/8eqeeu4xEez9yaC1IRwQ==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr14496817wme.21.1615574372517;
        Fri, 12 Mar 2021 10:39:32 -0800 (PST)
Received: from ?IPv6:2a01:4b00:85fd:d700:32b0:795:72f:7832? ([2a01:4b00:85fd:d700:32b0:795:72f:7832])
        by smtp.gmail.com with ESMTPSA id s23sm2959737wmc.35.2021.03.12.10.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:39:32 -0800 (PST)
To:     David Howells <dhowells@redhat.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <161428671215.677100.6372209948022011988.stgit@warthog.procyon.org.uk>
 <161428674320.677100.12637282414018170743.stgit@warthog.procyon.org.uk>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Subject: Re: [PATCH 4/4] integrity: Load mokx variables into the blacklist
 keyring
Message-ID: <4b275a33-28ac-78c2-e075-ea2eda4f13a8@canonical.com>
Date:   Fri, 12 Mar 2021 18:39:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161428674320.677100.12637282414018170743.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 25/02/2021 20:59, David Howells wrote:
> From: Eric Snowberg <eric.snowberg@oracle.com>
> 
> During boot the Secure Boot Forbidden Signature Database, dbx,
> is loaded into the blacklist keyring.  Systems booted with shim
> have an equivalent Forbidden Signature Database called mokx.
> Currently mokx is only used by shim and grub, the contents are
> ignored by the kernel.
> 
> Add the ability to load mokx into the blacklist keyring during boot.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/r/20210122181054.32635-5-eric.snowberg@oracle.com/ # v5
> Link: https://lore.kernel.org/r/c33c8e3839a41e9654f41cc92c7231104931b1d7.camel@HansenPartnership.com/
> ---
> 
>  security/integrity/platform_certs/load_uefi.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index ee4b4c666854..f290f78c3f30 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -132,8 +132,9 @@ static int __init load_moklist_certs(void)
>  static int __init load_uefi_certs(void)
>  {
>  	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
> -	void *db = NULL, *dbx = NULL;
> -	unsigned long dbsize = 0, dbxsize = 0;
> +	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
> +	void *db = NULL, *dbx = NULL, *mokx = NULL;
> +	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
>  	efi_status_t status;
>  	int rc = 0;
>  
> @@ -175,6 +176,21 @@ static int __init load_uefi_certs(void)
>  		kfree(dbx);
>  	}
>  
> +	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
> +	if (!mokx) {
> +		if (status == EFI_NOT_FOUND)
> +			pr_debug("mokx variable wasn't found\n");
> +		else
> +			pr_info("Couldn't get mokx list\n");
> +	} else {
> +		rc = parse_efi_signature_list("UEFI:MokListXRT",
> +					      mokx, mokxsize,
> +					      get_handler_for_dbx);
> +		if (rc)
> +			pr_err("Couldn't parse mokx signatures %d\n", rc);
> +		kfree(mokx);
> +	}
> +


My preference would be if the above hunk was moved into the
load_moklist_certs() function which is called just below. Such that
loading of MokListRT & MOkListXRT are done next to each other.

And also implement loading the same way it is done for MokListRT -
specifically via the EFI MOKvar config table & then via a variable.

See 726bd8965a5f112d9601f7ce68effa1e46e02bf2 otherwise large MokListXRT
will fail to parse.

>  	/* Load the MokListRT certs */
>  	rc = load_moklist_certs();
>  
> 
> 
> 

