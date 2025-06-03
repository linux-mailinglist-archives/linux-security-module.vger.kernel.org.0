Return-Path: <linux-security-module+bounces-10320-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABAFACCE74
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Jun 2025 22:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226F41767BF
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Jun 2025 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC2224B01;
	Tue,  3 Jun 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KB2rPxdM"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288121C16D
	for <linux-security-module@vger.kernel.org>; Tue,  3 Jun 2025 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983802; cv=none; b=rEEgNGHYJ67kLheZ/9VwzCx+2jcE9cisN+hL5Gt3VhbibnY97aQiakfUk1VRexHIfcJiWcHL9TlKsSATKa3HKRct2Wvs6/6sYOZcC7NVU5TRHk9qGx8OKBGmZHVUY6w+MkuZiYqQhJze7htdMemkENyxK01MY7oUZxfHcluAe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983802; c=relaxed/simple;
	bh=j9OUWrhChf7ZQCsdoqnA29xM4WW996oqQ1Kht5NiaRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/2M1Z+y7yu4m3U+alTDZsE3BzrDZejzeRDaKyuHLMefiZ1WB7s7Dr+rB1VJyutGLDb2BcjgikreXUv8cJuUJb6a7F16A2xciek5sflUrazceaEw5eaV5PBdxbd9dVgcEmNq5qYHLMJGuTimvQe242LFJsjGnWDH5jhTTf66gS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KB2rPxdM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c60e0e4-0bb8-4ae4-b7c3-f29af926f6a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748983795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYDczDkAWGO7hhWYMWNKnea7MYkw9912XrfEX61Dh/U=;
	b=KB2rPxdMXmrNDx+/PRWF+SZ0Dq9rGGghN/OMmDeHZb7kzLHmtNXE/N1xPsQ7BN82Nq5CVI
	oRoiTZXpBOyHUrBLMPr7ZBLs2dUdMknaz/LQDr5fWYnqy4ysEd02nzyawtblVs5UchB8aG
	fEPIKdVGWtijMCNEcSu6t2AyXcuPa9M=
Date: Tue, 3 Jun 2025 13:49:47 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net,
 gnoack@google.com, m@maowtm.org
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-4-song@kernel.org>
 <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/3/25 11:40 AM, Andrii Nakryiko wrote:
> On Mon, Jun 2, 2025 at 11:59 PM Song Liu <song@kernel.org> wrote:
>> Introduce a path iterator, which reliably walk a struct path toward
>> the root. This path iterator is based on path_walk_parent. A fixed
>> zero'ed root is passed to path_walk_parent(). Therefore, unless the
>> user terminates it earlier, the iterator will terminate at the real
>> root.
>>
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>>   kernel/bpf/Makefile    |  1 +
>>   kernel/bpf/helpers.c   |  3 +++
>>   kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>>   kernel/bpf/verifier.c  |  5 ++++
>>   4 files changed, 67 insertions(+)
>>   create mode 100644 kernel/bpf/path_iter.c
>>
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 3a335c50e6e3..454a650d934e 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
>>   ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
>>   obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
>>   endif
>> +obj-$(CONFIG_BPF_SYSCALL) += path_iter.o
>>
>>   CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>>   CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b71e428ad936..b190c78e40f6 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
>>   BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   #endif
>>   BTF_ID_FLAGS(func, __bpf_trap)
>> +BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
>> new file mode 100644
>> index 000000000000..0d972ec84beb
>> --- /dev/null
>> +++ b/kernel/bpf/path_iter.c
>> @@ -0,0 +1,58 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_mem_alloc.h>
>> +#include <linux/namei.h>
>> +#include <linux/path.h>
>> +
>> +/* open-coded iterator */
>> +struct bpf_iter_path {
>> +       __u64 __opaque[3];
>> +} __aligned(8);
>> +
>> +struct bpf_iter_path_kern {
>> +       struct path path;
>> +       __u64 flags;
>> +} __aligned(8);
>> +
>> +__bpf_kfunc_start_defs();
>> +
>> +__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
>> +                                 struct path *start,
>> +                                 __u64 flags)
>> +{
>> +       struct bpf_iter_path_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
>> +       BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
>> +
>> +       if (flags) {
>> +               memset(&kit->path, 0, sizeof(struct path));
>> +               return -EINVAL;
>> +       }
>> +
>> +       kit->path = *start;
>> +       path_get(&kit->path);
>> +       kit->flags = flags;
>> +
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
>> +{
>> +       struct bpf_iter_path_kern *kit = (void *)it;
>> +       struct path root = {};
>> +
>> +       if (!path_walk_parent(&kit->path, &root))
>> +               return NULL;
>> +       return &kit->path;
>> +}
>> +
>> +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
>> +{
>> +       struct bpf_iter_path_kern *kit = (void *)it;
>> +
>> +       path_put(&kit->path);
> note, destroy() will be called even if construction of iterator fails
> or we exhausted iterator. So you need to make sure that you have
> bpf_iter_path state where you can detect that there is no path present
> and skip path_put().

In rare cases, it is possible &kit->path address could be destroyed
and reused, right? Maybe we need more state in kit to detect the change?

>
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a7d6e0c5928b..45b45cdfb223 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7036,6 +7036,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>>          struct sock *sk;
>>   };
>>
>> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
>> +       struct dentry *dentry;
>> +};
>> +
>>   static bool type_is_rcu(struct bpf_verifier_env *env,
>>                          struct bpf_reg_state *reg,
>>                          const char *field_name, u32 btf_id)
>> @@ -7076,6 +7080,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>>                                      const char *field_name, u32 btf_id)
>>   {
>>          BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>> +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
>>
>>          return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>>                                            "__safe_trusted_or_null");
>> --
>> 2.47.1
>>


