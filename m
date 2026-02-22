Return-Path: <linux-security-module+bounces-14798-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPYVNyNum2lNzgMAu9opvQ
	(envelope-from <linux-security-module+bounces-14798-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 21:59:15 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B21705EF
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 21:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A45F300F5FC
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 20:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88301C84B8;
	Sun, 22 Feb 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="wEn05ERF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849161BC46;
	Sun, 22 Feb 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793949; cv=none; b=aU+TLd9JTlu3RjfFq3j6KLSikv+IuRE8HB0JzrqHrcQHprl4/9HF3Vrj7IGrCWfFqHgBbqWGmalkN3721FGZ+lTq+DBsqGnmm85befMBnCov+J+lkwMzJnfDfCGmaK29r64n5kaGlG9Ex+d5kgPxjiCwdidCG38aaEKgVAPzGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793949; c=relaxed/simple;
	bh=rBR6mKA2YTWqFBrvr1bBxZQaQCdGcFHlkMKutJewIj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3fjHFE+A1m7P1Hc+xvmPWTWQa7A4VaxkM35XF533KlQqD+Xq+h+8zRAKO8Fot8A3n84wPjrwxn9SDlWB0XyboomKYORgwskoRBccg5PcB3/lwHcDfTO+NqshtMCBKNwmEcVRU+mbqwdEhqvEzhQiGVgLK3FPnEaI6MaH0570e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=wEn05ERF; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1771793587; bh=rBR6mKA2YTWqFBrvr1bBxZQaQCdGcFHlkMKutJewIj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEn05ERFEe2N1GPBVte78a078GlaXXGHzLndIa1hlcGD61ukrW4MzYXlByXtFdtaa
	 H9H2WOs3Nw/pH22lzVOy1nqJVOq+reqUwwT/JQwZsb0XuVkOY8SKl5DgOZv1mge8zI
	 BdAvwLVNjB286Mn0LG1+/t+EIptaDblmfjgVllf8GBMxD1/ELm68/xGpvv7weA3H/J
	 4eU+ovqVBZoPVDXvEXT4n+5p064JtW+i8PLsDj6r1tTnQAvrrG1PRqc4pcTgwvykKN
	 vZTiteOJc1p8bazaONCrFXbwMTZLa23XFiXIGtiVm0fV3THD87oXAcKC76LDj7BXFR
	 k6wTckYGi6bYA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B78FB5A4; Sun, 22 Feb 2026 14:53:07 -0600 (CST)
Date: Sun, 22 Feb 2026 14:53:07 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] apparmor: Replace memcpy + NUL termination with
 kmemdup_nul in do_setattr
Message-ID: <aZtss2/FsdJSrk0y@mail.hallyn.com>
References: <20260222204645.285727-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222204645.285727-1-thorsten.blum@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hallyn.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[hallyn.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14798-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[hallyn.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serge@hallyn.com,linux-security-module@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hallyn.com:email,hallyn.com:dkim]
X-Rspamd-Queue-Id: BC6B21705EF
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 09:46:44PM +0100, Thorsten Blum wrote:
> Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
> a manual NUL termination.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks correct, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/apparmor/lsm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..49aa6ad68838 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -858,12 +858,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
>  
>  	/* AppArmor requires that the buffer must be null terminated atm */
>  	if (args[size - 1] != '\0') {
> -		/* null terminate */
> -		largs = args = kmalloc(size + 1, GFP_KERNEL);
> +		largs = args = kmemdup_nul(value, size, GFP_KERNEL);
>  		if (!args)
>  			return -ENOMEM;
> -		memcpy(args, value, size);
> -		args[size] = '\0';
>  	}
>  
>  	error = -EINVAL;
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

