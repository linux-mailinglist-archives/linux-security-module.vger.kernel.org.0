Return-Path: <linux-security-module+bounces-6927-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640779E3762
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Dec 2024 11:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D4116680C
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Dec 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0D1AF0BB;
	Wed,  4 Dec 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WYjwtfdU"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76931AA1DF
	for <linux-security-module@vger.kernel.org>; Wed,  4 Dec 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307706; cv=none; b=pTLeNX1Eji+w6SDYuQBtKB/ws8yRDeeEkl8CImVQt6CWlYsHVhEGEF7g2RNCiuCKoWde0siLRs70ieBfIAHjMAPzXb/05waHevmm9b5jGg3vm956gUpFjHTZZQAgXicT5NPaAmRlgWN84SrR4gChWdLHlnp9jxhYRfr2VCWugLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307706; c=relaxed/simple;
	bh=rKSAyG07/h2eMatj22GyJdWRpjcsvVHB9qLi+04StoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrQ29SktJ5rVozLW9YLqVxHMYkkQxfn/UUd4DOOYqiXuW4rMfqC8My4NroYXDomKeYoceyOc22rqLOWQMLT4h9+m7IrutlztBFrLwjcreiqicnUQffVhmsY9HFNc9p9ovp6zKncUZnFvGEUSZXDi2M7/P5er/qvpyUcQUSGQbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WYjwtfdU; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3D1j6x2kzw15;
	Wed,  4 Dec 2024 11:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733307353;
	bh=7QdWrJp74Ayt3Lkyd8RV7Cyw5fURDnlvpTchBSBsUL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYjwtfdUADrkIBWJpzYpQMVuZxXAHmOIbs9Z6Xy5WTRHD53ofEvHfOluKuHVlR/1t
	 skdniFdXJ0qg2p5nMXvmVPS0pJec8Ost+LvfXPZotIm6w44GNhbLEWekVxPyoSX2aE
	 uxJ1dy7jFaf76PLA4lTRGCA3RLmjsJwXGg3LJslQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3D1j0rV6zL46;
	Wed,  4 Dec 2024 11:15:53 +0100 (CET)
Date: Wed, 4 Dec 2024 11:15:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org, 
	Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <20241204.IeZeTheing4e@digikod.net>
References: <20241203233424.287880-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203233424.287880-1-zohar@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Tue, Dec 03, 2024 at 06:34:24PM -0500, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file exection
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
> 
> Differentiate kernel and userspace enforced integrity audit messages.
> 

I guess there is a missing tag:

Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

With some minor comments, this looks good to me. I'll include this patch
or the next one in my patch series.  Thanks!

> ---
> Changelog v2:
> - Mickael: Use same audit messages with new audit message number
> - Stefan Berger: Return boolean from is_bprm_creds_for_exec() 
> 
>  include/uapi/linux/audit.h            |  1 +
>  security/integrity/ima/ima_appraise.c | 28 +++++++++++++++++++++++++--
>  security/integrity/ima/ima_main.c     | 22 +++++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..826337905466 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -161,6 +161,7 @@
>  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
>  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data integrity */
>  
>  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
>  
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 656c709b974f..144e0b39fbcd 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/file.h>
> +#include <linux/binfmts.h>
>  #include <linux/fs.h>
>  #include <linux/xattr.h>
>  #include <linux/magic.h>
> @@ -469,6 +470,18 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
>  	return rc;
>  }
>  
> +static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
> +{
> +	struct linux_binprm *bprm = NULL;
> +
> +	if (func == BPRM_CHECK) {

struct linux_binprm *bprm;

> +		bprm = container_of(&file, struct linux_binprm, file);
> +		if (bprm->is_check)
> +			return true;

return bprm->is_check;

> +	}
> +	return false;
> +}
> +
>  /*
>   * ima_appraise_measurement - appraise file measurement
>   *
> @@ -483,6 +496,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  			     int xattr_len, const struct modsig *modsig)
>  {
>  	static const char op[] = "appraise_data";
> +	int audit_msgno = AUDIT_INTEGRITY_DATA;
>  	const char *cause = "unknown";
>  	struct dentry *dentry = file_dentry(file);
>  	struct inode *inode = d_backing_inode(dentry);
> @@ -494,6 +508,16 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
>  		return INTEGRITY_UNKNOWN;
>  
> +	/*
> +	 * Unlike any of the other LSM hooks where the kernel enforces file
> +	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
> +	 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
> +	 * of the script interpreter(userspace). Differentiate kernel and
> +	 * userspace enforced integrity audit messages.
> +	 */
> +	if (is_bprm_creds_for_exec(func, file))
> +		audit_msgno = AUDIT_INTEGRITY_DATA_CHECK;
> +
>  	/* If reading the xattr failed and there's no modsig, error out. */
>  	if (rc <= 0 && !try_modsig) {
>  		if (rc && rc != -ENODATA)
> @@ -569,7 +593,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>  		status = INTEGRITY_FAIL;
>  		cause = "unverifiable-signature";
> -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +		integrity_audit_msg(audit_msgno, inode, filename,
>  				    op, cause, rc, 0);
>  	} else if (status != INTEGRITY_PASS) {
>  		/* Fix mode, but don't replace file signatures. */
> @@ -589,7 +613,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  			status = INTEGRITY_PASS;
>  		}
>  
> -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +		integrity_audit_msg(audit_msgno, inode, filename,
>  				    op, cause, rc, 0);
>  	} else {
>  		ima_cache_flags(iint, func);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 06132cf47016..f0830e6d0cda 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -554,6 +554,27 @@ static int ima_bprm_check(struct linux_binprm *bprm)
>  				   MAY_EXEC, CREDS_CHECK);
>  }
>  
> +/**
> + * ima_bprm_creds_for_exec - collect/store/appraise measurement.
> + * @bprm: contains the linux_binprm structure
> + *
> + * Based on the IMA policy and the execvat(2) AT_CHECK flag, measure and

AT_EXECVE_CHECK

> + * appraise the integrity of a file to be executed by script interpreters.
> + * Unlike any of the other LSM hooks where the kernel enforces file integrity,
> + * enforcing file integrity is left up to the discretion of the script
> + * interpreter (userspace).
> + *
> + * On success return 0.  On integrity appraisal error, assuming the file
> + * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
> + */
> +static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
> +{

We could have a comment explaining that ima_bprm_check() will not be
called a second time bi the bprm_check_security hook if bprm->is_check
is true because this hook would then not be called.  This would not be a
security issue anyway, just a useless call.

> +	if (!bprm->is_check)
> +		return 0;
> +
> +	return ima_bprm_check(bprm);
> +}
> +
>  /**
>   * ima_file_check - based on policy, collect/store measurement.
>   * @file: pointer to the file to be measured
> @@ -1177,6 +1198,7 @@ static int __init init_ima(void)
>  
>  static struct security_hook_list ima_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
>  	LSM_HOOK_INIT(file_post_open, ima_file_check),
>  	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
>  	LSM_HOOK_INIT(file_release, ima_file_free),
> -- 
> 2.47.0
> 
> 

