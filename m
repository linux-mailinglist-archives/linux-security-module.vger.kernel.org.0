Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D42D112
	for <lists+linux-security-module@lfdr.de>; Tue, 28 May 2019 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfE1Vja (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 28 May 2019 17:39:30 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:45452 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbfE1Vja (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 17:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559079567; bh=nEAUupGo0y4ykOTcXwaUz0zFaWdvtTH+Is1+7mb7/qw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=OrEQABWkbyZ8Dg9j14sUA8ofWLD2/YL6BXbjoDJovgv33KdxtVJvHWSnI4rBsbDf5fu6TtFcomexGXVhqX/sVkOdkX1US8NQlNYv2WwJNtavmg/inBFWsXnq4hLhlyZqtf0pp0oObtkYA9ATLuxvt6kISSM5XwoebHQ4BG6t6bQrlapPhoL/0a4GWSFWqSJiqX6a8SgVK3ulbJoAklUJ0g/xs94p8DLalWd9kyVouSgCAVpnHUriSzLbRhzK2B0tATVngG303ESKzIu9A5BySZbKW8PA5ZxjV4iLuJHgo/0/50qT45/qitqGqTqjTH8fEtEwCLVul5yZ9K2zae6XSQ==
X-YMail-OSG: vesToCIVM1kjwi1wDesYwqARFi_EeFDqUpm_UYUcXiCXDlCpk75dYV6Rxp1YePz
 KmoVC99.0dNF39lkazwUC_y9Q_FTEHgA.CwRtxnGz53FpeJ5frV3cWtdwFLUw9qv8JpytoMu61MU
 gc4Wb_vDSk8bDhmyMy71TeDsXr0fob5HBR2JBQVEGj0.OSTzVC3eaU6SUQFXSJfZBDrWxELlZNcH
 Sm08yreaY6fIDMpCMWYxdYHkkt6nZJP2WIxox3_I7hgIylDkYOswDIpHF7yKjeO0uyAMcfvNTz4p
 Bcmwheyq_n1cT7yNa9OEX6ZMqcSMgk18Mi3qcFdj8GjTM.owb7yH.bQXj0w2er2O7IR8WOJI7BU3
 wyJHQ8GZyJ4YIdQbVJqts3J4Ev2Kw8Hnfq5YqVl3f1R2APZ.BojuBpbA_XAjLR_NR9eI1WLeOSzY
 vXUJn2hE9B0OaB53geZ88Bc2PvP56s59GzCZD2SnCnmqO_VpX1O5ocout6OPW07n3zzRUM5BftR0
 wgjU.uE0PH3vvERk_Xv649Efa3Ff.6_O0P6OGGas0.Lo0xpfVgfxI40NqP0_ynqdBM5cxQK1d_lg
 t1nWAE.6Ywe_gxyhIIqUuKxx91L..VmCqPsW91AOg1bXSGtq9KiZn7qSLK0MfLieDXQQbNFoEVw2
 1.b4ebSjmGE0ChCPp5UVMtXVQD.FkIbzpmTpybmaX8Fhi7jMZTY.NUQEZN8dD6sqr6ICkJLw8pz9
 i1u8UxPbXNV7_dPrXvPer2PUjoiWuSN7hLy6hHX8ojJF4km5_SldeVUl6ah4EpNwwbVJPV6yhuzY
 jH3moLZc78_ApeZ8KVlEGXkhxolo2IsydV_kHu3eXSLVumGCDCPGWoTIs0jIu5Eo1FU6ea8cZYJg
 GMT7p7jzoMGJzqogokIBrnhqWwMoxZRse7xHt.iEtGHeWcbdKjBm4.DD56yulOgTTlLdU23yZdmE
 LQVo5WC4IPFRkmbxWSEXK8VU9NknMD0D3haXuZYSiFfve2Zb.kc4fotjAvZVQplim2yiDRyQllgx
 KTOBz9BP1dpoLLZTsiUaGvJMOuKvG49klGUDg8XWu9Zh03WLoj2gWxETF7vWuMWAIaUR2F3lxFpp
 Mx9EcijC2WSk225.ZdHfkiW57X2HWg.BAuwXwfZJ2pxWDbPaeJiUIpRghyOl6VfoNaHiADsVEZ8J
 .cjKIrs1tlNZnZX_k_qYQyLGvOdmZKOHyUzL1Vn6VyngoJiseTr4VbgTNx4o7fq5abGTZUUraxQr
 5nkxyx4.d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 21:39:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 77cbfc5a564a9b19ac504bcbacbb44ae;
          Tue, 28 May 2019 21:39:24 +0000 (UTC)
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option and add
 missing prefixes
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <155907646050.25083.16573974978890009010.stgit@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <207acb88-782d-37c1-c23a-7ca0c1daf7d5@schaufler-ca.com>
Date:   Tue, 28 May 2019 14:39:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <155907646050.25083.16573974978890009010.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/28/2019 1:47 PM, David Howells wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
>
> The 5.1 mount system rework changed the smackfsdef mount option
> to smackfsdefault. This fixes the regression by making smackfsdef
> treated the same way as smackfsdefault.
>
> Also fix the smack_param_specs[] to have "smack" prefixes on all the names.
> This isn't visible to a user unless they either:
>
>  (a) Try to mount a filesystem that's converted to the internal mount API
>      and that implements the ->parse_monolithic() context operation - and
>      only then if they call security_fs_context_parse_param() rather than
>      security_sb_eat_lsm_opts().
>
>      There are no examples of this upstream yet, but nfs will probably want
>      to do this for nfs2 or nfs3.
>
>  (b) Use fsconfig() to configure the filesystem - in which case
>      security_fs_context_parse_param() will be called.
>
> This issue is that smack_sb_eat_lsm_opts() checks for the "smack" prefix on
> the options, but smack_fs_context_parse_param() does not.
>
> Fixes: c3300aaf95fb ("smack: get rid of match_token()")
> Fixes: 2febd254adc4 ("smack: Implement filesystem context security hooks")
> Cc: stable@vger.kernel.org
> Reported-by: Jose Bollo <jose.bollo@iot.bzh>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Tested-by: Casey Schaufler <casey@schaufler-ca.com>

Looks good. Can you send this in for 5.1 and 5.2?

> ---
>
>  security/smack/smack_lsm.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0de725f88bed..d99450b4f511 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -68,6 +68,7 @@ static struct {
>  	int len;
>  	int opt;
>  } smk_mount_opts[] = {
> +	{"smackfsdef", sizeof("smackfsdef") - 1, Opt_fsdefault},
>  	A(fsdefault), A(fsfloor), A(fshat), A(fsroot), A(fstransmute)
>  };
>  #undef A
> @@ -682,11 +683,12 @@ static int smack_fs_context_dup(struct fs_context *fc,
>  }
>  
>  static const struct fs_parameter_spec smack_param_specs[] = {
> -	fsparam_string("fsdefault",	Opt_fsdefault),
> -	fsparam_string("fsfloor",	Opt_fsfloor),
> -	fsparam_string("fshat",		Opt_fshat),
> -	fsparam_string("fsroot",	Opt_fsroot),
> -	fsparam_string("fstransmute",	Opt_fstransmute),
> +	fsparam_string("smackfsdef",		Opt_fsdefault),
> +	fsparam_string("smackfsdefault",	Opt_fsdefault),
> +	fsparam_string("smackfsfloor",		Opt_fsfloor),
> +	fsparam_string("smackfshat",		Opt_fshat),
> +	fsparam_string("smackfsroot",		Opt_fsroot),
> +	fsparam_string("smackfstransmute",	Opt_fstransmute),
>  	{}
>  };
>  
>
