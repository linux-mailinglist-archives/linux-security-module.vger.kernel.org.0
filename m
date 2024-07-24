Return-Path: <linux-security-module+bounces-4487-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D303693B8D1
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jul 2024 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E121F21FCD
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jul 2024 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BA13A252;
	Wed, 24 Jul 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E6olU3Bz"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526B18040
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721858129; cv=none; b=VzHMUKgls1w6Gja25AeZ6g8XGgqYgVhI/mLMZ0FmpOMf/WNF15ifntpass3/jm5saEmkcDssyVoGskdsnuz0ob7QO/EJfIFnsPkTyrPaZPrB2i9Sr8mjho48ZIr2k9tk/dlJgUQeFj9Jad5H00TGxHvu8OwdtEJsjR9jiss9jd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721858129; c=relaxed/simple;
	bh=+mMd8KWa1udV1Q0WOLgzdraq2NYFnE9apCBA8B0M7J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RurK9RWCu+bZbdLujJx24dBVdzW6zuxe6OoG/rYim+csu5Bc+Z1rsh95kUHpOJ8M3f9Jq7KWBkGkeQTuR97QhTlQ3cHN5JCizmQzLI3kS3INi/ySQdgX546/HiY1CjvTIpu65PxdjxpK71b+abOB2SI5xZuhX8dm5Pl5o1BhT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E6olU3Bz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65fdfd7b3deso3126307b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2024 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721858125; x=1722462925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX2S+wkSh9PXj1mrFurJA9PykaHp11nkFTGDDdb5ssA=;
        b=E6olU3BzexqV/EbGRySbKn/ll3xfNW8Bz4Nyrxod+GrBNwyNiV9Gdi2hFl5YS7zrXf
         O21SL1u7PFhkYGexslfYNNtHWBg+1fyE1hsgdSvzySBJtDOy0iC1DQE3xhNFRhjWbQFI
         hYllL6ZL6fX/bzkHQH2ITtIg9A5EP/23MKDjZOe5PiyC+WBPc+9qJYDPY1b7ZXaDuwOj
         9V4dC0eb9xzCKpDZ1EtafvvIhzvZ+QN77D0rSyeOjCCfzVwZ7J0M6pQudzYhPrqwf7bz
         lGK3KZoSwKoPAYE5BwlgBrcXHPEDTWkcHeSMTnzpO0jVdu2gtpCZj2s1QT0vbLq+DqzK
         nreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721858125; x=1722462925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX2S+wkSh9PXj1mrFurJA9PykaHp11nkFTGDDdb5ssA=;
        b=UCoYMrObdREGMPyNQZy78/sIiLZbpvWbDE1NUDSbT69GrnnLVlW3oO4rYCngM0hAGW
         r50o8yjJvEVFA6waiOylCQpzxglG4PJQW09EBm4nanBgevFPmZ50sWRUh/WDFIt/RsEY
         aA6JABfAD3U8l5eRDTMqjKNPDk3frQU0/CVy/gmOFxFZ5ix5s8GmSWHcf003V6PwNTGh
         yRdzZo7j8gRmSx/bsOsupxAuN8Uztv6vF2Ki/jPC9hcg7lTfbVuT2XVAwHpn48aqRP9e
         afwOu3vYkN79a8/dGSg2iQ7Ci9dQtZLfitl8yof5KHCpOnMuMcLIsq9I+upy8LcJw1WS
         0wFg==
X-Forwarded-Encrypted: i=1; AJvYcCVxGGHpzHCiRoXJD0IwzLJVu+pNXvADSnv4zfdXofJ86bFcc+Z4DkQYi4+bB08zk/OexIckamXG4j+HeOpSqgeAti/gTYBlUGjy1rwqyiJeK4fCp0a2
X-Gm-Message-State: AOJu0Yx4k8VehKhggUKnnaOFlUCwYJVwh0Lqm3B2iJbm171n08pFgfX7
	RGZO1SASC+rejJ5W9IxbDDraSf/AeWmTVA8845Udfct/ypYVuBUj4QfZpNFjCoKW3EuaQLzuu7y
	6uzh4Gc0lIpI5H/IUn1U0dABdkjPH0W/zs0ON
X-Google-Smtp-Source: AGHT+IEvK2qDe3JpupN8A/TtWU8g9/xrVml3rY6g5rMwfVak/BD44/4JmQdOkWDHisL63uxy63dZ/n2jLT0o+6TyI2Y=
X-Received: by 2002:a81:c24f:0:b0:665:657d:9847 with SMTP id
 00721157ae682-675113b33a1mr8994327b3.13.1721858125677; Wed, 24 Jul 2024
 14:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724020659.120353-1-xukuohai@huaweicloud.com> <26bb0c7b-e241-4239-8933-349115f3afdb@schaufler-ca.com>
In-Reply-To: <26bb0c7b-e241-4239-8933-349115f3afdb@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jul 2024 17:55:14 -0400
Message-ID: <CAHC9VhTfqhWe9g5Tfzqn2e2S8U3JrCJ2zjjgKKJF0La+ehwAaQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Refactor return value of two lsm hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, James Morris <jmorris@namei.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 4:36=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/23/2024 7:06 PM, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > The BPF LSM program may cause a kernel panic if it returns an
> > unexpected value, such as a positive value on the hook
> > file_alloc_security.
> >
> > To fix it, series [1] refactored the LSM hook return values and
> > added BPF return value checks.
> >
> > [1] used two methods to refactor hook return values:
> >
> > - converting positive return value to negative error code
> >
> > - adding additional output parameter to store odd return values
> >
> > Based on discussion in [1], only two hooks refactored with the
> > second method may be acceptable. Since the second method requires
> > extra work on BPF side to ensure that the output parameter is
> > set properly, the extra work does not seem worthwhile for just
> > two hooks. So this series includes only the two patches refactored
> > with the first method.
> >
> > Changes to [1]:
> > - Drop unnecessary patches
> > - Rebase
> > - Remove redundant comments in the inode_copy_up_xattr patch
> >
> > [1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@huawe=
icloud.com
> >     https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@huawe=
icloud.com
> >
> > Xu Kuohai (2):
> >   lsm: Refactor return value of LSM hook vm_enough_memory
> >   lsm: Refactor return value of LSM hook inode_copy_up_xattr
>
> For the series:
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Looks good to me too.  I'm going to merge this into lsm/dev-staging
for testing with the expectation that I'll move them over to lsm/dev
once the merge window closes.

Thanks!

--=20
paul-moore.com

