Return-Path: <linux-security-module+bounces-6273-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B39A4F1D
	for <lists+linux-security-module@lfdr.de>; Sat, 19 Oct 2024 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADD32853FD
	for <lists+linux-security-module@lfdr.de>; Sat, 19 Oct 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FF2207A;
	Sat, 19 Oct 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RSxock2j"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01138DD8
	for <linux-security-module@vger.kernel.org>; Sat, 19 Oct 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352063; cv=none; b=Mf/SscguNtFIuIkRCBHgV5bx/XFmjx21MyJJN8wAFtu5emv3wjtvv55zHvgx7BgavnLV4d31Ai9XNfwrLUR7VJOZzL2oJeI8EJWMQxBX0RAEI4loK2ncyXgD6yDV75/WH9niiC6EmcMqShaGoq6rTf3RIPrBn9aalt6HyK67K48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352063; c=relaxed/simple;
	bh=2VEf0sZkKNyJqV8bPANqoeIKJLjrteDBJkPH+wW3P7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU13E4SA8Hi4rPLXSwbo4zh6ZLXfPCc+cY2q1lRprlfF3j2Ojg7dXAQd6fb0Ecu4dv0twNi1pwfN/VTpaStW9sNNu4ydtq2u+UaatuyAq3YAAT1wYvaoASPNQan5V03DeI6a5o6W6Dj8otObrcGrWeuranorw81jP2urTDYS9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RSxock2j; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2e508bd28so23772927b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 19 Oct 2024 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729352059; x=1729956859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt9BnWbKgBvIPn8Egk93F8g/4UamVtbhqjDHYRc0VbU=;
        b=RSxock2j4eFSMhlPud2PzMLhYJac3rWyeEDfgpn6nEyOad4weShuW0oPInoz9hKbG8
         Ww7E5MQV80gkmZirtXUcT3sGyi4ZKtp275tH4BsfKCP0Laepk+0gV2WD25h77PzZ8Ck9
         Qb61d6X1prsbHCW6kW+Kuj5dxj5OA7Dl9h3HosI/w+TnOjM+mzsqsQapyJJZaF6mc4Ka
         fd48+oheIE9sLzbV5e0BiUExUP7Z0PLusAZbv8b6lLFLWYxjO/1IQ04uuoPvgTKjTijU
         Ld9RDoyrTGzzCyxH0fkWmrCIFrz1YWyuBfy66q1laX3QGf9P16At8QHYI36hm66E3Og4
         8+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352059; x=1729956859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt9BnWbKgBvIPn8Egk93F8g/4UamVtbhqjDHYRc0VbU=;
        b=EhqTf90/W/kK+NS2YDTRoxXHYuvUAFEROPQ7XVNi1Dhw/nUygjVS2SoLD/dlNvWOIZ
         1i17X1Fhsfv+FAOUinfLz8YV4L0POt1An1FQoJ1KCjudfF04Uk4ZVsyVq6+7mEogkIir
         4MnNJ/SVJNp2+cTaphmhO4t/VVaj4ctPnxK0xnRSA7LvUqTcH4SE37NV5DYX5dfVEkwC
         z6oYe7A9n5rKKH4akXQdF7CCREq20OPxCyiCQcwk3GsqGoCPCZvM3992oKjMBQXTn9sh
         0RcZBDoZC6gZUsYCAVfCiD55iI+v7fPcknBwyKDOJGYvGBzxHSVCyhukiQQc7mg2qxzi
         69OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW8T40c3++FfA9B/VllU0wgz4oj6vzucBSeClZmA9PZZSJ1lhp/fNwvZbII5SHZP3RJP0UfjzuSY9ooAZYAmMFZRJrVww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ia3RFhBDLIG1P38dQwY9ep6saxfuVwVsvd5wmg37uWoNX7fa
	m6jd964HmTog82LMlk1WPpYhM2thuAHvYaunHJT+hEJA6bLCLSwy53HoRMi4HOmvjVrOVqDrjm9
	xNAt7m0uxjmAC1nDI+7Oqg6Rwedbk0KzbbABv
X-Google-Smtp-Source: AGHT+IGtdGqzYcDLxnIpfjuAVP5vxoGEl/nSImRtgtKWi9QsQ/qNJR8p9BgodGD1xEymrlwrAaFBjtak2CSZfpvFhTo=
X-Received: by 2002:a05:690c:f91:b0:6de:c0e:20ef with SMTP id
 00721157ae682-6e5bfbdbe14mr53079707b3.7.1729352059439; Sat, 19 Oct 2024
 08:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Oct 2024 11:34:08 -0400
Message-ID: <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ebpqwerty472123@gmail.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:15=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect(=
).
>
> However, that commit called security_mmap_file() inside the mmap_lock loc=
k,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
>
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
>
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock, retrieves the VMA
> and the file descriptor associated, and calculates the 'prot' and 'flags'
> variables; the second takes a write lock on mmap_lock, checks that the VM=
A
> flags and the VMA file descriptor are the same as the ones obtained in th=
e
> first critical region (otherwise the system call fails), and calls
> do_mmap().
>
> In between, after releasing the read lock and before taking the write loc=
k,
> call security_mmap_file(), and solve the lock inversion issue.
>
> Cc: stable@vger.kernel.org # v6.12-rcx
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap=
_file_pages()")
> Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.4=
6d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 17 deletions(-)

Thanks for working on this Roberto, Kirill, and everyone else who had
a hand in reviewing and testing.

Reviewed-by: Paul Moore <paul@paul-moore.com>

Andrew, I see you're pulling this into the MM/hotfixes-unstable
branch, do you also plan to send this up to Linus soon/next-week?  If
so, great, if not let me know and I can send it up via the LSM tree.

We need to get clarity around Roberto's sign-off, but I think that is
more of an administrative mistake rather than an intentional omission
:)

--=20
paul-moore.com

