Return-Path: <linux-security-module+bounces-12444-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C5BE163A
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Oct 2025 05:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715C04EBBCA
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Oct 2025 03:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902F20A5C4;
	Thu, 16 Oct 2025 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9e7XpR9"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87F79EA
	for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586621; cv=none; b=Y1FZLkrvKRYk+CLxu70PieyVTOvc2gscQRJY9BHCn5fSoV6gCCBow56LZ0Eco8TjQjmRwp5Pgszr8+sHS8B26npOisdLQG8sgh15OVBMqL8MfyyC6nk7UfHBEVBQLc8+WFYdtLop+uRfud0ztOxhhkGYvAVtqwWqKzjiH0fWqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586621; c=relaxed/simple;
	bh=IxmHoaGhL0xNI3WXnFEL2hTY96YyAEssrwkJ2eZDazQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IJR5bZRMqG5sA9TD+hmCjFkI9AYJPVwFYyDzFCYD6Ro7GnLfw0SnX9rrR75ZJ+gtaOn86kEclQs3SvtfJB3hmdnQzQS8+WXBwUwBdDC04ICkakK7DlIkhW50BegJrC8arBxjbNh0QFWkiU69BGxeMoh2t+Uo240jjfgA61dD5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9e7XpR9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760586617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cAm9vGIddtchQXr3hlgf4GWUVB1Eu3MqRMvwPeSn5k=;
	b=G9e7XpR9hGcYRC8eREpfFKnQB+onkf4v68RZRTEOVAc+5KQfd/+2MmdPgpKNzM0sibSbkv
	Hgx+1AAknnQP26VdOi4vUwLoKBMupRTCihtXWPP+IHLVq8WtX1eSIDJvi1EUsyP9gLRIgC
	Hz/zDtv64xM9cVxl4NXs1F8H6V2cca8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-C5y8nohfNPqSyCdbHvny7Q-1; Wed, 15 Oct 2025 23:50:16 -0400
X-MC-Unique: C5y8nohfNPqSyCdbHvny7Q-1
X-Mimecast-MFC-AGG-ID: C5y8nohfNPqSyCdbHvny7Q_1760586615
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befbbaso414460a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 20:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760586615; x=1761191415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cAm9vGIddtchQXr3hlgf4GWUVB1Eu3MqRMvwPeSn5k=;
        b=Ja+piHnsN5GAvLE88uR8cAXihpapEczk3yD/rONpvb/lwjhkfNq/mvdVCgiVMxq80e
         IWGr9cLqhpArNZZxn+0w5jStdmoAA2VQsiDGik/wg4U9CYGIrSstr+OfEiBwNHs3XeiQ
         gYE2JeZPFhI5BzKjZp2FnHgXhVraGCZdhU3ieBbclHYsy641bEUrmC+jWDmVMBQLUUmQ
         XFHOoC1qiaErp2Ye0rMX551BKLVb8MbTjmEd2pX8keiE0GRqAe7+zJWoCKGfFvc8ddxP
         PIuz219d+9gwmEOrrelKhuYu5PTBrv2QYPR4Nd7RtRZWZP7ReYtgp6zMmz2fRwSrSABq
         NoOg==
X-Forwarded-Encrypted: i=1; AJvYcCUrDnl8kPey9G2UKfbbjVWlvtBf2s1/Kj9E4+gcVxk/VPxkxSz+Q0Kvf/WpAWJ0dIWiCvEKpq26Zp+pHzH1igI1rWDPbBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyb2Mkc9bzq/nskqhVD5VePUuC4VRf2WkJHBv2qQV9Z5c6pT6d
	gxa/G8EMIfQAX0iN73T03VAulEEUB7dCtE3TSqkzGn/SQThvQ/XoDXkUUDTu3s+dMANWB6wm2Pe
	TgZ8w2gYI0Z4xaA4RDbqoZV61m1ssiG6vE7IXgIZ5UtP1eU6tjG/aDOhYsnh10ZQpa/ypJt3fav
	yMZg==
X-Gm-Gg: ASbGncsJANwlPSjSSXzxCMrwN2aU9gW/8D/7LSrsqB1I2XEzqStcLAdgz8uCIqdOiHg
	ttANSorKm/a2q4fZ6Hyu9Dr2a5QuPtQk2G1Tk0FlQTUjAahaCXPSuoSb2pWIZF38qrv1ll4RLMv
	ZZIYMU6o+ikNFFTtI9qChoX/mfT0IWyDNZBrbncPghNe8XtaE4m4yaJt/k/Or9WETIYN8uS8xgc
	Kg5/Zm2pR3QHYj2Dk+ZWKLQgO9QlqfNLZoXW5nEuS2QL0f5CBbA1hQGIIi2I9Ts72cFGU9+3Fn6
	KRiygw9j8iYm6EoXowgpqux3oABEGAZUgqx3RG36urB8UFO99wa4R95F1jnqmsEblg==
X-Received: by 2002:a17:90b:1a8a:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-33b510ff6a6mr44197259a91.8.1760586614893;
        Wed, 15 Oct 2025 20:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLIHTOeRj4rQrdogrwKp08L69Jq0bkoicobjktGlWCYKjygr0kGOABSqkcnYlCdD4w/AS+Vg==
X-Received: by 2002:a17:90b:1a8a:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-33b510ff6a6mr44197206a91.8.1760586614225;
        Wed, 15 Oct 2025 20:50:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba9222d26sm496344a91.0.2025.10.15.20.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:50:13 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:46:10 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7xRadFfuPLCXjuVeI46eZmoOsZOXQiIZVRtns4UbW3g_1760586615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 30, 2025 at 04:28:14PM -0400, Mimi Zohar wrote:
>On Tue, 2025-09-30 at 09:57 -0400, Mimi Zohar wrote:
>> On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
>> > Currently, for any IMA policy that requires appraisal for kernel modules
>> > e.g. ima_policy=secure_boot, PowerPC architecture specific policy,
>> > booting will fail because IMA will reject a kernel module which will
>> > be decompressed in the kernel space and then have its signature
>> > verified.
>> >
>> > This happens because when in-kernel module decompression
>> > (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
>> > syscall instead of init_module to load a module. And IMA mandates IMA
>> > xattr verification for finit_module unless appraise_type=imasig|modsig
>> > is specified in the rule.  However currently initramfs doesn't support
>> > xattr. And IMA rule "func=MODULE_CHECK appraise_type=imasig|modsig"
>> > doesn't work either because IMA will treat to-be-decompressed kernel
>> > module as not having module signature as it can't decompress kernel
>> > module to check if signature exists.
>> >
>> > So fall back to default kernel module signature verification when we have
>> > no way to verify IMA xattr.
>> >
>> > Reported-by: Karel Srot <ksrot@redhat.com>
>> > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > ---
>> > Another approach will be to make IMA decompress the kernel module to
>> > check the signature. This requires refactoring kernel module code to
>> > make the in-kernel module decompressing feature modular and seemingly
>> > more efforts are needed. A second disadvantage is it feels
>> > counter-intuitive to verify the same kernel module signature twice. And
>> > we still need to make ima_policy=secure_boot allow verifying appended
>> > module signature.
>> >
>> > Anyways, I'm open to suggestions and can try the latter approach if
>> > there are some benefits I'm not aware of or a better approach.
>>
>> Coiby, there are multiple issues being discussed here.  Before deciding on an
>> appropriate solution, let's frame the issues(s) properly.

Hi Mimi,

Thanks for listing and framing the issues! Sorry, it took me a while to
go through your feedback as I also had a 8-day holiday.

>>
>> 1. The finit_module syscall eventually calls init_module_from_file() to read the
>> module into memory and then decompress it.  The problem is that the kernel
>> module signature verification occurs during the kernel_read_file(), before the
>> kernel module is decompressed.  Thus, the appended kernel module signature
>> cannot be verified.

Since IMA only accesses a kernel module as a fd or struct file*, even if
IMA hook is triggerd after kernel module is decompressed, IMA still
doesn't know the default verification has passed or can't access the
decompressed kernel buffer [2] to do the verification by itself.

[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/main.c?h=v6.17#n3689

>>
>> 2. CPIO doesn't have xattr support. There were multiple attempts at including
>> xattrs in CPIO, but none were upstreamed [1].  If file signatures stored in
>> security.ima were available in the initramfs, then finit_module() could verify
>> them, as opposed to the appended kernel module signature.

Thanks you for pointing me to the work [1]. I'll take a more careful
look at [1]. I think CPIO supporting xattr can be a long-term solution
and also close a important security gap.

>>
>> 3. The issues described above are generic, not limited to Power.  When
>> CONFIG_MODULE_SIG is configured, the arch specific IMA policy rules do not
>> include an "appraise func=MODULE_CHECK".

Yes, the issue is not limited to Power. And thanks for correcting me
that Power arch specific IMA policy rules don't have this problem! Sorry
I misread the code.

>>
>> 4. Unlike the arch specific IMA policy rules, the built-in secure boot IMA
>> policy, specified on the boot command line as "ima_policy=secure_boot", always
>> enforces the IMA signature stored in security.ima.
>>
>> Partial solutions without kernel changes:
>> - Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
>> - Disable kernel module compression.
>>
>> Complete solution:
>> - Pick up and upstream Roberto Sassu's last version of initramfs support [1].
>> - Somehow prevent kernel_read_file() from failing when the kernel_read_file_id
>> enumeration is READING_MODULE and the kernel module is compressed.  The change
>> might be limited to ima_post_read_file().
>
>or perhaps not totally.
>
>init_module_from_file() doesn't pass the flags variable to kernel_read_file().
>You might want to consider defining a new kernel_read_file_id enumeration named
>READING_COMPRESSED_MODULE.

Thanks for suggesting the solutions! I like the solution of CPIO
supporting xattr but it seems it won't land in upstream soon. So I
prefer the last approach. I've implemented one [3] by defining a new
kernel_read_file_id enumeration, would you like me to post the patches
to the mailing list directly?

[3] https://github.com/coiby/linux/tree/in_kernel_decompression_ima

>
>Mimi
>
>>
>> [1] [PATCH v4 0/3] initramfs: add support for xattrs in the initial ram disk
>> https://lore.kernel.org/linux-fsdevel/20190523121803.21638-1-roberto.sassu@huawei.com/
>>
>>
>
>

-- 
Best regards,
Coiby


