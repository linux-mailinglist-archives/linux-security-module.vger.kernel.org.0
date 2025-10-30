Return-Path: <linux-security-module+bounces-12604-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3952C204D8
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Oct 2025 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E066B188E746
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Oct 2025 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9D25A645;
	Thu, 30 Oct 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a24Nir7M"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A4258ECB
	for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831809; cv=none; b=i/n7olUDT4b9yE0XOwIfYa9kXCyz17b5mK9EiaZJBX7I+9/jQ1IUA3Bc7YNMzWvD83Ku5UWQWKkbV6bUVxhPs4iDDmE1eziG13xZHWb5NuagqCpr5/6dHbnKxhJ4OhwMiHX4/dMX5RS29Jqzkuv+f9fgK/vfdhqQ8onQLoV3F9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831809; c=relaxed/simple;
	bh=YYIMYtG7xQoPiLtdRYHshU6ndSg2P0YikKxI4gtxbK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nfaY5xcL2zwT9S5OxRvdzNkDv2rZ1Fw4d87rFVBFX7D2XuRoKwmF9GUGQLx0zyQJ95ZnEHY8otCHjwmDGgTM75Cs8ZQNDUwrHStyAifye5nnIGs85DgqdXQguDEsGWVrN8cBJ/zPqZBZXO7NZzz9wefT2q3gzUeEZ5NHEUKHcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a24Nir7M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761831806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vio4H/nEtltKsmVO4UlosRGQd2lB3LzSIgSACpY8IJE=;
	b=a24Nir7MuuGkjVqXAlhjoW+/wdVgmqt0K9YYN60fM3aXvdHYFO+L5mQPisYLAaj9lO6p03
	Xv+RzF2ltvHWLUWKlTLPMu3u/2sSkl3V5nR3pKTYOGdnuFPwCn8CuPwLKZKz/mP1uieMm+
	ctL2laSWt71YeGvmOMO1JNe9DYsRDtA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-UtMMkPZKNlmOgUIT9Lberw-1; Thu, 30 Oct 2025 09:43:25 -0400
X-MC-Unique: UtMMkPZKNlmOgUIT9Lberw-1
X-Mimecast-MFC-AGG-ID: UtMMkPZKNlmOgUIT9Lberw_1761831804
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a153ba0009so2396330b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 06:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761831804; x=1762436604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vio4H/nEtltKsmVO4UlosRGQd2lB3LzSIgSACpY8IJE=;
        b=cCMa9RlSfUyOAKkH/59eCPiNoxnWSp4Fv3YLPIchmZEXqMcniuVEt4OUIEu2lchBD3
         pLWfsTsOjv45UJjPz1PKOgCWqxoy2BaKIpFy+lRu7/5QMkwsP8tgf3xCFGYgP7/0PFQ5
         WtYR/HK7TtItNkZmfrh049qejSzQKVEE2LNVy63sZUcKwgfdq3UESdVY2PCkkvJIpbYv
         UgFQp5VqJwfy8X3AKwLji/5HJ44REx/IeRWgx/y+gSq3G/LEWOeHHIiiNqJCgWDFRTGb
         IhrIrtYR+wmxDtbiDPagLd49b/NfjVnQ67F0k6TZfdJ5tMZsolLfdtRcrWSrDvpkVA7d
         rx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3m14fOjfY54QJDKxUUK2e8ndS/ykdrVLCxkjpdF2qQfz2rCdH0kc2eHSb5QKsADGU/vEc9T+tJXbSdu1nwKfqf2JYeBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjpvvI6v23oH8++3pk6CcKvwD/mBEFY+Cst+tcewACvsiwy6I
	xZ83uH/Xh6mF/mgq7oXU8WugKVLeiayv6X5cHySGmKQwwqmEHTJuawPEZzGOUHLPHqBrS83xbPK
	bI+I+RT9RCWPM7ctv3SoJothG1o5zuDJ5GSrSd4vdBF5PWNkPbHHON7kmgGKHOVcv+ykuYpslLP
	SoSA==
X-Gm-Gg: ASbGncsyRU9G4sJw/Jn3nDSdHST6c4L8UIdZ84zdOipQe3DMft6hEIbPF38cWdJvXTj
	+c/IPtUgc/eZ0U97GCUcz8ed3Rl3HwTzdOALTOvjeMufICevoT2BHv7Zvshdc4aKRDjb+bhhCsQ
	Uo2geXHpcvVG2otOkaJnd3bf/oTggcQ1+ikrjIG689PaxXA6E0Kq/XfDYXVlp6mJUK3XAzh8tfM
	I+L2MnaUzf6MinL+UmKygr2OlK2LmWbbBh0CbS8fEItPRYOYGC4gaST3HjLzx5HfKbpHmqXhc0O
	4fA3wnmGmP3XkZAokYyFMDIAuZFtzujNEIj+DOMDqWx9zObQ36XX3xcTkm1+QgpVWg==
X-Received: by 2002:a05:6a00:14c7:b0:7a2:8111:7807 with SMTP id d2e1a72fcca58-7a4e2cf5221mr8663847b3a.5.1761831803713;
        Thu, 30 Oct 2025 06:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGDJ8WVJlbObUQTQy8ZG2TJzzo4ICqBYNNCZPDL/+m75vxqy4nGz5Zqt6bBkqzxq1uEvQxw==
X-Received: by 2002:a05:6a00:14c7:b0:7a2:8111:7807 with SMTP id d2e1a72fcca58-7a4e2cf5221mr8663792b3a.5.1761831803160;
        Thu, 30 Oct 2025 06:43:23 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm18668136b3a.50.2025.10.30.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:43:22 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:42:49 +0800
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
Message-ID: <pbkvp4o4m3spjgvctapidfnsswakekxl2vyigqip6yyfzp73z4@rgbohq7h4nnt>
References: <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
 <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
 <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jhATydJxz8_leTlJGwfYaiecB_GBh3VR-Tz_ML_i9GI_1761831804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 29, 2025 at 11:01:27PM -0400, Mimi Zohar wrote:
>On Thu, 2025-10-30 at 08:31 +0800, Coiby Xu wrote:
>> On Fri, Oct 24, 2025 at 11:16:37AM -0400, Mimi Zohar wrote:
>> > On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
>> > > On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
>> > > > > > > 2. Instead of defining an additional process_measurement() argument to identify
>> > > > > > > compressed kernel modules, to simplify the code it might be possible to define a
>> > > > > > > new "func" named COMPRESSED_MODULE_CHECK.
>> > > > > > >
>> > > > > > > +       [READING_COMPRESSED_MODULE] = MODULE_CHECK,  -> COMPRESSED_MODULE_CHECK
>> > > > > >
>> > > > > > I also thought about this approach. But IMA rule maps kernel module
>> > > > > > loading to MODULE_CHECK. If we define a new rule and ask users to use
>> > > > > > this new rule, ima_policy=secure_boot still won't work.
>> > > > >
>> > > > > I don't have a problem with extending the "secure-boot" policy to support
>> > > > > uncompressed kernel modules appended signatures, based on whether
>> > > > > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to the existing
>> > > > > MODULE_CHECK rule.
>> > > >
>> > > > I assume once the new rule get added, we can't remove it for userspace
>> > > > backward compatibility, right? And with CPIO xattr supported, it seems
>> > > > there is no need to keep this rule. So if this concern is valid, do you
>> > > > think we shall switch to another approach i.e. to make IMA support
>> > > > verifying decompressed module and then make "secure-boot" to allow
>> > > > appended module signature?
>> > >
>> > > Yes, once the rule is added, it wouldn't be removed.  As for "to make IMA
>> > > support verifying decompressed module", yes that might be a better solution,
>> > > than relying on "sig_enforce" being enabled. IMA already supports verifying the
>> > > appended signatures.  A new IMA specific or LSM hook would need to be defined
>> > > after module_decompress().
>> >
>> > Looking at the code further,�decompressing the kernel module in IMA is
>> > redundant.  Instead I think the best approach would be to:
>> > - define DECOMPRESSED_MODULE, in addition to COMPRESSED_MODULE.
>> >
>> > id(COMPRESSED_MODULE, compressed-kernel-module) \
>> > id(DECOMPRESSED_MODULE, decompressed-kernel-module)    \
>> >
>> > - instead of passing a boolean indicating whether the module is compressed, pass
>> > the kernel_read_file_id enumeration to differentiate between the compressed and
>> > decompressed module.
>> >
>> > - define a new IMA hook, probably LSM hook as well, named
>> > ima_decompressed_module().
>> >
>> > - call the new ima_decompressed_module() from init_module_from_file()
>> > immediately after decompressing the kernel module.  Something along the lines
>> > of:
>> >
>> > err = ima_decompressed_module(f, (char *)info.hdr, info.len,
>> >                              READING_DECOMPRESSED_MODULE);
>>
>> Thanks for proposing a better solution! Yeah, decompressing the kernel
>> module in IMA is unnecessary. Do you think we can further extend your
>> idea to call one IMA hook only after kernel module decompression is
>> done? If we call two IMA hooks in finit_module, we'll need coordination
>> between two IMA hooks i.e. the 1st IMA hook shouldn't fail in order for
>> the 2nd IMA hook to be executed. The new IMA hook will always have
>> access to the decompressed kernel module buffer so there is no need to
>> differentiate between compressed and decompressed module.
>
>Agreed instead of verifying the kernel module signature on the LSM
>kernel_post_read_file() hook, define and move it to a new IMA/LSM hook after it
>is decompressed, would be much simpler than coordinating two LSM hooks.

Thanks for confirming it! I'll send a new version once the testing is
finished.

>
>>
>> Another question is whether we should allow loading a kernel module with
>> appended signature but misses IMA signature. Both IMA arch specific policy
>> and init_module syscall only require appended signature verification. On
>> the other hand, we only allow "appraise_type=imasig|modsig" but not
>> appraise_type=modsig. How about we allow loading a kernel module with
>> valid appended signature regardless of its IMA signature? We won't call
>> set_module_sig_enforced but as long as we know is_module_sig_enforced()
>> is true, we allow the module in IMA.
>
>Based on the policy, IMA enforces signature verification. Only if
>CONFIG_MODULE_SIG is configured, the IMA arch specific policy does not define an
>IMA kernel module appraise rule. However, custom policies could still require
>both types of signatures, not necessarily signed by the same entity.
>
>The option "appraise_type=imasig|modsig" allows either an IMA signature OR an
>appended signature.

Thanks for the clarification! If I understand you correctly, some users
may want to enforce IMA signature verification and we should provide
such flexibility. Then do you think it's a good idea to change the kernel
module rule in ima_policy=secure_boot to 
"appraise func=MODULE_CHECK appraise_type=imasig|modsig" so
ima_policy=secure_boot can also work for in-kernel decompressing
modules?

-- 
Best regards,
Coiby


