Return-Path: <linux-security-module+bounces-1371-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AF84D8B6
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Feb 2024 04:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57813287219
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Feb 2024 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73312376FD;
	Thu,  8 Feb 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="St8QShq1"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D43364C0
	for <linux-security-module@vger.kernel.org>; Thu,  8 Feb 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362333; cv=none; b=fGpo5uXUj9gsq4nrq+l54TPXOLCYNz3DhdfAm9CEYDdjsjcaWZdW6ZZK0NAK+Wwapajwdku6BAGi+7vARz0Hc5A4WfeHWUVe9ksSJYSJK5Qyk3wCe0Ih64dTO369wUf3YVaPhIuy5paKkA6K8/W0+CI2WSg1SunC83Y09U9zZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362333; c=relaxed/simple;
	bh=Cff+Wiecc2cHcyyI8nwMBx5je+HqeBudB8XmvaexVqo=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=oj389V0SoNtZ4fcFfraiy/pcvvpcMJYkT+jhCvlbF+1HuBBSoWEkImvQHwCJrka1xtwMEFjmwF/5+D9ZyIDkVvFC1SZ7Dx0JaFw8E5smF5HIFRYU/3NsZ98EulF0gR+6ENZj6f7UiY2EXxcfdsqd/09gPlQc5k3l5wNLEv48Uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=St8QShq1; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c022adaa88so536339e0c.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 19:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362328; x=1707967128; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SzomLHNvmfRLTVJXPSTY/24nqK1tA5o0ol6Vicf7etQ=;
        b=St8QShq1YhmoHL0MKGrlWOqJZuci9nKvHaC03ZQS86JaVixPZVHTXUsXyTfScuJBEf
         dKLNt71NyhxMb1Xuk8VMR0l5z1xFeGgv0laL9A6kz3MPRBeiVC7ukEuME4ByQLp8dGRl
         X+sApsJ3HecIV5NN8C5DZetnUE8EAl1GowHvh6A4VS+VJysf+fOyoWq77Zo97khdeXDS
         Hs3Cpn3jt365txjlEvFttlSMbjRab7RWvfoCbsWjqMMol3/mNq0WY/JSyUzaVhgEhETC
         zFIU5v0xtywFxQQeieq+gGkytctgK3DRPGmDaU6upEJkMmiVeK+IwFQQLpYhecUx712e
         LybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362328; x=1707967128;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzomLHNvmfRLTVJXPSTY/24nqK1tA5o0ol6Vicf7etQ=;
        b=GglS3OB07Iecsdbbro9PQNmHpXlCXiuQsaOyw3rtRumZEZZOu3WBpd0PwTkDVTcEZd
         pikWJNQJbJXGjiSKJ+elrOI7qsnytL86r8gdcJRe8ilotuyq6vNHu3YkkeM2w8Q4mVS4
         tnGV6N6sXipcjk9zv8ID9Ln0fVAJ3XCvbaDyg3ppW+ndNUkYWtwGHlNIRo2roEbwbYwT
         VGkKyoNZ19ibdZi5oImW3rGZyZggxRlbSSVV70CLhAUVgrQ0NqvB5ijejX+LA1mmRlKR
         vJo+yqAYgqqmGWXYokj21ScT4uiRBEaGrou4boObGe5+izjbncQCV3VKyswwE6FQRO1X
         fZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYXaWn2Dg/zKyCG27Xe7tLuXm4nSzr/kutK4uXFT7qwIYzJ9LJlrH6ZzV482nKVZmJmOVCQIXNOtane3Fk1+jg/nmaiXK+s/mlyJqeTp30Kj5H0QDh
X-Gm-Message-State: AOJu0YyYd5Bmb8mzjT+FwFU/RZGLoHxPXPpNcCfyHyyxoxa+9WGM5dqI
	jpC/zAOKjatxzjIEiegBjJDtlMhDvYkBskBTM6fpYUa4WssHkNxEH2wefzX/XQ==
X-Google-Smtp-Source: AGHT+IFns334tyR2QEfnnaR13d1rH6S3XWDd74F5W5/THo7GHyQNpVeViJSOtzOlmX9KOUjuxHmvfw==
X-Received: by 2002:a05:6122:4b0a:b0:4b6:d63c:ca8f with SMTP id fc10-20020a0561224b0a00b004b6d63cca8fmr4083957vkb.16.1707362328329;
        Wed, 07 Feb 2024 19:18:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpyqK0RogBYaBMcS4e9J8dBLmERGQfZODiiwNRZAcDf7dZipTH660AKkFCMPBp+dLZ5ZUF1L8NJZkuE+Dh1qNkVHO6jzYqZ1P8sQxbNXgXia3UonV2GKKmWbmtyeztpcVOIIXth64kQ9zSVJddnsyrBKm989pDxaxTNROY1pJ00PbyD1GhGOzVQxzuU4wovNdyFBo5DxPXd+7DhgKx5wFrfXEZsUd9z9EMnBPkzSEKGoFqLc7FA4xjbH14JlXQ5J9ytQyXQU4IqEhs/qA9/chnZGYkl32hyXVGrUEVgbWLCKo0WlpXijEgFzYr98Ury5wq7vFPFTqzV7DzUhs1uZ1/5hM/iJkCDZEConDJ9CnmTBngp3tY/Jb1UnwDHWBSpPMKg9QEw2/XSOlDeXdUseAoplcnomoaJ5Jk4tekkpQMVJTpz5iiTX30ycYSiYTwXBqia9ZgCfhPBQU7OYeQAPizww2/ZlMC/spwrFkLKNaB49Gh0XpCy1EiWYps2c/SRxml7h0qWoIjuJot1J+/csUXzlJyp3wHDaDSCEc6nWrdi2dKQyvBz4dr23+1WyjoMBtH/WPiSwUsONkjN961iGqdWOhm2AFiAAc0dTlbB2yBTxmAaODQBlT3JCaZDam0OWZgkY5K5iDjJhg1nbfioqJUTDRb2FF1dtl4gNqoQoaIvezpZran8J3uqj4PYfSVKtMWYtaHhslZIR2lVEtpdTDmR2p/K2knaVLCvymrS5IAZFTSRUuCsy1nq7qoy17JMtBMtFnuZBogeEmfY5UOo1lLLIwYBUgmGMNJhGu4xBKP7fu4YQrgl2QW846Bvg6fRVWNuJEAsqCY7VH9SV5FgzCQzN5n+Cy0vLaU+VNhi1IaHT8tUD81sqczpbr5DCz509puMuFIh/bFiWwjYI2RhQv3782cp191T2M2zVeINpOS0dMhvUlXIidRBOboLtFQlRYQE2
 k5UmWW6loGyms=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bp38-20020a05620a45a600b00783fb14c67bsm1071312qkb.48.2024.02.07.19.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:47 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:47 -0500
Message-ID: <923041f758925191b6cfc90fe5f95e9a@paul-moore.com>
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
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 16/25] security: Introduce inode_post_set_acl hook
References: <20240115181809.885385-17-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-17-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.
> 
> At inode_set_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_set_acl, EVM re-calculates the file's HMAC based on the modified
> POSIX ACL and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 27 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

