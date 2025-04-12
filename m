Return-Path: <linux-security-module+bounces-9328-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098CBA86911
	for <lists+linux-security-module@lfdr.de>; Sat, 12 Apr 2025 01:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB47AFCCD
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Apr 2025 23:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77726A09B;
	Fri, 11 Apr 2025 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CGH2A03s"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6452BD58B
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413378; cv=none; b=W6qHQdAVx3FKuUrYfs/dU6jImSv9aToEdI2RoOVQWvf3LtnJVAbyZWFr6UQlGflQo2WYfMEkRZY9tamgYA4OvAm6+j/9ypFy5Wvd8780f8P0wBszUADSNs9CBMRFEj0b1FnCBHQvrpiGAPWMGKMOdLYn+pdb/M3kZFYKpaMKvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413378; c=relaxed/simple;
	bh=y/67TUX3SKsxvpdITZXAWtpG9m+MFwkW0ufwvWD8ZvE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=mDjvqSaaplIF7niGxwGb/uB37GUg2LX93JSXsGTl0WqFbQU3/S/knxZTJ4wbF63PvaVFuC/BkvJ+iaGAsGYsVolQOiNeN8tAYIkHxFqU7H4paAzHwf+AdovT6tNeUwvekeRcpjFPMXlyb2zt/Bi4WS3ggGkZkpFE7pjzyCebPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CGH2A03s; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so26617026d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744413375; x=1745018175; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuGybtALY1nU6Xel+qCGNU6dttZXpp155m7wcuPBHmI=;
        b=CGH2A03s0jbQ0NeVAtNFM33HSQKWcni5JvcOrXTTi1eyn4Yl2Iry5DT53kX7+PNHh9
         4Cg66M9NJLPEUWO4LKzfu74A/imSgIRVEHmFvMUAL8BVKdfpSQ47dVvA5VxKDqp65CpF
         ns0mmdM3gHZ3W5LddtB1PrvVYE8wtZkh6jR0eDhdxuhgihatPMfomvUF4yYj7xK8XQVB
         yqrhr+GNxyU4HjWTS4/r2nRVz88wkipQjJrhrSYee77FITP7WbqL+tQHZ0fkYJPwqRcr
         zlrm4iHl3bdf+o7JntX9HCaLBrxUx1/7sYMNw64dtjVENasNPybDgrA0N+ivth1mR0fQ
         IuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413375; x=1745018175;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tuGybtALY1nU6Xel+qCGNU6dttZXpp155m7wcuPBHmI=;
        b=Jkb5HGmIIoB0IOVf8bx/V52CCYpauY4PmteuK4u5d4CMXLj9bvZydoT1HifDZmeQtU
         eUvgA8wNxcgQInDu9r1vym+jTmRGtjdUP1v93jCNPs/D/tmNsOG/viBjTBB9tP8djRw8
         44o0SaWw9RwViO6BKXm4njeVJgIeywh/vWiCLlNdbf5i39IWmCa4i+Yho7R+xnwnwFlM
         ISYUeJ5dcWlJqtxTvpOVoV5KYIU35x77V9woAca7g5rZjs40YWiWXsMrJJvVgYts8wNV
         4JfsDy9GBDO7aJTXleMUUn1rJNJBUmM1EvG0QzYw+R/zPjPPOQnzB3CdlLZEw3uC8e9k
         uOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPEzA6IJl4kv8ORfYFC2H74WkQC+jEcZ13nh/nsLpYo6Vii4ky5u5i4OCiXwyruVjSBj/6BUhzsptLHoD1to0vOrkzbpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cuqEObOqdXG2yk/ih+T/Bipik/r4SHdMxl/VSsbXXcRA/COk
	Y/9okV12Fc/WfFVnOdm/3S7IbWVg2RiP23II5UJYVkRTROapKGWsvC9/v4urHQ==
X-Gm-Gg: ASbGncuE+mH8Vo4OAUH2OSGqfpWHD5FNQd8KztKmUxPlnb5/9Ib9CQLEGBNcZC4hF2r
	R8zNcNPlgxSXi1MRVMLY8sTwbLnQUXb5Vuyz6AuSYYqnWj5uYisfJ8JOJ458DDdekIMF5NLxrIB
	EWGBjZR6tVEk8r3YnbaZ2dLVRNc3t95sNqUJ6OlDpxw2CmiwmAVo9eWuwX966AvcoODvDIci1tY
	3lrClmAfElZrQHzWpR94BuSuYAHVpw3fhLP+yHws/Eo8+jTNZPdqr6Viar0QmPf6GktXXTiIrKN
	F5gbWIWA9+o6gXDxlw/yu3j0kc4okNyUSIIVbKa7Q79ktevMEZPoOhnNfDn+RJhxc1tlH4fkM59
	JtGv0+Sih3g==
X-Google-Smtp-Source: AGHT+IGjduBmlSpWU0mlp+40mGyjda74cdL2upZ68BYIBvIaRlX1u4yCfExf6wZG67mqfhzmsnsAMA==
X-Received: by 2002:a05:6214:4015:b0:6e6:6c10:76fb with SMTP id 6a1803df08f44-6f230db4864mr77277436d6.25.1744413375163;
        Fri, 11 Apr 2025 16:16:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea10697sm42931066d6.108.2025.04.11.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:16:14 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:16:14 -0400
Message-ID: <d3ad9a7bb9eb68a3ae5dd18bf091825d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com, 
	teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 1/4] security: Hornet LSM
References: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>

On Apr  4, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This adds the Hornet Linux Security Module which provides signature
> verification of eBPF programs. This allows users to continue to
> maintain an invariant that all code running inside of the kernel has
> been signed.
> 
> The primary target for signature verification is light-skeleton based
> eBPF programs which was introduced here:
> https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/
> 
> eBPF programs, before loading, undergo a complex set of operations
> which transform pseudo-values within the immediate operands of
> instructions into concrete values based on the running
> system. Typically, this is done by libbpf in
> userspace. Light-skeletons were introduced in order to support
> preloading of bpf programs and user-mode-drivers by removing the
> dependency on libbpf and userspace-based operations.
> 
> Userpace modifications, which may change every time a program gets
> loaded or runs on a slightly different kernel, break known signature
> verification algorithms. A method is needed for passing unadulterated
> binary buffers into the kernel in-order to use existing signature
> verification algorithms. Light-skeleton loaders with their support of
> only in-kernel relocations fit that constraint.
> 
> Hornet employs a signature verification scheme similar to that of
> kernel modules. A signature is appended to the end of an
> executable file. During an invocation of the BPF_PROG_LOAD subcommand,
> a signature is extracted from the current task's executable file. That
> signature is used to verify the integrity of the bpf instructions and
> maps which were passed into the kernel. Additionally, Hornet
> implicitly trusts any programs which were loaded from inside kernel
> rather than userspace, which allows BPF_PRELOAD programs along with
> outputs for BPF_SYSCALL programs to run.
> 
> The validation check consists of checking a PKCS#7 formatted signature
> against a data buffer containing the raw instructions of an eBPF
> program, followed by the initial values of any maps used by the
> program. Maps are frozen before signature verification checking to
> stop TOCTOU attacks.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst |  55 ++++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  crypto/asymmetric_keys/pkcs7_verify.c    |  10 +
>  include/linux/kernel_read_file.h         |   1 +
>  include/linux/verification.h             |   1 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  11 ++
>  security/hornet/Makefile                 |   4 +
>  security/hornet/hornet_lsm.c             | 239 +++++++++++++++++++++++
>  12 files changed, 335 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet_lsm.c

...

> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> index 000000000000..d9e36764f968
> --- /dev/null
> +++ b/security/hornet/hornet_lsm.c

...

> +/* kern_sys_bpf is declared as an EXPORT_SYMBOL in kernel/bpf/syscall.c, however no definition is
> + * provided in any bpf header files. If/when this function has a proper definition provided
> + * somewhere this declaration should be removed
> + */
> +int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);

I believe the maximum generally accepted line length is now up to 100
characters, but I remain a big fan of the ol' 80 character terminal
width and would encourage you to stick to that if possible.  However,
you're the one who is signing on for maintenence of Hornet, not me, so
if you love those >80 char lines, you do you :)

I also understand why you are doing the kern_sys_bpf() declaration here,
but once this lands in Linus' tree I would encourage you to try moving
the declaration into a kernel-wide BPF header where it really belongs.

> +static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr *attr,
> +			       struct hornet_maps *maps)
> +{
> +	struct file *file = get_task_exe_file(current);
> +	const unsigned long markerlen = sizeof(EBPF_SIG_STRING) - 1;
> +	void *buf = NULL;
> +	size_t sz = 0, sig_len, prog_len, buf_sz;
> +	int err = 0;
> +	struct module_signature sig;
> +
> +	buf_sz = kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
> +	fput(file);
> +	if (!buf_sz)
> +		return -1;

I'm pretty sure I asked you about this already off-list, but I can't
remember the answer so I'm going to bring this up again :)

This file read makes me a bit nervous about a mismatch between the
program copy operation done in the main BPF code and the copy we do
here in kernel_read_file().  Is there not some way to build up the
buffer with the BPF program from the attr passed into this function
(e.g. attr.insns?)?

If there is some clever reason why all of this isn't an issue, it might
be a good idea to put a small comment above the kernel_read_file()
explaining why it is both safe and good.

> +	prog_len = buf_sz;
> +
> +	if (prog_len > markerlen &&
> +	    memcmp(buf + prog_len - markerlen, EBPF_SIG_STRING, markerlen) == 0)
> +		prog_len -= markerlen;
> +
> +	memcpy(&sig, buf + (prog_len - sizeof(sig)), sizeof(sig));
> +	sig_len = be32_to_cpu(sig.sig_len);
> +	prog_len -= sig_len + sizeof(sig);
> +
> +	err = mod_check_sig(&sig, prog->len * sizeof(struct bpf_insn), "ebpf");
> +	if (err)
> +		return err;
> +	return hornet_verify_lskel(prog, maps, buf + prog_len, sig_len);
> +}

--
paul-moore.com

