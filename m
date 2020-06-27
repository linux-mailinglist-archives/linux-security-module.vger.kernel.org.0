Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978BD20C35C
	for <lists+linux-security-module@lfdr.de>; Sat, 27 Jun 2020 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgF0Rnp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 27 Jun 2020 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0Rnp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 27 Jun 2020 13:43:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE4C061794;
        Sat, 27 Jun 2020 10:43:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26ff00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:ff00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECAE11EC0212;
        Sat, 27 Jun 2020 19:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593279822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1A1dVBrbGPPkY/HQ3nWi6nbRp+BjUmn3DkY6Tj41HdA=;
        b=gG/5jUPIpYuAaOggN0AoYuUN0RH5V6m3GQcIaP4pjuzJTN4kF++dHDk+Hzi2ECFcMxU8hY
        lXu72EPKKpZmQAQDe0ePb3lwibrlerxn5jeX9ln15n2p3BMP8ABeLO8Z4sXA8GFqKchGma
        6EEtwJzoTXOPFLH957DiON3ns6TTklE=
Date:   Sat, 27 Jun 2020 19:43:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v33 11/21] x86/sgx: Linux Enclave Driver
Message-ID: <20200627174335.GC15585@zn.tnic>
References: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
 <20200617220844.57423-12-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617220844.57423-12-jarkko.sakkinen@linux.intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 18, 2020 at 01:08:33AM +0300, Jarkko Sakkinen wrote:
> +static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
> +			 void *token)
> +{
> +	u64 mrsigner[4];
> +	int ret;
> +	int i;
> +	int j;
> +
> +	/* Check that the required attributes have been authorized. */
> +	if (encl->secs_attributes & ~encl->allowed_attributes)
> +		return -EACCES;
> +
> +	ret = sgx_get_key_hash(sigstruct->modulus, mrsigner);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&encl->lock);
> +
> +	if (atomic_read(&encl->flags) & SGX_ENCL_INITIALIZED) {
> +		ret = -EFAULT;
> +		goto err_out;
> +	}

That test should be the first thing this function or its caller does.

> +	for (i = 0; i < SGX_EINIT_SLEEP_COUNT; i++) {
> +		for (j = 0; j < SGX_EINIT_SPIN_COUNT; j++) {

Ew, what's that double-loop for?

It tries to init an enclave a bunch of times. Why does it need to init
more than once?

> +			ret = sgx_einit(sigstruct, token, encl->secs.epc_page,
> +					mrsigner);
> +			if (ret == SGX_UNMASKED_EVENT)
> +				continue;
> +			else
> +				break;
> +		}
> +
> +		if (ret != SGX_UNMASKED_EVENT)
> +			break;
> +
> +		msleep_interruptible(SGX_EINIT_SLEEP_TIME);
> +
> +		if (signal_pending(current)) {
> +			ret = -ERESTARTSYS;
> +			goto err_out;
> +		}
> +	}
> +
> +	if (ret & ENCLS_FAULT_FLAG) {
> +		if (encls_failed(ret))
> +			ENCLS_WARN(ret, "EINIT");
> +
> +		sgx_encl_destroy(encl);
> +		ret = -EFAULT;
> +	} else if (ret) {
> +		pr_debug("EINIT returned %d\n", ret);
> +		ret = -EPERM;
> +	} else {
> +		atomic_or(SGX_ENCL_INITIALIZED, &encl->flags);
> +	}
> +
> +err_out:
> +	mutex_unlock(&encl->lock);
> +	return ret;
> +}
> +
> +/**
> + * sgx_ioc_enclave_init - handler for %SGX_IOC_ENCLAVE_INIT
> + *
> + * @filep:	open file to /dev/sgx

@encl:       pointer to an enclave instance (via ioctl() file pointer)

> + * @arg:	userspace pointer to a struct sgx_enclave_init instance
> + *
> + * Flush any outstanding enqueued EADD operations and perform EINIT.  The
> + * Launch Enclave Public Key Hash MSRs are rewritten as necessary to match
> + * the enclave's MRSIGNER, which is caculated from the provided sigstruct.
> + *
> + * Return:
> + *   0 on success,
> + *   SGX error code on EINIT failure,
> + *   -errno otherwise
> + */
> +static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
> +{
> +	struct sgx_sigstruct *sigstruct;
> +	struct sgx_enclave_init einit;
> +	struct page *initp_page;
> +	void *token;
> +	int ret;
> +
> +	if (!(atomic_read(&encl->flags) & SGX_ENCL_CREATED))

Might just as well check the other flags: doing EINIT on an already
initialized enclave - SGX_ENCL_INITIALIZED - is perhaps a nono or
similarly on a SGX_ENCL_DEAD enclave.

And you could do similar sanity checks in the other ioctl functions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
