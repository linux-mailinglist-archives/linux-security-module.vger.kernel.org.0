Return-Path: <linux-security-module+bounces-12596-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C074C1DEBC
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Oct 2025 01:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47731888D4C
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Oct 2025 00:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375E1E5B9E;
	Thu, 30 Oct 2025 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5O7uEoN"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A31E47C5
	for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784518; cv=none; b=Kty+/bqNoagv3xAlkAAnGqC1sFjdhqeB6fA7QYof1bMymmmMqWQxiS1pW2Qcn3U9L9RiRxFuFkDaH5AUgLMPcxoPR4+B3neD6vRZPgZFnDARzX6XOb60ksT3HRQtqNzjKDqLF2If+g81Aa1Ou2s5YMBOKB9gGvn7WCl7nZig6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784518; c=relaxed/simple;
	bh=vsyS65OZFIabeA7UuG3ChI+paS0XQnUbVpobMPy6d/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XwSqtAGcXHlylPIbcnEMecoMr/ShzzEgD5xe6wDXSeGIp+NKRuXmfLqNft6OhBKPIUIbJTQOLtt5hljkRQ1Vb2HFd57KDWjaEWBRnOc+cldvKt6+VVOkX3/Paj4HYoRqW54pjgMLF/gSWm/ToMSGqGuK/w+xqaetHyr5YY3QdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5O7uEoN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWIFuBd1HudXa9pt0d3mK80H5ogYBZ4hml22FEJFpvY=;
	b=Q5O7uEoNWI0P2LaonMyTG78p91fJ8//SX+/gkpW6OSrNTiO5GSSMRPhLaPNCYrSkH9qo5N
	pV+sA/RUtOdk5BcZ91AL4U3cbfQJ6Hft9gP7bMwvQAs0cmoJyObYWLhlV5oTOsuTiTGjvS
	cnwfKSUSfRpWCt5A1MA4jzUZSLA5xOg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-rETzDG7wMTGarr_TllEhSg-1; Wed, 29 Oct 2025 20:35:14 -0400
X-MC-Unique: rETzDG7wMTGarr_TllEhSg-1
X-Mimecast-MFC-AGG-ID: rETzDG7wMTGarr_TllEhSg_1761784513
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso427505b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 29 Oct 2025 17:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784513; x=1762389313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWIFuBd1HudXa9pt0d3mK80H5ogYBZ4hml22FEJFpvY=;
        b=MrauLfev4F9f4HPAseM5ICNrsF/9zcSiuJetUPRTBQcIeLylBpJBQ8+868QWp9Qs3i
         XKknTRG1nmhWQAiqNDL5nf3+k1YarL4Z0c/EBMcS39EHvjuAA6+1s0UCOmzxceeeH5Js
         zfoEoKtXjRQlxcTTV7F0nDbE97zs2u2IAxtSBvm+ij2efHXKHpPDogpAPSOl0g6VYqMl
         gALVjHQU9EZAcHpKP31MbmXKjVWBwcFtE2fq7ASkf2uDiOvnmIAy1YeEhkJScGktvm/T
         yC9IWNKVlSrbcgrsIXtSsbTFwr9CwHqUvqf/OAowBxpPC4NixbpqWVK1oEl7zYazLGSk
         x+7w==
X-Forwarded-Encrypted: i=1; AJvYcCWmtmbXOSPtIA1pqKB7T+cDTGoc9x/0QI7XUbKwWIkJ6sHJylmU0SpXEcueTO8xmM+oS3yJwg4LU/edLPpMr+bCGAk5r94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQuKbIB1u726f7VdpVjgyx5c2PyxFt1LcqSMLzje+RZaeHLhk
	EIvYM18pt18i7aTKxu5sFXMqFYNqX81pQkOCg75thp7KP3me8eW1ggVDCvihIlZMnjKTjwgyDUG
	Q3iPQVVAkER/sWpvXd9Oz0bylEu92ks111NpgekovUGXv8Xw+OP5nK1rE4OJqJ0l86wsge45bet
	x04w==
X-Gm-Gg: ASbGncuREUa99UiBJkkfNgPdHx3wSOByLhsfOwQfLuH3WPHg5tN3kz3mI5Yr8JH0frR
	6XUQMdgHz5cjPNiywNvlLqgbMUy/Q2m4Z1Z5O8xg/Qo09EuCR781ZAyNpestjaeqFX81uM8oKfw
	v0W5TCalYOpMiD2f1m87WAs9Au2djSu9kvXwLOvYLETiw5sg91kP4JLgDyBQGJ+37+nEwdJ4n2C
	HpOpEQ1yuxQ7CRRHEmJGS1hhm3ROpdQwtWjz817rhsopBfEt8zmYx0c7reiWrYQiW4uKQkgX8Iu
	Pd1e0uE5But6u+jpq5oTsqd0Vd7kEJkDcQK2siiLEJup3stDLZydQXCFw/fQnJY1pQ==
X-Received: by 2002:a05:6a00:8d5:b0:781:9a6:116a with SMTP id d2e1a72fcca58-7a4e33c5cf5mr5055530b3a.9.1761784512768;
        Wed, 29 Oct 2025 17:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRw4686zkHlaMgFM4AfmtZ7ntMbQDS6nrck8c23aLAuHLwAT/o6ZLmSffHd3VKODv5UdLfFw==
X-Received: by 2002:a05:6a00:8d5:b0:781:9a6:116a with SMTP id d2e1a72fcca58-7a4e33c5cf5mr5055507b3a.9.1761784512247;
        Wed, 29 Oct 2025 17:35:12 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408757csm16470217b3a.59.2025.10.29.17.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:35:11 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:31:36 +0800
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
Message-ID: <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aHeeVm-5oWeTw8xPwNSm4VduM_sQSFgBFH3QB4I85EU_1761784513
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 24, 2025 at 11:16:37AM -0400, Mimi Zohar wrote:
>On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
>> On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
>> > > > > 2. Instead of defining an additional process_measurement() argument to identify
>> > > > > compressed kernel modules, to simplify the code it might be possible to define a
>> > > > > new "func" named COMPRESSED_MODULE_CHECK.
>> > > > >
>> > > > > +       [READING_COMPRESSED_MODULE] = MODULE_CHECK,  -> COMPRESSED_MODULE_CHECK
>> > > >
>> > > > I also thought about this approach. But IMA rule maps kernel module
>> > > > loading to MODULE_CHECK. If we define a new rule and ask users to use
>> > > > this new rule, ima_policy=secure_boot still won't work.
>> > >
>> > > I don't have a problem with extending the "secure-boot" policy to support
>> > > uncompressed kernel modules appended signatures, based on whether
>> > > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to the existing
>> > > MODULE_CHECK rule.
>> >
>> > I assume once the new rule get added, we can't remove it for userspace
>> > backward compatibility, right? And with CPIO xattr supported, it seems
>> > there is no need to keep this rule. So if this concern is valid, do you
>> > think we shall switch to another approach i.e. to make IMA support
>> > verifying decompressed module and then make "secure-boot" to allow
>> > appended module signature?
>>
>> Yes, once the rule is added, it wouldn't be removed.  As for "to make IMA
>> support verifying decompressed module", yes that might be a better solution,
>> than relying on "sig_enforce" being enabled. IMA already supports verifying the
>> appended signatures.  A new IMA specific or LSM hook would need to be defined
>> after module_decompress().
>
>Looking at the code further,�decompressing the kernel module in IMA is
>redundant.  Instead I think the best approach would be to:
>- define DECOMPRESSED_MODULE, in addition to COMPRESSED_MODULE.
>
>id(COMPRESSED_MODULE, compressed-kernel-module) \
>id(DECOMPRESSED_MODULE, decompressed-kernel-module)    \
>
>- instead of passing a boolean indicating whether the module is compressed, pass
>the kernel_read_file_id enumeration to differentiate between the compressed and
>decompressed module.
>
>- define a new IMA hook, probably LSM hook as well, named
>ima_decompressed_module().
>
>- call the new ima_decompressed_module() from init_module_from_file()
>immediately after decompressing the kernel module.  Something along the lines
>of:
>
>err = ima_decompressed_module(f, (char *)info.hdr, info.len,
>                              READING_DECOMPRESSED_MODULE);

Thanks for proposing a better solution! Yeah, decompressing the kernel
module in IMA is unnecessary. Do you think we can further extend your
idea to call one IMA hook only after kernel module decompression is
done? If we call two IMA hooks in finit_module, we'll need coordination
between two IMA hooks i.e. the 1st IMA hook shouldn't fail in order for
the 2nd IMA hook to be executed. The new IMA hook will always have
access to the decompressed kernel module buffer so there is no need to
differentiate between compressed and decompressed module.

Another question is whether we should allow loading a kernel module with
appended signature but misses IMA signature. Both IMA arch specific policy
and init_module syscall only require appended signature verification. On
the other hand, we only allow "appraise_type=imasig|modsig" but not
appraise_type=modsig. How about we allow loading a kernel module with
valid appended signature regardless of its IMA signature? We won't call
set_module_sig_enforced but as long as we know is_module_sig_enforced()
is true, we allow the module in IMA.


>
>For testing purposes to see the decompressed appended signature in the
>measurement list, modify the MODULE_CHECK measure rule to include "template=ima-
>modsig" in ima_efi.c.

I haven't figured out why to include "template=ima-modsig" for testing
purpose considering we can simply check if the kernel module has been
loaded successfully. It it related to the design that "The d-modsig and
modsig fields are only populated if both the measure and appraise rules
trigger"? If so, can you also help me understand there is such a design?

[1] https://ima-doc.readthedocs.io/en/latest/event-log-format.html#ima-modsig


>-- 
>Mimi
>

-- 
Best regards,
Coiby


