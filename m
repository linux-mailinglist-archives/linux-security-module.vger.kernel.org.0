Return-Path: <linux-security-module+bounces-1505-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61D8563E5
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Feb 2024 14:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA841C212E1
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Feb 2024 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839312F39F;
	Thu, 15 Feb 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XRSmcQyy"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF612E1C7
	for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002142; cv=none; b=NB/s1bx9mCSexX+72ZOHwrff1bZCDAwtag44vTc9bo0J3CMVoL1gm6ujYylBf9KUtVKvKQjRGQJqKu5rvkHuWGZTuhcFtlE7pbXb9jFG+ygZFkc6FDwIJWqrpjqG/LIiRynaYmwgIUc2hysIoe/KSiLzb0nW9ZwALDJBklatzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002142; c=relaxed/simple;
	bh=2agPtJl3v9niVpIiQlLbesjxGfDjfBKYPIlmRtWAQQg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YnkBLzmOVpegDRl+uQkzFsz4Sft0ESlz/dX3ptgjRwSxo4k26PkJRwt3WZX6A4/cgnWRG2EPF6qnBTJ/sUTEvcVBdB8oWt08+i23LPXkBYNRz9vI4p2L0addZgXo0uJgDLNF5UqnD/l9xvlJNHQYxWavgptBjKVGcelLl3cICBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XRSmcQyy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-785bdb57dfaso156421385a.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708002139; x=1708606939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2agPtJl3v9niVpIiQlLbesjxGfDjfBKYPIlmRtWAQQg=;
        b=XRSmcQyyL03rLtS3VvikblzeXgnjVle+cPooHiMTpSqCYxGtdPogrYx4e94aLpG9a3
         mlPF6S095uzEPFaMh9eFHLt94D2qehvCLO7K5ePpMlXpdwLIHxcIAw/B/6BVUcvvsbs6
         kDsTaaCyES02fsNI4BdSVAd97sEhNNOzCt9J3QibrU/NAfdPoSri1w3GjLTlhI/tkERt
         btBHYvk61sr3HPK0IxUbuBMDPBQ+xfUxxG8dvHUgjqPHmRdjwVQAVuxBOE3jePArorqF
         80mtq8ST85jd5p20eubUPllgeOC/EAWE/Fhps98X8n+YTCaXL5XQN6Ep4GNHVWWR+0N2
         di4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002139; x=1708606939;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2agPtJl3v9niVpIiQlLbesjxGfDjfBKYPIlmRtWAQQg=;
        b=Bazdj6CwGKi2DFXEQ3W3ie520mHMogzGCOPDykhIitNhYSypuaKqZTGWxoBg/55Qy7
         Re6TUfANB445RuqMgGV5SUy1YJWCjE0SQIO+gK/5hiR01/nUmIuYtp4akNt6Z0r+Ag/R
         a58ClzWegWqG36/Q6hv+SZ2mBO9vZ3bdPLfvrg/cL5F1FE10Oe4y6of/+4vUOVMoLUp8
         9y2uP6UrL1gIb0mXwjpHoBOR1woTjciSelsrEI0YHq8SIdrGVKX47eLRqmNjssuFGC53
         dROAy2GABaIicK7hvSREkhxqkKLCS+T5h6ga/NgPMxPmJFp26+AXB4lhnTA5DrcQJYrw
         JB+w==
X-Forwarded-Encrypted: i=1; AJvYcCWhdy21EdNuLX3czKiKIf/qRIuwhqZiyaar+G5/YBy7KDwOiJhHS2D15/U/chgteuDgZc1D5SOoKIEdzRSUL0xsexTIiw3GeH9BmYWYTg5tOQqfVDJ7
X-Gm-Message-State: AOJu0YxkLfXcijEx7sDuE/7IJJzNUqxsdsI38pVTAsgvP5ykW+dG234l
	QQtaKFgqi/cxhb3hK2d4/Ha4AvCM1EeC48h6kWvLq3r5w+KjCtUoe6p8IhmsTQ==
X-Google-Smtp-Source: AGHT+IGXRXkvIjtM2XptNphgmbdrAs5LHYnEl5lJFcxgwonSt9iT8GNqc5kaY+tfx3dBMBTZqxQN6g==
X-Received: by 2002:a05:620a:1d:b0:787:2529:6073 with SMTP id j29-20020a05620a001d00b0078725296073mr2061569qki.6.1708002139428;
        Thu, 15 Feb 2024 05:02:19 -0800 (PST)
Received: from [192.168.7.16] ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b0078723db4da9sm570760qkn.98.2024.02.15.05.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2024 05:02:19 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
CC: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 15 Feb 2024 08:02:18 -0500
Message-ID: <18dacdbced8.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <202402141644.808307E71@keescook>
References: <20240214160538.1086089-1-jannh@google.com>
 <a4a77e0e-8d5e-4c9d-aff4-9fe0d8b89cf0@schaufler-ca.com>
 <202402141644.808307E71@keescook>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr() syscall
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 14, 2024 7:45:43 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 14, 2024 at 08:53:52AM -0800, Casey Schaufler wrote:
>> On 2/14/2024 8:05 AM, Jann Horn wrote:
>>> security_setselfattr() has an integer overflow bug that leads to
>>> out-of-bounds access when userspace provides bogus input:
>>> `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
>>> redundantly, also against `size`), but there are no checks on
>>> `lctx->ctx_len`.
>>> Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
>>> value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
>>> will then be passed to an LSM module as a buffer length, causing LSM
>>> modules to perform out-of-bounds accesses.
>>>
>>> The following reproducer will demonstrate this under ASAN (if AppArmor is
>>> loaded as an LSM):
>>> ```
>>> #define _GNU_SOURCE
>>> #include <unistd.h>
>>> #include <stdint.h>
>>> #include <stdlib.h>
>>> #include <sys/syscall.h>
>>>
>>> struct lsm_ctx {
>>> uint64_t id;
>>> uint64_t flags;
>>> uint64_t len;
>>> uint64_t ctx_len;
>
> Do we want to take the opportunity to reduce this to u32 for len and u32
> for ctx_len? All FS operations are limited to INT_MAX anyway...

Not at this point, no.

--
paul-moore.com




