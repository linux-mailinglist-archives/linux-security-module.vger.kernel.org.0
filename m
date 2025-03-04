Return-Path: <linux-security-module+bounces-8478-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34525A4E70D
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Mar 2025 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B3619C6D45
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Mar 2025 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C025A2CE;
	Tue,  4 Mar 2025 16:28:24 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E558298CBC
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105704; cv=fail; b=SVNbZHjYmXc5EuqeVUJ1yriGMZvG+DNmWU5K8FkwbnEm8B3k1h8veUAwadQiJYw9IOeQxF4iVMHWXJDE3ToX2j0ACR2s3WAAmorQs7eSSQOctYGRAjvxR08RuCqUz7Hoz/h6as94Ois74TBWY/jRSwi6NmdPpdcVfQnKRK2vvys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105704; c=relaxed/simple;
	bh=L5HS60kYabEVenqegeg+oOYjkpnSrucFj+LmV4XaBK4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HfT/dGCDmjI97nLWNP/PI66RNbjPQb+3lHHOXRnqREHaAFgMrUmUNGpGKXjuqdgZ7HNqfygJq7k8cvgnZQ4S0KZUPNuHb9S1GulvfyKK35yeghN1ul+5DPcSg9YtIRtbg3In9uC1euH5DNDCxN8lME98/h7lR/0KzAb38BpcSdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=45.249.212.188; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 6C48040F1CEA
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 19:28:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h0G3sstzG3M5
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 19:26:54 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 4FBE94272C; Tue,  4 Mar 2025 19:26:41 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541851-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D2A2A41D36
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:50:09 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 673B23063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:50:09 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83583AB4B7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967A2135A4;
	Mon,  3 Mar 2025 13:49:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32F21128F;
	Mon,  3 Mar 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009765; cv=none; b=UtZyWDmRiLGL3PeKR8u6pBAt/lHrQ8TuPZ9l1rBkG1mN8ffiTz9OEDcR+UKvPosU7xD/6kz6+TmbRv8EAKcAbYaTCwZwqtjg50KBEPmclR80GieRK7fyYNw/xEgSiB20kMwgBuBldGo7rR4vHnjwJBxVXHWsdp3oq8CAr8hy6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009765; c=relaxed/simple;
	bh=/FdZFuI0IOKHUanIrzm+Ue5+S3RrxndULHeqzaUYCb0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Rw/7VR58vGk3eMozk4WGT5rIjwmC6fPbr0QCkPv0+2y0uHqMOc9gfFir6KpzQcGrV3T2bk+/2sI9RHLLMWo3DZE9vkd2QGmbETnzOgFxdB95Y1/bCFxcCBGh/C1+7y8tR59DG+s2CaRe7Mx63hMiPbDn8sCnRVigNouZC8tQdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z60St47YKzCs7q;
	Mon,  3 Mar 2025 21:45:50 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 77DF11401F0;
	Mon,  3 Mar 2025 21:49:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Mar 2025 21:49:18 +0800
Subject: Re: [PATCH v2 06/11] ubifs: reorder capability check last
To: <cgzones@googlemail.com>
CC: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<cocci@inria.fr>, Richard Weinberger <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-5-cgoettsche@seltendoof.de>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a9257803-c5cd-bb83-21b6-a8b152c943e6@huawei.com>
Date: Mon, 3 Mar 2025 21:49:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250302160657.127253-5-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h0G3sstzG3M5
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710417.16253@u3opneklZdWyXrcCrKU5qg
X-ITU-MailScanner-SpamCheck: not spam

=E5=9C=A8 2025/3/3 0:06, Christian G=C3=B6ttsche =E5=86=99=E9=81=93:
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>    1. A denial message is generated, even in case the operation was an
>       unprivileged one and thus the syscall succeeded, creating noise.
>    2. To avoid the noise from 1. the policy writer adds a rule to ignor=
e
>       those denial messages, hiding future syscalls, where the task
>       performs an actual privileged operation, leading to hidden limite=
d
>       functionality of that task.
>    3. To avoid the noise from 1. the policy writer adds a rule to permi=
t
>       the task the requested capability, while it does not need it,
>       violating the principle of least privilege.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Richard Weinberger <richard@nod.at>
> ---
> v2: split into two patches for each subsystem
> ---
>   fs/ubifs/budget.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
>=20
> diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> index d76eb7b39f56..6137aeadec3f 100644
> --- a/fs/ubifs/budget.c
> +++ b/fs/ubifs/budget.c
> @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_i=
nfo *c, int min_idx_lebs)
>    */
>   static int can_use_rp(struct ubifs_info *c)
>   {
> -	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) |=
|
> -	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
> +	if (uid_eq(current_fsuid(), c->rp_uid) ||
> +	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
> +	    capable(CAP_SYS_RESOURCE))
>   		return 1;
>   	return 0;
>   }
>=20



