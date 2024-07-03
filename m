Return-Path: <linux-security-module+bounces-4022-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11477924C9E
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jul 2024 02:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311E11C21EF7
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jul 2024 00:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9940623;
	Wed,  3 Jul 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E3s0DRgn"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9E39B
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jul 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965259; cv=none; b=eqAa633Uhd6oy7Bl8Wh8SN/nGawrAGoLaBO40t9dzMVMYL0Hj8cOuxOgfMfevFZkcmssc+8D2enU27NDH0JKcXtGlMJnQsH4ki/jAFeCr+hrwpchbMtRpOoh+ybiDWIxfi1mP+r6pKFcsFyYWo8+12Sr1iUKRLgziZpvCLdmloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965259; c=relaxed/simple;
	bh=jTw/nLCE+f5gmI7kGoZXTkhBb5e615ewSZovIbxjh3g=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=qAamYX8BKOUCp+BwrmoS2inA1AoKcHpTWlTMngylo6SzIzxsf+32rLXsO9S1VWm7+77BUok2KkwYtpuDM8yXQxxLl18IG3q6iQJlSNDyZaUfBVD2ni0dU0YFpqBa7o1AQXMM5BryVmljDPdjUAG49dN3WKZ6OqFziJMH3wg7lQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E3s0DRgn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c10f03a94so7657985a.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jul 2024 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719965257; x=1720570057; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kck7ZrAJLThmJHmUiSxadRhTzlMpPsVokh6Ow333HfM=;
        b=E3s0DRgnBXpVDNM7DzD3Qk/KHrjzrTMTmExNWLODXChN2UGAixXhApK8sizTsjbw/a
         C6yF2SEMu+9Mhxtb9jUff/79KWtCOr+KFlRqBpoM11xpUnyUDbPh1zVqbQbpXvz2yjbl
         hW+N1Fb/Gg6lroRoIGLw7+w9Gsku5NPzM/7VmSryVSLtnhjORHN3JfpxdeEBa5QfaiR9
         zdlnh/nDpkt4tlykm2ktHUVR0q02VTBKqT2p7bLlTduI4EEjzoYnL8K+ZPpLKZIAbf9r
         90iOpKXCxq0MkdheX+cogzags/tVJQkNU0l6Q5sO2ibF9mbMEBpAIBZVAzvZHmbkdKDs
         dX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965257; x=1720570057;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kck7ZrAJLThmJHmUiSxadRhTzlMpPsVokh6Ow333HfM=;
        b=EUQXq66MgtgEfs1FI3rqRsdmGgJH1ZK6L4dqxZfhN9K6orKvmP60qRVOnOZRWtwKJb
         WO7huljMfKZPiVAIGQau2U0zPlP5mDsHLT3KWwaEH6y8hxRVzuBWwY6VnrY/BMTTOEEN
         JH3x/YIBHQ0brO0IupRBhBq+2qLkg2/fivl/yhMBny9wJXVNAASbTGb5YzlyW9hZF6xl
         xT4OvLU5qSj0k45TOse1yNbSAY0gDPm0c+gvgMcAsVk4d1YL9Rl2KZ4UFrEG0iszoZxm
         y5TeABiRaR+3jMBIu3k0s1BmZBoHGPqAJEUw+JiEgL6RRCSeFVHnxNN7Xug1+WhdYnB5
         CWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiOsxPEtLoFlzp7KxU+GDcPlEO9+J7FHrAw+c0P0QwH/JrqTXmlN51Sy+MBBcx6JIN/BnlGmqpSOdcsiyEWD6RXz8uETvyZpE5miPaueBuqQM7EZr5
X-Gm-Message-State: AOJu0YyydmzPc8SYQlyT9MUrO66eNKKpb1cBaPYD0nKj9VPzj5D90AxY
	+aENqDVh8rIrXx/b2lV55btJ45UBT3GxvVn1bCmEUbuQxg12VWtObWOhftndCw==
X-Google-Smtp-Source: AGHT+IGucLDfjmkfApkijD2fKk2gXgjWzJT6a0ItBRAVVVzesGyWCLPgWzI9fPykOFuc32PKLa3VYQ==
X-Received: by 2002:a05:620a:564b:b0:79d:9a20:7c03 with SMTP id af79cd13be357-79ee3153c51mr21596685a.10.1719965256823;
        Tue, 02 Jul 2024 17:07:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6932dd5fsm501311785a.135.2024.07.02.17.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 17:07:36 -0700 (PDT)
Date: Tue, 02 Jul 2024 20:07:36 -0400
Message-ID: <5e39b1c8134f25c822c3665cc1884c0b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v13 5/5] bpf: Only enable BPF LSM hooks when an LSM program  is attached
References: <20240629084331.3807368-6-kpsingh@kernel.org>
In-Reply-To: <20240629084331.3807368-6-kpsingh@kernel.org>

On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> BPF LSM hooks have side-effects (even when a default value's returned)
> as some hooks end up behaving differently due to the very presence of
> the hook.
> 
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
> 
> security_file_ioctl:
>    0xff...0e30 <+0>:	endbr64
>    0xff...0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xff...0e39 <+9>:	push   %rbp
>    0xff...0e3a <+10>:	push   %r14
>    0xff...0e3c <+12>:	push   %rbx
>    0xff...0e3d <+13>:	mov    %rdx,%rbx
>    0xff...0e40 <+16>:	mov    %esi,%ebp
>    0xff...0e42 <+18>:	mov    %rdi,%r14
>    0xff...0e45 <+21>:	jmp    0xff...0e57 <security_file_ioctl+39>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for SELinux
> 
>    0xff...0e47 <+23>:	xchg   %ax,%ax
>    			^^^^^^^^^^^^^^
> 
>    Static key disabled for BPF. This gets patched when a BPF LSM
>    program is attached
> 
>    0xff...0e49 <+25>:	xor    %eax,%eax
>    0xff...0e4b <+27>:	xchg   %ax,%ax
>    0xff...0e4d <+29>:	pop    %rbx
>    0xff...0e4e <+30>:	pop    %r14
>    0xff...0e50 <+32>:	pop    %rbp
>    0xff...0e51 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
>    0xff...0e57 <+39>:	endbr64
>    0xff...0e5b <+43>:	mov    %r14,%rdi
>    0xff...0e5e <+46>:	mov    %ebp,%esi
>    0xff...0e60 <+48>:	mov    %rbx,%rdx
>    0xff...0e63 <+51>:	call   0xff...33c0 <selinux_file_ioctl>
>    0xff...0e68 <+56>:	test   %eax,%eax
>    0xff...0e6a <+58>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e6c <+60>:	jmp    0xff...0e47 <security_file_ioctl+23>
>    0xff...0e6e <+62>:	endbr64
>    0xff...0e72 <+66>:	mov    %r14,%rdi
>    0xff...0e75 <+69>:	mov    %ebp,%esi
>    0xff...0e77 <+71>:	mov    %rbx,%rdx
>    0xff...0e7a <+74>:	call   0xff...e3b0 <bpf_lsm_file_ioctl>
>    0xff...0e7f <+79>:	test   %eax,%eax
>    0xff...0e81 <+81>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e83 <+83>:	jmp    0xff...0e49 <security_file_ioctl+25>
>    0xff...0e85 <+85>:	endbr64
>    0xff...0e89 <+89>:	mov    %r14,%rdi
>    0xff...0e8c <+92>:	mov    %ebp,%esi
>    0xff...0e8e <+94>:	mov    %rbx,%rdx
>    0xff...0e91 <+97>:	pop    %rbx
>    0xff...0e92 <+98>:	pop    %r14
>    0xff...0e94 <+100>:	pop    %rbp
>    0xff...0e95 <+101>:	ret
> 
> This patch enables this by providing a LSM_HOOK_INIT_RUNTIME variant
> that allows the LSMs to opt-in to hooks which can be toggled at runtime
> which with security_toogle_hook.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++-
>  kernel/bpf/trampoline.c   | 40 +++++++++++++++++++++++++++++++++++----
>  security/bpf/hooks.c      |  2 +-
>  security/security.c       | 36 ++++++++++++++++++++++++++++++++++-
>  4 files changed, 101 insertions(+), 7 deletions(-)

I didn't look at this one too closely, see my previous comments in
patch 3/5, but I did catch one typo, see below ...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a66ca68485a2..dbe0f40f7f67 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -110,11 +110,14 @@ struct lsm_id {
>   * @scalls: The beginning of the array of static calls assigned to this hook.
>   * @hook: The callback for the hook.
>   * @lsm: The name of the lsm that owns this hook.
> + * @default_state: The state of the LSM hook when initialized. If set to false,
> + * the static key guarding the hook will be set to disabled.
>   */
>  struct security_hook_list {
>  	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const struct lsm_id		*lsmid;
> +	bool				runtime;
>  } __randomize_layout;

The comment header doesn't match the struct fields, "default_state" vs
"runtime".

--
paul-moore.com

