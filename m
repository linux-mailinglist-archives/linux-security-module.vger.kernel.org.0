Return-Path: <linux-security-module+bounces-11220-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B85B10E41
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Jul 2025 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EF03B8A0C
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Jul 2025 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154842E03E3;
	Thu, 24 Jul 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gijkp9c9"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FEB1A5B84
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369377; cv=none; b=qsv3O6D9rvKW1dP2nn1HETkQl/07kstx7aNrI04FNtG9MEiZmThPvTWdtGp8Rf+jpQsv+kIN4Zxoi99YFu2q79NTHIWGELBjCDVvhLeIXy9H9QmHt2gesMWIRQt+yjI8hmyDA3DIQCAn1RKAlNd9f5vC+MIMZ5j4cGshKIj7gTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369377; c=relaxed/simple;
	bh=VIns2DmzkCFmcFt2MOofeL94uOFlGJ5ipCSb5ltfUoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOxdCmN/ApFwoL5VWHiX07lpjE8TwDlBsnsZy2aVtecERzVBfPv641XO9y23q2KUEvSKNJmBeIV2jNrQRA0ONYpxPcUcQDt/++VE+nUrdUkAL3Djif54EhOUJIvMS3TaBniXJc79886SssgkNEyYk5YCvSF6H/QQcDd75PiRnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gijkp9c9; arc=none smtp.client-ip=66.163.184.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753369374; bh=NAvZGQh415/zNs9I5E6hZcRbXLABGCki+GVC2uvI1WM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gijkp9c9VKDeyeiwoMY/7FD2nxKk9RWiUC+kDYE6YuLWgLsQrWWfgAUVbluYajmLT+ZqLnn2jaEsrGuxpZZN/bCPmv4s2lQUots8PUbie4kLUo/++STLIVa/1o+ZoqARanBxS5y6rm61JxhN4yVrx74hUUt6aIG67xtDFTBDl3TMtCtCxoo8i8KwvYDwQzdrkKiKuehiA9LWqz5qWe2v5sptq+UYJ6h5WcbkmU7Eqxpxv9tbzGzSVwlT2zX+vh0fNGRqsRc7xcv+jGATDGRwddGTEUcN4Bpwrrjc6nvqbxZF90eejB04XmozugRnsvOswTuM4cWLpimpVHef31RPsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753369374; bh=BK3a4RuhPr+MY++lsoyEYltKjde6aSSzCXcr/GrYy9N=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MOUkVaZVSNS/s2pod/4GjvO0dbq6FS/s5KLo0U5ec+Xm6EfB76Mj2iGvmmt/mJI4c3k3OT4T9Oaiu26BW/fAJ6h6aciqJoRzvdUW648hZgNULRnFtUGHjgJ7Y3e02HoTKzqSSSoD5DlNVk8PLWzf8aR41xkEyBdaQZErmwLRy2G2eHjokLk8RXbx2GKGPXyduHAgHqRVoX9mNKn26fSt44tWKmMlcTBNyevqd8B0Y0ieb6k3axyeGFFL3yJuSXq9xWXi287HNhKTjN3bcAliDEw82Uzp7MnBqzeWXH+sdfLpTqVJnd6JmzGznDKuF6rEmzXvZMLLAQOXTJqy6wH04A==
X-YMail-OSG: 5nBZ4I0VM1lmCOGlvJLSQsArmi8uJriRY3Csw.meMlfXqasMvZyxwpe0ozTBRif
 805T.kKdprrQoAO4To00DwfD5.YM7glqvRVDJB6SvsN.JP9YL.Y2oo6YAAx9CnMK8OJBxtNpM.OM
 5MvTFmzURgTOtGCeU3gv7SHEql6FI5mmyKdZeXoocqy38.INPD0GdeZZmVHle1toH30T80r2FMWj
 Bvf.fQ93fo1bHli9mErwwcXCE2OdFjsho4wYAkq7c1AUdjW.RJf4Gs.LV2WoVFZb7BMf.tfguCJ.
 bqa.FDRYiP9UYErMUN2NbnM6s6PktvG2bi54I0X2hJ8PppfF5RaWfutcaOWYgNC0bHBfSwyP0EC.
 76M.XHuyKMAyjDeTNFLqxQSk.CoblgctRai.BZVj6R5L8FTlVb9hqZLdWWFkXwx1TcgiavYA.62U
 BnqMHAwf4Q.FmUpOEFCtq1jj18CP_Js335v0nkPhWJK6Fg_KhUpCL9Mh0v_0xg5kE05BzKYStH2L
 Q4_d50ooj6xkkco64SZC.Jc6vfGBCfhvLjOu1Ds08fjzdSO_IC6NRvZiUaQV.k5VkblDyi2m6zak
 yCnC1rD0Sho4os6JNg9AH7oSHrfwqB3ulnxmEEY0aezzvVn.ozApJ8FiUkOKhEEPkRb48Z_efdML
 oaZOwrtbmcZRJb0IBYKcjeN.mncmJV5LP7aHz48jYxnxrkQHvEKfscSTqJUqI6C2Qzmz2ce.VB3g
 cDZQi0OVpEs1_jiODOXdLN65Dt..NouTEt2viQih4hX.j1auH.pxjmIKySqbfmy3gT_HbAfs5X17
 0FsQK.ysWnqak2M0YyhEZNI68cKWOaBuh40UkK6ie8WUKQH12bmbatFpXRREq39IKIyxv5jcUfSF
 ThvXzoPEcKG9s42q8.DYMw3GbQB3krwEBWxTkq2Czj_50tIxk5lE.o7vKCkEePYlPJjl7V0Fv1TO
 nw5z0IvY6B0R7FnzLrWltrDAJI09AQFgF46hxEJMePWn2udJw5.leFXnNbWLAmgugSrGvlTJUzBh
 KcLY2s5ALHSGbiAVwjk349xCorEROriuwV.5oHvqpHWGD5WsxLMq8HYS84.LfyMxyDq5HZgxQufi
 pjod07RCbUXlIQY0EvcNegau2XyM6BPGyvJ2qBMfmVtb7RSk8KLAvDkEsBSiDsuhG7LbngPB576_
 P9wrSF1M6QIl5hLiRDjkyg7yRzz8179qOXch2Z5MSdGYP8JywPrZz4l_jLUT2pTmfKYLHMddX7pb
 cDOyyJSJ_5JuAoyo.AeIG3u5mOFKlXwKR.NqyklX6vrQC_wHpAmvklPvyLDqCsQNOSgImQMhxciN
 yvK2igzyF0Sa0h9kwOd36heGtxf1GC3OkYzwzho.olgp.Jhxti_c2k6zVJs652_aTDB0hgnRjluU
 MxoCzLL9O4e_r6eOgrDre01u22xdAVwh_U1q6AysOtjWaQJ9tYp1OZVtmmfKKvYJja3gE0MdpLO0
 O7zP5zjmqzR3zvhCmRP3NNSwvyPyFoAhUJuL2__sQUsqqLc9ZVTSYMjdcRML0MbW1aFf0mTUbdGc
 rZrvA_0Vpjk_t58jXLnH9SKjBzSj3EdPD6J3QaGxS3F1FwyvN5buBDqILrK0Jr.JvREjEJIRx9N1
 B6ek2fZVWMjnbwLxNnzSVojRBCaPym8d3cfzPsh0XIlwN5r0yd09JFp1fIS7CJ8CfilhA.i5PLCQ
 SPHM0kux7p26yCg7bV30wGMK9NGZQA1aEtyMQB8ydicCIlnu3PLEqWv9rrYJbzwX2IJbY6UPupCd
 FRy8CJj5P3riY5InX4SjYlwe7HL3vf3l7FKSjr4I7.fP.JjPGGphcoyaVIkZSAH48O2aYsFNTGz5
 geDBIpDWsof7dKz.awCHj.8c1QLtk1ha2f00auYR7C6eaohMC6nBs40b84DhCvQ7i7MWjO9.2m1s
 GICkaPY0.hcbAbxDsGmkgFnUZeLHCOYe2ofCul2CQOlV_wtY6NU92nA2PRUDNlqkeXubEkATkzts
 Sccs_rvosajEtcbt1dtUWTGB2LmKTqr8ltzZERGvYU3uYPN8LEa2tvWMm2HBofb10eDqT9vdwXU3
 g7GqZv.TPTqury9x3yvwDABF_RddmYw69ml.LwtG1pVWaubAK1uCbf0b2n0Lu.6utPBl7m8jC4wn
 5VQoHTldFz4lzbXHMRgCIlXv8_tzVIIKke847XP3o8abAXAiHyb7uyiNJjOiaDEtHKUZGhGeoWLT
 1fWhyaJ9hGi7ofxHNtsVwCGjfD7bPWroJpbHNXcIX.liZAfJCez8FA_BamnawwsiCmHwC.5U3Qxt
 Yk6QhmejU0AnTOKQfqfJu69G4k6lOMnKULA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 76a4307e-4d36-4d36-ac0d-977e39af7b27
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:02:54 +0000
Received: by hermes--production-gq1-74d64bb7d7-r4nbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b8764b5f41df74a43633dc8901657462;
          Thu, 24 Jul 2025 14:52:45 +0000 (UTC)
Message-ID: <05a123e6-2fdf-4d33-9ecb-e20eb426372c@schaufler-ca.com>
Date: Thu, 24 Jul 2025 07:52:43 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/34] lsm: consolidate lsm_allowed() and
 prepare_lsm() into lsm_prepare()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-39-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-39-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
> into a new function, lsm_prepare().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 103 ++++++++++++++++++--------------------------
>  1 file changed, 43 insertions(+), 60 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 70e7d4207dae..7beb028a507b 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  		   is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
> -/* Is an LSM allowed to be initialized? */
> -static bool __init lsm_allowed(struct lsm_info *lsm)
> -{
> -	/* Skip if the LSM is disabled. */
> -	if (!is_enabled(lsm))
> -		return false;
> -
> -	/* Not allowed if another exclusive LSM already initialized. */
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static void __init lsm_set_blob_size(int *need, int *lbs)
>  {
>  	int offset;
> @@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
>  	*need = offset;
>  }
>  
> -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> +/**
> + * lsm_prepare - Prepare the LSM framework for a new LSM
> + * @lsm: LSM definition
> + */
> +static void __init lsm_prepare(struct lsm_info *lsm)
>  {
> -	if (!needed)
> +	struct lsm_blob_sizes *blobs;
> +
> +	if (!is_enabled(lsm)) {
> +		set_enabled(lsm, false);
> +		return;
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +		init_debug("exclusive disabled: %s\n", lsm->name);
> +		set_enabled(lsm, false);
>  		return;
> -
> -	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> -	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> -	/*
> -	 * The inode blob gets an rcu_head in addition to
> -	 * what the modules might need.
> -	 */
> -	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> -		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> -	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> -	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> -	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> -	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> -	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_set_blob_size(&needed->lbs_xattr_count,
> -			  &blob_sizes.lbs_xattr_count);
> -	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> -}
> -
> -/* Prepare LSM for initialization. */
> -static void __init prepare_lsm(struct lsm_info *lsm)
> -{
> -	int enabled = lsm_allowed(lsm);
> -
> -	/* Record enablement (to handle any following exclusive LSMs). */
> -	set_enabled(lsm, enabled);
> -
> -	/* If enabled, do pre-initialization work. */
> -	if (enabled) {
> -		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -			exclusive = lsm;
> -			init_debug("exclusive chosen:   %s\n", lsm->name);
> -		}
> -
> -		lsm_set_blob_sizes(lsm->blobs);
>  	}
> +
> +	/* Mark the LSM as enabled. */
> +	set_enabled(lsm, true);
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +		init_debug("exclusive chosen:   %s\n", lsm->name);
> +		exclusive = lsm;
> +	}
> +
> +	/* Register the LSM blob sizes. */
> +	blobs = lsm->blobs;
> +	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
> +	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> +	/* inode blob gets an rcu_head in addition to LSM blobs. */
> +	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
> +	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
> +	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
> +	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_set_blob_size(&blobs->lbs_xattr_count,
> +			  &blob_sizes.lbs_xattr_count);
> +	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
>  }
>  
>  /* Initialize a given LSM, if it is enabled. */
> @@ -358,7 +341,7 @@ static void __init ordered_lsm_init(void)
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
>  
>  	for (lsm = ordered_lsms; *lsm; lsm++)
> -		prepare_lsm(*lsm);
> +		lsm_prepare(*lsm);
>  
>  	report_lsm_order();
>  
> @@ -499,7 +482,7 @@ int __init early_security_init(void)
>  	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
>  		if (!lsm->enabled)
>  			lsm->enabled = &lsm_enabled_true;
> -		prepare_lsm(lsm);
> +		lsm_prepare(lsm);
>  		initialize_lsm(lsm);
>  	}
>  

